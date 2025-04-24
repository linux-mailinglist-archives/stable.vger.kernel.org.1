Return-Path: <stable+bounces-136597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0041A9B0CD
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C643BB51E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4C1A2C25;
	Thu, 24 Apr 2025 14:17:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AC17A2FB;
	Thu, 24 Apr 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.186.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504223; cv=none; b=VMCR4iiWiwEDxADDwSgg93Xp7QLD0A1jb5btgTdqBJLUXluub5gVPAcX43+x9cb1QdDAmqSoKsraxm3A4+8BTpVuU+Kb3djOZqy0lbt3aHKm4IvfNz/URFibkk4wqyEH50X8FLltnn93xSEHtt22v280ei8NJ3GdKaWOOnhtJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504223; c=relaxed/simple;
	bh=zo2TnXsQYlaSKgJ4ENhrVxFq06aOKbF0z6oD6YQH70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWz3qE9833QRnoYbG4Xxp+CMf+KNfz2JwqlvNntmc9PKCDMU7sIMFvJBg2+cZgwyCUhuGEe5gpZNgnU/C3tXY1tdTRjhzXBvpjptAomyBCi4E33he+OWY5m7lQ4RBsFhHYiat0kT83ThhDEuHvyhRiz269Z3V5LGyePs0ybw8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk; spf=pass smtp.mailfrom=v3.sk; arc=none smtp.client-ip=167.172.186.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v3.sk
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id CF5D3DF929;
	Thu, 24 Apr 2025 14:03:40 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R8LejtgJeqgC; Thu, 24 Apr 2025 14:03:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id 4FD6ADFFFC;
	Thu, 24 Apr 2025 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ttumpklmL8mi; Thu, 24 Apr 2025 14:03:40 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
	by zimbra.v3.sk (Postfix) with ESMTPSA id 12E1DDF929;
	Thu, 24 Apr 2025 14:03:40 +0000 (UTC)
Date: Thu, 24 Apr 2025 16:10:23 +0200
From: Lubomir Rintel <lkundrak@v3.sk>
To: Christian Heusel <christian@heusel.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "rndis_host: Flag RNDIS modems as WWAN devices"
Message-ID: <aApGT9V9HELMrmaV@demiurge.local>
References: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu>

On Thu, Apr 24, 2025 at 04:00:28PM +0200, Christian Heusel wrote:
> This reverts commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8. Since this
> commit has been proven to be problematic for the setup of USB-tethered
> ethernet connections and the related breakage is very noticeable for
> users it should be reverted until a fixed version of the change can be
> rolled out.
> 
> Closes: https://lore.kernel.org/all/e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu/
> Link: https://chaos.social/@gromit/114377862699921553
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220002
> Link: https://bugs.gentoo.org/953555
> Link: https://bbs.archlinux.org/viewtopic.php?id=304892
> Cc: stable@vger.kernel.org
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Christian Heusel <christian@heusel.eu>

Thanks for sending this out, it really needs a different solution.

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  drivers/net/usb/rndis_host.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
> index bb0bf1415872745aea177ce0ba7d6eb578cb4a47..7b3739b29c8f72b7b108c5f4ae11fdfcf243237d 100644
> --- a/drivers/net/usb/rndis_host.c
> +++ b/drivers/net/usb/rndis_host.c
> @@ -630,16 +630,6 @@ static const struct driver_info	zte_rndis_info = {
>  	.tx_fixup =	rndis_tx_fixup,
>  };
>  
> -static const struct driver_info	wwan_rndis_info = {
> -	.description =	"Mobile Broadband RNDIS device",
> -	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
> -	.bind =		rndis_bind,
> -	.unbind =	rndis_unbind,
> -	.status =	rndis_status,
> -	.rx_fixup =	rndis_rx_fixup,
> -	.tx_fixup =	rndis_tx_fixup,
> -};
> -
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct usb_device_id	products [] = {
> @@ -676,11 +666,9 @@ static const struct usb_device_id	products [] = {
>  	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
>  	.driver_info = (unsigned long) &rndis_info,
>  }, {
> -	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
> -	 * Telit FN990A (RNDIS)
> -	 */
> +	/* Novatel Verizon USB730L */
>  	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
> -	.driver_info = (unsigned long)&wwan_rndis_info,
> +	.driver_info = (unsigned long) &rndis_info,
>  },
>  	{ },		// END
>  };
> 
> ---
> base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
> change-id: 20250424-usb-tethering-fix-398688b32dad
> 
> Best regards,
> -- 
> Christian Heusel <christian@heusel.eu>
> 

