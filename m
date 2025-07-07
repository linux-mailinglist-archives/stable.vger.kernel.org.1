Return-Path: <stable+bounces-160386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1371EAFB9CC
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB7188752E
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A052980B8;
	Mon,  7 Jul 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv64liun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F122127A;
	Mon,  7 Jul 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909039; cv=none; b=BtNgmFGahtZUseqEF1Cnq0OtV1ekCg1d4SjvF7f/uXhvrea5cBO3acf/Z0NtXRE8qA+esRA0KdO4oyKUoVPOEyvm57h8cPLmFDSkPA3IerOwzViUv4BZLH+AeelTRRcbVr0A/otswuhBveaCCD7SxNrxwALRMSU/zLQtHOSbaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909039; c=relaxed/simple;
	bh=EyTn0efcaGBr0y+YWZB+XHS+KWDMpStDIQpsExCzOxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk7sWyo4C3MQnHAnEk4Obtk75f5yhI8J73USjTvQxSEPKqI2pCFPD2vFJYms+ifaDT9dpZ3dHR8qBWtVsiBpVLUQoAyv0AH2RgkNf3Gvnz5xtq8dUZt06cEQnqReHaOfzLjY96BQjOefCVrVp7lbNwj6T82vrYTsLe2UM/9a/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv64liun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AD7C4CEF4;
	Mon,  7 Jul 2025 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909038;
	bh=EyTn0efcaGBr0y+YWZB+XHS+KWDMpStDIQpsExCzOxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nv64liunK354seSQMSHrkMXXjkuM+a1PXHCqiOTJjYUpAiFZEqU7oRbLdRyl/MtoD
	 KPeM28DkSdq6P7Jh1NLX0vH/qc2w9AFxNLrxZBECnzBX3Xc98ZLpmZfthpO9OGti0A
	 dV+RdHnjHzPn2Foz2hg85XbU///R7D9secj6/5+Dmqlr/yKADBuT+Unakpm0lp3qPQ
	 3ACyt4mHxvbq7POwkj2Jac5ejrt3mh8amL3Q3zyWLX1qiGSaLpzBRLasfyJoaveNqG
	 C6moRVeq4RPE00K+FM5h2BGzJl5Vf3Ahz5AuDwWyN/lsQoWShX4B0s9XPIVCC0ZMWz
	 bSF2aKAGxMOIw==
Message-ID: <7a1addd2-9f82-4e48-9f17-7ebc991f984a@kernel.org>
Date: Mon, 7 Jul 2025 19:23:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: ideapad-laptop: Fix FnLock not
 remembered among boots
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gergo Koteles <soyer@irl.hu>, =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?=
 <pobrn@protonmail.com>, stable@vger.kernel.org
References: <20250707163808.155876-1-i@rong.moe>
 <20250707163808.155876-2-i@rong.moe>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250707163808.155876-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Jul-25 6:38 PM, Rong Zhang wrote:
> On devices supported by ideapad-laptop, the HW/FW can remember the
> FnLock state among boots. However, since the introduction of the FnLock
> LED class device, it is turned off while shutting down, as a side effect
> of the LED class device unregistering sequence.
> 
> Many users always turn on FnLock because they use function keys much
> more frequently than multimedia keys. The behavior change is
> inconvenient for them. Thus, set LED_RETAIN_AT_SHUTDOWN on the LED class
> device so that the FnLock state gets remembered, which also aligns with
> the behavior of manufacturer utilities on Windows.
> 
> Fixes: 07f48f668fac ("platform/x86: ideapad-laptop: add FnLock LED class device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Zhang <i@rong.moe>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans




> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b5e4da6a6779..62a72b09fc3a 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1728,7 +1728,7 @@ static int ideapad_fn_lock_led_init(struct ideapad_private *priv)
>  	priv->fn_lock.led.name                    = "platform::" LED_FUNCTION_FNLOCK;
>  	priv->fn_lock.led.brightness_get          = ideapad_fn_lock_led_cdev_get;
>  	priv->fn_lock.led.brightness_set_blocking = ideapad_fn_lock_led_cdev_set;
> -	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED;
> +	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
>  
>  	err = led_classdev_register(&priv->platform_device->dev, &priv->fn_lock.led);
>  	if (err)


