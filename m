Return-Path: <stable+bounces-240545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKf/LMDE6mnfDQAAu9opvQ
	(envelope-from <stable+bounces-240545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9AE458AD3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFD2E3004D29
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF194221FB6;
	Fri, 24 Apr 2026 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL2ehKha"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0D17A586
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993466; cv=pass; b=nTDWrLfjD1/mvzUvZkHhfXsPFgXoDdMmauahKhdgDrdS9Jq7CAVH8lzpADQBf5VRlvswBa/5d8Gvqqa0JvyqOn00kf2LnnUOhOH7hpJUkcLEFi3mxCVYq8H4rbt5k4BzrZI1qoijUveT6ljUY54GZosm/3/D5D2q7/7rkHHdAls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993466; c=relaxed/simple;
	bh=BftoHye19UwN5wPCxtq1p2W/P8kKhpfmToVh3f55XT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdTfZCmqit62uwhQ/bXhG+SEBPTUSw7hbWVU4kympn8h03NuNCw++CHvCeb+1DXc/CAM3N1GWYwfnEd8KK5y9Y0Dm6VgywdzJwBmFEFKTEFKz2N/GNff4Pe0DoyOwdJZtz2WANw2Lnlv/OR4aEJH0ZPjqcuK9Esbfm5VqDjj0Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL2ehKha; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso5836998a91.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 18:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776993464; cv=none;
        d=google.com; s=arc-20240605;
        b=DDirZHn0OadSS76y1+UbNnSN3iUCTlQLwBMMyaoBF/TMHLUlD2EI57Z4iegBn8A7VQ
         RTpeIwfacwkdrmAr0gWuSksWAg2FK9a41V6vypc6aUb+jFVOJDhTrNJVEzJP12yeTcXe
         G/3zjACbJ5cDPdSBOtwKTT1lIHArK7D4ynno5TNoMsFYX8TU4xgmTCBpMvkryGAvnusk
         tuo0rQBK4z9HHZF+tslWSNOd/0Em2w/La6hbkqBpO88XurmNExHgAeT1QPLvHb/E+uud
         4MXpg3O5sSaD40sobohzccwAAnbotd2xyvYfE9eJDu6toqatxyctPHQplyZbotSRFMcg
         FmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        fh=BGQj/NIFupdPshImF3MzwuI/Vj0nbdQlEJhlnDz7plI=;
        b=jz6q+bWuhCqMsdrDSZ5zk1txNFcohK/nnbGC0vh1oIpIz9KjvlUwFfUR8ehVUZ8MYy
         ex+yffrXnk1/3kVMieflBlhGDUvy7lWIG/FEQIo6lzuf1g9DkIeWncmX1VrDOYZych3D
         LT8/FT6L7SduULnxAn2f/cM9NLNrZloNPSUDBiZoDLvIJlvvPh1yZ8CEb9k+CZcRMP/m
         KNf9M9o3U49w9/+ZNm6SJd14/0au6i9CdYc6XqBFQ8bGbUeCQtoQkUKQcgX8Y8kxfkXs
         BozMn3ma9/NCHwEN//guoTYO/Et5UdWcLorzCdRECHXwmWpra3X1IBuWPLr2T3nhyk82
         hKHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776993464; x=1777598264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        b=YL2ehKhakR8hNDfU76MMFSrKoXbd7KueCelwoWuH+iovB9uhMYIozf3GB18HotRbEV
         WyAer8/OYMBbS31adhTzvlnjRSlwqd+4a+XyigfRo1UqZBYT/f/MfE8vUspngagpuURs
         WSFfcRqIgheC26v2L2rn+8naJ9HefDcQKL4We4XWL26kMZL/JQW6AH02h3YIp4WrBfJL
         SpXXQNC3vsXZgfJuHOvZqJEpc2WWN30pwf6PsD8oanwpsTVCMgrypeA2J3XOvxGRgNNr
         1sYwC/K8UevqOSXeeaf0vqdY1IV5mWDeYcuH+c4hIqTmiC/z6EGDCALAQ7k2m3IyJDXF
         qVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993464; x=1777598264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbrbRZqlZjolBdHvcSYKsDX1RWcNQSuhFtRf5Cy8y7Q=;
        b=GSiLw5TOJTkr71WDg5cDERpa/2kfgNt1ZgHUmJjnmnRcdwV2iSjH6MXgagNTUkRknQ
         gAzqiLvz4G6RFfyH7N0roGXfO0TJ2bTsUI/yALD2HjfIQ6naHG6Tq4b+JLjw4fCkkDiW
         8qHhKCWOLMLG0cFb0pH0nqwbaCVYS/sXEI4rdu2UG4oD7EPd/fCANTaPQsXR/0v48iKD
         nOGqzwR9vEudYQu6dRRF8CA2HQkuDjoBSe3rM36sPkcDWiFuwhKOsnFkQzFvZJ/tzyYq
         73BTea2UaDpHEFqy9v88mgRp1IjwaYh0G93LUTzsNAbnB4d0ogqSDWmkTG4pqwaiuysp
         1GSg==
X-Forwarded-Encrypted: i=1; AFNElJ+0mJvzPRY2lAVRm/prnYePqMH6bYokDl/w/Z0H5BCso90YxDjA3rcb2BkN6rDBbHcE0VkqS68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswiTyd34aPk6gl6TF6qW7i3BCD9c+uXTkqz2OUdkCeISIpt/8
	f2/6s0992gf3gaXuOGR8AKQOxTcMaaoC/JGaid2dpNBIfeSzRKVNHUxQQHgqyw0qSq4RgmJy8Zg
	jKHocmU8gKGBRoXXRUUEL6Ct801Z9iQg7Y39m0aRk
X-Gm-Gg: AeBDieuuTYvQVHa3TqRaWBahiGCJdcM129QVWoyzVmQyua8haCKSQOIRvV1N7kTsBWV
	OeVWtYGF/rMtetWJqhtPBcpAHkear0Nc0mceajdGZ+GWvasg3KrcAM6PL8SmCNuUPEHcwskB5Wb
	MBn5y7T5dwCKLURqjAjkJGmAqQvSULRMpCtQqwxjnWd8VqUpDARq4P5ImNmDyEgWENckTpPm9CG
	RfvFoRmDssthsou6NcAuvuXOdKX/mYiRTvytqET2qB1plzMpLzK9uG5sjG7t/VXuH2x8kq1f1BS
	bFkowEUbCc8huh1t1ZRwZSBq+gCt5IUAVzo7pij1itOePt4hgCTagFUR+g==
X-Received: by 2002:a17:90b:37cb:b0:35e:5ae3:299d with SMTP id
 98e67ed59e1d1-36140411fd9mr27495218a91.11.1776993464062; Thu, 23 Apr 2026
 18:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-3-hramamurthy@google.com> <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
In-Reply-To: <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:17:33 -0700
X-Gm-Features: AQROBzAk58ugy1joaMi2IsclXN8MCjWFpwU7EESqk4pj8krP7OelctOEa9CjLNI
Message-ID: <CAHwYsirGS1Frgtg+V7D2PB74F5gxAB8GXo+Zvss_aYbJC5LwFg@mail.gmail.com>
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
X-Rspamd-Queue-Id: BA9AE458AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240545-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]

