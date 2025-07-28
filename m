Return-Path: <stable+bounces-164908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A793FB139E9
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5AF16AEF5
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE37425C70C;
	Mon, 28 Jul 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrsbhRVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CE18FDBE
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702413; cv=none; b=jEItkLMcV8OR52iJw8bMhzySOdnytX5ocG7QiUEi7EgQcGJo3/k+mRhtMs5Jv8UL6B5UDpwr1vRqO1w2uqSJ1qRqQVDb9NjVG2aCxm9i06STouUt9Ww5CBRrG3a+5TGCIQPBdsBBCnhqX57rh4puh5bvxXzPvxkiPiwxJziU724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702413; c=relaxed/simple;
	bh=yIj5CX5I8PCMf+IFW7nTZRqz5/2TXFP3P+go8hc2a5Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G48z28VKMdAQzApCFxaVC+b1fHNt0wmdPd/ki/bRY3QK+8syl2KfnBQ36BdhWMtrg5F2XeWH3TAmAC66m6lUqDqx+9z07C5AXO5y2X0alIG3XK3qthiH2glxyExlwooZlv4SzmtTzIrRU/YYbb1Th+Ut8MoUYvAgmOZZeMgcUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrsbhRVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96263C4CEE7;
	Mon, 28 Jul 2025 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753702413;
	bh=yIj5CX5I8PCMf+IFW7nTZRqz5/2TXFP3P+go8hc2a5Y=;
	h=Subject:To:Cc:From:Date:From;
	b=IrsbhRVPP+0LDYcnVAG/Mv+9LXGEjVLgojSzsaC4wNCYZ9fnkfLztV97nk8Lg5AC4
	 2Is/NmYli1SM18D97C4Y5F6uITP6jXnszHmnURR2ZHPUnExWWKy+rNvav6M7eMgNkS
	 fNoCxXBTAb54sVDo5pIdwZpN5vK2xWavi6CbpDBQ=
Subject: FAILED: patch "[PATCH] Revert "drm/gem-shmem: Use dma_buf from GEM object instance"" failed to apply to 6.15-stable tree
To: tzimmermann@suse.de,christian.koenig@amd.com,simona.vetter@ffwll.ch,stable@vger.kernel.org,zack.rusin@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 13:33:30 +0200
Message-ID: <2025072830-reveler-drop-down-d571@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6d496e9569983a0d7a05be6661126d0702cf94f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072830-reveler-drop-down-d571@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d496e9569983a0d7a05be6661126d0702cf94f7 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 15 Jul 2025 17:58:16 +0200
Subject: [PATCH] Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 1a148af06000e545e714fe3210af3d77ff903c11.

The dma_buf field in struct drm_gem_object is not stable over the
object instance's lifetime. The field becomes NULL when user space
releases the final GEM handle on the buffer object. This resulted
in a NULL-pointer deref.

Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
Acquire internal references on GEM handles") only solved the problem
partially. They especially don't work for buffer objects without a DRM
framebuffer associated.

Hence, this revert to going back to using .import_attach->dmabuf.

v3:
- cc stable

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: <stable@vger.kernel.org> # v6.15+
Link: https://lore.kernel.org/r/20250715155934.150656-7-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index aa43265f4f4f..a5dbee6974ab 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -349,7 +349,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 	int ret = 0;
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
@@ -409,7 +409,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	struct drm_gem_object *obj = &shmem->base;
 
 	if (drm_gem_is_imported(obj)) {
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 


