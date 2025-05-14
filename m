Return-Path: <stable+bounces-144390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED4AB6FBE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E0316414B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6D183098;
	Wed, 14 May 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1EvO4T2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267F125B2
	for <stable@vger.kernel.org>; Wed, 14 May 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236290; cv=none; b=pZ5k3R7xgsOMxBdq3X++Kou88kRNaRZO/okd/zG92UP9mhJKIvVyfOZekrhE7XhL3cvn3l+FwjDs+MhWyeFCKv0Cjdclw+MbNSH1DCfmeCrcUxj7JCLBiB5wmJRBynysZdi2UTnrjwarDXbFM2gxCSddS8JwsQJOgJhMKwCQBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236290; c=relaxed/simple;
	bh=sAVwxiUHyCySCQN0fWXiDUop9GOm/rUWMpBSoMI8+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIsnAgCbayptMVfNkWPkic/eI9y8UYRsfz2oVCuVbIakgp0p0qSUPIQu5Ab8rKdw3jph8mqIReeBIfwwchHXGTAitCrrquPvg8v2DvH/0CrllHdlWZ2mWsb9/zOPfsLw6VwKo7h498dgyMU+WtrCSckNPtir9pkmMktoIbgfrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1EvO4T2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747236289; x=1778772289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAVwxiUHyCySCQN0fWXiDUop9GOm/rUWMpBSoMI8+zQ=;
  b=Z1EvO4T28oayE/Zi783XjE0cGoiWHBeKfi0MeHQVaIloAL2ie0nhPlju
   w4fpnhQh9/pB3IVfSOrquIJ+TRlSJXnx1fae6Tzj/ejUiw6OdE2Nf3kOa
   8WnRTY0IFWtwpMtmkxCRF0iQmTYCRYMYP2z/0Mif43eywdZt4omLNMya0
   Llf2Cqx4Gzqn1LnpNhdgw0gwnjkxVkfIdLThXSKmg6ICngYpctVDHsGuE
   4J0Rw3DlncpMe9n5ows1C6pce000HxdK7iMNa3UvOJFIFRDXI+voXbNQX
   rqCZASth9q4H47H7DTuWcQvxWw2AlkjIZ58OPNAv3ekH60mlxEIStvv+m
   w==;
X-CSE-ConnectionGUID: SDyvL1jNRJWoqMdfkZlxCQ==
X-CSE-MsgGUID: FTwrm/T2T7C0Ds9TJB3E/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60149642"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="60149642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:24:48 -0700
X-CSE-ConnectionGUID: 1qjkFXIyTSOLBPdPv2OxZw==
X-CSE-MsgGUID: Zu94Yn8CTUy00v9Ich4EbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="137949208"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:24:47 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/vm: move rebind_work init earlier
Date: Wed, 14 May 2025 16:24:25 +0100
Message-ID: <20250514152424.149591-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xe_vm_close_and_put() we need to be able to call
flush_work(rebind_work), however during vm creation we can call this on
the error path, before having actually set up the worker, leading to a
splat from flush_work().

It looks like we can simply move the worker init step earlier to fix
this.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5a978da411b0..168756fb140b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1704,8 +1704,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
 	 * scheduler drops all the references of it, hence protecting the VM
 	 * for this case is necessary.
 	 */
-	if (flags & XE_VM_FLAG_LR_MODE)
+	if (flags & XE_VM_FLAG_LR_MODE) {
+		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
 		xe_pm_runtime_get_noresume(xe);
+	}
 
 	vm_resv_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
 	if (!vm_resv_obj) {
@@ -1750,10 +1752,8 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
 		vm->batch_invalidate_tlb = true;
 	}
 
-	if (vm->flags & XE_VM_FLAG_LR_MODE) {
-		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
+	if (vm->flags & XE_VM_FLAG_LR_MODE)
 		vm->batch_invalidate_tlb = false;
-	}
 
 	/* Fill pt_root after allocating scratch tables */
 	for_each_tile(tile, xe, id) {
-- 
2.49.0


