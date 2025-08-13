Return-Path: <stable+bounces-169402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB74B24B95
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEDA5C0F37
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405E2EB5B4;
	Wed, 13 Aug 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hX1tM0qX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E82E5B0F
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093651; cv=none; b=AK8JqgbpE/j9y5UgyfOSR/qLHQf2YQMHOjrE9JtG/qU7TLyyJmz5yMbFPJ6Sc8w+I/E1Z4iM7Rl7dl6358Up8nsjQA1PjsYx/q8e2mQm0sHK18WIan6PUSnL9Cs6y0jnIGP1tBo0a84TvpP4EkvNSqkOV8fW8eLq+LFr4soO8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093651; c=relaxed/simple;
	bh=UsGW5uN88QfodskVKu0bk/zEoPGB6z7yLng9J3kJqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRx2+89uq+VPGYR6gSSYBdEHul1d4sYs1pq4DqFsLtvvgHmcrFKeAzjDa5LEYuiFySpK6tWng68gPtgCSdsZsgyMEedVAkFF3n5HTMlodLrIvGDoKhXFpYFtZ41ygMoekmq6VkzJaKt0hCg30Czg8RSLgN1d8jSGTPYlenhZJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hX1tM0qX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b07d777d5bso74375571cf.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755093649; x=1755698449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc31v2yJfn5lC70LsWzHpGyS8F15AJd43KPnoZNTig0=;
        b=hX1tM0qX1hpfCCM0ATyINtwaAKyg9z8ABBa1fyJQNUPuBTDUYVEbWTKjA4rwf2bji/
         elvxo47HWeTZOH+HoEjfOMDVfNhe1C4Am+3HnpAQp+7DcI4tD+2o8+Nc5lTuMY9bPeyR
         pdSleUu2Y3/zgYNClEQfKG1ZKlU1QnKne5FTrwk+GzqFES7j4XX484g/XVzOO3Rz2Vyl
         VAGwkfezdSaFmaFimZVAK0iEEF6vpLlEbNKfHjUQY3xQmkI18cjdfwZ2Ou7oJ55GZJYk
         bv/C7N8h1BCFxAxZiHvtvBOgcFwZk1Zl1FYe80QobZY8GzF9kELr6s+xn/fsO4jaYgAs
         waQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093649; x=1755698449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc31v2yJfn5lC70LsWzHpGyS8F15AJd43KPnoZNTig0=;
        b=Puum9NC1K4vU/84/53T5wDajLh5SXyKCuJTglJG4jp4dH2+6FyBPbpHu+ize+hduws
         R/Qy9rz3v/VDcI2HXHNUFhNAFuSS5imzUz1BjAwwzCSmCH4NpRJk+/VgLsrquwqdgi8W
         2Ah8FNaeQx2bnEKDq3IaUguzSZNBQjdixVgTCcJt4gfp9wjswF49TQo1ek++McxJkHsr
         VB6QJiwpjxxl+o6zPS+uCqhEhmI3jWQH8IuNxHTHPJSpBh7WqNhvT7cAHonGl/Rn3HTP
         VhzEo4VGo1W2ynVat4VW4/Q9FnTmAQL+UaJWHE14adxvHnzyy/zAcpwx0nWGnXmE/skg
         CaLw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7L+c9yclMzHySncXcG14FJIcc7yZWlzOVeG8UP9Y5Br+xp1CYuw01Re1obv+kiPnxXDyVhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOulHca/VY/ak078PB9ToxLEIYL7F0oHPJsrEs9uHUR3EMc0Ex
	QK1LA3NdMDoOhnZwT/3XtPeoeeHrCZ59eN5OKIrWRqDBADMpdGKVU52RBdMC3jzO1w==
X-Gm-Gg: ASbGncvzYlo8fl2uFChEtzjLhVlpkcKuHBpfqRHBwqlBXIfo5tVUDDWZ47WsPwNnG18
	omL7hY0U09k7x9M444IiKESgewWJ1QC3uxgvbUC9TLsey7ktuEIUVVBDLTvgGLlo3y+kFAQj+hD
	vL/4VIKHsN3GJ7Bg7XatxK1RZULE4wgnwvHfn4n57ogatDCuf+7xroZA8wSfYu7m+l7874TuHrp
	QlGvePt8c5PjVRTJrUTfOYOp274BD2F0+fZTIOtrJlDv2WLeC8R2/V1EU7T3cEkoyFB7kqvlk2J
	ilhcPH2GhD+oS5YbI+d2ziQwacUr95qRbAm1dftnKOJgPrz8Aj9sqoayd7b/zPnUMQWgVX7AueW
	Q7NRuhYxGPjNMfDVpeXAhxTc1ZhDtbNPkC8Iu7oFs
X-Google-Smtp-Source: AGHT+IEfhlGUyZwjmFmc8w/5qnUy1OjJjl63ruLaNjye3n5HyB1AIXAaAwqg8IppikZVDelkkPlPTA==
X-Received: by 2002:a05:622a:4818:b0:4b0:be3b:d40 with SMTP id d75a77b69052e-4b0fc86fa65mr41526931cf.40.1755093648934;
        Wed, 13 Aug 2025 07:00:48 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b1080bbf35sm933301cf.15.2025.08.13.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:00:48 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:00:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	wwang <wei_wang@realsil.com.cn>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: storage: realtek_cr: Use correct byte order for
 bcs->Residue
Message-ID: <5c190936-7c9a-4577-87c2-f79975725787@rowland.harvard.edu>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
 <20250813101249.158270-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813101249.158270-6-thorsten.blum@linux.dev>

On Wed, Aug 13, 2025 at 12:12:51PM +0200, Thorsten Blum wrote:
> Since 'bcs->Residue' has the data type '__le32', we must convert it to
> the correct byte order of the CPU using this driver when assigning it to
> the local variable 'residue'.
> 
> Cc: stable@vger.kernel.org
> Fixes: 50a6cb932d5c ("USB: usb_storage: add ums-realtek driver")
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 8a4d7c0f2662..758258a569a6 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -253,7 +253,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
>  		return USB_STOR_TRANSPORT_ERROR;
>  	}
>  
> -	residue = bcs->Residue;
> +	residue = le32_to_cpu(bcs->Residue);
>  	if (bcs->Tag != us->tag)
>  		return USB_STOR_TRANSPORT_ERROR;
>  

Acked-by: Alan Stern <stern@rowland.harvard.edu>

