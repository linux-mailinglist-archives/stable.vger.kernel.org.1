Return-Path: <stable+bounces-195016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C8C65FD4
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1727E3472DF
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF805301030;
	Mon, 17 Nov 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="nJNWfesj";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="nJNWfesj"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF07260F;
	Mon, 17 Nov 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408256; cv=none; b=rdrL7beCECxpKVjlAHxZl8PDF7itPHW/Ggg2QTb5aEsr16h1migyxC2OVr2CIImyUTvyR208q1uHqbRJS6uYcHkHNE9N/mRQY4U2I4cKLa9v8UcLiXN6kpyZl2mY81Vorvfn9fzBVa8WruUNYRozAHcD1aqkKeX0RD3yGzrlA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408256; c=relaxed/simple;
	bh=HJiyM+TjOIWKLKTw7MYVnnaCGoGvZairr1UN5br0BUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG8iW8ayRZOxkqQauSB8dUdZoJa/CyPuumtk7yjU4aG6G+8p0RskAlhRvflp10LDSmMhjFY9z32SG3gqlVdISebSi/KQ2COWACLTSBx3a2WGAqh7zK8Q49wN2N2e+ZX6d0jymf+hF0BM/1m9cmVknU+eagl5lMjM43VXOhuV/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=nJNWfesj; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=nJNWfesj; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763408252; bh=HJiyM+TjOIWKLKTw7MYVnnaCGoGvZairr1UN5br0BUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nJNWfesj1FqGsS1ypY+bq/sXkuUl74fn37W7RarPFh73HCQsvKdAz2P/ndimtAyqF
	 2jsPHy+lCQAVDkNHMTL1wme6juoNpIxfd7/DMzFOL1ps4XbyLitDrb709tawQ8P8bW
	 rJg/Xv1wYv6qNLuZwgok+gphpW2ZkKWW85V2mBvzebcocJDOZCCmJS+ExVtc6NzUbm
	 TpFiO0GnT6RL6/RR1XQJ3XcdImv0eTuoomRPca7JHAXr7gw4D/JPS8vDAxcGufbdsw
	 dv6mwwSNw4+4ITFgcrZO0TeIUp9ym+lYOsaDpS05ZCwt9NUDXde4kxSzGSym4+pmzm
	 DCzCH0RyXLflw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 8B9493E1D1D;
	Mon, 17 Nov 2025 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1763408252; bh=HJiyM+TjOIWKLKTw7MYVnnaCGoGvZairr1UN5br0BUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nJNWfesj1FqGsS1ypY+bq/sXkuUl74fn37W7RarPFh73HCQsvKdAz2P/ndimtAyqF
	 2jsPHy+lCQAVDkNHMTL1wme6juoNpIxfd7/DMzFOL1ps4XbyLitDrb709tawQ8P8bW
	 rJg/Xv1wYv6qNLuZwgok+gphpW2ZkKWW85V2mBvzebcocJDOZCCmJS+ExVtc6NzUbm
	 TpFiO0GnT6RL6/RR1XQJ3XcdImv0eTuoomRPca7JHAXr7gw4D/JPS8vDAxcGufbdsw
	 dv6mwwSNw4+4ITFgcrZO0TeIUp9ym+lYOsaDpS05ZCwt9NUDXde4kxSzGSym4+pmzm
	 DCzCH0RyXLflw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id E35743E1D02;
	Mon, 17 Nov 2025 19:37:31 +0000 (UTC)
Message-ID: <0f085940-2214-4d0f-b08b-e4d40b07051b@mleia.com>
Date: Mon, 17 Nov 2025 21:37:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
To: Ma Ke <make24@iscas.ac.cn>, stern@rowland.harvard.edu,
 piotr.wojtaszczyk@timesys.com, gregkh@linuxfoundation.org, stigge@antcom.de,
 arnd@arndb.de
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20251116010613.7966-1-make24@iscas.ac.cn>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251116010613.7966-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251117_193732_588530_8A8B3746 
X-CRM114-Status: GOOD (  18.12  )

On 11/16/25 03:06, Ma Ke wrote:
> When obtaining the ISP1301 I2C client through the device tree, the
> driver does not release the device reference in the probe failure path
> or in the remove function. This could cause a reference count leak,
> which may prevent the device from being properly unbound or freed,
> leading to resource leakage. Add put_device() to release the reference
> in the probe failure path and in the remove function.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/usb/host/ohci-nxp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 24d5a1dc5056..f79558ef0b45 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -223,6 +223,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>   fail_resource:
>   	usb_put_hcd(hcd);
>   fail_disable:
> +	if (isp1301_i2c_client)
> +		put_device(&isp1301_i2c_client->dev);
>   	isp1301_i2c_client = NULL;
>   	return ret;
>   }
> @@ -234,6 +236,8 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
>   	usb_remove_hcd(hcd);
>   	ohci_nxp_stop_hc();
>   	usb_put_hcd(hcd);
> +	if (isp1301_i2c_client)
> +		put_device(&isp1301_i2c_client->dev);
>   	isp1301_i2c_client = NULL;
>   }
>   

For v2 please remove checks for !isp1301_i2c_client as pointed out by Alan Stern,
and then feel free to add

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

