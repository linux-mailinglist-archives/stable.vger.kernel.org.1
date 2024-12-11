Return-Path: <stable+bounces-100618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A519ECD42
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CCB2823B3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CA22C348;
	Wed, 11 Dec 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ron5fLPA"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098F23FD1E;
	Wed, 11 Dec 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924057; cv=none; b=XMqsITALsiZfx0TG79NqPj6AYAlwSDs3MdLOnlS45j/lnn/r+oXmpPBlp5pZSJvYRJ3hDpJE3LGgkbkoBUVduIH6DTdPLo+xnW1l/OsZKzIZ8VYzARNYw5h//WOLe9JQ9TgzM5fmPBqrBwX/RdaZn5uSMMTmzeDGmeAuMbEkIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924057; c=relaxed/simple;
	bh=WszZcEp+hm9oobZQ0cpYfNt6xlUzCkv3qvAcbh8jlQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkFYOTVNfQd85I6+BsVbA4gG8rl5WHsfB/EIPZqfW+dX5C+n1O7bQsU1Jn3Bef4+5FQdKKX73K0WMi1b/4+7aNIfBzgPOg3HyiDP93VnFzbJFFNLrWisMlkRgaZl47wlkbleeSSSXXnb1zxcMgh1ku9xAaFU4cD9edtM0gJ1XUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ron5fLPA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sDFfLRnwNPdpPqXLbuUXlu1XVZL5ZhlVr6oeF4VaGas=; b=ron5fLPA1q7RbMNK3S0gPcITab
	PTQFbtHPTHB4du9033xdgWbr+uxGrDdCceb6LK/OyZZkfNmehh4eSoWBarXEOPwmgSMpv8EzI0irJ
	0M0flG2utvVjJLaQGQn3smP6aV8bwqPgCIw7IXtdeNdBtrPqHud5Fv58iJGGNaaZlTm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLMqo-0006Dq-Fk; Wed, 11 Dec 2024 14:34:02 +0100
Date: Wed, 11 Dec 2024 14:34:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
Message-ID: <fe505333-7579-4470-852d-6fddd20197ab@lunn.ch>
References: <20241211124657.1357330-1-robert.hodaszi@digi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211124657.1357330-1-robert.hodaszi@digi.com>

On Wed, Dec 11, 2024 at 01:46:56PM +0100, Robert Hodaszi wrote:
> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> added support to let the DSA switch driver set source_port and
> switch_id. tag_8021q's logic overrides the previously set source_port
> and switch_id only if they are marked as "invalid" (-1). sja1105 and
> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
> initialize those variables. That causes dsa_8021q_rcv() doesn't set
> them, and they remain unassigned.
> 
> Initialize them as invalid to so dsa_8021q_rcv() can return with the
> proper values.

Hi Robert

Since this is a fix, it needs a Fixes: tag. Please also base it on net.

There is more here:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

