Return-Path: <stable+bounces-77083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8F98537D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C3F1C2311E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E25156220;
	Wed, 25 Sep 2024 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijrXJEzo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B448132103
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248484; cv=none; b=ll8g8R7gC94IaVBeJlED8sdh+VHcWAgI/eeRU6biwlfBYCEQF6tdpUnGSlNKkQtjC2O0LW536iYTxP95kx6X7xBntcoY8eYGF3nG4imtFzjEXUc3LemKeHnisU+ZFwyZ2poSeXO7Yg7KYkb5GLy0ivXRIZ8POxbGkdDuz35mIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248484; c=relaxed/simple;
	bh=RQewIJ5jgRSChN9kL832GTgVw+SPwAtAdiiaLGzOHtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuEKFRK6vtMHgGNms9Y1IEUUEQGxQssu71T4CDYIb8NeGPvcwGSONGnUF4jTFcM+2blKHF2pfFb4hLAsj7dvZDvm3N3EZ1rlQP+HdI0uav5C05jbbgiUQcY0Cw0nQaSK0y/kaQoaJSzOhnf4eDg0RUlCnEEK+ZRAVPWEpp+eZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijrXJEzo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727248483; x=1758784483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RQewIJ5jgRSChN9kL832GTgVw+SPwAtAdiiaLGzOHtM=;
  b=ijrXJEzokBEvOx9YuOKtspxl4sq3DBYZ7VjEB1+aTCAppdtknZCNs9Nb
   D7mqJkaYas9mWo4LR4bfbYHaRw4pqpGPlF5gt2Z+Hh2S8ug+iqCf94KWW
   PfkeLFTO186b7eNhMJ2lVHuXjiRerakFE4TGsti2qkpVm0OC7rd5Sflut
   vOHuRjBULyPpaCyVi981zBlENuekbBTpRoCyjDvtYQImiebIs+baFLtrj
   NtYKFRlPczdtZvXs4F6goI7j0rjmuKaavXzOawTZqX11K51MMOklBrozB
   TfnVEytuxfFsILYw0ZgCflcW3CsIp+TSLC5BnkxtXLtcRJPDDKV0OWX4P
   Q==;
X-CSE-ConnectionGUID: +G12KtWcSeCTS7EDFmsmUQ==
X-CSE-MsgGUID: F8oeZ3tHSz63qzZc3PkeiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43799266"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="43799266"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:14:42 -0700
X-CSE-ConnectionGUID: Lnf2aRSkSzyoV37u0Q2UCA==
X-CSE-MsgGUID: SRW01/YcTWeTyHHXvP+Zjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76185436"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:14:41 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/xe/vm: move xa_alloc to prevent UAF
Date: Wed, 25 Sep 2024 08:14:27 +0100
Message-ID: <20240925071426.144015-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/xe/xe_vm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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
 
-- 
2.46.1


