Return-Path: <stable+bounces-78182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD2989034
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9921E1C2136B
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D178276;
	Sat, 28 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwFhu91n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1454918
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539181; cv=none; b=KhFFia72cWp66tORP/WT98pTKiapDeMySN/gsbWc581xZOyvYNTqhDKa/HEx/o8re2kwmWSUWVxUxFIwVBSYTSMQrV2oZ9hw34yMAHMtzXZqUBwwIihox+BQqLCHsBVh9aUJA/njQJ8OFLUu6+ZEpIoq7FEUfn6lKX0xN6bGt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539181; c=relaxed/simple;
	bh=jjFbe6GHvkGD8l3YN2nWZscAGPq7pNuj5A/2Pcl3+tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pA2WqmwrpmtF2tGtcir6offia/JoHq4PfkECV0nMW2t5sNiT1V8mX/7ozAg4vxjUtkaaP9kO0+hrjmQNvPkh7OaMVI/swi8KuGUdG5SOsGdSHPEi7yeEuV7TyDGHf/ZJpdPyDAGbW50lAtJSx7o9pZtOkPrF6mtBrCeQ63DA4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwFhu91n; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727539181; x=1759075181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jjFbe6GHvkGD8l3YN2nWZscAGPq7pNuj5A/2Pcl3+tI=;
  b=WwFhu91nF8JGrmChQRMQbccjAoI30BtNBTZ8FOdxALftJ4Wci2Jv5L3y
   X2sNAMvzKcH+izCvG3yMlhmgkpoMLAKNs+npoUnjE2T7ckDpZfY2IT9wS
   4sFwqjI/19ot4sI6W+l3ulaYb6EOpLbSppe5mBFL4cvMgi/Kh0bwRiUMM
   wYJC85aWhrrB8B42aZ1ijo77CdKPqOuj3snp7y3QX+l/0yFt2HMgyqXRI
   sosaygCWp2tvIDKu1o/FbLH2rRHbVQ6INJ6hXKRFYhFUHkMqokXkJGxWA
   htvVtaLvYM/j7YOM5YugRURApfkVMoYOPGIHVRZnAIMAMH7MR5CPhd+eC
   Q==;
X-CSE-ConnectionGUID: c/rNjftKQAOZaKDkTPlgPg==
X-CSE-MsgGUID: fqsAj8fMRAia9g4das5W4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26470470"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26470470"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 08:59:37 -0700
X-CSE-ConnectionGUID: 1C5IwgelQ/6JTq8fbBCN1g==
X-CSE-MsgGUID: bACWIfX0Rz6t64WUSHfNpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72994566"
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
Subject: [PATCH 5.15.y 3/3] x86/mm: Switch to new Intel CPU model defines
Date: Sat, 28 Sep 2024 09:05:12 -0700
Message-Id: <20240928160512.21889-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
References: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
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
index 56d5ab70bfa1..5953c7482016 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -263,21 +263,17 @@ static void __init probe_page_size_mask(void)
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


