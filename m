Return-Path: <stable+bounces-164584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904DCB106E4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B28E1C241E2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561724728C;
	Thu, 24 Jul 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj+yUHWv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531923371F;
	Thu, 24 Jul 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350407; cv=none; b=bWZ0CZQWrWviAhBH3VndQflNhsygwvdAu046tQW8ZSJ7hF1P6aRWrJp2xJup2YjRZz3jcF/RRQVHqO2rYW76g0wMZzmTC6h5hpYC43yt6R7eW0v7ug8cbagvfWs3YXJ+K6Ji2TzTpR7/PWFzHD1i9Nb+q5/H+gTaQx+M1VjsWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350407; c=relaxed/simple;
	bh=hLpaFAqZta/u9NxaLVwSNs4FG4C7tvWUBCxafobn0oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncSOLNWZd7dF0xrebjLx8kd4MFrNaJjiTiy7VpuJOUhTlhiiWWivXh+hME0J6iW+9r939uQiIkjsJDqGrzTxB9velTwN6foRtoYvm6RGT0ANt32HNlTfH9UbO3PTaR+mh5c4pKprBvbvHZ15QiS+R/o2KbVYQ/r/nKcYl78hAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj+yUHWv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753350406; x=1784886406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hLpaFAqZta/u9NxaLVwSNs4FG4C7tvWUBCxafobn0oI=;
  b=Cj+yUHWvrnMs4x6pMV3X6mbNSrTJMPv0WZk2BoNgVkpQZRy6Kk6ZT8Aa
   tQ1DHu9nMaYJ7kkrvkeTf2fYknlCqqlKxzR6g4/AsUVQJvtT0Os4s4gSN
   HghD1ollIXYJPKOxOZAIe8h+izBacWGLu53EaI6PIw4PU3ysQFPOcSPv9
   Zvjn0FB1P97qcd+aEzJW59OjYYnHaaIgQ8tznVILVA/jFn5aSWmc8E1DG
   Ty8d8od4M0+qUcuLQKXEouJEB5O+LEEpdmnV+cKf9EEyrtfdEcQVrVlLw
   /E+OuHVpMTmSn67MHHJJTTRjzKS/EJKlYAsG+e0dil2CrTpQFoCt+tIkO
   Q==;
X-CSE-ConnectionGUID: e6vXVe9WTJGW24PWaHoduA==
X-CSE-MsgGUID: pbAAomRPSaCd2RFA1bfSgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54867416"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="54867416"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 02:46:46 -0700
X-CSE-ConnectionGUID: 6y1Bah4yRce2t3wv5/Af8w==
X-CSE-MsgGUID: Ezs3+RWMRu+ajT7pgvIgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="183788575"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.18])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 02:46:41 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kyung Min Park <kyung.min.park@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>
Cc: xin3.li@intel.com,
	maciej.wieczor-retman@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86: Clear feature bits disabled at compile-time
Date: Thu, 24 Jul 2025 11:45:51 +0200
Message-ID: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some config options are disabled during compile time, they still are
enumerated in macros that use the x86_capability bitmask - cpu_has() or
this_cpu_has().

The features are also visible in /proc/cpuinfo even though they are not
enabled - which is contrary to what the documentation states about the
file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
split_lock_detect, user_shstk, avx_vnni and enqcmd.

Add a DISABLED_MASK_INITIALIZER() macro that creates an initializer list
filled with DISABLED_MASKx bitmasks.

Initialize the cpu_caps_cleared array with the autogenerated disabled
bitmask.

Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org>
---
Changelog v3:
- Remove Fixes: tags, keep only one at the point where the documentation
  changed and promised feature bits wouldn't show up if they're not
  enabled.
- Don't use a helper to initialize cpu_caps_cleared, just statically
  initialize it.
- Remove changes to cpu_caps_set.
- Rewrite patch message to account for changes.

Changelog v2:
- Redo the patch to utilize a more generic solution, not just fix the
  LAM and FRED feature bits.
- Note more feature flags that shouldn't be present.
- Add fixes and cc tags.

 arch/x86/kernel/cpu/common.c       | 3 ++-
 arch/x86/tools/cpufeaturemasks.awk | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 77afca95cced..061e91922725 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -704,7 +704,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 }
 
 /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
+	DISABLED_MASK_INIT_VALUES;
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
index 173d5bf2d999..6ebaa27f1275 100755
--- a/arch/x86/tools/cpufeaturemasks.awk
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -84,5 +84,11 @@ END {
 		printf "\t) & (1U << ((x) & 31)))\n\n";
 	}
 
+		printf "\n#define DISABLED_MASK_INIT_VALUES\t\t\t\\";
+		printf "\n\t{\t\t\t\t\t\t\\";
+		for (i = 0; i < ncapints; i++)
+			printf "\n\t\tDISABLED_MASK%d,\t\t\t\\", i;
+		printf "\n\t}\n\n";
+
 	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
 }
-- 
2.49.0


