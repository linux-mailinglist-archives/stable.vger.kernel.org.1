Return-Path: <stable+bounces-164867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F38B131F1
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B90B7A86EA
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE62066F7;
	Sun, 27 Jul 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVdWr7Gd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFE155326;
	Sun, 27 Jul 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650332; cv=none; b=aG/vjq45MAcXJ1s3AcmZvxnPxxAHqOkaZbZi3xZLx/UQnnOTh1WDDKJHof7tIdgovlkMAxkyjOH4TvTG6rpQMO2VX6zTLFM24X8CIH4PPqqeLRm66E9FeKOf3h/HSOLY/7YwYnUIuNXOcD/ZIlRoFAFX3OnE/celjVx75dWJdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650332; c=relaxed/simple;
	bh=StsXTIN5nDK4vRXIb0SwkkLgru/IrkRxgcHlzLIdwXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxDx0kQwc8D4QcdstxOcy48pGWs3kHxtkBKgVjcgrtustexX6Rst43Rs3fCAMfilu2hPDWfGUEMw2sZX5q4ozr6xXK+zuN5xQE+9zjqbPqtFBt41n0HE/qQoeaHsHLFDA1Zog30N+mTWm+lXOnC/AJE10429/M6sp81tSL5qUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVdWr7Gd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753650331; x=1785186331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=StsXTIN5nDK4vRXIb0SwkkLgru/IrkRxgcHlzLIdwXM=;
  b=CVdWr7Gd93e97sKUIPaFpdWS8aD+PizYbyuZCJgytusUOX7LsMnuNMaS
   BmIUfbbepjAb1fJUcmOgA+N2rnIufESG4RT4wZ1yPhvLjOACxn840EXPR
   7AiB4jMmla4GBbanULXoWFqcQ/iVf3X6RjrqZA6VQUPP79m/e25wXH0uB
   TPPL49lqi4lDS7hndrq1jleWS6umKkcRBHbrKR6459z0jMOBhqbIRk+6m
   KU9y1s7MgJmP4/6FNUPE4oMvX/djMXGlu8+OuxdpGP37Ms3AU2WQQXJVM
   2FdgCjJZQdWNbasYC7wCkbS+N2a/7Ff1PrKXek+Jm9RXjtKHDu56JrWWT
   Q==;
X-CSE-ConnectionGUID: GW2OiGRqRwGt1QaK1ipuXA==
X-CSE-MsgGUID: OpbIWdgjQTimOZ2RWpywCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="67249791"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67249791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 14:05:31 -0700
X-CSE-ConnectionGUID: J2jOi8naSAO95aolGRw28A==
X-CSE-MsgGUID: 6pVmds2lRWq9E0gGcvzjaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166417786"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa003.jf.intel.com with ESMTP; 27 Jul 2025 14:05:30 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel-uncore-freq: Check write blocked for ELC
Date: Sun, 27 Jul 2025 14:05:13 -0700
Message-ID: <20250727210513.2898630-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing write_blocked check for updating sysfs related to uncore
efficiency latency control (ELC). If write operation is blocked return
error.

Fixes: bb516dc79c4a ("platform/x86/intel-uncore-freq: Add support for efficiency latency control")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
Non urgent patch. It can go through regular merge window even if it has fix tag.
This is not a current production use case.

Rebased on
https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
for-next

 .../x86/intel/uncore-frequency/uncore-frequency-tpmi.c       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 6df55c8e16b7..bfcf92aa4d69 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -192,9 +192,14 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
 static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val, enum uncore_index index)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
+	struct tpmi_uncore_struct *uncore_root;
 	u64 control;
 
 	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+	uncore_root = cluster_info->uncore_root;
+
+	if (uncore_root->write_blocked)
+		return -EPERM;
 
 	if (cluster_info->root_domain)
 		return -ENODATA;
-- 
2.49.0


