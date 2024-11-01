Return-Path: <stable+bounces-89523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F79B9905
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C9B1C20381
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37911D1E77;
	Fri,  1 Nov 2024 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5ryA8Wj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F41CACF2;
	Fri,  1 Nov 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490773; cv=none; b=GSTdm38UkIZtWPmBwZVkaRlB+pCTmanSAKNs+GHsAndkm+K83ecgyNhAbXmtWvg3rBGdJ1m4fx4rfYiM5bJ+igdi4sqxW80T/1pbIh7E8v+3RG2Bq1zO3Oklb1M3K+MxgsAb2XCRPJvhqI9J5pTAOg2VBFLP6uv+43IKzYJKBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490773; c=relaxed/simple;
	bh=75TsGrCzuU9kiP8H4uqt/9mF+gJdxD3Q4ZiswdgLKf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehM3NClgmkgSw34ZNBSJHCC/ptP3A/iaFYdG8SQ4Lm1Bozy7eslHGMBY6C/u+vYmvwa224sNOIIK2mSkR6JWHQ39i/GgZTbZAOlC2D63lPcW8YoUy2RWNeHIDVS0Xfjms7L+ZPukbi3JCVZ7OgYA79vR7QHBDZBLfnRxs5QlK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5ryA8Wj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so1406727a12.2;
        Fri, 01 Nov 2024 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490771; x=1731095571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xhsok5lUSaLeX0jB80qqmTm3/8Vx9ryb4EE5XRrW0T8=;
        b=c5ryA8WjLOzvzIfgCXWTwS+MBTsq/haBrV5GnSasQnXUZSAQ4RrzaCIgur/7j2f7TB
         N/hnxdErEKTSoP2VMaNAiPGCULkEatPRBqTYwV3mwKbV3BYHtrXO2BFOJ0l7BQhmJ+lg
         jZS7DnOVH87CZM/DI+SZq27wZiVoEi1lwun+EMtd0zW6SK59qySL6s5x14LcSkQyrxCL
         +2qeESyYxneSLWKbeI/j+Yk3/OQIH22VKCnD8DETruktsbVhqvg+3wDa4vT9ftD+57za
         RCBKkUZ0eQiWMNkxa00FmLB2Q+YozsEOB0ikJElLKyderDRc3OAkVL6tW3vfXg2SELGf
         GnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490771; x=1731095571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xhsok5lUSaLeX0jB80qqmTm3/8Vx9ryb4EE5XRrW0T8=;
        b=ZBUJUtQChbnqamvpSL40WDQvvWl8deayTaZNZsGTxefOfOTGKNoJbxi+Xz2/FhkJ++
         vgNdFI+qYVVsqIgh7+26muAqul16WkOCqDjTnebiSokBfbMXBdbzQH9dz6aWIgMSafJk
         x0/ZW9io6TyYfpgUfuezxqwYxEcMQ+ZYfxWnkcyCeXrWQMDYAYz6Niu6iArHFcPusHUT
         5FIG5BBBrwmoxlgZ2QWtLFH6u5cJT57ZEL0RKfBP5nR/2+Y11Ne9XyOVByPpC9vmzsfH
         EMEQ5JK364IvEcCmjYr5vHGF+kH/QFlckBJsktpTUQaQJkN2E78DUFu51Tx4a0xkYMLa
         d+/A==
X-Forwarded-Encrypted: i=1; AJvYcCULIjbJ8cIVNAxrHABQOjJh6RKMR0ggBUgAA2jS1gfYMbWgUMrgs8DOuXHHjhMMMTZjn0RkWJKQ@vger.kernel.org, AJvYcCXdCzGPcl5UeOCA9L8lhMJFC8eiGG5ZMhHY5z8YT4DW6BVhI73BKz8WO6QDzllrroV+P8gy5kzmzGOiEnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9l90m/rEbOIr+1fweL1VUCH59cipqLW1TjX9pcDBOqhea4op
	UNzaFIr9/FSFouUg923ONiMVw5Rma2p5I5smOwJlV2HSY5ZBkC/lwbM03x32GaHy/xRKXjr5yBD
	OUEIsIRPBmyX1TygSdm6l2GxeA1j3nAtb
X-Google-Smtp-Source: AGHT+IHZKMW6nZzgZWjfjRWzIvWK1iTYBaT4YLGi4D6U/W2A5SxqJ4IVJebquI4t7FLTpZHyma5G5RNi+tkyXX6nGq4=
X-Received: by 2002:a17:90b:1c85:b0:2e2:e597:6cd3 with SMTP id
 98e67ed59e1d1-2e94c2d6a20mr6009738a91.17.1730490770981; Fri, 01 Nov 2024
 12:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021155241.943665-1-Frank.Li@nxp.com> <DU2PR04MB86770FFB0CAEEBE95B91F5FC8C4C2@DU2PR04MB8677.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB86770FFB0CAEEBE95B91F5FC8C4C2@DU2PR04MB8677.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 1 Nov 2024 14:52:39 -0500
