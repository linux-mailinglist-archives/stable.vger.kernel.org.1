Return-Path: <stable+bounces-25866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C186FD6A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ADA282E6A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E23224E6;
	Mon,  4 Mar 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIwpi47m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCF381CF
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544249; cv=none; b=RkG75dRs6XYDA/kQpHjCCux5juyQPn9V8ezBvqmM5jlrKq8O3YfhtbJ3MKdO4QMa/V2qjhUGvb30mBLOsEBbxgRp2fj40AoEkxwetkM4iyKlTv1mEK/BsKARIewjQFh/zccW5KmCH2RhUG+7ZFNM+n9YfvdkavU7wddFG3mZB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544249; c=relaxed/simple;
	bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT3A/Ev9mGpuiEVhZyayZsFt/xcuexU15yiLl7lIvcEbEbIsf74EL184Ww81X8GbShzQYCRyc5IJJOaOrRgYfxcJyKAz3n4ThWmXLMGvp4iv8miY7iaS0Ey+la79J+I5B0Ka6T9Jmy5VFxSBLkTfx5yoB6gZT4CM979rAsZAG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIwpi47m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709544248; x=1741080248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
  b=AIwpi47mNoV72H1vWM/nVebOyvV1HXoY/PsSYs7M83sHeJgbVoOKqGOZ
   VVnAnK1JmTNBd8mhMBPdK6C8lcThwtCHpKNFb941QOXvlvpG1CbbHDweE
   iW3jQVtbT3QiVsv6yMtoXXCffJyjUOYQTaWswQwDNhuSr/NJWjKLMGK9J
   xjcx4Q470hEe4jmfU4PBNAvukY+KpGzfmQGnwORe2bngopJxg85G3sDqb
   pPx/Orhw9tuZiBTm3mLFH3BO6Z/WVzna8w+pSDx23URzuyWsLzYHbnumS
   aGkeSqNuVG3Y0ln2BNhNqkW75B4gQZ9qzRxkVpGjC/3453Se9yyl13IH+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4149523"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4149523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13490529"
Received: from smullaly-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.100])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:24:06 -0800
Date: Mon, 4 Mar 2024 01:24:05 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1.y v2 3/6] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240304-delay-verw-backport-6-1-y-v2-3-bf4bce517d60@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>

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
index e309e7156038..ee5def1060c8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -912,6 +912,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -981,6 +982,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1173,6 +1175,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



