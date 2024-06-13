Return-Path: <stable+bounces-52099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17831907CA6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADF81F23AE9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CEB149DFA;
	Thu, 13 Jun 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2WNkZWTO"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A512D203;
	Thu, 13 Jun 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307193; cv=none; b=qovTL2u/UqjrpXLNpf1fwirymNWh9JEg7gLq8aq+J14va+fvO99BXKUkKT0iSlNWDN9flCalKJVAvwLv2JzZwc73t+MyjlqZZDEDPROvFVLIblG01BBT3mkR+loZ8EueTY9hf3QSeHAY0Eyno+veOpN0T8V0THra31cAIFt1Z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307193; c=relaxed/simple;
	bh=5sD1IK/8V8bWGT1IDN8YyNkWTWo86CTAtfNysGwYtMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htRDNu90PcLSLlLt5fP9nY0jbq+0Ik9Emq/xbfC3JOVH4rlgw9CGlrlyo47lXqWeFIC8cKmXU1ANP+AvnUTM41X3tBj1Ai7AjPsH0zPNI2ejtTpLf+nlamldAH+CJnY8xS34Z0fMGFSYIgzgbSi59ReY8fVZd0ppX3sALp76GwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2WNkZWTO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bX9yCP+ayyPjjEYI3UrDUQu6a798S/7dzFInHc8v3yQ=; b=2WNkZWTO+1TR8M5CZwDs3LIfpy
	5lrJlm/B++8FhrKOzInyPI4hBgsxTRsd7VCeAf3sIGdbw6ufMIjv9mkVp/dsrZ6vDt3W6vbc+I87g
	dmPAjIy4CCYaJk41uX3M4Uii5cnUQgswbxLf9dsTDXadxZYjsctJ6mrtJ9cxMbzRtLhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHqBx-00005Z-0Z; Thu, 13 Jun 2024 21:33:01 +0200
Date: Thu, 13 Jun 2024 21:33:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 2/2] net: phy: dp83tg720: get initial master/slave
 configuration
Message-ID: <f88abfe3-a66c-4e65-b627-7adf7f04580f@lunn.ch>
References: <20240613183034.2407798-1-o.rempel@pengutronix.de>
 <20240613183034.2407798-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613183034.2407798-2-o.rempel@pengutronix.de>

On Thu, Jun 13, 2024 at 08:30:34PM +0200, Oleksij Rempel wrote:
> Get initial master/slave configuration, otherwise ethtool
> wont be able to provide this information until link is
> established. This makes troubleshooting harder, since wrong
> role configuration would prevent the link start.

I looked at how genphy_c45_read_status() works. If we have
phydev->autoneg == AUTONEG_ENABLE then genphy_c45_baset1_read_status()
is called which sets phydev->master_slave_get. If not AUTONEG_ENABLE
it calls genphy_c45_read_pma() which ends up calling
genphy_c45_pma_baset1_read_master_slave().

So it seems like the .read_status op should be setting master/slave
each time it is called, and not one time during .config_init.

What do you think?

    Andrew

