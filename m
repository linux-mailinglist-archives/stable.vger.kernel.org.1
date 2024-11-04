Return-Path: <stable+bounces-89706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3949BB743
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D036B2849B7
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8913BC2F;
	Mon,  4 Nov 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWV/ppQZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDED2AE90;
	Mon,  4 Nov 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729682; cv=none; b=H8dZPmIf4HvH0Q0yvYJRwHzFnI3oH+Bc5SD1jcax8ePx4gO/RMCjkcHIJ+c1LoBM+dPJ4wcyi2j7/XHglBF+AQJHQ2OPUA39UZ4XkjIg1Ih+bj9zdYAwJesKTVL0MLFRBzBDX9ONu1Q/zuAakDPboiX0xZy1erb6UhS3K89Gvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729682; c=relaxed/simple;
	bh=22IkpLsTJ3lJP8P21zcOPBy6UAX1xZrcihsucCCaPlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZuncB4kq6R7bLrSDteRq56vydqamK3ybN4kEoBNT6z5joAlQKGjJePc0RXcRUzhOO6El5vey6pe93nyLy0gRn54pFZsNhwbwMbftuSIqZrw5oIpOIidAsQt0CsuSlE35Ei61CW7n/aP2GprhbHLsxb0zCb0THPMMghX1N1746k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWV/ppQZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so3505945a91.1;
        Mon, 04 Nov 2024 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730729680; x=1731334480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edAMo1PY72zkfTpbMxA+qP1Jihl1VWVJ/LFLScOHZxs=;
        b=NWV/ppQZPq1od17fFWqrgKK+lBUUN5JsZPZwLPixef7DEaGHl642KHOUmUU8OaFw7A
         0y7dBuTRKAYropKFnC7pNiUM9vFHyHWBn/5GthgjhB+L/BsbfnMJP9BL4beaf7zATToN
         OCqsZnAaV4yHTH3Cfz+pEhW83jsw7m4EeKUsOABNqJ9FuGgm9+TepOU7HUv8uuO2xw8y
         QtJnCMWPtszW9qj4vyDqYVkOivR/rOM+MIESi+uZfl1ZQYoak4rrmyGDwnFir2ekrxNW
         bDmVj1/mm1KGS1x6JMED3kcSyUJMNm/Op0Ye6N2RjZzOfKz4eVvl00Kf1SR22s+wXZv5
         92VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729680; x=1731334480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edAMo1PY72zkfTpbMxA+qP1Jihl1VWVJ/LFLScOHZxs=;
        b=vDqgZK4JPKQfOHiFbYbWz+gTADdiP8jD/oB9tyJda2iZk+gp5vmppmP65mqBQ1N0hu
         1pG9XIJzhgzUiRxwSXya/mqUlqE8nw0XMViaViTCbYyUSdlGdhTV10QWU/AGrYarhVEM
         mJvg4ZL82yJ6MzEW1GMVpojZNx6MmCccyzExIDY58O1EgFsi5Cq2DVo19zM8YNsOV5sc
         FxLQNkO1OHtfAjcliWaCtrTwd2ch4V+H9ZfUoBGm6/cy9ZEZVfhNk3kvgSbBajrg99aB
         na3LGsaxYNpX2NozgfGaUTiOlCikzkhCGkeSm7GKGKaip0DZZrJnsfppsZnEjNpNmvJp
         fMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3XRNon+o1EKH+o4MwU0125cj3LtmJiK6oNrX2TAW6qhWWziYPfJVcUx2tQDvixwZOZ3K9rTeZ@vger.kernel.org, AJvYcCWKdyChPf62ThqR6Z8oFFPpkuV+4MzJrXLDxxaB3NrdP1WKjyAwcg+T716/rZfLlfdGCqnnCncd53W/+lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8huRM3cEbCooF6BEe+l+THcLaIQlRYl6Vz+agD6PZv+OGLPz
	VOdzWPxYm0FMuZjTXZwzT1LKfEsPy9s67sbrA1HZSsPJG17C1AIv3rrVne1t/3c7+yyfVfP32ui
	OxaRYFJ897r6XkS70MyuUe388VBc=
