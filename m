Return-Path: <stable+bounces-201119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B465CC04A3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 01:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EB230145AD
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDD33EC;
	Tue, 16 Dec 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4jxy5Kw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0F3B8D52
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 00:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765843349; cv=none; b=E5S21B4UdiAD+tmYgPlZI8YF9DPrAzOcgsytb/zCgG1uwB0sf+gtzv79wFiiWur6Pk5I1SmaI1q3Zz9qlmlyK5xajI+plkS5mDMi+eq9qsTnR7AUcOkjEeIlAeMJolvyFjdRwOiwL4QCi6PafTGCL/e1o1W9iGPszMNvqOe1Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765843349; c=relaxed/simple;
	bh=IfxLDcruypX4wrf69FrOY+iSzEbJu1dEvy47POZPvko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvaK2af0tVZWQrYUKxVIXepmpdTbWdZliOziWI0Mvt0MixnJbHzguXqHLQ4gKKTiPLtMTkSo00LXeC2Pg2/L/d1WpSoeD/Z1vL5fi27FM3aB6Tn9HMyo4a2MFqocm/Bpah2RK+Ld6fbQCa1IsIjhU/FI4Q6cdIKCexFB6v+dLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4jxy5Kw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765843348; x=1797379348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IfxLDcruypX4wrf69FrOY+iSzEbJu1dEvy47POZPvko=;
  b=V4jxy5KwP5mN1rsMxEF2XOpzInDfy0mnw/7u7u/pVjzYtAGOOBReEo1M
   BZ9oT2kmQZchWNpXpD6XNaiooWkzvNRpWZjY6mxZgIX0f5BCQtkN9PdKh
   COT4MdfGUycM19w5Q5mLWy/23TYb335/HX+BABgy2w7ZjLPBRI6rM19dY
   trLlb3C0r1lK4hFTxjdR7MRQjr0KpsxRB7epogFzIpaxzx4m009XxqIYX
   JOh2HW3gwMsIOhnH9UFmXHX9p9Ye8l8zuv/FYotT9vGAaa9bcnlv7okyj
   X5KdUyDuBJErpauudzj4kBbDbxWLLOOudvH7R/kzXwc48LfgW84FAktnG
   w==;
X-CSE-ConnectionGUID: CGK9Rh33SciBZAjq6EBCxw==
X-CSE-MsgGUID: xwvutMmxQ7qhGTd0e2/eJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="55320810"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="55320810"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:02:27 -0800
X-CSE-ConnectionGUID: SqFQLMMHTAeD3CSw9PoXHg==
X-CSE-MsgGUID: s7AnXEPZQiCYtX0dvz3b+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="228521060"
Received: from osgcshtiger.sh.intel.com ([10.239.70.161])
  by orviesa002.jf.intel.com with ESMTP; 15 Dec 2025 16:02:25 -0800
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Alex Zuo <alex.zuo@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Xin Wang <x.wang@intel.com>,
	stable@vger.kernel.org,
	Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] drm/i915/dg2: Update workaround 22013059131
Date: Tue, 16 Dec 2025 00:02:21 +0000
Message-Id: <20251216000221.3496541-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous fix enabled LSC chicken bit FORCE_1_SUB_MESSAGE_PER_FRAGMENT.
This caused side effects on 128EU SKUs. Updated solution limits SLM
allocation to 96KB which is done at UMD to avoid these issues and
ensure stable behavior.

Bspec: 54833
Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
Signed-off-by: Jia Yao <jia.yao@intel.com>
Cc: Alex Zuo <alex.zuo@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Xin Wang  <x.wang@intel.com>
Cc: stable@vger.kernel.org
Cc: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index ece88c612e27..abb47c65f43a 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2866,10 +2866,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 				     MAXREQS_PER_BANK,
 				     REG_FIELD_PREP(MAXREQS_PER_BANK, 2));
 
-		/* Wa_22013059131:dg2 */
-		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0,
-				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
-
 		/*
 		 * Wa_22012654132
 		 *
-- 
2.34.1


