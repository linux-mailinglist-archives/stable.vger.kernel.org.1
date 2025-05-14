Return-Path: <stable+bounces-144326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B3AB62C5
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840394613E0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6181F428C;
	Wed, 14 May 2025 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZRAx9K1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95D1F5E6
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203003; cv=none; b=WGXD4Oiil6zFZD1FFBJvlZoiBIzyfMJyTrNqSOv80aLKv8rqgTKq3bWY0TUrV8rbIYi+be4uDHeAIWd/LtdeXS5O8XN2RMrtEOU1m4KNHaMIXOvo0ruQ7S8oo76ZsUnLuIJ4LNmFFiMEJBG8j99WJAnJ8Vn1erRgzPcnLDymPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203003; c=relaxed/simple;
	bh=5NHavNtv3RDzqddKQnuU7SaWRGOTdW6NWDh6TE4/ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hur/eTMsKRSfwzsd/YBCeyW4/Ndf9k4TJJI6vjnKAD6m/7tIPhWeH+c7VVG52i/2ZwNJcaDCnsPks0hIzj1an221H2/6dKXVqg0EtI6PzVIMr57xBahJt3/VwLOKFRIEAjECawrPI80s9yF57KJ/2rM6QrJrpi7M307Apjdk3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZRAx9K1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747203002; x=1778739002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NHavNtv3RDzqddKQnuU7SaWRGOTdW6NWDh6TE4/ft8=;
  b=dZRAx9K18G5ApOUW3bhbp16bVrFV5+Z1HTGJ44ovPLN66f7pZQbFwhkS
   3LH6d1CHXR3HtRJGfU8Ry8NEKlX5Wyu0x9mFDbe9bM7lPQFdMt6Ipmf5w
   0Nt6rB/ur2CxEnmcJAw0AY2isce3LWCH68300+mXnrJDjqB1axG0GiaJ2
   WuHMHRsPq63NVWAeURkzj8n2EiBYEbyhVCjiKzsWOI1SAwSMgsoIZ+aeV
   jKTc2gp4YNIaIm9f2hpl8YgEUxvI6gOTeka9nsV9B2UpTF7zehzLA4cBb
   zGTuiRiCMeqk3mWCjBzgUXnMLLjgkCM2Q76V0bIKdXtjdOYy8pVKIMzp0
   w==;
X-CSE-ConnectionGUID: 61dAJtidTuWBdyL9J/bXpA==
X-CSE-MsgGUID: BUoM25CgRtSsNSo9yJetDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48191049"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="48191049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:10:02 -0700
X-CSE-ConnectionGUID: rUHVzdL3T+OzBfVGKC2mwQ==
X-CSE-MsgGUID: qjWXIyFcRy2iSKUGczsv+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="137982307"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:10:01 -0700
Date: Tue, 13 May 2025 23:10:00 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v2 13/14] x86/its: Align RETs in BHB clear sequence to
 avoid thunking
Message-ID: <20250513-its-5-15-v2-13-90690efdc7e0@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>

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



