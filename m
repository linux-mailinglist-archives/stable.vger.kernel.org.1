Return-Path: <stable+bounces-26864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D578729C4
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046141F26DA5
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073F12BE98;
	Tue,  5 Mar 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5+tXDXA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D35A796
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675695; cv=none; b=dw9QiS0/B1RIEb9IH7hz5VkhDUSNPIQ7Yssa57iFI3Tmpmp0kSA5YSoSvcGpyChu7gfjXuFZuWS7LTN9iPrze/uQHMrCLMwqxwbqQkkjE1LaBOaO2JpoySxXQiEu3e23LLMtV7e2NU9Ue75/9yiubTqR1ETC+wqnHXGK1vob90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675695; c=relaxed/simple;
	bh=nPyizn+lHMGJ9AvsEFX24vUsQ+jGcC1UdRyMZd2WsDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVp0sK/I0DQ4JEk4fM4sVMLSLACYcqPg6AvEUp+BWrHu8wEGs76VbAStmGO4nO+7wlwl5228NTWpxxjotUs+LKZHnnftPHGAkQ5Omkz1FAUtdmCbxHv58dmwDKzxax212jDUQou9nyQGE/waac1IkCOT0CQml1hb1mQ0Y2PKVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5+tXDXA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675693; x=1741211693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPyizn+lHMGJ9AvsEFX24vUsQ+jGcC1UdRyMZd2WsDE=;
  b=m5+tXDXAwYxtJbcmChcpC1OvVUzdNKbq0moXqocxuO1fDlsbPGWyGz9P
   yW3YE8YC4u+jp63Pbktp2Q9Rx52FJF6jwP6SVMeuwLvUoP9Q9IWBu26lD
   aX6XEVYi8cMNqMZ4pGTTKl0Gc6PER2KSFZ5DnUKLJab6scGjJiVUKJfg7
   mft4JekEovqBl99exvPPPHiBJns+y0RmWTC2Xg4vhzYnsZGwi7hBtOXYA
   pZM7l8qErRQaJGnDt83k1X3m1hzi7ccc/74h5AVU/CF1eQ7aRQxiyNuDf
   XAsksKkGHE83tXchLt9S+b48Z68+PUn9R2THUiAxasF4osCpynK9ftvGo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4119714"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4119714"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9683822"
Received: from pbemalkh-mobl.amr.corp.intel.com (HELO desk) ([10.209.20.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:51 -0800
Date: Tue, 5 Mar 2024 13:54:50 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.10.y 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip)
 suffix
Message-ID: <20240305-delay-verw-backport-5-10-y-v1-1-50bf452e96ba@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>

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



