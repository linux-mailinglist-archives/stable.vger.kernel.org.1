Return-Path: <stable+bounces-241441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mClZA27H72knGAEAu9opvQ
	(envelope-from <stable+bounces-241441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03EC47A076
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AF05300D1F8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AEC370D56;
	Mon, 27 Apr 2026 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwEeH74w"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87F242D6A
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321835; cv=pass; b=UfHBWbBfCUKcNWT6fkI8F3LH1R11LiLjRmclBe4GZ8PI8kEZ7R20skM3SbXYeC0pk8kbLKK0IrkDoh3c5Jft43pFPdUouNX5XUhXUEtctu0Wu2CsSznFS8f173l2D8xLYLAtiC6MyjErsfsyD0JX3WonsvEUD0kgb6geaEmWiw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321835; c=relaxed/simple;
	bh=CBdZD0o0xH6S63xgHNjMb6WcEzD+oBN8na7BiQ261sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxUPl5Vb33hBUMwziMEkxvSoVPaRwF5Y136lw0nJ5o82/Qb6b0v7bp5EW1d3/FllMZR3Nb8gcKXbqcDi0QFMu0BCbiJOPUEUTCJIQ4Xf8VgO6ikhTx5eN7x2mTYHmCdiTJb6BDRqOyBiWapzozd2m+/pccJmchG6nJuJmBWEwmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwEeH74w; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-61399bdd395so3427869137.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777321833; cv=none;
        d=google.com; s=arc-20240605;
        b=HwwYSwqdW1nf2aDs7YznsD5fe8mMXGJGePkU0d8pWA3KOaDtIXInwkZrPGLO6LKl54
         XWdzqkKxwip2nYV3jd9jwSCVKUc4r/JcddPjxR0QwC+n8eyKu03ykaQXGsXK4Hn7kn18
         qfLVVCzpWzD/sceBnbk3whb3DgPOeUCBGCmxH3Kjij8V3E2Efth/rqbluzORqaXji7mG
         opQJW2JV1UyoGEmk1mUBFzIs/khrUOyAnwKY1QRK5+feUQ0Q4BDUwTX0y6ceRyOU+nDg
         Te5cCCSiovsXDybrlPBJzljOjwe0k+KwXuiPGba3JqGkVCzyIqJ3Cin9lNWIaRzf4KoN
         Bj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cY52Pc8bna5SJOkKQJ9yeqlkwv7LoY6hzA8k6b64L0E=;
        fh=nNnTUhN1x6O6v+pLQ4ZrPNFHgtBzt7iS1hUglfaYPZA=;
        b=GC1qssjaWXKT9gqolIMuACwZi02wmQMo8GpLgni6VCZL9t0UOzx3rudBQPUtAkuPNe
         SXmvssXtNmuep8BrD6AG6cxwGqydbSm7E2RD+O0STrOCcEMz7bu1voIiNWmBAQ1TNgdA
         GOw3+iOzvea4U+AUn3CEk4Yt3GZTeSTE2MKIr9aA4ec0Lv7e78ADfxA8pTjl6eTC8YSf
         7zqkot2BdWG9tZwPC6d4ULE4x6ZZCQiDOCIEwTkHpxjMDJxpqQQbQLNFQXBiwoJNCsP2
         32RdC3Hy3njqNDvSvtFeo2e6DfQ13NSSAAIlG6xrBrK/ob+3ziAaliagVg5Pg0BFfbUo
         wB4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777321833; x=1777926633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY52Pc8bna5SJOkKQJ9yeqlkwv7LoY6hzA8k6b64L0E=;
        b=EwEeH74w26HJdAfwdB0cvHTiewHqmSaUtDplpaXXUTbzdwjQkJ2S4PEDlFADN1J6xA
         uelQT6ZcUNBgaC8hi7GDfG6wc3UzhiNpD6BYMH4wTt0eA8eu7tHDt3zf4Dd85SZHfBkt
         nwbHWiDAsdWwrRomnxgnzdh38F0e1/wKfqAiq4xe1vRZIcoGQpUnw3I1fgvSQsO46ovT
         RCB1LGOcuwNm1j3Zc/dwbXEHav3kbahmhqhkUgYW977smN4M4KTC2pbZH/3vIUknRKgC
         yv07N5geyc0Q2mKaTCxvv3/W3wGjyBCsy+FVQWnU+2aWOWBDmKE9zxnYIoeH/BpNJOPC
         bmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321833; x=1777926633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cY52Pc8bna5SJOkKQJ9yeqlkwv7LoY6hzA8k6b64L0E=;
        b=WGY0jeDBBQs0PALU+GA8tsgAO4cngzkxbQk+5WTVTkLFpSKtQXBH47qO0SKQyYV4aj
         0h4OqXOz6NYKinsQCHfjTkyWQhXoPgtsAkn4uffSEXcyd4NChp4S1wgF6KNd8ZBaUA4V
         QjFDaimjrnczpR1BTPxo9sM5AH8Pr9a94mg+ZpSOmJAcxF8/85/xM6V9wR87LKe0S1Uv
         txmS7Up086w+Kh6D7fQF6+4CgDsu+ulhK5/FWHV8puErX2qP9/nqzJC3F/1EC0PhdCAO
         NeGUYpvfh5lScbr0bVwiaf+giodk4hAot8XmR+dkGEevMCp57XcwQoxXOxPQLq+1YZWx
         27qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dxu9/mUEH/QE6XiAcYqMvn6xHN9rzUXkdafVnz8rwvUcCbqQsOYFEe5U9JgwKvVPhQ+qRDmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHXo6ze/qTaAREpQeV7cWkpcS1A2WVxAQZXvE7G8NdFs5JYYU
	+NQqwBnhZClbZwqtT/ufo/bS8tXjN5Zq9L//ostcPxmDWyqJV+u07Zs9fWTfBa1mWr0U9Gz8yON
	xwS8ySXSijxAnq3w9Q2b62aOUO2Bs2vX6tYb/INbQ
X-Gm-Gg: AeBDietwyaBkMTzINXUXRZMO6I3SB1pBhafembLnJrSr8wSyX4BxM9taJSGmZFsN9Og
	EOBs7yunARtM6GcGHtIdV1clZCABmiQfG7mPjajffRcoGrG9yIFIsIPBNMWyBqGKDYadDawcZJq
	kYh1YMl49PSQ0LPzsJBONwgVrdafjyiHdFg64a9gR3/mImlzgTdLnk0RJ2LohmOmVwRHD0Ad/5s
	2jSeFlfG+F5/9ojZRDjXZ0aF+UBaonewYNbvSM29wR1HvUwQCwOmkLJFcjVUl2yVxSqFdSbcTxi
	7tThCJ+KHhZBL8ELZQmW3sHXOTtdBWj7wM/8aqQ64vJuQH4CmgNW3ed2nP0AQLTAk3YliA==
X-Received: by 2002:a05:6102:2c1c:b0:602:7a74:fbbe with SMTP id
 ada2fe7eead31-6280957715cmr78081137.9.1777321831899; Mon, 27 Apr 2026
 13:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com> <20260425002450.163421-3-hramamurthy@google.com>
In-Reply-To: <20260425002450.163421-3-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 27 Apr 2026 13:30:19 -0700
X-Gm-Features: AVHnY4JhU_x70BQYQBtGqiCKWI6PJnTqpp26JxQs8TL_ZMA2BaJXIKOffX2Em-Y
Message-ID: <CAHwYsiotoLU+toZmVzUcSpA+7v+R8PWnm04C1PrPbi29RJavfQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/4] gve: Fix backward stats when interface goes
 down or configuration is adjusted
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A03EC47A076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241441-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 5:24=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Debarghya Kundu <debarghyak@google.com>
>
> gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> when interface goes down or configuration is adjusted.
>
> Fix this by persisting baseline stats across interface down.
>
> Cc: stable@vger.kernel.org
> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> Co-developed-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v2:
> - Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
> - Use local variable to prevent inflates from u64_stats_fetch_retry()
>   (Sashiko)
> - Add u64_stats_fetch/begin to protect base stats (Sashiko)
>
>  drivers/net/ethernet/google/gve/gve.h      |  7 ++
>  drivers/net/ethernet/google/gve/gve_main.c | 88 ++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 1d66d3834f7e..702b1641d984 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -794,6 +794,10 @@ struct gve_ptp {
>         struct gve_priv *priv;
>  };
>
> +struct gve_ring_err_stats {
> +       u64 rx_alloc_fails;
> +};
> +
>  struct gve_priv {
>         struct net_device *dev;
>         struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -883,6 +887,9 @@ struct gve_priv {
>         unsigned long service_task_flags;
>         unsigned long state_flags;
>
> +       struct gve_ring_err_stats base_ring_err_stats;
> +       struct rtnl_link_stats64 base_net_stats;
> +       struct u64_stats_sync base_statss; /* sync stats for 32bit archs =
*/

Sashiko says:

Is u64_stats_init(&priv->base_statss) ever explicitly called during driver
probe?
netdev_alloc_priv() zero-allocates the memory, but on 32-bit architectures
or when lockdep is enabled, the underlying seqcount_t requires explicit
initialization to set up its lockdep class key.
Could failing to initialize it trigger a lockdep splat when the interface
goes down and u64_stats_update_begin() is invoked?

Yes, this is missing in this series. We will include this in v3.

>         struct gve_stats_report *stats_report;
>         u64 stats_report_len;
>         dma_addr_t stats_report_bus; /* dma address for the stats report =
*/
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index ef00d9ca1643..1fec8e1e4821 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -106,9 +106,34 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>                 return gve_tx_dqo(skb, dev);
>  }
>
> -static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats=
64 *s)
> +static void gve_add_base_stats(struct gve_priv *priv,
> +                              struct rtnl_link_stats64 *s)
> +{
> +       struct rtnl_link_stats64 *base_stats =3D &priv->base_net_stats;
> +       unsigned int start;
> +       u64 rx_packets, rx_bytes, rx_dropped, tx_packets, tx_bytes, tx_dr=
opped;
> +
> +       do {
> +               start =3D u64_stats_fetch_begin(&priv->base_statss);
> +               rx_packets =3D base_stats->rx_packets;
> +               rx_bytes =3D base_stats->rx_bytes;
> +               rx_dropped =3D base_stats->rx_dropped;
> +               tx_packets =3D base_stats->tx_packets;
> +               tx_bytes =3D base_stats->tx_bytes;
> +               tx_dropped =3D base_stats->tx_dropped;
> +       } while (u64_stats_fetch_retry(&priv->base_statss, start));
> +
> +       s->rx_packets +=3D rx_packets;
> +       s->rx_bytes +=3D rx_bytes;
> +       s->rx_dropped +=3D rx_dropped;
> +       s->tx_packets +=3D tx_packets;
> +       s->tx_bytes +=3D tx_bytes;
> +       s->tx_dropped +=3D tx_dropped;
> +}
> +
> +static void gve_get_ring_stats(struct gve_priv *priv,
> +                              struct rtnl_link_stats64 *s)
>  {
> -       struct gve_priv *priv =3D netdev_priv(dev);
>         unsigned int start;
>         u64 packets, bytes;
>         int num_tx_queues;
> @@ -143,6 +168,14 @@ static void gve_get_stats(struct net_device *dev, st=
ruct rtnl_link_stats64 *s)
>         }
>  }
>
> +static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats=
64 *s)
> +{
> +       struct gve_priv *priv =3D netdev_priv(dev);
> +
> +       gve_get_ring_stats(priv, s);
> +       gve_add_base_stats(priv, s);
> +}
> +
>  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
>  {
>         struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> @@ -1533,6 +1566,29 @@ static int gve_queues_stop(struct gve_priv *priv)
>         return gve_reset_recovery(priv, false);
>  }
>
> +static void gve_get_ring_err_stats(struct gve_priv *priv,
> +                                  struct gve_ring_err_stats *err_stats)
> +{
> +       int ring;
> +
> +       if (!priv->rx)
> +               return;
> +
> +       for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) {
> +               struct gve_rx_ring *rx =3D &priv->rx[ring];
> +               unsigned int start;
> +               u64 rx_alloc_fails;
> +
> +               do {
> +                       start =3D u64_stats_fetch_begin(&rx->statss);
> +                       rx_alloc_fails =3D rx->rx_skb_alloc_fail +
> +                                        rx->rx_buf_alloc_fail;
> +               } while (u64_stats_fetch_retry(&rx->statss, start));
> +
> +               err_stats->rx_alloc_fails +=3D rx_alloc_fails;
> +       }
> +}
> +
>  static int gve_close(struct net_device *dev)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
> @@ -1542,6 +1598,12 @@ static int gve_close(struct net_device *dev)
>         if (err)
>                 return err;
>
> +       /* Save ring queue and err stats before closing the interface */
> +       u64_stats_update_begin(&priv->base_statss);

