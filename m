Return-Path: <stable+bounces-228793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JyANExpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:24:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3472F8096
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73485304B2AF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3623E33D;
	Mon, 23 Mar 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nso01hhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417823B62C;
	Mon, 23 Mar 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277141; cv=none; b=s+mWytInh0mNUjbNKOqnDurlnkdResFSI1pE63wU7uiqhpRz4Ui5f/O8j9k3aiJlwhEech+MVg7EqpsS37EZL/kM67a1LvEImEfbao1SUlgEgR+PsbmqBgkPlN6MTh4lJuK7YyaARnfT5B0gDCuL1S79iHD9Cdu9LiaTRtYpDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277141; c=relaxed/simple;
	bh=sQ++P00VzDnidaxeH3IBqWi7EiuWjZKDrQK7IYxr+KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neFJFbg3IzSbrcpad3g5rgtBwGeXud25G5RCNSoibAmEd17x3sfgBDeXy9e7QvI8k58jxzaSWf6yr3dO3xYsy83gDUjTia352mMxhU/WAw4VuJ7OT6h/mKQlcpeBh5TUNNOIK3zjnZC3ERaVS0gW6YgfRQaZjtjDEudsg/onf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nso01hhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF9C2BC9E;
	Mon, 23 Mar 2026 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774277141;
	bh=sQ++P00VzDnidaxeH3IBqWi7EiuWjZKDrQK7IYxr+KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nso01hhMvhdxFpAnH3DnizfuqcZ3q8T4g8K4tSUytd+pv/p41bslMUn6C762jhqoD
	 MI914txUblaDKarNeMUtOdGxAoQ4PNYgZdnROTmeZcG0HAgiiog9xkEUHHbm7UqsI1
	 OG2qAzE/IXdsc2d1U0/TWrH8jtUc7HgnQTMeWmTiG+uZtCYO6CjPljm0frzCbcc0PR
	 NqflOTxQxmIl8PAwg8O37mDllvSnNMIj6o2j3n6tAPiS9QsWRmyNTjQfYb4Bbjn42e
	 BYO5qvxoKsc2UFz04x9dhHU3mgzAm8DFjXMtZ5gKLXNSaOzCWUjkpNOWzaUMwiCx1d
	 FMllqws+SOJqQ==
Date: Mon, 23 Mar 2026 14:45:35 +0000
From: Simon Horman <horms@kernel.org>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@linux.ibm.com,
	nnac123@linux.ibm.com, sukadev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, danisjiang@gmail.com,
	ychen@northwestern.edu
Subject: Re: [PATCH] ibmvnic: fix OOB array access in ibmvnic_xmit on queue
 count reduction
Message-ID: <20260323144535.GB85922@horms.kernel.org>
References: <20260321035439.900644-1-LivelyCarpet87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321035439.900644-1-LivelyCarpet87@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228793-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,northwestern.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A3472F8096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:54:39PM -0500, Tyllis Xu wrote:
> When the number of TX queues is reduced (e.g., via ethtool -L), the
> Qdisc layer retains previously enqueued skbs with queue mappings from
> before the reduction. After the reset completes and tx_queues_active is
> set to true, netif_tx_start_all_queues() drains these stale skbs through
> ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
> the newly allocated array bounds, causing out-of-bounds reads on
> tx_scrq[] and tx_pool[]/tso_pool[], and out-of-bounds writes on
> tx_stats_buffers[] in the function's exit path.
> 
> The existing tx_queues_active guard does not help here: it is set to
> true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
> queue draining, so stale skbs pass the check with an invalid queue index.
> 
> Add a bounds check against num_active_tx_scrqs immediately after the
> tx_queues_active guard. Use a dedicated out_unlock label to skip the
> per-queue stats updates (which also index tx_stats_buffers[queue_num])
> when the queue index is invalid.
> 
> Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335e..c939391474cb 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2453,6 +2453,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
>  		goto out;
>  	}
>  
> +	if (unlikely(queue_num >= adapter->num_active_tx_scrqs)) {
> +		dev_kfree_skb_any(skb);
> +		goto out_unlock;
> +	}
> +

This doesn't seem quite right. Shouldn't it be as per other
blocks in this function that drop packets. In which case
it could re-use the existing handling in the conditional immediately above
this hunk.

Also, I don't think unlikely() seems in keeping with the existing
implementation of this function.

I'm suggesting something like (completely untested):

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..67e1e62631e3 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2457,7 +2457,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	txq = netdev_get_tx_queue(netdev, queue_num);
 	ind_bufp = &tx_scrq->ind_buf;
 
-	if (ibmvnic_xmit_workarounds(skb, netdev)) {
+	if (ibmvnic_xmit_workarounds(skb, netdev) ||
+	    queue_num >= adapter->num_active_tx_scrqs) {
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;

Where the next line is:

		goto out;

...

> @@ -2672,6 +2677,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
>  	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
>  
> +	return ret;
> +out_unlock:
> +	rcu_read_unlock();
>  	return ret;
>  }

My previous comment not, withstanding:

The RCU read side critical section is already enormous.
So perhaps making it slightly better doesn't make a difference.

If so, can we go for this slightly flow here (completely untested).

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..1e1cd8c11cf9 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2664,14 +2664,14 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_carrier_off(netdev);
 	}
 out:
-	rcu_read_unlock();
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
 	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
 	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
-
+out_unlock:
+	rcu_read_unlock();
 	return ret;
 }
 

-- 
pw-bot: changes-requested

