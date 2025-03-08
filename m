Return-Path: <stable+bounces-121522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24FA57708
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793B31897630
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2CBDDCD;
	Sat,  8 Mar 2025 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBWRgk1u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDF2563
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394979; cv=none; b=oWhxFPnyKpUkooUD3qylWZKBYl22NT7nJe+ikE56s+w+BxjtJuD7kPrJZhDwHULeblBZNIW3pMvnwsv+VhE+thJLtj/kgYUfmrLAlzNmK4HIY0QwsrHDMQ7OrHf57cb8HUTcLt+0C9vflpsNvpj/O4Sxrb+enOT88Brka3Tc60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394979; c=relaxed/simple;
	bh=CuhWp0qeie4GC5+52avMHSbpmsCuVMMarnl1Q+ufsnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BLzT18qHx1YAM941Rm6ZovDiddsHU+dthGY5yhhYEOf684tJmSiHR9m13NWrxhvvyA9GvoMMytQa01sTa5JXUWxpnicCpFg00rvhLE6yUj7XABSifGjOuGxCLjpe3gpakKQD3xN/0GAzt0TF3YXfPwwia9CGhFOfE5OIx/10q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBWRgk1u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741394978; x=1772930978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CuhWp0qeie4GC5+52avMHSbpmsCuVMMarnl1Q+ufsnE=;
  b=IBWRgk1ulW+Y5dlCAZQU1+wDJtte3WvimXHqjFzlIRty5GUOS8a5fjAi
   bjafm4nya+LAF9s/kWqg7zG9uSWWj0foGqRY+ffiRDwVtN35qNXWbn5/k
   JXP8DR/Vqr5vIhUlIzASEDY2Hc9z38NIEamRIJpP4xbpk9dFhJCmwtvZC
   LHrTkPMjAXEu3TaLPqcDw5LpIKHOuoStcYoDGBcAwubwy33YpOZIngcpS
   HPB5T96KpepwbqgqdvO5Pp0zBIVFVFJ/3KX0kq2+uojURs2A9luWEiIwG
   aNkufn+WgfyOphZZNkfdWyFPEE4Ut8+FSJfvJlLyF8jQkymumcwM0MN6a
   g==;
X-CSE-ConnectionGUID: M3JbkXtmS9qIgzWkcsnSjg==
X-CSE-MsgGUID: wyvj2rMCRKic78L9UEMFZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42336167"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42336167"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:49:37 -0800
X-CSE-ConnectionGUID: AqB+9NFsSomQ1egTf0x/lw==
X-CSE-MsgGUID: qNyMv/YHQjKbP9n/eqPXWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123650232"
Received: from vward-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.180])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 16:49:37 -0800
Date: Fri, 7 Mar 2025 16:49:36 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Voegtle <tv@lio96.de>
Subject: [PATCH 5.10] x86/mm: Don't disable PCID when INVLPG has been fixed
 by microcode
Message-ID: <20250307-clear-pcid-5-10-v1-1-79ed114bc031@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGWTy2cC/x3MQQqAIBBA0avErJsYTTO6SrQom2ogKhQikO6et
 HyL/xNEDsIRuiJB4FuinEeGKgvw23isjDJngyZtqSaHfucx4OVlRouKsDGL0a2bjPUOcnUFXuT
 5jz3YShEM7/sBNelit2cAAAA=
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
[ pawan: backported to 5.10
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
index 17f1a89e26fc..d4b6ca0221a7 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -258,28 +258,33 @@ static void __init probe_page_size_mask(void)
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
base-commit: f0a53361993a94f602df6f35e78149ad2ac12c89
change-id: 20250307-clear-pcid-5-10-64f4287b45c7

Best regards,
-- 
Thanks,
Pawan



