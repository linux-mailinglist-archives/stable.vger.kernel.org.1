Return-Path: <stable+bounces-109253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE0A1394A
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024E73A449D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F01DE3CA;
	Thu, 16 Jan 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ooq+sz3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2941DDC20
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027696; cv=none; b=TCv0nc1uzQeYK3FMdQg1NK9BpWsCbaoCZnfL9wVIFor9k+89kncCVc1aUU8WW77Lcz8HVY+PraplZicsv+Nh/HthFehWE5Zy2coj6/ZDWDl+zvIQNF+SvThVOkwu7SuGIjmErpLHzPursoIVXSyPeCX3X/l4CMulbF4tuK8vV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027696; c=relaxed/simple;
	bh=zAzvQkgyVrWT7h0H+w/wyN5QepOC/QzZ2EN0PbZeYXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN9/UTQKMdN8T+RqOET6qCY7AkdUkzQGHWctzUYaPgOrrJ7FXpxZj4S5Z1cc45Nrr8jp262OyO612UCTORdUaMA/B3jjYLH3J0AW+akhf0VcO7b2/2mHTyPFALcwHor9ZY9KQ0uo3RHTp80n5O+jOV3DpmcnaYaunQBB9dWTVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ooq+sz3H; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401af8544bso4112e87.1
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737027693; x=1737632493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ajRTt+sTCFa/yzDvj8sHUr1nS9xu5mD6luchoIVOyo=;
        b=Ooq+sz3HoGrjrgpXHIqPSUjS89L+Rsydmc47DI9xBMOi8B0aadDV3kshBR0k/FMdBm
         REA0q++4IY8fPJmdbL/LN3z3bitadELYWBYtbLleDTl3rwhlAK3OgnzS9qgRp6DUstGM
         v4Qawng02/bYnq8byLuD4UkYGnosbAQ+C2j0JyaMj7MzAKUkd3oH+/erc8f59vwoglGR
         LSoc3j0theZRw8YaKR2F5mC6sOzzTIEOh9ZOYOsu07stZ+hkQLFjts6d9SXBwqIwEUfH
         5xPZQOCt0PEcixRk8grBrtLn9YiUxH9mO2sMIDqClp8qasP1HQSMBH9IKLIvl9miHEBm
         MvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027693; x=1737632493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ajRTt+sTCFa/yzDvj8sHUr1nS9xu5mD6luchoIVOyo=;
        b=tbkg9NqrC+u+arf9I73z77AJtAs18ix9mHZSNyPlsiUKlNv+keJEwXYLt+6q/FyP1T
         su6J4Y1H9JO5/orOiJIkA5oKZdz1LtDcZXikDnUmjNlu+Eb+suPh5hMyK7faEMy7iDfO
         PGgySw1JoSe/5LWW1wpreh7/EOpmmrSq7CbgcxGTno0BmTbsXd57J5W8MUoVO+Ta9vQJ
         wu9GD4geJxp7NhMyQcy9NWxpUTJ1MsMTP0MG/BG8krixTnmw7lKDW7fqApJ17PkAE8Ac
         oN453qQdAE8I1MPJt4jtaYTQ0BdSYLx8/C8GH+zzDzgIMKrHT/tPxx5NTJMWfvKG1WIm
         NQHw==
X-Forwarded-Encrypted: i=1; AJvYcCUKep1I3nWEuhHQr4xxLmZNs/bq+K+U3LXw8QE+Rda8p0Mf6NVUAMgqFoa/daBkV1arKhpmU2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWq4Sj/sYfDsnmaFVaeaNtYLIIj1vNyL4XM9rwRdhQmgPdhzI
	CsWoagNbrZUMFkCVD4Z4Ei1Wtp4v5i+4ue/Is2+bNjkXNjKNnhTUCOLX27++GSAyEzmJ7CVHWRX
	bm24GfB+7023M6RxO0znUvMrz2DgC4ud0EfxM
