Return-Path: <stable+bounces-164592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3290B10801
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6882AE3CC7
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC542260569;
	Thu, 24 Jul 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSb8hnrQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E81FDD;
	Thu, 24 Jul 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353972; cv=none; b=Ow55CzkTMSMdGEerHXOQK8P5uwZmUS8R/quXRkvQAAsNmgyqXseKBbfdh/73tEZHfRX+XRtHzQwVuj+OjwGabZZ3/rBW0XibbzfafB/+0x2TmrbrE4sba846mD3GsrCZmivwhpCQ81TCYElEjxn65CFhq8OCxEN5hB9K9fxDe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353972; c=relaxed/simple;
	bh=UVfFglqDP7SGTOdQNAVRwkBbVVWG0gISNs18EqhC7E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4OYgU2eU3uHh1UZCpK7PO1qz9H6qFnYDUItWiVYxfaJfSwp2NaihRhVHeX8BOtNEfBqzHeDUu6cddmESdBem0TqUpd+JM5hUaqYCTbIhkid2hI3I0bNg5oMckzYFtLn7AR0vazU3zsjtWhIB2PWwBec3hLM77uFrEnYvBNvx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSb8hnrQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753353971; x=1784889971;
  h=from:to:cc:subject:date:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=UVfFglqDP7SGTOdQNAVRwkBbVVWG0gISNs18EqhC7E4=;
  b=XSb8hnrQq9aO9kNU8jmLEEnBjwRhfVXB0oR3QqCAf/iJ06WJt/+1BIH+
   9HwI9oYgLWPJ9cP8kndgQdXQVLtf2Fk0SU0MEhmmoAi+elBI2eiwnpmpd
   Nyw4bCXSUtD/tjEntvQOB+AjyUeGFoB3zT3RYh56EaTiJI0cgtJST3uZ2
   ZwBSXU40fILh/qTS5EZoKWi30X8hDb5G0x+PWaC0VHxAOCLKgX0nd60A6
   uQWylgP3XGQQdYdCjBC8xsNz7PzUT0PozTonyy/nm1iIz48FAnBHCTL1+
   HRUKLpFEfWKIqEBA8i7SohdLDHZ9Po3syFEuYwSwsMlZGh8Vz3vSe9M+/
   Q==;
X-CSE-ConnectionGUID: jY5l7oQ8ToisMNWBw3DEsg==
X-CSE-MsgGUID: umm/LLzwRjyFSndkGUUlOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55767455"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55767455"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:46:10 -0700
X-CSE-ConnectionGUID: Jhc+iC4+QR+gHfgEjjBrqw==
X-CSE-MsgGUID: a/dI7zPiT9uyLI1WBSgNBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="160886532"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:46:05 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>
Cc: xin3.li@intel.com,
	maciej.wieczor-retman@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] x86: Clear feature bits disabled at compile-time
Date: Thu, 24 Jul 2025 12:45:35 +0200
Message-ID: <20250724104539.2416468-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.49.0
Reply-To: 20250724094554.2153919-1-maciej.wieczor-retman@intel.com
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
Resend:
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


