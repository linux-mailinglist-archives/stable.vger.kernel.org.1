Return-Path: <stable+bounces-194948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B70C63760
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E3B3AFBD9
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD8329E46;
	Mon, 17 Nov 2025 10:12:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA6328269
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374378; cv=none; b=Qwd247KcPLjctQ7pRzdcFWgGjX23Cwf3LB/mfS8i1UwpCN40EcUGCZ1piqw7MtQF+lCxaF10AP/y5cNKPn0ZShXpBNyqJFiHxllOdohcqCvKJqLQ9IKE4bZ4COTALjj3dj055yWeg04tyxE08HWdFUxkGUb0Prce6uo8YbkikRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374378; c=relaxed/simple;
	bh=GDOM+0gYiKkhyCkDjVnvHjHMXUKJ91og6WK5WoSGmVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvN22phyCC/zcSt7GODxBeioIrgmpS+1UXyB6qmBU5NqfHLTsCa7+FYbB6/aXvSn7BtIlBpimlD57BLWy1ahYSbv+pIGju7NEmuR3znARduZ9GM2PfmYeUcu79teR3zM0APMNME6jbiJbecrpGrra8P0s7DpZRqpvMeEKlDRa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso3061978137.0
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 02:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374375; x=1763979175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwmIm0bgwineetBBRefqzkv/ZlLUD6Hn/jhQ8fYgpUo=;
        b=wSHkcg7x/cwjXoTANWU4cR/lHqk0az/+vFMclkMua6knsMDxEewcWmuBUiie9nDl48
         UYUqSrE1YBPXBylpC4td0R9RhaZHrN8XNeehbLl8q1b9wnpGFayyaKtXCCxO7CbanZej
         RNfeZrAQNJXq0D7DwuuISTUe8C6v8muHfeoOjKmohY6SozBPwOmLPhoZO5a6oXPi2JMB
         MLg5m7nzS93b3YD4BPq3G12+LAJyuCz1Cv/OQ8RhwmzXZ0EJmq/CMpBvmSDVlUK+p493
         2FnfJ5qL1IozzA6YxROD3REsxVBkFIsFlGvZBHAp7tvM65qRN4xEw5LwPN6tW0KACia6
         zt2w==
X-Forwarded-Encrypted: i=1; AJvYcCUXl+WGzN6HmreRD5tcKv9R9cYGwUNAnKIuBRJ2V3NNA89ZRWTSnmEl8AZXYv8rL6YEKDr2xR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eqFJ3zp4A5nTM0Khxkusyd5tv1yBr8KVImPQbUm3a97K9Unf
	7Pgeb4nBKuaRem9oPd5UdJbaSh+czFTiAOjprzMgNzR51muNmNVUKYloQUT2l6/t
X-Gm-Gg: ASbGnctiVyT+07GRxK0bJRSFX7wYm0/6FNlwhKS+saGxL4T0v7aWWjOVYkILd8MrDct
	SQ3dwzacTsjWcHSc97+4+lV5tmnx+wVEHUdRbNCMb8cFF9MK6VenUQ95vZBDCdwixot/5gMTIa9
	EL4r5hkYQB3uziiv3mrzsxkPRQPM9DaoEmUoo3k+Hx0oMWMFIDzlfPmMWwDjw9DdVisMaZWKgOd
	IpfRccQoU9b9eaKicd+48lyZvGD6kJ4+7Gz5uZNIkX8sn2g0Hu53yTZHgNeHOGCjQwJW0hQikDM
	H3ec0mHHzpxK2qIr+uv9KPGeyT67ehQIzP4mN5AFH/8og5NNKtyW7N+FYTjoMTh96i13NRgiOD5
	eKs6x3DAvNt86MTy5O+WAxrhMWhWei/KySZwxJUNTafer1KtTHClRLA+ObL9urJZ6MEyIsqMm8a
	mI3TanROT8GjtuudUwWibp7fRjbYNgsnJu4jU6pBETHbulNHx0BZpE