X-Gm-Gg: ASbGnctcG9HPtj069LHSk1fGrqVztETUCbj2Eqz1IQeiq9AJ+dBwMB5N5FVEHyURJLD
	AwryG7bDi5veLNK5HWQkVcshSXwP+i/4VGRgSuJNSx1Xi3tTRP76OGdFQDM9cq613tLl5ggM=
X-Google-Smtp-Source: AGHT+IFP7WO7kDE2/46Cyx0Cg9OQ/0H9hXxKtWG6n9UrYOXfjmj+ZVQhyiloRgp5iy8m2aej53iHuMHB3u+ZMcWXnow=
X-Received: by 2002:a19:7002:0:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-542f46a3191mr131036e87.3.1737027693046; Thu, 16 Jan 2025
 03:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114142435.2093857-1-kyletso@google.com> <Z4jsp4J6AX0X-uwX@kuha.fi.intel.com>
In-Reply-To: <Z4jsp4J6AX0X-uwX@kuha.fi.intel.com>
From: Kyle Tso <kyletso@google.com>
Date: Thu, 16 Jan 2025 19:41:16 +0800
X-Gm-Features: AbW1kvaJ3ZYNqz0ChrdDMtHBrULy6UybRZ5KHQDoRRzRtFi3Fiw33c6yXzCEHYM
Message-ID: <CAGZ6i=3W-WsZ7Hz9T2wEYnFFMmFPpjgnrWQuHo=a_QJn8jzUOA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpci: Prevent Sink disconnection before
 vPpsShutdown in SPR PPS
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, andre.draszik@linaro.org, rdbabiera@google.com, 
	m.felsch@pengutronix.de, xu.yang_2@nxp.com, u.kleine-koenig@baylibre.com, 
	emanuele.ghidoli@toradex.com, badhri@google.com, amitsd@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 7:25=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Jan 14, 2025 at 10:24:35PM +0800, Kyle Tso wrote:
