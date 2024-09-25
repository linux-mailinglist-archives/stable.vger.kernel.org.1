Return-Path: <stable+bounces-77072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9E9851A7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 05:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3098D1C20EB4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 03:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868914AD2E;
	Wed, 25 Sep 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL+EICzd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4920E6
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236401; cv=none; b=Y+DMVC6WjryBl1uPBPboYL9SWp8wXIRG521AjkGv1gDrbbq9V6a0+plPujHMHt38BHdHh8EdB+OvcoUOTk6Zcay5nH+HxCHM/YxgonZLwOKge6lm4pQO3mOoQjF9bNCDMjcll33AWrJU/xRpk5zI5NNqynT5x0+B40Gi54qra3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236401; c=relaxed/simple;
	bh=ktotHi6B2/4z8R9XImAcsxBT80Jja3JEXN2e+OeJZAU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uPLolre3K6BI4yJXY4oM72CSp1q2oe8agkGoaoWTn+bDkfGjj6YUJi83kcn7pzT/ufRa+VvmTHdAX77vMmgoyNkdgADPjKnLfwa6YZJ3kDfJScKA9n3WWCvd0sdmQvZrEJnM6EtS3Q3mjOx4OMLirTN9VTfnSzHj1X3FhwVlBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL+EICzd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727236399; x=1758772399;
  h=from:to:cc:subject:date:message-id;
  bh=ktotHi6B2/4z8R9XImAcsxBT80Jja3JEXN2e+OeJZAU=;
  b=jL+EICzdjPvmDt+MZAW5/IqMZz5b+QVehD6jiwL0hJfYuE2eOq3JW+2L
   iI3VZLNUIm2lf9gzxUqk7QTGiVDGZAnM2gf3bg1FqnqMSuTGbEw8Ftv0Z
   j/AV4xVeTXtadwDnnIxwzPppxkiSNhJ9OLcQLBtUmxuERZvjWx4dp1rLm
   MYR90QOg2OLyV6D/qj38TzGajoK/lpYXAdO3CdSQ+c7hwwWg664QXSgt+
   eFlJJGuaOZSL8mInsbZSueBaohRQ2lV+PGwgUjLSTM7fXfTZy1sSGCvhS
   GWrKHEkmyqY4JhU2ckOnJPTEK8NoxcfmkaeXqf8GglOMlxH522Xyv8rFv
   w==;
X-CSE-ConnectionGUID: GWvs2jBWT1edmzzDZht11g==
X-CSE-MsgGUID: RdqjWmVMRY2t9VeKlai6hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37640757"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="37640757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 20:53:19 -0700
X-CSE-ConnectionGUID: t/YTVD46SumXr5lQ2zYqcg==
X-CSE-MsgGUID: LtoW6G3RRUaYQG2WT/RdLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71780874"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP; 24 Sep 2024 20:53:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 6.6.y] x86/mm: Switch to new Intel CPU model defines
Date: Tue, 24 Sep 2024 20:58:57 -0700
Message-Id: <20240925035857.15487-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
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
  instead of X86_MATCH_VFM() as in the upstream commit. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on an Alder Lake system. Now pr_info("Incomplete
global flushes, disabling PCID") is back in dmesg. I also tested on a
Meteor Lake system, which is not affected by the INVLPG issue. The message
in question is not there before and after the backport, as expected.

This backport fixes the last remaining caller of x86_match_cpu()
that does not use the family of X86_MATCH_*() macros.

Thomas Lindroth intially reported the regression in
https://lore.kernel.org/all/eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com/

Maybe Tony and/or the x86 maintainers can ack this backport?
---
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..6215dfa23578 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
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
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
 	{}
 };
 
-- 
2.34.1


