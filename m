Return-Path: <stable+bounces-235664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I4ckDo9f2WlqpAgAu9opvQ
	(envelope-from <stable+bounces-235664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:37:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747773DC7FF
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA1F300822E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AF392C21;
	Fri, 10 Apr 2026 20:37:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497137FF58;
	Fri, 10 Apr 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853450; cv=none; b=eEI6NeO9/IHVFqIjZRg56s5MsWVtwy6Nva4J0pfAA2jSlPs8EnaXzpr1HJulsFHpaSI7gFWuah3hZHzEbuFbk8d19m8xP9apXRL2dw/Q1phweK3hJPva9+t4zNBI+oLky876EuhIXZzmiTW6kSv2DvBsW9ATu2fBUyyaij34GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853450; c=relaxed/simple;
	bh=e99ZEba2XOq+ctpMGkfiSkSBgDBkuT2L6JX9XCcK074=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCe8GLQLIPXECr+/Cd5DQCHJzun9x7h8PniKbwz4ghR6RCJh+G6IkDtpcfNVyGMwtRj9EL026tl3JaMDlwBQ8q5QiijJin0wm7IEy0n66Nxruyw24VxK7y5wiA0KAJutIMEN9+zjU7zTHCyKoqb88NdvVkr31/4XzuOKp2SoO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBIbC-00EzFn-Bq; Fri, 10 Apr 2026 20:37:06 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wBHUe-0000000EGm3-3AmX;
	Fri, 10 Apr 2026 21:37:05 +0100
Message-ID: <364a0f17-c733-4ef0-8d8f-1bd9e00dcae9@cambridgegreys.com>
Date: Fri, 10 Apr 2026 21:37:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: fix NULL pointer derefs in queue-less
 transports
To: Michael Bommarito <michael.bommarito@gmail.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20260410203028.3717914-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235664-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cambridgegreys.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,nod.at,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anton.ivanov@cambridgegreys.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambridgegreys.com:email,cambridgegreys.com:mid]
X-Rspamd-Queue-Id: 747773DC7FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/04/2026 21:30, Michael Bommarito wrote:
> TAP transport sets neither VECTOR_RX nor VECTOR_TX, so
> vector_net_open() never allocates rx_queue or tx_queue.  HYBRID sets
> VECTOR_RX but not VECTOR_TX, so tx_queue is NULL there too.
>
> vector_reset_stats(), vector_poll(), vector_get_ethtool_stats(), and
> vector_get_ringparam() unconditionally deref these queue pointers,
> causing a NULL pointer crash on SMP or with any lock debugging option.
>
> Guard all queue pointer accesses with NULL checks.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Cc: stable@vger.kernel.org
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Found while enabling KCOV and lockdep on UML for a network-stack
> test lab.  Tested boot with SMP=y + PROVE_LOCKING + DEBUG_SPINLOCK +
> DEBUG_LOCK_ALLOC + LOCKDEP + KCOV, all with vec0:transport=tap.
>
> Without the fix, the same config panics at addr 0x18 (SMP, no debug),
> 0x1c (DEBUG_SPINLOCK), or 0x30 (lockdep) -- all offsets into a NULL
> vector_queue pointer.
>
>   arch/um/drivers/vector_kern.c | 48 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 2cc90055499a5..6134c376e57be 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -105,25 +105,18 @@ static const struct {
>   
>   static void vector_reset_stats(struct vector_private *vp)
>   {
> -	/* We reuse the existing queue locks for stats */
> -
> -	/* RX stats are modified with RX head_lock held
> -	 * in vector_poll.
> -	 */
> -
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	vp->estats.rx_queue_max = 0;
>   	vp->estats.rx_queue_running_average = 0;
>   	vp->estats.rx_encaps_errors = 0;
>   	vp->estats.sg_ok = 0;
>   	vp->estats.sg_linearized = 0;
> -	spin_unlock(&vp->rx_queue->head_lock);
> -
> -	/* TX stats are modified with TX head_lock held
> -	 * in vector_send.
> -	 */
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
>   
> -	spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
>   	vp->estats.tx_timeout_count = 0;
>   	vp->estats.tx_restart_queue = 0;
>   	vp->estats.tx_kicks = 0;
> @@ -131,7 +124,8 @@ static void vector_reset_stats(struct vector_private *vp)
>   	vp->estats.tx_flow_control_xoff = 0;
>   	vp->estats.tx_queue_max = 0;
>   	vp->estats.tx_queue_running_average = 0;
> -	spin_unlock(&vp->tx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_unlock(&vp->tx_queue->head_lock);
>   }
>   
>   static int get_mtu(struct arglist *def)
> @@ -1163,7 +1157,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
>   
>   	if ((vp->options & VECTOR_TX) != 0)
>   		tx_enqueued = (vector_send(vp->tx_queue) > 0);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	if ((vp->options & VECTOR_RX) > 0)
>   		err = vector_mmsg_rx(vp, budget);
>   	else {
> @@ -1171,7 +1166,8 @@ static int vector_poll(struct napi_struct *napi, int budget)
>   		if (err > 0)
>   			err = 1;
>   	}
> -	spin_unlock(&vp->rx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
>   	if (err > 0)
>   		work_done += err;
>   
> @@ -1421,10 +1417,10 @@ static void vector_get_ringparam(struct net_device *netdev,
>   {
>   	struct vector_private *vp = netdev_priv(netdev);
>   
> -	ring->rx_max_pending = vp->rx_queue->max_depth;
> -	ring->tx_max_pending = vp->tx_queue->max_depth;
> -	ring->rx_pending = vp->rx_queue->max_depth;
> -	ring->tx_pending = vp->tx_queue->max_depth;
> +	ring->rx_max_pending = vp->rx_queue ? vp->rx_queue->max_depth : 0;
> +	ring->tx_max_pending = vp->tx_queue ? vp->tx_queue->max_depth : 0;
> +	ring->rx_pending = ring->rx_max_pending;
> +	ring->tx_pending = ring->tx_max_pending;
>   }
>   
>   static void vector_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
> @@ -1466,11 +1462,15 @@ static void vector_get_ethtool_stats(struct net_device *dev,
>   	 * to date.
>   	 */
>   
> -	spin_lock(&vp->tx_queue->head_lock);
> -	spin_lock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_lock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_lock(&vp->rx_queue->head_lock);
>   	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
> -	spin_unlock(&vp->rx_queue->head_lock);
> -	spin_unlock(&vp->tx_queue->head_lock);
> +	if (vp->rx_queue)
> +		spin_unlock(&vp->rx_queue->head_lock);
> +	if (vp->tx_queue)
> +		spin_unlock(&vp->tx_queue->head_lock);
>   }
>   
>   static int vector_get_coalesce(struct net_device *netdev,

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


