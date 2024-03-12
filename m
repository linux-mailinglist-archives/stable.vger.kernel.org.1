Return-Path: <stable+bounces-27524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9708B879D44
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6E2833AB
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B3143725;
	Tue, 12 Mar 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO7eZ8yw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9113B2BF
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277852; cv=none; b=YfbqIHiSE7lVBb6nTJElmVfwr9gSp6fcsZ5h+oJOES1FU6EwbSGX1JnefED5W0WBBSpnZACJCW2P1gCB+ZXSN35GTLQQYSNeESObM+UKFV7XvHl1INvTU0MrCWWutuFRssc3Rdz+Ywr0nWcLmQc4Rc//HBRINGEx3TwIqmv5IxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277852; c=relaxed/simple;
	bh=WirNLx8Y5BMEKax2q90RMlYcXPGz9pCZ0xSTXzxf6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edC57fq9+DHe7kEgKk154wRrDUNIjca70jo74aAi1hJivhbEN8tdNT7D5BKaCRUkw21mI5gewIVmKxolslBDS2F3DYFyQ1XdTWoydI5K0n6HDQ2SZxD42T/sOzLzbynlUycSTHgR5f7IL4H6wwpCMXrvYTdzvvzZWTmKm3nfnqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO7eZ8yw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277851; x=1741813851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WirNLx8Y5BMEKax2q90RMlYcXPGz9pCZ0xSTXzxf6uo=;
  b=bO7eZ8ywoiswhAtmgtIjusBZ4L/+QHw+DSSLW9IJe5EAgWpm1U2rN2C+
   r6tVxcjddinq/vELwIGXx+HV87m5hTtjsBvTUL5Py4f8OCv1xjBS27pCh
   8qqJ55bdVbTot/O7kWEgZS8ktAJMYp21ptl4fPALsZ0ZUbJr/id5frzYu
   KQthZlz1QgyHzMpjc4I37ZK4gTIb7X23ykU+f3DHFKieRolvpZPIJ36pM
   RaSql7RVCDeiEj4YsCZ2we65q//8cCchyT+SnxgTvKK7vbiGJE0pbJcL/
   zn05Vl15go24+n7nke2fEf/Hz0ZZ/moEMPG1ThUB0lC6UrJHac4zGTv3R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5146039"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5146039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42609663"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:41 -0700
Date: Tue, 12 Mar 2024 14:10:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.15.y v2 01/11] x86/asm: Add _ASM_RIP() macro for x86-64
 (%rip) suffix
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-1-e0f71d17ed1b@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>

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



