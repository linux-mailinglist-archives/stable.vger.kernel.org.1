Return-Path: <stable+bounces-66260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6EE94CFB9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07BF1C20E5A
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7D18E021;
	Fri,  9 Aug 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G618oFsh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+H8vrHJ7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A5161904;
	Fri,  9 Aug 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204969; cv=none; b=XNjNbLp4AJB1Wk4iBgHEiCSb5uhywbUia2MUSiFg1p+ciF29sEekXE+TbPN8DaHaKB+1ryOzDOhkcrm4sk41w1Bkv502oXWfBEYfKLHJj/qgwLYtjPYU8ldDM+lMUe+46EWD4XrncvQHJPApoh4WGANizSPBZr3cqFdzNy1sREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204969; c=relaxed/simple;
	bh=bNS+dlI6eMfwHroXkXaMEEwK3YgpBxQD5+w9PbSpJqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gRFhcZC2TEfSM6eR1JJlUNlPRxxxhjFoqAi2ZBDi7f39LZGu4dvECYAwUBV8sXmUdjKJgd+biz76/bBkuQWpZV6mX91Mct9RZvt1Yf1m0Rh4VlTEuNylfDno3NQdDFt2igGs01pGoijPKp5U4vSJOPDg3fP5XWfJUPJPTaPd4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G618oFsh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+H8vrHJ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723204965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/Rnw4ttHCXxua62VFVv0IOBz4+OSq/4hv6ANbwMTMw=;
	b=G618oFsh0+KY+QEXRu8SEP7w3aPCR2gZULVGtMLgepgVLvFkQaEQdn87/I4wBP262LdFFm
	HLpYqsF6/7TmfVGrXuQDxkixzImOjRKzt4PRccbZhcvctWljBMj1TnxEUHAmcJSqUuzVwM
	wpHLByCeF3GS3O1i/fVnRS56fe17tAWNFxg6t+MWvQwxm+2o3hJzQYe+9B0IkYYWeqFdnc
	APNqr05iHAgoPdd1ExOmRfEARL+hX4N9F0ZWJaVCmXxKSaeY+HdnFqc/C2q30pAbxqEN+B
	aZl7BPtRwFgFVgAe4pM7VR+p4prOqowDpWWXEX+hnN+uDalbZx75RQpxHmucNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723204965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/Rnw4ttHCXxua62VFVv0IOBz4+OSq/4hv6ANbwMTMw=;
	b=+H8vrHJ73F9BdVuGbVkLe6PIbm2ttPN4UGgipyr3liiBBOGy4cdnI8INmaV99SD6Fq/wFB
	1xYDPbe4CPaPCTDg==
To: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
In-Reply-To: <87sevet447.ffs@tglx>
References: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>
 <87sevet447.ffs@tglx>
Date: Fri, 09 Aug 2024 14:02:44 +0200
Message-ID: <87plqhucnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 11:52, Thomas Gleixner wrote:
>>  static inline u64 xfeatures_mask_independent(void)
>>  {
>> -	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
>> +	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) ||
>> +	    (fpu_kernel_cfg.max_features & XFEATURE_MASK_LBR) != XFEATURE_MASK_LBR)
>
> This is wrong because fpu_kernel_cfg.max_features never contains
> XFEATURE_MASK_LBR. It only contains the bits which are managed by the
> FPU subsystem.

You want something like the uncompiled below.

The LBR bit should be probably cleared when the CPU feature is not there
at some point in the boot process to avoid the whole is enabled and
masking business, but that's an orthogonal issue.

Thanks,

        tglx
---
 arch/x86/include/asm/fpu/types.h |    7 +++++++
 arch/x86/kernel/fpu/xstate.c     |    2 ++
 arch/x86/kernel/fpu/xstate.h     |    4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -591,6 +591,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features which are supported by XSAVES but not managed
+	 * by the FPU core, e.g. LBR
+	 */
+	u64 independent_features;
 };
 
 /* FPU state configuration information */
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -788,6 +788,8 @@ void __init fpu__init_system_xstate(unsi
 		goto out_disable;
 	}
 
+	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -62,9 +62,9 @@ static inline u64 xfeatures_mask_supervi
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
 
 /* XSAVE/XRSTOR wrapper functions */

