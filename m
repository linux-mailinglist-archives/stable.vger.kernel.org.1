Return-Path: <stable+bounces-121517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C05A575BB
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF65189A12F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A41EBFE6;
	Fri,  7 Mar 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnQqBfeT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6559208989
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388706; cv=none; b=XGa2PuBxDTfaG/ktHSEnGygUIH4yBQFu6cCp4yl5NT4VV/u+kZezdHu0T/5FjTVIUELx7VHnhv0+vV3gEvp7uTRwv8AsIkzcsQ7nGnMTaQlyh2vGkX+3KGFjVKhaTCFjkL2qc+aPzrUFD8eAU/SUFhIG0S6UPItHeN561iDiEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388706; c=relaxed/simple;
	bh=HP5R1u2aMPJBxl6xyiwZdHlPEtFMA1qsDfAy+TB/Qi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqkRS7tZlpwc7U19Gh3yo4r/AX/NIj22gAwAly4nVRyU5aWv+BfOyxS+QHVd1USotg83Sv7+7PQbMOlrjVSf9ME4hVhXtMsWdW2aVdZ5wSkj3C+uJYrcTmN+Iy2UFDY1sb6Qq4FWU8QkdZmWVs6mzmzCVXYbWAzA4yvv21nHH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnQqBfeT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741388705; x=1772924705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HP5R1u2aMPJBxl6xyiwZdHlPEtFMA1qsDfAy+TB/Qi4=;
  b=OnQqBfeTae+PeBYXG30/UT0I/jodaPh82u3VrNk+bNhV3Mq6JJDKMneu
   3pzsdGs4gg8QCdKC80OEIXOGxIw7kZxgRXi5H8dfy9lKqPSDOWNYQOc+7
   gUKzhCxCkPfyX7vhuRvoddmjoG/UNVk86IqI4Jr47WuF01FNTWROgKiU9
   xIYyldoas3nIWFrddrS1/ZncDD6u3cEJqDmQlpl1P/yb9a2B0aHpP3OEz
   JimGIjqrgj5EC353j9rwy/2EJ/WuEBGPptZlRDMLEKzEnrIq7yKP+cju0
   mWTIcDL3arF2bxHt9MbqjpU2P9rAtQ9o4yYW0jJ9n4c7ehF91h3OrkzIZ
   A==;
X-CSE-ConnectionGUID: UA5qKxIkRlSTvlVJ3BKK1g==
X-CSE-MsgGUID: A1tyFF4yTU2UJ9fMrrOCdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42157639"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42157639"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:05:04 -0800
X-CSE-ConnectionGUID: PXIcuaQAQNqgcYZ2qYWIlw==
X-CSE-MsgGUID: l/4sSFRBTIuGutegx2tNlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119447539"
Received: from vward-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.180])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:05:03 -0800
Date: Fri, 7 Mar 2025 15:05:03 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 6.6] x86/mm: Don't disable PCID when INVLPG has been fixed by
 microcode
Message-ID: <20250307-clear-pcid-6-6-v1-1-cbf7ff0e817c@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAB17y2cC/x2MSwqAIBQAryJvneEHDbpKtPDzqgdhohCBdPckZ
 jWLmQYVC2GFmTUoeFOlK3WRA4NwuLQjp9gdlFBGaDHxcKIrPAeK3HYCGumd89obDz3KBTd6/uE
 CdrSwvu8HVEfS5WUAAAA=
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Xi Ruoyao <xry111@xry111.site>

commit f24f669d03f884a6ef95cca84317d0f329e93961 upstream.

Per the "Processor Specification Update" documentations referred by
the intel-microcode-20240312 release note, this microcode release has
fixed the issue for all affected models.

So don't disable PCID if the microcode is new enough.  The precise
minimum microcode revision fixing the issue was provided by Pawan
Intel.

[ dhansen: comment and changelog tweaks ]
[ pawan: backported to 6.6 ]

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Link: https://lore.kernel.org/all/20240522020625.69418-1-xry111%40xry111.site
---
 arch/x86/mm/init.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 6215dfa23578..71d29dd7ad76 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -262,28 +262,33 @@ static void __init probe_page_size_mask(void)
 }
 
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0x11),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;

---
base-commit: 568e253c3e3bdfecf5a4d65ccc8fc971c6c4b31f
change-id: 20250307-clear-pcid-6-6-ce51baab3b5b

Best regards,
-- 
Thanks,
Pawan



