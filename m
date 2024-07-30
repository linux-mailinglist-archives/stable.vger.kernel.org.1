Return-Path: <stable+bounces-64667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DCC94214C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BA4B25B08
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F918CC0F;
	Tue, 30 Jul 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kKMU14dC"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DED3FE4;
	Tue, 30 Jul 2024 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369984; cv=none; b=GLFBT6G2daageKHCvBBN71qIOGWTZ1DAH/D5whonSlzNpp0hwFw7coeegASE0rZM4qLVpIHI4gZGzlLagRWOyi5iBHpBie4D2E/DSfUk5Ph5CdDBZeB3hchIRktFfwGtxjKj6zj74ti+4qPNAWkgL6f0BaqNF7ZwESnMZ8QYP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369984; c=relaxed/simple;
	bh=ldzGPhI3navSK6h0k9eTGLX4BZt43+62x4bVEOjbJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8CyH9Jj+7BTBx7FVBbwbs/FEP0N6XZ/Rg7I1iseWJgmYko5so7Uegvhd0MO0jdMaPLL7Sqd6rHlV6NDVdPcNKFg0Cmiv5oft5msbrZKmHSN0BL1GWEjGvh5mK6izJ8hgwmjbBZSSLT7NAMMNxpR7IHPXcdNY7OFqthMfUXhtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kKMU14dC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dc0PNP7nHVAM0Jmi9Ijq/BTgRvE2kRiW17YeF4eGCyY=; b=kKMU14dC7Zi5NmhZ5pKM8PGxdT
	vgQU3zzc5fYAkhCbe4WY7Xaj+5Nxc1df2F6ZLZ0J6hN3mmhhx1NE8Lq6OaLMu3sWYXLqRO5pTcW+Y
	5uFJJgU9QntqUK+snCANgFy6UbF29hLKRC1jCZIM7bTC2T+F/fcTZeefxNWEPUAyd6ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYt6m-003bqE-Ks; Tue, 30 Jul 2024 22:06:08 +0200
Date: Tue, 30 Jul 2024 22:06:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	pabeni@redhat.com, horatiu.vultur@microchip.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status
 issue
Message-ID: <42039b61-2b22-4497-85b4-3978b9d03058@lunn.ch>
References: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>

On Thu, Jul 25, 2024 at 12:41:25PM +0530, Raju Lakkaraju wrote:
> The MDIX status is not accurately reflecting the current state after the link
> partner has manually altered its MDIX configuration while operating in forced
> mode.
> 
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register
> 
> Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

