Return-Path: <stable+bounces-81461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E6993546
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB5283AE2
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF351D2229;
	Mon,  7 Oct 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i2H2K4ji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8C1DA26
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323140; cv=none; b=PMculSzdoeU5+GqAum+vftzObpwb45B32/N2HSiTvW7GF8ZwZeASXVNhEMvNjWhZ22pEXt7SBv24Tqf6oKeQn7AoIcsKokUbJGM5ylJ6P1AQqaGA1gzYNNHxBFMNUIUuqVn+1MmAl0MEjrRAjfO4YP8srinenAiO4IZiqrBXKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323140; c=relaxed/simple;
	bh=KzZ8awnflIgbaqgxsf5+bgT02mNzjGZAZZkNAU9okfo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jQGQPzGBGbCJ2uWubTrYOQyzjloQq8+FZ/AUgt55J1KH3gOedRM0WDf1xZnPHYW14tFAJ/WRSUAOhNPwOpZjN4kCz8wdwmqZH4d18zC7hlyfcCoC73IGUBQsmZrhdJEExDNzaGMn1/Pjg6kA8vAGcNr0GSC/ExVx6slc9hSC7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i2H2K4ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6708CC4CEC6;
	Mon,  7 Oct 2024 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728323139;
	bh=KzZ8awnflIgbaqgxsf5+bgT02mNzjGZAZZkNAU9okfo=;
	h=Subject:To:Cc:From:Date:From;
	b=i2H2K4jiMY2UJihfE5Xixu65PChWXuNw+B+a3pBVZvCS9QThEKqeCHq4mDDiHBHuB
	 wifenw6pvrk2zLDoXa+PNGFWioq1cUIOTi4SfRgNtKk9AQZGkVyvIYOxSRXwWZzu9P
	 4vUvHOjRq153ObQQotOfCMMjvMzVMx3lNb0keZgs=
Subject: FAILED: patch "[PATCH] drm/xe/vm: move xa_alloc to prevent UAF" failed to apply to 6.10-stable tree
To: matthew.auld@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,nirmoy.das@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:45:28 +0200
Message-ID: <2024100728-sectional-bakeshop-2c8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 74231870cf4976f69e83aa24f48edb16619f652f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100728-sectional-bakeshop-2c8c@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

74231870cf49 ("drm/xe/vm: move xa_alloc to prevent UAF")
9e3c85ddea7a ("drm/xe: Clean up VM / exec queue file lock usage.")
2149ded63079 ("drm/xe: Fix use after free when client stats are captured")
a2387e69493d ("drm/xe: Take a ref to xe file when user creates a VM")
3d0c4a62cc55 ("drm/xe: Move part of xe_file cleanup to a helper")
0568a4086a6c ("drm/xe: Remove unwanted mutex locking")
45bb564de0a6 ("drm/xe: Use run_ticks instead of runtime for client stats")
188ced1e0ff8 ("drm/xe/client: Print runtime to fdinfo")
6109f24f87d7 ("drm/xe: Add helper to accumulate exec queue runtime")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74231870cf4976f69e83aa24f48edb16619f652f Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Wed, 25 Sep 2024 08:14:27 +0100
Subject: [PATCH] drm/xe/vm: move xa_alloc to prevent UAF

Evil user can guess the next id of the vm before the ioctl completes and
then call vm destroy ioctl to trigger UAF since create ioctl is still
referencing the same vm. Move the xa_alloc all the way to the end to
prevent this.

v2:
 - Rebase

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240925071426.144015-3-matthew.auld@intel.com
(cherry picked from commit dcfd3971327f3ee92765154baebbaece833d3ca9)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 31fe31db3fdc..ce9dca4d4e87 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1765,10 +1765,6 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(vm))
 		return PTR_ERR(vm);
 
-	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
-	if (err)
-		goto err_close_and_put;
-
 	if (xe->info.has_asid) {
 		down_write(&xe->usm.lock);
 		err = xa_alloc_cyclic(&xe->usm.asid_to_vm, &asid, vm,
@@ -1776,12 +1772,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 				      &xe->usm.next_asid, GFP_KERNEL);
 		up_write(&xe->usm.lock);
 		if (err < 0)
-			goto err_free_id;
+			goto err_close_and_put;
 
 		vm->usm.asid = asid;
 	}
 
-	args->vm_id = id;
 	vm->xef = xe_file_get(xef);
 
 	/* Record BO memory for VM pagetable created against client */
@@ -1794,10 +1789,15 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
 #endif
 
+	/* user id alloc must always be last in ioctl to prevent UAF */
+	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
+	if (err)
+		goto err_close_and_put;
+
+	args->vm_id = id;
+
 	return 0;
 
-err_free_id:
-	xa_erase(&xef->vm.xa, id);
 err_close_and_put:
 	xe_vm_close_and_put(vm);
 


