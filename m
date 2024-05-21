Return-Path: <stable+bounces-45531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B528CB40D
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 21:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725231C239CD
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C614901E;
	Tue, 21 May 2024 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JugbqVue"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57252142916;
	Tue, 21 May 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318498; cv=none; b=gO7mqCqCP0ox5BDuCDD/MDy5u3T1jFQmBB9+R/3GYjEV/IHEd8QKrNT/BwDt7i60cl7Lrb0g8JfP9OHSsmMm2lYf5Cryu6olP/XLENBvfRgPOGOydgAgMgIW9UvMg6ZxLlYne4+giqnMvExLIT97iBP+exhXV+UqhTtb1YfG2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318498; c=relaxed/simple;
	bh=U4wbU+4FKbRdiy0GkDK+FyHdxCCPRXfs7pfAF6gNJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxa0j/wONqrkbiYtGPhMDVM4aKQZ4gdI/EJsKfILEMDkKywMLJI4TaY8lDde2teyjIV6Ym8LEy5HUL3YuGF0ZtlzH14mbccEE0IXGIMxYrVgIbdn4K3ZIA11gKmUz/enXh9AkYGOlRbI4LAmIvjgdu2g9tSPCrAypUzYSbbReX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JugbqVue; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Aa0cLQv6EXqOfkPotmVcZhdZiy3itIGTrTeuDAF0fks=; b=JugbqVueUMPEOzD6J0OMO/9EUb
	HVQwA9KIYPYMQBLTwCMP3MfSLThC4zef/dXWPErhjdUyKOEoNvSM0TDt6f0GEJ3OPJV2j4vp9DjJ7
	DJOGnhcRqdyekj0IducRHiff0mImOKiA/wvJGV6qXI7kdd6uo86LRDtuWuRWdQ8YxBK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9Uq1-00FmSO-8x; Tue, 21 May 2024 21:07:53 +0200
Date: Tue, 21 May 2024 21:07:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Da Xue <da@libre.computer>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
Message-ID: <8593ae57-d5ec-4b89-899d-4619d7767f81@lunn.ch>
References: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>

On Tue, May 21, 2024 at 02:56:45PM -0400, Da Xue wrote:
> This bit is necessary to enable packets on the interface. Without this
> bit set, ethernet behaves as if it is working but no activity occurs.
> 
> The vendor SDK sets this bit along with the PHY_ID bits. u-boot will set
> this bit as well but if u-boot is not compiled with networking, the
> interface will not work.
> 
> Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
> 
> Signed-off-by: Da Xue <da@libre.computer>

Please don't put blank lines between tags.

If you intend that this patch is backported to stable, please add

Cc: stable@vger.kernel.org

Also please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

particularly the bit about indicating the tree in the Subject:

    Andrew

---
pw-bot: cr

