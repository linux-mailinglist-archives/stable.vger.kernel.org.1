Return-Path: <stable+bounces-185752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1BBDCA6B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF07042220C
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726083019DF;
	Wed, 15 Oct 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1whw52b"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8127A477
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508211; cv=none; b=Ryzq9YoUuFVR/q8u5irvDA9y3r89Vt9vcWDQYQKStU+hmhlc3kAnJccCXjjc/qbcW3ahisywdtFYuNZvWnrGPMDkzGW4Wfh96jX/v73mUp5VVrB1I26vtRZuCMt+KmdMC8mQ+lXjsiFgpSbLv46tEbsTT2HOhVIiAdnIwjpg1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508211; c=relaxed/simple;
	bh=jNoDGwfpzpVVSjrYNRU4l9Z3f0423H9BvWzg1OZsMN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sniyRYGxajrcGb0XhcyUMbA41V7E6sGiH99sMfxtQO9eONyQc5RH4MESOzmA/8ecityTnhLz8o2o2jkvciyLR6Lvoiiu30axAg57wgZU+al4ZgTkaSFsTqjCJ4QhkC7PxoFhr5f0WPNq1WOMK1NcDiJWvJdukLXYrGWSDaovUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1whw52b; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-87db3aa478fso665878385a.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760508208; x=1761113008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pie7fZGvPev2eUvrmRxtLn5uwIJ2jK2TyEzOvGquVLE=;
        b=U1whw52bPjCPWEDZwv9dXqgK5sgZZ0oPYtxNdZ2U6uJXGusJmaXCy7Rz9pEPdYv5Wu
         AnxD89BYWUpTZnA+jNg9BJxs6Ou6/nYxxvumMbqXk719U1UhO+dmln8emMO7PZq1T7pc
         WhS3YiAWKQxMjl3O6rkn1Pl/QxGFylXI+L1Jl0HxLOyr6wrOr9C9MrnC7LpP3DS24U0Z
         3r+YtPhUFVvnUl7bydVWL6kXoZu29n8VAYMkfOCLY3Rpk+zFL+0dyiD6l3XzVJMhn7ch
         Lkr6FzNfCo8BcLWUTWZXME2B2KEG2QcQUXLes1fPs1wAC0DWjtzCBGAdsK6kpMfsZ9VR
         /Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508208; x=1761113008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pie7fZGvPev2eUvrmRxtLn5uwIJ2jK2TyEzOvGquVLE=;
        b=jPB6+HSyjKnPsDn7/rvWGKds9yuP1dNe4XEDY6ngdxmWOtUzjgSJMYF7xRJFzrgcvf
         NVY/DWNCbwatrpGKy0z+uv82NNEvOWUeEOwwzPVRB5Brf8dRofMVr4QLXkEprX+MFJsk
         5pSddIE9H43clH7vLIeu8ecTUQWWcznrxtDrnpeT5eskowUWjgdgT+0czkmEn6D+JUjP
         CUhdaRDuL/F1WLAAzF/T5ZpKmXrbCiK4kWP2MeL3nkcwugUIPqgPB2lwZmp2F8aILxNR
         Hw9LsUHnfotbKBM+SJEjkL/7pvRk3rO8pVf5MRAvoOb9kFqbQh04z5qut56TEZi35uun
         6zQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0mr7mcKhcCP8OceZWzjrfhO36PQt4zG+mjniZeVWq8c0E0VRAzVNf9dlH9sbC1QR21D4sUco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxuTUhEK04GIXqrSiVNM7A/Znnr/d9DniI2X6KhOzV+dJ9T3bV
	5MpebSxHRNwwzmb4SxOryEiKOSPe5BOZyQoC7VAzpZPLZ4hHiODdHQHlT1FXcuoniusOB9b30zJ
	cL6MIbpfuBGTHRnpVtjx/ywkIkz7fff1c2XSt149j
X-Gm-Gg: ASbGncsjUpgVdmgRLvs6b4nnwqAFYwIUjQ8Q703d5Gol6W5J21uRgHTWqsEhFCShbFx
	OEXsph4FqiSIL3Hi/f9nqvDpw308GqzbEgclu5M6NLbQS4xNEHiy8zRJu12okaYhVX8NkepwJN/
	zYvWN7WPDo9+SH/p3zTRa4vZ8KErpgNLE8FpbrFZ7m1p6UY9t7G7DPQ2nI5CBmJwfGbEqeoX0n3
	427tpxKs3euTKNr+pUzmb89Boo78cgduBzEfpxZ8dHf
