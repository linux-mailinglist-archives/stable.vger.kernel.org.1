Return-Path: <stable+bounces-80749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3F99058D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1A7285DFE
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881B216A2B;
	Fri,  4 Oct 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DUZ4AC6b"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E4216A12;
	Fri,  4 Oct 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051093; cv=none; b=IgWc/esvlYDpPUpRvBlxiq0z4zUfPbTRuWL1l3romzy1boUSlJ4XB/FZQDbEPqqMXCJ3DC4P/VyW86JUcDmqXldZwTYdbIPArgXY1v5Ql9uG530+GYf+SFp60KUdpYFhQnG06nCYCgUGzCniYA+MEZbbgeiH0KaPQgBoIVc6y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051093; c=relaxed/simple;
	bh=ArixIeJNDLPVCxRDxf27xxYe+gw/fjNd0rIJJG7+YT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhpLRWoxuqFgEPw8r0i5XqeVIU4H/bViovYfKuk8rosNvNt/Jpi3+fyqEZNajgxLaw7XtQzWy1Cexl7jHSd7bamYWwvB5mwvcnv1QVVaopTZ/h8qoeNMCSvOagHhq+WaF4j0vK1dlllFsFdXatmInUNA8xZwiV9PATyWqCjXiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DUZ4AC6b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wtDLpt+mqO8smZV50WHaGdAClLGroyh7/DD4NF2nJN8=; b=DUZ4AC6biOzFlHzoRllc4EIRyF
	0buHdCErToxxXOnMK5/aNk5ShMWbwmVlL0xLDEbqPuTZYcOpqcTcRFLE7bBTSV8nMjhN8aBlrgzAu
	Mo/BUL4NoAlVOh9ZCNOKD6cFM14/V3usJ72DRFN1LrklUaCWUdmT3EX6IG8uiJD59XT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swj1e-0093OX-1D; Fri, 04 Oct 2024 16:11:22 +0200
Date: Fri, 4 Oct 2024 16:11:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	stable@vger.kernel.org
Subject: Re: [net PATCH 2/2] net: phy: Skip PHY LEDs OF registration for
 Generic PHY driver
Message-ID: <ce1feaa5-b9e0-4245-8e64-6e90bcf528eb@lunn.ch>
References: <20241003221006.4568-1-ansuelsmth@gmail.com>
 <20241003221006.4568-2-ansuelsmth@gmail.com>
 <2dcd127d-ab41-4bf7-aea4-91f175443e62@lunn.ch>
 <66ffb1c2.df0a0220.1b4c87.ce13@mx.google.com>
 <a463ca8c-ebd7-4fd4-98a9-bc869a92548c@lunn.ch>
 <66fff1c0.050a0220.f97fa.fec2@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fff1c0.050a0220.f97fa.fec2@mx.google.com>

> Ok I will squash this and the net-next patch and change to dbg.
> 
> Do you think it's still "net" content? I'm more tempted to post in
> net-next since I have to drop the Generic PHY condition.

Does it cause real problems for users? That is the requirement for
stable.

	Andrew

