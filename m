Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F227354F7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjFSLAW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFSK7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373D198A
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B35160B78
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62962C433C0;
        Mon, 19 Jun 2023 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172319;
        bh=Fnc5zGA4j6ghl6fyO2w9uVpYMGVQa4LWs+UzjIponNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQlbEccGeLGJC4DD8RYE7DhJdyNzjG1bqcfB8TpxABeugu0k3PylX1KcmpwGXnxJ7
         6yxyPMY6tVwQxTV6dX5lKzjnsvFWXEQApzBv83e3iAc3jzYuKLknHJzMtrzcSUSqiZ
         Lgk9KGAVJtb2JQVe8rQRW6WfVI2loUJs5JuTaUOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 006/107] of: overlay: rename variables to be consistent
Date:   Mon, 19 Jun 2023 12:29:50 +0200
Message-ID: <20230619102141.840951746@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

[ Upstream commit 1e4089667c7c732dd1b92c4c6bc7bd240ca30213 ]

Variables change name across function calls when there is not a good
reason to do so.  Fix by changing "fdt" to "new_fdt" and "tree" to
"overlay_root".

The name disparity was confusing when creating the following commit.
The name changes are in this separate commit to make review of the
following commmit less complex.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220420222505.928492-2-frowand.list@gmail.com
Stable-dep-of: 39affd1fdf65 ("of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/overlay.c | 94 ++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 424682372417d..56afef5594112 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -57,8 +57,8 @@ struct fragment {
  * struct overlay_changeset
  * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
- * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
- * @overlay_tree:	expanded device tree that contains the fragment nodes
+ * @new_fdt:		Memory allocated to hold unflattened aligned FDT
+ * @overlay_root:	expanded device tree that contains the fragment nodes
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
  * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
@@ -67,8 +67,8 @@ struct fragment {
 struct overlay_changeset {
 	int id;
 	struct list_head ovcs_list;
-	const void *fdt;
-	struct device_node *overlay_tree;
+	const void *new_fdt;
+	struct device_node *overlay_root;
 	int count;
 	struct fragment *fragments;
 	bool symbols_fragment;
@@ -183,7 +183,7 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 
 /*
  * The values of properties in the "/__symbols__" node are paths in
- * the ovcs->overlay_tree.  When duplicating the properties, the paths
+ * the ovcs->overlay_root.  When duplicating the properties, the paths
  * need to be adjusted to be the correct path for the live device tree.
  *
  * The paths refer to a node in the subtree of a fragment node's "__overlay__"
@@ -219,7 +219,7 @@ static struct property *dup_and_fixup_symbol_prop(
 
 	if (path_len < 1)
 		return NULL;
-	fragment_node = __of_find_node_by_path(ovcs->overlay_tree, path + 1);
+	fragment_node = __of_find_node_by_path(ovcs->overlay_root, path + 1);
 	overlay_node = __of_find_node_by_path(fragment_node, "__overlay__/");
 	of_node_put(fragment_node);
 	of_node_put(overlay_node);
@@ -716,19 +716,20 @@ static struct device_node *find_target(struct device_node *info_node)
 
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
- * @ovcs:	Overlay changeset to build
- * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
- * @tree:	Contains the overlay fragments and overlay fixup nodes
+ * @ovcs:		Overlay changeset to build
+ * @new_fdt:		Memory allocated to hold unflattened aligned FDT
+ * @overlay_root:	Contains the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
- * the top level of @tree.  The relevant top level nodes are the fragment
- * nodes and the __symbols__ node.  Any other top level node will be ignored.
+ * the top level of @overlay_root.  The relevant top level nodes are the
+ * fragment nodes and the __symbols__ node.  Any other top level node will
+ * be ignored.
  *
  * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
- * detected in @tree, or -ENOSPC if idr_alloc() error.
+ * detected in @overlay_root, or -ENOSPC if idr_alloc() error.
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *fdt, struct device_node *tree)
+		const void *new_fdt, struct device_node *overlay_root)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -739,17 +740,17 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	 * Warn for some issues.  Can not return -EINVAL for these until
 	 * of_unittest_apply_overlay() is fixed to pass these checks.
 	 */
-	if (!of_node_check_flag(tree, OF_DYNAMIC))
-		pr_debug("%s() tree is not dynamic\n", __func__);
+	if (!of_node_check_flag(overlay_root, OF_DYNAMIC))
+		pr_debug("%s() overlay_root is not dynamic\n", __func__);
 
-	if (!of_node_check_flag(tree, OF_DETACHED))
-		pr_debug("%s() tree is not detached\n", __func__);
+	if (!of_node_check_flag(overlay_root, OF_DETACHED))
+		pr_debug("%s() overlay_root is not detached\n", __func__);
 
-	if (!of_node_is_root(tree))
-		pr_debug("%s() tree is not root\n", __func__);
+	if (!of_node_is_root(overlay_root))
+		pr_debug("%s() overlay_root is not root\n", __func__);
 
-	ovcs->overlay_tree = tree;
-	ovcs->fdt = fdt;
+	ovcs->overlay_root = overlay_root;
+	ovcs->new_fdt = new_fdt;
 
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 
@@ -762,7 +763,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	cnt = 0;
 
 	/* fragment nodes */
-	for_each_child_of_node(tree, node) {
+	for_each_child_of_node(overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (overlay_node) {
 			cnt++;
@@ -770,7 +771,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 		}
 	}
 
-	node = of_get_child_by_name(tree, "__symbols__");
+	node = of_get_child_by_name(overlay_root, "__symbols__");
 	if (node) {
 		cnt++;
 		of_node_put(node);
@@ -783,7 +784,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	}
 
 	cnt = 0;
-	for_each_child_of_node(tree, node) {
+	for_each_child_of_node(overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (!overlay_node)
 			continue;
@@ -805,7 +806,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	 * if there is a symbols fragment in ovcs->fragments[i] it is
 	 * the final element in the array
 	 */
-	node = of_get_child_by_name(tree, "__symbols__");
+	node = of_get_child_by_name(overlay_root, "__symbols__");
 	if (node) {
 		ovcs->symbols_fragment = 1;
 		fragment = &fragments[cnt];
@@ -859,12 +860,12 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	}
 	kfree(ovcs->fragments);
 	/*
-	 * There should be no live pointers into ovcs->overlay_tree and
-	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
-	 * to retain pointers into the overlay devicetree.
+	 * There should be no live pointers into ovcs->overlay_root and
+	 * ovcs->new_fdt due to the policy that overlay notifiers are not
+	 * allowed to retain pointers into the overlay devicetree.
 	 */
-	kfree(ovcs->overlay_tree);
-	kfree(ovcs->fdt);
+	kfree(ovcs->overlay_root);
+	kfree(ovcs->new_fdt);
 	kfree(ovcs);
 }
 
@@ -872,16 +873,15 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * internal documentation
  *
  * of_overlay_apply() - Create and apply an overlay changeset
- * @fdt:	base of memory allocated to hold the aligned FDT
- * @tree:	Expanded overlay device tree
- * @ovcs_id:	Pointer to overlay changeset id
+ * @new_fdt:		Memory allocated to hold the aligned FDT
+ * @overlay_root:	Expanded overlay device tree
+ * @ovcs_id:		Pointer to overlay changeset id
  *
  * Creates and applies an overlay changeset.
  *
  * If an error occurs in a pre-apply notifier, then no changes are made
  * to the device tree.
  *
-
  * A non-zero return value will not have created the changeset if error is from:
  *   - parameter checks
  *   - building the changeset
@@ -911,8 +911,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * id is returned to *ovcs_id.
  */
 
-static int of_overlay_apply(const void *fdt, struct device_node *tree,
-		int *ovcs_id)
+static int of_overlay_apply(const void *new_fdt,
+		struct device_node *overlay_root, int *ovcs_id)
 {
 	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
@@ -924,16 +924,16 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	if (devicetree_corrupt()) {
 		pr_err("devicetree state suspect, refuse to apply overlay\n");
-		kfree(fdt);
-		kfree(tree);
+		kfree(new_fdt);
+		kfree(overlay_root);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
 	if (!ovcs) {
-		kfree(fdt);
-		kfree(tree);
+		kfree(new_fdt);
+		kfree(overlay_root);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -941,20 +941,20 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	of_overlay_mutex_lock();
 	mutex_lock(&of_mutex);
 
-	ret = of_resolve_phandles(tree);
+	ret = of_resolve_phandles(overlay_root);
 	if (ret)
 		goto err_free_tree;
 
-	ret = init_overlay_changeset(ovcs, fdt, tree);
+	ret = init_overlay_changeset(ovcs, new_fdt, overlay_root);
 	if (ret)
 		goto err_free_tree;
 
 	/*
-	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
+	 * After overlay_notify(), ovcs->overlay_root related pointers may have
 	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
 	 * and can not free memory containing aligned fdt.  The aligned fdt
-	 * is contained within the memory at ovcs->fdt, possibly at an offset
-	 * from ovcs->fdt.
+	 * is contained within the memory at ovcs->new_fdt, possibly at an
+	 * offset from ovcs->new_fdt.
 	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
@@ -996,8 +996,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	goto out_unlock;
 
 err_free_tree:
-	kfree(fdt);
-	kfree(tree);
+	kfree(new_fdt);
+	kfree(overlay_root);
 
 err_free_overlay_changeset:
 	free_overlay_changeset(ovcs);
-- 
2.39.2



