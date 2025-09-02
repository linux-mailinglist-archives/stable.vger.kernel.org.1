Return-Path: <stable+bounces-176934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA95B3F58C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C235A204E4D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435A2E5438;
	Tue,  2 Sep 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz4yIxfz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DE2E3AF5;
	Tue,  2 Sep 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794815; cv=none; b=qBW1YL7r16PyMWdasD2FCxvby+JlDHevjRc6+SlRPJoZZtqULhOK6OcMJyqyZ9MKMCCMve9lWzlMS8xctSZ9Y/D5/NKz1z/P0UCnGRt+2Em52oyKlKwzcGxsWDvB8yQ0hOUuc7Y6UkjTPkHkzIXcdBJvJh1rbZIi8FGadmGh95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794815; c=relaxed/simple;
	bh=ZDNReLvC0RCY1VeCbcsfatxrM0P1WZc1w7HV1lB+bpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJz/+2f4EghxM9wVRAxx1ja7AueQbfl6SYYumXvbojxjT/zPLMcCC8wlo3GaEK6SlgkYXnzQ2f+3j/2pg0vgalohKUc8DWEUPZ+uggx9JCuE8WF60mFSMe6OhWAKWAORdO2CUg5/Usu/8RpuRAao1pBKJQ5i0E4nC3sohFQ1Mgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz4yIxfz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so2484026a12.0;
        Mon, 01 Sep 2025 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756794811; x=1757399611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISFG0CIFXRHnVQKVajsUgA9M8/dPNjeamQ8F2yisxME=;
        b=Oz4yIxfzNmeODQMttCbKFMs+MXj4crOeVXKjbmYnmWrmP7MoHIeacf8Ct00vRm4Yc2
         10X3GITvvguhFA/TiXZnpeOm/DuD7KQD5D93fj/4u4/Xb0KRHNqW6vQ9s5ycoi0oIpmt
         xO1QlQa0pjugb8vxNEHHS06IC4CdGwh1khsPNGEm4D4q64bcwjFc2SRw0SmTVp4Y0r2L
         gKgueRfbrW1xfrNQQRuiyDRgin1KjJD1R+fDfqErzeIvdQJyfFqF6dLv0F/9a1O3+PRl
         cyLjAC+rpioJoqHAcb0sLCFOGlDskrzd3CYxo9k7GAUZDi2f1s5BqwUwEDzCIBB8DxIe
         l7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794811; x=1757399611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISFG0CIFXRHnVQKVajsUgA9M8/dPNjeamQ8F2yisxME=;
        b=s68sYIjy/EnMeIURlTx1+MG9AIgXVdBQOl4aIW9WQCAPgIqY+5fb4Vayz5T4KCtAAb
         kpvg2fBFNEPnaOz8+Ofbr9vgOMNmjtrXCGIqYkpWmvR+LIbTkjrWYXkLxT4O4E+bq5gl
         1qtEPtcqoRn3UCMAaE/XXB4wehKMMuptez3jIJVxdmTmiYyZHl7TvvXJTx9hntsNaHd3
         XfwnhFsvoDyS5fVFs9wJUuwWLahLGKvnXZ7+sL5wP9GCeQwF5PcCStOQOYHHBjzyLWW+
         qe1wgbOQegjSgh6QemiqiY9nOYtYhWATXacOCkgC7q+4t/bpC1W83OVa3FF7vrXivj+v
         3CXg==
X-Forwarded-Encrypted: i=1; AJvYcCUhzl0Q45juGZJZg3mAd+KOpKqsH3DeHxGQlSB84AzWmaSMUxQnMdRiJ+kqeiT1H2x+fVm6jh0y@vger.kernel.org, AJvYcCUpYS6y9zdwFUOBCIYW4t9ES6Xc+OYQSzWwhdqp0CBWTKRQ/WBfZiVzWiplh1YgdoEk0svhwOSa4Ec0mos=@vger.kernel.org, AJvYcCXqO1cZTjTTurDGxVJdjxcmrpAlHT5HPsV8GPlWammABLhqdmRwzRVYu3HoN1DVmCoS1yj8iDLQZNSY@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXjQLTAmY3hLTJEaljBLtlbiWdKxhDPtdPvYxiknvTFpo9efL
	Y2RWvdwX1UuJG+R7+iu4/9Nv+vaPcthsDRjUoy5oFS2dDsYhtDz+wz1F7V1oF1NQ+WRBQx9zhji
	g5A3+YbyMJqdKzdU+Q7Pm44S8G5IPlNRTYw==
X-Gm-Gg: ASbGncusExPs3/mTdYwq0mFWYkkxrQnWeTwTuksONKUML253AbHjCCWwQYO/U0yaQok
	ddRUFheP+ahx7eAQOz9NAKtMXxOYBDHp444v6QZlUqNfFtpvW0JxXWx4U7qLJ4ynrN/RQFeAHki
	a9FY1P55sJfdHav6Pzm6sqdibhElznWhB0E59eoldWENVAZwZr+uobB9sejch2f+aqhsVNu/cpk
	O2IhTMvZlRg9Y9M
X-Google-Smtp-Source: AGHT+IEHJyrNijpzDhe0b3FK/TlF//GsukVr71TxxcCy+CqWVly5WlmkCCB9aWLEzQTXmsG+MrB+TgAjZ1ojtxv9Q8A=
X-Received: by 2002:a05:6402:4407:b0:61e:a13a:27b8 with SMTP id
 4fb4d7f45d1cf-61ea13a298fmr4303831a12.1.1756794810617; Mon, 01 Sep 2025
 23:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901094224.3920-1-benchuanggli@gmail.com> <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
