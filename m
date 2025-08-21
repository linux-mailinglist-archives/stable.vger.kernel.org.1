Return-Path: <stable+bounces-172145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02BB2FD15
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FED3B51BC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8C192598;
	Thu, 21 Aug 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0EW3mvso"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037C2EC572
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786946; cv=none; b=WJiuMTRssS9NRrCQn0VF8Usa3gdS/G4Ahm9KjbihCQmGWwphYwkx2Vtw5z7t7D1N5y/pGjD4/ArYJNnZVU9ceVG7M5pF/jK+CnkFHgZU/IhLSOe6j8USfnadspw8meihOucghGDCVMi/+/Ys2AKyUNgtwszQbGD8qBWoOsgDLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786946; c=relaxed/simple;
	bh=L4f/A+GW6XcthwJY7m0cdJ2c/uh3OOTfICWWvouj+/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DhzyxlsFTXHHuxz3yN0aG08m2nvHNDJC00m4ogL4LimuILiywqBwmGBWyqEUkV1wc2903mB9Yo9S+ESADo6tbNLTz3Zjpdba8kuOUti7B99BSQ81VT6CFUxcKhK7UnRKWJUWv5QXUvbBStn12yZEBiOUcKm5sdtzA488YfaXbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0EW3mvso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D19C4CEEB;
	Thu, 21 Aug 2025 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786946;
	bh=L4f/A+GW6XcthwJY7m0cdJ2c/uh3OOTfICWWvouj+/E=;
	h=Subject:To:Cc:From:Date:From;
	b=0EW3mvsoYnKM8t1gYbnhKXQA3knOYAm7WFdOEro3OJlEpbSqkNIp4a+g+QITYyqRD
	 SfihAnlGvRf/Pws/GceD+wRWoXJqjWKCDpdneNlF6ED1rKWxu+2iV8DEi1cEre2xmZ
	 uJd+Jgz0lVOcA3cZfKzA6DifK0CnmRv5Glewh2Tc=
Subject: FAILED: patch "[PATCH] drm/xe: Timeslice GPU on atomic SVM fault" failed to apply to 6.16-stable tree
To: matthew.brost@intel.com,himal.prasad.ghimiray@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:35:26 +0200
Message-ID: <2025082126-playable-viewer-a6f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x a5d8d3be1dea8154edbbea481081469627665659
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082126-playable-viewer-a6f2@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5d8d3be1dea8154edbbea481081469627665659 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Mon, 12 May 2025 06:54:58 -0700
Subject: [PATCH] drm/xe: Timeslice GPU on atomic SVM fault

Ensure GPU can make forward progress on an atomic SVM GPU fault by
giving the GPU a timeslice of 5ms

v2:
 - Reduce timeslice to 5ms
 - Double timeslice on retry
 - Split out GPU SVM changes into independent patch
v5:
 - Double timeslice in a few more places

Fixes: 2f118c949160 ("drm/xe: Add SVM VRAM migration")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://lore.kernel.org/r/20250512135500.1405019-5-matthew.brost@intel.com

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index d8e15259a8df..d934df622276 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -797,6 +797,8 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR) ? SZ_64K : 0,
 		.devmem_only = atomic && IS_DGFX(vm->xe) &&
 			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
+		.timeslice_ms = atomic && IS_DGFX(vm->xe) &&
+			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR) ? 5 : 0,
 	};
 	struct xe_svm_range *range;
 	struct drm_gpusvm_range *r;
@@ -836,6 +838,7 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	if (--migrate_try_count >= 0 &&
 	    xe_svm_range_needs_migrate_to_vram(range, vma)) {
 		err = xe_svm_alloc_vram(vm, tile, range, &ctx);
+		ctx.timeslice_ms <<= 1;	/* Double timeslice if we have to retry */
 		if (err) {
 			if (migrate_try_count || !ctx.devmem_only) {
 				drm_dbg(&vm->xe->drm,
@@ -855,6 +858,7 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, r, &ctx);
 	/* Corner where CPU mappings have changed */
 	if (err == -EOPNOTSUPP || err == -EFAULT || err == -EPERM) {
+		ctx.timeslice_ms <<= 1;	/* Double timeslice if we have to retry */
 		if (migrate_try_count > 0 || !ctx.devmem_only) {
 			if (err == -EOPNOTSUPP) {
 				range_debug(range, "PAGE FAULT - EVICT PAGES");
@@ -894,6 +898,7 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 			drm_exec_fini(&exec);
 			err = PTR_ERR(fence);
 			if (err == -EAGAIN) {
+				ctx.timeslice_ms <<= 1;	/* Double timeslice if we have to retry */
 				range_debug(range, "PAGE FAULT - RETRY BIND");
 				goto retry;
 			}