X-Google-Smtp-Source: AGHT+IEmoWv2BQyjgSKvNZTyFnFU/aFLKu2M11dcp+q5xS3jkjmpk2PvhiOnId+cOj9tdQGGbgL5byubxkd+rHQu7UM=
X-Received: by 2002:a17:90b:2dcc:b0:2e2:7f8f:3ad7 with SMTP id
 98e67ed59e1d1-2e93c1595b5mr21780271a91.7.1730729679934; Mon, 04 Nov 2024
 06:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021155241.943665-1-Frank.Li@nxp.com> <DU2PR04MB86770FFB0CAEEBE95B91F5FC8C4C2@DU2PR04MB8677.eurprd04.prod.outlook.com>
 <CAHCN7xJya+XjAP+kn5MePdrqNxaLnkYag23UaNatoh09ize+AA@mail.gmail.com> <AS8PR04MB8676D33E00DE6B0B961B5EB58C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676D33E00DE6B0B961B5EB58C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 4 Nov 2024 08:14:28 -0600
Message-ID: <CAHCN7xKj9XYnsaTjFfE_jn7rsN86wv0bxKq3o83WNkamrqeU1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before
 PHY PLL lock check
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "kishon@kernel.org" <kishon@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 11:19=E2=80=AFPM Hongxing Zhu <hongxing.zhu@nxp.com>=
 wrote:
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: 2024=E5=B9=B411=E6=9C=882=E6=97=A5 3:53
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; vkoul@kernel.org; festevam@gmail.com;
> > imx@lists.linux.dev; kernel@pengutronix.de; kishon@kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > linux-phy@lists.infradead.org; Marcel Ziswiler <marcel.ziswiler@toradex=
.com>;
> > s.hauer@pengutronix.de; shawnguo@kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just=
 before
> > PHY PLL lock check
> >
> > On Mon, Oct 21, 2024 at 11:06=E2=80=AFPM Hongxing Zhu <hongxing.zhu@nxp=
.com>
> > wrote:
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <frank.li@nxp.com>
> > > > Sent: 2024=E5=B9=B410=E6=9C=8821=E6=97=A5 23:53
> > > > To: vkoul@kernel.org
> > > > Cc: Frank Li <frank.li@nxp.com>; festevam@gmail.com; Hongxing Zhu
> > > > <hongxing.zhu@nxp.com>; imx@lists.linux.dev; kernel@pengutronix.de;
> > > > kishon@kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; Marcel
> > > > Ziswiler <marcel.ziswiler@toradex.com>; s.hauer@pengutronix.de;
> > > > shawnguo@kernel.org; stable@vger.kernel.org
> > > > Subject: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just
> > > > before PHY PLL lock check
> > > >
> > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > >
> > > > When enable initcall_debug together with higher debug level below.
> > > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D9
> > > > CONFIG_CONSOLE_LOGLEVEL_QUIET=3D9
> > > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D7
> > > >
> > > > The initialization of i.MX8MP PCIe PHY might be timeout failed rand=
omly.
> > > > To fix this issue, adjust the sequence of the resets refer to the
> > > > power up sequence listed below.
> > > >
> > > > i.MX8MP PCIe PHY power up sequence:
> > > >                           /----------------------------------------=
-----
> > > > 1.8v supply     ---------/
> > > >                     /----------------------------------------------=
-----
> > > > 0.8v supply     ---/
> > > >
> > > >                 ---\ /---------------------------------------------=
-----
> > > >                     X        REFCLK Valid
> > > > Reference Clock ---/ \---------------------------------------------=
-----
> > > >                              --------------------------------------=
-----
> > > >                              |
> > > > i_init_restn    --------------
> > > >                                     -------------------------------=
-----
> > > >                                     |
> > > > i_cmn_rstn      ---------------------
> > > >                                          --------------------------=
-----
> > > >                                          | o_pll_lock_done
> > > > --------------------------
> > > >
> > > > Logs:
> > > > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > > > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > > > 0x0000000000
> > > > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > > > 0x0018000000
> > > > probe of clk_imx8mp_audiomix.reset.0 returned 0 after 1052 usecs
> > > > probe of 30e20000.clock-controller returned 0 after 32971 usecs phy
> > > > phy-32f00000.pcie-phy.4: phy poweron failed --> -110 probe of
> > > > 30e10000.dma-controller returned 0 after 10235 usecs imx6q-pcie
> > > > 33800000.pcie: waiting for PHY ready timeout!
> > > > dwhdmi-imx 32fd8000.hdmi: Detected HDMI TX controller v2.13a with
> > > > HDCP
> > > > (samsung_dw_hdmi_phy2) imx6q-pcie 33800000.pcie: probe with driver
> > > > imx6q-pcie failed with error -110
> > > >
> > > > Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe
> > > > PHY
> > > > support")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > >
> > > > v2 changes:
> > > > - Rebase to latest fixes branch of linux-phy git repo.
> > > > - Richard's environment have problem and can't sent out patch. So I
> > > > help post this fix patch.
> >
> > Even with this patch, I am still seeing an occasional timeout on 8MP.
> > I looked at some logs on a similarly functioning 8MM and I can't get th=
is error to
> > appear on Mini that I see on Plus.
> >
> > The TRM doesn't document the timing of the startup sequence, like this =
e-mail
> > patch did nor does it state how long a reasonable timeout should take. =
So, I
> > started looking through the code and I noticed that the Mini asserts th=
e reset at
> > the beginning, then makes all the changes, and de-asserts the resets to=
ward the
> > end.  Is there any reason we should not assert one or both of the reset=
s on
> > 8MP before setting up the reset of the registers like the way Mini does=
 it?