Message-ID: <CAHCN7xJya+XjAP+kn5MePdrqNxaLnkYag23UaNatoh09ize+AA@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 11:06=E2=80=AFPM Hongxing Zhu <hongxing.zhu@nxp.com=
> wrote:
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2024=E5=B9=B410=E6=9C=8821=E6=97=A5 23:53
> > To: vkoul@kernel.org
> > Cc: Frank Li <frank.li@nxp.com>; festevam@gmail.com; Hongxing Zhu
> > <hongxing.zhu@nxp.com>; imx@lists.linux.dev; kernel@pengutronix.de;
> > kishon@kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; Marcel Zis=
wiler
> > <marcel.ziswiler@toradex.com>; s.hauer@pengutronix.de;
> > shawnguo@kernel.org; stable@vger.kernel.org
> > Subject: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just bef=
ore
> > PHY PLL lock check
> >
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > When enable initcall_debug together with higher debug level below.
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D9
> > CONFIG_CONSOLE_LOGLEVEL_QUIET=3D9
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D7
> >
> > The initialization of i.MX8MP PCIe PHY might be timeout failed randomly=
.
> > To fix this issue, adjust the sequence of the resets refer to the power=
 up
> > sequence listed below.
> >
> > i.MX8MP PCIe PHY power up sequence:
> >                           /--------------------------------------------=
-
> > 1.8v supply     ---------/
> >                     /--------------------------------------------------=
-
> > 0.8v supply     ---/
> >
> >                 ---\ /-------------------------------------------------=
-
> >                     X        REFCLK Valid
> > Reference Clock ---/ \-------------------------------------------------=
-
> >                              ------------------------------------------=
-
> >                              |
> > i_init_restn    --------------
> >                                     -----------------------------------=
-
> >                                     |
> > i_cmn_rstn      ---------------------
> >                                          ------------------------------=
-
> >                                          | o_pll_lock_done
> > --------------------------
> >
> > Logs:
> > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > 0x0000000000
> > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > 0x0018000000
> > probe of clk_imx8mp_audiomix.reset.0 returned 0 after 1052 usecs probe =
of
> > 30e20000.clock-controller returned 0 after 32971 usecs phy
> > phy-32f00000.pcie-phy.4: phy poweron failed --> -110 probe of
> > 30e10000.dma-controller returned 0 after 10235 usecs imx6q-pcie
> > 33800000.pcie: waiting for PHY ready timeout!
> > dwhdmi-imx 32fd8000.hdmi: Detected HDMI TX controller v2.13a with HDCP
> > (samsung_dw_hdmi_phy2) imx6q-pcie 33800000.pcie: probe with driver
> > imx6q-pcie failed with error -110
> >
> > Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
> > support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >
> > v2 changes:
> > - Rebase to latest fixes branch of linux-phy git repo.
> > - Richard's environment have problem and can't sent out patch. So I hel=
p post
> > this fix patch.

Even with this patch, I am still seeing an occasional timeout on 8MP.
I looked at some logs on a similarly functioning 8MM and I can't get
this error to appear on Mini that I see on Plus.

The TRM doesn't document the timing of the startup sequence, like this
e-mail patch did nor does it state how long a reasonable timeout
should take. So, I started looking through the code and I noticed that
the Mini asserts the reset at the beginning, then makes all the
changes, and de-asserts the resets toward the end.  Is there any
reason we should not assert one or both of the resets on 8MP before
setting up the reset of the registers like the way Mini does it?

adam

> > ---
> Hi Frank:
> Thanks a lot for your kindly help.
> Since my server is down, I can't send out this v2 in the past days.
>
> Hi Vinod:
> Sorry for the late reply, and bring you inconvenience.
>
> Best Regards
> Richard Zhu
>
> >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > index 11fcb1867118c..e98361dcdeadf 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > @@ -141,11 +141,6 @@ static int imx8_pcie_phy_power_on(struct phy
> > *phy)
> >                          IMX8MM_GPR_PCIE_REF_CLK_PLL);
> >       usleep_range(100, 200);
> >
> > -     /* Do the PHY common block reset */
> > -     regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > -                        IMX8MM_GPR_PCIE_CMN_RST,
> > -                        IMX8MM_GPR_PCIE_CMN_RST);
> > -
> >       switch (imx8_phy->drvdata->variant) {
> >       case IMX8MP:
> >               reset_control_deassert(imx8_phy->perst);
> > @@ -156,6 +151,11 @@ static int imx8_pcie_phy_power_on(struct phy
> > *phy)
> >               break;
> >       }
> >
> > +     /* Do the PHY common block reset */
> > +     regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > +                        IMX8MM_GPR_PCIE_CMN_RST,
> > +                        IMX8MM_GPR_PCIE_CMN_RST);
> > +
> >       /* Polling to check the phy is ready or not. */
> >       ret =3D readl_poll_timeout(imx8_phy->base +
> > IMX8MM_PCIE_PHY_CMN_REG075,
> >                                val, val =3D=3D ANA_PLL_DONE, 10, 20000)=
;
> > --
> > 2.34.1
>
> --
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