X-Google-Smtp-Source: AGHT+IHk1Qa9G2Z7lrePlnWT1wJ5pGFgSY+pvTD3holNp21hg8nbt5uips6CajeZth2lfOGWNXR1Sw==
X-Received: by 2002:a05:6102:cc8:b0:5db:ce49:5c71 with SMTP id ada2fe7eead31-5dfc55b0bbfmr4302652137.18.1763374374661;
        Mon, 17 Nov 2025 02:12:54 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce60bsm3839055241.3.2025.11.17.02.12.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 02:12:54 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93722262839so2328326241.2
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 02:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZua6So6uqYnoSgxqhtjTI6BiKabNkCWVYC5bg6UK2POTCxhDWpVv+MCq5WyqPphlTLIjk4gM=@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:5db:32dc:f05b with SMTP id
 ada2fe7eead31-5dfc5bf1b06mr4258951137.42.1763374374287; Mon, 17 Nov 2025
 02:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Nov 2025 11:12:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
X-Gm-Features: AWmQ_blx-TSIXOAD1fL3P2E09fREtqUZGsBV4Ry1Ow-eJhOSBFBGV1F1fuwPF-E
Message-ID: <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, Tranh Ha <tranh.ha.xb@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sun, 16 Nov 2025 at 11:31, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Biju Das
> > > Sent: 12 November 2025 08:47
> > > On 30.10.2025 12:05:04, Biju wrote:
> > > > The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode
> > > > setting") applies to all SoCs except the RZ/G2L family of SoCs. As
> > > > per RZ/G2L hardware manual "Figure 28.16 CAN Setting Procedure after
> > > > the MCU is Reset" CAN mode needs to be set before channel reset. Add
> > > > the mode_before_ch_rst variable to struct rcar_canfd_hw_info to
> > > > handle this difference.
> > > >
> > > > The above commit also breaks CANFD functionality on RZ/G3E. Adapt
> > > > this change to RZ/G3E, as well as it works ok by following the
> > > > initialisation sequence of RZ/G2L.
> > > >
> > > > Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Applied to linux-can.
> >
> > There are 3 modes for CANFD on RZ/G3E
> >
> > 1) CAN-FD mode
> > 2) FD only mode
> > 3) Classical CAN only mode
> >
> > In the "FD only mode", the FDOE bit enables the reception and transmission of CAN-FD-only frames.
> > If enabled, communication in the Classical CAN frame format is disabled.
> >
> > On RZ/G2L, currently, CAN-FD mode is enabled by default and On RZ/G3E and R-Car Gen4, currently FD-
> > only mode is the default.
> >
> > Prior to commit 5cff263606a1010 ("can: rcar_canfd: Fix controller mode setting) RZ/G3E and R-Car Gen4
> > are using incorrect code for setting CAN-FD mode. But fortunately, it sets the mode as CAN-FD node, as
> > the channel reset was executed after setting the mode, that resets the registers to CAN-FD
> > mode.(Global reset, set mode, channel reset)
> >
> > The commit 5cff263606a1010 makes (Global reset, channel reset, set mode), now align with the flow
> > mentioned in the hardware manual for all SoCs except RZ/G2L.
> > But because of the earlier wrong code, it sets to FD-only mode instead of CAN-FD mode.
> >
> > Is it okay to drop this patch so I can send another patch to make CAN-FD mode as the default for
> > RZ/G3E and R-Car Gen4?
> >
> > As an enhancement, we need to define a device tree property to support FD-only mode for RZ/G2L, RZ/G3E
> > and R-Car Gen4. Please share your thoughts on this.

Hmm, Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml:

  renesas,no-can-fd:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The controller can operate in either CAN FD only mode (default) or
      Classical CAN only mode.  The mode is global to all channels.
      Specify this property to put the controller in Classical CAN only mode.

> The patch I posted "can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs" and
> commit 5cff263606a1010 ("can: rcar_canfd: Fix controller mode setting) is wrong for
> R-Car Gen3.
>
> R-Car Gen3 has only 2 modes: CAN-FD and Classical CAN (there is no FD-only mode).
> All other SoCs has 3 modes, CAN-FD, Classical CAN and FD-only mode
>
> R-Can Gen3, RZ/G2L (CAN-FD and Classical modes): Modify the RSCFDnCFDGRMCFG register only in global reset mode.
> (Here the flow is global reset, set mode, channel reset)
>
> Selection of FD-only mode for RZ/G2L: Modify the FDOE bit in RSCFDnCFDCmFDCFG only in channel reset
>
> RZ/G3E and R-Car Gen4: Modify the FDOE/CLOE bit in CFDCnFDCFG only in channel reset
>                       (Here flow is global reset, set mode, channel reset)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

