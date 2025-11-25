Return-Path: <stable+bounces-196869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80896C83B8C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2053A38E3
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BA2E5437;
	Tue, 25 Nov 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="plcXhOYf"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C882D4816;
	Tue, 25 Nov 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055731; cv=none; b=o/MZzc53R3zcZ2FfUedzs/RFZNUXBnpwHYHVC7e70Hl/IOZZe8kv2/0puL8UOQKdrDY2n6YLGSB/rNT3RlBlskwA5XTQv5a2kcAxN88qpHplC6WBHKivl6Jy6PEINnk4UlXVoy81ucMbPR4ckx5LtX/BHnyNgiyQLneYJz0Jc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055731; c=relaxed/simple;
	bh=E+nTZ64PFFkJHSRwdNzcffSPOkz7JAhGb0mGB8PFKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnhJlBlxm5TOd0n+tYOHK40F8RgSy/jfQYMxXqwMYqy3ag/sF2UKGpcQAoKOVLwHC+LlBaECUVfJm6XH9mzPaHjrbefZs2mojozDzlziO6ChlQMK29fO50CZTyuA4BU2jX/b9JO7M/7sZ8lPsRVPZQuI4IQz4vANxBVCfvn7jIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=plcXhOYf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 567FE22239;
	Tue, 25 Nov 2025 08:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1764055217;
	bh=eP2e4OiQhKFjF8jIAfWUJ81hm27Yf/v4hmfnRrA+7u4=; h=From:To:Subject;
	b=plcXhOYfkNszbCYxnXmFqaWOpn7jc3Rlx9S9egzSDXifLp+Bb333iJsRbBBPPv8yq
	 CbBakUPdb9dSRtKzwZXj6MixsWT03hX/W2bXAjjarsZy+JHCuPZMhMHqK3Zlc+ENtQ
	 DgYKxtsD7KiRMEuyO3FXQUjuO9wANtxjUkr0tHkB9311I7rVG3bxid1ZqWKf1JzZkC
	 0CQtFnm6NbfCzmELIFAAxm4Ty59VCC/n8Q52D7eY23zsiRU7mpd/GcRebcivax0usU
	 Mls6U4hAsqKVkrUKo2p2S8wRJK4pwYISYDSPSJG4OSA8QGj87euyQRFKQSL427X2Vb
	 BIafJR4XqnsLw==
Date: Tue, 25 Nov 2025 08:20:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] phy: fsl-imx8mq-usb: fix typec orientation switch
 when built as module
Message-ID: <20251125072011.GA5375@francesco-nb>
References: <20251124095006.588735-1-fra.schnyder@gmail.com>
 <w2dpsbfspr4od2j5seidi3tcpo3r2revhahhxiuacqehkqy3nn@2zjb3xvso45d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w2dpsbfspr4od2j5seidi3tcpo3r2revhahhxiuacqehkqy3nn@2zjb3xvso45d>

On Tue, Nov 25, 2025 at 03:04:43PM +0800, Xu Yang wrote:
> On Mon, Nov 24, 2025 at 10:50:04AM +0100, Franz Schnyder wrote:
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> > 
> > Currently, the PHY only registers the typec orientation switch when it
> > is built in. If the typec driver is built as a module, the switch
> > registration is skipped due to the preprocessor condition, causing
> > orientation detection to fail.
> > 
> > This patch replaces the preprocessor condition so that the orientation
> > switch is correctly registered for both built-in and module builds.
> > 
> > Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > ---
> >  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > index b94f242420fc..d498a6b7234b 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> > @@ -124,7 +124,7 @@ struct imx8mq_usb_phy {
> >  static void tca_blk_orientation_set(struct tca_blk *tca,
> >  				enum typec_orientation orientation);
> >  
> > -#ifdef CONFIG_TYPEC
> > +#if IS_ENABLED(CONFIG_TYPEC)
> 
> With below commit:
> 
> 45fe729be9a6 usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n
> 
> I think this #if/else/endif condition can be removed.

This patch should go to stable, and that commit is not present in any
such previous kernel.

Should we have 2 patches or "force" 45fe729be9a6 to be also backported?

What's the general advise in these situations?

Francesco


