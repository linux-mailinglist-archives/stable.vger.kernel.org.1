Return-Path: <stable+bounces-164704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BEB115B1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381071C8322B
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5E1C8616;
	Fri, 25 Jul 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEOqWbvE"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996241C549F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406402; cv=none; b=sOKdxHbTEbRuYWtp+H16Luoghr/5qbdmF1GxP/s42OFazD4u9d2mVT+wDub7dKE0q82osYhnu6ngpSICRKFUF2CayEQOoj/VpBhSZFj++MTKBWX1zaPawtfmK0mobdkbbrES5XtoE1+wEEyBsM2bEcVrKXQdadfSUaPkxCNFKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406402; c=relaxed/simple;
	bh=KMp+aBJeXGXdSSkn8gWIZscNhYbFENCCJ2WhFi4gnmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tamWpuBKcRDeImzSQCkm1o54vSBEVgdrI2TIOVx0Xs67v7rJSCCMm1bNbkmQ9Q+5vGRhwVFJsp4xNh6lso5jH0qUIVa+LeJxvi1LzSvVHxaIA5v9fLT45I7n9hnWvjer7oLdOo42gGaOG/Iqs540kb9ku4I8gDVL+C+gpFHbOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEOqWbvE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-87c0bb1ee4eso39502539f.2
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753406400; x=1754011200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK/gYnhz8WxypxaXzlzjFNaBe5jgICo9avyYr9Xjlc8=;
        b=JEOqWbvEaFXt8g6lmKWc9KkS8Fevfm3rp2dycADwy+MtfF6q+BPWgQ34kGGP48OJwS
         VF8LE0tJNFA2/iaWNKSZetk9tRTPcK/3Z8Iihn6D9O2n6zY710qlDkg+NAWG5QMEj0av
         7klwojsWYjELC5IhAUDPeAggv8/8phU/8JUWnDwBcXaSRKlGXFy0y0Wf1lvQmMkj9hps
         4//gguQrVb+mMfaNdhI+0dNWI7G8vA/OG5DFspuhuSwp5auHcFoFuyA0ZTQrMt0+n8lA
         BQ1pgIZxCWcKKFVeNA4Csi/pFkKrk/n/zJ/hgHf/X3rTp16xlzUnRGdrIdXSvYAGErZ1
         zRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753406400; x=1754011200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK/gYnhz8WxypxaXzlzjFNaBe5jgICo9avyYr9Xjlc8=;
        b=Px7HMfObcCPvDtpcJCJp/Lq5Lzylf5d6NfaEQ8bMSL1ntfpp0OVoy8V89hch6mXO04
         jwvk8RddbUQSsxh4A9oNGW9V7Vge8sMsZjIYK4UNeDlOrr8PGD2o67/mahVG6OL8zvUL
         5gFNUQpfFrPbhqAUNrD/9EJlytQH8bg8FeZTPKclP3tKg1jxLx5est2aj1afrCraaG6P
         Lq7aOoxlm7HhCDugFM8P18KwMoTdcA8nXKMOIU7nbjgDL/HibgSdTYQqcPuDrCXx1PFU
         8ByQadPtrqfOpA4xE9ronOIR/jPbHi/z6HaozcSMnlMP+AgZc+LrT4RXA6h6ThQLHyM/
         5OQw==
X-Forwarded-Encrypted: i=1; AJvYcCXdgFii0BKVaHv9TX9NaYAJ1qqFkuxWJNuavKiP8s5WaXJ3rCXQ77+iiiiX0/Za1wUF2NiZJ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1mm1HMzJ9DjA4GpYW0qfne1I6YJxRKARcWyBpUQRiYcMsXlT
	Q7NChV3jg51DaSvtkjc9D708wJjzJNpSd5ysvfbEw/nKPvJvPz4i9I6tB9aVaitVcA==
X-Gm-Gg: ASbGncvPjPVCSlv46zLh/4jl66Ey64MuLW57zJz6ekfDEIsEeDLZHGo0nG+Bl7vjVrB
	o6Y9RaxoeLUR/8r6GcGB3CNVJs44/aGcKbEmCqwEt2KMdQXQscXdW1Bv/nDfQlWXSASg0NRIH0w
	lmyVjQGRePQbv+QHgg99kS90gKzdEU6OK4cc2jXm5ZoILFwifjGWy4zI7E/HQ8LSr+rXrwnyUC2
	jV8K030O0nS2R8kSsfYAGTFu2KB06+UsiWLBkNaRs5B2oSrwXYpLjn/38AFPumOkfIEN6ogTXN9
	oUfGi/KIHWn/RIS6rMRdTAzEd5c2b5HUFeLUEKKzdRDvl2T2VTYX+UlNnSCz5dvKG3uhhm3/Enz
	/50/uIWXv4rAFDeAoNFJdEpGCLempt0cHCYXPiM8+SVi3oHIB6PUh7iUjvd3BRYVRl+4=
X-Google-Smtp-Source: AGHT+IEmFccKRhDDkZ+Zb03HqYIMkjVZNy7vREse+9ncUz0sanXGTB21Co/1U2q+QuC2Ff0zX/sN0g==
X-Received: by 2002:a05:6602:2cd5:b0:873:de29:612f with SMTP id ca18e2360f4ac-87c64f89e6cmr1623090439f.3.1753406399396;
        Thu, 24 Jul 2025 18:19:59 -0700 (PDT)
Received: from google.com (39.173.198.104.bc.googleusercontent.com. [104.198.173.39])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87e201992fasm28737439f.28.2025.07.24.18.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 18:19:58 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:19:53 -0700
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] KVM: arm64: silence -Wuninitialized-const-pointer
 warning
Message-ID: <xcwmzitmc5igc3eplgr2uwviitdfmtdknth4a5zpaldamw7png@o22wb4ze3czd>
References: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>

On Thu, Jul 24, 2025 at 06:15:28PM -0700, Justin Stitt wrote:
> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways.
> 
> Silence the warning by initializing the struct.

For posterity's sake, here's the warning message which I meant to
include in the patch:

../arch/arm64/kvm/sys_regs.c:2978:23: warning: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
 2978 |         get_clidr_el1(NULL, &clidr); /* Ugly... */

> 
> This patch won't apply to anything past v6.1 as this code section was
> reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache configuration").
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f4a7c5abcbca..d7ebd7387221 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2948,7 +2948,7 @@ int kvm_sys_reg_table_init(void)
>  {
>  	bool valid = true;
>  	unsigned int i;
> -	struct sys_reg_desc clidr;
> +	struct sys_reg_desc clidr = {0};
>  
>  	/* Make sure tables are unique and in order. */
>  	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);
> 
> ---
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> change-id: 20250724-b4-clidr-unint-const-ptr-7edb960bc3bd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

