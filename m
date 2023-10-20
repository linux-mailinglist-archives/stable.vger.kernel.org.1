Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49B7D1536
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJTRy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjJTRy2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:54:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295CC0
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:54:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A4EC433C8;
        Fri, 20 Oct 2023 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697824466;
        bh=o2LNGZ7OVjS1/kUaoBcjuvo77jAvhFaCT+hffiC9BsA=;
        h=Subject:To:Cc:From:Date:From;
        b=WFedMJ1WJiTXk3ot14rthuChuYbZxLMKlXhMZSopR5+jrdD4Gt3h5b+juCLZOo6ed
         DZZT/jvsbDrHHti3VyHqbEarvjTC0nt6lSkXamY3ntiwYjPSlMPnLxnqppgWoQq0vY
         4zr9x3zPtiVh3BGmbNR8N58uLnOaylCEG+Qwbigo=
Subject: FAILED: patch "[PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap" failed to apply to 5.15-stable tree
To:     wenst@chromium.org, chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:54:23 +0200
Message-ID: <2023102023-praising-mumbo-a93b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dcc583c225e659d5da34b4ad83914fd6b51e3dbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102023-praising-mumbo-a93b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dcc583c225e659d5da34b4ad83914fd6b51e3dbf Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 4 Oct 2023 16:32:24 +0800
Subject: [PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap

The MediaTek DRM driver implements GEM PRIME vmap by fetching the
sg_table for the object, iterating through the pages, and then
vmapping them. In essence, unlike the GEM DMA helpers which vmap
when the object is first created or imported, the MediaTek version
does it on request.

Unfortunately, the code never correctly frees the sg_table contents.
This results in a kernel memory leak. On a Hayato device with a text
console on the internal display, this results in the system running
out of memory in a few days from all the console screen cursor updates.

Add sg_free_table() to correctly free the contents of the sg_table. This
was missing despite explicitly required by mtk_gem_prime_get_sg_table().

Also move the "out" shortcut label to after the kfree() call for the
sg_table. Having sg_free_table() together with kfree() makes more sense.
The shortcut is only used when the object already has a kernel address,
in which case the pointer is NULL and kfree() does nothing. Hence this
change causes no functional change.

Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20231004083226.1940055-1-wenst@chromium.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 9f364df52478..0e0a41b2f57f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	npages = obj->size >> PAGE_SHIFT;
 	mtk_gem->pages = kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
 	if (!mtk_gem->pages) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		return -ENOMEM;
 	}
@@ -248,12 +249,15 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 	if (!mtk_gem->kvaddr) {
+		sg_free_table(sgt);
 		kfree(sgt);
 		kfree(mtk_gem->pages);
 		return -ENOMEM;
 	}
-out:
+	sg_free_table(sgt);
 	kfree(sgt);
+
+out:
 	iosys_map_set_vaddr(map, mtk_gem->kvaddr);
 
 	return 0;

