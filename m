Return-Path: <stable+bounces-151412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1FFACDF04
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218BF188B84C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDC28F935;
	Wed,  4 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ea/HIRNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93E1EF395
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043633; cv=none; b=meVerxKJhrSYff2wfkA8l9C4H9+T6MEZzJUph/y5Nrtvf1SESUX6beKXFSHGCPPsRndat3J5f6zKropgzYcfoVvp6gbVIxUIV5nj1i4sEHTnQQpXBM7g4CXe6KQqkXSrRCwgsNB+o2qdDCgjeUfftc5uj7p30c8rJyC+UvwNmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043633; c=relaxed/simple;
	bh=e+4vca9UlxpQMefiTfp8hIQClsinK/xwH+lITsa2MA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSGkRZ0mg/12gJZc1+7bnXrP+yAzir1Ix2e6eWn4b7sE6Ub2KxtVJGxbQygAGAa5zOvTlKA5xDqHApy3RXJI9ngfbN0ahf/46D9xlaRZgR++WcOfoE/ij+aWYryNyFQfgJEDBlcwXXfEpDQqLxoX4S6ZDsvyy2efgLxg6mxNcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ea/HIRNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69CFC4CEEF;
	Wed,  4 Jun 2025 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749043633;
	bh=e+4vca9UlxpQMefiTfp8hIQClsinK/xwH+lITsa2MA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea/HIRNh0vxbJrqd7DDEM0PAwANIbrWjWZrj2TDqkEDy8qjtkqEsPP+xzqDB4Vhi1
	 p5/9rkhGtYu8F45mt7sSpbI0keFclKUF0J/NsNYaM8kTbSgA8F8yHCouJG1zF2yVb5
	 AF5kIgbpjSGtaT94/EtX4sKGR0jBpGPh30Hhy4l4=
Date: Wed, 4 Jun 2025 15:27:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 1/4] serial: sh-sci: Check if TX data was written
 to device in .tx_empty()
Message-ID: <2025060448-puzzle-equator-c99b@gregkh>
References: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
 <20250603093701.3928327-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603093701.3928327-2-claudiu.beznea.uj@bp.renesas.com>

On Tue, Jun 03, 2025 at 12:36:58PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> commit 7cc0e0a43a91052477c2921f924a37d9c3891f0c upstream.
> 
> On the Renesas RZ/G3S, when doing suspend to RAM, the uart_suspend_port()
> is called. The uart_suspend_port() calls 3 times the
> struct uart_port::ops::tx_empty() before shutting down the port.
> 
> According to the documentation, the struct uart_port::ops::tx_empty()
> API tests whether the transmitter FIFO and shifter for the port is
> empty.
> 
> The Renesas RZ/G3S SCIFA IP reports the number of data units stored in the
> transmit FIFO through the FDR (FIFO Data Count Register). The data units
> in the FIFOs are written in the shift register and transmitted from there.
> The TEND bit in the Serial Status Register reports if the data was
> transmitted from the shift register.
> 
> In the previous code, in the tx_empty() API implemented by the sh-sci
> driver, it is considered that the TX is empty if the hardware reports the
> TEND bit set and the number of data units in the FIFO is zero.
> 
> According to the HW manual, the TEND bit has the following meaning:
> 
> 0: Transmission is in the waiting state or in progress.
> 1: Transmission is completed.
> 
> It has been noticed that when opening the serial device w/o using it and
> then switch to a power saving mode, the tx_empty() call in the
> uart_port_suspend() function fails, leading to the "Unable to drain
> transmitter" message being printed on the console. This is because the
> TEND=0 if nothing has been transmitted and the FIFOs are empty. As the
> TEND=0 has double meaning (waiting state, in progress) we can't
> determined the scenario described above.
> 
> Add a software workaround for this. This sets a variable if any data has
> been sent on the serial console (when using PIO) or if the DMA callback has
> been called (meaning something has been transmitted). In the tx_empty()
> API the status of the DMA transaction is also checked and if it is
> completed or in progress the code falls back in checking the hardware
> registers instead of relying on the software variable.
> 
> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://lore.kernel.org/r/20241125115856.513642-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [claudiu.beznea: fixed conflict by:
>  - keeping serial_port_out() instead of sci_port_out() in
>    sci_transmit_chars()
>  - keeping !uart_circ_empty(xmit) condition in sci_dma_tx_complete(),
>    after s->tx_occurred = true; assignement]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)


For obvious reasons, we can't take patches ONLY for older stable
kernels, and not newer ones.  Otherwise you would have kernel releases
without any fixes and get a regression when moving to a newer tree,
which you yourself don't want to have happen :)

So can you resend these patches for all of the needed branches,
including this one, as I'll drop this from my review queue now.

thanks,

greg k-h

