Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82D7354F4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjFSLAY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFSK7c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4F1701
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2EBF60B8D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B49C433C0;
        Mon, 19 Jun 2023 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172322;
        bh=CeEcoPNPhu2kmeD+unAgV7Ky5hUZMRaLlWIXaUf1ZXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpzXSQEKFipBZsm5nCLCXQiJxlKD/n1t5BY+571117caiI+3eGlWTthpTtKAk1wre
         yKzybpxpmCC6E3BWp4SECQzSd9SC1BYcp50bjPzU55GjcpRAoLoTwTofG4nx3ctpHL
         Tl7S77twfOvH+1Yj7Vm233L3RebHXcH9exlAcM18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/107] of: overlay: rework overlay apply and remove kfree()s
Date:   Mon, 19 Jun 2023 12:29:51 +0200
Message-ID: <20230619102141.893980369@linuxfoundation.org>
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

[ Upstream commit 067c098766c6af667a9002d4e33cf1f3c998abbe ]

Fix various kfree() issues related to of_overlay_apply().
  - Double kfree() of fdt and tree when init_overlay_changeset()
    returns an error.
  - free_overlay_changeset() free the root of the unflattened
    overlay (variable tree) instead of the memory that contains
    the unflattened overlay.
  - For the case of a failure during applying an overlay, move kfree()
    of new_fdt and overlay_mem into free_overlay_changeset(), which
    is called by the function that allocated them.
  - For the case of removing an overlay, the kfree() of new_fdt and
    overlay_mem remains in free_overlay_changeset().
  - Check return value of of_fdt_unflatten_tree() for error instead
    of checking the returned value of overlay_root.
  - When storing pointers to allocated objects in ovcs, do so as
    near to the allocation as possible instead of in deeply layered
    function.

More clearly document policy related to lifetime of pointers into
overlay memory.

