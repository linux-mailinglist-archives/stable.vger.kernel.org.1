Return-Path: <stable+bounces-95922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A49DFAAC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F16F28182B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0031F8AC7;
	Mon,  2 Dec 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gd7un+aa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F1481A3
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120847; cv=none; b=eE4DgOfCkTYknhWZ70DeZqOF9OblvUo5hq1GBiPfFFyqITlOtrFK6dnVbmi0wl4sXvqILVWmkbMo58AZS/PKacJ/kVarIqdg7hLLPCczuRTCw0BaiQZybw37ek9r/oLE3qHrenZyTiLW3R0t5VlpotUfc8gbvE27ge1ZqMs7Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120847; c=relaxed/simple;
	bh=wgi0qLfDA4hVYHpKS1ejkxkYc317sNvCklmf6ifQEX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2kUsJdNvrNY2lnu2+qh9A+43URWMUn+WKMX9DlH1dFurnGZXLwwGV4pRoPz/4ZCsCh2PxA3FT6108ut4pCnzoXMeNj/7acHRZk9YvuNJeezv5yGFRlleU0lO1zoaXWtcBvBrS/pCdaALZ/hlGomxQnOy/cDxs4d6oEv3inzQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gd7un+aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79104C4CED2;
	Mon,  2 Dec 2024 06:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733120847;
	bh=wgi0qLfDA4hVYHpKS1ejkxkYc317sNvCklmf6ifQEX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gd7un+aan6y9XJO8ALnXKSej7AYxmmlXJ1/uRvsCuXFcuKOF6CmMT+q3dZjLoZATn
	 KKbhkTiaued6vTFvGM1YDeAAFiic2/yH11GreMGL1mqpLujTt0JmONuXUYGAUj4E/A
	 Zh3D+KCkx7NUCz3IoGlF7H8+cqoQygOgK4C1oLD8=
Date: Mon, 2 Dec 2024 07:27:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Koichiro Den <koichiro.den@canonical.com>, stable@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH 6.6 433/538] arm64: dts: mediatek: mt8195-cherry: Mark
 USB 3.0 on xhci1 as disabled
Message-ID: <2024120210-discolor-saloon-a47a@gregkh>
References: <20241002125751.964700919@linuxfoundation.org>
 <20241002125809.530901902@linuxfoundation.org>
 <6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw>
 <CAGXv+5G4uBmrxNKi_ftRdWu55v2+kt13en5u6M6fDiHZCgJOJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5G4uBmrxNKi_ftRdWu55v2+kt13en5u6M6fDiHZCgJOJg@mail.gmail.com>

On Mon, Dec 02, 2024 at 11:36:33AM +0800, Chen-Yu Tsai wrote:
> On Sun, Dec 1, 2024 at 8:15 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Wed, Oct 02, 2024 at 03:01:12PM +0200, Greg Kroah-Hartman wrote:
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Chen-Yu Tsai <wenst@chromium.org>
> > >
> > > commit 09d385679487c58f0859c1ad4f404ba3df2f8830 upstream.
> > >
> > > USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
> > > pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
> > > design.
> > >
> > > Mark USB 3.0 as disabled on this controller using the
> > > "mediatek,u3p-dis-msk" property.
> > >
> > > Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> > > Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
> > > Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> > > @@ -1312,6 +1312,7 @@
> > >       usb2-lpm-disable;
> > >       vusb33-supply = <&mt6359_vusb_ldo_reg>;
> > >       vbus-supply = <&usb_vbus>;
> > > +     mediatek,u3p-dis-msk = <1>;
> > >  };
> > >
> > >  #include <arm/cros-ec-keyboard.dtsi>
> > >
> > >
> >
> > It looks like this change is applied to xhci3 instead of xhci1. The same
> > appears in the backport for linux-6.1.y. Could you take a look?
> 
> Agree that it's applied to the wrong node. It won't cause any issues
> since xhci3 is USB 2.0 only, but we should we fix it regardless.

Great, can someone please send a patch so that we get this correct?

thanks,

greg k-h

