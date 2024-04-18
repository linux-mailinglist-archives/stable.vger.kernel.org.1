Return-Path: <stable+bounces-40159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0FA8A93EF
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A34281E17
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925513D984;
	Thu, 18 Apr 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC1igNG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340010A0E;
	Thu, 18 Apr 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424985; cv=none; b=dk83NuJVDeY6QwFXnrKM6Ttl0x5tKCpbUJlzfOzUtZ1s+kyN7S4rUinMUteRUVPU5xR/lhyWiRYSHxHzw3kEGEjpFB6UPQVXP3makXqyw6SILWUoh+h6Ag3KqeApj5lSLEnbSxTKsUo55PiL5JA1A4RN/jNtX1B2AjgvMPnrRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424985; c=relaxed/simple;
	bh=HcL3bdax0vWgbd+ZMV08mblWaeGO7x77npLnawEPafw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3bAiT6uSdJYTnPg1LxbOwFkWU/h2YKaAchzkFwG0k1viarOn4K7QrovwAF8/mteWFxqGLrD8Q3cJBEAQgFKb2JGsdcvbZXO0t/4EskqWoZZhrr6mTUKiD7upH4KVGTdIiaxQvJy+8uv/Ws5PGcusU2xd7QU+7F+nxlR8VOHGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC1igNG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD4C113CC;
	Thu, 18 Apr 2024 07:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713424984;
	bh=HcL3bdax0vWgbd+ZMV08mblWaeGO7x77npLnawEPafw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CC1igNG/40KXu78up/lUkjsTE61ygR3YeH/ZV2UkSUDls5VouKRVSYcMUin5GVa0m
	 NxcAkmKpexwPG/FebECf0Cvg3NSduZVW/FpJVhks5tY2Q8Soh81eaKw8yXoyid/j+e
	 dRfLkWJuBOel+dp2iBh9UTanNkb7R8EqLGV9zKsjngl1NFpFbT1VUyZA5bvrjHLsKL
	 CpK35o7jz3w8WA0luuwfsRS97Ugyg16fRtitjhJoSZHeCjHYzoGEQfmBJbEvoRn1oc
	 cYx9l8sG5ZIUDAuuwYHZmYyFjhKY2Yu3wC6WQESfWQnzGqxFVUCxt9/39mwHHDe+H6
	 6yX9Q/vvhHx5A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxM6s-000000002tR-3Ivn;
	Thu, 18 Apr 2024 09:23:06 +0200
Date: Thu, 18 Apr 2024 09:23:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: linux-usb@vger.kernel.org, Lars Melin <larsm17@gmail.com>,
	stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] USB: serial: option: add Lonsung U8300/U9300
 product
Message-ID: <ZiDKWvLJkfOidH4w@hovoldconsulting.com>
References: <20240415142625.1756740-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415142625.1756740-1-coiaprant@gmail.com>

On Mon, Apr 15, 2024 at 07:26:25AM -0700, Coia Prant wrote:
> Update the USB serial option driver to support Longsung U8300/U9300.

> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> Reviewed-by: Lars Melin <larsm17@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---

Thanks for the update. Next time, remember to include a short changelog
here when revising a patch.

>  drivers/usb/serial/option.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 55a65d941ccb..27a116901459 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -412,6 +412,10 @@ static void option_instat_callback(struct urb *urb);
>   */
>  #define LONGCHEER_VENDOR_ID			0x1c9e
>  
> +/* Longsung products */
> +#define LONGSUNG_U8300_PRODUCT_ID		0x9b05
> +#define LONGSUNG_U9300_PRODUCT_ID		0x9b3c
> +
>  /* 4G Systems products */
>  /* This one was sold as the VW and Skoda "Carstick LTE" */
>  #define FOUR_G_SYSTEMS_PRODUCT_CARSTICK_LTE	0x7605
> @@ -2054,6 +2058,10 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(4) },
>  	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
>  	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
> +	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U8300_PRODUCT_ID),
> +	  .driver_info = RSVD(4) | RSVD(5) },
> +	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300_PRODUCT_ID),
> +	  .driver_info = RSVD(0) | RSVD(4) },

I dropped the product defines in favour of a comment (as they don't
really add any value and we don't have to worry about keeping the
defines sorted).

I also trimmed the commit message slightly before applying.

The end-result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=cf16ffa17c398434a77b8a373e69287c95b60de2

Johan

