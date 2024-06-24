Return-Path: <stable+bounces-55031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918EC915143
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025CAB24D13
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8D19ADB1;
	Mon, 24 Jun 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hg/S7Tqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880B19ADA6
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241364; cv=none; b=QtRFdIuMdpNAvnJEiNHF4oSZI3YAjH90v+VqTJM86Jf6y4X7PXMfciXaF4U49buZuIQsbb3BLIPsPAL6zboM7LFxyoberlMa0BNVw7uC8HD+dgW2Cv5QJ1186ObmaAEuloNnH2jploqZgybYMAx+843KyJQr4N6RpEwJORyhJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241364; c=relaxed/simple;
	bh=RA3Apruz/CuoUIjTrn0djMsTyql07dJdEE1i3MOT8+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnUOEOACdkh6a2wzB+2bpsYl/JWy/T6F27mM9Hiait2tQxUhzP5iD9IhSiyb56GvQRIKBOy9ICdyLhmpuij7nXxC3UqoqtQ+tpLf4Xph39cBwXlt3bN8U2lVPHsr+8KO6z2+6p1xvC4TGzzL/58lQVt3WhpcZrvKbm0SaDO+hYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hg/S7Tqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377ABC2BBFC;
	Mon, 24 Jun 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241364;
	bh=RA3Apruz/CuoUIjTrn0djMsTyql07dJdEE1i3MOT8+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hg/S7TqmgHkZveUMadhsYdKyMK8agWEty8q1mSY9V3HlZYqRqRe/0iRMVnXpe1z0X
	 zkhjDg4LCdOaE/oAYQ7BEh/OhBklCK6EAUYL0BorsdRDOKm2aHZEHaKv7+iLi2Wlfd
	 W6uhzJsLPtX9ZJiTWU3/vLUWWyBUwtkaLicnM9qk=
Date: Mon, 24 Jun 2024 17:02:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 5.15] serial: stm32: rework RX over DMA
Message-ID: <2024062424-appeasing-mobster-9276@gregkh>
References: <20240620152658.1033479-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620152658.1033479-1-dario.binacchi@amarulasolutions.com>

On Thu, Jun 20, 2024 at 05:26:57PM +0200, Dario Binacchi wrote:
> From: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> commit 33bb2f6ac3088936b7aad3cab6f439f91af0223c upstream.
> 
> This patch reworks RX support over DMA to improve reliability:
> - change dma buffer cyclic configuration by using 2 periods. DMA buffer
> data are handled by a flip-flop between the 2 periods in order to avoid
> risk of data loss/corruption
> - change the size of dma buffer to 4096 to limit overruns
> - add rx errors management (breaks, parity, framing and overrun).
>   When an error occurs on the uart line, the dma request line is masked at
>   HW level. The SW must 1st clear DMAR (dma request line enable), to
>   handle the error, then re-enable DMAR to recover. So, any correct data
>   is taken from the DMA buffer, before handling the error itself. Then
>   errors are handled from RDR/ISR/FIFO (e.g. in PIO mode). Last, DMA
>   reception is resumed.
> - add a condition on DMA request line in DMA RX routines in order to
> switch to PIO mode when no DMA request line is disabled, even if the DMA
> channel is still enabled.
>   When the UART is wakeup source and is configured to use DMA for RX, any
>   incoming data that wakes up the system isn't correctly received.
>   At data reception, the irq_handler handles the WUF irq, and then the
>   data reception over DMA.
>   As the DMA transfer has been terminated at suspend, and will be restored
>   by resume callback (which has no yet been called by system), the data
>   can't be received.
>   The wake-up data has to be handled in PIO mode while suspend callback
>   has not been called.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> Link: https://lore.kernel.org/r/20211020150332.10214-3-erwan.leray@foss.st.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ dario: fix conflicts for backport to v5.15. From the [1] series, only the
>   first patch was applied to the v5.15 branch. This caused a regression in
>   character reception, which can be fixed by applying the second patch. The
>   patch has been tested on the stm32f469-disco board.
>   [1] https://lore.kernel.org/all/20211020150332.10214-1-erwan.leray@foss.st.com/. ]
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  drivers/tty/serial/stm32-usart.c | 206 ++++++++++++++++++++++++-------
>  drivers/tty/serial/stm32-usart.h |  12 +-
>  2 files changed, 165 insertions(+), 53 deletions(-)
> 

Now queued up, thanks.

greg k-h

