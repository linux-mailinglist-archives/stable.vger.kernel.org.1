Return-Path: <stable+bounces-77709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E19863CD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C0028911D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56E79C4;
	Wed, 25 Sep 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JR0ZAFKt"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333311D5ABD;
	Wed, 25 Sep 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278811; cv=none; b=D3Wjnt3laS1nroPetVwH2XHwSdWDSyEBNKYwBCFilR07y0vQzBT6CQfWWJHZzUoi46etNrwbWCColBxwNABd2AYEZlhHbOIW38hTXxug/waQYsVTK7tC9oCForMHS+K6rlf6i1hmz2DffNyIThLtfy6Pkd3fx+C/i37RW14ftzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278811; c=relaxed/simple;
	bh=kL8HG8Xwa+i7w3XjeWLMDj9WPGvuks109dxhfgzU49k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHGsskiByLi+sxOpc0kvUn0IuTGK5EHtVLOk4dEb9h99XcMO2zKnDXGH4Qawc2DcXO93YzOFDHlSdFIZOB3xlXpvX/mWk+zEQZA0hqZZB0f86dyf+KRVgsrdA2OQMSvVdWSpA3D1aS3bbjGLsqs1S2JLaxdDbgua3v68SmPEl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JR0ZAFKt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q77yhq1cjviFHLXOxf/F3ZQcus4c7vEqJGBAAXfzwWM=; b=JR0ZAFKtKim2yR550of1N1F1Q1
	/JCk7LL7jvgFcrysPJyNlo3wO0/vgPCH2NQRNIij845O+MY2zijXjnFCvs9PTX6atmcz56czB4LIr
	GNd/kk4yE3sem4uG/IeEEcMjZrA4vihVIYMaovwUcwS1h6vS2yUBJFvh055A8hLeXgSk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1stU77-008InE-8a; Wed, 25 Sep 2024 17:39:37 +0200
Date: Wed, 25 Sep 2024 17:39:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: George Rurikov <g.ryurikov@securitycode.ru>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] r8169: Potential divizion by zero in rtl_set_coalesce()
Message-ID: <060a134b-63ea-4dc1-a5f3-980b2bb4334f@lunn.ch>
References: <20240925135106.2084111-1-g.ryurikov@securitycode.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925135106.2084111-1-g.ryurikov@securitycode.ru>

On Wed, Sep 25, 2024 at 04:51:06PM +0300, George Rurikov wrote:
> Variable 'scale', whose possible value set allows a zero value in a check
> at r8169_main.c:2014, is used as a denominator at r8169_main.c:2040 and
> r8169_main.c:2042.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2815b30535a0 ("r8169: merge scale for tx and rx irq coalescing")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 45ac8befba29..b97e68cfcfad 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2011,7 +2011,7 @@ static int rtl_set_coalesce(struct net_device *dev,
> 
>         coal_usec_max = max(ec->rx_coalesce_usecs, ec->tx_coalesce_usecs);
>         scale = rtl_coalesce_choose_scale(tp, coal_usec_max, &cp01);
> -       if (scale < 0)
> +       if (scale <= 0)
>                 return scale;

Please think about this. Say scale is 0, and you return it. It appears
the call has worked, but in fact it did nothing.

I much prefer a division by 0, causing a splat, than the silent bug
you just added.

Also, please could you explain the code path which results in scale
being 0.

    Andrew

---
pw-bot: cr

