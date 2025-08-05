Return-Path: <stable+bounces-166528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A924CB1AE83
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 08:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D018A028F
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 06:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7C21C9E3;
	Tue,  5 Aug 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOWSRomr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B91C861A;
	Tue,  5 Aug 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376263; cv=none; b=CazskSdrhWEG7DKGgAa26ZpIE5adc/gRC7YGS91OcFIDdHnE7xDh3znmen6NPzOWUE1hccafExY2S9CTOPIcXTMsjFPiinHN2SduV3WSr+k5FIIry6nnA6nUpVL/t82EZyMSOrh4Q1u6nqp//od7ALtpB2P5NB+N+J6x4o/2YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376263; c=relaxed/simple;
	bh=zmCWDbWtpbzzMgGs32xyb++YFUupJejY/iPWbySknCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khyYlcw7GSCCt30omREgnQYy+Iw4CmcvXuqwvd9L72HzN+RCSe7abMJ6mjQAwpXl1wcwXuTamsgVcuavta0eW7Memkrx1y+ZL7k9W3wUW30AEeJkNaWzDku8JWLacX3QPaPGe97Wo6DFm7cfecmpf/8I8Gply2i1EqZvHkxI/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOWSRomr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C91FC4CEF4;
	Tue,  5 Aug 2025 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376263;
	bh=zmCWDbWtpbzzMgGs32xyb++YFUupJejY/iPWbySknCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOWSRomr0pF+kNq2Wqx0WlNWOK9zgM8cUY4Q8tKNvhWGi7wzFQdn2ouq4/W9+uH85
	 mzCdCgNqfZslO1QHOiHipKSZvLTfL8KESWciykzs3LDpWEmdYWFp+YItmvxl7WUBr4
	 LZU4bjSpoT3Dse6+qPk9lzuxQ1i79ZeHBY3qtTkUlaMiw42Pss9n+Wok3g4oJwxsQb
	 vttuoPPbgCp6JTHu69W+t2Mjl6Dl+xWNJIvyr/I7GOjMRd9TmlwPDeQ98JQIn44OQW
	 TqrUjW/ZeBMqSYB9xaslr0IJaWLP3EGmNFSFN4BJ0OjrszA4lrqI1jOBi/1ARtSeNW
	 172AqkZbP6dYQ==
Date: Tue, 5 Aug 2025 08:44:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, thomas.petazzoni@bootlin.com, Jyri Sarha <jsarha@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am62-main: Add tidss clk-ctrl
 property
Message-ID: <20250805-imperial-bobcat-of-improvement-5cf705@kuoka>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-3-1bdfb3fe7922@bootlin.com>
 <20250731001725.GA1938112-robh@kernel.org>
 <8a2b1876-d1d4-4523-ae6a-bd14875772cf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a2b1876-d1d4-4523-ae6a-bd14875772cf@bootlin.com>

On Thu, Jul 31, 2025 at 11:50:16AM +0200, Louis Chauvet wrote:
>=20
>=20
> Le 31/07/2025 =C3=A0 02:17, Rob Herring a =C3=A9crit=C2=A0:
> > On Wed, Jul 30, 2025 at 07:02:46PM +0200, Louis Chauvet wrote:
> > > For am62 processors, we need to use the newly created clk-ctrl proper=
ty to
> > > properly handle data edge sampling configuration. Add them in the main
> > > device tree.
> > >=20
> > > Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform =
Display SubSystem")
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > >=20
> > > Cc: stable@vger.kernel.org
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/bo=
ot/dts/ti/k3-am62-main.dtsi
> > > index 9e0b6eee9ac77d66869915b2d7bec3e2275c03ea..d3131e6da8e70fde035d3=
c44716f939e8167795a 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > > @@ -76,6 +76,11 @@ audio_refclk1: clock-controller@82e4 {
> > >   			assigned-clock-parents =3D <&k3_clks 157 18>;
> > >   			#clock-cells =3D <0>;
> > >   		};
> > > +
> > > +		dss_clk_ctrl: dss_clk_ctrl@8300 {
> > > +			compatible =3D "ti,am625-dss-clk-ctrl", "syscon";
> > > +			reg =3D <0x8300 0x4>;
> >=20
> > H/w blocks are rarely only 4 bytes of registers... Does this belong to
> > some larger block. The problem with bindings defining single registers
> > like this is they don't get defined until needed and you have a constant
> > stream of DT updates.
>=20
> In this case, I don't think there is a "larger block". This register exis=
ts
> only because TI had issues in the display controller [1].
>=20
> Here is the extract of MMR registers ([2], page 4311):
>=20
> [...]
> A2E4h AUDIO_REFCLK1_CTRL_PROXY <unrelated>

Here is clk ctrl proxy...

> A300h DPI0_CLK_CTRL_PROXY <this register, 32 bits>

and here as well, so pretty related. This looks also close to regular
syscon and we do not define individual syscon registers as device nodes.

Best regards,
Krzysztof


