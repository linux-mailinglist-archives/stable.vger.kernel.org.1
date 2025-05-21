Return-Path: <stable+bounces-145814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA26ABF309
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119603AD5DE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48F263F5B;
	Wed, 21 May 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxNfRTss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FD239585;
	Wed, 21 May 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827501; cv=none; b=BJWi8Pgrd9IYGIS7BjOhQp/57oF17ZNFcRqOSDOZnsgsERTJNPepOPPGaUU9L78kJ1Pj6rrTDohSsvr6UpnGMGAQk6kDsnJrpBPCEIHK656eyINYw5kQdiogB3dISggfrAgS0mY200JfsploBNBrA6fKtpPUh9uJcAYzKQsvmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827501; c=relaxed/simple;
	bh=RTk6zZE4Ocqx64VCuCzzw2IhiKNg639tTa3vFSVixtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0v2AQRv6wQ20t1PMCeV6BIGwBISH/AIidAdpogphdKTkrQhgUY46PL7A6+7N0FrMYmZOXMsw9KmvTYJEQIuS6JwhEFdxn2SnZQ8O+AC7F7bK9Vb4PgSdPfGzLtyzQAh8Lc35IhkVTgGVTSj1A93nT0johmjxKH3Cv3i8TTqL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxNfRTss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81511C4CEE4;
	Wed, 21 May 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747827501;
	bh=RTk6zZE4Ocqx64VCuCzzw2IhiKNg639tTa3vFSVixtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxNfRTss/fINM5OSrc1IzeDcbzVLjNTyGJ2ZXyqPPZI3R31361spKZ3bJx9IoENWS
	 1PjRjk/ZJzqXHEoVoPXTMcLAEFf/w9X+D2oS8JVLWjFrfaFy6y9wy9eyQ2giQ2dQOI
	 DIbtMm62iogL8wtCArxBDYdDZA7vwxD2osg8sGbA=
Date: Wed, 21 May 2025 13:38:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mans Rullgard <mans@mansr.com>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250_omap: fix TX with DMA for am33xx
Message-ID: <2025052101-lunchbox-catacomb-79fe@gregkh>
References: <20250514072035.2757435-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514072035.2757435-1-jirislaby@kernel.org>

On Wed, May 14, 2025 at 09:20:35AM +0200, Jiri Slaby (SUSE) wrote:
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
> 
> ---

You forgot to sign off on this patch :(

Can you resend it with that?

thanks,

greg k-h

