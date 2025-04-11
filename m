Return-Path: <stable+bounces-132255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875AA85FAB
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACB67BAC67
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC211D79B8;
	Fri, 11 Apr 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fmQx+zP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F25AD24;
	Fri, 11 Apr 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379445; cv=none; b=K6CFIn0syPzYwg3uqkriouPj9pChxLhHffEZbQnX48wiZJfdhHtE0dovKocw6KOKdVaWbbngfI7UCBnJx2nvoJwFXAviC9V0PUd0BbPg/4lSGzLJUh0tS01nZ8ouyLxtYzlGSbpMeaOW/vT2chB1O7pZCq7MMDxfvYKqblJZ9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379445; c=relaxed/simple;
	bh=WVbUWZM/0R8dQ4aHJyJFuK4CcNxXNeH0CZegsHqPlZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCfD1BLF8Nr2jQ7DQ5cl5gMmHkT8+UVHONLoBUxgyIq3dHTKrZDShPXC5OBEfa3E45UuuWCKlQoXa4tNUTIRUXPSIGqVh7q4lCsUjPlmpfYq7VQx8xmTN0xzNfH6EacjANWMbH76xuXed301Gbv0kD7FLX8/oe6VF5KraILM0zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fmQx+zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E482C4CEE2;
	Fri, 11 Apr 2025 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744379445;
	bh=WVbUWZM/0R8dQ4aHJyJFuK4CcNxXNeH0CZegsHqPlZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1fmQx+zPVEHRXYCDKCtMFMlTe37sDe6o7Xz7ADOR0a3WsZHsZYaeMuINsM6QXUIos
	 aYF/9OTwrLfbG1y5X+OtWpeciTDn01D5TsA1BjA4IZwyyf+cmW1xhGMcQFLxDmtIcZ
	 TjjUjaMHCn1OadOXtzgKyeaa+SYHwXUuTQz6ShgY=
Date: Fri, 11 Apr 2025 15:50:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: renesas_usbhs: Add error handling for
 usbhsf_fifo_select()
Message-ID: <2025041154-refinery-bronzing-7893@gregkh>
References: <20250402124515.3447-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124515.3447-1-vulab@iscas.ac.cn>

On Wed, Apr 02, 2025 at 08:45:15PM +0800, Wentao Liang wrote:
> In usbhsf_dcp_data_stage_prepare_pop(), the return value of
> usbhsf_fifo_select() needs to be checked. A proper implementation
> can be found in usbhsf_dma_try_pop_with_rx_irq().
> 
> Add an error check and jump to PIO pop when FIFO selection fails.
> 
> Fixes: 9e74d601de8a ("usb: gadget: renesas_usbhs: add data/status stage handler")
> Cc: stable@vger.kernel.org # v3.2+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/renesas_usbhs/fifo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

How was this tested?



> 
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index 10607e273879..6cc07ab4782d 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c
> @@ -466,6 +466,7 @@ static int usbhsf_dcp_data_stage_prepare_pop(struct usbhs_pkt *pkt,
>  	struct usbhs_pipe *pipe = pkt->pipe;
>  	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
>  	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv);
> +	int ret;
>  
>  	if (usbhs_pipe_is_busy(pipe))
>  		return 0;
> @@ -480,10 +481,14 @@ static int usbhsf_dcp_data_stage_prepare_pop(struct usbhs_pkt *pkt,
>  
>  	usbhs_pipe_sequence_data1(pipe); /* DATA1 */
>  
> -	usbhsf_fifo_select(pipe, fifo, 0);
> +	ret = usbhsf_fifo_select(pipe, fifo, 0);
> +	if (ret < 0)
> +		goto usbhsf_pio_prepare_pop;
> +
>  	usbhsf_fifo_clear(pipe, fifo);
>  	usbhsf_fifo_unselect(pipe, fifo);
>  
> +usbhsf_pio_prepare_pop:
>  	/*
>  	 * change handler to PIO pop
>  	 */

This change really looks wrong and I would like you to test and verify
tha it actually works before going forward.

thanks,

greg k-h

