Return-Path: <stable+bounces-176936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A83B3F643
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88BF1A82955
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193342E62D9;
	Tue,  2 Sep 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRhtDNB2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E32E36E9;
	Tue,  2 Sep 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797136; cv=none; b=pQ2MpZvM0AoVJEYuTlmH4f6jYo6U7Tlc2EnBUlze0vhwyWfqMjVo47Z+QLK+Qah3jqFuQG2UYjdLfRSagBpzmg7GL+o1gFxCQ7RmHLRhJHaj1xKXMFzyo+DBElJE4ThhXInvBgQoYaHfLPhsQgBvJ2h/ehRipxphlREKQJII+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797136; c=relaxed/simple;
	bh=KfIhs/QHI9uKXAU6wEHiDKRxtZStBaqgm9XSaLZH9oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4cXogEdI1uLlF6Xnn/Ml4/UVrYLmHnsMGW6MmS4EF5J7UApRV1szf96u+6qTMkvfNAx78DsI5KySq85mw+WoFUe3lAZG1vLiyp/rCXy7FDmjr34khOVsUBStfl31w8csnVFjMTAA//vs1mNWibdIlZXZzmF51F+x9cDRyGNqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRhtDNB2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so6265598a12.0;
        Tue, 02 Sep 2025 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797132; x=1757401932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxufWewqEFAv99uIytCHjgx11TKUdAha3OgtKd/++a0=;
        b=PRhtDNB2Zc+XOvJ23q/FcJJffrEXT6ssqhP+DoT/FTEMWBArm1eN6v3Cqnwo9Ru0c0
         gMGXsj+mqUUvNGWreniI3Lk/lTWi17QjuLoyIN75stanwos4AX8i7/Ki3dk43VxHpypB
         dnm9RP6gYHNpnxvTFasElChcg12qUKRb4F/g4gH/fuFkYhd3jzpk9YsGtB+KKkveGvj7
         xoWRmMNwQuyZYtyTBTgCNPnW5Ky+lqEdWhdDGgenKgadhDVZn7ujyR5HgLRmiK6yOFSC
         Q9km72ySgZAbHeQ8UZVQI2gdcuZP0XO9BIQr22IEICI4t5VhG2TeQyPte6e5a7u6pd0s
         Z45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797132; x=1757401932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxufWewqEFAv99uIytCHjgx11TKUdAha3OgtKd/++a0=;
        b=c7lVYmalNNOG8T3F+lFF2RiABsvkXJlEDhwzz6uIzem6zjjkcRDptuMW9xI07wXuzJ
         i5IXa+oorBenDSjgbVcudaCNtYTns+Q6Rf79Hsb10l1t83hhMpIxZGdwjP4Rr5ooiDat
         epJ3KdS9Pxuf8C+A77nwwYn31USOmoroocZaMTOxxWiw0I8qX5cMexkjZqqoEhmRx7Lw
         2wT1XkJ3l+QeMEM8koFV9oZivJb/dRaso/y/4zdVjBbKtKhDt1ktAluH7+T2VnRCnVfv
         dYpEO+5S2B6WmyRng4M+yZn7jJz7FNfFhHiFnS23gtBLgbpmQo4eQ8idAROAqC771qPg
         LT1A==
X-Forwarded-Encrypted: i=1; AJvYcCUW2/yKJ5VPfZVpN/1VsIwMNenNi3IYz8joSkstvGOqedPTlonqBgAbriOBTK8lfusoPi4a6uHd@vger.kernel.org, AJvYcCVSLOKKz2nvJkPz7XzWDM0ghHQ2iOmN9FLY5OXxPXMnRyXlJtR6R+DQLImm83SGNfq20jZ8IGrhOr86@vger.kernel.org, AJvYcCVm3OFcSVg/WX0eLU77c/SEXmVgA3PAkIOGfIC0FNoHvM5TARTn0+WMAXoOTWmFKbLVrFT+8RkRWFcgSgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxktm510wDmmWew5LM82WNKDLPdb3wYTv2qlcZusPDrK5MiZldp
	y6EwsrJVAfJiozaA2T7tlNviyFCehni6F6/k+1JCP3APd6PGW1ognNQvfbIci3q4Yj2KgPvng9p
	G3Jfgu36VYNZ4PmQdJYStDUI9QwY3aWg=
