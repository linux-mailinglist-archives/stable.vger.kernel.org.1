Return-Path: <stable+bounces-203205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D212CD53E1
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6811E300C0CB
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC52FC011;
	Mon, 22 Dec 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aq3mkN1S"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD69226CF1;
	Mon, 22 Dec 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766394464; cv=none; b=EY0jwuUf9qZhcmzYVBTWXFS4hczyD7qOm81gf/TUlgKwPA6gvOzYY820MEFv5qGEFS9TdO8Gr8NDnN3tybktQe4hhh8ABNcqfzCzlknYN52pzeVZ82HqO5Gt56RIV2+QTw5n3nQI15+Wi2a2O233MFKYNfusqyQh86X2Jh0kLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766394464; c=relaxed/simple;
	bh=FZO8A1oCiEKduFgK/VgdOVArquSOAEjpCTbXaSs51Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqcfB/gQ3j+Q92vQ/m/UP/JHhZt9HQNVD7b8PUGPzkw2iGrzDAczPbC2mJ1yrgY9vpDyJ9dIHBAvT9DR7o22TcpUTryA8XFfWVEAz9ViK5t+F2A9v+3dcDy6Ykw/W5/fku/Bd7d4bDx3jlnwvWG64vvUGijhTWQtu23b22Rvn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aq3mkN1S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=UFJ2hQrr9TPFdahxPW3to7FdtjsagKdsAQCxdi7EZ5M=; b=aq
	3mkN1SgkcbPpgiwudxWF3Oy7LjZkw1CDM4pXywR5aZl1TgA6NfF34n/FLdXYdYsF1qqeMW5aefh03
	weW052WjwuQSQDpQFXZoYkK/3bjfLCpr5z5YtzBK5iVStLrxge/DZaqWR9BCGWk2C56vckpeQYAbF
	0OoF52PGlS+RmB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXbtC-000A56-IC; Mon, 22 Dec 2025 10:07:38 +0100
Date: Mon, 22 Dec 2025 10:07:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
Message-ID: <5be10af1-e7ca-4bed-bf19-0127e2eeb556@lunn.ch>
References: <20251221082400.50688-1-enelsonmoore@gmail.com>
 <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch>
 <CADkSEUhW5+=mo8nLK9cSa7Nh0SKP-RXV=_z7RY73BZgUH=kV9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUhW5+=mo8nLK9cSa7Nh0SKP-RXV=_z7RY73BZgUH=kV9w@mail.gmail.com>

On Sun, Dec 21, 2025 at 03:42:58PM -0800, Ethan Nelson-Moore wrote:
> Hi, Andrew,
> 
> The other two are correct because they intend to write multiple registers -
> they are used with a length parameter. 

Please don't top post.

How finished do you think this driver is? Are there likely to be more
instances of SR_WR_REG/SR_WR_REGS added in the future? If so, it might
make sense to change the code to make this sort of error less likely.

SR_WR_MULTIPLE_REG and SR_WR_ONE_REG?

		   Andrew

