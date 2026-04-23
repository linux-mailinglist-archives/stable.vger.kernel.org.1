Return-Path: <stable+bounces-240471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Iy9KA0H6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:48:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780B45177C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A0530221C2
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F43E7146;
	Thu, 23 Apr 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJ85Ovq9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI1ld7Bo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEE19CD1B
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944840; cv=none; b=VZeY+s4JL75QqGbcBHA8xUW4RUqJ9KmoRImu76/qnKMRb74zfjnARHRmW9r+ATd1YqnXTqTsAr/dnHji0uxlUwKDiSmm/RPGb0a9FyzJswHmgo6Nk/vKHH/3iL112yXKCvjM2PRm8XZb0RjlgIKlGY6jOPRKMdfxEVDsj6JKjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944840; c=relaxed/simple;
	bh=0B5ZqRGIkYIeaZ8FHBpqaHKS02ZWIPg7rxW44VTGwmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBYIo4XKKcXGbQauJ+cQZ7BteCeWUZiph1mrWcaEkprLQZxGZzWw1yFXauqxp/dw+PqyNrMsVOxKL1aVpglbA/d69utpPl4jeEHiIiqmyynQEgVdMYQuJK9TBeTD1VDwDwg0yDX2i0+h1PHmO5ydGT00AJdpgBhiJJZf9eIhN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJ85Ovq9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CI1ld7Bo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776944837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SCI9sfiKkFOqrMq9DPa4YhaLd4iUhWXlL/+IrvGdTE=;
	b=AJ85Ovq9Spyc7zyku93Ewry2WYdXH7l39zKEafrZV/5tkcWQGM2p36WvqJV8YX7iYXD6kJ
	AClti7Bg2YAFU4Y/BABElmOkcaQLFsFahGH9sbUUiaNf5t/QQtiKihTZ4/DxGsYhASTLky
	pltCsmuXXLHSpmoVoCzbOijPDKdgVZs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-2yK9esVmMnGQ3lA1x0zf8A-1; Thu, 23 Apr 2026 07:47:16 -0400
X-MC-Unique: 2yK9esVmMnGQ3lA1x0zf8A-1
X-Mimecast-MFC-AGG-ID: 2yK9esVmMnGQ3lA1x0zf8A_1776944835
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f803658d5so8012444b3a.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776944835; x=1777549635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SCI9sfiKkFOqrMq9DPa4YhaLd4iUhWXlL/+IrvGdTE=;
        b=CI1ld7BoNZXIKNRc2qxkYkPWnYyTzuqScs2+77w1TenEOUXHXH/B8XPtQIgT7ZMhYm
         G/W9MtiQF2W0t83PbOMkhWOOjPz2fMb8TCSYYTbxmdMYET0aD+2k/+wdeETe1QaJjtH/
         dIopZoDTRYHakmD0kxckvser8Q22Z82BB6kZnkr6rjivne/ljM1UysSZ+dB0+AWJ7JjW
         aTLY5vNa8llTBDmfOgkRZskXKYZZow3BgFj2gUOaHM6HAU01MfaxHauvc+igUJOHpX1s
         sqaFY0eYkF9hEnI0nahTg3k3Rwg31hoWo6uNjziWVUwbK/NIzWVA5YUo1VMedIuT+a2J
         PMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776944835; x=1777549635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SCI9sfiKkFOqrMq9DPa4YhaLd4iUhWXlL/+IrvGdTE=;
        b=ku+A3X+6rg2dcRiNmrg4E+bZxOObhwNuWwmHGVbj1qLXqBVSTBljalDnSCxjLSPsZl
         ydQw2soaOQ8e6BMrzSW5jk3pPT/DFTtvKTc/pFIVMzrbGU4n6GpkftCUlawZ8Kxsb+eM
         pNGn3GDAjeDr0RH4B3syRWikYKHj+y+K1+i5O9aS8CmNz2uhRH5awOYGxO+GjfB5RFKb
         enn6dqUQEh0meCMZuYqr7jYdCpmPVfrvd16TRyTtosXtQL3TCHxRXgmlpQNtNgput9Hs
         XTL5dxuImZZyHYiXD1qdNPZsNzHPHZgVkTWF2ybkXjmm328tmD/lR7uFmOX824FIg2w/
         3+OA==
X-Forwarded-Encrypted: i=1; AFNElJ97cMGS0XWaEShn7xwgEdWwxWvfh3mxic65G8yv8Tb8Xmg+7eLghc6jtCH7yP/CDuhzw9vYGNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIzQt7JbW2GDq9p5tax/DIOcYs/y+rssNz60No3Cjz/lqwnGM
	jVh7S4L3iwsOpDHKJCPLyB1hfxZZnZbE8zlE4XhJAY2V8BwIwrn/OrdXuFNe9khQnDlNsRARbrf
	FqUWUXT3w7tEpClLGDZitGk3FW95/cY7X5daWH41vSYG6bh6fn4rSFxUqmw==
X-Gm-Gg: AeBDiesAFim89wraZ9rtoekjRKvAx4MyMKvkT53HhhFOa4xryCw8LuE0zqOvroOt6Mx
	mFkmMm5dUCqhKWXUektMJT3f1vAKSghiVkaSmFc7cCmR84/SaYRyZ7gG9/kknj68fbMQlGFSF5L
	sRnruOKrhtFHuQx3XbNv/l7sIwfQRCsuBY9IcO+ZHblQMfxKBTQmtcwUqoqjZjOuOkTbPL8a9CN
	CC8e37m1ZiHn5Arl36c0BJWGhFEUA/gdrtnA84jTFvvbHaHgV+bUQFemdpAQPBvMQNnLx6JTNXN
	b9OVF4y+cyBIIZSe6P3KodwOxNSbhRyG1XfN4iDwiBBq5NaWZxtV/jWAjTJzXbQZIkm9MLubpZR
	1phPN2hC46PLLImmM7BzRWJsqkkVLUEC0I0O3B0NE2ThkDfSOD6n+vCxMs3IUBJ+IoBQ=
