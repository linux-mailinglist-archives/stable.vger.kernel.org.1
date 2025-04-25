Return-Path: <stable+bounces-136698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E2A9C67B
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9536B465A49
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758172405F8;
	Fri, 25 Apr 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBW3tp0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B223DEB6;
	Fri, 25 Apr 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578884; cv=none; b=lcJRQYBNfMdhFa93unEFKMb3UtOZkArsnoc5V/Qg54uXTAgSlocfNJ7xHJw5U8u5EjsM9/gdnw3cnCt7kohjlSm89VE2XGnY3iampD+Cl66Z1U5ib2fsdU+JXPcoNz9idEjbLMP+XzEJNk/YX6eQQgeAzP+oBCeUxvL0M2f+Ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578884; c=relaxed/simple;
	bh=Gn3QznmvXAavlTZS38XkbgiV8W4CSNb9eLYN5wF0B44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHQiWbLI4g9foHuzn5fKfKeTHjskhGvz8EFKzI2eBut3zsaXtwq6I8neEbL6avh54h6cVI/ad8vuacgAFaJ082LmWuutIlufCmumjsz6tzhY0jPUlUS60PqGbB+Oacv2t3NE8H2OEHCai+Yz9/o8yRf9d1NJOvP7SXMjSVgHBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBW3tp0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D19C4CEE4;
	Fri, 25 Apr 2025 11:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745578884;
	bh=Gn3QznmvXAavlTZS38XkbgiV8W4CSNb9eLYN5wF0B44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBW3tp0FuijVu6piqbkeoxPNBIRzrKowV0GHkB/jyki+qLfmzx26Kg+s8OaUFU0C9
	 xDQJAKoPjS1CDVTBFLMt6Ldzk+QRwRY+KBD6sT2fvDRzj3Mx3Mqq5efG8QW7FayYWn
	 i6vfS3DpNQgRYSC3Xoh0ZB99HW+tmaAWCBmtpH4g=
Date: Fri, 25 Apr 2025 13:01:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: renesas_usbhs: Add error handling for
 usbhsf_fifo_select()
Message-ID: <2025042552-upper-clatter-0d9d@gregkh>
References: <20250422023825.2016-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422023825.2016-1-vulab@iscas.ac.cn>

On Tue, Apr 22, 2025 at 10:38:24AM +0800, Wentao Liang wrote:
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
> -- 
> 2.42.0.windows.2

How was this tested?  I still think this is wrong, as the cleanup does
not look correct.

thanks,

greg k-h

