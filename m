Return-Path: <stable+bounces-119672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA79A4612E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6CA27A9E2C
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4921D3D2;
	Wed, 26 Feb 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O+J6C6YS"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E041C71;
	Wed, 26 Feb 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577421; cv=none; b=FYjjDYxn/fO5Lo+a0J1K3p0B48RvBj/ECYvfw5kBTc8BmT9Gy//GFO3E4EePS0cvXT9m0jDwhe6heFvdXfCxRBFAFM66NXEmNNJv/YNm3zCe6qkZ+TKmtIJrpNyMDKI13rC/VR5AEFsJ3j6Ei519cuO9LEzhKrfXIS3Btgt86ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577421; c=relaxed/simple;
	bh=C1RgbLR6GSfvgGMUX8LxeDVo7GdVzjmW06YGox9WhSA=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md+QrwwDR005Mwl2QpnxTVImF9KRaAQsRWAc9yETJXQu6GpLzN6DmT7/UgEK+yPAuQkWDFCFqV8VsKQjzsEBPbWaVYw9Eb5jwdKIx52+n3+4tN6xUrxax4Q70xiRbmfFocgTVH1XB9nXLkF4mhv9BzCN2tLUDpMqaPCawSwhmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O+J6C6YS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+RM9fCd/pH/t1kXOr5ohz3w+lMtjBfCOedTcP39zAaM=; b=O+J6C6YSUoR+qkSnbq3xnBv7kq
	TK4+SebVazszU6RcdBlkTq5CUyf3NmIhIhYO4MGohY316oVlXE0KLvs6ss0yQ3ky3nYPY3QhgpeF9
	eE9Sc7oXJ+d8EeSJgvEf/0+iAexlZBH/QGnIn08RsEP67gXc1wGFh+n+8SXiFA7yLrgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnHhD-000Gqa-Mm; Wed, 26 Feb 2025 14:43:31 +0100
Date: Wed, 26 Feb 2025 14:43:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <418ddcf6-e7c9-4a8e-ba1a-38a83cb2b5f8@lunn.ch>
References: <Z7R6uet1dJ1UJsJ1@qasdev.system>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7R6uet1dJ1UJsJ1@qasdev.system>

On Tue, Feb 18, 2025 at 12:19:57PM +0000, Qasim Ijaz wrote:
> On Tue, Feb 18, 2025 at 02:10:08AM +0100, Andrew Lunn wrote:
> > On Tue, Feb 18, 2025 at 12:24:43AM +0000, Qasim Ijaz wrote:
> > > In mii_nway_restart() during the line:
> > > 
> > > 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > > 
> > > The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> > > 
> > > ch9200_mdio_read() utilises a local buffer, which is initialised 
> > > with control_read():
> > > 
> > > 	unsigned char buff[2];
> > > 	
> > > However buff is conditionally initialised inside control_read():
> > > 
> > > 	if (err == size) {
> > > 		memcpy(data, buf, size);
> > > 	}
> > > 
> > > If the condition of "err == size" is not met, then buff remains 
> > > uninitialised. Once this happens the uninitialised buff is accessed 
> > > and returned during ch9200_mdio_read():
> > > 
> > > 	return (buff[0] | buff[1] << 8);
> > > 	
> > > The problem stems from the fact that ch9200_mdio_read() ignores the
> > > return value of control_read(), leading to uinit-access of buff.
> > > 
> > > To fix this we should check the return value of control_read()
> > > and return early on error.
> > 
> > What about get_mac_address()?
> > 
> > If you find a bug, it is a good idea to look around and see if there
> > are any more instances of the same bug. I could be wrong, but it seems
> > like get_mac_address() suffers from the same problem?
> 
> Thank you for the feedback Andrew. I checked get_mac_address() before
> sending this patch and to me it looks like it does check the return value of
> control_read(). It accumulates the return value of each control_read() call into 
> rd_mac_len and then checks if it not equal to what is expected (ETH_ALEN which is 6),
> I believe each call should return 2.

It is unlikely a real device could trigger an issue, but a USB Rubber
Ducky might be able to. So the question is, are you interested in
protecting against malicious devices, or just making a static analyser
happy? Feel free to submit the patch as is.

	Andrew

