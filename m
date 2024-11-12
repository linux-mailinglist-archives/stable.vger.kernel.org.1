Return-Path: <stable+bounces-92813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CD9C5E9B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC5EB3B089
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB09205AD3;
	Tue, 12 Nov 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNBbbovk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E18205ABD
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428939; cv=none; b=arwNE3wL3saU0F16T0miYnRQiJO3oombz9SF+RzCs4vInSS4SEkbE9BavMxUctoZTJIlm0i2Ujgeth2Z8pXoz8wOA/IQXN8fs9SDcU6LKTFmMY+ecp4Wsi8+PoG6gty6VR1o+nuEOk8G31wRIMuFyqDT95CGQIf4VQSc4jAe59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428939; c=relaxed/simple;
	bh=pOVFdoX3ulHpIm1jNjxVJrGgtQT39JIvGrtrwxVvTn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxmwkG9qKF5nj0EVb8XBnNI5QmIjWcY85E271DYrIy54gKfvlTwO8BSPMCKzH72TDi/92Sm+u1qThBLxQvjr/hPgIP4WYb2LwYaCpKLFaxmNKm1bPeefodjYLKF+0L2zXvGaBPoYQJinWk1D8QwGSLFpfFwdbQB62fqgK8OqoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNBbbovk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731428938; x=1762964938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pOVFdoX3ulHpIm1jNjxVJrGgtQT39JIvGrtrwxVvTn4=;
  b=kNBbbovktNU0G2OjVto0zY1nTFmsHomw10cMLUNKA+6nk/usb3KhhX18
   WXVX9T9KZJqzdkUTsDsOp5H6gAiIXtpOkbniNCCLb4oa9uBuFFsQRNe2k
   zUaCSJ5F1Vtn78LaPC0cLBL5fo1eDy0zhAGPQmERrFPF/cRUBmwqCL+Me
   Ryy/WzVfdfVl/RDNtOUmVMoHmEB+A6xABfggZDEeQbUsGnZwxI+NPQXVc
   hevW1hP7qJScs4JUY33k2cM2cWzCG157iiZWRDi2D5hRScuGAprR9e9oi
   sNsF+sa6UAOO1OhROH5KBbgFlW/ROKJi7u5sw6NMsmg0FcMgZeEFnWCFM
   Q==;
X-CSE-ConnectionGUID: Q5URhlMNQ6e9DxnnvJIORw==
X-CSE-MsgGUID: ntO4HXopQ/OhstlrFCgX4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18885805"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="18885805"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:28:57 -0800
X-CSE-ConnectionGUID: JgTfpxVVTHOUQiW4HQ5zJA==
X-CSE-MsgGUID: SKKfsjRESfutujfplQM3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="91580629"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.231])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:28:56 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: handle flat ccs during hibernation on igpu
Date: Tue, 12 Nov 2024 16:28:28 +0000
Message-ID: <20241112162827.116523-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from LNL, CCS has moved over to flat CCS model where there is
now dedicated memory reserved for storing compression state. On
platforms like LNL this reserved memory lives inside graphics stolen
memory, which is not treated like normal RAM and is therefore skipped by
the core kernel when creating the hibernation image. Currently if
something was compressed and we enter hibernation all the corresponding
CCS state is lost on such HW, resulting in corrupted memory. To fix this
evict user buffers from TT -> SYSTEM to ensure we take a snapshot of the
raw CCS state when entering hibernation, where upon resuming we can
restore the raw CCS state back when next validating the buffer. This has
been confirmed to fix display corruption on LNL when coming back from
hibernation.

Fixes: cbdc52c11c9b ("drm/xe/xe2: Support flat ccs")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3409
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_bo_evict.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index b01bc20eb90b..8fb2be061003 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -35,10 +35,21 @@ int xe_bo_evict_all(struct xe_device *xe)
 	int ret;
 
 	/* User memory */
-	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
+	for (mem_type = XE_PL_TT; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		struct ttm_resource_manager *man =
 			ttm_manager_type(bdev, mem_type);
 
+		/*
+		 * On igpu platforms with flat CCS we need to ensure we save and restore any CCS
+		 * state since this state lives inside graphics stolen memory which doesn't survive
+		 * hibernation.
+		 *
+		 * This can be further improved by only evicting objects that we know have actually
+		 * used a compression enabled PAT index.
+		 */
+		if (mem_type == XE_PL_TT && (IS_DGFX(xe) || !xe_device_has_flat_ccs(xe)))
+			continue;
+
 		if (man) {
 			ret = ttm_resource_manager_evict_all(bdev, man);
 			if (ret)
-- 
2.47.0


