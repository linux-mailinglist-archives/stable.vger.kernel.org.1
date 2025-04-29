Return-Path: <stable+bounces-138941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65CAA1B13
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8599A776A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88F250C15;
	Tue, 29 Apr 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR10Z9Xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5378F54;
	Tue, 29 Apr 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953333; cv=none; b=dQHwkMqqKF8TcpacYQ2dKX/cWn6a2Pz27o2jRn79rEruEotbbNNlSzHZnmTisjqmuf7783+tAikb9uSXC79GCRw6ReHd6Z0Y4EiX84ooyR4tMZT8uWCOdQFcqwea7KbXEZWU7RmVPiwAz957WCmvg2Bnmtsyz7ulUaOxoJAHV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953333; c=relaxed/simple;
	bh=2nAjN+lDJpPG/3AFkNBwRGaeoQ2au71DtIzMd+k6ns8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTpKFw375gQRK9vZRRCvJnOduGVwOelYqIywTE6u2wrfgQD2OxDGyxtzqd+vwqoG6hag6Mq6KcQHLC7M4qYURDN4iwosceyIbEOt7joAfdWpAiBbOG/JR+NJx5GoCKIy17mNXVQdt7SS+M0zDgJ5IHJyo5kDw4OL0ySsL8UU7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR10Z9Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D66C4CEE3;
	Tue, 29 Apr 2025 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953332;
	bh=2nAjN+lDJpPG/3AFkNBwRGaeoQ2au71DtIzMd+k6ns8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WR10Z9XdtTt53b6JY3mS283JRh2MzxwfiXpdUtmsSCjRRfAn29RhPFZaPbIS/KT8d
	 uror/Fcz/WeEbnT4hlZbC1Qirj3pOHbRNwLMxjFN7BITpKKEeBzhWSnpwvP/T7eOAz
	 3NSGUnanz2EQzMLxpkzKkreVeOGalwgg7SoHtHB4FpFXI7QyfEPTQ88JmOZB0pEzMC
	 J2jD4crcvbTYZdCZOiEFSXq0sFiwfi1UKDVxwm/ijx8Gkw4q2fXQtzrSeez6rJVnHQ
	 RyZYLqQZVN2ZTdq3kFOfppcv+/FBC2KunYVwuueiwZCg78RkGkC/2h8td2hhBOj7pW
	 Y+3HHlLGCPQoA==
Date: Tue, 29 Apr 2025 12:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Da Xue <da@lessconfused.com>
Cc: Simon Horman <horms@kernel.org>, Da Xue <da@libre.computer>, Andrew Lunn
 <andrew@lunn.ch>, Neil Armstrong <neil.armstrong@linaro.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman
 <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Jerome Brunet
 <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Heiner Kallweit
 <hkallweit1@gmail.com>
Subject: Re: [PATCH v3] net: mdio: mux-meson-gxl: set reversed bit when
 using internal phy
Message-ID: <20250429120210.0aa6fa81@kernel.org>
In-Reply-To: <CACdvmAhcBmoDNyuu0npZzyExfhyLKdyPw9HvHvV+OdADxEfJJQ@mail.gmail.com>
References: <20250425192009.1439508-1-da@libre.computer>
	<20250428181242.GG3339421@horms.kernel.org>
	<CACdvmAhcBmoDNyuu0npZzyExfhyLKdyPw9HvHvV+OdADxEfJJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 20:44:14 -0400 Da Xue wrote:
> > On Fri, Apr 25, 2025 at 03:20:09PM -0400, Da Xue wrote:  
> > > This bit is necessary to receive packets from the internal PHY.
> > > Without this bit set, no activity occurs on the interface.
> > >
> > > Normally u-boot sets this bit, but if u-boot is compiled without
> > > net support, the interface will be up but without any activity.
> > >
> > > The vendor SDK sets this bit along with the PHY_ID bits.  
> >
> > I'd like to clarify that:
> > Without this patch the writel the patch is modifying will clear the PHY_ID bit.
> > But despite that the system works if at some point (uboot) set the PHY_ID bit?  
> 
> Correct. If this is set once, it will work until the IP is powered
> down or reset.
> If u-boot does not set it, Linux will not set it and the IP will not work.
> If u-boot does set it, the IP will not work after suspend-resume since
> the IP is reset.
> Thus, we need to set it on the Linux side when bringing up the interface.

Added to the commit message when applying, thank you both!

