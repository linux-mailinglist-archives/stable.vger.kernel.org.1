Return-Path: <stable+bounces-121521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA868A576F2
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 01:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015491742D6
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A68CA6F;
	Sat,  8 Mar 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO8Z9+8D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CEF8F66
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393995; cv=none; b=ZuzJeuAsTYuApDkBhelMpXoVpDPdr3DkBhiDgBl5+N82+XyJ1cnTHldI2Z2lAv2Uc8rbjTDiINJDwrcvDSIiXGrh+uXc6FY1TQChKVIM3YNBFvByOD+76RP1X6jut3D2U1wim+KLxaM6wPKr4iVt+6KRpKlSRIJPdkAHStDyFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393995; c=relaxed/simple;
	bh=Q1GJ2LGfYkIIoAH/ijT8chDthLBuX4ZAZOluqwCSWcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=len5QldAbnntE7WR/1v7qT3VeyvQBEX+CqYYkYhpdCp3EGfN+kdSi12E5xGY8CuDz/EcleN28W9IifAjgAfvYUBni7UIH0BS91q8d4OMgBcwOU30K0agKXhqblakkiwR07vMHcg1RdVnsGs4Md7BTQZDwo0zyco/p45KbmKN/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO8Z9+8D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741393994; x=1772929994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1GJ2LGfYkIIoAH/ijT8chDthLBuX4ZAZOluqwCSWcI=;
  b=eO8Z9+8DYFBd84gJy2KGE9oObXZ09c4E1/sOeoGcwYXvOM8gjQkHTLAD
   hWiCBY650LhelyufSgVPcQNRoGsPkMXG+4W6zcqcMTxApnmX1EWxrEwE6
   3chVVVs5HnlNy0+Zw326BiidABGQ403wpkjeiJnZvU9FRz6r/rJf7fE/b
   ObucZ1i9daJAVhjw272TLysA14XD0BsN32b44lAP51TAy8spSWV4/KiLP
   WUBtRwSSVopgoiJDQdzFOGZmGPHvYYcu6+yOOO8XHLrCr6bXMRczkEkRQ
   Zw0g3Lni1ibzoHU+cCIg1Xo3hcisBlCAGmX/UYaZytS2jiTUujoJ4B+FA
   g==;
X-CSE-ConnectionGUID: ee6BuPsVRe+goL3pjfvKRw==
X-CSE-MsgGUID: ikHLxj7hQmuxlt807fVSFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42371521"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42371521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:33:14 -0800
X-CSE-ConnectionGUID: 4++ckDuGREuNBdkyNrJZqA==
X-CSE-MsgGUID: UYlJRb9zQMWgc+0jhLJ0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156681552"
Received: from vward-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:33:13 -0800
Date: Fri, 7 Mar 2025 16:33:12 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 5.15] x86/mm: Don't disable PCID when INVLPG has been fixed
 by microcode
Message-ID: <20250307-clear-pcid-5-15-v1-1-f20bafd8c5e4@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANSPy2cC/x3MQQqAIBBA0avIrJvQapK6SrQwm2ogShQiiO6et
 HyL/x9IHIUT9OqByJckOY8MUyjwmztWRpmzodIV6Vpb9Du7iMHLjISGkDvbaF9P1DYd5CpEXuT
 +jwNQaQjG9/0AbyieM2cAAAA=
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
[ pawan: backported to 5.15
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
index 5953c7482016..1110f6dda352 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -264,28 +264,33 @@ static void __init probe_page_size_mask(void)
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
base-commit: c16c81c81336c0912eb3542194f16215c0a40037
change-id: 20250307-clear-pcid-5-15-e9740c3b5649

Best regards,
-- 
Thanks,
Pawan



