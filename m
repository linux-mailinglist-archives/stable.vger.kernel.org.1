Return-Path: <stable+bounces-41540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39728B42C1
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 01:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1EC28359F
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7C3839C;
	Fri, 26 Apr 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M91vQ1Xv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048421101
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714174325; cv=none; b=CCnm+5miS9nq91oeTaXNlCUJq4ry+yxQ3ovbJb2PrOH5NTRWq9rVHdQDzyVGBw+Qt+4pRrKQg9mB5LMh8vT40TYPyUdE5E/S6HaG7Tf5s1HULDpg+QYtLN+2Wv82DcWb5PtikRl8u+JZ7TqZo0VC6mf9fITp4Wbh0yqzu9m8mP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714174325; c=relaxed/simple;
	bh=DWZTfiX3kuO6n+/R+6e4hbeu//yI5YH8Pwkk8mqsm/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N+nou3jUdFcLfpp7RXR8RQvT1ryLSsEJs3J7yvTeEcXXMh3MwVxOnMRZcuAgzAH6fUOftDQo9qmwr5HiEbP3VcxvWFV1mIzavEOsSO0NRNxyiB27oAsAzvAvs2xVxA5USYx+2XUVwItIBM8AaIrOc4wMOKPoSBfiO7har2uSz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M91vQ1Xv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714174324; x=1745710324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DWZTfiX3kuO6n+/R+6e4hbeu//yI5YH8Pwkk8mqsm/g=;
  b=M91vQ1XvompaUmf25QE4pDcAfhhboYFHomTR7Thb+BDtPXIuxwL2DVCA
   Thb1lsbO2ouQS/t8c9ZbarS/L2u2zFZg3uXdZ1jc86aci5gd7Cl0MML2K
   EHFMaVSEYOnw+Z4+cVMiiTSRAE6UX+L0FXfQI1xugNty+WTF3vjF2+sXa
   T8FkDXX4EhyM6dBx7ku+LxKtANTu9z3A+PbWYSDNujuS9L/ZyZ/0g60U3
   BQ1xTPvoOPqgMK2fqD9AhZm2eVUVVsai2pv0EEbXP0RcUHd7e+uUhHNos
   UYOFHrQkSMAMOyeQh4PuqU5S/xqNzuKXESAj6qemixMoShPFCxpremLEz
   w==;
X-CSE-ConnectionGUID: ftU8epfuTIOple0CCLXkag==
X-CSE-MsgGUID: o+hAtdrTQla912ngh9XAvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="21333510"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="21333510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:32:04 -0700
X-CSE-ConnectionGUID: hHhcEkHUSsOhYm3fR8lT8w==
X-CSE-MsgGUID: RQEF/hVLRCiEHaa8YsBVcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="63040669"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:32:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Date: Fri, 26 Apr 2024 16:32:36 -0700
Message-Id: <20240426233236.2077378-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To be secure, when a userptr is invalidated the pages should be dma
unmapped ensuring the device can no longer touch the invalidated pages.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user pages")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index dfd31b346021..964a5b4d47d8 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
 		XE_WARN_ON(err);
 	}
 
+	if (userptr->sg)
+		xe_hmm_userptr_free_sg(uvma);
+
 	trace_xe_vma_userptr_invalidate_complete(vma);
 
 	return true;
-- 
2.34.1


