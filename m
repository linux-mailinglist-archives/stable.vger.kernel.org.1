Return-Path: <stable+bounces-185728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045CBDB370
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 22:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41BAF4F7869
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385530649D;
	Tue, 14 Oct 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e37GjW0q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E56305E08
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473160; cv=none; b=cxESHUpX5c2msNZ/onZSEL8OZbr/hKXGk92Xn6hF3snQdrSd7ulegpsXs5SStwcs+4epDJFzhMwuRv6eaPyc2kGBwJwpI8RDLFqH5AQ4RAqWsxiMLv9wCE67yOrzBkglBSWY3w4335VDEwowtaa7Sb3ualJ4vconkO7QCK3B71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473160; c=relaxed/simple;
	bh=s0JAPwQCeNUGqbXiAPfWCILaBU1LL0HgDD6g13LjeAM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XFR5Tppby+H2RNCR9xWN+f4Er5Ghpl76+GocDX3jdrKhmp5rKBI9puO4deiU/acnBJnWABXfxoIvyfjbnx2ybgjWOlxkSOOnzwyg6WOlMU39mSqPuyNHZWSPyd2/0idPuAOVRPp0ybbYLD5IuwlwOBbeCeimiNP6PRiNOR9nPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e37GjW0q; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-862cbf9e0c0so728184885a.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473157; x=1761077957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzdiCHYIj0Cjw5czi/OLW10sC7byu6chts+eoAZd97A=;
        b=e37GjW0qhUoLe4/ODld1XwNA36J4zBCG9BI3DXqp/Xrxr7rzpxzZeYu1ona+gZ8Yq8
         +ItcovZ+tdb2ACXV26/NPQC435tAIQXr/EJeHD2ZvJlmhZ7to9fvTT+EamdndFZzBNJp
         ZHMOulzO7hE8GHYYcWwC9dykOAEWU6Szbr5ROtKgQ9405NA173X9+iXvVZoci3x0PAkq
         YrtF5uHkhkDcbjJb6yCD8c6iXPc+/1uYT96ogbA7uzX+ST7xdoRDPbqn7s0UbclwHIcs
         Rx1guASJ1DTLmvC8t1e4dOpQK4z0u43zYKOjkSNGM/G5dK1vuPtw5/OTDKEgqHrOuP1o
         UY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473157; x=1761077957;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XzdiCHYIj0Cjw5czi/OLW10sC7byu6chts+eoAZd97A=;
        b=n1F27qcyaSw+YqZzy9ZI/DCxnTwnwoek1vJ3vU8K3LgOx0PUM+BRigj1pYRkI5AxtF
         mHU75IusVi3hoN68VZU9tJhMIRrCxxmnQv1xrRmxUSjVdUCVLYwvZiArrbA0x1OHNGUB
         Ew3hnDKO9RP11xKfAlrAC3fIqEAsjTky8jhX/Z3eGOF3EJv/RNeq4Gu78nF0kqmO671J
         7tepw6Bc2ouPKq5Q62q49tZr8N5xEIj3QcaS7o4HTQXCJU3rl6KJ/n1yc2mxv21K5kz1
         ZVXH0IPWKt/BpTF1k+2ODpfOSqL6Ts9P2dBMN1/qJC4QCPMjTvnGVmFCTSlPPX10Vg9n
         IYpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkBbMWfOXfXJvZrueWtoKi5N1bflN3vvcuoU3JA14mRG5IvNktpWJtyt5mBoMvK45QhatwDHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpu4k1K2rUNP7AuikJEjdhFb4c+fudOsY1BYYEePRRVnIVfPD
	tzf07e18OATim/l0WKSRm/It4fD9jhetumPvXLGj925GQGpRaH1X/Gpi
X-Gm-Gg: ASbGncvGheQSJ2qybD86fleh9dDTdyZuECbuo6nkbKkZzf9AZYeORzCESaM990VaOR3
	8RVvxUqIYj3ovhLu+o15G45fwYhw/mZHBzfXvPJTTXey8TMMrzGr5LwvtzfaJg017UZDpqRi8qu
	6zFpOMmwFD89VKNh3kz9HLo3e9yXm3tYCTmClx5mQtmYwwct5PZng8N2OaL6tKE+SbEf7hL9nB7
	YR9RLij3GiGeleZTur3hu+wQ96jgIHF1GFKy9y0Xyqk7bOdcTPA0WSuYSrdRtVlIu5RMzbeI5sQ
	r+hAnmDbEn/ZL5A//50R4uY/Jrg1LIAiOoP7vOwW/ny2bhGePTJCcFRL3g6zXTep0xFsrFNLMW8
	Q7GLH0x8sd5VsuuxCB+HRUB0RgrqteVr8anO1XSF3CV32Ovu6JJTqiiNWHtIFVvZ9sGmDO0tTCk
	GHmhqbpGDVkIvt7k7bYFSvcV4=
X-Google-Smtp-Source: AGHT+IG60iLHa2EMec/dE36AehmNsjVJtbZbTViDb8TsMFWdu0WsUPcrps5EfQNTLTL8ck1FgSdveQ==
X-Received: by 2002:a05:620a:1a83:b0:85e:3ab2:9627 with SMTP id af79cd13be357-88353b2a836mr3565355985a.60.1760473157034;
        Tue, 14 Oct 2025 13:19:17 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a2273e9dsm1260522285a.47.2025.10.14.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:19:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:19:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, 
 joshwash@google.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 pkaligineedi@google.com, 
 jfraker@google.com, 
 ziweixiao@google.com, 
 thostet@google.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.37111d2d67443@gmail.com>
