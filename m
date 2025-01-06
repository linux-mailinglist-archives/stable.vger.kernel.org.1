Return-Path: <stable+bounces-106854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BBDA02867
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FB1161577
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DBE86328;
	Mon,  6 Jan 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIMl9Iht"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69611DED59
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174740; cv=none; b=PPMDyjbWtwNWLpUGO2aAPcvN9AdyT3wEDIlwpo1XrvLmxptYO229oz+J73KMONXJ+Upx/ApM9p3Rumg3glyVEiB7RkfsWIYHVE067yd+8Xh7UTDKn/anVG156tB3Io7mCpnGZ8bM+RfQZ2KjeA+AoMMRm+MBkVmQodUmgGulXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174740; c=relaxed/simple;
	bh=VKg+j5w7wrkL7MH5JEo2mPVnNHRy9ewZkjBYWhlqiCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyA4B792qBsBbyiBdrSYAbo/tgQMJGJp4RkP94POqnKSF7OcYmeeY3ojVMQjPD9SJowXh959eku0CDoJABtCSasf3DguIUbZ95PM9VFOA7VVSj1s6oROUcrenuyu/hi91OnA2zZah3bW16dnmB9H5dJfYuxhPyXSF4w4erE2sq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIMl9Iht; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736174736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OKi4mQUPHQzwet86Fodk/kjXwZzb1xN6oJud0vG8Zw=;
	b=aIMl9Iht/nm4mZnmT2Dcbse54MbQe2CqfrlSdFt3bh871Oplis4U0aEFe7Q3ey+jlbPJBX
	QPA4m7N8vh56sRX1zklf9NOQt/CROavqesIodcytDGIpWrGAOHPiMThJLyfiegSXBcDuxE
	SxRrAQNHS7jZx4RqjYJxk1MjeB9yc48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-88yJv6kENPqnzapV04h4-A-1; Mon, 06 Jan 2025 09:45:34 -0500
X-MC-Unique: 88yJv6kENPqnzapV04h4-A-1
X-Mimecast-MFC-AGG-ID: 88yJv6kENPqnzapV04h4-A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385f0829430so8959624f8f.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 06:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174733; x=1736779533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OKi4mQUPHQzwet86Fodk/kjXwZzb1xN6oJud0vG8Zw=;
        b=BR4TKLS/LNejyE3LFQC2NMjDAoL90m58igw8uGRufhCQOx+80YBoAKORJu++toGoTb
         h/udq11dYvTAABu/24pd/XmCgInryiUe8qu/oOrdX+kPdl1XctpWrGOl2DLNO0f0NoW5
         OlXT0ibjhd5XlBzD99j8pzHKeVutnohk9YvStvjQY1js8+u4uINJjSbbEzIemPkP6rB4
         FyTL9dfJ79Kzh0HlGg82RyQuXcFU1+j7lmXs3XSOlHTBYdJndh4jIZ70iOq12i2QLdYE
         EHRG799grcp4Fjtmew6YbPpNGGMP2tltro61u329krEzUdsUI1LikyZMJqgwMXM3qMHB
         MnUg==
X-Forwarded-Encrypted: i=1; AJvYcCVpGuIATGF7xShzLdSOuxMnNv4UeG2639cdMvCy7+5FYk8R+gkEdTZeyt3hZA8xtWg7rkXJV84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5Nz5cGFwsTc7DB6we0SnssteM6U5c7WGD9HEvJnGeUh7TEsr
	k3gcJ0sjcpCTcDrHSusZC7L10YsSBFSzed4X4V1dUFg2+bsotDP/BuR0sCJLyfkzgT3GUe0HI1u
	Irv+X7wmFKJSzdoHGOv/cwT+F3CTMc1kjEwgMserz/9C0uD8fm2158A==
X-Gm-Gg: ASbGncuu1Q5spBhkpq/MSgPgfcHpH0P6ZyovOMYRx9uhRdGWIo2ne4DZMbdQ09gDdj9
	yl447ljQYh9fKovLo4phKxJDKhVo1VBhmaVdIi+lg2ClH7WhZvEO0cgWB7UQ/Is19lwJWFrfWW3
	/WDW5bce7r5trQ2QUt/imIChVgAfVqXWAmBkbYxdT//G8PmcKExyLTtq3Muh97IJ2KGLL4F6PWe
	arHVGnkKAe+RYAOak3x1l6/nzf4j+RV
