Return-Path: <stable+bounces-65543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB694A966
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D601C2048A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF721373;
	Wed,  7 Aug 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8EBMkxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302551DDEB
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039647; cv=none; b=sIsWkQ0mN0XWB5Uvl6VxDBVylfSIS3aYZ8nxqwRl8B6+87bOIWMN/z6J6TregfZeBVP3dQXoJSbOb1nLCuVxN9TYpTzw2cvTaKnnVkGsyot0JTo20gwhbwI4Cg52fnUax4/j1M7RcM2l5Pn+rA12iPVKwi/8UF6nZx8TIJQHHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039647; c=relaxed/simple;
	bh=TmMMJG8j+sbVRXyKL+2g7LPwPzmnbhBQCKaBJFoAGb0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JJZyy14H27BnTi46RLYQ7gkmzEMVp1PdozH5lehPyHuhhqmAUMxcc7cZjFGpG8pkDy5p5vFq4tyTClGInGDyPmng3hA88VJPFGbdAbXctH4PilQgCs2h2wGOICH7ksD+IGETyMdcgT/I78nQHjT1jUHHchJq4Rfyhn/hBe8KVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8EBMkxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2642C32782;
	Wed,  7 Aug 2024 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039647;
	bh=TmMMJG8j+sbVRXyKL+2g7LPwPzmnbhBQCKaBJFoAGb0=;
	h=Subject:To:Cc:From:Date:From;
	b=S8EBMkxFPdWOo80lZDsp5GgvCUj9uQHFv+IXUCpfiQEst3OS6kE9BpMvRRa4nEoNf
	 Lq4yC6fwxhlkliNkuBuTbFtoN1TvwNteNkGmSG6GdwSVfQBrLp1S/ltSW8ojg2JKj4
	 11mUQE3woachRdWpomOBA3izG1nFU1xbPOIcNtjs=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Fix a deadlock in dma buf fence polling" failed to apply to 5.10-stable tree
To: zack.rusin@broadcom.com,bcm-kernel-feedback-list@broadcom.com,maaz.mombasawala@broadcom.com,martin.krastev@broadcom.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:07:23 +0200
Message-ID: <2024080723-snowy-luxury-099a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e58337100721f3cc0c7424a18730e4f39844934f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080723-snowy-luxury-099a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

e58337100721 ("drm/vmwgfx: Fix a deadlock in dma buf fence polling")
c6771b6338c8 ("drm/vmwgfx/vmwgfx_fence: Add, remove and demote various documentation params/headers")
be4f77ac6884 ("drm/vmwgfx: Cleanup fifo mmio handling")
840462e6872d ("drm/vmwgfx: Remove references to struct drm_device.pdev")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e58337100721f3cc0c7424a18730e4f39844934f Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 22 Jul 2024 14:41:13 -0400
Subject: [PATCH] drm/vmwgfx: Fix a deadlock in dma buf fence polling

Introduce a version of the fence ops that on release doesn't remove
the fence from the pending list, and thus doesn't require a lock to
fix poll->fence wait->fence unref deadlocks.

vmwgfx overwrites the wait callback to iterate over the list of all
fences and update their status, to do that it holds a lock to prevent
the list modifcations from other threads. The fence destroy callback
both deletes the fence and removes it from the list of pending
fences, for which it holds a lock.

dma buf polling cb unrefs a fence after it's been signaled: so the poll
calls the wait, which signals the fences, which are being destroyed.
The destruction tries to acquire the lock on the pending fences list
which it can never get because it's held by the wait from which it
was called.

Old bug, but not a lot of userspace apps were using dma-buf polling
interfaces. Fix those, in particular this fixes KDE stalls/deadlock.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 2298e804e96e ("drm/vmwgfx: rework to new fence interface, v2")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.2+
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240722184313.181318-2-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 5efc6a766f64..588d50ababf6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -124,13 +123,13 @@ static void vmw_fence_obj_destroy(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
-
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
-	spin_lock(&fman->lock);
-	list_del_init(&fence->head);
-	--fman->num_fence_objects;
-	spin_unlock(&fman->lock);
+	if (!list_empty(&fence->head)) {
+		spin_lock(&fman->lock);
+		list_del_init(&fence->head);
+		spin_unlock(&fman->lock);
+	}
 	fence->destroy(fence);
 }
 
@@ -257,7 +256,6 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
-
 /*
  * Execute signal actions on fences recently signaled.
  * This is done from a workqueue so we don't have to execute
@@ -355,7 +353,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -403,7 +400,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 				      u32 passed_seqno)
 {
 	u32 goal_seqno;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -413,7 +410,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_fence_goal_write(fman->dev_priv,


