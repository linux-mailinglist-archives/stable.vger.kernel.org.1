Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283075C654
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGUMBR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGUMBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E587919A1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7201961A39
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E18C433C8;
        Fri, 21 Jul 2023 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689940865;
        bh=lNSqXEC4O/mCbg1O8VNH87S5DTuGe7g3CLLBBjTxbWo=;
        h=Subject:To:Cc:From:Date:From;
        b=q/UuS2v0n7wHe3Q5VPoB7flSrjHinZvA05QyapASTNVQnqaD1/4gJyz27MWZppI6k
         Mo/9yppBeZ7o1Y0FE8cSoE4UB4GW8zJfCFBs5lsFejcbMc+ODI6uvA2w1aaw/P0Xlr
         RbfHPYf8ZKCObqPivQxJ0m9DY3d9ARuYDwJnLI6A=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix clearing mappings for BOs that are always" failed to apply to 4.19-stable tree
To:     samuel.pitoiset@gmail.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 14:01:02 +0200
Message-ID: <2023072102-sprint-thicken-fc8b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ea2c3c08554601b051d91403a241266e1cf490a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072102-sprint-thicken-fc8b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ea2c3c085546 ("drm/amdgpu: fix clearing mappings for BOs that are always valid in VM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea2c3c08554601b051d91403a241266e1cf490a5 Mon Sep 17 00:00:00 2001
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Date: Fri, 16 Jun 2023 15:14:07 +0200
Subject: [PATCH] drm/amdgpu: fix clearing mappings for BOs that are always
 valid in VM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Per VM BOs must be marked as moved or otherwise their ranges are not
updated on use which might be necessary when the replace operation
splits mappings.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 143d11afe0e5..eff73c428b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}

