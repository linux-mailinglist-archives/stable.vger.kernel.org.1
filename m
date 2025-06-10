Return-Path: <stable+bounces-152326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5EAD4280
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670B717B8F5
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3725F993;
	Tue, 10 Jun 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSojEKqL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C42494C2
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582423; cv=none; b=jsk2/bwhKkUMA/BZKjvGDq4Sux4K2SUyU04c6MBt78aUvzMvIkCkzc0YBIAXBWklcMY4HBl02/op1cDHVaqWuDJJFcQ7SCXCczJUjo0lYjZtEK/HxsemmO3QIIQN0VaFj77xca5Ji1DdjV2GG3nMKJgrer0G8bX79XuaZH0TAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582423; c=relaxed/simple;
	bh=zFy9Kuu17ZY+HR9BTjQE27jyGgWPD4qhuULCRNj/naQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvkc7u+VzTvfhTZNcd77Qo43vlRDEvF3kZgk3WQiIzyEqhnH1yECKbacRzva/mLvONLtIii7o/H9Wfzm4GWjoDduki+e45OsNbunbMMTot2oqu1y585STam3ILYm6xfNxKwvtUY24P83R82fMhZEq2Oh+WSeDvGC/HNS26qsaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSojEKqL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749582421; x=1781118421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFy9Kuu17ZY+HR9BTjQE27jyGgWPD4qhuULCRNj/naQ=;
  b=DSojEKqLmPJOehQE2Rp5p9OjM+T2zGIbaFhMwm3W/M+kGfeiKS+DTS2C
   KK8YiU3XYHPjGHzEF+fWwoWqc8N6dB6SNXNbLVvfnJ+6QB4OKGlZMfvwp
   fkmSwUva+5//1CRmukP5tlB0Jq7jHrxZZTOMgVYNEvrnTVOzT68sCQimn
   sIvzBB5qUf4vgUs29f0IRw6JiDGYWkYtgXFMCTzYb0qqM0J5475euMpdO
   gdljFe4xEV1Yi3kFT/ru06nnnNJOVhKHVzmiky6s8TCktBMUyigjdG6vD
   M8aFRBHhZBH6782bNMpjHLx/cNuh8mbDLPardv2gMf+vSXeCsyz7/8KD8
   w==;
X-CSE-ConnectionGUID: BftTg19eQO2JeuSK2n60jQ==
X-CSE-MsgGUID: yJ7bzxbwTACRqReuT9FCSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51566818"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51566818"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:07:01 -0700
X-CSE-ConnectionGUID: cAe4QttaQsi6YE2LxTk/Ag==
X-CSE-MsgGUID: GWEXJt/rRtei61B7Q7TB5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151815088"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:07:00 -0700
Date: Tue, 10 Jun 2025 12:06:59 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [RFC PATCH 5.10 02/16] x86/bhi: Define SPEC_CTRL_BHI_DIS_S
Message-ID: <20250610-its-5-10-v1-2-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

From: Daniel Sneddon <daniel.sneddon@linux.intel.com>

commit 0f4a837615ff925ba62648d280a861adf1582df7 upstream.

Newer processors supports a hardware control BHI_DIS_S to mitigate
Branch History Injection (BHI). Setting BHI_DIS_S protects the kernel
from userspace BHI attacks without having to manually overwrite the
branch history.

Define MSR_SPEC_CTRL bit BHI_DIS_S and its enumeration CPUID.BHI_CTRL.
Mitigation is enabled later.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/include/asm/msr-index.h   | 5 ++++-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3365ec973763bbfe94c335ee9811f93272b0c80..52810a7f6b115c6d702976ee0fe38cab5c49ae4a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -289,7 +289,7 @@
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
-/* FREE!				(11*32+ 8) */
+#define X86_FEATURE_BHI_CTRL		(11*32+ 8) /* "" BHI_DIS_S HW control available */
 /* FREE!				(11*32+ 9) */
 #define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
 #define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 7fd03f4ff9ed29d6e8deee29931ff0453142b902..d6a1ad1ee86e7c871a5c1959b4faaf2fd398034f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -55,10 +55,13 @@
 #define SPEC_CTRL_SSBD			BIT(SPEC_CTRL_SSBD_SHIFT)	/* Speculative Store Bypass Disable */
 #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
 #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
+#define SPEC_CTRL_BHI_DIS_S_SHIFT	10	   /* Disable Branch History Injection behavior */
+#define SPEC_CTRL_BHI_DIS_S		BIT(SPEC_CTRL_BHI_DIS_S_SHIFT)
 
 /* A mask for bits which the kernel toggles when controlling mitigations */
 #define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
-							| SPEC_CTRL_RRSBA_DIS_S)
+							| SPEC_CTRL_RRSBA_DIS_S \
+							| SPEC_CTRL_BHI_DIS_S)
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index f1cd1b6fb99ef5696c71a47304eff45c34597f91..53a9a55dc0866ba10f5a97f5b7fcc9a728be83e2 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -27,6 +27,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
+	{ X86_FEATURE_BHI_CTRL,		CPUID_EDX,  4, 0x00000007, 2 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },

-- 
2.34.1



