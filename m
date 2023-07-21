Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C275BF81
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGUHWT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGUHWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671ED30D4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF7656144C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EF6C4339A;
        Fri, 21 Jul 2023 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924129;
        bh=VJ9LVvw4PCz1fjy2c7tf59tnqr+YinrQmMeYyqIRj9s=;
        h=Subject:To:Cc:From:Date:From;
        b=eCogJHMn+TegBoGCF2xlhOylMCFIxt77Q/AkSjSqOomBwW3CrTqoh14dSg8Ym9vdC
         kksQRktE2ifpHZTpG/GglyQjHFEck2YIp84SPWuWHxeepOEVCtTH4zCIos7d06qocy
         L56MRz0R7/RAEz0hoPeo1Exf/reP8Ity3Gi1afeY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: change reserved vram info print" failed to apply to 6.4-stable tree
To:     YiPeng.Chai@amd.com, Arunpravin.PaneerSelvam@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:22:06 +0200
Message-ID: <2023072106-dentist-stagnate-1b4f@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 869bcf59fd64382e3b23b219e791e6e5ebf1114e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072106-dentist-stagnate-1b4f@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 869bcf59fd64382e3b23b219e791e6e5ebf1114e Mon Sep 17 00:00:00 2001
From: YiPeng Chai <YiPeng.Chai@amd.com>
Date: Wed, 24 May 2023 17:14:15 +0800
Subject: [PATCH] drm/amdgpu: change reserved vram info print
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The link object of mgr->reserved_pages is the blocks
variable in struct amdgpu_vram_reservation, not the
link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 89d35d194f2c..c7085a747b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &mgr->mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, "  vis usage:%llu\n",
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, "reserved:\n");
-	list_for_each_entry(block, &mgr->reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
+		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+			rsv->start, rsv->start + rsv->size, rsv->size);
 	mutex_unlock(&mgr->lock);
 }
 

