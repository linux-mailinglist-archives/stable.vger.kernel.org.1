Return-Path: <stable+bounces-127048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF5CA76725
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47723AB688
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233D212B18;
	Mon, 31 Mar 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1crgzpip"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB83234;
	Mon, 31 Mar 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429229; cv=none; b=XXudRC3ynA7bTjDnUhOwqmQdBIHWVpj4ZfbYOTBECNjuauNtvGyyycDFcc53cLvm3clVf8GrEXBiNDQVxUWsXuaUs6YaWZx5K8Y9apn6ZFt3PreS+ZL/s4qhHGISRRxkT8x/hPth5Bap/93PjVt7OBEMdaDnmFh42npdUkTbxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429229; c=relaxed/simple;
	bh=1bdgB4pjkJgOiAEZ3O0j60c0NykT/heXgoCddgtisSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/XEPkTVqQ7niXWU0KviChRnfwTlpNFaQ0pMI36SB2q8U7vC3GArORoE1deiDySTpgmUyZpjwZP3CkBmKsfX83GnLcRlm3hCR5FJOScRXT2bf+TwtLwGFZ5B66Ux0/k2uDTnQ1YmZp1VWoo3MdKrWjvukSmWMxmTUd60/dJ1Z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1crgzpip; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J+9FHX6rBVj88oLrVg3eeFc6dbE26aHLfHIwgVKUO0Q=; b=1crgzpiphNYZZMz+GjSnJxI47/
	e/wBQT5YUXA7IQOngX6lT3BH2o0OmevomoPSt24xcmo7AMdDP6sMxOlA6msEwtKg5lTNecEG3zBgP
	kppgV+v1toN5MnPPbjcNc8K2ELoK2CkqXTB1HvrzthnCPpRohtI22a6DtieBEq8MfrDhz0macOk9N
	wTq803aLg3b+QshUhTKj9IsTc5NzR9vUROvprRfSmGp6ZE43yY5SIEQYUVpakDRz7lznUpX/5x/Dx
	HXS94PFQ4trFXKc9RzXNSyekPMQqCmn+TmhszUYebpK3nMvTs4dd6gq+EnBfXDllAf/utSY5SkQua
	FGUJoobA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzFa4-00047M-0c;
	Mon, 31 Mar 2025 14:53:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzFa0-0001j6-2N;
	Mon, 31 Mar 2025 14:53:32 +0100
Date: Mon, 31 Mar 2025 14:53:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Da Xue <da@libre.computer>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
Message-ID: <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 31, 2025 at 03:43:26PM +0200, Andrew Lunn wrote:
> On Mon, Mar 31, 2025 at 07:44:20AM +0000, Christian Hewitt wrote:
> > From: Da Xue <da@libre.computer>
> > 
> > This bit is necessary to enable packets on the interface. Without this
> > bit set, ethernet behaves as if it is working, but no activity occurs.
> > 
> > The vendor SDK sets this bit along with the PHY_ID bits. U-boot also
> > sets this bit, but if u-boot is not compiled with networking support
> > the interface will not work.
> > 
> > Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
> > Signed-off-by: Da Xue <da@libre.computer>
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> > Resending on behalf of Da Xue who has email sending issues.
> > Changes since v1 [0]:
> > - Remove blank line between Fixes and SoB tags
> > - Submit without mail server mangling the patch
> > - Minor tweaks to subject line and commit message
> > - CC to stable@vger.kernel.org
> > 
> > [0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com/
> > 
> >  drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > index 00c66240136b..fc5883387718 100644
> > --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> > +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > @@ -17,6 +17,7 @@
> >  #define  REG2_LEDACT		GENMASK(23, 22)
> >  #define  REG2_LEDLINK		GENMASK(25, 24)
> >  #define  REG2_DIV4SEL		BIT(27)
> > +#define  REG2_RESERVED_28	BIT(28)
> 
> It must have some meaning, it cannot be reserved. So lets try to find
> a better name.

Indeed, that was my thoughts as well, but Andrew got his reply in
before I got around to replying!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