Hi Paolo,

On Thu, Apr 23, 2026 at 4:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> > From: Debarghya Kundu <debarghyak@google.com>
> >
> > gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> > when interface goes down or configuration is adjusted.
> >
> > Fix this by persisting baseline stats across interface down.
> >
> > This was discovered by drivers/net/stats.py selftest.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> > Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> > Signed-off-by: Pin-yen Lin <treapking@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h      |  6 ++
> >  drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++---
> >  2 files changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index cbdf3a842cfe..ff7797043908 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -794,6 +794,10 @@ struct gve_ptp {
> >       struct gve_priv *priv;
> >  };
> >
> > +struct gve_ring_err_stats {
> > +     u64 rx_alloc_fails;
> > +};
> > +
> >  struct gve_priv {
> >       struct net_device *dev;
> >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -882,6 +886,8 @@ struct gve_priv {
> >       unsigned long service_task_flags;
> >       unsigned long state_flags;
> >
> > +     struct gve_ring_err_stats base_ring_err_stats;
> > +     struct rtnl_link_stats64 base_net_stats;
> >       struct gve_stats_report *stats_report;
> >       u64 stats_report_len;
> >       dma_addr_t stats_report_bus; /* dma address for the stats report =
*/
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 675382e9756c..8617782791e0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >               return gve_tx_dqo(skb, dev);
> >  }
> >
> > -static void gve_get_stats(struct net_device *dev, struct rtnl_link_sta=
ts64 *s)
> > +static void gve_add_base_stats(struct gve_priv *priv,
> > +                            struct rtnl_link_stats64 *s)
> > +{
> > +     struct rtnl_link_stats64 *base_stats =3D &priv->base_net_stats;
> > +
> > +     s->rx_packets +=3D base_stats->rx_packets;
> > +     s->rx_bytes +=3D base_stats->rx_bytes;
> > +     s->rx_dropped +=3D base_stats->rx_dropped;
> > +     s->tx_packets +=3D base_stats->tx_packets;
> > +     s->tx_bytes +=3D base_stats->tx_bytes;
> > +     s->tx_dropped +=3D base_stats->tx_dropped;
> > +}

Sashiko says:

Can this result in torn reads on 32-bit architectures?
The base_net_stats struct accumulates 64-bit network statistics in gve_clos=
e()
under rtnl_lock, but these stats are read here via ndo_get_stats64 which ca=
n
execute concurrently without rtnl_lock.
On 32-bit systems, a concurrent update might result in torn reads since 64-=
bit
memory reads are not atomic.
Should u64_stats_sync sequence counters or atomic types be used here?

We will add u64_stats_fetch_(begin|retry) to guard this in v2.

> > +
> > +static void gve_get_ring_stats(struct gve_priv *priv,
> > +                            struct rtnl_link_stats64 *s)
> >  {
> > -     struct gve_priv *priv =3D netdev_priv(dev);
> >       unsigned int start;
> >       u64 packets, bytes;
> >       int num_tx_queues;
> > @@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev, =
struct rtnl_link_stats64 *s)
> >       }
> >  }
> >
> > +static void gve_get_stats(struct net_device *dev, struct rtnl_link_sta=
ts64 *s)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(dev);
> > +
> > +     gve_get_ring_stats(priv, s);
> > +     gve_add_base_stats(priv, s);
> > +}
> > +
> >  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> >  {
> >       struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> > @@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *priv=
)
> >       return gve_reset_recovery(priv, false);
> >  }
> >
> > +static void gve_get_ring_err_stats(struct gve_priv *priv,
> > +                                struct gve_ring_err_stats *err_stats)
> > +{
> > +     int ring;
> > +
> > +     for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) {
> > +             unsigned int start;
> > +             struct gve_rx_ring *rx =3D &priv->rx[ring];
> > +
> > +             do {
> > +                     start =3D u64_stats_fetch_begin(&rx->statss);
> > +                     err_stats->rx_alloc_fails +=3D
> > +                             rx->rx_skb_alloc_fail + rx->rx_buf_alloc_=
fail;
> > +             } while (u64_stats_fetch_retry(&rx->statss, start));
>
> Sashiko says:
>
> Could this loop improperly inflate the baseline metric by double counting=
?
> If a concurrent update causes the sequence counter to change,
> u64_stats_fetch_retry() forces the loop to restart. Because the addition
> is performed in-place on err_stats->rx_alloc_fails, the same ring's
> error values will be added again.
> Would it be safer to use local variables inside the retry loop and update
> the global accumulator only after the loop completes successfully, simila=
r
> to the pattern established in gve_get_ring_stats()?
>
We'll fix this by using local variables in v2.
>
> > +     }
> > +}
> > +
> >  static int gve_close(struct net_device *dev)
> >  {
> >       struct gve_priv *priv =3D netdev_priv(dev);
> > @@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
> >       if (err)
> >               return err;
> >
> > +     /* Save ring queue and err stats before closing the interface */
> > +     gve_get_ring_stats(priv, &priv->base_net_stats);
> > +     gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
>
> Sashiko says:
>
> Does this create a temporary spike in reported statistics?
> During gve_close(), the active ring stats are added to base_net_stats.
> However, priv->rx and priv->tx are not set to NULL until the memory
> teardown completes in gve_queues_mem_remove().
> If ndo_get_stats64 is called concurrently during this window, it will
> add both the active ring stats and the newly updated base stats together.
> This causes the reported statistics to temporarily double until the
> teardown finishes.

As Sashiko mentioned, this is an existing concurrency issue between
gve_close() and gve_get_stats() (i.e., .ndo_get_stats64() callback of
gve driver):

gve_queues_mem_remove(priv);
This is a pre-existing issue, but can this lead to a use-after-free
during concurrent stats retrieval?
When gve_queues_mem_remove() frees the ring memory, priv->rx and
priv->tx are not set to NULL until after the memory is freed. If
gve_get_stats() executes during this window, it may iterate over and
dereference the already freed ring memory.

We will send out a separate patch to fix this.

>
> Note that you are expected to proactively comment/reply on the ML to the
> concerns raised by sashiko reviews.

Thanks for the reminder.

>
> Thanks,
>
> Paolo
>

Regards,
Pin-yen

