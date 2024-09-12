Return-Path: <stable+bounces-76013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAA976F4E
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BFD2856A3
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFE1BF7F1;
	Thu, 12 Sep 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kFFr7uNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3B1BD039
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161063; cv=none; b=VAEHg9m6kuNtF13hiD5UvKjhn4+xWxAph9qlOdZ173OLwQNoptGsCc1Gbl79prqdu4Bm740ufa43owShqTVTQSotKxRBryV7gVzqDtp2IpEJv4Mr8OhN8+R23zrVgK/zXbSfbQLRGRXhKVxYkIv9tou25yL6b/yn/Je+AV5D9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161063; c=relaxed/simple;
	bh=5gJ6l5wVgyMHD+DRrXFNhJNf/Ygal/hUcFQKO+ht7iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYl5jrcJvWRElgPnz5FNKqtoKXCwpefZjCdBvcJ2QRQl/3AVginpr/lx/wp7K2k2FthdPsdKelkPJqRz0YHqQtRTJGyuG5hHvkU2fydX+t0RDzja4ojd88bihcz1OPl1tn4GFpCURXa4Cwp5h82vp8bRLU4WdRsqdcry+KTYwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kFFr7uNL; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id onLHsHKzxfEYhonLHs9PCQ; Thu, 12 Sep 2024 19:10:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726161052;
	bh=2Ee2CxsZWgzD01X0OHNp/hegrnEnDGrKsW9T6JRCD+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kFFr7uNL2TlFiAJNHp/EI53/sJtSLLtbceO30Z3953ZzruJjsPTVbz5JVB51c2Cok
	 FMhLg6gj+c7Z/6e9OmYO3Zx4VgcV75Z1RoUWnYk+9lBRVe0ruJ8zwN6BiKpGUM0TnM
	 F8Zq+sbxhLycbyFeBc5BFka5LNWSqB9YiwJFejX2Mn582LyB6CxuokfGCcQEN699SV
	 wTDev48JTr0aRlJRDO6fi5v9uPDqO/U9ZGXouHpjDGgrAes9KIAwxP7l/XkLYUOEmo
	 Y3W9poJuH2N/7C2kf6ku+q8dXFgBRhpxSIA42oIgKCIY3/mYgqf/CAkhIjIop2F2xS
	 OhzNA6UyhOm7g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Sep 2024 19:10:52 +0200
X-ME-IP: 90.11.132.44
Message-ID: <5ed76217-c30e-4b9a-9462-0dbd859b2a79@wanadoo.fr>
Date: Thu, 12 Sep 2024 19:10:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c/synquacer: Deal with optional PCLK correctly
To: Ard Biesheuvel <ardb+git@google.com>, linux-i2c@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <20240912104630.1868285-2-ardb+git@google.com>
Content-Language: en-US, fr-FR
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912104630.1868285-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(trying to merge t and cc fields from Ard's and Andy's messages)


Le 12/09/2024 à 12:46, Ard Biesheuvel a écrit :
> From: Ard Biesheuvel <ardb@kernel.org>
>
> ACPI boot does not provide clocks and regulators, but instead, provides
> the PCLK rate directly, and enables the clock in firmware. So deal
> gracefully with this.
>
> Fixes: 55750148e559 ("i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()")

Hi,

If that matters, I'm not sure that the Fixes tag is correct.

IIUC, either it is a new functionally that is added (now it works with 
ACPI...), or if considered as a fix, then I think that it is linked to 
commit 0d676a6c4390 ("i2c: add support for Socionext SynQuacer I2C 
controller").

I don't think that 55750148e559 introduced a regression. The issue seems 
to be there since the beginning. Agreed?

If yes, then it may be needed to backport it in older kernels too.

CJ

> Cc: <stable@vger.kernel.org>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> https://lore.kernel.org/all/CAMj1kXFH+zB_YuUS+vaEpguhuVGLYbQw55VNDCxnBfSPe6b-nw@mail.gmail.com/T/#u
>
>   drivers/i2c/busses/i2c-synquacer.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 4eccbcd0fbfc..bbb9062669e4 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -550,12 +550,13 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
>   	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
>   				 &i2c->pclkrate);
>   
> -	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
>   	if (IS_ERR(pclk))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
>   				     "failed to get and enable clock\n");
>   
> -	i2c->pclkrate = clk_get_rate(pclk);
> +	if (pclk)
> +		i2c->pclkrate = clk_get_rate(pclk);
>   
>   	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
>   	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)

