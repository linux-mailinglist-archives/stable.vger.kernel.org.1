Return-Path: <stable+bounces-56001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F312891B1C3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD800284048
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABD1A08C7;
	Thu, 27 Jun 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnGf/csM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC41864C;
	Thu, 27 Jun 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525462; cv=none; b=TSGkEUHFEllYtzMWc7rF0I86vKxf1tshJ6iWolnoieo+4LJXpG5kFKi+5rtJHNq7wJuG207UXrjme5JXmaT+Wbxppasju1ZE+Uo4DiRlW7mO/d8OXuHPmC73oiAZAaNgpaAHw0LEAF7bsY38zZGvn5uZfz2Gk8m/+dbxPdNPt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525462; c=relaxed/simple;
	bh=btUn2RTfx69GlQFcTNPIXCDVQg0YlIo0Eispfw6DYUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb+F/RQSFjxJuHezJjrQ1ql+naCTOwoEHR9hShC+4JYSpq6gxbw0l7V578LsHgskT9mnBOaeVYi4w7dkUqVfQA7Be3JHk1x1UMbAY0TSbrwyH8etUVkdBpxvMXPCBFWz9HzS0A+NVBKFYYsh4n3qeGFNj8UfMrKYXBYhx6Ck1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnGf/csM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B12C2BBFC;
	Thu, 27 Jun 2024 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525462;
	bh=btUn2RTfx69GlQFcTNPIXCDVQg0YlIo0Eispfw6DYUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnGf/csMhppI+fPN7bpCdPj/EHjFvZ4zieA3RgXcHwgRwRnDgAPb/mZGTust+0bly
	 26oeAXQZWiuN9Qxvn7P8cZYAuI7htqQFA3nw6TUGRuIsbqbnjVZ68aa8wsTBZ6omwR
	 jtsTbfJGIdWYj+Dyv+d4xZhdUdIePdyJxWWKLCOz2ZHqKeI3LZTAQDnlmdybtvbIpV
	 qLWLdoOldobGdidpgVMGbEqW8z0ivAUKa+85/KGSvf8jNy1n0j0WiAH41m31p22Ww0
	 1hRT2b4CqcB3vky2YU9+vxcCwtUNwWY45cX72D5nianocwqDiAIRQjyVcGinBrTjBL
	 XkiWBIRRFRLwA==
Date: Thu, 27 Jun 2024 14:57:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1 1/1] net: phy: micrel: ksz8081: disable broadcast
 only if PHY address is not 0
Message-ID: <20240627145740.26df3456@kernel.org>
In-Reply-To: <20240627053353.1416261-1-o.rempel@pengutronix.de>
References: <20240627053353.1416261-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 07:33:53 +0200 Oleksij Rempel wrote:
> Do not disable broadcast if we are using address 0 (broadcast) to
> communicate with this device. Otherwise we will use proper driver but no
> communication will be possible and no link changes will be detected.
> There are two scenarios where we can run in to this situation:
> - PHY is bootstrapped for address 0
> - no PHY address is known and linux is scanning the MDIO bus, so first
>   respond and attached device will be on address 0.
> 
> The fixes tag points to the latest refactoring, not to the initial point
> where kszphy_broadcast_disable() was introduced.
> 
> Fixes: 79e498a9c7da0 ("net: phy: micrel: Restore led_mode and clk_sel on resume")

Is there a reason you're not CCing the author ?

