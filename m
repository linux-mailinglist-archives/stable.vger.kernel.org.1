Return-Path: <stable+bounces-76029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED997784F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 07:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96AD1F2487F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 05:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F6149DF0;
	Fri, 13 Sep 2024 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NALrRdky"
X-Original-To: stable@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C4154C0B
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205187; cv=none; b=DU0pKWEwrhx92DxU2eUT/AnVdamVFVSGYe8j25BNtY9g77cUXGi/okLGvJ2aF7D2hjzRbXrYi5Ymst/BsDPobuNIGDfCvNBFV7oXB2pvN7YpcQ2qao+l+eNOEEkLKGGDRi27Km0Mz6iAUP3APfLO4DXrFiLHHunPkZywXQ+8OAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205187; c=relaxed/simple;
	bh=oDzPv1Y1QlhN0VKg61eGukUlI585QY4rVzK17U1/DBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXY5nJoEWx/Yb229C5LlKadX8CjwCZwMHyQsDCuF+Y3yiI3WwduD38d3JqpnKnrt1tnUUzunM/2ktTcNJOT/6e6bP2vyHdTBbXvdLQVhY00YvEPzXNLa+yMEItkPvKbOT/YrFt28Qre6M8U7ZF6n4nnxt0LGrtH47PUJxvCweFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NALrRdky; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oyowsnGGQG3q8oyowsqRC1; Fri, 13 Sep 2024 07:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726205182;
	bh=KIKSdY+oERrLJGWIuSve8q7G/AsXHAikohdbciI8Qc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NALrRdkyqSw0QUjCidqRSlXV1y52pP0uv/A9xVZlDpuTgeiAfJHP4Dt7daRBd2BkU
	 rfDoRRwmmBR/1qZ2cha8mA0lY0PyWe/7PnBTr5avaaR5gZ3vrnWdLcmYdzXAG+3Ox5
	 6hWctQKO9CfWib3XRENrgA45ZRRJLT/06z3/1VLkp2CZeAjFx1CWjBwx6IWqGkcuQD
	 c8oBrbiisx+85n04ejSf2aJ6LcBrTy4ogXlEOhbjiIV4FoKGKFvfyzUHIoZHtqjo/3
	 kbuLPIaY1ploJocF5gIEUlyGdPVbO03ir/c4EM/Cq6edB+YBHCnsEI24mq8FCluZu+
	 GqpcXBYCmh8LA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 07:26:22 +0200
X-ME-IP: 90.11.132.44
Message-ID: <3efdd5c8-84e9-4beb-811c-65db48e9af2b@wanadoo.fr>
Date: Fri, 13 Sep 2024 07:26:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] pinctrl: check devm_kasprintf() returned value
To: Ma Ke <make24@iscas.ac.cn>, marcan@marcan.st, sven@svenpeter.dev,
 alyssa@rosenzweig.io, linus.walleij@linaro.org, joey.gouly@arm.com,
 stan@corellium.com, maz@kernel.org, akpm@linux-foundation.org
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240912020840.1763252-1-make24@iscas.ac.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912020840.1763252-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 04:08, Ma Ke a écrit :
> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a0f160ffcb83 ("pinctrl: add pinctrl/GPIO driver for Apple SoCs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/pinctrl/pinctrl-apple-gpio.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
> index 3751c7de37aa..f861e63f4115 100644
> --- a/drivers/pinctrl/pinctrl-apple-gpio.c
> +++ b/drivers/pinctrl/pinctrl-apple-gpio.c
> @@ -474,6 +474,9 @@ static int apple_gpio_pinctrl_probe(struct platform_device *pdev)
>   	for (i = 0; i < npins; i++) {
>   		pins[i].number = i;
>   		pins[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "PIN%u", i);
> +		if (!pins[i].name)
> +			return -ENOMEM;
> +
>   		pins[i].drv_data = pctl;
>   		pin_names[i] = pins[i].name;
>   		pin_nums[i] = i;

Hi,

this is not really an issue. if pin[i].name is NULL, then 
pinctrl_generic_add_group() below will fail with -EINVAL.
So your change only returns a more correct error code and saves a few 
cycles in case of (unlikely) memory allocation issue.

Anyway:
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

CJ



