Return-Path: <stable+bounces-104400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640739F3BCE
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 21:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03E01889714
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65071F668C;
	Mon, 16 Dec 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUZayAur"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA61DB366;
	Mon, 16 Dec 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381871; cv=none; b=KFtVm/pQRbpHOdTImtXlsdTChqT7Nluf7YQj4IxM5bgQ1qNqCQJorCoPRKoTY0mtc+6yRO6FB17ONbGrikI/sl5Bw67GLebZmeZxtwUMQV3eawI2D4EuFX+4F5ERGVp+BFkRgBRasVRAj1xNVHjYcECqjQCJ9L0tIY0aRsvDyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381871; c=relaxed/simple;
	bh=8lk6hIXv5uBixZsKS30e47KoF6LuB9cSgt/3WoiP1K8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbSp2DrYGYKdpaHJ//oqwhm69nbSrqVCHUeGQZ9wIuyL5dgzh0qc2vkyBfzJi51UORZJUgNGGFQnzkeBA45fDiSumeBwDUtt+nRu8UKLpn32zU/a+1JGcrM+ohCB+yxoPUjSqtTbsKgMJ7Zhjiv/k5iFys+uDj4+3GpgMv1RB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUZayAur; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734381870; x=1765917870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8lk6hIXv5uBixZsKS30e47KoF6LuB9cSgt/3WoiP1K8=;
  b=fUZayAurUWyqf7deH9lXx4cgymKAupwclOtC8x5pGsSYB2oAdbYiHlsQ
   fUGbCrIYwYHuSIKUizZccC4o6rfJcAAyU/AnFFUor1TEF89swz8zsdn89
   VsqUnaWOJCSq1HQXWlsiKKEjiB5vNMPrAC9mPCzU/Jp4Z8dSJqDwJEEqL
   wy20g3QFurRfjLS2+VuPRNQV5XU5VXosaD3HvhwG0uG5kVPfOrpFHouLa
   5p+mtZyd2pqkvj9gyuzCzIZrznBr79DfRY+tyWz9/MgaMRKrvJ492jCe9
   wpQ8HxnIP4CFQZ8qLw00EaDz/dfMhwjCpgbzJkRCg9uJsCXqsNNrhWTJl
   w==;
X-CSE-ConnectionGUID: itfQ4vEnT4aPAjB2uOehdw==
X-CSE-MsgGUID: ndVwX7nNSYytpObXyXjfnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38461509"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38461509"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:44:30 -0800
X-CSE-ConnectionGUID: scgSLEsiQSClNeexA7kuAw==
X-CSE-MsgGUID: 8/Oga1xZTsq0gjfIrWWFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101926350"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 16 Dec 2024 12:44:29 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V5 1/4] perf/x86/intel/ds: Add PEBS format 6
Date: Mon, 16 Dec 2024 12:45:02 -0800
Message-Id: <20241216204505.748363-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The only difference between 5 and 6 is the new counters snapshotting
group, without the following counters snapshotting enabling patches,
it's impossible to utilize the feature in a PEBS record. It's safe to
share the same code path with format 5.

Add format 6, so the end user can at least utilize the legacy PEBS
features.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---

New patch since V4

 arch/x86/events/intel/ds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8dcf90f6fb59..ba74e1198328 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2551,6 +2551,7 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 6:
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
-- 
2.38.1


