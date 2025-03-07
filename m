Return-Path: <stable+bounces-121454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D2A57449
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD6E1896536
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ABE1A9B24;
	Fri,  7 Mar 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyWJ+nIh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479A7E9
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384925; cv=none; b=ISqWos0zV2hdMoUnApFWOu4TgWPJCG5rXv1zWg+OYHQbyooTbPGUV4EBkJ31QmZAvXyWLQdGXqdMeTTiwkJc7AyYjJcx5ahbHquRY1eCcVhO4BsUurBWAnYRNOHdcohuqoRed4TuWh4XsuBVjWE1HVHsm4o1Va4lzEFzUX7kzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384925; c=relaxed/simple;
	bh=Iqg2bKs3r41ACX9As4jl+rl20MuvESPwxCo28QpUXoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VY88CoFnag/XJqBwEQcUTJjPGw+x5amjVYDGZeDR/S8kQiU6xvN7I27GApyHhRFxO/vaWUuqREZ1+4vnTFAS0KX9ASnRwhUCGYq4lENnqNkr2FXnUBRC+YpV/XOjEQxbugV7g/+1Zvhrv/CraM4JTmbrYjO0aLGGu5RHrCJqQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyWJ+nIh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741384923; x=1772920923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Iqg2bKs3r41ACX9As4jl+rl20MuvESPwxCo28QpUXoI=;
  b=UyWJ+nIhZNxd8brhM/gr136nK3KFe0ErnD/XhQ+qobhEviQZiajYTedq
   qNDYLE4cRPqHzVqXPL7MN7z9cI2meNhxF+htM3/u/JJ0+2mHiW1heo+xZ
   uKQVwcX0LEQhMGfPiRy+7TemcCLn8XopEMbJkAzLLir3nXyoOnA0C6Iyu
   CurRFy40NHtZ6xLdPhQSh2SAIuyZa+MkUislps5B/BKMHTfXSzIxV5Z9S
   zCf9AsK6SKxkABHIGl3c3rM2M4jT1tlm3ExKFZ897Kc+HSvHuk/0APloZ
   to7U+Qn/3SwyVugwpMWVTKJDDWoA5ndqBXttr9zBblMb/2YPlckuiGhAo
   g==;
X-CSE-ConnectionGUID: U9lou/luRgypisveYDR0Gg==
X-CSE-MsgGUID: I3n4/BwXR92KKTrcDEgySQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="46369914"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="46369914"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:02:02 -0800
X-CSE-ConnectionGUID: /Zg9r1maQtGKLnbmvQGk0Q==
X-CSE-MsgGUID: Pzyd+NizRtm2P5utaMgX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119620732"
Received: from vward-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.180])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:02:02 -0800
Date: Fri, 7 Mar 2025 14:02:01 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 6.12] x86/mm: Don't disable PCID when INVLPG has been fixed
 by microcode
Message-ID: <20250307-clear-pcid-6-12-v1-1-7c7f826c0fd1@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAA9sy2cC/x3MMQqAMAxA0atIZiNtrFW8ijhIGjUgKi2IIN7d4
 viG/x9IElUS9MUDUS5NeuwZtiyA12lfBDVkAxlqTG1a5E2miCdrQI+WcK7Fcee4JeMhV2eUWe/
 /OICvLMH4vh+0TDsYZwAAAA==
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
[ pawan: backported to 6.12 ]

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
index eb503f53c319..101725c149c4 100644
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
-	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0x2e),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0x42c),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0x118),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0x4117),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0x2e),
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
base-commit: 105a31925e2d17b766cebcff5d173f469e7b9e52
change-id: 20250307-clear-pcid-6-12-f3e4c84c7206

Best regards,
-- 
Pawan