> Yes, I had the similar confusions when I try to bring up i.MX8MP PCIe.
> i.MX8MP PCIe resets have the different designs but I don't know the reaso=
n and
> the details. These resets shouldn't be asserted/de-asserted as Mini does =
during
>  the initialization.
>
> On i.MX8MP, these resets should be configured one-shot. I used to toggle =
them
> in my own experiments. Unfortunately, the PCIe PHY wouldn't be functional=
.

I started testing adding the resets before I asked, because it appears
to be working ok, but if you're suggesting it's a bad idea, I won't
continue down that path.  Do you have any other suggestions on how to
eliminate the occasional timeout error?  I still see it at times on a
cold-boot even with this latest patch applied.

thanks

adam

>
> Best Regards
> Richard Zhu
> >
> > adam
> >
> > > > ---
> > > Hi Frank:
> > > Thanks a lot for your kindly help.
> > > Since my server is down, I can't send out this v2 in the past days.
> > >
> > > Hi Vinod:
> > > Sorry for the late reply, and bring you inconvenience.
> > >
> > > Best Regards
> > > Richard Zhu
> > >
> > > >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > index 11fcb1867118c..e98361dcdeadf 100644
> > > > --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > @@ -141,11 +141,6 @@ static int imx8_pcie_phy_power_on(struct phy
> > > > *phy)
> > > >                          IMX8MM_GPR_PCIE_REF_CLK_PLL);
> > > >       usleep_range(100, 200);
> > > >
> > > > -     /* Do the PHY common block reset */
> > > > -     regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > > > -                        IMX8MM_GPR_PCIE_CMN_RST,
> > > > -                        IMX8MM_GPR_PCIE_CMN_RST);
> > > > -
> > > >       switch (imx8_phy->drvdata->variant) {
> > > >       case IMX8MP:
> > > >               reset_control_deassert(imx8_phy->perst);
> > > > @@ -156,6 +151,11 @@ static int imx8_pcie_phy_power_on(struct phy
> > > > *phy)
> > > >               break;
> > > >       }
> > > >
> > > > +     /* Do the PHY common block reset */
> > > > +     regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > > > +                        IMX8MM_GPR_PCIE_CMN_RST,
> > > > +                        IMX8MM_GPR_PCIE_CMN_RST);
> > > > +
> > > >       /* Polling to check the phy is ready or not. */
> > > >       ret =3D readl_poll_timeout(imx8_phy->base +
> > > > IMX8MM_PCIE_PHY_CMN_REG075,
> > > >                                val, val =3D=3D ANA_PLL_DONE, 10,
> > 20000);
> > > > --
> > > > 2.34.1
> > >
> > > --
> > > linux-phy mailing list
> > > linux-phy@lists.infradead.org
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ist
> > >
> > s.infradead.org%2Fmailman%2Flistinfo%2Flinux-phy&data=3D05%7C02%7Chongx=
i
> > >
> > ng.zhu%40nxp.com%7C666c8968b3094147ed4408dcfaaec631%7C686ea1d3bc
> > 2b4c6f
> > >
> > a92cd99c5c301635%7C0%7C0%7C638660875771545687%7CUnknown%7CTWF
> > pbGZsb3d8
> > >
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C0
> > > %7C%7C%7C&sdata=3D3Mg4SqcaA%2FlbScveriGBBMOq1YOTt3okydgHmjmdLps
> > %3D&reser
> > > ved=3D0

