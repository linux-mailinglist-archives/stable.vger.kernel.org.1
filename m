Return-Path: <stable+bounces-203354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6FCDB40C
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 04:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D354F30227AE
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BFE327C11;
	Wed, 24 Dec 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8jWJXZG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DA319864;
	Wed, 24 Dec 2025 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766546621; cv=none; b=GYapIPtBnDgoM51XSBgQtf9Fk+qiAnRIEj8VDhSNFfiEkaJaDGki+3ayqJY4BQKhwutAYHjLkWxghUqd9emlkYkKwhRkEiJJdH6HUG35ePmIcIdnGyG75x5uJUzCay6tuSj3jTzkKHkJTmoIEOw3hcrVq5kP2ypFC1G227uwWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766546621; c=relaxed/simple;
	bh=RUggawVPSWiNWrpeTeZX/vDikxl8/XvtKFmOAkdwHd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4hahJIGGnKEYvW2DGKm17APDlrho+BrEFK5oQbC+h4ooIdfXAFDw6mjFW4hfoSNx1mLRjPJfTs9aoWknhVSkKGQk59/ck+Rd58Z2R/Q7LXqTqRFHkeQKQJfXXRojTo1LjUao/c8llzX0M+Dl3QyeV0Yo1UbsVjNhR1ZyknRjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8jWJXZG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766546619; x=1798082619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUggawVPSWiNWrpeTeZX/vDikxl8/XvtKFmOAkdwHd0=;
  b=S8jWJXZG/4UiFe3u6Lv9IX3Mg5WVTGyWFQRf/79vgH304Lpg9WDKd+oP
   IDsX5kBF5wpPymU254UX7xdtAnl05B/8s/FA68q/1czJs7XZ2UFTlCLoZ
   yd8+11sNsvvoPV/UUROV63eAGTUauZtlPb7S09Xu5EjAwMNth98KfbUuz
   qlZ54BO/GNV4sCnAUhyAosT40gwBDltVIz5B2Vcq7ArmHmgzBm1YeVWHv
   YWD7OjaqJtlbTi4acNG8SftTc7qlF7+c7fAnFCYBUNx25tFBVGeen48Y9
   fs3CQP+Yszo6WmsLLOSurmICGH0N+JLK3xL4ld7YkcJDc1pHM7+7VmMIp
   Q==;
X-CSE-ConnectionGUID: gOVeGs6kSnyrtuHeA++A3A==
X-CSE-MsgGUID: 07slvXE+QQaMvJWGOAMYnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68464006"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="68464006"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 19:23:36 -0800
X-CSE-ConnectionGUID: 34cKrfTFQpuYV022qE1g9g==
X-CSE-MsgGUID: n4ydWzz3R2OuCKWaonB9hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="199901932"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Dec 2025 19:23:34 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: david.e.box@linux.intel.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: intel_telemetry: Fix swapped arrays in PSS output
Date: Wed, 24 Dec 2025 08:50:53 +0530
Message-Id: <20251224032053.3915900-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTR blocking statistics and wakeup event counters are incorrectly
cross-referenced during debugfs output rendering. The code populates
pss_ltr_blkd[] with LTR blocking data and pss_s0ix_wakeup[] with wakeup
data, but the display loops reference the wrong arrays.

This causes the "LTR Blocking Status" section to print wakeup events
and the "Wakes Status" section to print LTR blockers, misleading power
management analysis and S0ix residency debugging.

Fix by aligning array usage with the intended output section labels.

Fixes: 87bee290998d ("platform:x86: Add Intel Telemetry Debugfs interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/platform/x86/intel/telemetry/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/telemetry/debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
index 70e5736c44c7..189c61ff7ff0 100644
--- a/drivers/platform/x86/intel/telemetry/debugfs.c
+++ b/drivers/platform/x86/intel/telemetry/debugfs.c
@@ -449,7 +449,7 @@ static int telem_pss_states_show(struct seq_file *s, void *unused)
 	for (index = 0; index < debugfs_conf->pss_ltr_evts; index++) {
 		seq_printf(s, "%-32s\t%u\n",
 			   debugfs_conf->pss_ltr_data[index].name,
-			   pss_s0ix_wakeup[index]);
+			   pss_ltr_blkd[index]);
 	}
 
 	seq_puts(s, "\n--------------------------------------\n");
@@ -459,7 +459,7 @@ static int telem_pss_states_show(struct seq_file *s, void *unused)
 	for (index = 0; index < debugfs_conf->pss_wakeup_evts; index++) {
 		seq_printf(s, "%-32s\t%u\n",
 			   debugfs_conf->pss_wakeup[index].name,
-			   pss_ltr_blkd[index]);
+			   pss_s0ix_wakeup[index]);
 	}
 
 	return 0;
-- 
2.34.1


