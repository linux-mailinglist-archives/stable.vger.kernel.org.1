Return-Path: <stable+bounces-166832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57398B1E6FE
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D741895E9E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2621B19D;
	Fri,  8 Aug 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHY0WzZS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BB145329
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651485; cv=none; b=RNcXFNunlcl3yk3PIeZ//7m5wQOtzBlsJAvUW/Ef3PrygxjbseO63VCPdWtCNQ2LFovvb3kVFZSCgFyBIOoETaCGO8zUCgM32x1RsfdI9w1vX3ZwvW9BO3J23qlZJCyhvWLZUVM/tujogy0632wN7T7SgaohMFsh16bNoUldORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651485; c=relaxed/simple;
	bh=purJkrY6cjSNtJ1exYHy5qtfoWVMg/9NNlLuGBLP1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WetPLxam+7ZBPqq1jyeqF+4OoNyVDqbx73he3PU9kcmkCmkjpf5kfK3kUCU7gOB0SpWDb03oqs+xsGf5m/7mx0Fb/czC2Cgibo5T0BxB2YjU4jFhxZQ2YwzBH7cI5Xec01J872g+pR7TXhkczzDUZAS2125S0L1ij1+4N8avccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHY0WzZS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754651485; x=1786187485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=purJkrY6cjSNtJ1exYHy5qtfoWVMg/9NNlLuGBLP1Po=;
  b=fHY0WzZSPObkbLXlLob2hcIig/tmwnN/UH2jAt5Flb+ydyxUAoqKLfUr
   ym0ERH/aBuCfYT98AspN+Ge0AzxBO0oCTL1dXnpMRZLPs3PGjdMiFpZ3s
   vv4M/jv0NpJO2nA49PgPReq9v6y9U4gDOA/yBieWfVvX88b7RukmdaLNk
   ulMLdmryJznsOLCANYbTNXqKJDgvwEA4dGJAp/sbzaHa5k5RyaaLKWBRU
   CrMJlutQmOGTo4UVDXzI6QQi8F67al/xMpQDSwkarq9XOsAprh2S2/5pS
   2kmsxYW6jexjWcCU1zdl11KaDFshGdRXVy2gGSnc8qCGV5uR9bx7FXaE4
   Q==;
X-CSE-ConnectionGUID: VG2qRDaHSmqBKmfbcvWv2A==
X-CSE-MsgGUID: 752cY+LxTiym+PjQQuUpbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60623300"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60623300"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:11:24 -0700
X-CSE-ConnectionGUID: CVoyPoFfRNeUaFQjyN2uRg==
X-CSE-MsgGUID: mswnhxYUR86BhJsAwjTeAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169764961"
Received: from unknown (HELO jlawryno.igk.intel.com) ([10.91.220.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:11:22 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Fix potential Spectre issue in debugfs
Date: Fri,  8 Aug 2025 13:11:20 +0200
Message-ID: <20250808111120.329022-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential Spectre vulnerability in repoted by smatch:
warn: potential spectre issue 'vdev->hw->hws.grace_period' [w] (local cap)
warn: potential spectre issue 'vdev->hw->hws.process_grace_period' [w] (local cap)
warn: potential spectre issue 'vdev->hw->hws.process_quantum' [w] (local cap)

The priority_bands_fops_write() function in ivpu_debugfs.c uses an
index 'band' derived from user input. This index is used to write to
the vdev->hw->hws.grace_period, vdev->hw->hws.process_grace_period,
and vdev->hw->hws.process_quantum arrays.

This pattern presented a potential Spectre Variant 1 (Bounds Check
Bypass) vulnerability. An attacker-controlled 'band' value could
theoretically lead to speculative out-of-bounds array writes if the
CPU speculatively executed these assignments before the bounds check
on 'band' was fully resolved.

This commit mitigates this potential vulnerability by sanitizing the
'band' index using array_index_nospec() before it is used in the
array assignments. The array_index_nospec() function ensures that
'band' is constrained to the valid range
[0, VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT - 1], even during
speculative execution.

Fixes: 320323d2e545 ("accel/ivpu: Add debugfs interface for setting HWS priority bands")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index cd24ccd20ba6c..2ffe5bf8f1fab 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -5,6 +5,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/fault-inject.h>
+#include <linux/nospec.h>
 
 #include <drm/drm_debugfs.h>
 #include <drm/drm_file.h>
@@ -464,6 +465,7 @@ priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t
 	if (band >= VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT)
 		return -EINVAL;
 
+	band = array_index_nospec(band, VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT);
 	vdev->hw->hws.grace_period[band] = grace_period;
 	vdev->hw->hws.process_grace_period[band] = process_grace_period;
 	vdev->hw->hws.process_quantum[band] = process_quantum;
-- 
2.45.1


