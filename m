Return-Path: <stable+bounces-235691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHmGL+QE2ml+xwgAu9opvQ
	(envelope-from <stable+bounces-235691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:23:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0C3DEF4E
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F3C3040203
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAC333441;
	Sat, 11 Apr 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZBZIM5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C332D0EE
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895683; cv=none; b=PvfZT9iXYH+uoORS1xi9/FqNd2OzhUe0KfN+vCoRhQPRkXFjk4ue4xY+j+vgziWLjxrJpKIkKi4EDBY87jwmS4q/YDJKtTdXnDUZN7Nibp7yeeTCRD4y/YENr6ym+sSVBV+hkadlFpiHCUOG+4y1re1zT4eSaenDymcRR1MeUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895683; c=relaxed/simple;
	bh=vcBjvKGJQYEODT9LGC4wGmOBHIm2sXHhdRxekpKCYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC/N5AkuALmHGfEH7O/bm9myJYWdZKgrCbOwz+FiaqijJ8xUrxQ8XRTLduZp+bERpe5eSnazaTEExEq2D+QwpQkH/fL+1WYY9t3Hx9zgWlwGvNGv3g2uBDAlOe4dBkCy1LXZQ7ryVqlGlDCWkmVBY3BnB+/5DC4XhHtdnIgHv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZBZIM5N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso29889655e9.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775895681; x=1776500481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiA2W6ra0oBmucOD+pQuH4lyD1NksJUw1bImSOanyJE=;
        b=hZBZIM5NJOSF6X4LQZfSmPudh6ZP/NaUCYDgevsN/TPzKFfObKLie5ztgp9KTyZylJ
         Snl4wJ3BWuIlauD3PgoIXy7Pa3bEANsGDyNEXuTEnrMNkSfonRkHHBPG41iFl13RTyWh
         d2Im2A7P3y3FfrNsad4ai9PwSxjhDjv7DKXTwMdHu7hJs8LSFe5f1v8JegL8elFaQL1y
         Fu8qRvQC8xLGTbr/HQVuytJAIcTdjMFObKrC9qmlaRWuAFNQMNfMC1922PzfaKR+Ux4X
         Tu/0IdJYIj/4lU1jqovt4XjkiMYLdirV4CY8dFB5ePy6S8cBl1PaWVveQxVzqODu2U/3
         pgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895681; x=1776500481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiA2W6ra0oBmucOD+pQuH4lyD1NksJUw1bImSOanyJE=;
        b=rWPxJ+zEmyTO8eOclPM8D5HHdwbBqVUnMXXvJKylHhySEJKSijhvzTf43m2zrPykh3
         1bldXmLumF6Xpm8o9JWSaRBf2b6WFkqT0qF3oQQPOo7cn9agB5rx+r18vCNLrV1+Dsfh
         +Qau/0xM0zngEasf2/HiBQhNd4rnUInfU8sfM1T8Ob9+oB2tEt/ZHEJi6zEVqgHedEgB
         6cIF+2Opja1dWI+3ovU7gQKYXhf2FfTVYXUhF9thXlEOLtk2NbVTHvdPE52ZLw9xVqCQ
         2qy0rEh0GaDwzCu7OT5XcGvghjvpfBGcBYpGwAiCDKTS3IyuzdaJgdqeDNnCQkW47hK/
         TVNg==
X-Forwarded-Encrypted: i=1; AJvYcCWrULv23kRtv2ok1jxPe/pRsYvylghHxAL9xLd/0fwlcxhN5aitSAeD6BDX28u+FJaYin7ZqxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKqZF1igF5gPCYqUuCZpvbRJBIafnrqh2BNPxIIW1FLsJt6Pr
	iLBtYrVHyGn7/1RaojApfwmZSZO7bTijlVWE6olaRdsII95yAyWuafCN
X-Gm-Gg: AeBDiesGe//0M9CTvBi9KBKjtl55n2AdIbSuwp1t873cvBlcU9BH5wqTwsTA9Z6tymk
	QeWjIImRbZg01ECfECROfUeBuIUTueXyDjx8DOdwx9DT7mA0PoN3e57ptqAkPa61+FQM5NFV/8z
	Nw3C6edPaiM8eJKlOLCrH4glIyVPG+/OXHtQSN/J38oSQvKe27SZhpznUkdT5wYay3NG8THMNJb
	OB+pvKge8YrGYuP6PjbE49bgNUOTWwrzuasB3jJrBIInC8uxqb8tAJJa9DcL33NxLHnWL+nSV7i
	ioPEfqqTyeo1XYOtcMuaF6od7nvVvbEpfA4SA04uDV1MyD20GA23WRx+6Nd9+fyMCzA37l7QxR1
	pwzSQ4xBzqU80hLKfiYFx9DolzfOsSLegUG3AbHJi0j5nR7P8Z9VI2lA57Vo7hH7xO5otpTMOBZ
	Ug7UgwMur0QhZdXeFzqYi8sZst1oPsjg==
X-Received: by 2002:a05:600c:64c4:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488d686c04fmr73932525e9.21.1775895680711;
        Sat, 11 Apr 2026 01:21:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ef00sm147467045e9.5.2026.04.11.01.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:21:19 -0700 (PDT)
Date: Sat, 11 Apr 2026 11:21:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
Message-ID: <adoEfbDRO_ZsIUx6@stanley.mountain>
References: <20260411080435.2125626-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411080435.2125626-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235691-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68D0C3DEF4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 04:04:35PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
  ^^^^^
The commit message says after but you're changing the before.

> is expected to be managed through the device core reference counting.
> 
> In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
> the error path frees trig directly with kfree() rather than releasing
> the device reference with put_device(). This bypasses the normal device
> lifetime rules and may leave the reference count of the embedded struct
> device unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.
> 
> Fix this by using put_device(&trig->dev) in the failure path and let
> iio_trig_release() handle the final cleanup. Also update the subirq_base
> check in iio_trig_release() to test for >= 0, so that a negative error
> code from irq_alloc_descs() is not treated as a valid IRQ descriptor
> base during cleanup.
> 
> Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/industrialio-trigger.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..ab544976018f 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
>  	struct iio_trigger *trig = to_iio_trigger(device);
>  	int i;
>  
> -	if (trig->subirq_base) {
> +	if (trig->subirq_base >= 0) {
>  		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>  			irq_modify_status(trig->subirq_base + i,
>  					  IRQ_NOAUTOEN,
> @@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
>  					    0);
>  	if (trig->subirq_base < 0)
> -		goto free_trig;
> +		goto err_put;
>  
>  	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
>  	if (trig->name == NULL)
> -		goto free_descs;
> +		goto err_put;

At this point we haven't done:

	trig->dev.type = &iio_trig_type;
or
	device_initialize(&trig->dev);

So the original code is fine and the new code just introduces memory
leaks.

regards,
dan carpenter

>  
>  	INIT_LIST_HEAD(&trig->list);
>  
> @@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  	return trig;
>  
> -free_descs:
> -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> -free_trig:
> -	kfree(trig);
> +err_put:
> +	put_device(&trig->dev);
>  	return NULL;
>  }