Double kfree()
Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220420222505.928492-3-frowand.list@gmail.com
Stable-dep-of: 39affd1fdf65 ("of: overlay: Fix missing of_node_put() in error case of init_overlay_changeset()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/overlay-notes.rst |  30 ++-
 drivers/of/overlay.c                       | 263 ++++++++++-----------
 include/linux/of.h                         |   3 +-
 3 files changed, 153 insertions(+), 143 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index b2b8db765b8c6..e139f22b363e9 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -119,10 +119,32 @@ Finally, if you need to remove all overlays in one-go, just call
 of_overlay_remove_all() which will remove every single one in the correct
 order.
 
-In addition, there is the option to register notifiers that get called on
+There is the option to register notifiers that get called on
 overlay operations. See of_overlay_notifier_register/unregister and
 enum of_overlay_notify_action for details.
 
-Note that a notifier callback is not supposed to store pointers to a device
-tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
-respective node it received.
+A notifier callback for OF_OVERLAY_PRE_APPLY, OF_OVERLAY_POST_APPLY, or
+OF_OVERLAY_PRE_REMOVE may store pointers to a device tree node in the overlay
+or its content but these pointers must not persist past the notifier callback
+for OF_OVERLAY_POST_REMOVE.  The memory containing the overlay will be
+kfree()ed after OF_OVERLAY_POST_REMOVE notifiers are called.  Note that the
+memory will be kfree()ed even if the notifier for OF_OVERLAY_POST_REMOVE
+returns an error.
+
+The changeset notifiers in drivers/of/dynamic.c are a second type of notifier
+that could be triggered by applying or removing an overlay.  These notifiers
+are not allowed to store pointers to a device tree node in the overlay
+or its content.  The overlay code does not protect against such pointers
+remaining active when the memory containing the overlay is freed as a result
+of removing the overlay.
+
+Any other code that retains a pointer to the overlay nodes or data is
+considered to be a bug because after removing the overlay the pointer
+will refer to freed memory.
+
+Users of overlays must be especially aware of the overall operations that
+occur on the system to ensure that other kernel code does not retain any
+pointers to the overlay nodes or data.  Any example of an inadvertent use
+of such pointers is if a driver or subsystem module is loaded after an
+overlay has been applied, and the driver or subsystem scans the entire
+devicetree or a large portion of it, including the overlay nodes.
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 56afef5594112..119dd6a0be868 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -58,7 +58,9 @@ struct fragment {
  * @id:			changeset identifier
  * @ovcs_list:		list on which we are located
  * @new_fdt:		Memory allocated to hold unflattened aligned FDT
+ * @overlay_mem:	the memory chunk that contains @overlay_root
  * @overlay_root:	expanded device tree that contains the fragment nodes
+ * @notify_state:	most recent notify action used on overlay
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
  * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
@@ -68,7 +70,9 @@ struct overlay_changeset {
 	int id;
 	struct list_head ovcs_list;
 	const void *new_fdt;
+	const void *overlay_mem;
 	struct device_node *overlay_root;
+	enum of_overlay_notify_action notify_state;
 	int count;
 	struct fragment *fragments;
 	bool symbols_fragment;
@@ -115,7 +119,6 @@ void of_overlay_mutex_unlock(void)
 	mutex_unlock(&of_overlay_phandle_mutex);
 }
 
-
 static LIST_HEAD(ovcs_list);
 static DEFINE_IDR(ovcs_idr);
 
@@ -162,6 +165,8 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 	struct of_overlay_notify_data nd;
 	int i, ret;
 
+	ovcs->notify_state = action;
+
 	for (i = 0; i < ovcs->count; i++) {
 		struct fragment *fragment = &ovcs->fragments[i];
 
@@ -717,53 +722,49 @@ static struct device_node *find_target(struct device_node *info_node)
 /**
  * init_overlay_changeset() - initialize overlay changeset from overlay tree
  * @ovcs:		Overlay changeset to build
- * @new_fdt:		Memory allocated to hold unflattened aligned FDT
- * @overlay_root:	Contains the overlay fragments and overlay fixup nodes
  *
  * Initialize @ovcs.  Populate @ovcs->fragments with node information from
  * the top level of @overlay_root.  The relevant top level nodes are the
  * fragment nodes and the __symbols__ node.  Any other top level node will
- * be ignored.
+ * be ignored.  Populate other @ovcs fields.
  *
  * Return: 0 on success, -ENOMEM if memory allocation failure, -EINVAL if error
- * detected in @overlay_root, or -ENOSPC if idr_alloc() error.
+ * detected in @overlay_root.  On error return, the caller of
+ * init_overlay_changeset() must call free_overlay_changeset().
  */
-static int init_overlay_changeset(struct overlay_changeset *ovcs,
-		const void *new_fdt, struct device_node *overlay_root)
+static int init_overlay_changeset(struct overlay_changeset *ovcs)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
 	struct fragment *fragments;
-	int cnt, id, ret;
+	int cnt, ret;
+
+	/*
+	 * None of the resources allocated by this function will be freed in
+	 * the error paths.  Instead the caller of this function is required
+	 * to call free_overlay_changeset() (which will free the resources)
+	 * if error return.
+	 */
 
 	/*
 	 * Warn for some issues.  Can not return -EINVAL for these until
 	 * of_unittest_apply_overlay() is fixed to pass these checks.
 	 */
-	if (!of_node_check_flag(overlay_root, OF_DYNAMIC))
-		pr_debug("%s() overlay_root is not dynamic\n", __func__);
+	if (!of_node_check_flag(ovcs->overlay_root, OF_DYNAMIC))
+		pr_debug("%s() ovcs->overlay_root is not dynamic\n", __func__);
 
-	if (!of_node_check_flag(overlay_root, OF_DETACHED))
-		pr_debug("%s() overlay_root is not detached\n", __func__);
+	if (!of_node_check_flag(ovcs->overlay_root, OF_DETACHED))
+		pr_debug("%s() ovcs->overlay_root is not detached\n", __func__);
 
-	if (!of_node_is_root(overlay_root))
-		pr_debug("%s() overlay_root is not root\n", __func__);
-
-	ovcs->overlay_root = overlay_root;
-	ovcs->new_fdt = new_fdt;
-
-	INIT_LIST_HEAD(&ovcs->ovcs_list);
+	if (!of_node_is_root(ovcs->overlay_root))
+		pr_debug("%s() ovcs->overlay_root is not root\n", __func__);
 
 	of_changeset_init(&ovcs->cset);
 
-	id = idr_alloc(&ovcs_idr, ovcs, 1, 0, GFP_KERNEL);
-	if (id <= 0)
-		return id;
-
 	cnt = 0;
 
 	/* fragment nodes */
-	for_each_child_of_node(overlay_root, node) {
+	for_each_child_of_node(ovcs->overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (overlay_node) {
 			cnt++;
@@ -771,7 +772,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 		}
 	}
 
-	node = of_get_child_by_name(overlay_root, "__symbols__");
+	node = of_get_child_by_name(ovcs->overlay_root, "__symbols__");
 	if (node) {
 		cnt++;
 		of_node_put(node);
@@ -780,11 +781,12 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	fragments = kcalloc(cnt, sizeof(*fragments), GFP_KERNEL);
 	if (!fragments) {
 		ret = -ENOMEM;
-		goto err_free_idr;
+		goto err_out;
 	}
+	ovcs->fragments = fragments;
 
 	cnt = 0;
-	for_each_child_of_node(overlay_root, node) {
+	for_each_child_of_node(ovcs->overlay_root, node) {
 		overlay_node = of_get_child_by_name(node, "__overlay__");
 		if (!overlay_node)
 			continue;
@@ -796,7 +798,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
 			of_node_put(node);
-			goto err_free_fragments;
+			goto err_out;
 		}
 
 		cnt++;
@@ -806,7 +808,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	 * if there is a symbols fragment in ovcs->fragments[i] it is
 	 * the final element in the array
 	 */
-	node = of_get_child_by_name(overlay_root, "__symbols__");
+	node = of_get_child_by_name(ovcs->overlay_root, "__symbols__");
 	if (node) {
 		ovcs->symbols_fragment = 1;
 		fragment = &fragments[cnt];
@@ -816,7 +818,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 		if (!fragment->target) {
 			pr_err("symbols in overlay, but not in live tree\n");
 			ret = -EINVAL;
-			goto err_free_fragments;
+			goto err_out;
 		}
 
 		cnt++;
@@ -825,20 +827,14 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 	if (!cnt) {
 		pr_err("no fragments or symbols in overlay\n");
 		ret = -EINVAL;
-		goto err_free_fragments;
+		goto err_out;
 	}
 
-	ovcs->id = id;
 	ovcs->count = cnt;
-	ovcs->fragments = fragments;
 
 	return 0;
 
-err_free_fragments:
-	kfree(fragments);
-err_free_idr:
-	idr_remove(&ovcs_idr, id);
-
+err_out:
 	pr_err("%s() failed, ret = %d\n", __func__, ret);
 
 	return ret;
@@ -851,21 +847,34 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	if (ovcs->cset.entries.next)
 		of_changeset_destroy(&ovcs->cset);
 
-	if (ovcs->id)
+	if (ovcs->id) {
 		idr_remove(&ovcs_idr, ovcs->id);
+		list_del(&ovcs->ovcs_list);
+		ovcs->id = 0;
+	}
+
 
 	for (i = 0; i < ovcs->count; i++) {
 		of_node_put(ovcs->fragments[i].target);
 		of_node_put(ovcs->fragments[i].overlay);
 	}
 	kfree(ovcs->fragments);
+
 	/*
-	 * There should be no live pointers into ovcs->overlay_root and
+	 * There should be no live pointers into ovcs->overlay_mem and
 	 * ovcs->new_fdt due to the policy that overlay notifiers are not
-	 * allowed to retain pointers into the overlay devicetree.
+	 * allowed to retain pointers into the overlay devicetree other
+	 * than during the window from OF_OVERLAY_PRE_APPLY overlay
+	 * notifiers until the OF_OVERLAY_POST_REMOVE overlay notifiers.
+	 *
+	 * A memory leak will occur here if within the window.
 	 */
-	kfree(ovcs->overlay_root);
-	kfree(ovcs->new_fdt);
+
+	if (ovcs->notify_state == OF_OVERLAY_INIT ||
+	    ovcs->notify_state == OF_OVERLAY_POST_REMOVE) {
+		kfree(ovcs->overlay_mem);
+		kfree(ovcs->new_fdt);
+	}
 	kfree(ovcs);
 }
 
@@ -873,27 +882,13 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * internal documentation
  *
  * of_overlay_apply() - Create and apply an overlay changeset
- * @new_fdt:		Memory allocated to hold the aligned FDT
- * @overlay_root:	Expanded overlay device tree
- * @ovcs_id:		Pointer to overlay changeset id
+ * @ovcs:	overlay changeset
  *
  * Creates and applies an overlay changeset.
  *
- * If an error occurs in a pre-apply notifier, then no changes are made
- * to the device tree.
- *
- * A non-zero return value will not have created the changeset if error is from:
- *   - parameter checks
- *   - building the changeset
- *   - overlay changeset pre-apply notifier
- *
  * If an error is returned by an overlay changeset pre-apply notifier
  * then no further overlay changeset pre-apply notifier will be called.
  *
- * A non-zero return value will have created the changeset if error is from:
- *   - overlay changeset entry notifier
- *   - overlay changeset post-apply notifier
- *
  * If an error is returned by an overlay changeset post-apply notifier
  * then no further overlay changeset post-apply notifier will be called.
  *
@@ -907,64 +902,37 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * following attempt to apply or remove an overlay changeset will be
  * refused.
  *
- * Returns 0 on success, or a negative error number.  Overlay changeset
- * id is returned to *ovcs_id.
+ * Returns 0 on success, or a negative error number.  On error return,
+ * the caller of of_overlay_apply() must call free_overlay_changeset().
  */
 
-static int of_overlay_apply(const void *new_fdt,
-		struct device_node *overlay_root, int *ovcs_id)
+static int of_overlay_apply(struct overlay_changeset *ovcs)
 {
-	struct overlay_changeset *ovcs;
 	int ret = 0, ret_revert, ret_tmp;
 
-	/*
-	 * As of this point, fdt and tree belong to the overlay changeset.
-	 * overlay changeset code is responsible for freeing them.
-	 */
-
 	if (devicetree_corrupt()) {
 		pr_err("devicetree state suspect, refuse to apply overlay\n");
-		kfree(new_fdt);
-		kfree(overlay_root);
 		ret = -EBUSY;
 		goto out;
 	}
 
-	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
-	if (!ovcs) {
-		kfree(new_fdt);
-		kfree(overlay_root);
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	of_overlay_mutex_lock();
-	mutex_lock(&of_mutex);
-
-	ret = of_resolve_phandles(overlay_root);
+	ret = of_resolve_phandles(ovcs->overlay_root);
 	if (ret)
-		goto err_free_tree;
+		goto out;
 
-	ret = init_overlay_changeset(ovcs, new_fdt, overlay_root);
+	ret = init_overlay_changeset(ovcs);
 	if (ret)
-		goto err_free_tree;
+		goto out;
 
-	/*
-	 * After overlay_notify(), ovcs->overlay_root related pointers may have
-	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
-	 * and can not free memory containing aligned fdt.  The aligned fdt
-	 * is contained within the memory at ovcs->new_fdt, possibly at an
-	 * offset from ovcs->new_fdt.
-	 */
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
-		goto err_free_overlay_changeset;
+		goto out;
 	}
 
 	ret = build_changeset(ovcs);
 	if (ret)
-		goto err_free_overlay_changeset;
+		goto out;
 
 	ret_revert = 0;
 	ret = __of_changeset_apply_entries(&ovcs->cset, &ret_revert);
@@ -974,7 +942,7 @@ static int of_overlay_apply(const void *new_fdt,
 				 ret_revert);
 			devicetree_state_flags |= DTSF_APPLY_FAIL;
 		}
-		goto err_free_overlay_changeset;
+		goto out;
 	}
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
@@ -982,9 +950,6 @@ static int of_overlay_apply(const void *new_fdt,
 		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
-	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
-	*ovcs_id = ovcs->id;
-
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_APPLY);
 	if (ret_tmp) {
 		pr_err("overlay changeset post-apply notify error %d\n",
@@ -993,19 +958,6 @@ static int of_overlay_apply(const void *new_fdt,
 			ret = ret_tmp;
 	}
 
-	goto out_unlock;
-
-err_free_tree:
-	kfree(new_fdt);
-	kfree(overlay_root);
-
-err_free_overlay_changeset:
-	free_overlay_changeset(ovcs);
-
-out_unlock:
-	mutex_unlock(&of_mutex);
-	of_overlay_mutex_unlock();
-
 out:
 	pr_debug("%s() err=%d\n", __func__, ret);
 
@@ -1013,15 +965,16 @@ static int of_overlay_apply(const void *new_fdt,
 }
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id)
+			 int *ret_ovcs_id)
 {
 	void *new_fdt;
 	void *new_fdt_align;
+	void *overlay_mem;
 	int ret;
 	u32 size;
-	struct device_node *overlay_root = NULL;
+	struct overlay_changeset *ovcs;
 
-	*ovcs_id = 0;
+	*ret_ovcs_id = 0;
 
 	if (overlay_fdt_size < sizeof(struct fdt_header) ||
 	    fdt_check_header(overlay_fdt)) {
@@ -1033,41 +986,67 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	if (overlay_fdt_size < size)
 		return -EINVAL;
 
+	ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
+	if (!ovcs)
+		return -ENOMEM;
+
+	of_overlay_mutex_lock();
+	mutex_lock(&of_mutex);
+
+	/*
+	 * ovcs->notify_state must be set to OF_OVERLAY_INIT before allocating
+	 * ovcs resources, implicitly set by kzalloc() of ovcs
+	 */
+
+	ovcs->id = idr_alloc(&ovcs_idr, ovcs, 1, 0, GFP_KERNEL);
+	if (ovcs->id <= 0) {
+		ret = ovcs->id;
+		goto err_free_ovcs;
+	}
+
+	INIT_LIST_HEAD(&ovcs->ovcs_list);
+	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
+
 	/*
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
 	 * will create pointers to the passed in FDT in the unflattened tree.
 	 */
 	new_fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
-	if (!new_fdt)
-		return -ENOMEM;
+	if (!new_fdt) {
+		ret = -ENOMEM;
+		goto err_free_ovcs;
+	}
+	ovcs->new_fdt = new_fdt;
 
 	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
 	memcpy(new_fdt_align, overlay_fdt, size);
 
-	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
-	if (!overlay_root) {
+	overlay_mem = of_fdt_unflatten_tree(new_fdt_align, NULL,
+					    &ovcs->overlay_root);
+	if (!overlay_mem) {
 		pr_err("unable to unflatten overlay_fdt\n");
 		ret = -EINVAL;
-		goto out_free_new_fdt;
+		goto err_free_ovcs;
 	}
+	ovcs->overlay_mem = overlay_mem;
 
-	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
-	if (ret < 0) {
-		/*
-		 * new_fdt and overlay_root now belong to the overlay
-		 * changeset.
-		 * overlay changeset code is responsible for freeing them.
-		 */
-		goto out;
-	}
+	ret = of_overlay_apply(ovcs);
+	if (ret < 0)
+		goto err_free_ovcs;
+
+	mutex_unlock(&of_mutex);
+	of_overlay_mutex_unlock();
+
+	*ret_ovcs_id = ovcs->id;
 
 	return 0;
 
+err_free_ovcs:
+	free_overlay_changeset(ovcs);
 
-out_free_new_fdt:
-	kfree(new_fdt);
+	mutex_unlock(&of_mutex);
+	of_overlay_mutex_unlock();
 
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
@@ -1204,28 +1183,26 @@ int of_overlay_remove(int *ovcs_id)
 	if (!ovcs) {
 		ret = -ENODEV;
 		pr_err("remove: Could not find overlay #%d\n", *ovcs_id);
-		goto out_unlock;
+		goto err_unlock;
 	}
 
 	if (!overlay_removal_is_ok(ovcs)) {
 		ret = -EBUSY;
-		goto out_unlock;
+		goto err_unlock;
 	}
 
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_REMOVE);
 	if (ret) {
 		pr_err("overlay changeset pre-remove notify error %d\n", ret);
-		goto out_unlock;
+		goto err_unlock;
 	}
 
-	list_del(&ovcs->ovcs_list);
-
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
 	if (ret) {
 		if (ret_apply)
 			devicetree_state_flags |= DTSF_REVERT_FAIL;
-		goto out_unlock;
+		goto err_unlock;
 	}
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
@@ -1235,6 +1212,11 @@ int of_overlay_remove(int *ovcs_id)
 
 	*ovcs_id = 0;
 
+	/*
+	 * Note that the overlay memory will be kfree()ed by
+	 * free_overlay_changeset() even if the notifier for
+	 * OF_OVERLAY_POST_REMOVE returns an error.
+	 */
 	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
 	if (ret_tmp) {
 		pr_err("overlay changeset post-remove notify error %d\n",
@@ -1245,7 +1227,12 @@ int of_overlay_remove(int *ovcs_id)
 
 	free_overlay_changeset(ovcs);
 
-out_unlock:
+err_unlock:
+	/*
+	 * If jumped over free_overlay_changeset(), then did not kfree()
+	 * overlay related memory.  This is a memory leak unless a subsequent
+	 * of_overlay_remove() of this overlay is successful.
+	 */
 	mutex_unlock(&of_mutex);
 
 out:
diff --git a/include/linux/of.h b/include/linux/of.h
index 6f1c41f109bbe..83414a0b41de5 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1486,7 +1486,8 @@ static inline bool of_device_is_system_power_controller(const struct device_node
  */
 
 enum of_overlay_notify_action {
-	OF_OVERLAY_PRE_APPLY = 0,
+	OF_OVERLAY_INIT = 0,	/* kzalloc() of ovcs sets this value */
+	OF_OVERLAY_PRE_APPLY,
 	OF_OVERLAY_POST_APPLY,
 	OF_OVERLAY_PRE_REMOVE,
 	OF_OVERLAY_POST_REMOVE,
-- 
2.39.2



