Return-Path: <stable+bounces-25810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9786F960
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24794281795
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2A46AD;
	Mon,  4 Mar 2024 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OogCyguj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6F612E
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709528919; cv=none; b=b7IKntAaeOgOMiPLCLbXEGRoryFZCk/0RO6bf7cmOboJram7fnRI/rea7vgKA0a15HpWCVQxomTzZ+HckUpGpYinJWguPSPWwYjWaAc10jmgW2f9PO9YVYRLwwywncq5TI5JTqE1blSqoUVzb8RO89gTeY8W2LN/LGsgK7CGpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709528919; c=relaxed/simple;
	bh=fsxcnPQk0UIJGmhhqFWDwr0XV56vguvj6FaGU0N7fl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toKDtYJEMPDC0OzjAgoQnL2QLTWHt7HAHKz2E+1sv2McHoVCdXkpVPowjCSqIHz7VNLOzZYqHUWROxIe4GGnmDRbGGbgzYyu9h/QWfIZ3QRfENttEQYCG8SL63AUFfsvVYPJd2lLCkAkXIg78h2X+ZY2ltUjwHP7t198Bh1XaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OogCyguj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709528918; x=1741064918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsxcnPQk0UIJGmhhqFWDwr0XV56vguvj6FaGU0N7fl8=;
  b=OogCygujyTqRYaoytfCoZn359Jtj/Op1FY6/Qt7l7mY57g5K/VV6Ns/L
   q/Hvwrp/9/DJZ3KW4CKXcF8Ou7C2xJxv6SHUSFIPjj7YrX97Sn7NMaoFb
   A9Fkk7mYQmqEE26Q50TFR5mu/+lkS76Q+ZEH+V9mt3sB84pRl6Onju8Xr
   0daXz5rofnve7Cn+vsGuaQo9mYLoPuBEc+vDTseJac2FMuDZH8ifZ6L31
   xV0vdqN7SlsDNSbzzhKBTSNcdAbnVgI94tXVCP3xS4giigaY56dAMdre8
   HvhPexLoEF1PVt2JaRybSS/AiaNXJy7AqA9JRn8xHch2C9hDE/aCc65Xq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4127478"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4127478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9061320"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:37 -0800
Date: Sun, 3 Mar 2024 21:08:36 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6.y v2 2/5] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240303-delay-verw-backport-6-6-y-v2-2-40ce56b521a5@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240303-delay-verw-backport-6-6-y-v2-0-40ce56b521a5@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303-delay-verw-backport-6-6-y-v2-0-40ce56b521a5@linux.intel.com>

commit a0e2dab44d22b913b4c228c8b52b2a104434b0b3 upstream.

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-3-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6e6af42e044a..74a4358c7f45 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -885,6 +885,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -954,6 +955,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1146,6 +1148,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