X-Gm-Gg: ASbGncsfF03NBeUTsEE2bU9dCRZ5hC7O3K/72a+LoW4TW7nwC7+PYNSued6sJbupdW7
	V1+vxE8bMaBd6u96O2h50G+KW2Tb7SkJyFY2wK4xip+YbDCtgcXs6+lClPJ/jU3Rr1eEVTWr7Rz
	zoCcwfMd779+As4i7Xk2CSV6sGhA7V2jbFNQ8HzO8ubfpdJbAHWsBEIalomHbeBmByvNprYdWFw
	ND5H04=
X-Google-Smtp-Source: AGHT+IEyHlYgeZfIQuCEEMlaGXtcQkEDLZkP/oxXg+pXvIGzIZDCNUrIB3twESvdqCr+edRWXTuNE+K5TpWeNONlvb8=
X-Received: by 2002:a05:6402:d0e:b0:61c:8114:8832 with SMTP id
 4fb4d7f45d1cf-61d2699b037mr9272851a12.16.1756797131949; Tue, 02 Sep 2025
 00:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901094224.3920-1-benchuanggli@gmail.com> <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
 <CACT4zj9n9E45E2T84ciLTEZgUAbcOzH5+ZgTYq8=m=Pusy37iA@mail.gmail.com>
In-Reply-To: <CACT4zj9n9E45E2T84ciLTEZgUAbcOzH5+ZgTYq8=m=Pusy37iA@mail.gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Tue, 2 Sep 2025 15:12:00 +0800
X-Gm-Features: Ac12FXwZjVjOIdI0stbqdSoQ3vqSXNRZz8TDgcS4HPUWIgrScaqqsm6p9EBwSpg
Message-ID: <CACT4zj-_NHV0td1RULmww4tvw3beJZASNv3+e5TG8wE318wvGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:33=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com> =
wrote:
>
> On Tue, Sep 2, 2025 at 1:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
> >
> > On 01/09/2025 12:42, Ben Chuang wrote:
> > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >
> > > According to the power structure of IC hardware design for UHS-II
> > > interface, reset control and timing must be added to the initializati=
on
> > > process of powering on the UHS-II interface.
> > >
> > > Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL97=
67")
> > > Cc: stable@vger.kernel.org # v6.13+
> > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/host/sdhci-pci-gli.c | 71 ++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 70 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhc=
i-pci-gli.c
> > > index 3a1de477e9af..85d0d7e6169c 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -283,6 +283,8 @@
> > >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE     0xb
> > >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL       BIT(6)
> > >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE         0x1
> > > +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN   BIT(13)
> > > +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE BIT(14)
> > >
> > >  #define GLI_MAX_TUNING_LOOP 40
> > >
> > > @@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(s=
truct pci_dev *pdev, bool enable)
> > >       gl9767_vhs_read(pdev);
> > >  }
> > >
> > > +static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *ho=
st)
> > > +{
> > > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > > +     u32 value;
> > > +
> > > +     gl9767_vhs_write(pdev);
> > > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > > +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> > > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > > +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> > > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > > +     gl9767_vhs_read(pdev);
> > > +}
> > > +
> > > +static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host *=
host)
> > > +{
> > > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > > +     u32 value;
> > > +
> > > +     gl9767_vhs_write(pdev);
> > > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > > +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >
> > Maybe add a small comment about PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VA=
LUE
> > and PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN being updated separately.
> >
> > > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > > +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> > > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > > +     gl9767_vhs_read(pdev);
> > > +}
> >
> > sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_de=
assert()
> > are fairly similar.  Maybe consider:
> >
> > static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool a=
ssert)
> > {
> >         struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >         struct pci_dev *pdev =3D slot->chip->pdev;
> >         u32 value, set, clr;
> >
> >         if (assert) {
> >                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >         } else {
> >                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >         }
> >
> >         gl9767_vhs_write(pdev);
> >         pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> >         value |=3D set;
> >         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >         value &=3D ~clr;
> >         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >         gl9767_vhs_read(pdev);
> > }
> >
>
> OK, I will update it. Thank you.
>
> >
> > > +
> > > +static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsigne=
d char mode, unsigned short vdd)
> > > +{
> > > +     u8 pwr =3D 0;
> > > +
> > > +     if (mode !=3D MMC_POWER_OFF) {
> > > +             pwr =3D sdhci_get_vdd_value(vdd);
> > > +             if (!pwr)
> > > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > > +                          mmc_hostname(host->mmc), vdd);
> > > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > > +     }
> > > +
> > > +     if (host->pwr =3D=3D pwr)
> > > +             return;
> > > +
> > > +     host->pwr =3D pwr;
> > > +
> > > +     if (pwr =3D=3D 0) {
> > > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > > +     } else {
> > > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > > +
> > > +             pwr |=3D SDHCI_POWER_ON;
> > > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > > +             mdelay(5);
> >
> > Can be mmc_delay(5)
> >
> > > +
> > > +             sdhci_gl9767_uhs2_phy_reset_assert(host);
> > > +             pwr |=3D SDHCI_VDD2_POWER_ON;
> > > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > > +             mdelay(5);
> >
> > Can be mmc_delay(5)
>
> I may not modify it now.
> mmc_delay() is in "drivers/mmc/core/core.h".
> If sdhci-pci-gli.c only includes "../core/core.h", the compiler will
> report some errors.

Ah, just add another headersand it will build.

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -14,6 +14,8 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/iopoll.h>
+#include <linux/mmc/host.h>
+#include "../core/core.h"
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
@@ -968,10 +970,10 @@ static void gl9755_set_power(struct sdhci_host
*host, unsigned char mode,

                sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
                /* wait stable */
-               mdelay(5);
+               mmc_delay(5);
                sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
                /* wait stable */
-               mdelay(5);
+               mmc_delay(5);
                sdhci_gli_overcurrent_event_enable(host, true);
        }


>
> <snippet>
> IIn file included from host/sdhci-pci-gli.c:17:
> host/../core/core.h:131:52: warning: =E2=80=98struct mmc_ctx=E2=80=99 dec=
lared inside
> parameter list will not be visible outside of this definition or
> declaration
>   131 | int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
>       |                                                    ^~~~~~~
> host/../core/core.h:134:49: warning: =E2=80=98struct mmc_ctx=E2=80=99 dec=
lared inside
> parameter list will not be visible outside of this definition or
> declaration
>   134 | void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
>       |                                                 ^~~~~~~
> host/../core/core.h:135:49: warning: =E2=80=98struct mmc_ctx=E2=80=99 dec=
lared inside
> parameter list will not be visible outside of this definition or
> declaration
>   135 | void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
>       |                                                 ^~~~~~~
> host/../core/core.h: In function =E2=80=98mmc_pre_req=E2=80=99:
> host/../core/core.h:165:17: error: invalid use of undefined type
> =E2=80=98struct mmc_host=E2=80=99
>   165 |         if (host->ops->pre_req)
>       |                 ^~
>
> >
> > > +     }
> > > +}
> > > +
> > >  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned=
 int clock)
> > >  {
> > >       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > @@ -1205,6 +1270,10 @@ static void sdhci_gl9767_set_clock(struct sdhc=
i_host *host, unsigned int clock)
> > >       }
> > >
> > >       sdhci_enable_clk(host, clk);
> > > +
> > > +     if (mmc_card_uhs2(host->mmc))
> > > +             sdhci_gl9767_uhs2_phy_reset_deassert(host);
> > > +
> > >       gl9767_set_low_power_negotiation(pdev, true);
> > >  }
> > >
> > > @@ -1476,7 +1545,7 @@ static void sdhci_gl9767_set_power(struct sdhci=
_host *host, unsigned char mode,
> > >               gl9767_vhs_read(pdev);
> > >
> > >               sdhci_gli_overcurrent_event_enable(host, false);
> > > -             sdhci_uhs2_set_power(host, mode, vdd);
> > > +             __gl9767_uhs2_set_power(host, mode, vdd);
> > >               sdhci_gli_overcurrent_event_enable(host, true);
> > >       } else {
> > >               gl9767_vhs_write(pdev);
> >
>
> Best regards,
> Ben Chuang

