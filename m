Return-Path: <stable+bounces-191175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61202C1112D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D6A188AF11
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8632C951;
	Mon, 27 Oct 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mr6Lny8+"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379932D0F9;
	Mon, 27 Oct 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593203; cv=none; b=uwFYOVlgWOB8WdvypcKryVIZw9JzjsH0W939puiw9umKeJLsuh8KWYMf+N5ed2RzM9hF2icJyCZXBm0nCesh03HmMrDF2ZBiu8SUs/i+IaxhnYLtiQ+t+qtlDirM6FhKkDPs8IO0O5C66pSoqlpWEJ0Fm67Ss74mYA7j44xm4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593203; c=relaxed/simple;
	bh=wm0oUa3mKa5IPbDSdqoAVyrF4ABVV7bku4lO6iYefFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2H+lq3axsFbWB3kn1BLooaFi1DJGfYFVjfAf+C/P7sY0E/IjRB3Clt7+MrP1MJvF66nnBYuJXI8Gh2GqTnueTDaBXkJfKuB549q1xl8CIQxBxCUkNDO0GCcxpnWm98zz2Qaar1HzFAhtNsKrfCQxVOmHpfE1QfYgkZqmHuvmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mr6Lny8+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rltA5F3NOT3/02lZg9x1jrEu7cFJbW2XAm8Wg3w2ho0=; b=Mr6Lny8+3zCZLImDC3HPEWPRxK
	zkL42IMNzI8TNT+0v/7QzXALMjbsFEEeWCf8lPLxS4CTsYHwXoJZpvez63CmdnOv5k7g35+7nG0BP
	TwBrAH8Ir6QfNhVU+ra86rRvEmL9z4tM+cLmyvv95A/9UGDKLdwSkFvMMEJw3GfgbQb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDSrM-00CE8m-Tt; Mon, 27 Oct 2025 20:26:28 +0100
Date: Mon, 27 Oct 2025 20:26:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <3a9240f6-442e-42f3-9c2d-7222c21d5e79@lunn.ch>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
 <f65c1650-22c3-4363-8b7e-00d19bf7af88@gmail.com>
 <aP-hca4pDsDlEGUt@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hca4pDsDlEGUt@shell.armlinux.org.uk>

> Your placement is the only possible location as the code currently
> stands, but I would like to suggest that of_set_phy_eee_broken()
> should _not_ be calling linkmode_zero(modes), and we should be able
> to set phydev->eee_disabled_modes in the .get_features() method.
> 
> Andrew, would you agree?

I dug back through the git history. Originally, the code would read a
value from DT which was literally used as a mask against the value in
MDIO_MMD_AN. If the mask was not zero, it was applied. That later got
converted to a collection of Boolean DT properties, one per link
speed, and the mask was created as a collection of |= statements, with
the initial value being 0, and the result assigned to
phydev->eee_broken_modes. It would of been possible at that stage to
do phydev->eee_broken_modes |=, but it guess a local variable was used
to keep the lines shorter. The u32 then got converted to a linux
bitmap, with the initial = 0; replaced with a linkmode_zero().

I don't see anything in any of the commit messages to indicate there
was a reason to initialise phydev->eee_broken_modes to 0 before
parsing the DT properties.

So i think it should be O.K. to remove the linkmode_zero(). For broken
PHYs like this, the earlier we mask out the broken behaviour the
better.

	Andrew

