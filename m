Return-Path: <stable+bounces-144081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44FAB49C7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928124A01EC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF71D47B4;
	Tue, 13 May 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7ARl90F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606801C2437
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105124; cv=none; b=jnSyhpEKMFtRQF6oHwZtokq2lBES5us4e0zAGVNfImne6HSVMbLJXr3JyS12SPTBaBTvQKmmDFRXYVXaavfVyS50JuqeW+QYTrWKrWg2D815qCyavqtv6YPSmIAGyXJCqzSExBXD7+pmkYFQvIQ7CtOEo9efBjlo11c9h77zsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105124; c=relaxed/simple;
	bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+utlubibsktZ/sAkL0NHTeH6gu65LgRu2t5bQOjCA7g2DZYcVYeGu2LN4EK0cM75a37LjcOOiQt4Ls8Ac4IrFLdpL447S/PUl+7jn5GjTDMPeomvOYqh6c2UfY6A2teu380NAnyaOe6f+yKbkqRtZQFAW8oRJnn87pPCUg5/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7ARl90F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105123; x=1778641123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
  b=C7ARl90Fon6IsjHFSvJoJLQqPuf7W3L+KfRdJwGQjrutJwTVaCZibLew
   LhE8lkKsnzdZ9w6kF6bD9ZRiaxHqueFwPrDgoZzaxgaW0mrEnY5bUmEf/
   u+GYTNfj70Q2ISUd/ajHJEh9M70yGBOFhCxR4VU4Ln0BkObKu8zH1lqZ1
   NB9fqp3U0Ssla1uEDlvb6t+jk9JdCRLa95Ke40u1HIYYGwOK1GOekGGuq
   6riCxgo3ZWhI3345DRLB1xDEqua9WsDOAgH0AEF5LA86h5zAZTD2hDgeT
   JQFUP/Yw8J3FHhD6Bj8tUAaukWIS3d0u6YRFfiHYzm/Y8oaxCxaFJj3LM
   g==;
X-CSE-ConnectionGUID: vWQ8Nt4mSXyonXzu1jaJfA==
X-CSE-MsgGUID: CE34B6cMQ9CKFOVxCP4a+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="51583642"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="51583642"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:42 -0700
X-CSE-ConnectionGUID: z38kFbTnSp+uVn1BcwjfDA==
X-CSE-MsgGUID: J8wtt9mnRBegNSAsyJ/4Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137576435"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:58:42 -0700
Date: Mon, 12 May 2025 19:58:41 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 04/14] x86/speculation: Remove the extra #ifdef around
 CALL_NOSPEC
Message-ID: <20250512-its-5-15-v1-4-6a536223434d@linux.intel.com>
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

commit c8c81458863ab686cda4fe1e603fccaae0f12460 upstream.

Commit:

  010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC consistent")

added an #ifdef CONFIG_RETPOLINE around the CALL_NOSPEC definition. This is
not required as this code is already under a larger #ifdef.

Remove the extra #ifdef, no functional change.

vmlinux size remains same before and after this change:

 CONFIG_RETPOLINE=y:
      text       data        bss         dec        hex    filename
  25434752    7342290    2301212    35078254    217406e    vmlinux.before
  25434752    7342290    2301212    35078254    217406e    vmlinux.after

 # CONFIG_RETPOLINE is not set:
      text       data        bss         dec        hex    filename
  22943094    6214994    1550152    30708240    1d49210    vmlinux.before
  22943094    6214994    1550152    30708240    1d49210    vmlinux.after

  [ pawan: s/CONFIG_MITIGATION_RETPOLINE/CONFIG_RETPOLINE/ ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 9b16113687e21e0a272ec2fa13b7f144efe833a7..79f51824fad3938032bd994709e46f1171c1b70c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -295,12 +295,8 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
-#ifdef CONFIG_RETPOLINE
 #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
 			"call __x86_indirect_thunk_%V[thunk_target]\n"
-#else
-#define CALL_NOSPEC	"call *%[thunk_target]\n"
-#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 

-- 
2.34.1



