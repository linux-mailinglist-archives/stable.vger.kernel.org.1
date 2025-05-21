Return-Path: <stable+bounces-145808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31F8ABF24D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DCD3BCBD7
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12222B8B1;
	Wed, 21 May 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyhkiq5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAA2609C2;
	Wed, 21 May 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825346; cv=none; b=BnUhYaf9hIUjeitunCraN/iVUiImG54sJhZfk2t5QXjBYzVTXPRjSRw2T5wFahlrboiHfZuILohT0/ugtX8c0+v0WBaHQN5p6L8NRtvgsTCKVxjprthAGuNuuy1b5j8q486MD/HCmYeG9mRqSN1N/qu0PoK8/f9ut4uN01MUGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825346; c=relaxed/simple;
	bh=NwM+NGfKHHnT2OLIKq+FHRN4Gio7xbZtXQnXe5DJhQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLLRTXN22juRwNDKXO3Id9JBTmanfIWncPyWzpi5PiIfJwPJtQ8HNrcIySPyZN0pjfYwS+RXGIJiWDwQBRKHBPK7LT+JqcqU9jre//hD0tQZXYBIfwXBtO6D6PpF60qpuLx+cEE5wdW+zndOInZzV0wSh/If9UAPmWT6H30bi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyhkiq5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D74EC4CEE4;
	Wed, 21 May 2025 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747825345;
	bh=NwM+NGfKHHnT2OLIKq+FHRN4Gio7xbZtXQnXe5DJhQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyhkiq5n2tRrqHP+RpenrYEMzU/SyB5KuqdW/U3aRN9wKlCD1qdbbs2DLk4kcDqpE
	 3+ZThVMbp3UqV/xpqo8Bg9XXz0tMcba1DvavI49Ev8L3s7jWHAY/fj8Rd7oTO7zZ8H
	 yoqMsfzaATTqlp8C9Gc41lj6JlUjgWQruodE8cak=
Date: Wed, 21 May 2025 13:02:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: u.kleine-koenig@baylibre.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Add null pointer check
 in usb3_irq_epc_pipe0_setup()
Message-ID: <2025052142-waking-monopoly-37a6@gregkh>
References: <20250514095053.420-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514095053.420-1-vulab@iscas.ac.cn>

On Wed, May 14, 2025 at 05:50:53PM +0800, Wentao Liang wrote:
> The function usb3_irq_epc_pipe0_setup() calls the function
> usb3_get_request(), but does not check its return value which
> is a null pointer if the function fails. This can result in a
> null pointer dereference.
> 
> Add a null pointer check for usb3_get_request() to avoid null
> pointer dereference when the function fails.
> 
> Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller")
> Cc: stable@vger.kernel.org # v4.5
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
> index fce5c41d9f29..51f2dd8cbf91 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -1920,11 +1920,13 @@ static void usb3_irq_epc_pipe0_setup(struct renesas_usb3 *usb3)
>  {
>  	struct usb_ctrlrequest ctrl;
>  	struct renesas_usb3_ep *usb3_ep = usb3_get_ep(usb3, 0);
> +	struct renesas_usb3_request *usb3_req = usb3_get_request(usb3_ep);
>  
>  	/* Call giveback function if previous transfer is not completed */
> +	if (!usb3_req)
> +		return;

Why is this check below the comment?  Shouldn't it be above it?

>  	if (usb3_ep->started)
> -		usb3_request_done(usb3_ep, usb3_get_request(usb3_ep),
> -				  -ECONNRESET);
> +		usb3_request_done(usb3_ep, usb3_req, -ECONNRESET);
>  
>  	usb3_p0_con_clear_buffer(usb3);
>  	usb3_get_setup_data(usb3, &ctrl);
> -- 
> 2.42.0.windows.2

How was this tested?

thanks,

greg k-h