> > The Source can drop its output voltage to the minimum of the requested
> > PPS APDO voltage range when it is in Current Limit Mode. If this voltag=
e
> > falls within the range of vPpsShutdown, the Source initiates a Hard
> > Reset and discharges Vbus. However, currently the Sink may disconnect
> > before the voltage reaches vPpsShutdown, leading to unexpected behavior=
.
> >
> > Prevent premature disconnection by setting the Sink's disconnect
> > threshold to the minimum vPpsShutdown value. Additionally, consider the
> > voltage drop due to IR drop when calculating the appropriate threshold.
> > This ensures a robust and reliable interaction between the Source and
> > Sink during SPR PPS Current Limit Mode operation.
> >
> > Fixes: 4288debeaa4e ("usb: typec: tcpci: Fix up sink disconnect thresho=
lds for PD")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kyle Tso <kyletso@google.com>
>
> You've resend this, right? So is this v2 (or v1)?
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>

Hello Heikki,

Thank you for the review.

Apologies for the resend. This is indeed the v1 patch. The previous
email was accidentally sent with an incomplete recipient list.

Thanks,
Kyle

> > ---
> >  drivers/usb/typec/tcpm/tcpci.c | 13 +++++++++----
> >  drivers/usb/typec/tcpm/tcpm.c  |  8 +++++---
> >  include/linux/usb/tcpm.h       |  3 ++-
> >  3 files changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tc=
pci.c
> > index 48762508cc86..19ab6647af70 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.c
> > +++ b/drivers/usb/typec/tcpm/tcpci.c
> > @@ -27,6 +27,7 @@
> >  #define      VPPS_NEW_MIN_PERCENT                    95
> >  #define      VPPS_VALID_MIN_MV                       100
> >  #define      VSINKDISCONNECT_PD_MIN_PERCENT          90
> > +#define      VPPS_SHUTDOWN_MIN_PERCENT               85
> >
> >  struct tcpci {
> >       struct device *dev;
> > @@ -366,7 +367,8 @@ static int tcpci_enable_auto_vbus_discharge(struct =
tcpc_dev *dev, bool enable)
> >  }
> >
> >  static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *de=
v, enum typec_pwr_opmode mode,
> > -                                                bool pps_active, u32 r=
equested_vbus_voltage_mv)
> > +                                                bool pps_active, u32 r=
equested_vbus_voltage_mv,
> > +                                                u32 apdo_min_voltage_m=
v)
> >  {
> >       struct tcpci *tcpci =3D tcpc_to_tcpci(dev);
> >       unsigned int pwr_ctrl, threshold =3D 0;
> > @@ -388,9 +390,12 @@ static int tcpci_set_auto_vbus_discharge_threshold=
(struct tcpc_dev *dev, enum ty
> >               threshold =3D AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
> >       } else if (mode =3D=3D TYPEC_PWR_MODE_PD) {
> >               if (pps_active)
> > -                     threshold =3D ((VPPS_NEW_MIN_PERCENT * requested_=
vbus_voltage_mv / 100) -
> > -                                  VSINKPD_MIN_IR_DROP_MV - VPPS_VALID_=
MIN_MV) *
> > -                                  VSINKDISCONNECT_PD_MIN_PERCENT / 100=
;
> > +                     /*
> > +                      * To prevent disconnect when the source is in Cu=
rrent Limit Mode.
> > +                      * Set the threshold to the lowest possible volta=
ge vPpsShutdown (min)
> > +                      */
> > +                     threshold =3D VPPS_SHUTDOWN_MIN_PERCENT * apdo_mi=
n_voltage_mv / 100 -
> > +                                 VSINKPD_MIN_IR_DROP_MV;
> >               else
> >                       threshold =3D ((VSRC_NEW_MIN_PERCENT * requested_=
vbus_voltage_mv / 100) -
> >                                    VSINKPD_MIN_IR_DROP_MV - VSRC_VALID_=
MIN_MV) *
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 460dbde9fe22..e4b85a09c3ae 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2973,10 +2973,12 @@ static int tcpm_set_auto_vbus_discharge_thresho=
ld(struct tcpm_port *port,
> >               return 0;
> >
> >       ret =3D port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc,=
 mode, pps_active,
> > -                                                         requested_vbu=
s_voltage);
> > +                                                         requested_vbu=
s_voltage,
> > +                                                         port->pps_dat=
a.min_volt);
> >       tcpm_log_force(port,
> > -                    "set_auto_vbus_discharge_threshold mode:%d pps_act=
ive:%c vbus:%u ret:%d",
> > -                    mode, pps_active ? 'y' : 'n', requested_vbus_volta=
ge, ret);
> > +                    "set_auto_vbus_discharge_threshold mode:%d pps_act=
ive:%c vbus:%u pps_apdo_min_volt:%u ret:%d",
> > +                    mode, pps_active ? 'y' : 'n', requested_vbus_volta=
ge,
> > +                    port->pps_data.min_volt, ret);
> >
> >       return ret;
> >  }
> > diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> > index 061da9546a81..b22e659f81ba 100644
> > --- a/include/linux/usb/tcpm.h
> > +++ b/include/linux/usb/tcpm.h
> > @@ -163,7 +163,8 @@ struct tcpc_dev {
> >       void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
> >       int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enab=
le);
> >       int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, en=
um typec_pwr_opmode mode,
> > -                                              bool pps_active, u32 req=
uested_vbus_voltage);
> > +                                              bool pps_active, u32 req=
uested_vbus_voltage,
> > +                                              u32 pps_apdo_min_voltage=
);
> >       bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
> >       void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool e=
nable);
> >       void (*check_contaminant)(struct tcpc_dev *dev);
> > --
> > 2.47.1.688.g23fc6f90ad-goog
>
> --
> heikki

