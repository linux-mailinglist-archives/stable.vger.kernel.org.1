Return-Path: <stable+bounces-26705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA2987150C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFEE1F227BA
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC543ACF;
	Tue,  5 Mar 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUDER1sx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893601803A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614921; cv=none; b=s2CMMQodOA0TIWJd4TJydQ5eQU3YJjbI9qxhgfiHZMylgoZhQyO3EjlbD3HvFS5rQ/i9pibr64bA+7vzurxiFQg9XLZxnTVvcaBXHh6sy20G5aVdUK+I7AtiasWYpGRjLKLPFx7GYqPvG1+Dj0ckeuw6uvnQhsrndsxSX9JuM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614921; c=relaxed/simple;
	bh=WirNLx8Y5BMEKax2q90RMlYcXPGz9pCZ0xSTXzxf6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzrMIHFGRqDIQPDOEq5UmVXn3xMRLL5V+RyHrR4xaw+clLxi5urBF6pyEDBT1Nc7JqTQucGhVJqqwA0mm24w6ylZnKS2Skvy3bGfOXTg3KcYQUUryJ1MxQRYttt6tVXdNWfcdCbgelP7nyF44ulCvrNR8Nwc2ZfOsNUU7L5Vp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUDER1sx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614920; x=1741150920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WirNLx8Y5BMEKax2q90RMlYcXPGz9pCZ0xSTXzxf6uo=;
  b=MUDER1sxobo7WfM7DDA+DLv6LA3GNjKSZd5Xr5vz9i5l/Iu/Evv1ztWR
   VJsqXOhlo73VNaJXIDeZefroYEuN15diRptl5QgmP/nfxn6ohbTKWnIBb
   DcnyUl7GV9sC6TlGq7WrMDphMCtN/WuVKLk8OJZXuk5eJ3CbsJ56MsNYy
   j4eaoUwL9VuRydFm4jGVEP6nYvVWwKgxGKjVfDN1iGn+Za+d60eRZRpXI
   PRB2sxF/tI584D1W4ZYDXxegI3ScWXOjGKYCMgrjQUJu3p3qHDIxFwxa+
   GmcG9jO91o+ldbccXtGY/9dw5vydotkb+g4inploVLcRp5uEqJnDObYST
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4024219"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4024219"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9655347"
Received: from egolubev-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:01:59 -0800
Date: Mon, 4 Mar 2024 21:01:58 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.15.y 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip)
 suffix
Message-ID: <20240304-delay-verw-backport-5-15-y-v1-1-fd02afc00fec@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

commit f87bc8dc7a7c438c70f97b4e51c76a183313272e upstream.

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

  [ pawan: resolved merged conflict for __ASM_REGPFX ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
---
 arch/x86/include/asm/asm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 6dd47c9ec788..fbcfec4dc4cc 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,11 +6,13 @@
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 # define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
 # define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
 # define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #define _ASM_BYTES(x, ...)	__ASM_FORM(.byte x,##__VA_ARGS__ ;)
@@ -49,6 +51,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 

-- 
2.34.1



