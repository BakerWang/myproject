/*
 * Copyright 2002-2006 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.eastinno.otransos.dbo.util;

import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Miscellaneous collection utility methods.
 * Mainly for internal use within the framework.
 *
 * @author Juergen Hoeller
 * @author Rob Harrop
 * @since 1.1.3
 */
public abstract class CollectionUtils {

	/**
	 * Return <code>true</code> if the supplied <code>Collection</code> is null or empty.
	 * Otherwise, return <code>false</code>.
	 * @param collection the <code>Collection</code> to check
	 */
	public static boolean isEmpty(Collection collection) {
		return (collection == null || collection.isEmpty());
	}

	/**
	 * Return <code>true</code> if the supplied <code>Map</code> is null or empty.
	 * Otherwise, return <code>false</code>.
	 * @param map the <code>Map</code> to check
	 */
	public static boolean isEmpty(Map map) {
		return (map == null || map.isEmpty());
	}

	/**
	 * Check whether the given Iterator contains the given element.
	 * @param iterator the Iterator to check
	 * @param element the element to look for
	 * @return <code>true</code> if found, <code>false</code> else
	 */
	public static boolean contains(Iterator iterator, Object element) {
		if (iterator != null) {
			while (iterator.hasNext()) {
				Object candidate = iterator.next();
				if (ObjectUtils.nullSafeEquals(candidate, element)) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Check whether the given Enumeration contains the given element.
	 * @param enumeration the Enumeration to check
	 * @param element the element to look for
	 * @return <code>true</code> if found, <code>false</code> else
	 */
	public static boolean contains(Enumeration enumeration, Object element) {
		if (enumeration != null) {
			while (enumeration.hasMoreElements()) {
				Object candidate = enumeration.nextElement();
				if (ObjectUtils.nullSafeEquals(candidate, element)) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Determine whether the given collection only contains a
	 * single unique object.
	 * @param coll the collection to check
	 * @return <code>true</code> if the collection contains a
	 * single reference or multiple references to the same
	 * instance, <code>false</code> else
	 */
	public static boolean hasUniqueObject(Collection coll) {
		if (coll.isEmpty()) {
			return false;
		}
		boolean hasCandidate = false;
		Object candidate = null;
		for (Iterator it = coll.iterator(); it.hasNext();) {
			Object elem = it.next();
			if (!hasCandidate) {
				hasCandidate = true;
				candidate = elem;
			}
			else if (candidate != elem) {
				return false;
			}
		}
		return true;
	}

	/**
	 * Find a value of the given type in the given collection.
	 * @param coll the collection to search
	 * @param type the type to look for
	 * @return a value of the given type found, or <code>null</code> if none
	 * @throws IllegalArgumentException if more than one value
	 * of the given type found
	 */
	public static Object findValueOfType(Collection coll, Class type) throws IllegalArgumentException {
		Object value = null;
		for (Iterator it = coll.iterator(); it.hasNext();) {
			Object obj = it.next();
			if (type.isInstance(obj)) {
				if (value != null) {
					throw new IllegalArgumentException("More than one value of type [" + type.getName() + "] found");
				}
				value = obj;
			}
		}
		return value;
	}

	/**
	 * Find a value of one of the given types in the given collection:
	 * searching the collection for a value of the first type, then
	 * searching for a value of the second type, etc.
	 * @param coll the collection to search
	 * @param types the types to look for, in prioritized order
	 * @return a of one of the given types found, or <code>null</code> if none
	 * @throws IllegalArgumentException if more than one value
	 * of the given type found
	 */
	public static Object findValueOfType(Collection coll, Class[] types) throws IllegalArgumentException {
		for (int i = 0; i < types.length; i++) {
			Object value = findValueOfType(coll, types[i]);
			if (value != null) {
				return value;
			}
		}
		return null;
	}

	/**
	 * Converts the supplied array into a List. Primitive arrays are
	 * correctly converted into Lists of the appropriate wrapper type.
	 * @param source the original array
	 * @return the converted List result
	 */
	public static List arrayToList(Object source) {
		Assert.notNull(source, "Source array must not be null");
		if (!source.getClass().isArray()) {
			throw new IllegalArgumentException("Source is not an array: " + source);
		}
		boolean primitive = source.getClass().getComponentType().isPrimitive();
		Object[] array = (primitive ? ObjectUtils.toObjectArray(source) : (Object[]) source);
		return Arrays.asList(array);
	}

	/**
	 * Merge the given Properties instance into the given Map,
	 * copying all properties (key-value pairs) over.
	 * <p>Uses <code>Properties.propertyNames()</code> to even catch
	 * default properties linked into the original Properties instance.
	 * @param props the Properties instance to merge (may be <code>null</code>)
	 * @param map the target Map to merge the properties into
	 */
	public static void mergePropertiesIntoMap(Properties props, Map map) {
		Assert.notNull(map, "Map must not be null");
		if (props != null) {
			for (Enumeration en = props.propertyNames(); en.hasMoreElements();) {
				String key = (String) en.nextElement();
				map.put(key, props.getProperty(key));
			}
		}
	}

	/**
	 * Returns '<code>true</code>' if any element in '<code>candidates</code>' is
	 * contained in '<code>source</code>' otherwise returns false.
	 */
	public static boolean containsAny(Collection source, Collection candidates) {
		for (Iterator iterator = candidates.iterator(); iterator.hasNext();) {
			if(source.contains(iterator.next())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Returns the first element in '<code>candidates</code>' that is contained in
	 * '<code>source</code>'. If no element in '<code>candidates</code>' is present in
	 * '<code>source</code>' returns '<code>null</code>'. Iteration order is
	 * {@link Collection} implementation specific.
	 */
	public static Object findFirstMatch(Collection source, Collection candidates) {
		for (Iterator iterator = candidates.iterator(); iterator.hasNext();) {
			Object candidate = iterator.next();
			if(source.contains(candidate)) {
				return candidate;
			}
		}
		return null;
	}

}