X-Google-Smtp-Source: AGHT+IH/PBuLyrEz5zQBYstCyOs7b50lPePZzd4TRKBU1/agPRdvbwqqn+6fzrnRarP8b13J3kggFAC8KtZoey/NOCU=
X-Received: by 2002:a05:622a:50a:b0:4e8:8a5e:6dc5 with SMTP id
 d75a77b69052e-4e88a5e70dfmr2436531cf.71.1760508207596; Tue, 14 Oct 2025
 23:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014004740.2775957-1-hramamurthy@google.com>
 <CANn89iKOK9GyjQ_s_eo5XNugHARSRoeeu2c1muhBj8oxYL6UEQ@mail.gmail.com> <willemdebruijn.kernel.37111d2d67443@gmail.com>
In-Reply-To: <willemdebruijn.kernel.37111d2d67443@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 23:03:15 -0700
X-Gm-Features: AS18NWDTQW4OvyuIYtm_vhiZuEvGwqArdUo3fhxdKCr-TBZKo8ZaexqzJu8EykU
Message-ID: <CANn89i+e8w0cA8+uE5QEUFY0fkQuwM7C5=8ULvRNaY2vh0YT4w@mail.gmail.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw timestamping
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, pkaligineedi@google.com, 
	jfraker@google.com, ziweixiao@google.com, thostet@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:19=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > On Mon, Oct 13, 2025 at 5:47=E2=80=AFPM Harshitha Ramamurthy