Sashiko says:

Is there a risk of a deadlock here on 32-bit platforms?
ndo_get_stats64 (which calls gve_get_stats()) can execute concurrently in
softirq context. u64_stats_update_begin() on 32-bit platforms acquires a
seqcount lock but does not disable bottom halves.
If a softirq interrupts this update on the same CPU, could the lockless
reader spin infinitely waiting for the sequence counter to become even,
causing a hard deadlock?
Should this update be wrapped in local_bh_disable() and local_bh_enable()?

We will add this in v3.

> +       gve_get_ring_stats(priv, &priv->base_net_stats);
> +       gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
> +       u64_stats_update_end(&priv->base_statss);
> +
>         gve_queues_mem_remove(priv);

Sashiko says:

Will this sequence cause a transient double-counting of statistics?
The active ring stats are accumulated into base_net_stats, but the ring
pointers (priv->rx, priv->tx) remain active and are not cleared until
gve_queues_mem_remove() executes later.
If gve_get_stats() executes concurrently during this window, does it sum bo=
th
the active ring stats and the newly updated base_net_stats (which now
incorporates those same ring stats)?
One additional pre-existing issue related to this code path: does
gve_queues_mem_remove() leave a window for a use-after-free?
ndo_get_stats64 executes locklessly under RCU and checks if (priv->rx)
before reading ring stats. gve_queues_mem_remove() frees priv->rx using
kvfree(), but sets the pointer to NULL only after the memory is freed.
If ndo_get_stats64 checks priv->rx, gets preempted, and resumes after
gve_close() frees the array, could it dereference freed memory?

