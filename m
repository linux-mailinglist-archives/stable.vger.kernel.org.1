Return-Path: <stable+bounces-176950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED2B3F937
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6601738FF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE92E8DE8;
	Tue,  2 Sep 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9XVYizC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F112E6CBD;
	Tue,  2 Sep 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803312; cv=none; b=NudrapEVmRC1WcRGEaHyCNZctSCJc0fAtQIXfQ1Pg4m10zq18YS6RdggaKPhpo6GJfWBXDQCmBQFUfBsdx2GWMlzKQ6JynfTuIhyCuNP/xZw4BVPbwg98ZSmJoRxHjk9fsido+3jbL+2iebzjE2ddx+E0g0hYY1PD/5oJVtIjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803312; c=relaxed/simple;
	bh=5k/F3GPvPJX/h98yra+MrJUBJRlqT1io0eiOVQiksfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arWQ05CaxYmaf8WJvwWW2TvAnevbT2e6sOvObcI5fgGPCMzxf7HpdmWrw6TbozE89xOVQ98eDTnjI9SVIj4AwbBLyDK2Y8vM9Fk+bIF1JjDxgap5+p9rBhXY1y9KGg+w1JfObN8cGJTdErqqpGKiW/iCUBejKlOxTt/QV1V8xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9XVYizC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61ebe5204c2so564867a12.3;
        Tue, 02 Sep 2025 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756803309; x=1757408109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4noW5v40fzmkdqqWK0thv5nhPzuPsgfgyez5/OdeZUY=;
        b=R9XVYizCRnDm4plL8AYPaiaT4GrzSha3N2VtiHOBhvShkMhrefRG5hre/hrqeFGa3l
         s1jPTApYPUbsV6LXebo0rqeEHXllH5X8J/k1hHtZQByP+ljrIoQ2/Eft4ORQkptT6eXa
         vqvSZOt+ypiODSBeU9K7UYBdh3bsAPU33+kcQeBBi2ojw7wnpUunj6AEs/KTR8TO2MrQ
         Bs25kgXKpDufcK0AavRZiAP8FfO08TQMLF+tXDO8OSiyAPV6slwp83NT9qH0Q9jasX81
         ZsGb+iD5wnhxpbvgjJyBRGJPRF45dbUtTLUXRFj/m6fykf9mysybD0OxjPOtCau34dz1
         Wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803309; x=1757408109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4noW5v40fzmkdqqWK0thv5nhPzuPsgfgyez5/OdeZUY=;
        b=WkO7E6L884nawYi7nNT4RI4FZa01vwrSJPvb3kiHVwv3Si0PC30b5IDXysZzAfa8Mm
         FcRQHOHysTanYU0yUMNAw7ntXhk1DIYMzadOcUYRrjb3+h1neqHs+moyW8N8j0LQZ0uV
         J1coTF/xZ/lkLWxonr7djL08HiMa6BwK24cRCdXLZ/FJW6HgA6NUkZLojDfEI7I/iiak
         8EJ8GmnMdeEwELurNLUWDhxixrydHwan1Yn8RkYJRb6WPSXaQfeHZwuv2kN9HIwScvKF
         r51apdHeGwd/d+SgkfkwaTa+6SH2Zz7pFM5RUssywcsUh8q7Zb7rThp9KFYSwPovuKH9
         ANbA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Evbedo3W1XtWFkjqImeysolBf0yEU9pPkFtz471rt12s5AxJQcw2WGDuXbYdwqq3kdoRsh13/UQA@vger.kernel.org, AJvYcCVeSeJaEuiEBkXmIVP6ImTUzPO3SjXQONDQQbu8Qf0wXv41K/St5uI31ZAOtv8c8DtPSkPZM166@vger.kernel.org, AJvYcCXHrfNGAtN7Sfslu7BB9TmHF9/pUkxL7bY3mXpsPEw9LesgHc7lBidWqkvB4ISk/slfzEhJUC0Hm+CDR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5Sv1yuO1ZgcCNpGWlXB3nPmISCfBlx2S4Ra1U+kDNirUVsWK
	htCYTtchO93FW4WflPvwb+hkH0WMiQo/xGCA8wl/CzMzle8N1lsM/9n4yFa4/gDFcVDLHGeC+oZ
	b8cgRQZxg/DRMdzy1nLcvsNWMQXJgPPo=
