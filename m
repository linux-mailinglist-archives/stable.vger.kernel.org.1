Return-Path: <stable+bounces-132678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96371A8916C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 03:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4273ACE47
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102519DF48;
	Tue, 15 Apr 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wWOCs9XA"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2760DCF;
	Tue, 15 Apr 2025 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680916; cv=none; b=I8Fj3crJ8JqmfBoPYYANmbE5SO7ayR6CFKS8Lv8+BgjG7SwwjTGkMM9dmZZyRAcWuUN+R8XXhJyDTt8o/AHxDCekBDw+xdzM3AUpupqf4Sri6DOCcIJp9Xyyd66MtVrLCNjt4lnDWKGONRqNcLemQ4EPZP0qRqMNVoKF4G5Uq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680916; c=relaxed/simple;
	bh=wRuP1NRSC1BsMmcqei+fx7IF60RxB+2Uj0kHYZWNjzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzu9I3gIFRyVLdpmGrkCuRfuZACGRpiviPiC469rBaul5fTjoDQD/TLFc23GHdB0ZMAOoW7XTjCVyNZXZHUdO8TcbmWOwMjWu8v/CWKfo1r/wEqO6069KhcSWbwSsfKwlgSJuYhpJH/+dGViteqGtF2za3/U8ap07dykkDvg/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wWOCs9XA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I1cbI5+pkj/hOZGceZRN10hFZrE+QXRqS1+7QDiAZpM=; b=wWOCs9XAm2+fu3B0Zff96+yxRv
	1QMlsJNG0BA84OOTnBwhzlNhW+VWeXbtZ4pJkaCN7vZuqaAO5//pkFnkglF///DL3EfBakAe0RuNb
	9GObEBOZJjid/yc3p1Ohv2C5CldueEo+EkvRABgwK7CkQXrHW4AiEVN/YEStUcIDQaYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4VCd-009Ju8-Jg; Tue, 15 Apr 2025 03:35:07 +0200
Date: Tue, 15 Apr 2025 03:35:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412183829.41342-6-qasdev00@gmail.com>

On Sat, Apr 12, 2025 at 07:38:29PM +0100, Qasim Ijaz wrote:
> During ch9200_mdio_read if the phy_id is not 0 -ENODEV is returned.
> 
> In certain cases such as in mii_nway_restart returning a negative such
> as -ENODEV triggers the "bmcr & BMCR_ANENABLE" check, we should avoid 
> this on error and just end the function.
> 
> To address this just return 0.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com> 
> ---
>  drivers/net/usb/ch9200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
> index 187bbfc991f5..281800bb2ff2 100644
> --- a/drivers/net/usb/ch9200.c
> +++ b/drivers/net/usb/ch9200.c
> @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  		   __func__, phy_id, loc);
>  
>  	if (phy_id != 0)
> -		return -ENODEV;
> +		return 0;

An actually MDIO bus would return 0xffff is asked to read from a PHY
which is not on the bus. But i've no idea how the ancient mii code
handles this.

If this code every gets updated to using phylib, many of the changes
you are making will need reverting because phylib actually wants to
see the errors. So i'm somewhat reluctant to make changes like this.

	Andrew

