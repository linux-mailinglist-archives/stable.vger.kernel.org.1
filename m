Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11C75BFE4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGUHhU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUHg6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C3B35BF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6484161136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B733C433C8;
        Fri, 21 Jul 2023 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924997;
        bh=mMGRkS9sYoWmr4A1bn/GdHfymvCG8E6cSZ7Bi/IXiNw=;
        h=Subject:To:Cc:From:Date:From;
        b=ZyX7o0kUvay19gnB3MjZxV/3AuI6U1e/7KBiynwxX/u5LSUCg+JpfsXk46fLtT38p
         bHRP0fR+KoDytN2d3QFpA3Z6MFegj31tBuQNMkDdIqTGN312OXBHmFzu0x2rLPDYuB
         5h7u4LEaazr4EOEi/ikojS/WrjQrtDQLxUy1URy8=
Subject: FAILED: patch "[PATCH] drm/ttm: Don't leak a resource on eviction error" failed to apply to 5.15-stable tree
To:     thomas.hellstrom@linux.intel.com, andi.shyti@linux.intel.com,
        andrey.grodzovsky@amd.com, christian.koenig@amd.com,
        nirmoy.das@intel.com, ray.huang@amd.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:36:26 +0200
Message-ID: <2023072126-altitude-coexist-08f2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x e8188c461ee015ba0b9ab2fc82dbd5ebca5a5532
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072126-altitude-coexist-08f2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e8188c461ee0 ("drm/ttm: Don't leak a resource on eviction error")
8ab3b0663e27 ("drm/ttm: Don't print error message if eviction was interrupted")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8188c461ee015ba0b9ab2fc82dbd5ebca5a5532 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Mon, 26 Jun 2023 11:14:49 +0200
Subject: [PATCH] drm/ttm: Don't leak a resource on eviction error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On eviction errors other than -EMULTIHOP we were leaking a resource.
Fix.

v2:
- Avoid yet another goto (Andi Shyti)

Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> #v1
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230626091450.14757-4-thomas.hellstrom@linux.intel.com

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bd5dae4d1624..d364639a2752 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -458,18 +458,18 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 		goto out;
 	}
 
-bounce:
-	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
-	if (ret == -EMULTIHOP) {
+	do {
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
+		if (ret != -EMULTIHOP)
+			break;
+
 		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
-		if (ret) {
-			if (ret != -ERESTARTSYS && ret != -EINTR)
-				pr_err("Buffer eviction failed\n");
-			ttm_resource_free(bo, &evict_mem);
-			goto out;
-		}
-		/* try and move to final place now. */
-		goto bounce;
+	} while (!ret);
+
+	if (ret) {
+		ttm_resource_free(bo, &evict_mem);
+		if (ret != -ERESTARTSYS && ret != -EINTR)
+			pr_err("Buffer eviction failed\n");
 	}
 out:
 	return ret;