> > <hramamurthy@google.com> wrote:
> > >
> > > From: Tim Hostetler <thostet@google.com>
> > >
> > > The device returns a valid bit in the LSB of the low timestamp byte i=
n
> > > the completion descriptor that the driver should check before
> > > setting the SKB's hardware timestamp. If the timestamp is not valid, =
do not
> > > hardware timestamp the SKB.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX time=
stamping")
> > > Reviewed-by: Joshua Washington <joshwash@google.com>
> > > Signed-off-by: Tim Hostetler <thostet@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve.h          |  2 ++
> > >  drivers/net/ethernet/google/gve/gve_desc_dqo.h |  3 ++-
> > >  drivers/net/ethernet/google/gve/gve_rx_dqo.c   | 18 ++++++++++++----=
--
> > >  3 files changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethe=
rnet/google/gve/gve.h
> > > index bceaf9b05cb4..4cc6dcbfd367 100644
> > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > @@ -100,6 +100,8 @@
> > >   */
> > >  #define GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD 96
> > >
> > > +#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
> > > +
> > >  /* Each slot in the desc ring has a 1:1 mapping to a slot in the dat=
a ring */
> > >  struct gve_rx_desc_queue {
> > >         struct gve_rx_desc *desc_ring; /* the descriptor ring */
> > > diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers=
/net/ethernet/google/gve/gve_desc_dqo.h
> > > index d17da841b5a0..f7786b03c744 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> > > +++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
> > > @@ -236,7 +236,8 @@ struct gve_rx_compl_desc_dqo {
> > >
> > >         u8 status_error1;
> > >
> > > -       __le16 reserved5;
> > > +       u8 reserved5;
> > > +       u8 ts_sub_nsecs_low;
> > >         __le16 buf_id; /* Buffer ID which was sent on the buffer queu=
e. */
> > >
> > >         union {
> > > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/n=
et/ethernet/google/gve/gve_rx_dqo.c
> > > index 7380c2b7a2d8..02e25be8a50d 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > @@ -456,14 +456,20 @@ static void gve_rx_skb_hash(struct sk_buff *skb=
,
> > >   * Note that this means if the time delta between packet reception a=
nd the last
> > >   * clock read is greater than ~2 seconds, this will provide invalid =
results.
> > >   */
> > > -static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
> > > +static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx,
> > > +                               const struct gve_rx_compl_desc_dqo *d=
esc)
> > >  {
> > >         u64 last_read =3D READ_ONCE(rx->gve->last_sync_nic_counter);
> > >         struct sk_buff *skb =3D rx->ctx.skb_head;
> > > -       u32 low =3D (u32)last_read;
> > > -       s32 diff =3D hwts - low;
> > > -
> > > -       skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_read + diff=
);
> > > +       u32 ts, low;
> > > +       s32 diff;
> > > +
> > > +       if (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) {
> > > +               ts =3D le32_to_cpu(desc->ts);
> > > +               low =3D (u32)last_read;
> > > +               diff =3D ts - low;
> > > +               skb_hwtstamps(skb)->hwtstamp =3D ns_to_ktime(last_rea=
d + diff);
> > > +       }
> >
> > If (desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) can vary among
> > all packets received on this queue,
> > I will suggest you add an
> >
> >         else {
> >                  skb_hwtstamps(skb)->hwtstamp =3D 0;
> >         }
> >
> > This is because napi_reuse_skb() does not currently clear this field.
> >
> > So if a prior skb had hwtstamp set to a timestamp, then merged in GRO,
> > and recycled, we have the risk of reusing an old timestamp
> > if GVE_DQO_RX_HWTSTAMP_VALID is unset.
> >
> > We could also handle this generically, at the cost of one extra
> > instruction in the fast path.
>
> That would be safest. This may not be limited to GVE.

Yes, I started counting the bugs yesterday.

But considering this is going to be a patch that is separate and could
be missed in various old kernels,
I think a belt and suspender mode is safer :

Make sure each individual driver does not assume the field is zero
(or add a check about this assertion, which is going to be more
expensive anyway)

>
> NICs supporting line rate timestamping is not universal. Older devices
> predominantly aim to support low rate PTP messages AFAIK.
>
> On the Tx path there are known rate limits to the number of packets
> that some can timestamp, e.g., because of using PHY registers.
>
> On the Rx path packets are selected by filters such as
> HWTSTAMP_FILTER_PTP_V2_L2_SYNC. But its not guaranteed that these can
> be matched and timestamped at any rate? Essentially trusting that no
> more PTP packets arrive than the device can timestamp.
>
> e1000e_rx_hwtstamp is a good example. It has a descriptor bit whether
> a packet was timestamped, similar to GVE. And only supports a single
> outstanding request:
>
>         /* The Rx time stamp registers contain the time stamp.  No other
>          * received packet will be time stamped until the Rx time stamp
>          * registers are read.  Because only one packet can be time stamp=
ed
>          * at a time, the register values must belong to this packet and
>          * therefore none of the other additional attributes need to be
>          * compared.
>          */
>
> Perhaps not the best example as it does not use napi_reuse_skb. I
> thought of too late ;) But there are quite likely more.
>

I took a look at various uses in RX path in drivers/net/ethernet, I
found many bugs

drivers/net/ethernet/amd/xgbe/xgbe-drv.c:2374
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c:1098
drivers/net/ethernet/broadcom/tg3.c:6898
drivers/net/ethernet/cavium/liquidio/lio_core.c
drivers/net/ethernet/freescale/enetc/enetc.c
drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
drivers/net/ethernet/meta/fbnic/fbnic_txrx.c...

Then I stopped chasing.

I will send a fix in napi_reuse_skb()

diff --git a/net/core/gro.c b/net/core/gro.c
index 5ba4504cfd28ec26f487bfb96645e25c4845d720..76f9c3712422109ad00f15f6804=
abf6a8b00db43
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -639,6 +639,8 @@ EXPORT_SYMBOL(gro_receive_skb);

 static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 {
+       struct skb_shared_info *shinfo;
+
        if (unlikely(skb->pfmemalloc)) {
                consume_skb(skb);
                return;
@@ -655,8 +657,12 @@ static void napi_reuse_skb(struct napi_struct
*napi, struct sk_buff *skb)

        skb->encapsulation =3D 0;
        skb->ip_summed =3D CHECKSUM_NONE;
-       skb_shinfo(skb)->gso_type =3D 0;
-       skb_shinfo(skb)->gso_size =3D 0;
+
+       shinfo =3D skb_shinfo(skb);
+       shinfo->gso_type =3D 0;
+       shinfo->gso_size =3D 0;
+       shinfo->hwtstamps.hwtstamp =3D 0;
+
        if (unlikely(skb->slow_gro)) {
                skb_orphan(skb);
                skb_ext_reset(skb);

