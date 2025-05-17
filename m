Return-Path: <stable+bounces-144646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CAABA6D5
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC445A23A1B
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06214101C8;
	Sat, 17 May 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lke/M/je"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599794B1E7A
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440033; cv=none; b=Ih4cdwe25eG98fps0jRriNgYcY8kfNwOyeftGgdRPyQUX9SemmE49SQpcTEH/Anu6QjdREzk9thYigCK+CnOFWNgGZAJuEa83xRN1yp4FHRaqilPtPZUa6bzsHLOOqRT0KRpaZBGFtfk8Bqp2FQx/PqIQy8M95HVCtXycoR+PJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440033; c=relaxed/simple;
	bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnHJsGuzeqd/oYTVTWiAJl1j0cn3zz5MRr6111RDiPcpBcTl78YTWa9/vHCGcwY/7fLMh5M6tF2xplUqniwcPNYMnL0BQrJJ5ofPktqq2RUjl/ygPg+xb+nAlc9zaN97N2bFHWmnHunJOmSrjdSHbBGlkWNnfvJmUzb0nwxaEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lke/M/je; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440032; x=1778976032;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=XlTJbiueJinftVairJQROOU7wHnezx25T+4wD+M7otY=;
  b=Lke/M/jeQ3cDQv3mVq5qOfCMntD5I20IaTN+KWxfF4ZPddIQfilRNYVc
   5C59g1ejYgI5oDmKzoQ5vjkRyA/OTKb6ldxcnNbxElUJUBhJJ4y39EA4c
   jgIjQYiE/Psh/xIBM7k1FgYAk8xCWD9+awXVUZKyeSM3aW7cQNyx6+JY2
   oB/J3A29WgQ4cQaiNyYblOiPhC4pvNXCcWP8OtmwuS9PKORyu0MT4z1b2
   7sqiPTqCageMoex/yMtuwRHBNlXPIb2N78qErGqo9yfxSNqC+S9BEDIM4
   Z+0RL/tMDWkpSi2/0a2VVzc46k0Jekvjewhs8CJYInDiqPRD7zBNw0+ak
   A==;
X-CSE-ConnectionGUID: 1VudQbgYSranv9I86FSbbw==
X-CSE-MsgGUID: JXavXzYeQyOQCAkjGqk3dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="37043613"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="37043613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:31 -0700
X-CSE-ConnectionGUID: awSyEuipTTmPOuXdbOGFkw==
X-CSE-MsgGUID: NnFXtdvLQIyxcMqgGBO5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="139851343"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:31 -0700
Date: Fri, 16 May 2025 17:00:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15 v3 04/16] x86/speculation: Remove the extra #ifdef
 around CALL_NOSPEC
Message-ID: <20250516-its-5-15-v3-4-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

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



