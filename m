Return-Path: <stable+bounces-154640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBBADE4B9
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 09:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2733BBA36
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508227EFE4;
	Wed, 18 Jun 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygjFBizO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8C1EF389;
	Wed, 18 Jun 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232699; cv=none; b=KEnptIqutrsflHhQKs8OLk+dMZJ+yx6v7GMQVaXS6pcjhFY11xJP1UqLOhcbm1C2cF0pxQBYEzGvV4k/AP3s+TqdL+yGuoxE2BSU6a1er9aXNu5YI9jY7QGwYntLZxKLa0NJ7+/VBokg15upbIj580VvIZN9T8sJuwiUJuio6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232699; c=relaxed/simple;
	bh=FFNidNQVJhVMPvZDCBwpffmyOW0CnVZwvZqZUZahEbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpHYQ9rVYF4z4I5oQnkl2wtKItedi+2vSCRIQrM1EPhu8VTdEozXNZaT2i+6Y+AVbNv1inQy5MNuZlTkLhAb83NQKwy4V+ECb3dIOGn2hCJCxzchKwSLqC3X8XietRfVnwsdgH0/bwUkmg84QiWicqLxJKY1RVK3PoW6KG/9qSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygjFBizO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A623CC4CEE7;
	Wed, 18 Jun 2025 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750232699;
	bh=FFNidNQVJhVMPvZDCBwpffmyOW0CnVZwvZqZUZahEbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ygjFBizOCM1fgb9sj+yJSWW2zJ1e7Z4lQU3fMQjVZne+1nYCdeD4dfHmBD5b9lN1H
	 Ld/WnlAt6sSO6i/HaxMIHPu21h8/t7Zn8jU45pkTl3CMFML+o/pplBptXsjRMS+qO1
	 1mDvLWLSeIJ0NA0ok9J7U3TalsTn+zTDDBAD0LEk=
Date: Wed, 18 Jun 2025 09:44:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vincent Cuissard <cuissard@marvell.com>,
	Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] NFC: nci: uart: Set tty->disc_data only in success path
Message-ID: <2025061838-frustrate-operative-bd34@gregkh>
References: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618073649.25049-2-krzysztof.kozlowski@linaro.org>

On Wed, Jun 18, 2025 at 09:36:50AM +0200, Krzysztof Kozlowski wrote:
> Setting tty->disc_data before opening the NCI device means we need to
> clean it up on error paths.  This also opens some short window if device
> starts sending data, even before NCIUARTSETDRIVER IOCTL succeeded
> (broken hardware?).  Close the window by exposing tty->disc_data only on
> the success path, when opening of the NCI device and try_module_get()
> succeeds.
> 
> The code differs in error path in one aspect: tty->disc_data won't be
> ever assigned thus NULL-ified.  This however should not be relevant
> difference, because of "tty->disc_data=NULL" in nci_uart_tty_open().
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  net/nfc/nci/uart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> index ed1508a9e093..aab107727f18 100644
> --- a/net/nfc/nci/uart.c
> +++ b/net/nfc/nci/uart.c
> @@ -119,22 +119,22 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
>  
>  	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
>  	nu->tty = tty;
> -	tty->disc_data = nu;
>  	skb_queue_head_init(&nu->tx_q);
>  	INIT_WORK(&nu->write_work, nci_uart_write_work);
>  	spin_lock_init(&nu->rx_lock);
>  
>  	ret = nu->ops.open(nu);
>  	if (ret) {
> -		tty->disc_data = NULL;
>  		kfree(nu);
> +		return ret;
>  	} else if (!try_module_get(nu->owner)) {
>  		nu->ops.close(nu);
> -		tty->disc_data = NULL;
>  		kfree(nu);
>  		return -ENOENT;
>  	}
> -	return ret;
> +	tty->disc_data = nu;
> +
> +	return 0;
>  }

Looks good, thanks for cleaning this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

