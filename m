Return-Path: <stable+bounces-3192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD97FE434
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 00:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3060D1C20C76
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39147A5E;
	Wed, 29 Nov 2023 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/zRtwo+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8410C0
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 15:41:07 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfd76c5f03so65695ad.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701301267; x=1701906067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAafIotfNLeEwiBYbu95S1M0tQmMdEiW9EUaH/ugkoU=;
        b=U/zRtwo+aQZrG+nwhUiUjVwBkM8E6E7anILz6pLZnjg3APyoMCqXtnjs3EjorKRqEG
         mq+DG/zr2BC83zA+M1FiFfb7nDYv4Y+ae1HlVdYrDp6B+eadXhrrqreb5twL3l4w402f
         ez4U71mypQC0n4seK/fW9eNEicCBJPlz+iOJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301267; x=1701906067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAafIotfNLeEwiBYbu95S1M0tQmMdEiW9EUaH/ugkoU=;
        b=WuGB5nZF/JPut2S8fRuSZ0j5omIRoHqo0rahCbSyQZ6BzhJqGdbtibLWZrXuzozAEg
         CF60J5bUqHGeC8URvuFx5CXeSwTHowtpoMGdQ9yfPAUMAXKIAfNzZU4ErddUgqEm6d2o
         FPEZW5lMDFZ6YgwfKNSbmz2EnZJA4Ei8zjLwiIL/tnChjkNc13SDl77jkT3xGHyZkJXH
         UHiqh0i6b6N9QKVehM0ChynGq23AmuKso09vvm85i3KzAncVHqNCb8MVTGP+Cf5YJL8m
         E5qmeBrSbjrHkWwpZ9D18E25OODjMu7Tz2mCuFUYP9Arc0litHMFiIpn3paqRCYr9D53
         mbZQ==
X-Gm-Message-State: AOJu0Yw+2PlpoKzffAySy9YivPFApQJdY0oLGJ3CjngKHbuz1SHnCDV0
	37BPFWjoIkcyQ9oZSr5PcNd2Hv0xzSKd2FwG78jKuQ==
X-Google-Smtp-Source: AGHT+IE1XSh+nbdNnRVKnLfSK/CPmIMOuq4e8h34HbM9E0oL/vYe5Unt0pVpjf63jESDwVXLVbmvwh3w0v7G4uQZ93o=
X-Received: by 2002:a17:903:5c5:b0:1cf:c366:9921 with SMTP id
 kf5-20020a17090305c500b001cfc3669921mr32999plb.9.1701301266715; Wed, 29 Nov
 2023 15:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129155350.5843-1-hau@realtek.com> <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
In-Reply-To: <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
From: Grant Grundler <grundler@chromium.org>
Date: Wed, 29 Nov 2023 15:40:50 -0800
Message-ID: <CANEJEGs9r0vq9QkGTcLryPnviMPgztJDsFjHqnRH65KbCqeF7g@mail.gmail.com>
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when suspended
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com, nic_swsd@realtek.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@chromium.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:05=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 11/29/2023 7:53 AM, ChunHao Lin wrote:
> > When FIFO reaches near full state, device will issue pause frame.
> > If pause slot is enabled(set to 1), in this time, device will issue
> > pause frame only once. But if pause slot is disabled(set to 0), device
> > will keep sending pause frames until FIFO reaches near empty state.
> >
> > When pause slot is disabled, if there is no one to handle receive
> > packets, device FIFO will reach near full state and keep sending
> > pause frames. That will impact entire local area network.
> >
> > This issue can be reproduced in Chromebox (not Chromebook) in
> > developer mode running a test image (and v5.10 kernel):
> > 1) ping -f $CHROMEBOX (from workstation on same local network)
> > 2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
> > 3) ping $ROUTER (wait until ping fails from workstation)
> >
> > Takes about ~20-30 seconds after step 2 for the local network to
> > stop working.
> >
> > Fix this issue by enabling pause slot to only send pause frame once
> > when FIFO reaches near full state.
> >
>
> Makes sense. Avoiding the spam is good.  The naming is a bit confusing
> but I guess that comes from realtek datasheet?

I don't know. It doesn't matter to me what it's called since I don't
have access to the data sheet anyway. :/

> > Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> > Reported-by: Grant Grundler <grundler@chromium.org>
> > Tested-by: Grant Grundler <grundler@chromium.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ChunHao Lin <hau@realtek.com>
> > ---
> > v2:
> > - update comment and title.
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 62cabeeb842a..bb787a52bc75 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -196,6 +196,7 @@ enum rtl_registers {
> >                                       /* No threshold before first PCI =
xfer */
> >  #define      RX_FIFO_THRESH                  (7 << RXCFG_FIFO_SHIFT)
> >  #define      RX_EARLY_OFF                    (1 << 11)
> > +#define      RX_PAUSE_SLOT_ON                (1 << 11)       /* 8125b =
and later */
>
> This confuses me though: RX_EARLY_OFF is (1 << 11) as well.. Is that
> from a different set of devices?

Yes, for a different HW version of the device.

> We're writing to the same register
> RxConfig here I think in both cases?

Yes. But to different versions of the HW which use this bit
differently. Ergo the comment about "8125b and later".

> Can you clarify if these are supposed to be the same bit?

Yes, they are the same bit - but different versions of HW use BIT(11)
differently.

>
> >  #define      RXCFG_DMA_SHIFT                 8
> >                                       /* Unlimited maximum PCI burst. *=
/
> >  #define      RX_DMA_BURST                    (7 << RXCFG_DMA_SHIFT)
> > @@ -2306,9 +2307,13 @@ static void rtl_init_rxcfg(struct rtl8169_privat=
e *tp)
> >       case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA=
_BURST | RX_EARLY_OFF);
> >               break;
> > -     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
> > +     case RTL_GIGA_MAC_VER_61:
> >               RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
> >               break;
>
> I assume there isn't a VER_62 between these?

Correct. My clue is this code near the top of this file:

 149         [RTL_GIGA_MAC_VER_61] =3D {"RTL8125A",            FIRMWARE_812=
5A_3},
 150         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
 151         [RTL_GIGA_MAC_VER_63] =3D {"RTL8125B",            FIRMWARE_812=
5B_2},

>
> > +     case RTL_GIGA_MAC_VER_63:
> > +             RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
> > +                     RX_PAUSE_SLOT_ON);
>
> We add RX_PAUSE_SLOT_ON now for RTL_GIGA_MAC_VER_63 in addition. Makes
> sense.

Exactly.

thanks for reviewing!

cheers,
grant

> > +             break;
> >       default:
> >               RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
> >               break;