In-Reply-To: <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Tue, 2 Sep 2025 14:33:19 +0800
X-Gm-Features: Ac12FXyDP4GxELd1rvS1ob_WueNyROUM5pReoyVTBo3rcTJTL8pp1NXPLA1WK2I
Message-ID: <CACT4zj9n9E45E2T84ciLTEZgUAbcOzH5+ZgTYq8=m=Pusy37iA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 01/09/2025 12:42, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > According to the power structure of IC hardware design for UHS-II
> > interface, reset control and timing must be added to the initialization
> > process of powering on the UHS-II interface.
> >
> > Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767=
")
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 71 +++++++++++++++++++++++++++++++-
> >  1 file changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 3a1de477e9af..85d0d7e6169c 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -283,6 +283,8 @@
> >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE     0xb
> >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL       BIT(6)
> >  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE         0x1
> > +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN   BIT(13)
> > +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE BIT(14)
> >
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> > @@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(str=
uct pci_dev *pdev, bool enable)
> >       gl9767_vhs_read(pdev);
> >  }
> >
> > +static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *host=
)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +
> > +     gl9767_vhs_write(pdev);
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +     gl9767_vhs_read(pdev);
> > +}
> > +
> > +static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host *ho=
st)
> > +{
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +
> > +     gl9767_vhs_write(pdev);
> > +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> > +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>
> Maybe add a small comment about PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALU=
E
> and PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN being updated separately.
>
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> > +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> > +     gl9767_vhs_read(pdev);
> > +}
>
> sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_deas=
sert()
> are fairly similar.  Maybe consider:
>
> static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool ass=
ert)
> {
>         struct sdhci_pci_slot *slot =3D sdhci_priv(host);
>         struct pci_dev *pdev =3D slot->chip->pdev;
>         u32 value, set, clr;
>
>         if (assert) {
>                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>         } else {
>                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
>                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
>         }
>
>         gl9767_vhs_write(pdev);
>         pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
>         value |=3D set;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>         value &=3D ~clr;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
>         gl9767_vhs_read(pdev);
> }
>

OK, I will update it. Thank you.

>
> > +
> > +static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsigned =
char mode, unsigned short vdd)
> > +{
> > +     u8 pwr =3D 0;
> > +
> > +     if (mode !=3D MMC_POWER_OFF) {
> > +             pwr =3D sdhci_get_vdd_value(vdd);
> > +             if (!pwr)
> > +                     WARN(1, "%s: Invalid vdd %#x\n",
> > +                          mmc_hostname(host->mmc), vdd);
> > +             pwr |=3D SDHCI_VDD2_POWER_180;
> > +     }
> > +
> > +     if (host->pwr =3D=3D pwr)
> > +             return;
> > +
> > +     host->pwr =3D pwr;
> > +
> > +     if (pwr =3D=3D 0) {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +     } else {
> > +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> > +
> > +             pwr |=3D SDHCI_POWER_ON;
> > +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
>
> Can be mmc_delay(5)
>
> > +
> > +             sdhci_gl9767_uhs2_phy_reset_assert(host);
> > +             pwr |=3D SDHCI_VDD2_POWER_ON;
> > +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +             mdelay(5);
>
> Can be mmc_delay(5)

I may not modify it now.
mmc_delay() is in "drivers/mmc/core/core.h".
If sdhci-pci-gli.c only includes "../core/core.h", the compiler will
report some errors.

<snippet>
IIn file included from host/sdhci-pci-gli.c:17:
host/../core/core.h:131:52: warning: =E2=80=98struct mmc_ctx=E2=80=99 decla=
red inside
parameter list will not be visible outside of this definition or
declaration
  131 | int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
      |                                                    ^~~~~~~
host/../core/core.h:134:49: warning: =E2=80=98struct mmc_ctx=E2=80=99 decla=
red inside
parameter list will not be visible outside of this definition or
declaration
  134 | void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
      |                                                 ^~~~~~~
host/../core/core.h:135:49: warning: =E2=80=98struct mmc_ctx=E2=80=99 decla=
red inside
parameter list will not be visible outside of this definition or
declaration
  135 | void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
      |                                                 ^~~~~~~
host/../core/core.h: In function =E2=80=98mmc_pre_req=E2=80=99:
host/../core/core.h:165:17: error: invalid use of undefined type
=E2=80=98struct mmc_host=E2=80=99
  165 |         if (host->ops->pre_req)
      |                 ^~

>
> > +     }
> > +}
> > +
> >  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
> >  {
> >       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > @@ -1205,6 +1270,10 @@ static void sdhci_gl9767_set_clock(struct sdhci_=
host *host, unsigned int clock)
> >       }
> >
> >       sdhci_enable_clk(host, clk);
> > +
> > +     if (mmc_card_uhs2(host->mmc))
> > +             sdhci_gl9767_uhs2_phy_reset_deassert(host);
> > +
> >       gl9767_set_low_power_negotiation(pdev, true);
> >  }
> >
> > @@ -1476,7 +1545,7 @@ static void sdhci_gl9767_set_power(struct sdhci_h=
ost *host, unsigned char mode,
> >               gl9767_vhs_read(pdev);
> >
> >               sdhci_gli_overcurrent_event_enable(host, false);
> > -             sdhci_uhs2_set_power(host, mode, vdd);
> > +             __gl9767_uhs2_set_power(host, mode, vdd);
> >               sdhci_gli_overcurrent_event_enable(host, true);
> >       } else {
> >               gl9767_vhs_write(pdev);
>

Best regards,
Ben Chuang

