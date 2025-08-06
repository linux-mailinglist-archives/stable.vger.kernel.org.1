Return-Path: <stable+bounces-166747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F925B1CF0F
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 00:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C2F625B58
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D3231A30;
	Wed,  6 Aug 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJg5WOQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888462264BA;
	Wed,  6 Aug 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519190; cv=none; b=QijG/CepC1NG5acdkmsUfodu2/cdyO2toLV/JL5uG2mENWWtP6oqTADmDCVLKL7dbeJPeDlpIfsRTM+P9ZhALGz12K3KX+rL6NKnGwxnosm+JTMW5Zf6trNWpq5JRHDKriPoBcti5ltrxRTp7d28RW3ztygdGRpBIMyXsAIesKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519190; c=relaxed/simple;
	bh=ZJ7HumVN6I5XaP5hhr6y49q70vELwodDQDogr8c3WSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIaY8pby7YsXBpk3n48X/Vuv55uSix8A5gRGsIniQWu69iGzu0bXghQuNt7JcJbG27HkP+3mEMfeZf9gDjLTZASOf5TUi/qhBqsSRV85Z9UsmgWlZV7N50yJYrtQemT/HArxwF/ki5k0HTq4ffG0gTPhZNPDYdemiBzwZpue3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJg5WOQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4833DC4CEE7;
	Wed,  6 Aug 2025 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754519190;
	bh=ZJ7HumVN6I5XaP5hhr6y49q70vELwodDQDogr8c3WSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJg5WOQRcY+6y3jP7TFV5krVcpPQUzVJN3TdYJI9NA/TcZKBAXfaDCE9MN6w2hrwA
	 yNSG06C1N+3jJ64NTcWbcpwePFTVUkZVbWcLHSp9/dAck/pNY9UZ12mujYEgC1evnL
	 rMzijI2qQTTWX8UAXolc1I8BhylEzfqBCIJ5VskCm/F2KwhWt4uKRbXdToWx1m+SmA
	 IkxeBNqvCvCpeaIYitR/WYr2984AcLoFQb0PmBeG74f//vw+zmWutxkRWCv1D4g+oS
	 w8L0Au8SCD/f5qxA843GmFOuCFCZItB9LeMaqA4QlyccFA3ZNyeYtY2R2TafjKCYPO
	 MmKBcZe1C5Lwg==
Date: Wed, 6 Aug 2025 15:26:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Christopher Covington <cov@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] KVM: arm64: sys_regs: disable
 -Wuninitialized-const-pointer warning
Message-ID: <20250806222624.GB1654483@ax162>
References: <20250728-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-e373a895b9c5@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-e373a895b9c5@google.com>

On Mon, Jul 28, 2025 at 02:04:24PM -0700, Justin Stitt wrote:
> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways -- it is
> a false positive.
> 
> |  ../arch/arm64/kvm/sys_regs.c:2838:23: warning: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
> |   2838 |         get_clidr_el1(NULL, &clidr); /* Ugly... */
> |        |                              ^~~~~
> 
> Disable this warning for sys_regs.o with an iron fist as it doesn't make
> sense to waste maintainer's time or potentially break builds by
> backporting large changelists from 6.2+.
> 
> This patch isn't needed for anything past 6.1 as this code section was
> reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
> configuration").
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/kvm/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 989bb5dad2c8..109cca425d3e 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -25,3 +25,6 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
>  	 vgic/vgic-its.o vgic/vgic-debug.o
>  
>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
> +
> +# Work around a false positive Clang 22 -Wuninitialized-const-pointer warning
> +CFLAGS_sys_regs.o := $(call cc-disable-warning, uninitialized-const-pointer)
> 
> ---
> base-commit: 8bb7eca972ad531c9b149c0a51ab43a417385813
> change-id: 20250728-b4-stable-disable-uninit-ptr-warn-5-15-c0c9db3df206
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

