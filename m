Return-Path: <stable+bounces-77706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80056986375
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63A0B32E7B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6718452E;
	Wed, 25 Sep 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDI9vdvi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3F155C82
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276527; cv=none; b=FVbY0YqcH80A7l21Etg69Q4XDrsG2+oOYhXmwHgRAS+3ghMZUJuJfMcxDKU1DzCjZwoeFu/aAbnAe8I5BFMl6102nsTnozoPqaxHpRYGuRo9QgjqfoYqPzBBOHHXU85TUxtpvdyTuQtb4EqdhOpKwASYmJosfJVLuCtuEkUwIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276527; c=relaxed/simple;
	bh=SGBHrZBMsLbYWPNhIjhcVqUKAFvOpG5EjgZCvW8CXWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YBuyDl8qbUGWKiIUN5nbmm1LDBqNrapXT4UDppuDWKbj2J24ltRV52ehAH4JiZHIAZRF2BOphh+88zJJzBePNjWZoDBIQblCOwUpf/GIGePVQ+g9LDdxkJmz59g7xGkQo/TYspNyJml9XEqpS2dP+OLWD5FDguwfmKjd1HZ3W1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDI9vdvi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727276524; x=1758812524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SGBHrZBMsLbYWPNhIjhcVqUKAFvOpG5EjgZCvW8CXWE=;
  b=fDI9vdviIx/KV2vmFNREDfBK27nFhiZ+dwu+EdabF+6jOHJjjDQmoi58
   AuVQ3GwkT/C3Ko4ubM1MOii9CmXhv/jUIOJLyv+3XZsw3FYEiNrENmj5J
   GWjGMqqYbCRdouHy8CipmV5pl1OmcqR6UE0+EbHN7Cv1WUdEFl/73O8Dd
   u9z+eEw7XIOxVcPCdPRTvDSmHchaysXpkWubaWvSuEveZn3OSkqH58AOO
   b8iNU6IwGd7oKk4Inup00rN6DWJ5L9cRxPjPkIqrmTUIoDRh5Y93qUtl0
   P73IXg662rMRrnbgwjsMLZ5bLwHwtImwLJ5Uyt7uYWT4slluMs5XJJC0a
   Q==;
X-CSE-ConnectionGUID: mwXBbqBBQBiXM3JIpNl7HQ==
X-CSE-MsgGUID: sXtgsYy5Q+y2KLYUSNEaOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26194383"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26194383"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:01:59 -0700
X-CSE-ConnectionGUID: NM3CH7g4Sn+A9Cs7ZME7lw==
X-CSE-MsgGUID: asH167rZRN+hvvUAYlPq6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72256156"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2024 08:01:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 6.1.y 1/2] powercap: RAPL: fix invalid initialization for pl4_supported field
Date: Wed, 25 Sep 2024 08:07:36 -0700
Message-Id: <20240925150737.16882-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
References: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

[ Upstream commit d05b5e0baf424c8c4b4709ac11f66ab726c8deaf ]

The current initialization of the struct x86_cpu_id via
pl4_support_ids[] is partial and wrong. It is initializing
"stepping" field with "X86_FEATURE_ANY" instead of "feature" field.

Use X86_MATCH_INTEL_FAM6_MODEL macro instead of initializing
each field of the struct x86_cpu_id for pl4_supported list of CPUs.
This X86_MATCH_INTEL_FAM6_MODEL macro internally uses another macro
X86_MATCH_VENDOR_FAM_MODEL_FEATURE for X86 based CPU matching with
appropriate initialized values.

Reported-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/lkml/28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com
Fixes: eb52bc2ae5b8 ("powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC")
Fixes: b08b95cf30f5 ("powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P")
Fixes: 515755906921 ("powercap: RAPL: Add Power Limit4 support for RaptorLake")
Fixes: 1cc5b9a411e4 ("powercap: Add Power Limit4 support for Alder Lake SoC")
Fixes: 8365a898fe53 ("powercap: Add Power Limit4 support")
Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Ricardo: I removed METEORLAKE and METEORLAKE_L from pl4_support_ids as
  they are not included in v6.1. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on Alder Lake and Meteor Lake systems. printk()
tells me that the former is detected whereas the latter is not. The
stepping and the feature fields are 0 as expected.
---
 drivers/powercap/intel_rapl_msr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 65adb4cbaaf8..e46a7641e42f 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -136,12 +136,12 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	{}
 };
 
-- 
2.34.1


