Return-Path: <stable+bounces-66314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31B94DBE7
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD31F22188
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4614C5BF;
	Sat, 10 Aug 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiqi1YA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31E4436E;
	Sat, 10 Aug 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281428; cv=none; b=tWbCskYNUwEnUKqu4F09fAXrIC3Vtdv8jQYn+qGYsYKkiaHXmgBswxLrueAhd4aA+8CBMZmNWM6z/k7X/dfLMSlnz/1qiMeoc7paZ5Kj58o7NarVAskZCvwvo2Abcu2dqmNymYkoyaYYtZ3UAVOocnppwBq0cU6Ytl8Wfup9rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281428; c=relaxed/simple;
	bh=zb4bAQPkC8PuI8iRT17mPKYwOYBQem3QeLvrxpTiEH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/2INPId1tybvweKLfPvmXz9L3nYWGwot6WcUINlSZCrraCBAwSb4BX75ftoVm3SQG/PI1bExE+b4N//VCgybodoXK1LOPys8g4f4zjknqNF4X0OeyX9g1sPTHes3jDhb5d4/8gjdVSBqnTN89DKjdlk7sj6mfLlFpfLKvEhP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiqi1YA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB139C32781;
	Sat, 10 Aug 2024 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281428;
	bh=zb4bAQPkC8PuI8iRT17mPKYwOYBQem3QeLvrxpTiEH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oiqi1YA4ZgNRWmOpHCOBWeHgy3LzYP5gWGnHlWVvFn0ZEKtMIdQ6+YGJ2A38JzEgq
	 9Oo5aofLeP+A2OBgb2PGtnjzGc7/ts/0oszaEAba+/RwKfEcBpaWRk9d5HLqUDnc5B
	 cpjL0lw8DMBdvuuZSfxtVF4qu+4AipMwdqCrvVCHPb1JlqRYm9JMTyxQNfcvwOe4n5
	 Cft8ouLSki2/L6FZS/DTD613X48gbeBms6hkNeX3wqzIrIjPHy9u/9jo16Difkoqa6
	 ZRHl6qkq7D5iM2eo/vGMMdS71s4i5SWU+IEmIV0/nB9UuCvJ8yx297YpnWsgXMmxKq
	 dIBOq5VaW3snw==
Date: Sat, 10 Aug 2024 10:17:03 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@outlook.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ice: Fix improper handling of refcount in
 ice_dpll_init_rclk_pins()
Message-ID: <20240810091703.GG1951@kernel.org>
References: <SY8P300MB0460FB85729319189B40576FC0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY8P300MB0460FB85729319189B40576FC0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>

On Fri, Aug 09, 2024 at 01:02:15PM +0800, Gui-Dong Han wrote:
> This patch addresses a reference count handling issue in the
> ice_dpll_init_rclk_pins() function. The function calls ice_dpll_get_pins(),
> which increments the reference count of the relevant resources. However,
> if the condition WARN_ON((!vsi || !vsi->netdev)) is met, the function
> currently returns an error without properly releasing the resources
> acquired by ice_dpll_get_pins(), leading to a reference count leak.
> 
> To resolve this, the patch introduces a goto unregister_pins; statement
> when the condition is met, ensuring that the resources are correctly
> released and the reference count is decremented before returning the error.
> This change prevents potential memory leaks and ensures proper resource
>  management within the function.
> 
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and detecting potential issues where resources are not properly managed.
> In this case, the tool flagged the missing release operation as a
> potential problem, which led to the development of this patch.
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index e92be6f130a3..f3f204cae093 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1641,8 +1641,10 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
>  		if (ret)
>  			goto unregister_pins;
>  	}
> -	if (WARN_ON((!vsi || !vsi->netdev)))
> -		return -EINVAL;
> +	if (WARN_ON((!vsi || !vsi->netdev))) {
> +		ret = -EINVAL;
> +		goto unregister_pins;
> +	}

Hi,

I wonder if it would make sense to move the check to the
top of the function. It seems to be more of a verification
of state at the time the function is run than anything else.

Doing so would avoid the need to handle unwind in this case.

>  	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
>  
>  	return 0;
> -- 
> 2.25.1
> 
> 

