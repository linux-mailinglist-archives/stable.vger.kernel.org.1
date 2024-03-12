Return-Path: <stable+bounces-27545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB8B879EFC
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071A5281D99
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69891CA8F;
	Tue, 12 Mar 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTDQ1MoF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2EBE7D
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283247; cv=none; b=hARMbw6fijhU/YgJSojN2NRgpP3YTkhzVReHjh0oMtaUs/bHvU9HrxroB/0BoiOVBIOX1/BYMsek1jFv+Axc14h3XlGQcUi0g5x6KFPxY22aJIgW3vku+vfFtaHqfcf5cT+Ka7KKjB7xUCypXL0hPEUeu5ag9A8HclsPOwTssjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283247; c=relaxed/simple;
	bh=AkCWN3AsdaO6n62Nyp/Vb6Qxgxa/JaG386UFDCtkgOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhvWpzXaZ2kAFiSp5kt4vhDU6thz9q27VtIJOyIge6kvWmiBt5eSrbgxyHh7sirmd9EgmwBFGDYwyYK1zq3fBgx4tV1IGn/j25p1NfLkBg7krWqPtCk473cCDzolkoF7drdnqPzXDez50KPBrM6aBuGjkfaoCkYgM8MzdtHBgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTDQ1MoF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283246; x=1741819246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkCWN3AsdaO6n62Nyp/Vb6Qxgxa/JaG386UFDCtkgOM=;
  b=eTDQ1MoFTVt/j/2j9Y0EtkGtFG0a1mex9vcdBglU8J22lZzQ0dpwCGDz
   J9G3K6ibKG/TDQvfX3QMolr/L+ag/TbDO5E75OFmKu+LM71KQU+N3c1KU
   JUbn+/mO3VXWKO2MBG7eBdxu5LL6Hav5MlmYVMzs+p9S/NIUUZ5Qcnssm
   2YY8KSWicY3Uq6TjRRC3mqOxds8PuTHxk6oGZqCkRQdN5Qly0vENRmqo5
   wY4TCn3hwYd2Jf2l7nESt7I1ngdXLV1H4UpV2CH/nVp1Umwbv1a1sQtPV
   3zQARV/wXn3Cga4gl134aK8kB5iM7OGgZMw6FtxffGlPiVY+l49MfrPDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4892348"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4892348"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11593236"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:45 -0700
Date: Tue, 12 Mar 2024 15:40:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10.y v2 04/11] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-4-ad081ccd89ca@linux.intel.com>
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
index 70bd81b6c612..840e4f01005c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -997,6 +997,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -1069,6 +1070,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1267,6 +1269,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



