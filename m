Return-Path: <stable+bounces-144317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBEDAB62B8
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ECE4639C9
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AF1EFFAC;
	Wed, 14 May 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQoBnWPh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44334433A8
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202863; cv=none; b=XKRcHhQ6kUdDnszOMi2P/rWu0fCN8QJx0TUb8YiGuHSW9QOS5uCVjdoJWWH+pnRtVnR0AxWC9YvKtxJpOANEN6gHgYUA9DUnlcdEIcSwU8x0I3HjqwgV834c0/89JAfbGO3CIeB1IgZSp13ECpV9EWgc7h+Yj4CxsjJMdbyCSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202863; c=relaxed/simple;
	bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGsxgKgFPYjhH2Ufu5J/lDhcyvHBXqpoQRU/IOkchqJD2bgXBaS3EVSdhxmXbyfuP5PAQRrraEugLfM7NSDhWYYQzoHPDBP/TcCuE5vA03do+vWATV4BWiGbIF2k6VAG9oDzJgMB1Qz+HV/TPFNJfoOSHjpXPohSe46jalHCYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQoBnWPh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202862; x=1778738862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
  b=gQoBnWPhrToP+1es4GY9b1FOuTOT7Ke2iHNXUsUJwHKL+EQ7LlqzMG/+
   7GQMjMl/7x6eaaSLqBpV/z1kVa/nLV5ZJ9TZjOvxIabCklMIx1nbEP6Pm
   Ijj4kkfqtjFSdrou6v/y4y201D52j/OjhH6TUSDuSyW+T8h7TaW7qTzYR
   2dL6lKJ7rEdQnb0zhvNQEA35KxVaDt2uSuLHZPDugW0JQmV+XtgS32gQq
   MfOcdowXq8/q44BI/908WPs3GTndtj99Ikztv6JbzvMq4ZpqztKmKUCSc
   2BcMmRID2hw6zK6PA32RcldBtZo+6RVooIAZdfSvtK6wsSalEjoT9viXs
   Q==;
X-CSE-ConnectionGUID: V/K1P3xFQfiU7f5tj4FlYw==
X-CSE-MsgGUID: FzR3EEW/QfmJNe3sJzmKjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="36706879"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="36706879"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:42 -0700
X-CSE-ConnectionGUID: I7HOUCjETJiteQHHeXQ7Gg==
X-CSE-MsgGUID: U2nM8ERsRnm5wC8irIXkNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="168883898"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:07:42 -0700
Date: Tue, 13 May 2025 23:07:41 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15 v2 04/14] x86/speculation: Remove the extra #ifdef
 around CALL_NOSPEC
Message-ID: <20250513-its-5-15-v2-4-90690efdc7e0@linux.intel.com>
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



