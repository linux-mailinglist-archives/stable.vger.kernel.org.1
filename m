Return-Path: <stable+bounces-203313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A596CD9A16
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 15:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1E730351F3
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63C33710F;
	Tue, 23 Dec 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfv8xKfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C33372A;
	Tue, 23 Dec 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500053; cv=none; b=GwKlofd9BDSX2uuQG1hGTK6iMIFGJIBlc7Vgj8sF5LZN16pR7pJfQYfvvbFzFv09MUZt35g91QkSKrfRnzFHa2vfNPKCHTQWG1VgmNMLcaUXSGakpYWxER2oaK6khB8CTFXL5aZK9Nn8ZVzMHhyolfWCNhrSTHcydmb1oE7ZLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500053; c=relaxed/simple;
	bh=icBEl8Zbktq9bZa0C7MLEY1JA0FECoyQ8ZNhMQCbl+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luNy1bVcjLQCnwkOq+Pxrr6nXdW77Z9kH5hxFMCJs3LOd7+IwS8bIGIV0ueeXKFkcf8hgXXbehNYWDz2VioUM86sNz7fYz4NJKOZ69/UmMoSm9yBjhIx/G2ZdaU5pkAh1HgIMRwb/oBepVLLd7jL3ihdz6NX2lnzSoP3a8js6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfv8xKfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A4C113D0;
	Tue, 23 Dec 2025 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766500051;
	bh=icBEl8Zbktq9bZa0C7MLEY1JA0FECoyQ8ZNhMQCbl+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfv8xKfCSfCOeaWWPt7oAqaXnZB4sx8nF5d3+au6DKInfiuUN09NtBi0kg5JZY0Ts
	 zrPTbsGdZIwjOgwW6VuAN6enSLGJTBgqXHRWjZg0qMhZSajw+jwy81/0WwCmbBZ9d4
	 ivTXer4f784fheJptzBj88Mc3RlAsSg/Ee4Hxq1g=
Date: Tue, 23 Dec 2025 15:27:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: heikki.krogerus@linux.intel.com, sean.anderson@seco.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: ulpi: fix a double free in ulpi_register_interface()
Message-ID: <2025122313-pebbly-petunia-5f2d@gregkh>
References: <20251219154859.650819-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219154859.650819-1-lihaoxiang@isrc.iscas.ac.cn>

On Fri, Dec 19, 2025 at 11:48:59PM +0800, Haoxiang Li wrote:
> If ulpi_register() fails, put_device() is called in ulpi_register(),
> kfree() in ulpi_register_interface() will result in a double free.
> 
> Also, refactor the device registration sequence to use a unified
> put_device() cleanup path, addressing multiple error returns in
> ulpi_register().
> 
> Found by code review and compiled on ubuntu 20.04.

"compiled on" doesn't really provide any information, sorry.  Espeically
for a VERY old distro release :(

How was this tested?

> Fixes: 0a907ee9d95e ("usb: ulpi: Call of_node_put correctly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/usb/common/ulpi.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 4a2ee447b213..c81a0cb24067 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -278,6 +278,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  	int ret;
>  	struct dentry *root;
>  
> +	device_initialize(&ulpi->dev);
>  	ulpi->dev.parent = dev; /* needed early for ops */
>  	ulpi->dev.bus = &ulpi_bus;
>  	ulpi->dev.type = &ulpi_dev_type;
> @@ -287,19 +288,15 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  
>  	ret = ulpi_of_register(ulpi);
>  	if (ret)
> -		return ret;
> +		goto err_register;
>  
>  	ret = ulpi_read_id(ulpi);
> -	if (ret) {
> -		of_node_put(ulpi->dev.of_node);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_register;
>  
> -	ret = device_register(&ulpi->dev);

Splitting this up into init/add instead of just register is usually only
done if you _HAVE_ to do that.  I really don't see why that is required
here at all, sorry.  Are you sure this is the correct solution?

thanks,

greg k-h

