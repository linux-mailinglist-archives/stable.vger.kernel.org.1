Return-Path: <stable+bounces-76899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887F97EBEF
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE311C2159B
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBF1990D2;
	Mon, 23 Sep 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejB41VDB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFB80C0C
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096330; cv=none; b=J139KPRUg1sOT8KsEKnsN7+APUpqdwvRiU51NL/ihHL2CkgwmBRe4Z6+v8lgIn5rqCDMfjmj4+6jcQB94gj//iyQatyD91zquc2weUWTd6zBAtL5MdhCWxQaDSQlMzirnOR3B7DrD+j77xki2k8Lgy7SgvGj3J0u/hCcHdFe/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096330; c=relaxed/simple;
	bh=7ngXVKCh1STEoKdjuAOoCj9RlsZ6ADtQyYwb6tD4Mbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHT6C0vgjz8/POzP9o9e7USiHai6oXTmvVrxQkx8DEAoPsSPNaUXbmU2o2mtqtURCr8dK2MZ3pY1VIB3LnHq2pwGm9Xn/i0NaxKzvh2Zkj9ZE2ME4BSEvDzaxIQCWx7PhLj7bG0bFRlg1m25rX2/9bY+xUy4tAvlOzRgIredPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejB41VDB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727096329; x=1758632329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ngXVKCh1STEoKdjuAOoCj9RlsZ6ADtQyYwb6tD4Mbc=;
  b=ejB41VDBu7Oa3RsAxPY9nzC+qCHvFpkHX1CSZFZurmEVCcIj0kpJxqtw
   80Yc6w21RlsZ+8WTwuiMF4tBPL8a0tN+kCOD97n9cP9RkJLCSDWn4MsWU
   YQ/hJtBAo0jJQk/y6SR0/vVDd592Ro4cVD4Wb4CMJWy5RGCELCQegE26p
   n0JzWE52QEdT1j7ky8Rr8g1jr99lTekVi07LbB3iI4bPE1/5fGk8yCEKN
   EoKGxWFmc7COYVkmPC889JNxgcpqblXGqnYbb9EQL6feZw3wrsIzBcigI
   A6Cix9I5ddB9IqP2sLyD7+R5l5EK3jbUT6705Kw9ajg2saVUHcmq0hhiU
   A==;
X-CSE-ConnectionGUID: 61Z91eMEQWK/kjl8ewIxOg==
X-CSE-MsgGUID: iUWY6ZycRhKyBkbL00XGbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26160077"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26160077"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:58:48 -0700
X-CSE-ConnectionGUID: sT2NRJGUQ0aUlw57rsAdgA==
X-CSE-MsgGUID: OgUZrcsQQX2m+dweGYqBWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="101910403"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:58:46 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/vm: move xa_alloc to prevent UAF
Date: Mon, 23 Sep 2024 13:57:34 +0100
Message-ID: <20240923125733.62883-3-matthew.auld@intel.com>
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

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a3d7cb7cfd22..f7182ef3d8e6 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1765,12 +1765,6 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(vm))
 		return PTR_ERR(vm);
 
-	mutex_lock(&xef->vm.lock);
-	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
-	mutex_unlock(&xef->vm.lock);
-	if (err)
-		goto err_close_and_put;
-
 	if (xe->info.has_asid) {
 		down_write(&xe->usm.lock);
 		err = xa_alloc_cyclic(&xe->usm.asid_to_vm, &asid, vm,
@@ -1778,12 +1772,11 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
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
@@ -1796,12 +1789,17 @@ int xe_vm_create_ioctl(struct drm_device *dev, void *data,
 	args->reserved[0] = xe_bo_main_addr(vm->pt_root[0]->bo, XE_PAGE_SIZE);
 #endif
 
-	return 0;
-
-err_free_id:
+	/* user id alloc must always be last in ioctl to prevent UAF */
 	mutex_lock(&xef->vm.lock);
-	xa_erase(&xef->vm.xa, id);
+	err = xa_alloc(&xef->vm.xa, &id, vm, xa_limit_32b, GFP_KERNEL);
 	mutex_unlock(&xef->vm.lock);
+	if (err)
+		goto err_close_and_put;
+
+	args->vm_id = id;
+
+	return 0;
+
 err_close_and_put:
 	xe_vm_close_and_put(vm);
 
-- 
2.46.1


