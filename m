Return-Path: <stable+bounces-39303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD58A2D7F
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 13:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC67EB22F8F
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0745491E;
	Fri, 12 Apr 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0/wPPyY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49E54BDE
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921569; cv=none; b=RbXaW+lYsnWU+WBhGW0q1zGe4uZjoAkMB9DChdqn/M4wnA7wCDmj8pq2uOaaaITaHMQDlAWV/gMfV38obNK29XlH+Ug71448dPvjBr2pxaO143YBaSEMscHbH81DiG5tDXb0WPY6nVt2wziVMrLFXs1xznLmHVcDlN1/Fl/bs2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921569; c=relaxed/simple;
	bh=hLwpJPb5tv1oQGYOIy3yt+eib0eFMTwnMVTGMVAEHvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anVdJ6/OdMlHzwam1MkQekjw8TFbEmwLMH56pwO/MCVEGXyXAmuDx6EqPSTR9Ey3KrnPOBvV5gBP7gTWb2rJH6rSwA6PpVSU6mje/6pjhe9RRh9zu8lW0DH4yyJNEe6mg+GOL1lRkSGP/X3JyOwsSDPFwa/Fw/U9P+G3pAB0fs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0/wPPyY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712921568; x=1744457568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hLwpJPb5tv1oQGYOIy3yt+eib0eFMTwnMVTGMVAEHvo=;
  b=S0/wPPyYT5zM7rAeXflvslQvFWHXwTfSSHe1nmazufmqrEaWTnOvsI8h
   qn42rJwRsC4gGRTn9LPhVKZJ+3u92d5inLXIUgK1ZfW9fXIw4EllIIkn2
   SO419w2FyZ7hLhdcBXWWsSnTiuDlRW1onamjBQtrE5IDbc9KNc6uxQxaI
   jfNgPC2wokcAv+1jFETwin4GZEz4efARZ/Mt0JiERfuz1kxadyIDF88VY
   jsN5WBwvQ6uzLNDUtLf75+i1G6GPnItIkR4gRZgAdKOwjLlh5hb95+JXl
   L4kNyXk2F2DeKfLFjZaadF0m1cklaX5RGYa8uT3LepupAipzirimyFTss
   A==;
X-CSE-ConnectionGUID: MfFDCjVhQ3GMwY5ZNqejTA==
X-CSE-MsgGUID: vTp05qWHQcyGXSlUaOy1zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11335422"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="11335422"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 04:32:47 -0700
X-CSE-ConnectionGUID: mOLOzkSWRLWwjzIejiTfHQ==
X-CSE-MsgGUID: nR3xZK0GTb6kn+6NDBMGeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21272574"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 04:32:46 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/xe/vm: prevent UAF with asid based lookup
Date: Fri, 12 Apr 2024 12:31:45 +0100
Message-ID: <20240412113144.259426-4-matthew.auld@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a196dbe65252..c5c26b3d1b76 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1581,6 +1581,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
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
@@ -1596,24 +1606,15 @@ static void vm_destroy_work_func(struct work_struct *w)
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
 
-- 
2.44.0


