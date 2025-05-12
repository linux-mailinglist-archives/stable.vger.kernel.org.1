Return-Path: <stable+bounces-143300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCAAB3D8B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826B717AAEB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C152517AA;
	Mon, 12 May 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kx9w7EQG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2D295DAB
	for <stable@vger.kernel.org>; Mon, 12 May 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066946; cv=none; b=o6Nu6q6nk7IKP8tEqNqE/UyklLfdnBKQ0YCMxJwSqgyXA+dpm4uwwkkJwnoJoxRzLsWR+haF9Rqb3wbU6ydEhe4cB3TDhFexg8i3WwI47cKFn4eB3o9sKqdiLLDoQM4IO/00T2O4U8pnXWI2rEE0ly7hx253FETDq8Bt9stTK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066946; c=relaxed/simple;
	bh=ljitn7k12JH+XcioQ+s2ihOSb+Zm57BLiVKEJ/sDOXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fV4p/y8gdPB6y4VxRlOVP3gCtL8xSqYqKZtSo+sBhlJWzDXJ5v7lzG7wpuXjxyBwz+pkwCE8ZKBB//fhgHyU5dgbEjM+QvWg2b7xI3F5bNgiqxBUVmDs34kAijlyzEaBBXTyHEMs8/WkryjGbqWsPkmMx4BJO71aSroz9uh/pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx9w7EQG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747066945; x=1778602945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljitn7k12JH+XcioQ+s2ihOSb+Zm57BLiVKEJ/sDOXE=;
  b=Kx9w7EQGJoxOcdEuIZfP1j7884/JE1GRvwsimQraTWNykcVHLwckNgUV
   GyADK1snwGX8F118YI7oRIv2eXDfONnDpe0ir0zDbRxzqeeoOsKCdaTvN
   D61HrsTSJbrV4ucwJIaTl1SHIWC11zdQGVmtbiw5QsmMDvnIv00ICYAV6
   W2TCNiWIsZMyo/skq4QQac3Byv2fXBwgDMfz6CDueY/mkRg3jK/OWLWNk
   jl2j6/ELJ8Bi+fM+wjuBdfcyX9AmR3KhH9wER/0FjMoqI0uGotzqcOfLj
   WfZQlMNzER2D3EesX5s9ZzGimo7FUzM5bkBznEuedy0nTE0cU+WohjOEl
   Q==;
X-CSE-ConnectionGUID: 8IwHhGdlSIuW34uGNeGjsg==
X-CSE-MsgGUID: 7aVdld7lQE+cEoJLedUkgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59508081"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59508081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 09:22:25 -0700
X-CSE-ConnectionGUID: nhIquoZqTCKUBNHvACMZPA==
X-CSE-MsgGUID: AewYZs1yRVuM3Ab4nS6fZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="142532696"
Received: from unknown (HELO himal-Super-Server.iind.intel.com) ([10.190.239.34])
  by orviesa005.jf.intel.com with ESMTP; 12 May 2025 09:22:23 -0700
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	stable@vger.kernel.org,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH v8 04/20] drm/xe: Timeslice GPU on atomic SVM fault
Date: Mon, 12 May 2025 22:17:24 +0530
Message-Id: <20250512164740.466852-5-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
References: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

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
---
 drivers/gpu/drm/xe/xe_svm.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.34.1


