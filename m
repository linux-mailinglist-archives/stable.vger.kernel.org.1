Return-Path: <stable+bounces-121520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012BA576AC
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 01:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD7171502
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760504A1C;
	Sat,  8 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaYTYl2q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA35A48
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392940; cv=none; b=VJDAxb0slIQYK7H91m3oQP48foBe5UN34n+Rr4KZTZc1zQCpet+/LC5mV/GVEdq5zUGvYC1/oxEvUD4bBTN6CQzWDE0qKur9MBq6f+Rbf75bIZMoi78oiaqthu5Q/leQEEb/JjXZeqckgJSRd1BlM5+oDs2CdDNdXADN7NfhbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392940; c=relaxed/simple;
	bh=s4cqDIESHsPP+/QYrwf6HevGwNRjCib34wQ+MJbTWFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eUpU/VQdvZ2XXBVwesUCOw7W9ruq14QIRJXbDa0joR1LNoowWh/7upfEkT0C9otTlgY+9vChLw2k6CElQYvW70tiBDrYPX1hsfwEKsJhanAUvEcnOrCfPNnyh3LkRlhKI2GbnWyweetORp+CGm7AjmW0RmoT1HAALEdkMZfMkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaYTYl2q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741392938; x=1772928938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s4cqDIESHsPP+/QYrwf6HevGwNRjCib34wQ+MJbTWFI=;
  b=DaYTYl2qrL+aTCFiDscsgQ5Okh9ElJVi4TA3a1BqwQGpggqTeOQVPPcJ
   WV2RGzelRUHUBPNFz/Q4xN3/RZWsF8+sZ+RWTF1ndKVCUiS5YkiK4U9uw
   1zlZWOQEAbllbxOextKmUT6EYRgdwcuB5XhLj/mhn/KIcVu9CrEEiH601
   ATL0zCP1jMM48o9tkmWqbq5vKX2XCE3ELrqCv/URpfb8F8ibpbCNX3MOV
   pZuHBgbU0S0fLvMV3EAB6ExcHHLa0vFGHk9aTsBB5Xba1p9UHafScK+3i
   wNYxw7lARpv6gnq3Mo8VNX4WrxAaql1tmz6SCUWLBHI/h0nn8uI93zYyt
   Q==;
X-CSE-ConnectionGUID: AKBbE1PzTaKWT7h6e8lgZw==
X-CSE-MsgGUID: ZadcwBFcS3KpIy+KE35XNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="59861288"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="59861288"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:15:38 -0800
X-CSE-ConnectionGUID: 2zdQHE4vQi6sN1A7GNa81g==
X-CSE-MsgGUID: hYOUSkkoTaueK+E7KvSqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124381055"
Received: from vward-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:15:38 -0800
Date: Fri, 7 Mar 2025 16:15:37 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 6.1] x86/mm: Don't disable PCID when INVLPG has been fixed by
 microcode
Message-ID: <20250307-clear-pcid-6-1-v1-1-2cbbd0aa3150@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAKWLy2cC/x3MSQqAMAxA0atI1kY6oAWvIi46pBoQlRZEKL27x
 eVb/F8gU2LKMHcFEj2c+TobZN+B3+25EXJoBiXUKLQw6A+yCW/PASeUqKNx0kY9eqegRXeiyO8
 /XGAaJKy1fodd97tlAAAA
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
[ pawan: backported to 6.1
         s/ATOM_GRACEMONT/ALDERLAKE_N/ ]

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
index ed861ef33f80..ab697ee64528 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -263,28 +263,33 @@ static void __init probe_page_size_mask(void)
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
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0x11),
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
base-commit: 6ae7ac5c4251b139da4b672fe4157f2089a9d922
change-id: 20250307-clear-pcid-6-1-3f7b1af35cb2

Best regards,
-- 
Thanks,
Pawan



