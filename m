Return-Path: <stable+bounces-207928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695AD0CA93
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2675300B350
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AD2E40E;
	Sat, 10 Jan 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNK6buvt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1419F40B
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006399; cv=none; b=jw6ibzHfmvG0/YG6xS01M3B3DNfv8MoMA2QSjKTDny+grpvPUnhrhlC6GVdK+PXx6xmLhdxxDGYP6GwgaYZ3jXBw8SOMMF5o0EexTRjca334aqT+PqzryMG9kVQW/EceK9w5szjD0EPnYQ5RF9iSp4pR/h5NzVSxoIsAo5gwSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006399; c=relaxed/simple;
	bh=nyAuNPvhGRpmtICy+jxKyQ7niVo4KbREpwwKNoxXQsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/eSgqg66B3cRFjN/9d2UEBkYmTDqmi/vB6cd66EKNRG+OCbMOgL1f0EQO5U+2zGnmNXXuu12ejpTAyh7tHScMPXTI53Np7W9SsfB+VTbXeeqXZKqvR72bQ2+GzIDackY4pFfrSJntLw+EI4WHUmpOKKlQZgF2U9aQBbSRL+SJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNK6buvt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768006398; x=1799542398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyAuNPvhGRpmtICy+jxKyQ7niVo4KbREpwwKNoxXQsk=;
  b=cNK6buvtr03s4EptUHO5RUc5DDUUnAaepPjAE0mIySwalE4/CNsGYszl
   b/Whyo5LIbKYcxbAIY4auFL9SBrX2mI0ufDHDamsoZMKmQ7dpKT9WHcbd
   VAJdHyuLmekPd20XPKCPBRvr6G1BK0fY2ltXy8/oe0gNZckvPptUOuRUG
   8SXDQd+XkPx10Wlw97Qq01V5POVfM4G7icmfXIXK6Wf/WujbGUUx95nZE
   5o+Y+E8KWFFtAC222N0XdCnPJMLIt0CnzAk3CCunPz9kRdZz/BlvYKyx9
   KeEI/gw2mZzoFkLMsIgp8daOeH7ZcDzuIP3x4XoppV1yHA666xaK6OJIS
   Q==;
X-CSE-ConnectionGUID: vyJ6E2hRQ0yi3dKjfDVz2g==
X-CSE-MsgGUID: M3mqJ0RMSyGWHBEYhmQhbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="79683568"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="79683568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 16:53:16 -0800
X-CSE-ConnectionGUID: FF0sD9RwSmOZhfozbRVrdA==
X-CSE-MsgGUID: aJurax8ERwWLBUw2JMwplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="234300472"
Received: from dut6304bmgfrd.fm.intel.com ([10.36.21.42])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2026 16:53:15 -0800
From: Xin Wang <x.wang@intel.com>
To: stable@vger.kernel.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	Xin Wang <x.wang@intel.com>
Subject: [PATCH 6.12 2/2] drm/xe: Ensure GT is in C0 during resumes
Date: Sat, 10 Jan 2026 00:52:46 +0000
Message-ID: <20260110005246.608138-2-x.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110005246.608138-1-x.wang@intel.com>
References: <20260110005246.608138-1-x.wang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 95d0883ac8105717f59c2dcdc0d8b9150f13aa12 ]

This patch ensures the gt will be awake for the entire duration
of the resume sequences until GuCRC takes over and GT-C6 gets
re-enabled.

Before suspending GT-C6 is kept enabled, but upon resume, GuCRC
is not yet alive to properly control the exits and some cases of
instability and corruption related to GT-C6 can be observed.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4037

Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Xin Wang <x.wang@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4037
Link: https://lore.kernel.org/r/20250827000633.1369890-3-x.wang@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 46c73ff10c74..f8fad9e56805 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -17,7 +17,7 @@
 #include "xe_device_sysfs.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
-#include "xe_guc.h"
+#include "xe_gt_idle.h"
 #include "xe_irq.h"
 #include "xe_pcode.h"
 #include "xe_trace.h"
@@ -165,6 +165,9 @@ int xe_pm_resume(struct xe_device *xe)
 	drm_dbg(&xe->drm, "Resuming device\n");
 	trace_xe_pm_resume(xe, __builtin_return_address(0));
 
+	for_each_gt(gt, xe, id)
+		xe_gt_idle_disable_c6(gt);
+
 	for_each_tile(tile, xe, id)
 		xe_wa_apply_tile_workarounds(tile);
 
@@ -451,6 +454,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 
 	xe_rpm_lockmap_acquire(xe);
 
+	for_each_gt(gt, xe, id)
+		xe_gt_idle_disable_c6(gt);
+
 	if (xe->d3cold.allowed) {
 		err = xe_pcode_ready(xe, true);
 		if (err)
-- 
2.43.0