Both point to a pre-existing race between stats and gve_close(). We
will address this in v3.

>         return 0;
>  }
> @@ -2784,12 +2846,24 @@ static void gve_get_base_stats(struct net_device =
*dev,
>                                struct netdev_queue_stats_rx *rx,
>                                struct netdev_queue_stats_tx *tx)
>  {
> -       rx->packets =3D 0;
> -       rx->bytes =3D 0;
> -       rx->alloc_fail =3D 0;
> +       const struct gve_ring_err_stats *base_err_stats;
> +       const struct rtnl_link_stats64 *base_stats;
> +       struct gve_priv *priv;
> +       unsigned int start;
>
> -       tx->packets =3D 0;
> -       tx->bytes =3D 0;
> +       priv =3D netdev_priv(dev);
> +       base_stats =3D &priv->base_net_stats;
> +       base_err_stats =3D &priv->base_ring_err_stats;
> +
> +       do {
> +               start =3D u64_stats_fetch_begin(&priv->base_statss);
> +               rx->packets =3D base_stats->rx_packets;
> +               rx->bytes =3D base_stats->rx_bytes;
> +               rx->alloc_fail =3D base_err_stats->rx_alloc_fails;
> +
> +               tx->packets =3D base_stats->tx_packets;
> +               tx->bytes =3D base_stats->tx_bytes;
> +       } while (u64_stats_fetch_retry(&priv->base_statss, start));
>  }
>
>  static const struct netdev_stat_ops gve_stat_ops =3D {
> --
> 2.54.0.545.g6539524ca2-goog
>

Regards,
Pin-yen

