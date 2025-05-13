Return-Path: <stable+bounces-144092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13943AB49D4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461177ADC6E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7281DE8AF;
	Tue, 13 May 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzfqG1Pw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEE1DD9D3
	for <stable@vger.kernel.org>; Tue, 13 May 2025 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105264; cv=none; b=VnB11lLZ/XEO49+9+TS2FVbFpfr2E9Na6REJ49ViYOHPKTcjCYFSvvtH9K5mth+NxRBEZvaKYL09I+wtU+a6J5luLnNQZRLDwfsTxnhY+oL0pyZZGBP8CJkD52+wHyUjVr3gO2O38WQX3lHC67flm/SEf78OVYqasQ9dW7e1tYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105264; c=relaxed/simple;
	bh=5NHavNtv3RDzqddKQnuU7SaWRGOTdW6NWDh6TE4/ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCSn/JxThwccplcrfQ3aH3KoggPGi808P75Uw1AssnfdUrvrIo3RhOlP7w6NFmjffktjNw0zOVQFlH2WiNJ4quJixR4XYE3c55mIuGjm7sG1FgiqtMcLSbA+OPWktZes/kuqy4HLc1ps6udQ7j+7KiKo7Bj1bFicXQuxHG9MTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzfqG1Pw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105262; x=1778641262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NHavNtv3RDzqddKQnuU7SaWRGOTdW6NWDh6TE4/ft8=;
  b=AzfqG1Pw/zdaP+ShLRHsBrSsHPChoGtZTUpxwgKTm4hrfUagSrHJaCHA
   LMF9ZVII3YkIDew5dGk0xO2A5isrtkE8GzSX0xxZean4zPDCr75XPoLHL
   dCu+HK8QECD/r0pyv3u22YhZZPijdvMCQQ5AUKHb4Ajg4AFylcZIn6eNV
   QndDjVpNCCh0jNuASLd8Lhw2RD0HSBFh7vMoMWYCCFzaWZhpnwpje6XdG
   Eg8kyQHvnXO84RWSGGE1Y1PzqszS1Xx8lsSh8uSI3GHtifE04d8xrjfFa
   2eG1XrVuCWJhEfV44ntYgmQYXoYcsK6MfipuwdrOBu4UqoOs3LgOl2Lpr
   w==;
X-CSE-ConnectionGUID: TExNilfmSvqf6kFn5xKDIw==
X-CSE-MsgGUID: tkxKFdMtT8ahcUo5zRuNmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59567771"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59567771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:01:02 -0700
X-CSE-ConnectionGUID: ck0aVveLSDiYAtMphdNvmQ==
X-CSE-MsgGUID: 6EIPf5dyRHq+MX4Lur6aEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="142331078"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:01:02 -0700
Date: Mon, 12 May 2025 20:01:01 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 13/14] x86/its: Align RETs in BHB clear sequence to
 avoid thunking
Message-ID: <20250512-its-5-15-v1-13-6a536223434d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>

commit f0cd7091cc5a032c8870b4285305d9172569d126 upstream.

The software mitigation for BHI is to execute BHB clear sequence at syscall
entry, and possibly after a cBPF program. ITS mitigation thunks RETs in the
lower half of the cacheline. This causes the RETs in the BHB clear sequence
to be thunked as well, adding unnecessary branches to the BHB clear
sequence.

Since the sequence is in hot path, align the RET instructions in the
sequence to avoid thunking.

This is how disassembly clear_bhb_loop() looks like after this change:

   0x44 <+4>:     mov    $0x5,%ecx
   0x49 <+9>:     call   0xffffffff81001d9b <clear_bhb_loop+91>
   0x4e <+14>:    jmp    0xffffffff81001de5 <clear_bhb_loop+165>
   0x53 <+19>:    int3
   ...
   0x9b <+91>:    call   0xffffffff81001dce <clear_bhb_loop+142>
   0xa0 <+96>:    ret
   0xa1 <+97>:    int3
   ...
   0xce <+142>:   mov    $0x5,%eax
   0xd3 <+147>:   jmp    0xffffffff81001dd6 <clear_bhb_loop+150>
   0xd5 <+149>:   nop
   0xd6 <+150>:   sub    $0x1,%eax
   0xd9 <+153>:   jne    0xffffffff81001dd3 <clear_bhb_loop+147>
   0xdb <+155>:   sub    $0x1,%ecx
   0xde <+158>:   jne    0xffffffff81001d9b <clear_bhb_loop+91>
   0xe0 <+160>:   ret
   0xe1 <+161>:   int3
   0xe2 <+162>:   int3
   0xe3 <+163>:   int3
   0xe4 <+164>:   int3
   0xe5 <+165>:   lfence
   0xe8 <+168>:   pop    %rbp
   0xe9 <+169>:   ret

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/entry_64.S | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f656c6e0e45882f261c9f61829a3c1f3e1e74167..ed74778c8ebd7fa4b80ed885d86fef638a1c4f26 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1530,7 +1530,9 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * ORC to unwind properly.
  *
  * The alignment is for performance and not for safety, and may be safely
- * refactored in the future if needed.
+ * refactored in the future if needed. The .skips are for safety, to ensure
+ * that all RETs are in the second half of a cacheline to mitigate Indirect
+ * Target Selection, rather than taking the slowpath via its_return_thunk.
  */
 SYM_FUNC_START(clear_bhb_loop)
 	push	%rbp
@@ -1540,10 +1542,22 @@ SYM_FUNC_START(clear_bhb_loop)
 	call	1f
 	jmp	5f
 	.align 64, 0xcc
+	/*
+	 * Shift instructions so that the RET is in the upper half of the
+	 * cacheline and don't take the slowpath to its_return_thunk.
+	 */
+	.skip 32 - (.Lret1 - 1f), 0xcc
 	ANNOTATE_INTRA_FUNCTION_CALL
 1:	call	2f
-	RET
+.Lret1:	RET
 	.align 64, 0xcc
+	/*
+	 * As above shift instructions for RET at .Lret2 as well.
+	 *
+	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
+	 * but some Clang versions (e.g. 18) don't like this.
+	 */
+	.skip 32 - 18, 0xcc
 2:	movl	$5, %eax
 3:	jmp	4f
 	nop
@@ -1551,7 +1565,7 @@ SYM_FUNC_START(clear_bhb_loop)
 	jnz	3b
 	sub	$1, %ecx
 	jnz	1b
-	RET
+.Lret2:	RET
 5:	lfence
 	pop	%rbp
 	RET

-- 
2.34.1



