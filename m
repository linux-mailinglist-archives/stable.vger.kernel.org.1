Return-Path: <stable+bounces-179224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B53B52529
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 02:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68390171BA4
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CE1F4621;
	Thu, 11 Sep 2025 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1pxoLt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6F1DE4CD;
	Thu, 11 Sep 2025 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551848; cv=none; b=KRZpJfamGwvEWoxbTuhMAINPs0Zs6HgAbqpA86bukAg4KTawCA51qHtVrGvJonTbT4NwBWRi2ryXnrUeU7tjMkyvQG48BXMq5A50bp6DOPQar1l5aGab1J4zwfb01TFBrN1RwXk9oLpcbVqjvCG4H+G1K4ji5G/htZbnWa4rhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551848; c=relaxed/simple;
	bh=CCzEqYjRt9XWktduZvjN/8dY64I8avmb7eUyz9LoKxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5gEPOfXJyYRpM5PDPtCaou9oZeKvmNINh79gcGGe2zV/r1PYDYHvzGPzMxKjl5Legz+v/GeKX8T7dfMusMlli5vS9+fxPzZjCAiuUR+kY4KqyCLfLS9NCT0DvYZjcNH1vDuJgQCYDCRw23p02H9xAYfpDx+4hxiWjx8gW2dtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1pxoLt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BC7C4CEEB;
	Thu, 11 Sep 2025 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551848;
	bh=CCzEqYjRt9XWktduZvjN/8dY64I8avmb7eUyz9LoKxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1pxoLt6g/EcpvVYn4QDPnaMSs5+Pq2BTmIcKYki/RMPxWIWVjwg9xHq0JKqC9EeG
	 l0V9dmuhbyIu/1NnA7Rn9DaPhy9bkXn4elZPFSgRqYd4uYziaQeKXukxhKyFBJiQZ3
	 34Q+eyRB9pdUShBB/lcfIZONCfNr+r8y3dz5lpbA50XEsDZkfDo/TizqzTtTaITa0R
	 Gx1QJ8wTS7KbYi5dN0oHL1QIsFFC3ShyKSw2suZGaeg1LOvI+l6TdaXICSNSOGhH80
	 z/IqasKXgx0gdd7o0efDJBxpxkHBVwruX3tqjzr5m2J02vgijS22yBSFl0F9h5ppP9
	 0hrBP3ppvJsBw==
Date: Wed, 10 Sep 2025 17:50:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Russell King
 <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <20250910175046.689f6abb@kernel.org>
In-Reply-To: <aMD6W80KfjcSz4In@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
	<20250909165803.656d3442@kernel.org>
	<aMD6W80KfjcSz4In@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 06:11:07 +0200 Oleksij Rempel wrote:
> On Tue, Sep 09, 2025 at 04:58:03PM -0700, Jakub Kicinski wrote:
> > On Mon,  8 Sep 2025 13:26:19 +0200 Oleksij Rempel wrote:  
> > > No extra phylink PM handling is required for this driver:
> > > - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.  
> > 
> > Meaning the interface is never suspended when open?  
> 
> Ack.

Alright, last time we touched usbnet we broke Linus's setup.
So let's say a quick prayer and..
:D

