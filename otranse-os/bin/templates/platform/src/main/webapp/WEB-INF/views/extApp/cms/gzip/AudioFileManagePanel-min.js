AudioFileManagePanel=Ext.extend(Disco.Ext.CrudPanel,{id:"audioFileManagePanel",baseUrl:"attachment.java",gridSelModel:"checkbox",baseQueryParameter:{type:2},pageSize:20,batchRemoveMode:true,showAdd:false,showEdit:false,showView:false,topicRender:function(a){return a+'<b><a style="color:green" href="'+a+'" target="_blank">&nbsp\u6d93\u5b2d\u6d47</a></b>'},storeMapping:["id","fileName","oldName","path","length","createTime"],initComponent:function(){this.cm=new Ext.grid.ColumnModel([{header:"\u95ca\u62bd\ue576\u935a\u5d87\u041e",sortable:true,width:100,dataIndex:"fileName"},{header:"\u9358\u71b7\u6095\u7ec9\ufffd",sortable:true,width:100,dataIndex:"oldName"},{header:"\u74ba\ue21a\u7dde",sortable:true,width:100,dataIndex:"path",renderer:this.topicRender},{header:"\u6fb6\u0443\u76ac/\u701b\u6944\u59ad",sortable:true,width:50,dataIndex:"length"},{header:"\u6d93\u5a41\u7d36\u93c3\u30e6\u6e61",sortable:true,width:50,dataIndex:"createTime",renderer:this.dateRender()}]);AudioFileManagePanel.superclass.initComponent.call(this)}});