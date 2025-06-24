Return-Path: <stable+bounces-158461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F85AE7131
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 23:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F553B2EBB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B71B0402;
	Tue, 24 Jun 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqhcTpYw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D04366;
	Tue, 24 Jun 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798912; cv=none; b=cgRtu6gXClS8ftRMUsYR0d9Tt+nC3XAini3b/m0DDWJwn68ELmiY8mrQjz/PhX42mHdqaet15Gm6yV/r4O+uYSVXDWKBuu/hhLwmQIE/DRmfJB99PKKGandPh7ih2WHxG3vLbW+S37Cna6TBo0rA4yE4NPhl99BKVq9TFfzs+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798912; c=relaxed/simple;
	bh=bMqshJkDZ9w34wfBJ4fDOC1gIdaYCEyKamwtCEgA/40=;
	h=Subject:To:Cc:From:Date:Message-Id; b=eWFdsXChKvAuPB47os9F5WgvUnzgv/GkGlUjjOXmuboHy/ZjYcEKwmZzpEHu9+nqPUcvS6u2XIe/yFXInwa8ymHOcjCtMPsJwPmqdUa2EINSqP+8/xrnc/V7zeFycM1Qn+hGWYoeN/hobOQROGKEHiCs8Vyd01uBsl9HAN92c6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqhcTpYw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750798911; x=1782334911;
  h=subject:to:cc:from:date:message-id;
  bh=bMqshJkDZ9w34wfBJ4fDOC1gIdaYCEyKamwtCEgA/40=;
  b=jqhcTpYwCfA2TMK9m+jTShbe/HVujNq2FQxq+gAXscaL9n09bbeGnrib
   1slfl8mSZavu9hd1qz1rTp8yOTmxMm73PsffcuFEXCazz1Xn4+h7h6G/h
   Spcx7i+llr9DGsf5ZSjxt8L3Mddu94eDafaVS+w4Nj9OW/5acbVQj9Gl/
   ez6i81x0mJ8i/WWlmEwxk4fIli/hhiBcVOL7XxTEp8vpbuZ061VwwIzbp
   iKdow2JBch/neYc9pypuVLs5uVnYw8JnHn4LiAj5VJMTZcOPQVFgm4hmR
   dmR6+GXv6coEQepvKObvpnZJn3i6Ow/1aknIjv133oetRKCvqcuePtmdN
   A==;
X-CSE-ConnectionGUID: CmFMfpmxT16lkrP63hnCbg==
X-CSE-MsgGUID: HGfEQHFoQl+AZBt67dfALQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64488307"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64488307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 14:01:51 -0700
X-CSE-ConnectionGUID: BZp4o3vOR6q8a7JjP9O4bA==
X-CSE-MsgGUID: p9udsA64S36RYhCDqDSm3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="189214103"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa001.jf.intel.com with ESMTP; 24 Jun 2025 14:01:50 -0700
Subject: [PATCH] [v2] x86/fpu: Delay instruction pointer fixup until after warning
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, chao.gao@intel.com, Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, Chang S. Bae <chang.seok.bae@intel.com>, Eric Biggers <ebiggers@google.com>, Rik van Riel <riel@redhat.com>, stable@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:01:48 -0700
Message-Id: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


Changes from v1:
 * Fix minor typos
 * Use the more generic and standard ex_handler_default(). Had the
   original code used this helper, the bug would not have been there
   in the first place.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

Right now, if XRSTOR fails a console message like this is be printed:

	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.

However, the text location (...+0x9a in this case) is the instruction
*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
also points one instruction late.

The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
keep on running after returning from the #GP handler. But it does this
fixup before warning.

The resulting warning output is nonsensical because it looks like the
non-FPU-related instruction is #GP'ing.

Do not fix up RIP until after printing the warning. Do this by using
the more generic and standard ex_handler_default().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
Acked-by: Alison Schofield <alison.schofield@intel.com>
Cc: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
---

 b/arch/x86/mm/extable.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/x86/mm/extable.c~fixup-fpu-gp-ip-later arch/x86/mm/extable.c
--- a/arch/x86/mm/extable.c~fixup-fpu-gp-ip-later	2025-06-24 13:58:09.722855233 -0700
+++ b/arch/x86/mm/extable.c	2025-06-24 13:58:09.736856435 -0700
@@ -122,13 +122,12 @@ static bool ex_handler_sgx(const struct
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	fpu_reset_from_exception_fixup();
-	return true;
+
+	return ex_handler_default(fixup, regs);
 }
 
 /*
_

