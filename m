Return-Path: <stable+bounces-180734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA812B8D18A
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE361B21451
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F8281375;
	Sat, 20 Sep 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpseLoSw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A627B33E
	for <stable@vger.kernel.org>; Sat, 20 Sep 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758403633; cv=none; b=ZiEcYw/kussLqxTDRED++Txk8m75D7KUhHH3ppwoYRDwEkdGIQx5uCiaSGn7U8Vql4bxtl+CkFN0oxG9QjAE7c79G4zOA91RTMnBziJic9exgKH8H9jXAk0C+AR6hmL0lEynx2fVOJqUFPlERe5U0iJkAOMt1AlYykD7h5Klyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758403633; c=relaxed/simple;
	bh=f7gaqrL+IdTMhppclJNecJwlQYDnd8rNalUqZDwS9BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaT12kKsLBfv/v9tchKM+bKIYZYTZ3sI2Xd2Q3qoHc1BiggBhRN5lmKnVC8t8LTDhjxUOH9EJ7eEe+q2zfwlfgiqXVAjXasjgSOTERJX7uLcWr4D/VI26PgIj5mUWkh0b2VHX47SWMP+sjNvQy8Tz1MYiRx3T7lEVfGOoXGsl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpseLoSw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b552590d8cdso1568789a12.0
        for <stable@vger.kernel.org>; Sat, 20 Sep 2025 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758403631; x=1759008431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZag6O+eNvRyqeUVqQW0eazqLmcxqUXmRta6WqjCdqc=;
        b=LpseLoSwx17AelclNn/2XNY/zir9cJREODHa8FLdRu/XsdAIBFMSa/TOfnGYbiZAvT
         zzYEzjixjmGq47BtsGNAb+AW7TOeBNs74QdPSrkqNY2kaSXTbg76UAsHMNtwW3yZxSAo
         7dQQATvqdlQ4c2BDc95hG1ukkUwaEGxoxhFb0Y+23UmiNgFzgFIB9o3nxsdTZawkIEw1
         Q1Y7DedOilyNaUjFYo23mXTt2xieoSIztniDsMB+Ebn6Kc+cvYkwgBF8Qd/qoYNbWiE2
         ZxgJRJqHFTHu+U0zBB2MDnS3QciMn7vsMP9T4BJ0e7LChGDKR6y1LjH5DsilqORReeMB
         SmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758403631; x=1759008431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZag6O+eNvRyqeUVqQW0eazqLmcxqUXmRta6WqjCdqc=;
        b=grj4uCe+K6E6U+T2UHTCBcaUCfOilp/JEMurFySdGZcP+x/j9y4fKAMrNHs8JOxw07
         aLkcRUN3DgtvXj+pgX8T6xJfSE1OPdJ8eLS23mnBeedC5tXHduHh8txMgz6KLvIK7V+d
         aQ/G16aZC3koaLb6Tcz3240xEXvSPXcHLUpvXhOjEGDVLCsyufyX6xAY1QmfG0uWW+hD
         +2OCdCay0pfkYas10sZaUYhJtnmjetL0N9iI0QNiiZFbTQktOHD+1FL4ed28PV721VIt
         fmlhVj8pWq9thV+JnDylypap9R6UhcBS2y3+9QkaMudwPBwUagz7t5kEmyv3D9y+kaPg
         gteA==
X-Forwarded-Encrypted: i=1; AJvYcCUgJJDR6zjm7+WgbAtUerajoZTQhhL+Bws5Ee9SLEiLQyWQSj0itcmDTxtlGP3I5xnZuMq5TMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGERmcmYre1Yu3/g3QaKCn/DYHKEHPoTqCQaXzM5a2YHEWH6Ut
	cj8DEatcmgjy5FKsyEZmE4hZUdizuhJlueastxb4RqRrmHjCjY8CN6XT
