Return-Path: <stable+bounces-240548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIRxDGfL6mk9DwAAu9opvQ
	(envelope-from <stable+bounces-240548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:46:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C4458E66
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22DE93017C05
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7867221FB6;
	Fri, 24 Apr 2026 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rY8SuGd3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509B22579E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995071; cv=pass; b=dzK+5ffPEQTF7Z+MH3JMNUD8bCIuORi7dwrSOAd9/MNLfhX24zxJTwsqzoQKb+2bagt9REJWkPYWmoEunLyN/WDie/tnlH5NfkjXLkjaj7jD7aqXSOhgLUUqL1SNwXOqD1bvYPQIfz+MCLFEdmhsXDXKexNTeQSiU72QZKjS2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995071; c=relaxed/simple;
	bh=tcVlOrjbcu3PtjIrZ7kxEKcgKoWLnFtXfcTmbStzT2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAJRhfRvFerTJBbTiCusEfLCJPKPPT3XHxEAxMXGQSt/gl9vhTu1iIJSxA85Qe0G2KQCjitrxS3M1cUMHX2Y9MklmprGLqiUU2tRn+lPtxE8JLY/JlEpQ6kNkwVEqzzFzLgsSNSIFrewjCAoUffuz/7T6CZslUay++aAxoi9cBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rY8SuGd3; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0afa0210bso33718275ad.2
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 18:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776995069; cv=none;
        d=google.com; s=arc-20240605;
        b=GvhH7V1f4ZSFTsCuMQpbQ+sqZPhZzv8Fm9cjn05p2F3n1pYXo/WVIyJw3h2+izsEQ7
         wVkauxoQufCWTSKU47Zd3QfZ6Rr+y6F/pPMhWwhJ65Ay/JJeQV8HwTz+7NiSDzVzmlg9
         iXVlVVR+umUeK+2qCl1pyjuWlY9ZO2DWiHk0X7uS3jaysAchp7gV1baFqj2hg9FAZ8/5
         YhzKX/T+RU/tqOjagkAEj+TyKcmEifR8FliOaNrjfOay553UsYtWF8/BJzEWi/pmFZrP
         JKI+wxFjkNuP+YwFqxKyfDoWmPPpgGFLdN2i663lDjBIsDqW8GE5lFu1hcuB+cswSrot
         Be3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        fh=iBDaQJei6kqdc2cJN0oWGh32+cFyYhNuE/HE/LqkQhQ=;
        b=gQMeMfHTVPLWDZlKXedscjTOzFpLz4muRExw4zeR0juVKL5p1xCvM9NhiAOAl6hobr
         HHE5ynRNr+4lglnk1K5QY1jvCp7hLN8pihh5QApznUntglWnonGVEV35xBySmLcoyRkR
         Agd/+iVoKuS8RawHEbgE2v2Yr1z96kuzL11RHUbeWnneqlc+csyM74uthzRgoOUypyMu
         yFcOXow/C3FfUL2l9JQjd+LFA96xT7Yzj4A+m+S8yIf33JaXPPTXf5WyrEI4WPaNQCfV
         7zoKL2P2p+GJg0kMhhWJaOwNcrHdtADJZfsPrxVBg1pZ2dnzprzMHkBjhwqmbTr99ZC9
         h68g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776995069; x=1777599869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        b=rY8SuGd325k9CSzX/TkJfr5DLKjuQMmvh+pRj9UfSlowdMkYeYw+pH7pLEryIzZ9CB
         OZj464heXmDjZS+fszfwGIbN901YIP2HHB6W2v7EuKzCGZesDKObttoQ4QhfyNjcDYv+
         gjswnyowiohbQHswLmv8iDFoSpJP6EcKcvrqY4zY/04/Oxulxvdf+UkoTy1mMbYeYM/X
         qAPGIKt8Q3sJwmvOtA7tYJqkT7d9c/YWPHZQAqBus7N3UawtbezTEJgCL5NhJd3j1T9C
         Vz/I+vmxYHVh8Vsjbof+juMWB2pngtK7PZiAAxZBVonzhNcJV6mHfTqOulh3dbcjExCs
         kxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776995069; x=1777599869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smpB6TlBZbFNQosajMhgVsLYPgcW/K3bWNylQA3ACNM=;
        b=jplZxbGYDQjn7ma4s4BVcerZZ6ujCpPR7K7QZdeepoHSvSUuBQVDJzRNMuf19hb7yo
         RVyKgcUK/f04m5oFAJh01Nv+FZ2z5fxj2Fadr2XdyIw4kH6a2zCehLFP1xpjWpQDo4Fc
         7UDlXjK8fcUlbc1rwtaznJ6CNi0FHkkmhhVf3ZfTme7tPnGhkQ5lS1UstcrWC/dSVEW8
         Yz1E70F/RPktPLThKnU2uw/LUjhowhSL04LkFH3JIiabfe5mwqrZ9ArSiIgROQU8O7sA
         5fOzvomNwHiORhrpyJlzXzkMT6tRWErnYXy235YNykYrCXatzRcurGCTmiVxRJsdRnVZ
         +U7A==
X-Forwarded-Encrypted: i=1; AFNElJ8jt022zMoif8dGbC28m3vPLhbO2xs1BeMmQ4EsNR0V7QvzwHMGF6dWX9ZZIGAz78VeF9xAoBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy936KAov4cBf9A6ALQbtV4SUJT/QwSdhtoXofbE4REiE8H2Gd3
	LaDTO0s8sfFreQ8sK3N49HH4XBz6HdS6QCcvu+Xx732K9SeST0mp7k2kSTCguuiTGsGGZbWiCS1
	jgUFpbvH7d313b9fLq3DM9FPn/QoZZ3GhrXdsH4nR
X-Gm-Gg: AeBDietYVbV12husCSHekynO7ugpR9Xu9FZU6QJ/CHq/THYiPjwy5PFl6JrmhrfhSGc
	QvgO9JJhwOlAJMw9sWfu6feGjBGFqNdRuQr/JbgPjIsHZBwmbCnnbyh/R7pAm83txCQufcmjL9p
	mxZf8dTKx0WmmYmE43i9ZDo3xvASvuXsBaeWV0h4un4iLhguMxkjaNUaP6QGg4qBsdE6Bnd9yhq
	aY+bAbXli0r0cXM2TRJtV77BYPVtEv8HZjbU2us5gRUDFXRlf9/j5eCrXakoc/z/Swpg0UIULBM
	lBTGXe7EbqOh70Vrh0enMIK4uDUEyFEbffGXJZcGno2o08hNxHoSewYeZLcjZs1C7VAQ
X-Received: by 2002:a17:903:2ecc:b0:2b4:5f67:5914 with SMTP id
 d9443c01a7336-2b5f9f65423mr347836855ad.33.1776995068684; Thu, 23 Apr 2026
 18:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-3-hramamurthy@google.com> <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
 <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
In-Reply-To: <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:44:17 -0700
X-Gm-Features: AQROBzDJZWR0M6oei0tA9R848FjEX9ScXZ6DuKnymGx1T2i8gxj3pkOEe9VuvG8
Message-ID: <CAHwYsiqW=bAusHgpZFnj0LrY_OT97y6oAJScvChq46uYXZPLdQ@mail.gmail.com>
Subject: Re: [PATCH net 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
To: Paolo Abeni <pabeni@redhat.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, maolson@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, shailend@google.com, jordanrhee@google.com, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 881C4458E66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240548-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 23, 2026 at 6:17=E2=80=AFPM Pin-yen Lin <treapking@google.com> =
wrote:
>
> Hi Paolo,
>
> On Thu, Apr 23, 2026 at 4:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > > From: Debarghya Kundu <debarghyak@google.com>
> > >
> > > gve_get_base_stats() sets all the stats to 0, so the stats go backwar=
ds
> > > when interface goes down or configuration is adjusted.
> > >
> > > Fix this by persisting baseline stats across interface down.
> > >
> > > This was discovered by drivers/net/stats.py selftest.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> > > Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> > > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > ---
> > >  drivers/net/ethernet/google/gve/gve.h      |  6 ++
> > >  drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++-=
--
> > >  2 files changed, 63 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethe=
rnet/google/gve/gve.h
> > > index cbdf3a842cfe..ff7797043908 100644
> > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > @@ -794,6 +794,10 @@ struct gve_ptp {
> > >       struct gve_priv *priv;
> > >  };
> > >
> > > +struct gve_ring_err_stats {
> > > +     u64 rx_alloc_fails;
> > > +};
> > > +
> > >  struct gve_priv {
> > >       struct net_device *dev;
> > >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > > @@ -882,6 +886,8 @@ struct gve_priv {
> > >       unsigned long service_task_flags;
> > >       unsigned long state_flags;
> > >
> > > +     struct gve_ring_err_stats base_ring_err_stats;
> > > +     struct rtnl_link_stats64 base_net_stats;
> > >       struct gve_stats_report *stats_report;
> > >       u64 stats_report_len;
> > >       dma_addr_t stats_report_bus; /* dma address for the stats repor=
t */
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 675382e9756c..8617782791e0 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> > >               return gve_tx_dqo(skb, dev);
> > >  }
> > >
> > > -static void gve_get_stats(struct net_device *dev, struct rtnl_link_s=
tats64 *s)
> > > +static void gve_add_base_stats(struct gve_priv *priv,
> > > +                            struct rtnl_link_stats64 *s)
> > > +{
> > > +     struct rtnl_link_stats64 *base_stats =3D &priv->base_net_stats;
> > > +
> > > +     s->rx_packets +=3D base_stats->rx_packets;
> > > +     s->rx_bytes +=3D base_stats->rx_bytes;
> > > +     s->rx_dropped +=3D base_stats->rx_dropped;
> > > +     s->tx_packets +=3D base_stats->tx_packets;
> > > +     s->tx_bytes +=3D base_stats->tx_bytes;
> > > +     s->tx_dropped +=3D base_stats->tx_dropped;
> > > +}
>
> Sashiko says:
>
> Can this result in torn reads on 32-bit architectures?
> The base_net_stats struct accumulates 64-bit network statistics in gve_cl=
ose()
> under rtnl_lock, but these stats are read here via ndo_get_stats64 which =
can
> execute concurrently without rtnl_lock.
> On 32-bit systems, a concurrent update might result in torn reads since 6=
4-bit
> memory reads are not atomic.
> Should u64_stats_sync sequence counters or atomic types be used here?
>
> We will add u64_stats_fetch_(begin|retry) to guard this in v2.
>
> > > +
> > > +static void gve_get_ring_stats(struct gve_priv *priv,
> > > +                            struct rtnl_link_stats64 *s)
> > >  {
> > > -     struct gve_priv *priv =3D netdev_priv(dev);
> > >       unsigned int start;
> > >       u64 packets, bytes;
> > >       int num_tx_queues;
> > > @@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev=
, struct rtnl_link_stats64 *s)
> > >       }
> > >  }
> > >
> > > +static void gve_get_stats(struct net_device *dev, struct rtnl_link_s=
tats64 *s)
> > > +{
> > > +     struct gve_priv *priv =3D netdev_priv(dev);
> > > +
> > > +     gve_get_ring_stats(priv, s);
> > > +     gve_add_base_stats(priv, s);
> > > +}
> > > +
> > >  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> > >  {
> > >       struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_r=
ules_cache;
> > > @@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *pr=
iv)
> > >       return gve_reset_recovery(priv, false);
> > >  }
> > >
> > > +static void gve_get_ring_err_stats(struct gve_priv *priv,
> > > +                                struct gve_ring_err_stats *err_stats=
)
> > > +{
> > > +     int ring;

Another Sashiko comment:

If the interface is brought down when ring memory allocation previously
failed, could priv->rx be NULL here?
Unlike gve_get_ring_stats(), there is no check for whether priv->rx is
allocated before dereferencing it.

This will also be fixed in v2.

> > > +
> > > +     for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) {
> > > +             unsigned int start;
> > > +             struct gve_rx_ring *rx =3D &priv->rx[ring];
> > > +
> > > +             do {
> > > +                     start =3D u64_stats_fetch_begin(&rx->statss);
> > > +                     err_stats->rx_alloc_fails +=3D
> > > +                             rx->rx_skb_alloc_fail + rx->rx_buf_allo=
c_fail;
> > > +             } while (u64_stats_fetch_retry(&rx->statss, start));
> >
> > Sashiko says:
> >
> > Could this loop improperly inflate the baseline metric by double counti=
ng?
> > If a concurrent update causes the sequence counter to change,
> > u64_stats_fetch_retry() forces the loop to restart. Because the additio=
n
> > is performed in-place on err_stats->rx_alloc_fails, the same ring's
> > error values will be added again.
> > Would it be safer to use local variables inside the retry loop and upda=
te
> > the global accumulator only after the loop completes successfully, simi=
lar
> > to the pattern established in gve_get_ring_stats()?
> >
> We'll fix this by using local variables in v2.
> >
> > > +     }
> > > +}
> > > +
> > >  static int gve_close(struct net_device *dev)
> > >  {
> > >       struct gve_priv *priv =3D netdev_priv(dev);
> > > @@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
> > >       if (err)
> > >               return err;
> > >
> > > +     /* Save ring queue and err stats before closing the interface *=
/
> > > +     gve_get_ring_stats(priv, &priv->base_net_stats);
> > > +     gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
> >
> > Sashiko says:
> >
> > Does this create a temporary spike in reported statistics?
> > During gve_close(), the active ring stats are added to base_net_stats.
> > However, priv->rx and priv->tx are not set to NULL until the memory
> > teardown completes in gve_queues_mem_remove().
> > If ndo_get_stats64 is called concurrently during this window, it will
> > add both the active ring stats and the newly updated base stats togethe=
r.
> > This causes the reported statistics to temporarily double until the
> > teardown finishes.
>
> As Sashiko mentioned, this is an existing concurrency issue between
> gve_close() and gve_get_stats() (i.e., .ndo_get_stats64() callback of
> gve driver):
>
> gve_queues_mem_remove(priv);
> This is a pre-existing issue, but can this lead to a use-after-free
> during concurrent stats retrieval?
> When gve_queues_mem_remove() frees the ring memory, priv->rx and
> priv->tx are not set to NULL until after the memory is freed. If
> gve_get_stats() executes during this window, it may iterate over and
> dereference the already freed ring memory.
>
> We will send out a separate patch to fix this.
>
> >
> > Note that you are expected to proactively comment/reply on the ML to th=
e
> > concerns raised by sashiko reviews.
>
> Thanks for the reminder.
>
> >
> > Thanks,
> >
> > Paolo
> >
>
> Regards,
> Pin-yen

Regards,
Pin-yen

