Return-Path: <stable+bounces-223405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO5KJu+Tq2kSegEAu9opvQ
	(envelope-from <stable+bounces-223405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 03:56:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D45229B3A
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 03:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ADC93022F8C
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 02:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD562E1746;
	Sat,  7 Mar 2026 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Qg6Gki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327A2DCF41;
	Sat,  7 Mar 2026 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852201; cv=none; b=GYNHWCB389gsxpSzfLSQmIvwgz4lPX3/icsl1EwttvEhr2Lo3nGvqGL3edzLtPG9Uls9O1s6OuhDNf1wBYTdU77tBY82FPvxhIwnyi+xEn6sjW0pilGnQFk4C7uRRv0CpJOj8hkX8k2b3xfeT/Qw32McvIfuNFO5QHAO14USFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852201; c=relaxed/simple;
	bh=pxIvuwvEYaO6ieaDBTEST/67jzsmSiyiMXageS18q3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKzdFkqvK+aemAUvucqlx04gNhFJE+CquLKTDj2No9NhqC1U9jta1dfLi7L4tgTMmM3x+XCUSl3PJyV09o7ICsLBebWr4XJVsPiaXavnCGmNmnvCKnH9qy8SKsiilD6b01u37HPgeYnsr9kucAPuyE4aHiGE/ygJWrd2P059mOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Qg6Gki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF47C4CEF7;
	Sat,  7 Mar 2026 02:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772852201;
	bh=pxIvuwvEYaO6ieaDBTEST/67jzsmSiyiMXageS18q3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8Qg6GkisVN2IIp03Nq7B6feJmwzImgM0yriuEd3QRKbM+aXdOci7DEC6VUcW7kqN
	 evLrw4EzngPuZODDykuPiVJMpM0cwe38ngX8BiEuL2RRHRt3xf8yTFrjGnUYPfIsIX
	 KeNP4VLYP+fTfIpBlAmu3FVH1f1QwT2J6wgLkcLpk9SJnZGjF0zDA60IbREyJzZxYQ
	 bgdObtC5yq7lHtfs0lBAo4P/OILt527OSJaErQYUO1Bs3nvDbgv0bx/mEb51QDfB4Y
	 qOhV5cGoakpPIm09j/woOqPLkdnwEkKCd+B0ARfU1wByNKc0i7/Hkd4K6ixWjEurlE
	 knA5QqFB+FtOg==
From: Jakub Kicinski <kuba@kernel.org>
To: haokexin@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	nicolas.ferre@microchip.com,
	quanyang.wang@windriver.com
Subject: Re: [net] net: macb: Shuffle the tx ring before enabling tx
Date: Fri,  6 Mar 2026 18:56:38 -0800
Message-ID: <20260307025638.1345906-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-zynqmp-v1-1-5de72254d56b@gmail.com>
References: <20260305-zynqmp-v1-1-5de72254d56b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4D45229B3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-223405-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: macb: Shuffle the tx ring before enabling tx

Quanyang observed that when using an NFS rootfs on an AMD ZynqMp board,
the rootfs may take an extended time to recover after a suspend. Upon
investigation, it was determined that the issue originates from a problem
in the macb driver. To resolve this issue, shuffle the tx ring and tx skb
array so that the first unsent packet is positioned at the start of the tx
ring.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 5bc35f651ebd..3ceeff22c12f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -668,6 +669,88 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
>  	netif_tx_stop_all_queues(ndev);
>  }
>
> +/* Use juggling algorithm to left rotate tx ring and tx skb array */
> +static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
> +{
> +	unsigned int i, head, tail, count, size, cycles, shift, curr, next;
> +	struct macb_dma_desc desc, *desc_curr, *desc_next;
> +	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
> +	struct macb *bp = queue->bp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> +	head = queue->tx_head;
> +	tail = queue->tx_tail;
> +	size = bp->tx_ring_size;
> +	count = CIRC_CNT(head, tail, size);
> +
> +	if (!(tail % size))
> +		goto unlock;
> +
> +	if (!count) {
> +		queue->tx_head = 0;
> +		queue->tx_tail = 0;
> +		goto unlock;
> +	}
> +
> +	shift = tail % size;
> +	cycles = gcd(size, shift);
> +
> +	for (i = 0; i < cycles; i++) {
> +		memcpy(&desc, macb_tx_desc(queue, i), sizeof(struct macb_dma_desc));
> +		memcpy(&tx_skb, macb_tx_skb(queue, i), sizeof(struct macb_tx_skb));
> +
> +		curr = i;
> +		next = (curr + shift) % size;
> +
> +		while (next != i) {
> +			desc_curr = macb_tx_desc(queue, curr);
> +			desc_next = macb_tx_desc(queue, next);
> +
> +			memcpy(desc_curr, desc_next, sizeof(struct macb_dma_desc));
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does this memcpy corrupt the descriptor fields on systems with 64-bit DMA?
The macb_tx_desc() macro uses macb_adj_dma_desc_idx() to properly space the
descriptor pointers in the ring according to the descriptor size reported by
macb_dma_desc_get_size(bp), which can be 8 bytes (base), 16 bytes (with
DMA64), or 24 bytes (with DMA64 + PTP). However, all three memcpy calls in
this function use sizeof(struct macb_dma_desc), which is only 8 bytes and
covers only the addr and ctrl fields.

On systems where macb_dma64(bp) == true, such as the AMD ZynqMp platform
this patch targets, each descriptor has an additional macb_dma_desc_64
struct containing the upper 32 bits of the DMA address (addrh field).

When the shuffle copies descriptors using only 8 bytes, it moves the lower
32-bit address (desc->addr) and control word (desc->ctrl) to new positions
but leaves the upper 32-bit address (addrh) unmoved in the old location.
After the shuffle, hardware reads a composite 64-bit DMA address from
mismatched descriptor slots: the old slot's addrh combined with the new
slot's addr.

This would cause DMA to a corrupted physical address, potentially leading
to memory corruption or bus errors.

The driver uses macb_dma_desc_get_size(bp) elsewhere for operations on the
descriptor ring:

drivers/net/ethernet/cadence/macb_main.c:macb_alloc_consistent() {
    ...
    size = bp->tx_ring_size * macb_dma_desc_get_size(bp);
    queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
                                        &queue->tx_ring_dma, GFP_KERNEL);
    ...
}

and in:

drivers/net/ethernet/cadence/macb_main.c:macb_free_consistent() {
    ...
    size = bp->tx_ring_size * macb_dma_desc_get_size(bp);
    dma_free_coherent(&bp->pdev->dev, size, queue->tx_ring,
                      queue->tx_ring_dma);
    ...
}

Should the memcpy size here use macb_dma_desc_get_size(bp) instead of
sizeof(struct macb_dma_desc)?

The same issue appears at two other locations in this function (the initial
memcpy saving desc at the start of the loop, and the final memcpy restoring
desc at the end). Additionally, the stack-allocated "struct macb_dma_desc
desc" temporary buffer may be too small to hold the extended descriptor.

> +
> +			if (next == bp->tx_ring_size - 1)
> +				desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
> +			if (curr == bp->tx_ring_size - 1)
> +				desc_curr->ctrl |= MACB_BIT(TX_WRAP);
> +
> +			skb_curr = macb_tx_skb(queue, curr);
> +			skb_next = macb_tx_skb(queue, next);
> +			memcpy(skb_curr, skb_next, sizeof(struct macb_tx_skb));
> +
> +			curr = next;
> +			next = (curr + shift) % size;
> +		}
> +
> +		desc_curr = macb_tx_desc(queue, curr);
> +		memcpy(desc_curr, &desc, sizeof(struct macb_dma_desc));
> +		if (i == bp->tx_ring_size - 1)
> +			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
> +		if (curr == bp->tx_ring_size - 1)
> +			desc_curr->ctrl |= MACB_BIT(TX_WRAP);
> +		memcpy(macb_tx_skb(queue, curr), &tx_skb, sizeof(struct macb_tx_skb));
> +	}
> +
> +	queue->tx_head = count;
> +	queue->tx_tail = 0;
> +
> +	/* Make descriptor updates visible to hardware */
> +	wmb();
> +
> +unlock:
> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> +}

[ ... ]
-- 
pw-bot: cr

