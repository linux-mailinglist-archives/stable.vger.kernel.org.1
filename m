Return-Path: <stable+bounces-45662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF888CD190
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C4AB209FC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF213BC12;
	Thu, 23 May 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKgGxXUw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F613BC0C
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465387; cv=none; b=Vru2scmSblKE0Gl5xk7E7uy16mp/rFtWm0ukak+cHPGWVVxPIXkHatUx6WGIDCLzXFbLTK+7vVwAuj3zDIkEUSOBCbe3LeU6p3jCYsqebmS24/+nrIxdE4u1nZ4Vcq8Kxw3fErSPx59RbrZqJ9crKu+BVCwEsL5SUDkAhC0n8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465387; c=relaxed/simple;
	bh=TSfI3BBhH4SQXg15oTofZkSYvmFAtIJa1tOfLIcM9B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwTbr3TSrzjzqaH1Qx2obWs3Fgmq40ZAF2kFIxQYnSzK4GPs5KJ0axCbZY/R93LcPkwhR3umQtZmwowcsP0SNkAYyjJC38f5UXS7ujLeOQowz4gY0k86OunQIfaNmVkc66Ok+jWae3T908enWc0UKPSTTkMXXfq3/gzh/s0Y+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKgGxXUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B5C2BD10;
	Thu, 23 May 2024 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465386;
	bh=TSfI3BBhH4SQXg15oTofZkSYvmFAtIJa1tOfLIcM9B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKgGxXUws6sCt60RPWuz5taXnWtwkms5/6fpdduD3LQwOU2kJIKMiqBrTIbTv/J3V
	 sly6G5AHSXiEGA6gQSxt2FrTIUCQGaVAX7WVzV20Jhh4t5tSzUIOrMFuMH6v9z7MQi
	 g0XQptM31iLDqYq8dYkqFUwr4Q6yj5wflI+XM1UU=
Date: Thu, 23 May 2024 13:56:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksandr Tymoshenko <ovt@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 6.1] arm64: atomics: lse: remove stale dependency on
 JUMP_LABEL
Message-ID: <2024052316-diaper-carless-bcdd@gregkh>
References: <20240521-lse-atomics-6-1-v1-1-7aa6040fc6cd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-lse-atomics-6-1-v1-1-7aa6040fc6cd@google.com>

On Tue, May 21, 2024 at 02:51:29PM +0000, Oleksandr Tymoshenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> [ Upstream commit 657eef0a5420a02c02945ed8c87f2ddcbd255772 ]
> 
> Currently CONFIG_ARM64_USE_LSE_ATOMICS depends upon CONFIG_JUMP_LABEL,
> as the inline atomics were indirected with a static branch.
> 
> However, since commit:
> 
>   21fb26bfb01ffe0d ("arm64: alternatives: add alternative_has_feature_*()")
> 
> ... we use an alternative_branch (which is always available) rather than
> a static branch, and hence the dependency is unnecessary.
> 
> Remove the stale dependency, along with the stale include. This will
> allow the use of LSE atomics in kernels built with CONFIG_JUMP_LABEL=n,
> and reduces the risk of circular header dependencies via <asm/lse.h>.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/r/20221114125424.2998268-1-mark.rutland@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
> ---
>  arch/arm64/Kconfig           | 1 -
>  arch/arm64/include/asm/lse.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c15f71501c6c..044b98a62f7b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1752,7 +1752,6 @@ config ARM64_LSE_ATOMICS
>  
>  config ARM64_USE_LSE_ATOMICS
>  	bool "Atomic instructions"
> -	depends on JUMP_LABEL
>  	default y
>  	help
>  	  As part of the Large System Extensions, ARMv8.1 introduces new
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index c503db8e73b0..f99d74826a7e 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -10,7 +10,6 @@
>  
>  #include <linux/compiler_types.h>
>  #include <linux/export.h>
> -#include <linux/jump_label.h>
>  #include <linux/stringify.h>
>  #include <asm/alternative.h>
>  #include <asm/alternative-macros.h>
> 
> ---
> base-commit: 4078fa637fcd80c8487680ec2e4ef7c58308e9aa
> change-id: 20240521-lse-atomics-6-1-b0960e206035
> 
> Best regards,
> -- 
> Oleksandr Tymoshenko <ovt@google.com>
> 
> 

Now queued up, thanks.

greg k-h

