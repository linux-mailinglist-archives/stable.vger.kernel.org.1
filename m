Return-Path: <stable+bounces-152334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88754AD4307
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150681897B85
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49237264638;
	Tue, 10 Jun 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joBzuS+t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCE238C20
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584578; cv=none; b=V0wWHhMWJ467rlzxFqIVymP/zbTjEch9e9xnxJTn8TGqOBUAL9VpjiVc4fG5/PKbfFGdlw0YIcMwQhRjyBNGeWSl4dPVeAvonqL4wYOuenBRe4pZ3uTs7E4ENkAHyrBOlhM5EKv1epRSJqc/5sydOKXdb/fqH3wSo4PreyyBEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584578; c=relaxed/simple;
	bh=QbTj6TZiA6BKJCFYiWz0gHTvjQj56kKPuGpfI0SkvP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhjOUoLEZKF6dkefSPhJJfL5/FfOBTFQFEM/v+ynEhrlIkxhaNPD7fgv2E995vUIVxpcE01ydc9+VDPq+7tvADnek+E4D9fNCdprWdoUYJ2xblGNey9cmcmyrBQhWA9G8Ew6WxNxJp84t4n4hcDv7EFxoSiyOHGGhv/hMs4lLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joBzuS+t; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584577; x=1781120577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QbTj6TZiA6BKJCFYiWz0gHTvjQj56kKPuGpfI0SkvP0=;
  b=joBzuS+tz0i4Bim3nJkFWBLB4/MaHii5aYj8O+8AMd6++o9JJPxLUDIJ
   3cvs6KybNjAay1d754+1vBN7TX5Buh0WHUrlo7rqVdUI+gwalYcOrom92
   JsLsS+8GYjSEUgo2K96dTYtF7MIhmKWT/bMGtrRJPgxIg7BKOTYtzaYj8
   I/tSdwGkOm6flFE85SRXFOZ6V5H0Wr3IXVjnngkoOsfbDzGbbBKbezm5Z
   zBACWuZxuODhwspZ5v4UipVeaD/acRU5fcHNH1YPnSPfVagVmsF9gt2pF
   yAY0JoU/VnsiRvLoCbQpOBFnRQDsHrFHy1jPR/ZcdsDdeYfiRucuH7tYR
   g==;
X-CSE-ConnectionGUID: gqx6dehyT72m0GmG6cVkOw==
X-CSE-MsgGUID: Q9U+laiXQmepBh/R7myRag==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51421458"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51421458"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:57 -0700
X-CSE-ConnectionGUID: J60+D8oCRyaZzFBHujhlBQ==
X-CSE-MsgGUID: v9boVKKZRuWtpzZ1SJ/clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147875854"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:42:56 -0700
Date: Tue, 10 Jun 2025 12:42:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 5.10 10/16] x86/its: Fix undefined reference to
 cpu_wants_rethunk_at()
Message-ID: <20250610-its-5-10-v1-10-64f0ae98c98d@linux.intel.com>
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

Below error was reported in a 32-bit kernel build:

  static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
  make[1]: [Makefile:1234: vmlinux] Error

This is because the definition of cpu_wants_rethunk_at() depends on
CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.

Define the empty function for CONFIG_STACK_VALIDATION=n, rethunk mitigation
is anyways not supported without it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 5d19a0574b75 ("x86/its: Add support for ITS-safe return thunk")
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7f33c1e052b7724db10fe23c1dfc63ab09dd2c9..4b9a2842f90e972a5569a363479c5885bd919287 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -80,7 +80,7 @@ extern void apply_returns(s32 *start, s32 *end);
 
 struct module;
 
-#ifdef CONFIG_RETHUNK
+#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
 extern bool cpu_wants_rethunk(void);
 extern bool cpu_wants_rethunk_at(void *addr);
 #else

-- 
2.34.1



