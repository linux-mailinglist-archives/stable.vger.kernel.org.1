Return-Path: <stable+bounces-155263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088CBAE31F8
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 22:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C01887273
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00F1E0DEA;
	Sun, 22 Jun 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NPTorpW/"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3AAD2C;
	Sun, 22 Jun 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624431; cv=none; b=kpn0ROq0zKg752SwX3MVTLADoWHsq0nFA9YXCngxD/OYJVAoBNTlEcSvMrmWRsVAQbOGHDYidUipsTSLQ3+VcURT0RwGnJnNs9eTXvzVNVNE+vfXkknc2bTWBNMWuD0N1QaJsai+QgrNKG6DwpZC77aa6obHzjWLyF+stsBWghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624431; c=relaxed/simple;
	bh=9qt3VEXjww2Y9h5OxVP6h/ujNfIbEToBjPUBwys0V/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buba9oNsSLUBInPCwOyWVbdxWr24YkQJvB8Qhcn+wEFiKhP8QOJ3E5lNxGmvgJIILxN5D+msytXK66gdD/Z2nv4j7BZEmLKvqgAQBt121L9mmoq5ryz6aICK99lnZDuo7KmYbMo+sWLxa/pZk3BnAdr/YelvleUisZ171uvTkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NPTorpW/; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4771F14C2D3;
	Sun, 22 Jun 2025 22:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750624421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DSenrNn0CjeH9c6zMLb3QHWm1cFVCBKUwae6Q8W2io=;
	b=NPTorpW/lzclVnSb68yVyhn4kVW8XqeeISVm8ANNTsHFAzcn7dygCvR+j/CeXXuHVh5mp6
	55uZrJyjustbhXTXG0b3xSMro/Aubr/tcjaVW0mZn7q29HwR2fZQCIOS+FmSbevDnbTRa0
	pbRNPe7rvGMTtOkYjTKoAh70yy2yzTO0mwQ0Yam6qzeWAVC2MSqJXDWylYI66vcBdClciL
	CPsA6WHrwLKb5tn4Fw3IMd3OdaRxC/jr3LiPFi37gr4ht5OdYtMHzXWnFLPJR7BtFXzQbw
	prss4uI3jXmVanj3jP5/wRoaDI5dG9xH4F+lWNccWjpMovHUhLdg8PhjuFprpQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8e85e19f;
	Sun, 22 Jun 2025 20:33:36 +0000 (UTC)
Date: Mon, 23 Jun 2025 05:33:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	security@kernel.org, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <aFhokd2CQwn_XBzJ@codewreck.org>
References: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>
 <2025062007-ravishing-overcrowd-7342@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025062007-ravishing-overcrowd-7342@gregkh>

Greg Kroah-Hartman wrote on Fri, Jun 20, 2025 at 06:56:24AM +0200:
> > -	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
> > +	if (req_size > p9_rx_req->rc.capacity) {
> > +		dev_err(&cdev->gadget->dev,
> > +			"%s received data size %u exceeds buffer capacity %zu\n",
> > +			ep->name, req_size, p9_rx_req->rc.capacity);
> 
> Do you want a broken device to be able to flood the kernel log?  You
> might want to change this to dev_dbg() instead.

I realize I hadn't replied to this one -- I (still) consider 9p mounts
to be somewhat privileged/trusted, so I'm fine flooding kernel logs with
a broken device.
If the trust model changes (I've been askedto make 9p mountable by
non-root users... perhaps after we've caught up with syzcallers
reports but not holding my breath) then we can revisit this, but 9p IO
errors are rather badly behaved afaik (connection possibly never
recovers) so I'd rather the first error stands out.

> > -	p9_rx_req->rc.size = req->actual;
> > +	memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
> >  
> > -	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
> > +	p9_rx_req->rc.size = req_sizel;
> 
> Did this code build properly?

Thanks/sorry for this one as well :/

-- 
Dominique

