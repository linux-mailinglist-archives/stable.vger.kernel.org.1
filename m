Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B7715116
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjE2VqT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjE2VqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427BC1
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VQtIeu65FchuGii9JZmgEqHm8MLSV5vAeqJUyRJJ1g=;
        b=BGFQW6ltuoFapOtOx5/7B72I2oPuDD4eE3BvGk6FOc0S675GdGbEpeDzvTvjQLGhI8ET1i
        8PAs2ylOzYhlnS/TxabzSVbCgg/dtIPIMCjSIe/Y8Us7Ua7wf02hn70VUzrmSLM19rQjlp
        pkpyCcHeESjcT4UTZ6kR1sIyYsOPVio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-lf4R9wfsM1iwHvB7HBbV4A-1; Mon, 29 May 2023 17:44:43 -0400
X-MC-Unique: lf4R9wfsM1iwHvB7HBbV4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79399185A78F
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:43 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 521302166B2B;
        Mon, 29 May 2023 21:44:43 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 09/12] fs: dlm: filter ourself midcomms calls
Date:   Mon, 29 May 2023 17:44:37 -0400
Message-Id: <20230529214440.2542721-9-aahringo@redhat.com>
In-Reply-To: <20230529214440.2542721-1-aahringo@redhat.com>
References: <20230529214440.2542721-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

It makes no sense to call midcomms/lowcomms functionality for the local
node as socket functionality is only required for remote nodes. This
patch filters those calls in the upper layer of lockspace membership
handling instead of doing it in midcomms/lowcomms layer as they should
never be aware of local nodeid.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c   |  3 ++-
 fs/dlm/lowcomms.c |  3 ---
 fs/dlm/member.c   | 37 ++++++++++++++++++++++++++++++-------
 fs/dlm/midcomms.c |  9 ---------
 4 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 2beceff024e3..4246cd425671 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -532,7 +532,8 @@ static void drop_comm(struct config_group *g, struct config_item *i)
 	struct dlm_comm *cm = config_item_to_comm(i);
 	if (local_comm == cm)
 		local_comm = NULL;
-	dlm_midcomms_close(cm->nodeid);
+	if (!cm->local)
+		dlm_midcomms_close(cm->nodeid);
 	while (cm->addr_count--)
 		kfree(cm->addr[cm->addr_count]);
 	config_item_put(i);
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 5a7586633cbe..345a316ae54c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -546,9 +546,6 @@ int dlm_lowcomms_connect_node(int nodeid)
 	struct connection *con;
 	int idx;
 
-	if (nodeid == dlm_our_nodeid())
-		return 0;
-
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, 0);
 	if (WARN_ON_ONCE(!con)) {
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 923c01a8a0aa..77d202e4a02a 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -307,6 +307,21 @@ static void add_ordered_member(struct dlm_ls *ls, struct dlm_member *new)
 	}
 }
 
+static int add_remote_member(int nodeid)
+{
+	int error;
+
+	if (nodeid == dlm_our_nodeid())
+		return 0;
+
+	error = dlm_lowcomms_connect_node(nodeid);
+	if (error < 0)
+		return error;
+
+	dlm_midcomms_add_member(nodeid);
+	return 0;
+}
+
 static int dlm_add_member(struct dlm_ls *ls, struct dlm_config_node *node)
 {
 	struct dlm_member *memb;
@@ -316,16 +331,16 @@ static int dlm_add_member(struct dlm_ls *ls, struct dlm_config_node *node)
 	if (!memb)
 		return -ENOMEM;
 
-	error = dlm_lowcomms_connect_node(node->nodeid);
+	memb->nodeid = node->nodeid;
+	memb->weight = node->weight;
+	memb->comm_seq = node->comm_seq;
+
+	error = add_remote_member(node->nodeid);
 	if (error < 0) {
 		kfree(memb);
 		return error;
 	}
 
-	memb->nodeid = node->nodeid;
-	memb->weight = node->weight;
-	memb->comm_seq = node->comm_seq;
-	dlm_midcomms_add_member(node->nodeid);
 	add_ordered_member(ls, memb);
 	ls->ls_num_nodes++;
 	return 0;
@@ -370,11 +385,19 @@ static void clear_memb_list(struct list_head *head,
 	}
 }
 
-static void clear_members_cb(int nodeid)
+static void remove_remote_member(int nodeid)
 {
+	if (nodeid == dlm_our_nodeid())
+		return;
+
 	dlm_midcomms_remove_member(nodeid);
 }
 
+static void clear_members_cb(int nodeid)
+{
+	remove_remote_member(nodeid);
+}
+
 void dlm_clear_members(struct dlm_ls *ls)
 {
 	clear_memb_list(&ls->ls_nodes, clear_members_cb);
@@ -562,7 +585,7 @@ int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
 
 		neg++;
 		list_move(&memb->list, &ls->ls_nodes_gone);
-		dlm_midcomms_remove_member(memb->nodeid);
+		remove_remote_member(memb->nodeid);
 		ls->ls_num_nodes--;
 		dlm_lsop_recover_slot(ls, memb);
 	}
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 3df916a568ba..9c66cb853d17 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1280,9 +1280,6 @@ void dlm_midcomms_add_member(int nodeid)
 	struct midcomms_node *node;
 	int idx;
 
-	if (nodeid == dlm_our_nodeid())
-		return;
-
 	idx = srcu_read_lock(&nodes_srcu);
 	node = nodeid2node(nodeid, GFP_NOFS);
 	if (!node) {
@@ -1328,9 +1325,6 @@ void dlm_midcomms_remove_member(int nodeid)
 	struct midcomms_node *node;
 	int idx;
 
-	if (nodeid == dlm_our_nodeid())
-		return;
-
 	idx = srcu_read_lock(&nodes_srcu);
 	node = nodeid2node(nodeid, 0);
 	if (!node) {
@@ -1487,9 +1481,6 @@ int dlm_midcomms_close(int nodeid)
 	struct midcomms_node *node;
 	int idx, ret;
 
-	if (nodeid == dlm_our_nodeid())
-		return 0;
-
 	idx = srcu_read_lock(&nodes_srcu);
 	/* Abort pending close/remove operation */
 	node = nodeid2node(nodeid, 0);
-- 
2.31.1

