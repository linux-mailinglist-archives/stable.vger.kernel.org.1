Return-Path: <stable+bounces-53713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377AC90E5C6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C911F21EE1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D879DC7;
	Wed, 19 Jun 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdi9Shao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF55FBB1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786209; cv=none; b=XijqXqIKdzKmbFf8EyuWVzg2rzkwjIGKDRXc+PqZwc9OcNyeWLmFbg+9TIaNjS3tuvLxQmWb0zWaTAnRAmAmalUcS3VZnOvsyKdMnpj56FSGrKPGfULKRfkykQxvTY0CRb/i6l6rWV1tHDwBPrLOfTeLPcnRAyr+e6ULXe5VVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786209; c=relaxed/simple;
	bh=pg0PKPtBYpC2lyLxIkRt0SGS/T3JY4qc/kGuqEkVJo0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PVXwdGcMnNaaAgzwVH60cXksKmhuhffBurXAI7M8C0DWOMeq8vMTBu5AJYRRU/mMjDTEKosvT8mCKSD773RKHjiosh92ixZaM7wvj59ix5ID/5BNRpY0vvcEcda7oIKSVgebgJPqefkGzPjEKHfYDMXvhbvEF82DpHN1B4yGhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdi9Shao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440FBC2BBFC;
	Wed, 19 Jun 2024 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786208;
	bh=pg0PKPtBYpC2lyLxIkRt0SGS/T3JY4qc/kGuqEkVJo0=;
	h=Subject:To:Cc:From:Date:From;
	b=mdi9ShaoG/8PhDKgN5U4gsodap5oCkkGShlUFn28IgD0boZ5MDsiUoPg7GFsfSMP+
	 vUeffb3f1n6dbvLoDJQz+Tqf6sgL6jId9cjERPtue4oACG+X+4ztTPF+d/ifz9CGkw
	 b1EBv2aN/OOxXYWGmZmtQ8gw5RmaVsZQVhwTut7c=
Subject: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF with asid based lookup" failed to apply to 6.9-stable tree
To: matthew.auld@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:36:33 +0200
Message-ID: <2024061933-superglue-cadet-4c6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 83967c57320d0d01ae512f10e79213f81e4bf594
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061933-superglue-cadet-4c6e@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

83967c57320d ("drm/xe/vm: prevent UAF with asid based lookup")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83967c57320d0d01ae512f10e79213f81e4bf594 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 12 Apr 2024 12:31:45 +0100
Subject: [PATCH] drm/xe/vm: prevent UAF with asid based lookup

The asid is only erased from the xarray when the vm refcount reaches
zero, however this leads to potential UAF since the xe_vm_get() only
works on a vm with refcount != 0. Since the asid is allocated in the vm
create ioctl, rather erase it when closing the vm, prior to dropping the
potential last ref. This should also work when user closes driver fd
without explicit vm destroy.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240412113144.259426-4-matthew.auld@intel.com

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 2dbba55e7785..b31e263ca754 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1481,6 +1481,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
 		xe->usm.num_vm_in_fault_mode--;
 	else if (!(vm->flags & XE_VM_FLAG_MIGRATION))
 		xe->usm.num_vm_in_non_fault_mode--;
+
+	if (vm->usm.asid) {
+		void *lookup;
+
+		xe_assert(xe, xe->info.has_asid);
+		xe_assert(xe, !(vm->flags & XE_VM_FLAG_MIGRATION));
+
+		lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
+		xe_assert(xe, lookup == vm);
+	}
 	mutex_unlock(&xe->usm.lock);
 
 	for_each_tile(tile, xe, id)
@@ -1496,24 +1506,15 @@ static void vm_destroy_work_func(struct work_struct *w)
 	struct xe_device *xe = vm->xe;
 	struct xe_tile *tile;
 	u8 id;
-	void *lookup;
 
 	/* xe_vm_close_and_put was not called? */
 	xe_assert(xe, !vm->size);
 
 	mutex_destroy(&vm->snap_mutex);
 
-	if (!(vm->flags & XE_VM_FLAG_MIGRATION)) {
+	if (!(vm->flags & XE_VM_FLAG_MIGRATION))
 		xe_device_mem_access_put(xe);
 
-		if (xe->info.has_asid && vm->usm.asid) {
-			mutex_lock(&xe->usm.lock);
-			lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
-			xe_assert(xe, lookup == vm);
-			mutex_unlock(&xe->usm.lock);
-		}
-	}
-
 	for_each_tile(tile, xe, id)
 		XE_WARN_ON(vm->pt_root[id]);
 