X-Gm-Gg: ASbGnctmoyxWJ5sQMy5F0DPqp+lWZVeSMaFHmkq3sl/Ocucq8WoYyFoy29FU9Mouxkv
	J2SEP21X+Kkg61G6UKKbj7OtCX3cWhVeQ9I+jVxrK6ILufCrMWX5IBue5k71TB0UOYJt2PeWqDt
	ZFiP03Mqm9Tm4Dok2LwRRSt5WHtAfGsD/+agxBFRgcLLFEvMvL3CKcD4iPwc+XaaQfe2HZYJ9VJ
	p5re50=
X-Google-Smtp-Source: AGHT+IEMNgWHyzQz1NhFH2UsT7O+2jBqajcT4rLQWra0eWkr3tuGdVU4vUPZTwzS9quq/e7QnsxH1t4pZPesyZCezmw=
X-Received: by 2002:a05:6402:27cb:b0:61c:5b94:c725 with SMTP id
 4fb4d7f45d1cf-61d26873cf1mr9301026a12.8.1756803308846; Tue, 02 Sep 2025
 01:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901094224.3920-1-benchuanggli@gmail.com> <18915c80-84c3-4a61-a5d2-d40387ec4eb7@intel.com>
 <CACT4zj9n9E45E2T84ciLTEZgUAbcOzH5+ZgTYq8=m=Pusy37iA@mail.gmail.com>
 <CACT4zj-_NHV0td1RULmww4tvw3beJZASNv3+e5TG8wE318wvGg@mail.gmail.com> <6113c4e9-9141-49bf-9672-0203c5cdbf88@intel.com>
In-Reply-To: <6113c4e9-9141-49bf-9672-0203c5cdbf88@intel.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Tue, 2 Sep 2025 16:54:56 +0800
X-Gm-Features: Ac12FXxiPTUJDQyQvLhLYcX6NDlb0XNIUZcT9xXCLHdDiQSyQkyvKZyOXwQU4v8
Message-ID: <CACT4zj-4A9Lkx2EJY9xtPr5R0oQYjkfN4acQp8=xk0nFgc+Z-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix initializing the
 UHS-II interface during a power-on
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:47=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 02/09/2025 10:12, Ben Chuang wrote:
> > On Tue, Sep 2, 2025 at 2:33=E2=80=AFPM Ben Chuang <benchuanggli@gmail.c=
om> wrote:
> >>
> >> On Tue, Sep 2, 2025 at 1:02=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>>
> >>> On 01/09/2025 12:42, Ben Chuang wrote:
> >>>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>
> >>>> According to the power structure of IC hardware design for UHS-II
> >>>> interface, reset control and timing must be added to the initializat=
ion
> >>>> process of powering on the UHS-II interface.
> >>>>
> >>>> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9=
767")
> >>>> Cc: stable@vger.kernel.org # v6.13+
> >>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci-pci-gli.c | 71 +++++++++++++++++++++++++++++=
++-
> >>>>  1 file changed, 70 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdh=
ci-pci-gli.c
> >>>> index 3a1de477e9af..85d0d7e6169c 100644
> >>>> --- a/drivers/mmc/host/sdhci-pci-gli.c
> >>>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> >>>> @@ -283,6 +283,8 @@
> >>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_VALUE     0xb
> >>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL       BIT(6)
> >>>>  #define   PCIE_GLI_9767_UHS2_CTL2_ZC_CTL_VALUE         0x1
> >>>> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN   BIT(13)
> >>>> +#define   PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE BIT(14)
> >>>>
> >>>>  #define GLI_MAX_TUNING_LOOP 40
> >>>>
> >>>> @@ -1179,6 +1181,69 @@ static void gl9767_set_low_power_negotiation(=
struct pci_dev *pdev, bool enable)
> >>>>       gl9767_vhs_read(pdev);
> >>>>  }
> >>>>
> >>>> +static void sdhci_gl9767_uhs2_phy_reset_assert(struct sdhci_host *h=
ost)
> >>>> +{
> >>>> +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >>>> +     struct pci_dev *pdev =3D slot->chip->pdev;
> >>>> +     u32 value;
> >>>> +
> >>>> +     gl9767_vhs_write(pdev);
> >>>> +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> >>>> +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>> +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>> +     gl9767_vhs_read(pdev);
> >>>> +}
> >>>> +
> >>>> +static void sdhci_gl9767_uhs2_phy_reset_deassert(struct sdhci_host =
*host)
> >>>> +{
> >>>> +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >>>> +     struct pci_dev *pdev =3D slot->chip->pdev;
> >>>> +     u32 value;
> >>>> +
> >>>> +     gl9767_vhs_write(pdev);
> >>>> +     pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> >>>> +     value |=3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >>>
> >>> Maybe add a small comment about PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_=
VALUE
> >>> and PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN being updated separately=
.
> >>>
> >>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>> +     value &=3D ~PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >>>> +     pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>> +     gl9767_vhs_read(pdev);
> >>>> +}
> >>>
> >>> sdhci_gl9767_uhs2_phy_reset_assert() and sdhci_gl9767_uhs2_phy_reset_=
deassert()
> >>> are fairly similar.  Maybe consider:
> >>>
> >>> static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool=
 assert)