X-Received: by 2002:a5d:6d84:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-38a221e2799mr60265809f8f.10.1736174732705;
        Mon, 06 Jan 2025 06:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4T4QlC5/jRrR6iDjWhKyBAT5NxE9LiMCGpKSmGfpcDUEiXBkKD2KSgBJpvYDW3z5/4WnSqg==
X-Received: by 2002:a5d:6d84:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-38a221e2799mr60265764f8f.10.1736174732103;
        Mon, 06 Jan 2025 06:45:32 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47373903f8f.30.2025.01.06.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:45:31 -0800 (PST)
Date: Mon, 6 Jan 2025 15:45:31 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Liu Ying <victor.liu@nxp.com>, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Abel Vesa <abel.vesa@linaro.org>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Ian Ray <ian.ray@ge.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] clk: Fix simple video pipelines on i.MX8
Message-ID: <20250106-poetic-conscious-worm-387b2c@houat>
References: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
 <b98fdf46-3d09-4693-86fe-954fc723e3a6@nxp.com>
 <87zflrpp8w.fsf@bootlin.com>
 <20241217-didactic-hedgehog-from-heaven-004c37@houat>
 <87ttaurzt5.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="75haewkz6w363ceg"
Content-Disposition: inline
In-Reply-To: <87ttaurzt5.fsf@bootlin.com>


--75haewkz6w363ceg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] clk: Fix simple video pipelines on i.MX8
MIME-Version: 1.0

