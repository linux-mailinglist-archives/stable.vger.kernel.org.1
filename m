Return-Path: <stable+bounces-88094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6B9AEB3C
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101C82856C7
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E81EABDB;
	Thu, 24 Oct 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAZcTOyd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A7156C74
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785631; cv=none; b=aLlcJnZ5E7BH+GDB1YlTjPjHu3NYJVc9ZhsH570xQp4eLo5SHO1pjEF3BzMMs08wC+pBvhEl1urpnAAJJiCey/gPXPp6yYwd51flX/PUwxJCgK2OB+beQZf9a1M8GPyUPeY2Fq3qPEm7//Gph+AyS964da5IdVJXcHapuTskC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785631; c=relaxed/simple;
	bh=HdD6LFiCfxFHCFx4F91EgQcK3pcUN0AemqdP0RklwX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PInGqzCCZ/hUD4ByatVspAz+CHXDbpsRRQ8V5J+o3T3L7/5lIWCX7hhD8BuP38q2SQMOweZdLhPlj0KDVHjy1JPg491Rh0NnwB+tYkPopTMuSBbIz7tARAmrW9saTHTzTsy7G4GNRczM1n9H/1yMENXMLM+RrdoRqSy2aDFNDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAZcTOyd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729785629; x=1761321629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HdD6LFiCfxFHCFx4F91EgQcK3pcUN0AemqdP0RklwX0=;
  b=VAZcTOydp16Y0cb01j7KIf5+0iJgi34M+IaL2YW9q/T51kb2MRExxOVu
   EhCl494OROm1sVuYvebUi7uRw4LevgJgyDttd9mfLqpaNmMM+yFiM9eBe
   Er6kTN0XIQRa6AJxXziM/ncmm8xDcKLPqWQ64Tde4U7ZxPhVrgJjOKRXS
   hII0JUyf7dV1aaEmijrrrAXOSpgWBMX6vQnFU+X6ml+xweRyM8ZtZHeke
   ddBYjjjEH9PkW2f57SSIJzVAgDIKAbCIawzuU3N1T9NmiycG/Km4HQn6l
   EUh/I8263l15zUd5YLuvwVLkuiQVFrns7d5g8kyFA8S7ALgxCde1bd9kd
   w==;
X-CSE-ConnectionGUID: S0BgnPuYSdaiZksiJ1yxzA==
X-CSE-MsgGUID: Fe3vl68tR0yJp/v5wY3vzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33331268"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33331268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:00:19 -0700
X-CSE-ConnectionGUID: pD0LmetCTleqkcJL+jaFqQ==
X-CSE-MsgGUID: 6ElvGkYiTwmk6LjakkP0Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85415741"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:00:16 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
Date: Thu, 24 Oct 2024 17:18:15 +0200
Message-ID: <20241024151815.929142-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to the recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is E core
scheduling fix.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index f5deb81eba01..78a0ad3c78fe 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -13,6 +13,7 @@
 #include "xe_device.h"
 #include "xe_gt.h"
 #include "xe_macros.h"
+#include "compat-i915-headers/i915_drv.h"
 #include "xe_exec_queue.h"
 
 static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
@@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			if (IS_LUNARLAKE(xe)) {
+				/*
+				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
+				 * worker in case of g2h response timeout")
+				 *
+				 * TODO: Drop this change once workqueue scheduling delay issue is
+				 * fixed on LNL Hybrid CPU.
+				 */
+				flush_workqueue(xe->ordered_wq);
+				err = do_compare(addr, args->value, args->mask, args->op);
+				if (err <= 0)
+					break;
+			}
 			err = -ETIME;
 			break;
 		}
-- 
2.46.0


