Return-Path: <stable+bounces-203039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4BCCE097
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 01:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6445B30386B1
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 00:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBD1C3306;
	Fri, 19 Dec 2025 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="HgdKerMG";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="K+uzLMNM"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9D1B4F0A;
	Fri, 19 Dec 2025 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103317; cv=none; b=GuKxksUY4DGLKPWm1oWUxLubqRmwx1fdPKpGvlV0ExhdGvzV0l3hqK7B2hiaitqOIHZkp+LxOYdexFOacAzCR/uwAsp2RJmahb6yXfk5k48205oB+KPzO72QCiUdi09GVjLqBTYmCurqVLkbhoAxFarSnWUB54DKgK6yQ7KdVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103317; c=relaxed/simple;
	bh=9CsnFTjuB7sohWMfMUgV5b+iZzJ+aOuYYS05in0bHsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbfFYxHu3UcuuL0kL8ERqFDAunmSGlonf3Wpa7YJfEalLTumzWrBkFkDvwbilZtHmG9QCkLPK6grG5ylfXak/5YXk1YVSmu9GO/YTQVSdubb7/V6RmclKdbpkveuOTFPSif1Lg3SrRxERVqIewMyeROuL0+pFr5KlDAFUhty+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=HgdKerMG; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=K+uzLMNM; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103314; bh=9CsnFTjuB7sohWMfMUgV5b+iZzJ+aOuYYS05in0bHsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HgdKerMGQNvdq9Tbcr5TD6OX4a6I37SPytx6kqOHaiKRrmgCr29XNMkEOfCxswLuF
	 gzkI/PdS1Tzgz60K6rf7Utp11P3O8QUHwOClCUAn5Lq5OlLIHvvPGlFMezcfnbMCjr
	 Cvl8Yxlb+Hq2aAbqBjF7W1shlG4EnEI2+NkXmvYQwj4WbSiZuisT7xkdu7kvMWMXWB
	 TVGWgi//RYr0cpcgV1u2LtO2JtJ0prcGESR7goy14CEzmC5O8P1Jc6z6ZhIwbMUYNP
	 NSY8Ej2sD9kZwT4Y4p2HK1q1IndpBA0phLq5NZgIOpxF3qzCySmbjvEkSzeDErbhwi
	 +QTBiDWGIEzZA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id F32333E7A9A;
	Fri, 19 Dec 2025 00:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103313; bh=9CsnFTjuB7sohWMfMUgV5b+iZzJ+aOuYYS05in0bHsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+uzLMNMsSnV6YTOwpY+pPC8bL+IBDBqMV3E28W6LuOdv8gOILd4oIPrESDJ3qyKV
	 KRmDhkYcui8mnWL4VpzHauaz35TjQAktH5BwAX/BK4suTWHMdlSYQML1kLwzWFppzp
	 M9lDOGuWOuRP2Rhc0cHj4Vm3/WqS9DJEnVVv8kIRloamZfsOX/mG/iYfUdel+eoF7j
	 rGmq+v3hM1lXZxrKYWzjgOW2lx5N32F4YivyJ9ZosVaIHxgrDe6n9BHbgwrK0h8VuT
	 A+4kcWsromwo9c2EfMVZa0y1LlQL4cP+JDrbPQKqRcaE8nU6YaPEijwS9pcmo+2Bkj
	 4g5HY/Bf1UJQg==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 74C463E769B;
	Fri, 19 Dec 2025 00:15:13 +0000 (UTC)
Message-ID: <71adaa7f-808a-47df-85ed-55ec12da4561@mleia.com>
Date: Fri, 19 Dec 2025 02:15:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] usb: phy: isp1301: fix non-OF device reference
 imbalance
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Alan Stern <stern@rowland.harvard.edu>, Ma Ke <make24@iscas.ac.cn>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251218153519.19453-1-johan@kernel.org>
 <20251218153519.19453-3-johan@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251218153519.19453-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251219_001514_014465_EF56143C 
X-CRM114-Status: GOOD (  21.83  )

On 12/18/25 17:35, Johan Hovold wrote:
> A recent change fixing a device reference leak in a UDC driver
> introduced a potential use-after-free in the non-OF case as the
> isp1301_get_client() helper only increases the reference count for the
> returned I2C device in the OF case.

Fortunatly there is no non-OF users of this driver, it's been discussed
recently.

> 
> Increment the reference count also for non-OF so that the caller can
> decrement it unconditionally.
> 
> Note that this is inherently racy just as using the returned I2C device
> is since nothing is preventing the PHY driver from being unbound while
> in use.
> 
> Fixes: c84117912bdd ("USB: lpc32xx_udc: Fix error handling in probe")
> Cc: stable@vger.kernel.org
> Cc: Ma Ke <make24@iscas.ac.cn>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/usb/phy/phy-isp1301.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
> index f9b5c411aee4..2940f0c84e1b 100644
> --- a/drivers/usb/phy/phy-isp1301.c
> +++ b/drivers/usb/phy/phy-isp1301.c
> @@ -149,7 +149,12 @@ struct i2c_client *isp1301_get_client(struct device_node *node)
>   		return client;
>   
>   	/* non-DT: only one ISP1301 chip supported */
> -	return isp1301_i2c_client;
> +	if (isp1301_i2c_client) {
> +		get_device(&isp1301_i2c_client->dev);
> +		return isp1301_i2c_client;
> +	}
> +
> +	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(isp1301_get_client);
>   

Okay, let's go the way of fixing the broken commit instead of its reversal.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir


