Return-Path: <stable+bounces-95925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C89DFAF3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518B7B21D39
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D91F8F10;
	Mon,  2 Dec 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4roW96C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771D4C85
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123470; cv=none; b=OFVfSolKyqqa/z/PABbEGnOZAPdxjRjnWi/Hmp79bihlu8Mpq9lKz7X+H+STZgMngzQlM0mR0A5dXK7+Nozkh6mwySiXgAawvxGMtCDnrPCGXF5dXVZ76nmH1c1STfa1iGKazlZOqohkCK9AJ32AGHeP32d5taQQkEy2UEaXSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123470; c=relaxed/simple;
	bh=P7e6pmJd2LwCcMtIh+xs1sVFv/Ibe//zWGF6APvwuig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLasHP3HlKRhbu3NLhDIza8J1c5LfNrSq1v4crGCJDjCGHkblL+0LlaWknvTThJtNTI4qzqCPPas2kgmp9HGaHf9P1q9+H7hEC1n/YbtlNmHCHD/QdZm0ommKuH9q58bqXhwP0uWukwW1ivwDI1sj4Isvpv+IX2CwmQMHwmvsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4roW96C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CECC4CED2;
	Mon,  2 Dec 2024 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733123470;
	bh=P7e6pmJd2LwCcMtIh+xs1sVFv/Ibe//zWGF6APvwuig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v4roW96CrrT51AZfUKmOvDck+FwW5LSBnC763556GV9m/0rouD0zFG89B/+462C79
	 Bch0mTlRU9724NdNKy4IWLew0RjVEwy98sy3BbJD33skjmFisdJYn7pnA16TdqPHLl
	 Kpq5H4Q5FgeBcqBsq80B2gHnEP8UPTUdD/mVGEp4=
Date: Mon, 2 Dec 2024 08:11:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, stable@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH 6.6 433/538] arm64: dts: mediatek: mt8195-cherry: Mark
 USB 3.0 on xhci1 as disabled
Message-ID: <2024120254-pry-shut-6670@gregkh>
References: <20241002125751.964700919@linuxfoundation.org>
 <20241002125809.530901902@linuxfoundation.org>
 <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
 <CAGXv+5G4uBmrxNKi_ftRdWu55v2+kt13en5u6M6fDiHZCgJOJg@mail.gmail.com>
 <2024120210-discolor-saloon-a47a@gregkh>
 <CAGXv+5G4GMv-_pt+SzwF8H+pP3VZne4=Nc18mzmxZzY5wJ8q7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5G4GMv-_pt+SzwF8H+pP3VZne4=Nc18mzmxZzY5wJ8q7g@mail.gmail.com>

On Mon, Dec 02, 2024 at 02:53:49PM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 2, 2024 at 2:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 02, 2024 at 11:36:33AM +0800, Chen-Yu Tsai wrote:
> > > On Sun, Dec 1, 2024 at 8:15 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > >
> > > > On Wed, Oct 02, 2024 at 03:01:12PM +0200, Greg Kroah-Hartman wrote:
> > > > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Chen-Yu Tsai <wenst@chromium.org>
> > > > >
> > > > > commit 09d385679487c58f0859c1ad4f404ba3df2f8830 upstream.
> > > > >
> > > > > USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
> > > > > pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
> > > > > design.
> > > > >
> > > > > Mark USB 3.0 as disabled on this controller using the
> > > > > "mediatek,u3p-dis-msk" property.
> > > > >
> > > > > Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> > > > > Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
> > > > > Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
> > > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |    1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > > > @@ -1312,6 +1312,7 @@
> > > > >       usb2-lpm-disable;
> > > > >       vusb33-supply = <&mt6359_vusb_ldo_reg>;
> > > > >       vbus-supply = <&usb_vbus>;
> > > > > +     mediatek,u3p-dis-msk = <1>;
> > > > >  };
> > > > >
> > > > >  #include <arm/cros-ec-keyboard.dtsi>
> > > > >
> > > > >
> > > >
> > > > It looks like this change is applied to xhci3 instead of xhci1. The same
> > > > appears in the backport for linux-6.1.y. Could you take a look?
> > >
> > > Agree that it's applied to the wrong node. It won't cause any issues
> > > since xhci3 is USB 2.0 only, but we should we fix it regardless.
> >
> > Great, can someone please send a patch so that we get this correct?
> 
> Would you like a revert plus a correct backport, or just a fixup?

Which ever is easier for you is fine.

thanks,

greg k-h