X-Received: by 2002:a05:6a00:bd0a:b0:82f:5571:1a92 with SMTP id d2e1a72fcca58-82f8c7dd0e4mr28631583b3a.7.1776944834997;
        Thu, 23 Apr 2026 04:47:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0a:b0:82f:5571:1a92 with SMTP id d2e1a72fcca58-82f8c7dd0e4mr28631538b3a.7.1776944834497;
        Thu, 23 Apr 2026 04:47:14 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe68ebsm22720215b3a.47.2026.04.23.04.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:47:14 -0700 (PDT)
Message-ID: <0e1c941e-dcaa-40fb-9df2-ac1db429f60a@redhat.com>
Date: Thu, 23 Apr 2026 13:46:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com,
 maolson@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com,
 shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>,
 Pin-yen Lin <treapking@google.com>
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-3-hramamurthy@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420171837.455487-3-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240471-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1780B45177C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> From: Debarghya Kundu <debarghyak@google.com>
> 
> gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> when interface goes down or configuration is adjusted.
> 
> Fix this by persisting baseline stats across interface down.
> 
> This was discovered by drivers/net/stats.py selftest.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      |  6 ++
>  drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++---
>  2 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index cbdf3a842cfe..ff7797043908 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -794,6 +794,10 @@ struct gve_ptp {
>  	struct gve_priv *priv;
>  };
>  
> +struct gve_ring_err_stats {
> +	u64 rx_alloc_fails;
> +};
> +
>  struct gve_priv {
>  	struct net_device *dev;
>  	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -882,6 +886,8 @@ struct gve_priv {
>  	unsigned long service_task_flags;
>  	unsigned long state_flags;
>  
> +	struct gve_ring_err_stats base_ring_err_stats;
> +	struct rtnl_link_stats64 base_net_stats;
>  	struct gve_stats_report *stats_report;
>  	u64 stats_report_len;
>  	dma_addr_t stats_report_bus; /* dma address for the stats report */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 675382e9756c..8617782791e0 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		return gve_tx_dqo(skb, dev);
>  }
>  
> -static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
> +static void gve_add_base_stats(struct gve_priv *priv,
> +			       struct rtnl_link_stats64 *s)
> +{
> +	struct rtnl_link_stats64 *base_stats = &priv->base_net_stats;
> +
> +	s->rx_packets += base_stats->rx_packets;
> +	s->rx_bytes += base_stats->rx_bytes;
> +	s->rx_dropped += base_stats->rx_dropped;
> +	s->tx_packets += base_stats->tx_packets;
> +	s->tx_bytes += base_stats->tx_bytes;
> +	s->tx_dropped += base_stats->tx_dropped;
> +}
> +
> +static void gve_get_ring_stats(struct gve_priv *priv,
> +			       struct rtnl_link_stats64 *s)
>  {
> -	struct gve_priv *priv = netdev_priv(dev);
>  	unsigned int start;
>  	u64 packets, bytes;
>  	int num_tx_queues;
> @@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
>  	}
>  }
>  
> +static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
> +{
> +	struct gve_priv *priv = netdev_priv(dev);
> +
> +	gve_get_ring_stats(priv, s);
> +	gve_add_base_stats(priv, s);
> +}
> +
>  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
>  {
>  	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
> @@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *priv)
>  	return gve_reset_recovery(priv, false);
>  }
>  
> +static void gve_get_ring_err_stats(struct gve_priv *priv,
> +				   struct gve_ring_err_stats *err_stats)
> +{
> +	int ring;
> +
> +	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
> +		unsigned int start;
> +		struct gve_rx_ring *rx = &priv->rx[ring];
> +
> +		do {
> +			start = u64_stats_fetch_begin(&rx->statss);
> +			err_stats->rx_alloc_fails +=
> +				rx->rx_skb_alloc_fail + rx->rx_buf_alloc_fail;
> +		} while (u64_stats_fetch_retry(&rx->statss, start));

Sashiko says:

Could this loop improperly inflate the baseline metric by double counting?
If a concurrent update causes the sequence counter to change,
u64_stats_fetch_retry() forces the loop to restart. Because the addition
is performed in-place on err_stats->rx_alloc_fails, the same ring's
error values will be added again.
Would it be safer to use local variables inside the retry loop and update
the global accumulator only after the loop completes successfully, similar
to the pattern established in gve_get_ring_stats()?


> +	}
> +}
> +
>  static int gve_close(struct net_device *dev)
>  {
>  	struct gve_priv *priv = netdev_priv(dev);
> @@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
>  	if (err)
>  		return err;
>  
> +	/* Save ring queue and err stats before closing the interface */
> +	gve_get_ring_stats(priv, &priv->base_net_stats);
> +	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);

Sashiko says:

Does this create a temporary spike in reported statistics?
During gve_close(), the active ring stats are added to base_net_stats.
However, priv->rx and priv->tx are not set to NULL until the memory
teardown completes in gve_queues_mem_remove().
If ndo_get_stats64 is called concurrently during this window, it will
add both the active ring stats and the newly updated base stats together.
This causes the reported statistics to temporarily double until the
teardown finishes.

Note that you are expected to proactively comment/reply on the ML to the
concerns raised by sashiko reviews.

Thanks,

Paolo


