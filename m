Return-Path: <stable+bounces-164607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0BB10ABB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E255188B273
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC01F2D4B5B;
	Thu, 24 Jul 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf6yVMhO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDE2D3ED7;
	Thu, 24 Jul 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361646; cv=none; b=SlEkQ5XYbSeKdF/yfESdColid7Ou+e1cnqC7iTyrUDM2iTXadSRtF3WNSq40ex3zUsJAYmC+rJvvpI+Whr/6aFGS/EcIekmaXbMGL1ltu4gfHU84ugosxxAQjdh1NlwCtEizWqif8AD+Qkx9A9KVXBsOwqFNZnVAhhmtXDYsYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361646; c=relaxed/simple;
	bh=o/HNMzmoL5jVJLbw/YCLhzRdjr7O65GLHlcUxrOksEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPHrbQkIcAeOnKyZKorDQQ4OiCEyT1WBajs+3c7x4QwlSv8svdNIOA+f03t2K796rhhopZSdJq6I/Icp/YK6dB/NAgYlkGWRMeJdtXFtJfNfraiHRA80qOMSalxzTXLt0ZXPkEndkmK2Vu64TqjMQuDLv1ZBo2vqCy7abGQ7ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf6yVMhO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753361645; x=1784897645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o/HNMzmoL5jVJLbw/YCLhzRdjr7O65GLHlcUxrOksEQ=;
  b=Bf6yVMhOeRIsghxSHSJD5FMRjub9HB4iu4YJ/RGj4MrUgJOjdXfuBpJU
   APoF/Vaw26XH3Idypn8KvSxOAdgDxXF/EFXOzkDbipk5LqO86dN5PFO06
   8Fbp3jm99ZN0P+wtSxWLiv8IwyfiiUoYlJuqTkjyjGUracDtcXzD33gYg
   UXWVzwrZitgOZ8yeqtJflDcWSth932KXOHUUlBPSKoLquwu7ugy9JaTsA
   TFirSTXOokNxWn4Yc9ukAcfVfVbIQaTGI5gQLmmvuMMQvS0SeuYD1GdF9
   w7q+VO5cARmMWyrIvYcHpmwN26/1BKaQmZpSQDZwbmlj9fz83c1oDF3V3
   Q==;
X-CSE-ConnectionGUID: tIwSoiWlSt2K79Q+plyrhA==
X-CSE-MsgGUID: xG6kZDVHQCqP7EbY0igc2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55778212"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55778212"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:54:04 -0700
X-CSE-ConnectionGUID: MvuiZzvORyu+oi7jI86Kdg==
X-CSE-MsgGUID: 8PZcJ1kUTCmTpJpYRniPwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="159981097"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:54:00 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>,
	Tony Luck <tony.luck@intel.com>
Cc: xin3.li@intel.com,
	maciej.wieczor-retman@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] x86: Clear feature bits disabled at compile-time
Date: Thu, 24 Jul 2025 14:53:46 +0200
Message-ID: <20250724125346.2792543-1-maciej.wieczor-retman@intel.com>
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

Add a DISABLED_MASK_INITIALIZER macro that creates an initializer list
filled with DISABLED_MASKx bitmasks.

Initialize the cpu_caps_cleared array with the autogenerated disabled
bitmask.

Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: <stable@vger.kernel.org>
---
Changelog v4:
- Fix macro name to match with the patch message.
- Add Peter's SoB.

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
index 77afca95cced..a9040038ad9d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -704,7 +704,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 }
 
 /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
+	DISABLED_MASK_INITIALIZER;
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
index 173d5bf2d999..1eabbc69f50d 100755
--- a/arch/x86/tools/cpufeaturemasks.awk
+++ b/arch/x86/tools/cpufeaturemasks.awk
@@ -84,5 +84,11 @@ END {
 		printf "\t) & (1U << ((x) & 31)))\n\n";
 	}
 
+		printf "\n#define DISABLED_MASK_INITIALIZER\t\t\t\\";
+		printf "\n\t{\t\t\t\t\t\t\\";
+		for (i = 0; i < ncapints; i++)
+			printf "\n\t\tDISABLED_MASK%d,\t\t\t\\", i;
+		printf "\n\t}\n\n";
+
 	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
 }
-- 
2.49.0


