Return-Path: <stable+bounces-144332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE6AB6426
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D80188182B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAA21ADAB;
	Wed, 14 May 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW73m9fx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF12063F0;
	Wed, 14 May 2025 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207348; cv=none; b=pBedPpS4me1TZddJwKcJCzwWUs9WkAl/lxLPFZXWo2sFfQM1RuWxN71cLKfRHMkU7NjP214V6wiXsWf7bwbTnqhkacd+G8L907lGvo60fwGh3VWuN/twUSwZSS8VXbMvokBVogQE+JWI/EfVpbJ3mBHnhiC126wZWLlFEEw+lyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207348; c=relaxed/simple;
	bh=1hZrJvEOYUx9JGctY4L22hhqz29PWO7JEuA6Jf8JYdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUDeBZiGNRuwxTunwbShiq/x9P0e1eHzsrp7mWVsiVUW0BAWFI5wf/ekBXmaNHSD+D8J4XkzAlT/ymo56KejRPkhxmvvLmwoCpw6bEaOiR/6AYjWcNIJLqetER/797bZ3HXrgls9NEGCdIj5o8MI6eAxTPZdUJuIp0O4YRC0gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW73m9fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48394C4CEE9;
	Wed, 14 May 2025 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747207347;
	bh=1hZrJvEOYUx9JGctY4L22hhqz29PWO7JEuA6Jf8JYdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZW73m9fxryJP2BBe5XZJuiuJbAl9WFvR1bGr0SAsArLv39hCPQKhxfs3uKlZ5RC1o
	 STAtwJSWSyak90MP/W8x8CHNxPIeAzhpeeJee8UjLyt9+01XBf3AVe3agI79zhyL9z
	 cbXBnpOMDAbrL98KcLOqicGUufqNTuOSpsNWfujekYy8hxPwJyne43bIDQCpJR6MMh
	 dt31v06qdHzW3GgEg5NCNdJhYXqQFPXuVi3ns+27KSAWlQjoZwnSjvZWTBPJ2crXDZ
	 rRk6AzanpAINWbd7mcpNuo5dw4/03aDnND1evGIk1g4v/vgFZtmfXiRYgPM6bbUv4U
	 UFpN90MWeFwfA==
Message-ID: <ef8c87b6-dcf6-47a4-92dc-075927d3823c@kernel.org>
Date: Wed, 14 May 2025 09:22:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: 8250_omap: fix TX with DMA for am33xx
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mans Rullgard <mans@mansr.com>, stable@vger.kernel.org
References: <20250514072035.2757435-1-jirislaby@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250514072035.2757435-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 05. 25, 9:20, Jiri Slaby (SUSE) wrote:
> Commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> introduced an error in the TX DMA handling for 8250_omap.
> 
> When the OMAP_DMA_TX_KICK flag is set, the "skip_byte" is pulled from
> the kfifo and emitted directly in order to start the DMA. While the
> kfifo is updated, dma->tx_size is not decreased. This leads to
> uart_xmit_advance() called in omap_8250_dma_tx_complete() advancing the
> kfifo by one too much.
> 
> In practice, transmitting N bytes has been seen to result in the last
> N-1 bytes being sent repeatedly.
> 
> This change fixes the problem by moving all of the dma setup after the
> OMAP_DMA_TX_KICK handling and using kfifo_len() instead of the DMA size
> for the 4-byte cutoff check. This slightly changes the behaviour at
> buffer wraparound, but it still transmits the correct bytes somehow.
> 
> Now, the "skip_byte" would no longer be accounted to the stats. As
> previously, dma->tx_size included also this skip byte, up->icount.tx was
> updated by aforementioned uart_xmit_advance() in
> omap_8250_dma_tx_complete(). Fix this by using the uart_fifo_out()
> helper instead of bare kfifo_get().
> 
> Based on patch by Mans Rullgard <mans@mansr.com>
> 
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Reported-by: Mans Rullgard <mans@mansr.com>
> Cc: stable@vger.kernel.org

I should have added this too:
Link: https://lore.kernel.org/all/20250506150748.3162-1-mans@mansr.com/

> ---
> The same as for the original patch, I would appreaciate if someone
> actually tests this one on a real HW too.
> 
> A patch to optimize the driver to use 2 sgls is still welcome. I will
> not add it without actually having the HW.
> ---
>   drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c9b1c689a045..bb23afdd63f2 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1151,16 +1151,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>   		return 0;
>   	}
>   
> -	sg_init_table(&sg, 1);
> -	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> -					   UART_XMIT_SIZE, dma->tx_addr);
> -	if (ret != 1) {
> -		serial8250_clear_THRI(p);
> -		return 0;
> -	}
> -
> -	dma->tx_size = sg_dma_len(&sg);
> -
>   	if (priv->habit & OMAP_DMA_TX_KICK) {
>   		unsigned char c;
>   		u8 tx_lvl;
> @@ -1185,18 +1175,22 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>   			ret = -EBUSY;
>   			goto err;
>   		}
> -		if (dma->tx_size < 4) {
> +		if (kfifo_len(&tport->xmit_fifo) < 4) {
>   			ret = -EINVAL;
>   			goto err;
>   		}
> -		if (!kfifo_get(&tport->xmit_fifo, &c)) {
> +		if (!uart_fifo_out(&p->port, &c, 1)) {
>   			ret = -EINVAL;
>   			goto err;
>   		}
>   		skip_byte = c;
> -		/* now we need to recompute due to kfifo_get */
> -		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
> -				UART_XMIT_SIZE, dma->tx_addr);
> +	}
> +
> +	sg_init_table(&sg, 1);
> +	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1, UART_XMIT_SIZE, dma->tx_addr);
> +	if (ret != 1) {
> +		ret = -EINVAL;
> +		goto err;
>   	}
>   
>   	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
> @@ -1206,6 +1200,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
>   		goto err;
>   	}
>   
> +	dma->tx_size = sg_dma_len(&sg);
>   	dma->tx_running = 1;
>   
>   	desc->callback = omap_8250_dma_tx_complete;


-- 
js
suse labs

