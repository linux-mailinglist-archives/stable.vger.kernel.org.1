Return-Path: <stable+bounces-144340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32905AB663D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF87A9481
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCB21E098;
	Wed, 14 May 2025 08:41:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482401E04BD;
	Wed, 14 May 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212086; cv=none; b=fCV9uvHzMjtweQ+S60cZrWEg8qi5n3s1NfPhXQsiw3xjbadvaGFMTP0l0f4wWu75YsAn3EurrUhurMXptRC7HviogpOyqn5goPUYcAnvnWlT+bOkQWLSMfHMGDUxtB6JpTy3V9L06z75ONTAxXA6DyglWLQN7Vg0YzZChiy8Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212086; c=relaxed/simple;
	bh=BHG6ZK7DUhY1prFc6nxmJ13YsH63YJl0RUxivpgX9qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bh8y/NgsiaeD4DDm9Nb8IM1A6mOoeeeXTH/lT/huC9mJVVIV9eFkn4q6I5slq48IZkGfv61SxddEUL9NIP21qjYkG4Hj/ayDgDVAY23a1oGqSs3UG8RiRF9H72hxtjJyuRhFAY7mFvebbGm+7PSKyzVEyUZOPj1xgO0365aRmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
	by unicorn.mansr.com (Postfix) with ESMTPS id 1DA1C15360;
	Wed, 14 May 2025 09:41:17 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id AF3BB21A3DA; Wed, 14 May 2025 09:41:16 +0100 (BST)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250_omap: fix TX with DMA for am33xx
In-Reply-To: <20250514072035.2757435-1-jirislaby@kernel.org> (Jiri Slaby's
	message of "Wed, 14 May 2025 09:20:35 +0200")
References: <20250514072035.2757435-1-jirislaby@kernel.org>
Date: Wed, 14 May 2025 09:41:16 +0100
Message-ID: <yw1xldqzlh3n.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

"Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:

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
> The same as for the original patch, I would appreaciate if someone
> actually tests this one on a real HW too.
>
> A patch to optimize the driver to use 2 sgls is still welcome. I will
> not add it without actually having the HW.

Are you seriously expecting me to waste even more time on this?
Do your damn job like you should have to begin with.

--=20
M=E5ns Rullg=E5rd

