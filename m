Return-Path: <stable+bounces-78187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2F989057
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 18:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AE7B21A82
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E213B298;
	Sat, 28 Sep 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMP/uybV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63A136352
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540340; cv=none; b=K4Q3kKmPl3pc6jlYOZc2UGd3bqmi4Tvh0ITSvhvvXpOzqDuEyo0uqET1RgmNwYG0S/O7/gju0SWBiGhU5MyZDDVKWtPcBApgq7BQNlXty8x8GUHkNfqM0TVoKgbaPtal0iqnOKJV9n/kdiKck5pPjdjw0PPqRbmEYVxWvh6vBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540340; c=relaxed/simple;
	bh=8GUAFyp0FuhOFL05WB5JhM5xrVYx/xVtkUQXQb64hfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QwYm/KO8993P5CpXze9YguI703ipp4Fef1uMDBooaR58ZocUziAWLD1YLqGYqpeJRIRWveRPJcRGB9gtUVM6ziN2hi5opFNdjEssVlXQUgWLrqyUYSfe/B1Ap+mIOpPTDlHsSZjYseBQPJvKp8VZmwpkl+qEOC5TgsyiFCnMrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMP/uybV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727540338; x=1759076338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8GUAFyp0FuhOFL05WB5JhM5xrVYx/xVtkUQXQb64hfI=;
  b=bMP/uybVqZkd2vJmAgWk8IJA01FsLgzjjeTOknOh5Pw0ebGCoah1GW1h
   /M0IFYrFpqFKCjb6piYN3PVzV9NKZZAi1ksKuJxbNlgneIGdBxisEVXvi
   ow4YEDZWRva/Y94VwNLRSzSm6pcyDkrWUgxYbFXMKyNunu5WdLlMgQVOB
   GCY5oAIgHR/XcmKOkau6iLnOwOaM6sUWEibybEmAK7nH3GqgBa+Il2MVl
   Rx2HQPCoD9gJpUmGbyqmkA4O/ZCznFv0ynTn2RsAxu1PRkdSQMEbaZQKW
   AB05lJU8C7DF8tK1s+/XvFcn8JWb7VqGfS9Y918yO+xjer8RpJPTldcL1
   A==;
X-CSE-ConnectionGUID: X7WrKiCgTqO6VeplwhTGFg==
X-CSE-MsgGUID: eGtcUoCIRVitA2wBwP/IhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26834090"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26834090"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 09:18:56 -0700
X-CSE-ConnectionGUID: +62v0AtSQxm81WZIYaVyqA==
X-CSE-MsgGUID: aEHiq+kQTZSZqUEatDWUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73260291"
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
Subject: [PATCH 5.10.y 3/3] x86/mm: Switch to new Intel CPU model defines
Date: Sat, 28 Sep 2024 09:24:31 -0700
Message-Id: <20240928162431.22129-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 2eda374e883ad297bd9fe575a16c1dc850346075 ]

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align 0's in invlpg_miss_ids[] ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
[ Ricardo: I used the old match macro X86_MATCH_INTEL_FAM6_MODEL()
  instead of X86_MATCH_VFM() as in the upstream commit.
  I also kept the ALDERLAKE_N name instead of ATOM_GRACEMONT. Both refer
  to the same CPU model. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on an Alder Lake system. Now pr_info("Incomplete
global flushes, disabling PCID") is back in dmesg. I also tested on a
Meteor Lake system, which unaffected by the INVLPG issue. The message in
question is not there before and after the backport, as expected.
---
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd15fdee4536..17f1a89e26fc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -257,21 +257,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
 	{}
 };
 
-- 
2.34.1


