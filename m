Return-Path: <stable+bounces-154603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C7ADE028
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7A33A7B89
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC07080D;
	Wed, 18 Jun 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vjtw5xGv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF82F5301
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207478; cv=none; b=gFcwd5QwkzOVDqBQWrTbGXYoCBFkUWlNA5bmlQbbV0e7hhLjVNmRPHb9g+6GvZFL/Ns0s6t/W0KYjEZOXUGOL+qVh3b0fLoNlFuVKuSsUPZqOsVxf1ZDam6cXE7ehOMmmlyvo3lhwfInaOh4BPJdvLjmiykVZxRyHhiX+7/86NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207478; c=relaxed/simple;
	bh=+OCjzt7Hm1fDvLlvOat5Qko0krtCPREhW5E2/bU/04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxLtnZuaepOI+wlA/qB6JtJMpSBNPzJtpvdwNF/TB6ZJCqEFFSrGo480g+BIEvAf+p4C+CaqucWCzKxWvrEpVE61d0KJNjuS8205XGlJeRd6i8uC5dNTIzt5xEWuKRUcN3CgTj8OVqWTmADXXOiRfK9oyKFueGjsqF+kiaEK4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vjtw5xGv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207478; x=1781743478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+OCjzt7Hm1fDvLlvOat5Qko0krtCPREhW5E2/bU/04A=;
  b=Vjtw5xGv9PoC8jus1PBlbh3Ygi3VISM/VgoEBRmRaybhNwr+tZs4RUK1
   TOIEruuLlWH88xxNSvuXm/1qhSeBL+IVCihNyv7ZqhgB+LrfwYOMgBgKQ
   ftM3V9ixn36sYC0syzM9c1tZOcCMs0I7wPztTEn/ecQAJ1aZk8AswazID
   6hy1WoVggASyHHCoK3crLc5R+3388e1mDSnYLo1dzdfM+U7Zh5DBGnRhX
   9GbO0uWunskvzr54Yjf+5rz6wOFuIsr/bzU24f7S/jmO0vYTDpEgEFLLj
   5NBQjHqF4TUJbRAX+2eLEBVww379KEJM1jwB2vqHRtfO8WJcc69nHQver
   g==;
X-CSE-ConnectionGUID: I/eSWWOaRjSJS/Cd9FagaQ==
X-CSE-MsgGUID: 3+aUhJA/RQmHWu6salEg6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52271754"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52271754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:37 -0700
X-CSE-ConnectionGUID: 1y0Gre1SR1SeiCH2kerM1A==
X-CSE-MsgGUID: xY432VmgQCWsJpLbpmt51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153746177"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:37 -0700
Date: Tue, 17 Jun 2025 17:44:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.10 v2 02/16] x86/bhi: Define SPEC_CTRL_BHI_DIS_S
Message-ID: <20250617-its-5-10-v2-2-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

From: Daniel Sneddon <daniel.sneddon@linux.intel.com>

commit 0f4a837615ff925ba62648d280a861adf1582df7 upstream.

Newer processors supports a hardware control BHI_DIS_S to mitigate
Branch History Injection (BHI). Setting BHI_DIS_S protects the kernel
from userspace BHI attacks without having to manually overwrite the
branch history.

Define MSR_SPEC_CTRL bit BHI_DIS_S and its enumeration CPUID.BHI_CTRL.
Mitigation is enabled later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/include/asm/msr-index.h   | 5 ++++-
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3365ec97376..52810a7f6b11 100644
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
index 7fd03f4ff9ed..d6a1ad1ee86e 100644
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
index f1cd1b6fb99e..53a9a55dc086 100644
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
2.43.0



