Return-Path: <stable+bounces-27542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8E879EF9
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC42B21F07
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E926AE8;
	Tue, 12 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzrFDm4Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351720B00
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283230; cv=none; b=o1SPEyL2KjmudYj9OraYTaAv6+BPXxxSzhK1kbtJWJLe/KgPUQQhGrH3svH2BrMCL905owp9OzKqye8/+8AsRetuxn4fGNIlWUFae/dddpZnw8+eHYxwIaSI+Xh2E/q0peoevrYsLiPbl1vR9nHdspgXsimXfT62O8YJWqbQi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283230; c=relaxed/simple;
	bh=nPyizn+lHMGJ9AvsEFX24vUsQ+jGcC1UdRyMZd2WsDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYji0faDmjvHbV9MLYc+av7Mmez8dO+fb+fFbQzZg5oHJ8x0DDwiEcJSArhftNFRN+cOONkUyQCcgup3VK/z0m+KPWAM1XO0flKHi+DFBozyAz6K6cOgXJ4/J2V3hKDHwXos4jvDoEDV9A95vtsdjbBZyygvfDa1kFsISYt2f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzrFDm4Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283229; x=1741819229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPyizn+lHMGJ9AvsEFX24vUsQ+jGcC1UdRyMZd2WsDE=;
  b=OzrFDm4ZlEhAsWCL6AuGbp2IDUksxx1Ki+c8cpiCg4Jm/Z6ZTjdi8pS5
   Bn/MVY5YdrFi8AwSZNQIjr2kEBInD0rEcZVufPwqiaV5UDINNkLTfh5h1
   fwUKl03h4Mkdl29fR+BM28h1WNfD0B+Dz/A7ZmvksdLThGGdI4hVnIhYD
   Ts04NlxYYVKvIDKn7/MCXdf1H7a1XEEbKAhot6KsWn1Wa8b5twKLRJlKq
   m9bkLpq7KIzwpVqJu7XObuUapSoOQCU8fVk+IVAaKEr6Mqha06GfM1FTT
   ONB0ceV+VqVUDhtf6r1Z3WRdHV0hL2TqY9yG7+HHMWY9MreRY1dBKrb0x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22475835"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22475835"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12116033"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:29 -0700
Date: Tue, 12 Mar 2024 15:40:27 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.10.y v2 01/11] x86/asm: Add _ASM_RIP() macro for x86-64
 (%rip) suffix
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-1-ad081ccd89ca@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

commit f87bc8dc7a7c438c70f97b4e51c76a183313272e upstream.

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
---
 arch/x86/include/asm/asm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0603c7423aca..c01005d7a4ed 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,12 +6,14 @@
 # define __ASM_FORM(x)	x
 # define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
 
 # define __ASM_FORM(x)	" " __stringify(x) " "
 # define __ASM_FORM_RAW(x)     __stringify(x)
 # define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #ifndef __x86_64__
@@ -48,6 +50,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 

-- 
2.34.1