In-Reply-To: <CANn89iKOK9GyjQ_s_eo5XNugHARSRoeeu2c1muhBj8oxYL6UEQ@mail.gmail.com>
References: <20251014004740.2775957-1-hramamurthy@google.com>
 <CANn89iKOK9GyjQ_s_eo5XNugHARSRoeeu2c1muhBj8oxYL6UEQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Oct 13, 2025 at 5:47=E2=80=AFPM Harshitha Ramamurthy
> <hramamurthy@google.com> wrote:
> >
> > From: Tim Hostetler <thostet@google.com>
> >
> > The device returns a valid bit in the LSB of the low timestamp byte i=
n
> > the completion descriptor that the driver should check before
> > setting the SKB's hardware timestamp. If the timestamp is not valid, =
do not
> > hardware timestamp the SKB.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX time=
stamping")
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Tim Hostetler <thostet@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h          |  2 ++
> >  drivers/net/ethernet/google/gve/gve_desc_dqo.h |  3 ++-
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c   | 18 ++++++++++++----=
--
> >  3 files changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethe=
rnet/google/gve/gve.h
> > index bceaf9b05cb4..4cc6dcbfd367 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -100,6 +100,8 @@
> >   */
> >  #define GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD 96
> >
> > +#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
> > +
> >  /* Each slot in the desc ring has a 1:1 mapping to a slot in the dat=
a ring */
> >  struct gve_rx_desc_queue {
> >         struct gve_rx_desc *desc_ring; /* the descriptor ring */
> > diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers=
/net/ethernet/google/gve/gve_desc_dqo.h
> > index d17da841b5a0..f7786b03c744 100644
> > --- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> > +++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> > @@ -236,7 +236,8 @@ struct gve_rx_compl_desc_dqo {
> >
> >         u8 status_error1;
> >
> > -       __le16 reserved5;
> > +       u8 reserved5;
> > +       u8 ts_sub_nsecs_low;
> >         __le16 buf_id; /* Buffer ID which was sent on the buffer queu=
e. */
> >
> >         union {
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/n=
et/ethernet/google/gve/gve_rx_dqo.c
> > index 7380c2b7a2d8..02e25be8a50d 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -456,14 +456,20 @@ static void gve_rx_skb_hash(struct sk_buff *skb=
,
> >   * Note that this means if the time delta between packet reception a=
nd the last
> >   * clock read is greater than ~2 seconds, this will provide invalid =
results.
> >   */
> > -static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
> > +static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
> > +                               const struct gve_rx_compl_desc_dqo *d=
esc)
> >  {
> >         u64 last_read =3D READ_ONCE(rx->gve->last_sync_nic_counter);
> >         struct sk_buff *skb =3D rx->ctx.skb_head;
> > -       u32 low =3D (u32)last_read;
> > -       s32 diff =3D hwts - low;
> > -
> > -       skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + diff=
);
> > +       u32 ts, low;
> > +       s32 diff;
> > +
> > +       if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
> > +               ts =3D le32_to_cpu(desc->ts);
> > +               low =3D (u32)last_read;
> > +               diff =3D ts - low;
> > +               skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_rea=
d + diff);
> > +       }
> =

> If (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) can vary among
> all packets received on this queue,
> I will suggest you add an
> =

>         else {
>                  skb_hwtstamps(skb)->hwtstamp =3D 0;
>         }
> =

> This is because napi_reuse_skb() does not currently clear this field.
> =

> So if a prior skb had hwtstamp set to a timestamp, then merged in GRO,
> and recycled, we have the risk of reusing an old timestamp
> if GVE_DQO_RX_HWTSTAMP_VALID is unset.
> =

> We could also handle this generically, at the cost of one extra
> instruction in the fast path.

That would be safest. This may not be limited to GVE.

NICs supporting line rate timestamping is not universal. Older devices
predominantly aim to support low rate PTP messages AFAIK.

On the Tx path there are known rate limits to the number of packets
that some can timestamp, e.g., because of using PHY registers.

On the Rx path packets are selected by filters such as
HWTSTAMP_FILTER_PTP_V2_L2_SYNC. But its not guaranteed that these can
be matched and timestamped at any rate? Essentially trusting that no
more PTP packets arrive than the device can timestamp.

e1000e_rx_hwtstamp is a good example. It has a descriptor bit whether
a packet was timestamped, similar to GVE. And only supports a single
outstanding request:

        /* The Rx time stamp registers contain the time stamp.  No other
         * received packet will be time stamped until the Rx time stamp
         * registers are read.  Because only one packet can be time stamp=
ed
         * at a time, the register values must belong to this packet and
         * therefore none of the other additional attributes need to be
         * compared.
         */

Perhaps not the best example as it does not use napi_reuse_skb. I
thought of too late ;) But there are quite likely more.
 =

> =

> >  }
> >
> >  static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_=
ring *rx)
> > @@ -919,7 +925,7 @@ static int gve_rx_complete_skb(struct gve_rx_ring=
 *rx, struct napi_struct *napi,
> >                 gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
> >
> >         if (rx->gve->ts_config.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
> > -               gve_rx_skb_hwtstamp(rx, le32_to_cpu(desc->ts));
> > +               gve_rx_skb_hwtstamp(rx, desc);
> >
> >         /* RSC packets must set gso_size otherwise the TCP stack will=
 complain
> >          * that packets are larger than MTU.
> > --
> > 2.51.0.740.g6adb054d12-goog
> >



