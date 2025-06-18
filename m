Return-Path: <stable+bounces-154611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C7ADE033
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6E3AEC45
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA25208A7;
	Wed, 18 Jun 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5AaRb0i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A829A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207601; cv=none; b=L6Y/NFoOxFSiBrPn5/29RdS9UXkZDhwuaXAkbpjRT7V8cg74R+pdZrpGTynpwqqOfp1RZBiNEcxv0gIy1ivKw5xn6gIqm4liwLwePbMd+iIrEo/0yhSjyIav4pMCUC60/51s0hIKMvVxsP/m5Ei561YTAGmnOy8yx4M7+3cqJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207601; c=relaxed/simple;
	bh=N45UxSeG/FD2S1YEQZF+lhXcVEgyxhsZEEx3qdv67wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY9KlpT/BPMDaDayj1pkyi/O3zPhHUC7inB6+DNyfbStFBpUU99Ejvi3SY+ZDzqbcqqzbRbObuxU6lvzYFkhx64lcmbQSQWVjJm4ZkcC+OjWr2YB2n5yG8wThJb0RmbWqqpjzIDlcsuH1OQqEUyhwGe1SHMa5jwM6XWKy9Bg9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5AaRb0i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207600; x=1781743600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N45UxSeG/FD2S1YEQZF+lhXcVEgyxhsZEEx3qdv67wc=;
  b=Q5AaRb0ipg6E3jZFhWbfUvqcg4h7Yhcn+HVCWTawFBHyNmWang1ilCOJ
   ACzZ7JmWrmJxva48YnSsBIm7U8A4NGDkUMmawgJESUSOei/i1rx5T5Z1X
   qcJ8EYPYs0EZTk/y9ygP18c/TznHu0ebTrMTWJc0ryuc1RV7qUuyP3k2X
   i0OTN35UGY34Ft2cCaieBGQDab7o8IB9M6rtNSq2/4zOOOE8t52vZ5jbR
   hj7dv3pmIf/InU1pmsBtkGYkF639CH4OlSnTbLDNd3K6PYfd2T6VNyagP
   7BdQ4O0A7LemAbYm2goHsynJQTOJWSEHUgRxj8+NI5D0d397ybDSkjjJE
   Q==;
X-CSE-ConnectionGUID: jd2ejnTcTpKBkYuV7Qh9Xw==
X-CSE-MsgGUID: xlMXHakQR6iAjPxLyOXEmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52547861"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52547861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:39 -0700
X-CSE-ConnectionGUID: TSMm6iMkRraSY8AyywzKQA==
X-CSE-MsgGUID: l+n6TAXzRke4Dw9d5JJPmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="148880855"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:46:40 -0700
Date: Tue, 17 Jun 2025 17:46:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.10 v2 10/16] x86/its: Fix undefined reference to
 cpu_wants_rethunk_at()
Message-ID: <20250617-its-5-10-v2-10-3e925a1512a1@linux.intel.com>
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

Below error was reported in a 32-bit kernel build:

  static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
  make[1]: [Makefile:1234: vmlinux] Error

This is because the definition of cpu_wants_rethunk_at() depends on
CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.

Define the empty function for CONFIG_STACK_VALIDATION=n, rethunk mitigation
is anyways not supported without it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 5d19a0574b75 ("x86/its: Add support for ITS-safe return thunk")
Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7f33c1e052b..4b9a2842f90e 100644
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
2.43.0



