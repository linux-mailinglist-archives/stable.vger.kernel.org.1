Return-Path: <stable+bounces-272904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B8jZJxybT2qekwIAu9opvQ
	(envelope-from <stable+bounces-272904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:59:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98729731506
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O4IxofIw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272904-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272904-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AA44304230A
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43722259F;
	Thu,  9 Jul 2026 12:48:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6621C9EA;
	Thu,  9 Jul 2026 12:48:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601312; cv=none; b=N1T9U6ZkFiJyh9RyBdA7WYv7YptitsTZCNmdMZF1FhfKLugINjY64fWY9tB13vaTYqjhDK7ea9btKZXRaaXPCP7Nrof8nKMm5/j7fJW1/gmYWzfISxAvbBPP5V9OASNLzXGD19Dqatq/F2JXExntNsQmcI76AToWhE2QzO3TsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601312; c=relaxed/simple;
	bh=UCvrSD4WPZCKMnfZ7bZPCCLcfYVVt5RIv+5WsMKZljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfRflhS3KDpKHlSImlqSHOaEfNl4Se1KoSjwpR1XUsBx0vuCnOXwLI6q/wGx9/O1ZY/xfMImJPhf0n8Gw3PHhdI7J9m6hKB8Vf2e0XLuXmHYf+/GRhCoUYUcaIdsUAG43tt0ka7OskpAzdOwfjou4lLTVyMOD4yaSmxOt3rKS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4IxofIw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342A41F000E9;
	Thu,  9 Jul 2026 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601310;
	bh=e35A+YQAtVyYh9/QLnZWQjsHK2Rt5TW72LzhiKpXFZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4IxofIw4RGqDF7wGZtzrNd9+8YLhxviQfAVBkZGMtP40hoBCDO5KPwOQ845thadO
	 hO63CYW0IFa2swIQSyMPrPtZ/JuXSa6E3LNYzxZzECVDJzaJBwTrsXBFbYFqhks/SN
	 wXUEGvOJp3FzsnGdcr3lcKEcGunRrTyZfb6ba5ea45d5hUp3lxLLA7UnUzHQSupWB6
	 lUTp5gDNZt4h3EbCqUOwj9lwLJg2S3xfBJo1QQPQHXBbGOMS9mW3B+XyW9ua4pUGkB
	 dOdW9URT8lP8Vp/+DilHwz/pJjS4QnPoz9viRrdBmefyiwqI4scBU/D2I+mB69LJ85
	 d9FlUnxopO1mA==
From: Simon Horman <horms@kernel.org>
To: fanwu01@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: hip04: quiesce tx coalesce timer before teardown
Date: Thu,  9 Jul 2026 13:43:10 +0100
Message-ID: <20260709124309.1557255-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703050133.2445155-1-fanwu01@zju.edu.cn>
References: <20260703050133.2445155-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,m:shenjian15@huawei.com,m:salil.mehta@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98729731506

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: hip04: quiesce tx coalesce timer before teardown

This patch fixes race conditions with the tx_coalesce_timer by properly
canceling it during device stop and remove. It also serializes device
restarts in the tx timeout handler using rtnl_lock().

> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index 18376bcc718a2..cb9b01c79ee6e 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c

[ ... ]

> @@ -761,6 +762,13 @@ static int hip04_mac_stop(struct net_device *ndev)
>  
>  	napi_disable(&priv->napi);
>  	netif_stop_queue(ndev);

[Severity: High]
This is a pre-existing issue, but does netif_stop_queue() adequately protect
against concurrent transmission here?

Since netif_stop_queue() only changes the queue state flag without waiting for
an active ndo_start_xmit callback to finish (unlike netif_tx_disable()), could
this allow the subsequent hip04_tx_reclaim() call to corrupt the TX ring or
cause invalid DMA mappings if a transmission is actively running?

> +
> +	/* Cancel the TX-coalesce timer after the arming paths (xmit via the
> +	 * queue, rx poll via NAPI) are disabled, so a pending tx_done()
> +	 * (which dereferences priv) is drained before the device is freed.
> +	 */
> +	hrtimer_cancel(&priv->tx_coalesce_timer);

[Severity: High]
This is a pre-existing issue, but is it possible for the softirq to re-arm
the timer after hrtimer_cancel() is called?

In hip04_rx_poll(), the NAPI ownership is released via napi_complete_done()
before the timer is armed:

hip04_rx_poll() {
    ...
    napi_complete_done(napi, rx);
done:
    if (rx < budget && tx_remaining)
        hip04_start_tx_timer(priv);
}

If the teardown thread cancels the timer and frees the private structure
while the softirq is preempted just after napi_complete_done(), could this
result in a use-after-free when hip04_start_tx_timer() is eventually executed?

> +
>  	hip04_mac_disable(ndev);
>  	hip04_tx_reclaim(ndev, true);

[Severity: High]
This is a pre-existing issue, but is there missing hardware synchronization
between disabling the MAC and reclaiming the TX ring?

hip04_mac_disable() disables the MAC using a relaxed MMIO write without
polling for an idle state.

Since the very next call is hip04_tx_reclaim() which unmaps buffers and
modifies descriptor memory, could this cause silent data corruption or IOMMU
page faults if the MAC is still actively processing packets in the background?

[ ... ]

> @@ -791,8 +799,15 @@ static void hip04_tx_timeout_task(struct work_struct *work)
>  	struct hip04_priv *priv;
>  
>  	priv = container_of(work, struct hip04_priv, tx_timeout_task);
> +
> +	rtnl_lock();
> +	if (!netif_running(priv->ndev))
> +		goto out;
> +
>  	hip04_mac_stop(priv->ndev);
>  	hip04_mac_open(priv->ndev);

[Severity: High]
This is a pre-existing issue, but what happens if hip04_mac_open() fails
during this restart?

If dma_map_single() fails inside hip04_mac_open(), it returns -EIO without
enabling NAPI. Because this return value is ignored here, the device remains
broken and NAPI is left disabled (with the SCHED bit set).

Will this cause a hard lockup later when hip04_mac_stop() spins forever in
napi_disable() waiting for the SCHED bit to clear?

> +out:
> +	rtnl_unlock();
>  }
>  

