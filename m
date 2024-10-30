Return-Path: <stable+bounces-89364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E99B6D48
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925971F21A10
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9C1D130E;
	Wed, 30 Oct 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y06cLp9y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E291BD9D8
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318963; cv=none; b=OPVwi3xyC9714dlrTvlVkMEZVsc/3rXtwEWYLL0eXb8M4kqSwL82hXYf7vMZYEffIi2ZMh0yBIbd5FY1gu8GIq3X4RHuN4MTXX5k82iVzJ4uD+PVRhOUMqOKVTPXuzTw9A5O+hW9Km/yZNQqHo7Wk8IP9b9uXLHgp9KPRn0qt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318963; c=relaxed/simple;
	bh=3GoHIUWOXuWToSJdXx7r5+OSBW9SUiHpsppQuFb0JkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCbG/7mmHzfyXkReTWLG4E8SE4qivbVN/4zJ60ERo2kI9B0JtyIXie62gIvhHgcQdnt+WPvP423u0JI1sisa2HnnEkFEIkwfnPi8jsuLbF7Y5mGJV0IrfkXCCeDn3eVKlqmT8Se9Okbsc59qcpoUvUh0XnBKrYJOkWF7hyt5z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y06cLp9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730318960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAhOKy8AaoE6kjDoU5Y+aFbm5DQKBGPLCE/gtj6bSE=;
	b=Y06cLp9ywpM/bcppsBYuavbbk+Fz8wxMx8SSXuVbtglq8mZvmMqx63Tbk9lgno61DjC0p3
	1ba5PSrhe4nj7y7wQzqAavkGyKqsvQXxGGyLDPCoV/ZTCzBv7eYMcQxG3RdzIv5qpMzziY
	/J6Oea9pehqHJ1PJeZkoNB4OH69yNug=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-TJwACM7QMDOrI-tcZFcJbQ-1; Wed, 30 Oct 2024 16:09:19 -0400
X-MC-Unique: TJwACM7QMDOrI-tcZFcJbQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b15c3ad7ceso24758085a.2
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318958; x=1730923758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWAhOKy8AaoE6kjDoU5Y+aFbm5DQKBGPLCE/gtj6bSE=;
        b=rmo/FjiVo+yGwecejBUQzmD+ad7B05nPe9ejWjAIM2DnmBcyW0WulvCgT3b9X9+0g4
         4nkaP276SSux+DYBEJU2cnYZzQ1lM6v/VKqJr55sRSfmF58RJ+9RMkwmXW5LgU5c0hQu
         NNT/4oLh31k8KVeECIDC+cSr/UbQBGeDgvFU32PZb1qBqq25mqLpeRmy3OOVxAgKwId/
         GF1oQIk4o5BYoCRfByng1++EozhXLp5rapkn3rDw41ad8xqfpzOPHLDZRx0JfkVme9G6
         rHLecedTanidwr9Epxjrzol8kkl3eIkjrH9ZBbtH3KgmqqVTCFrkfUD4VDvRjlulowgg
         gzLA==
X-Forwarded-Encrypted: i=1; AJvYcCVvLxBrhVpmV2cduIC/szupO6fCv8T1VRT2sJCf3lYfMtc5HsW3Nw3KoQ/unmxXEIIYjbeEQEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPdTcO5l3bmyJy6/jfOryxpc8dM2HBuUDmgVj3KMfyGEXQNvo
	AR6I0VblgnzdtHKD1Wfhk/fDDpinrPtR/qml4MJIiRK2g9PYWy/hN/eiuPT1Gj6dPaCTrcigHSW
	HEgNh52LL1/LQ2jK2YfCp6ZNNR6KC0nkU++LVSerrvDJNt5HjygczDg==
X-Received: by 2002:a05:620a:4449:b0:7b1:3bf8:b3cc with SMTP id af79cd13be357-7b193efa025mr2481312985a.17.1730318957922;
        Wed, 30 Oct 2024 13:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESiC+ZBshjKIPN+xWOccI73zuzKl0nIkRotTScN/UA0F/oksFRqHkq6WeD3OlPrRtZpSE0bw==
X-Received: by 2002:a05:620a:4449:b0:7b1:3bf8:b3cc with SMTP id af79cd13be357-7b193efa025mr2481310785a.17.1730318957629;
        Wed, 30 Oct 2024 13:09:17 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7be9sm400085a.33.2024.10.30.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:09:16 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:09:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Message-ID: <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
References: <20241029223647.35209-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029223647.35209-1-jarkko@kernel.org>

On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> according to the bug report, as this leaves window for tpm_hwrng_read() to
> be called while the operation is in progress. Move setting of the flag
> into the beginning.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8134f002b121..3f96bc8b95df 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		goto suspended;
>  
> @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
>  	}
>  
>  suspended:
> -	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> -
>  	if (rc)
>  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
>  	return 0;
> -- 
> 2.47.0
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