X-Gm-Gg: ASbGncu84qkHZYFSRUSJhJE3jBUcx2YyAtaUxlkkmERi5F/Yw0fUzc5fnPqT6Mz1+sn
	KdjD5IS2pdfmEgWT+Vld6JsnQY/3hG/3aOaeBweRKcHIfoQCq41T/tol++5IT0a3HU8UPazkRb6
	hUFrEkmi5VL8jsNhHCXtV1bnhYeQ2rNi2rH63Ez40xL5tynaAjpGF+rpzJiB7ttj4XsvB1dOfXF
	/AEmgFRcZuaCIJuAFr7XUBnhe4egCFGVJxG9nqQpahCbH0PtNU9VsNSG7y8wvp0R1XIANfN4Kpa
	gagcCJ2T5nZEh2aM6KsKmYp0fgE4trWDMAeokjrVf2nBkQRoeRgk+NYdmNlIA2xxEEC0gxHDOX8
	vD4luskkJ2S0JHTrhI5w5wDQ=
X-Google-Smtp-Source: AGHT+IGITBO0tfJKLwT0mwSLK+UoL+A//Eq2cJmFH0SGOX6eRMi/hhWWMwDIlaR00acM/zLrO/w3rA==
X-Received: by 2002:a05:6a20:12c7:b0:263:5c8b:56f9 with SMTP id adf61e73a8af0-2925ca2bd9dmr11817653637.10.1758403631238;
        Sat, 20 Sep 2025 14:27:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fdae:ef9f:3050:cdfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553e0c92acsm1054462a12.15.2025.09.20.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 14:27:10 -0700 (PDT)
Date: Sat, 20 Sep 2025 14:27:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Extend software-node support to support
 secondary software-nodes
Message-ID: <w7twypwesy4t5qkcupjqyqzcdh2soahqpa35rqeajzh2syhtra@6trjploaie6g>
References: <20250920200955.20403-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920200955.20403-1-hansg@kernel.org>

On Sat, Sep 20, 2025 at 10:09:55PM +0200, Hans de Goede wrote:
> When a software-node gets added to a device which already has another
> fwnode as primary node it will become the secondary fwnode for that
> device.
> 
> Currently if a software-node with GPIO properties ends up as the secondary
> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
> 
> Add a new gpiod_fwnode_lookup() helper which falls back to calling
> gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
> found in the primary fwnode.
> 
> Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changes in v2:
> - Add a new gpiod_fwnode_lookup() helper instead of putting the secondary
>   fwnode check inside gpiod_find_by_fwnode()
> ---
>  drivers/gpio/gpiolib.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 0d2b470a252e..74d54513730a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4604,6 +4604,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
>  	return desc;
>  }
>  
> +static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
> +					     struct device *consumer,
> +					     const char *con_id,
> +					     unsigned int idx,
> +					     enum gpiod_flags *flags,
> +					     unsigned long *lookupflags)
> +{
> +	struct gpio_desc *desc;
> +
> +	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
> +	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
> +		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
> +					    idx, flags, lookupflags);
> +
> +	return desc;

Bikeshedding for later. Maybe do it like this in case we can have more
than 2 nodes at some point?

        do {
		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
		if (!gpiod_not_found(desc))
			return desc;

		fwnode = fwnode->secondary;
	} while (!IS_ERR_OR_NULL(fwnode));

	return ERR_PTR(-ENOENT);

> +}
> +
>  struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  					 struct fwnode_handle *fwnode,
>  					 const char *con_id,
> @@ -4622,8 +4639,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  	int ret = 0;
>  
>  	scoped_guard(srcu, &gpio_devices_srcu) {
> -		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> -					    &flags, &lookupflags);
> +		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
> +					   &flags, &lookupflags);
>  		if (gpiod_not_found(desc) && platform_lookup_allowed) {
>  			/*
>  			 * Either we are not using DT or ACPI, or their lookup

Thanks.

-- 
Dmitry