[ ... ]

> @@ -1029,10 +1044,15 @@ static void hip04_remove(struct platform_device *pdev)
>  	if (priv->phy)
>  		phy_disconnect(priv->phy);
>  
> -	hip04_free_ring(ndev, d);
>  	unregister_netdev(ndev);

[Severity: High]
This is a pre-existing issue, but does calling phy_disconnect() before
unregister_netdev() cause a use-after-free and WARN?

phy_disconnect() halts and detaches the PHY, dropping its reference count.
The subsequent call to unregister_netdev() invokes hip04_mac_stop(), which
unconditionally calls phy_stop().

Could calling phy_stop() on a detached and potentially freed PHY device
pointer cause a crash?

> -	of_node_put(priv->phy_node);
>  	cancel_work_sync(&priv->tx_timeout_task);
> +	hrtimer_cancel(&priv->tx_coalesce_timer);
> +	/* Free the rings only after the interface is stopped (.ndo_stop via
> +	 * unregister_netdev) and the work/timer are drained; the TX/NAPI
> +	 * paths touch them while the device is up.
> +	 */
> +	hip04_free_ring(ndev, d);

[Severity: High]
This is a pre-existing issue, but does hip04_free_ring() safely handle
allocation failures?

During probe, if allocating the TX descriptor ring fails, priv->tx_desc
remains NULL, and the error path calls hip04_free_ring().

Since hip04_free_ring() unconditionally calls dma_free_coherent() on
priv->tx_desc, could this cause a kernel panic on architectures that trap
virtual-to-physical translations on NULL?

> +	of_node_put(priv->phy_node);
>  	free_netdev(ndev);

[Severity: High]
This is a pre-existing issue, but does explicitly freeing the netdev here
create a use-after-free race with the interrupt handler?

The driver requests its interrupt in hip04_mac_probe() using
devm_request_irq(), meaning the IRQ is only freed during devres cleanup after
hip04_remove() completely finishes.

If an interrupt fires between free_netdev() and the devres cleanup,
hip04_mac_interrupt() will cast dev_id to the freed ndev pointer, which seems
like it would lead to a use-after-free crash.

>  }
>  

[ ... ]

Regarding the RX polling path in hip04_rx_poll():

[Severity: High]
This is a pre-existing issue, but does a failure in build_skb() cause a memory
and DMA mapping leak?

Looking at hip04_rx_poll():

    if (unlikely(!skb)) {
        net_dbg_ratelimited("build_skb failed\n");
        goto refill;
    }
    ...
refill:
    ...
    priv->rx_buf[priv->rx_head] = buf;
    priv->rx_phys[priv->rx_head] = phys;

If build_skb() fails, the code jumps directly to the refill label, completely
bypassing the dma_unmap_single() call for the original buffer. It then
allocates and maps a new buffer, overwriting the array entries.

Could this permanently leak the original buffer and its DMA mapping,
eventually leading to an OOM crash under memory pressure?