> >>> {
> >>>         struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >>>         struct pci_dev *pdev =3D slot->chip->pdev;
> >>>         u32 value, set, clr;
> >>>
> >>>         if (assert) {
> >>>                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >>>                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >>>         } else {
> >>>                 set =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_RESETN_VALUE;
> >>>                 clr =3D PCIE_GLI_9767_UHS2_CTL2_FORCE_PHY_RESETN;
> >>>         }
> >>>
> >>>         gl9767_vhs_write(pdev);
> >>>         pci_read_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, &value);
> >>>         value |=3D set;
> >>>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>         value &=3D ~clr;
> >>>         pci_write_config_dword(pdev, PCIE_GLI_9767_UHS2_CTL2, value);
> >>>         gl9767_vhs_read(pdev);
> >>> }
> >>>
> >>
> >> OK, I will update it. Thank you.
> >>
> >>>
> >>>> +
> >>>> +static void __gl9767_uhs2_set_power(struct sdhci_host *host, unsign=
ed char mode, unsigned short vdd)
> >>>> +{
> >>>> +     u8 pwr =3D 0;
> >>>> +
> >>>> +     if (mode !=3D MMC_POWER_OFF) {
> >>>> +             pwr =3D sdhci_get_vdd_value(vdd);
> >>>> +             if (!pwr)
> >>>> +                     WARN(1, "%s: Invalid vdd %#x\n",
> >>>> +                          mmc_hostname(host->mmc), vdd);
> >>>> +             pwr |=3D SDHCI_VDD2_POWER_180;
> >>>> +     }
> >>>> +
> >>>> +     if (host->pwr =3D=3D pwr)
> >>>> +             return;
> >>>> +
> >>>> +     host->pwr =3D pwr;
> >>>> +
> >>>> +     if (pwr =3D=3D 0) {
> >>>> +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >>>> +     } else {
> >>>> +             sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> >>>> +
> >>>> +             pwr |=3D SDHCI_POWER_ON;
> >>>> +             sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> >>>> +             mdelay(5);
> >>>
> >>> Can be mmc_delay(5)
> >>>
> >>>> +
> >>>> +             sdhci_gl9767_uhs2_phy_reset_assert(host);
> >>>> +             pwr |=3D SDHCI_VDD2_POWER_ON;
> >>>> +             sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> >>>> +             mdelay(5);
> >>>
> >>> Can be mmc_delay(5)
> >>
> >> I may not modify it now.
> >> mmc_delay() is in "drivers/mmc/core/core.h".
> >> If sdhci-pci-gli.c only includes "../core/core.h", the compiler will
> >> report some errors.
> >
> > Ah, just add another headersand it will build.
> >
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/mmc/host.h>
> > +#include "../core/core.h"
> >  #include "sdhci.h"
> >  #include "sdhci-cqhci.h"
> >  #include "sdhci-pci.h"
> > @@ -968,10 +970,10 @@ static void gl9755_set_power(struct sdhci_host
> > *host, unsigned char mode,
> >
> >                 sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> >                 /* wait stable */
> > -               mdelay(5);
> > +               mmc_delay(5);
> >                 sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> >                 /* wait stable */
> > -               mdelay(5);
> > +               mmc_delay(5);
> >                 sdhci_gli_overcurrent_event_enable(host, true);
> >         }
>
> It seems mmc_delay() is for core mmc code only, not host drivers.
> But the issue with mdelay is that it does not sleep.  Other options
> are msleep() or usleep_range().
>

Ok, I will use usleep_range() instead of mdelay().
Thanks for the suggestion.

Best regards,
Ben Chuang

