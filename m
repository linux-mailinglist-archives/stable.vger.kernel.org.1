Return-Path: <stable+bounces-6613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9981196C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C271F2166F
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF235EEC;
	Wed, 13 Dec 2023 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdoyBTIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137D33CFF;
	Wed, 13 Dec 2023 16:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F73C433C7;
	Wed, 13 Dec 2023 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702484969;
	bh=LpUT5DCYHNkKp48aWpAg9uJhDqev4O8ZCeYdnemj2eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdoyBTIEE+hKfv7gI/p2DN7nR4x/2m/LIY00NltrDpHnaUm0DDcNYGgYiseagREz8
	 IoM+278fjvl1p5yopg51xXJ8dfvpgGSrXHUgYvoovyGXkzh82XJkTS8FQGdnRkpsoy
	 g05BalqdT5xe0uz+3eFDQEQ0KiAIjme1fwmRB1OA7wZUcwDJwdESCoKCipzW1rduIL
	 dZx6rtsp/IADd0rq5dlPXlbNjcgVcEJinIzbQWEIypQ78LGm9QYFoID1PbXI5G7Pmf
	 W4MXSc2KfprA6+AZUCUGVKI633iJuuobo/+g1tOieZ3bXZ01jGMGyzjJwz88sxx1YX
	 F6X9OeA9p+HnQ==
Date: Wed, 13 Dec 2023 16:29:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ks8851: Fix TX stall caused by TX buffer
 overrun
Message-ID: <20231213162924.GH5817@kernel.org>
References: <20231212191632.197656-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212191632.197656-1-rwahl@gmx.de>

On Tue, Dec 12, 2023 at 08:16:32PM +0100, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> There is a bug in the ks8851 Ethernet driver that more data is written
> to the hardware TX buffer than actually available. This is caused by
> wrong accounting of the free TX buffer space.
> 
> The driver maintains a tx_space variable that represents the TX buffer
> space that is deemed to be free. The ks8851_start_xmit_spi() function
> adds an SKB to a queue if tx_space is large enough and reduces tx_space
> by the amount of buffer space it will later need in the TX buffer and
> then schedules a work item. If there is not enough space then the TX
> queue is stopped.
> 
> The worker function ks8851_tx_work() dequeues all the SKBs and writes
> the data into the hardware TX buffer. The last packet will trigger an
> interrupt after it was send. Here it is assumed that all data fits into
> the TX buffer.
> 
> In the interrupt routine (which runs asynchronously because it is a
> threaded interrupt) tx_space is updated with the current value from the
> hardware. Also the TX queue is woken up again.
> 
> Now it could happen that after data was sent to the hardware and before
> handling the TX interrupt new data is queued in ks8851_start_xmit_spi()
> when the TX buffer space had still some space left. When the interrupt
> is actually handled tx_space is updated from the hardware but now we
> already have new SKBs queued that have not been written to the hardware
> TX buffer yet. Since tx_space has been overwritten by the value from the
> hardware the space is not accounted for.
> 
> Now we have more data queued then buffer space available in the hardware
> and ks8851_tx_work() will potentially overrun the hardware TX buffer. In
> many cases it will still work because often the buffer is written out
> fast enough so that no overrun occurs but for example if the peer
> throttles us via flow control then an overrun may happen.
> 
> This can be fixed in different ways. The most simple way would be to set
> tx_space to 0 before writing data to the hardware TX buffer preventing
> the queuing of more SKBs until the TX interrupt has been handled. I have
> chosen a slightly more efficient (and still rather simple) way and
> track the amount of data that is already queued and not yet written to
> the hardware. When new SKBs are to be queued the already queued amount
> of data is honoured when checking free TX buffer space.
> 
> I tested this with a setup of two linked KS8851 running iperf3 between
> the two in bidirectional mode. Before the fix I got a stall after some
> minutes. With the fix I saw now issues anymore after hours.
> 
> Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Tristram Ha <Tristram.Ha@microchip.com>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

...

> diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c

...

> @@ -310,6 +322,8 @@ static void ks8851_tx_work(struct work_struct *work)
>  	unsigned long flags;
>  	struct sk_buff *txb;
>  	bool last;
> +	unsigned short tx_space;
> +	unsigned int dequeued_len = 0;

Hi Ronald,

Please consider using reverse xmas tree - longest line to shortest -
for local variable declarations in Networking code.

> 
>  	kss = container_of(work, struct ks8851_net_spi, tx_work);
>  	ks = &kss->ks8851;
> @@ -320,6 +334,7 @@ static void ks8851_tx_work(struct work_struct *work)
>  	while (!last) {
>  		txb = skb_dequeue(&ks->txq);
>  		last = skb_queue_empty(&ks->txq);
> +		dequeued_len += calc_txlen(txb->len);

On the line below it is assumed that txb may be NULL.
But on the line above it is dereferenced unconditionally.
This seems inconsistent.

Flagged by Smatch.

> 
>  		if (txb) {
>  			ks8851_wrreg16_spi(ks, KS_RXQCR,

...

