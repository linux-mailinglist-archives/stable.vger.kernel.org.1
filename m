Return-Path: <stable+bounces-78181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C1989032
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5B1C20EA8
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4A6F099;
	Sat, 28 Sep 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npMF0LaO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B71EB39
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539180; cv=none; b=aMjRrempqjmSO6nLfGd6yfJbBAveY7PrvbIguV5M30WuqcZYeWDMUU/NiJd+YCKbLQF1zJEzATIbRn5sRfOWUPk3n11OuFXBjBE3kss9cZYYjgjdl2l7jSTrGkXQ+nwOGxjoKwUsza/hu7GiZ5bSOwHGVdVPLvJRJguO4POzdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539180; c=relaxed/simple;
	bh=3C8+16F4ITsWvr5cL4KlDzMCDYJbAdgKEHvCWGXLVyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tMMkuaVRPgX//5dJ/PZKT6CqnKdz1KBRpAf5yMZBfgwTZ9AJrOTyMN3/DFsaROIUxdMRNSfCYvqy9Xl4lojPytGtj2MZbjjrjihSNUwK3O3iV25w0AY0gV6RdcF4vvHy3zYd4OuyVOFyoxsb3KpZpyFQMxSjqTE6oZRWibXrURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npMF0LaO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727539179; x=1759075179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3C8+16F4ITsWvr5cL4KlDzMCDYJbAdgKEHvCWGXLVyc=;
  b=npMF0LaOeevLk3BcWsDMWF2L8c5QlVKG+xTFMq81FkdR0Qqwbq9S8D/s
   /U2iIyZNJhTCNUubXk+GfemERQ2vnI9wfP4ES08yzRYhY+GdEa8xvmuaO
   VJi3sjGKB7/14wXErC+RZGZVduJJiPKEvRxbtWEHkjUau1F9MhZkLXsDX
   b6J1q0+hF0n/Tv2/XiVDQDCiYkxf8FdfoTp0mnQysYzzLUZeDc974eCGC
   fL1OUnT3xy+N8tN9Z2CjtVO3Y4FBY6oYEcIcnlp9rZChDCKJsi07wkOzr
   sPwNTKn7D6KRqVltjJXIlNe/ikbG7F5A+Q/aYCHgIjopMvnSQhyxF3kpR
   Q==;
X-CSE-ConnectionGUID: +mh4QYarS3qHmgLtcrzkbw==
X-CSE-MsgGUID: 52uGD8KETMOnHS2pOuKJSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26470465"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26470465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 08:59:37 -0700
X-CSE-ConnectionGUID: yOVEpH9eSMiATK8V0tFffA==
X-CSE-MsgGUID: AcvgxHvaTI2bggwkWkO4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72994563"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2024 08:59:36 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 5.15.y 2/3] powercap: RAPL: fix invalid initialization for pl4_supported field
Date: Sat, 28 Sep 2024 09:05:11 -0700
Message-Id: <20240928160512.21889-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
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
[ Ricardo: I only kept TIGERLAKE, ALDERLAKE, and ALDERLAKE_L in
  pl4_support_ids as only these models are enumerated before this
  changeset. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on Alder Lake and Meteor Lake systems. printk()
tells me that the former is detected whereas the latter is not. The
stepping and the feature fields are 0 as expected.
---
 drivers/powercap/intel_rapl_msr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index c19e69e77093..8435d5358448 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -136,9 +136,9 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
 	{}
 };
 
-- 
2.34.1


