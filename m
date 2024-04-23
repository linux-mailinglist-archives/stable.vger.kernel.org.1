Return-Path: <stable+bounces-40686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E828AE773
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60670286EE7
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EC1350CD;
	Tue, 23 Apr 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lEVioWIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F608134CF7
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877688; cv=none; b=Y9wVpg03jW7NAjfOv6nuHxerr8DmZ6gTMQq6xQLSUmIw3v+8mgNsuH/GNuyOxlgeii4HvY8STo38HvQiLoXdIe8Gno/hZ4c4TMsTvgiLjqOto2AdFfiokwX8KMNQJpthXvibtj8tr5H3NuUG2j3XXAVCT2s8fSPmEups//nxjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877688; c=relaxed/simple;
	bh=igF0AdoS8lFRMqE5mrOCHsdbz/qLcX3S6jt2bBfGAe0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iN6wEExin/M5T8Kb5LE/AMH8f2d6ByQyqlvBbsdKYvArWQ/mUhvUm+WR0nolHXcsXasvfG94zmLtMWzGGnmtGiKN7cepzdXki48XrxC5hi+2cf8/Lxbo1Sxd/m1uHLWeljUCHFhWdZJOEGXBcLqYpNCHR+7nJpZ/Mkl2cjDRR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lEVioWIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24183C2BD11;
	Tue, 23 Apr 2024 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877688;
	bh=igF0AdoS8lFRMqE5mrOCHsdbz/qLcX3S6jt2bBfGAe0=;
	h=Subject:To:Cc:From:Date:From;
	b=lEVioWIjaB0nsJdMYOAwiE3U0JpcyxlhXs9rWTn0pfqfq/BBVM8JzfmCJ97Kc3CCB
	 kBSD1oCSEc3vL9pwVz9T8nc6fozVmlNALochcVwPNaEw2556U2pAt6KEjTKxxDy0Ts
	 Xok+GsPKPOn8756rmIGbyfAmQoXjEKVxAR8ERhTk=
Subject: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF with asid based lookup" failed to apply to 6.8-stable tree
To: matthew.auld@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:07:58 -0700
Message-ID: <2024042358-esteemed-fastball-c2d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x ca7c52ac7ad384bcf299d89482c45fec7cd00da9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042358-esteemed-fastball-c2d8@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

ca7c52ac7ad3 ("drm/xe/vm: prevent UAF with asid based lookup")
0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
be7d51c5b468 ("drm/xe: Add batch buffer addresses to devcoredump")
4376cee62092 ("drm/xe: Print more device information in devcoredump")
98fefec8c381 ("drm/xe: Change devcoredump functions parameters to xe_sched_job")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca7c52ac7ad384bcf299d89482c45fec7cd00da9 Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 83967c57320d0d01ae512f10e79213f81e4bf594)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 62d1ef8867a8..3d4c8f342e21 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1577,6 +1577,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
@@ -1592,24 +1602,15 @@ static void vm_destroy_work_func(struct work_struct *w)
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
 


