Return-Path: <stable+bounces-78186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E36989055
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD76D1F21C92
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80371386D7;
	Sat, 28 Sep 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQkS0EyT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE854673
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540339; cv=none; b=ofliBWFQWS5l4vopa5r2Rsn9DOSAkx05xaIIvojjfVALvp83RUNdwIHZSdl/QNBDdDa1WZFFu263DIHikndhQvpbjmP32bBkLo0HN0FFD1FYis1cUwEtxexMwin7nQBsRHTm2xDaQK8aYnPUrnXK6hz0+pw9+mur0yT7eJFjRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540339; c=relaxed/simple;
	bh=E46wlzXEaZ/AdFOCW0kyX7OIrHlMFrn52PsBiPw5hfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LCRouLZi6AT2FfLiTjsksC3vazprjqcXQOFwGKiBFJh82ctD7s7uPPC5A9f5RfoUEJumL6ZT4J6nCO0gaspeVK2yxxRxWhOgNhrZaQODre8s7CP1eDbB6SHpZOfBOvnHSL08tq38rmqWVkyKZgYGP3CNBsMDAj+QVZflPYOr6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQkS0EyT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727540338; x=1759076338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=E46wlzXEaZ/AdFOCW0kyX7OIrHlMFrn52PsBiPw5hfU=;
  b=aQkS0EyT36GMsGEzLwwz6LFo/JkEOlCvoYpgzkDDrcgCEDhDJC2df6Vf
   3F04Fo/OUweHG4fL+YYEesAnyBFTbSjI5nVAKBSc6OIpQS9APKytxDZLo
   +eDe5mBUBNxyOzJLP74FjMoDJXy7D6Ib2LiBx8kiVGHxSGrubMDQjDgO3
   vqWX35ZryMH9kVwMjDKNPTzYwdpTi/DbHw5P1sjSL2FGpFX13o8kX2kG+
   GOAjt935lvopuamKsARSaGwxNGDFXGsfwrCXwuUuuK4rMtEtk+PTIXEvG
   4SmjWCFXOpRaJQiZu9igcJcZduD2fV+K2tMyyi1Ni7Lh0YhvFI8slKP2l
   w==;
X-CSE-ConnectionGUID: K8/KEayDQe6glb4d39vHLw==
X-CSE-MsgGUID: yva+sIaeTzulVU44NZeeNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26834086"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26834086"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 09:18:56 -0700
X-CSE-ConnectionGUID: nB5/kbVhQj25WMNeU2SnrA==
X-CSE-MsgGUID: anOnYm90ROWgHUjwW2firw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73260288"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 28 Sep 2024 09:18:56 -0700
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
Subject: [PATCH 5.10.y 2/3] powercap: RAPL: fix invalid initialization for pl4_supported field
Date: Sat, 28 Sep 2024 09:24:30 -0700
Message-Id: <20240928162431.22129-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
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
[ Ricardo: I only kept TIGERLAKE in pl4_support_ids as only this model is
  enumerated before this changeset. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on Tiger Lake and Meteor Lake systems. printk()
tells me that the former is detected whereas the latter is not. The
stepping and the feature fields in Tiger Lake are 0 as expected.
---
 drivers/powercap/intel_rapl_msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 6b68e5ed2081..17692b234f42 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -126,7 +126,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
 	{}
 };
 
-- 
2.34.1


