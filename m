Return-Path: <stable+bounces-144341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD310AB66A3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8147519E5814
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4A221561;
	Wed, 14 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugeobv1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FC1E5734;
	Wed, 14 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213124; cv=none; b=BXHF5KBCVzAdqrRvPLSgd08WYk4Gd7JEWjRqzME93SDCt55qj8nGDFnt/0oK5sJsVumMqI72rD9MLmxja2Fk+4PAywbjO+N3sATolI9vVmypqDCnHKZhvojGen8rEkK0qR8nCqIMGP0r+pUxbX683haV67DUEBZ/E6Qz4X/0ZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213124; c=relaxed/simple;
	bh=4Fu/+bWayIzle3MVwoUfvIrsZOYpROT1tgBBO62bR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGHVg02Eo41Vi1LP7vbHy5E+uwyetccryemnjIymRHzY0zM2D6UMiQSDf8nxdNrCN/4Wh5ETYmdpESLT/d28ZzjrTtpbaJ05lHK+GNMXkyN1kAaGa3o/Am/B0zNPYU7sjmhcqjrZ3oiE7bWQcLOf8f+5ZYVrm7p328dUuvmpwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugeobv1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37426C4CEE9;
	Wed, 14 May 2025 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747213123;
	bh=4Fu/+bWayIzle3MVwoUfvIrsZOYpROT1tgBBO62bR6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugeobv1fBeN6ixO3JsGcbSW94qPMjPhIcmciyi/p/2tQy0GPw4tDz4DJSfHTVEaCA
	 1FxvcdcjU5MuYcf7WENZYEijP3c0UGNJEx+tSvyCYWP53Lui/LtqMEjp7J73t8rEWl
	 O/7Knurf3crxq3QYQbRh/v1lf5EVMRYRvGaV93hM=
Date: Wed, 14 May 2025 10:56:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250_omap: fix TX with DMA for am33xx
Message-ID: <2025051425-thank-unbitten-d814@gregkh>
References: <20250514072035.2757435-1-jirislaby@kernel.org>
 <yw1xldqzlh3n.fsf@mansr.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xldqzlh3n.fsf@mansr.com>

On Wed, May 14, 2025 at 09:41:16AM +0100, Måns Rullgård wrote:
> "Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:
> 
> > Commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > introduced an error in the TX DMA handling for 8250_omap.
> >
> > When the OMAP_DMA_TX_KICK flag is set, the "skip_byte" is pulled from
> > the kfifo and emitted directly in order to start the DMA. While the
> > kfifo is updated, dma->tx_size is not decreased. This leads to
> > uart_xmit_advance() called in omap_8250_dma_tx_complete() advancing the
> > kfifo by one too much.
> >
> > In practice, transmitting N bytes has been seen to result in the last
> > N-1 bytes being sent repeatedly.
> >
> > This change fixes the problem by moving all of the dma setup after the
> > OMAP_DMA_TX_KICK handling and using kfifo_len() instead of the DMA size
> > for the 4-byte cutoff check. This slightly changes the behaviour at
> > buffer wraparound, but it still transmits the correct bytes somehow.
> >
> > Now, the "skip_byte" would no longer be accounted to the stats. As
> > previously, dma->tx_size included also this skip byte, up->icount.tx was
> > updated by aforementioned uart_xmit_advance() in
> > omap_8250_dma_tx_complete(). Fix this by using the uart_fifo_out()
> > helper instead of bare kfifo_get().
> >
> > Based on patch by Mans Rullgard <mans@mansr.com>
> >
> > Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > Reported-by: Mans Rullgard <mans@mansr.com>
> > Cc: stable@vger.kernel.org
> >
> > ---
> > The same as for the original patch, I would appreaciate if someone
> > actually tests this one on a real HW too.
> >
> > A patch to optimize the driver to use 2 sgls is still welcome. I will
> > not add it without actually having the HW.
> 
> Are you seriously expecting me to waste even more time on this?
> Do your damn job like you should have to begin with.

That type of response is not allowed here.  Please refrain from this in
the future.

greg k-h

