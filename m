Return-Path: <stable+bounces-105573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170269FACE0
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140071884BCF
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA00191F6F;
	Mon, 23 Dec 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="b9s9TBca"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D982AF1D;
	Mon, 23 Dec 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947665; cv=none; b=PQ2YhoAfVZuJ4bGfDBOl8W4XVGszIKSwLr9Ucz0WWmukto4Q2jh0u+hboNAxW9ufrJ7o5DfHjUjhhnJu26GaszrPHeoPwLlEGQ/GXXs/1IlJtX+SFYm3KBKTVTptZzY8DrwU6NYJUBvybkVLHEYxTk00ce4sBMr0PqY+5ZJEx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947665; c=relaxed/simple;
	bh=IsiyxwM42tVsYFhlspfcZgQsVXrZHw6SodvmuEjxBLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJfOPRHEmcIhOqcr27DzMzbZZ7YiSzz7xDbBN8NbDAwAosOmcbBYyJofJDY+vNa2Yd/Xk4TtjfmwmmCtrJ4TTuyejoianwu7VyU83zd3Mj/0psSmyBAFyjOAfYRcVXybUYatyBRnF06oroV3+9OnhCsYEUFlq2DMfZV3mHYrhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=b9s9TBca; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6F754518E778;
	Mon, 23 Dec 2024 09:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6F754518E778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1734947194;
	bh=8L3X9ortj8P6VyUjEWVqaUBaQArAdK3FFtCIpQGVo3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9s9TBca1nob+/SS1NPqRJ911IbT+AxZ+f32Zt7h8Wx5hOLvwQtqNn3ca04HeDI1e
	 djwE+WhDGx0pGqacl1HG+KBEfo+m4SvmJp551EaAKof044O8NOYNkaeGWXBZfsGOkt
	 4nViSKXOfCXYRZ8xaktdVvnxTUUglSZHKcZV/dpI=
Date: Mon, 23 Dec 2024 12:46:30 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Vitalii Mordan <mordan@ispras.ru>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: ehci-hcd: fix call balance of clocks handling
 routines
Message-ID: <20241223-7a6c874adb4a809293a4dca6-pchelkin@ispras.ru>
References: <20241121114700.2100520-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121114700.2100520-1-mordan@ispras.ru>

On Thu, 21. Nov 14:47, Vitalii Mordan wrote:
> If the clocks priv->iclk and priv->fclk were not enabled in ehci_hcd_sh_probe,
> they should not be disabled in any path.
> 
> Conversely, if they was enabled in ehci_hcd_sh_probe, they must be disabled
> in all error paths to ensure proper cleanup.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: 63c845522263 ("usb: ehci-hcd: Add support for SuperH EHCI.")
> Cc: stable@vger.kernel.org # ff30bd6a6618: sh: clk: Fix clk_enable() to return 0 on NULL clk
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---

The current patch was added to stable kernels lacking the necessary
prerequisite ff30bd6a6618 ("sh: clk: Fix clk_enable() to return 0 on
NULL clk") which is specified in Cc:stable tag of the commit description
per stable kernels documentation [1].

[1]: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Could you please cherry-pick ff30bd6a6618 ("sh: clk: Fix clk_enable() to
return 0 on NULL clk") to 6.1.y, 5.15.y, 5.10.y and 5.4.y ? It applies
cleanly.

Thanks!

>  drivers/usb/host/ehci-sh.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
> index d31d9506e41a..77460aac6dbd 100644
> --- a/drivers/usb/host/ehci-sh.c
> +++ b/drivers/usb/host/ehci-sh.c
> @@ -119,8 +119,12 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->iclk))
>  		priv->iclk = NULL;
>  
> -	clk_enable(priv->fclk);
> -	clk_enable(priv->iclk);
> +	ret = clk_enable(priv->fclk);
> +	if (ret)
> +		goto fail_request_resource;
> +	ret = clk_enable(priv->iclk);
> +	if (ret)
> +		goto fail_iclk;
>  
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret != 0) {
> @@ -136,6 +140,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
>  
>  fail_add_hcd:
>  	clk_disable(priv->iclk);
> +fail_iclk:
>  	clk_disable(priv->fclk);
>  
>  fail_request_resource:
> -- 
> 2.25.1
> 

