Return-Path: <stable+bounces-164403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA4B0EE4D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A22F5682E7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11043285C90;
	Wed, 23 Jul 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvW3NjYL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DD205AB6;
	Wed, 23 Jul 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262587; cv=none; b=mFk8LCTyyYNSnwbCB16r3GYgPM4GwB4FN4SgePXu6k+IriURrQgl9FgHb8YP6qvbY1u2hbBCuaM1XHXYHDENvMf2IVzlwnTcelsykT1Omprad8K/JBXEHsF7AvI+GHXYDK8I5N3YomYFv0H/ZgxCkx+UCCGvbto7Q0fe6hkcoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262587; c=relaxed/simple;
	bh=Go8854Dtc7BWnZRFCk+SiNto+kngeXqWSUu0T1Jtgpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSIAVe5il7o7vYfNBi7L0/CaxUPKNs0hXviJE381y0mPyp8/sWFSH7ldY5281LKUa8lm1TkXHYXqRNPZOiokXhLXDoXiHrieDf4cPKqTIUElL4Sv/5Ulb/wSatZA9lPv7oVM1xDA9ad6z6ESbPn0uEVDVjRnMWFNiY5uygyQVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvW3NjYL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753262586; x=1784798586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Go8854Dtc7BWnZRFCk+SiNto+kngeXqWSUu0T1Jtgpg=;
  b=EvW3NjYLC5X2/OOEOeZ3GovdzTXkuCP6gzcwgABwtKLLiBVgNUfeesPa
   yyR3eBGdGfmaTsqwEh/I6SBur28BoW2s292MU2xsz3tYrD1Vxb2UNc7re
   8uAYzIoPm1ikjez1rUqrTWt3bN/PLQQgq+Mmt8xOKCuuMGx0Kbw6BA1Qk
   F3ovARwsYybIiV9b8tUQkB+Jjdvj/QvmQVHo2SKfWcvxAYnpEgGEp+cNz
   TbBMY5rQf1YQjA0D+NGxFde9Mwa7UjZ++ZsZJALpgRfXsoOzIqip4G1aT
   QqS+6RzMDK+++K5qf6ZMLuMBHnU+zZHtIlbMdglPYHv2mQA79gnHYAwTe
   g==;
X-CSE-ConnectionGUID: jm/s2xJ8R46I0Yt6xp8gyw==
X-CSE-MsgGUID: NFGbNqvbRJucpT2u+kA+XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="73113182"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="73113182"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 02:23:05 -0700
X-CSE-ConnectionGUID: nKVIQAM7S4mXgZhgzLPIOg==
X-CSE-MsgGUID: zfgZgSy5TUSIaNJQht/Buw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190359308"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 02:22:59 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Sai Praneeth <sai.praneeth.prakhya@intel.com>,
	Jethro Beekman <jethro@fortanix.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: maciej.wieczor-retman@intel.com,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86: Clear feature bits disabled at compile-time
Date: Wed, 23 Jul 2025 11:22:49 +0200
Message-ID: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
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

Add a DISABLED_MASK() macro that returns 32 bit chunks of the disabled
feature bits bitmask.

Initialize the cpu_caps_cleared and cpu_caps_set arrays with the
contents of the disabled and required bitmasks respectively. Then let
apply_forced_caps() clear/set these feature bits in the x86_capability.

Fixes: 6449dcb0cac7 ("x86: CPUID and CR3/CR4 flags for Linear Address Masking")
Fixes: 51c158f7aacc ("x86/cpufeatures: Add the CPU feature bit for FRED")
Fixes: 706d51681d63 ("x86/speculation: Support Enhanced IBRS on future CPUs")
Fixes: e7b6385b01d8 ("x86/cpufeatures: Add Intel SGX hardware bits")
Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Fixes: 701fb66d576e ("x86/cpufeatures: Add CPU feature flags for shadow stacks")
Fixes: ff4f82816dff ("x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org>
---
Changelog v2:
- Redo the patch to utilize a more generic solution, not just fix the
  LAM and FRED feature bits.
- Note more feature flags that shouldn't be present.
- Add fixes and cc tags.

 arch/x86/kernel/cpu/common.c       | 12 ++++++++++++
 arch/x86/tools/cpufeaturemasks.awk |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 77afca95cced..ba8b5fba8552 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1709,6 +1709,16 @@ static void __init cpu_parse_early_param(void)
 	}
 }
 
+static __init void init_cpu_cap(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < NCAPINTS; i++) {
+		cpu_caps_set[i] = REQUIRED_MASK(i);
+		cpu_caps_cleared[i] = DISABLED_MASK(i);
+	}
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1782,6 +1792,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
+	init_cpu_cap(c);
+
 	detect_nopl();
 }
 
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
index 173d5bf2d999..2e2412f7681f 100755
--- a/arch/x86/tools/cpufeaturemasks.awk
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -82,6 +82,14 @@ END {
 		}
 		printf " 0\t\\\n";
 		printf "\t) & (1U << ((x) & 31)))\n\n";
+
+		printf "\n#define %s_MASK(x)\t\t\t\t\\\n", s;
+		printf "\t((\t\t\t\t";
+		for (i = 0; i < ncapints; i++) {
+			if (masks[i])
+				printf "\t\t\\\n\t\t(x) == %2d ? %s_MASK%d :", i, s, i;
+		}
+		printf " 0))\t\\\n\n";
 	}
 
 	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
-- 
2.49.0