On Mon, Dec 23, 2024 at 07:59:02PM +0100, Miquel Raynal wrote:
> Hello,
>=20
> >> >> [After applying PATCH "clk: imx: clk-imx8mp: Allow LDB serializer c=
lock reconfigure parent rate"]
> >> >>=20
> >> >> This is a commit from Marek, which is, I believe going in the right
> >> >> direction, so I am including it. Just with this change, the situati=
on is
> >> >> slightly different, but the result is the same:
> >> >> - media_disp[12]_pix is set to freq A by using a divisor of 1 and
> >> >>   setting video_pll1 to freq A.
> >> >> - media_ldb is set to 7*A by using a divisor of 1 and setting video=
_pll1
> >> >>   to freq 7*A.
> >> >>   /!\ This as the side effect of changing media_disp[12]_pix from f=
req A
> >> >>   to freq 7*A.
> >> >
> >> > Although I'm not of a fan of setting CLK_SET_RATE_PARENT flag to the
> >> > LDB clock and pixel clocks,
> >>=20
> >> I haven't commented much on this. For me, inaccurate pixel clocks most=
ly
> >> work fine (if not too inaccurate), but it is true that having very
> >> powerful PLL like the PLL1443, it is a pity not to use them at their
> >> highest capabilities. However, I consider "not breaking users" more
> >> important than having "perfect clock rates".
> >
> > Whether an inaccurate clock "works" depends on the context. A .5%
> > deviation will be out of spec for HDMI for example. An inaccurate VBLANK
> > frequency might also break some use cases.
> >
> > So that your display still works is not enough to prove it works.
>=20
> Well, my display used to work. And now it no longer does.

I'm not disputing that.

> The perfect has become the enemy of the good.

What I'm disputing however is that your display might never have been
good or perfect in the first place.

> >> This series has one unique goal: accepting more accurate frequencies
> >> *and* not breaking users in the most simplest cases.
> >>=20
> >> > would it work if the pixel clock rate is
> >> > set after the LDB clock rate is set in fsl_ldb_atomic_enable()?
> >>=20
> >> The situation would be:
> >> - media_ldb is set to 7*A by using a divisor of 1 and setting video_pl=
l1
> >>   to freq 7*A.
> >> - media_disp[12]_pix is set to freq A by using a divisor of 7.
> >>=20
> >> So yes, and the explanation of why is there:
> >> https://elixir.bootlin.com/linux/v6.11.8/source/drivers/clk/clk-divide=
r.c#L322
> >>=20
> >> > The
> >> > pixel clock can be got from LDB's remote input LCDIF DT node by
> >> > calling of_clk_get_by_name() in fsl_ldb_probe() like the below patch
> >> > does. Similar to setting pixel clock rate, I think a chance is that
> >> > pixel clock enablement can be moved from LCDIF driver to
> >> > fsl_ldb_atomic_enable() to avoid on-the-fly division ratio change.
> >>=20
> >> TBH, this sounds like a hack and is no longer required with this serie=
s.
> >>=20
> >> You are just trying to circumvent the fact that until now, applying a
> >> rate in an upper clock would unconfigure the downstream rates, and I
> >> think this is our first real problem.
> >>=20
> >> > https://patchwork.kernel.org/project/linux-clk/patch/20241114065759.=
3341908-6-victor.liu@nxp.com/
> >> >
> >> > Actually, one sibling patch of the above patch reverts ff06ea04e4cf
> >> > because I thought "fixed PLL rate" is the only solution, though I'm
> >> > discussing any alternative solution of "dynamically changeable PLL
> >> > rate" with Marek in the thread of the sibling patch.
> >>=20
> >> I don't think we want fixed PLL rates. Especially if you start using
> >> external (hot-pluggable) displays with different needs: it just does n=
ot
> >> fly. There is one situation that cannot yet be handled and needs
> >> manual reparenting: using 3 displays with a non-divisible pixel
> >> frequency.
> >
> > Funnily, external interfaces (ie, HDMI, DP) tend to be easier to work
> > with than panels. HDMI for example works with roughly three frequencies:
> > 148.5MHz, 297MHz and 594MHz. If you set the PLL to 594MHz and the
> > downstream clock has a basic divider, it works just fine.
> >
> >> FYI we managed this specific "advanced" case with assigned-clock-paren=
ts
> >> using an audio PLL as hinted by Marek. It mostly works, event though t=
he
> >> PLL1416 are less precise and offer less accurate pixel clocks.
> >
> > Note that assigned-clock-parents doesn't provide any guarantee on
> > whether the parent will change in the future or not. It's strictly
> > equivalent to calling clk_set_parent in the driver's probe.
>=20
> Oh yeah, but here I'm mentioning en even more complex case where we
> connect three panels with pixel clocks that cannot be all three derived
> from the same parent. There has never been any upstream support for
> that and I doubt we will have any anytime soon because we need a central
> (drm) place to be aware of the clock limitations and make these
> decisions.

I'm not sure why DRM would be involved here. It's internal clock
details, putting that in the consumer is an abstraction violation. Also,
this will happen with any clock that needs accurate frequency. If the
conflict happens between ALSA and MMC, how will you deal with it?

> >> +       /*
> >> +        * Dual cases require a 3.5 rate division on the pixel clocks,=
 which
> >> +        * cannot be achieved with regular single divisors. Instead, d=
ouble the
> >> +        * parent PLL rate in the first place. In order to do that, we=
 first
> >> +        * require twice the target clock rate, which will program the=
 upper
> >> +        * PLL. Then, we ask for the actual targeted rate, which can b=
e achieved
> >> +        * by dividing by 2 the already configured upper PLL rate, wit=
hout
> >> +        * making further changes to it.
> >> +        */
> >> +       if (fsl_ldb_is_dual(fsl_ldb))
> >> +               clk_set_rate(fsl_ldb->clk, requested_link_freq * 2);
> >>         clk_set_rate(fsl_ldb->clk, requested_link_freq);
> >
> > This has nothing to do in a DRM driver. The clock driver logic needs
> > to handle it.
>=20
> The approach I am proposing in this series can sadly not work, because
> it is not possible to slightly modify a clock after the crtc has been
> set up without getting back into drm for further tuning.

I'm not sure what you mean or what you want here, sorry.

> I observed that my series was dependent on the probe order, because
> the exact same clock tree would work and not work depending on the
> order.
>=20
> To get back to your comment, unfortunately, there will be no other
> choice than having drm drivers being aware of clock limitations, just
> because the clock subsystem alone, even if it would do the right thing
> behind the hood, would still sometimes break displays. This means drm
> drivers will have to care about clock constraints.

Clock constraints, sure. Like, if the clock cannot provide a given
frequency within a reasonable tolerance, DRM should indeed ignore that
mode. Trying to arbitrate between clocks and find a good configuration
for a given platform, absolutely not.

> As an example here, I am fine arguing about the way (calling
> clk_set_rate twice on the same clock), but the fact that the parent
> clock must be multiplied: this is drm business, because it is a drm
> requirement.

That's not what the abstraction is though. Any driver should call
clk_set_rate_exclusive on a clock once, and expect the clock to remain
the same going forward. That's what is documented, that's what the
driver will rely on. If or how the API implementation is able to perform
that task is none of the consumer's business.

Maxime

--75haewkz6w363ceg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ3vsigAKCRAnX84Zoj2+
dvOAAYDMG9y6CoudQtjyH363osJ/SPKHskXTxR1vA85r3y4/gv0PEyEfQ3TugjPc
fBCYlusBfiElRsO8Ea4TYRBaqDd4iXqGSQSdrBwsoWdi7UwMxqfc177GP9AGsxOL
eqBaIJ0EaQ==
=5+xQ
-----END PGP SIGNATURE-----

--75haewkz6w363ceg--


