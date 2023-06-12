Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9852E72BAD0
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjFLIgM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjFLIgJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 04:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A86136
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 01:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C72B462152
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 08:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBCBC433EF;
        Mon, 12 Jun 2023 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686558962;
        bh=yv8A5TvY0uy7+PRqKAwGGWMdeDuCibijbf0MDTu/OpQ=;
        h=Subject:To:Cc:From:Date:From;
        b=Wr24I6LEhE0wS9NRtbjzuiaUwhQJWweFOWNfBk0Qmke5914H4ksmD9JCILLC4ZSuo
         UNwZ/r6W5BkDd22SD7sd3enc17+0H3K2seVnQOvmCl+c4mfWT8L5SIxt70IM5smIwa
         8sXWN2yzDHO/Y7UH2DhFGxsfgqE75R57MoC7oxLo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix Null pointer dereference error in" failed to apply to 5.15-stable tree
To:     Hongkun.Zhang@amd.com, Feifei.Xu@amd.com,
        alexander.deucher@amd.com, xinhui.pan@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 10:35:59 +0200
Message-ID: <2023061259-commodity-reflected-be84@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
git cherry-pick -x 2a1eb1a343208ce7d6839b73d62aece343e693ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061259-commodity-reflected-be84@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a1eb1a343208ce7d6839b73d62aece343e693ff Mon Sep 17 00:00:00 2001
From: Horatio Zhang <Hongkun.Zhang@amd.com>
Date: Mon, 29 May 2023 14:23:37 -0400
Subject: [PATCH] drm/amdgpu: fix Null pointer dereference error in
 amdgpu_device_recover_vram

Use the function of amdgpu_bo_vm_destroy to handle the resource release
of shadow bo. During the amdgpu_mes_self_test, shadow bo released, but
vmbo->shadow_list was not, which caused a null pointer reference error
in amdgpu_device_recover_vram when GPU reset.

Fixes: 6c032c37ac3e ("drm/amdgpu: Fix vram recover doesn't work after whole GPU reset (v2)")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Acked-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2bd1a54ee866..3b225be89cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -79,9 +79,10 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
-	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo *shadow_bo = ttm_to_amdgpu_bo(tbo), *bo;
 	struct amdgpu_bo_vm *vmbo;
 
+	bo = shadow_bo->parent;
 	vmbo = to_amdgpu_bo_vm(bo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
 	if (!list_empty(&vmbo->shadow_list)) {
@@ -694,11 +695,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
-	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
-	/* Set destroy callback to amdgpu_bo_vm_destroy after vmbo->shadow_list
-	 * is initialized.
-	 */
-	bo_ptr->tbo.destroy = &amdgpu_bo_vm_destroy;
 	return r;
 }
 
@@ -715,6 +711,8 @@ void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
 
 	mutex_lock(&adev->shadow_list_lock);
 	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
+	vmbo->shadow->parent = amdgpu_bo_ref(&vmbo->bo);
+	vmbo->shadow->tbo.destroy = &amdgpu_bo_vm_destroy;
 	mutex_unlock(&adev->shadow_list_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index df63dc3bca18..051c7194ab4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -564,7 +564,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return r;
 	}
 
-	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
 	amdgpu_bo_add_to_shadow_list(*vmbo);
 
 	return 0;

