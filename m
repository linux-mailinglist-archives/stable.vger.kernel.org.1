Return-Path: <stable+bounces-113947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F40A29689
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8843918883FC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202A1DA11B;
	Wed,  5 Feb 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="QeiPBh2J"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B81191F7A
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773884; cv=none; b=pwg6QAbB6ntjRaG5Qi2+LUWS8y+VnPghpJ5uOsphKIPeSG1rqEOPsmsDhX3ggQpjLVfGt5y/iqIedYKjWWv6TMAo6DD3zu6HF8sUi5UPsK4kO/EXxhUaG6HC83xczOGsPrfec2mfFguYXu3gsKS80Iovc7t5ezrVkQpqPkVcEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773884; c=relaxed/simple;
	bh=bBU+pt61zyAtW2Ud1OYyE3Ce2NAzO80oqdMnELCX/GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1bsgmfH+fJPaC6e+Ti4/LNxRKMDhvVBo2B7eamUqHNJXcaBf62xJretSeCVXhocwNlFwYs8LExvIOipk7NkcXe+5n8Sm47feCq5vTWnrg2yLwIxD2G5i+Hj0pJKfjSOtaf8KchG0k6TI3tRQoCy3DkfSEzqmBhZpW2jaUfQ1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=QeiPBh2J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46fa764aac2so91521cf.1
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738773882; x=1739378682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjoGXlkAkW/LVx7Wgz5EofRxkYv+KJC4KXFoMOpGEvk=;
        b=QeiPBh2JbO6rVhZA1hyLVAaaLxWulf6Xwy/FPxBtxqntRjb11SzXtv6WVKtXESqYPJ
         Hp2N+jYFF/CnMdhnJQy0K560vNFnv4SULoXWWWl3nlcPSGmj5IH59oAtBNIhefa+1UH3
         LbRWEm9RWjExsJoJ/xwSqyGcpWdR+TfhtIlUmSwIi/qgty773D+/ViasyThjwRNq0o31
         9k32m3JchRNlW0V463rOKK+ceZxa1A5DW7o4eEUHddPevLJPSulRIOGIYRMarPMn7cKh
         FOKsIlIvWqJ+DvBX/8cnaz4advKktJKo8A6ZRXL21zU3dNeA6R0pafilgDYF2hx2ccZZ
         oCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773882; x=1739378682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjoGXlkAkW/LVx7Wgz5EofRxkYv+KJC4KXFoMOpGEvk=;
        b=r7rpucyGT/SWbI2R0CyhmVQjV5KHmGbQ6LVQTwlgAux5CcOPVow2JG/4Nx+YbyCWc/
         s/XTi0TStkbG39KBxAecmFcgpc26DeXyWZ1WFf9J+4ediRt16FfuYiogU8ehGbDOW+vX
         fXgtECviyDtTwzXxwy8tqsTEH+qxbmkNfpXjAOzI+4XG2tEMMs3q1ZuuZdZFDknnlgee
         ODN1VpJaQ6zcNV59NKRule7AmOy3FTy3dHJsVCS1Tl7XevUqGAGlVm8hoJ2scyePD4CS
         IvdQO58qse/QQ4mZOV8leGnpBaHLX9+6wtM6eBgs44GGHLlEk0/mlaRGdgb3KBdroAKx
         WMZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bZwLrUERCih0uoKZjXB7L3AfVozwPyaTsByyj0poXdgujd7R0JtUv+luB/fsiSPpgimu32Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2MYsrKgGNo6Iiv4FX6Hj8ZnsqN9m9tjMD2Gcx0C2phgC6NUo
	X0yUiASlrq7bWJI56iBtDmVWD52xLV1WGDd3XA2akAlgiReeNGXAkjjye4mx8Q==
X-Gm-Gg: ASbGnctuTy8gUXQurLI1xu/BmBSll1LzKJnalKQYGuDLLqHirOYdCkkgjMhZOOovtpn
	1G0o7aGpKK09uHjIMZa/abK6v8JM6mE75MoQblRFSKO5sn9EA7zsKYzNLL2OV1BpCWtUmOaWcwK
	4huHpkQVENZ045JEsDwRK1ok7Vk4YqoMUI06181lcCznLkj4rqNNKfZFIS1EfC04/UQJsitULms
	ZS0Zd10Af9CDce+TvuLYGHs5lojO74wxJZQiSGXMkdWgmeFmm/f8q5wnu5Adm3U2+BaB6sCY9OW
	b2tY5Z6ceD4gDD7ZUTICAnC4X7IqtQglky8q2IhPZxhDdKLQiW9guW/hZ0xtIsG9IyRpUA6PurV
	CumPEKAm4
X-Google-Smtp-Source: AGHT+IEJJIFFkoN3GGHuFCIeaeqDpk11sq27Z6ttoSKnjS+COwjd8IQQqwUcMadaS0VY1/XoRDycYQ==
X-Received: by 2002:a05:622a:81:b0:46e:23bc:8589 with SMTP id d75a77b69052e-470281b8dcdmr57411681cf.13.1738773881979;
        Wed, 05 Feb 2025 08:44:41 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-21.harvard-secure.wrls.harvard.edu. [65.112.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0ceacesm71401691cf.31.2025.02.05.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:44:41 -0800 (PST)
Date: Wed, 5 Feb 2025 11:44:39 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Roy Luo <royluo@google.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, elder@kernel.org, crwulff@gmail.com,
	paul@crapouillou.net, jkeeping@inmusicbrands.com,
	yuanlinyu@hihonor.com, sumit.garg@linaro.org, balbi@ti.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: flush gadget workqueue after
 device removal
Message-ID: <f083ad19-bea8-4a51-834c-14d6810699fe@rowland.harvard.edu>
References: <20250204233642.666991-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204233642.666991-1-royluo@google.com>

On Tue, Feb 04, 2025 at 11:36:42PM +0000, Roy Luo wrote:
> device_del() can lead to new work being scheduled in gadget->work
> workqueue. This is observed, for example, with the dwc3 driver with the
> following call stack:
>   device_del()
>     gadget_unbind_driver()
>       usb_gadget_disconnect_locked()
>         dwc3_gadget_pullup()
> 	  dwc3_gadget_soft_disconnect()
> 	    usb_gadget_set_state()
> 	      schedule_work(&gadget->work)
> 
> Move flush_work() after device_del() to ensure the workqueue is cleaned
> up.
> 
> Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Roy Luo <royluo@google.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/udc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index a6f46364be65..4b3d5075621a 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1543,8 +1543,8 @@ void usb_del_gadget(struct usb_gadget *gadget)
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	sysfs_remove_link(&udc->dev.kobj, "gadget");
> -	flush_work(&gadget->work);
>  	device_del(&gadget->dev);
> +	flush_work(&gadget->work);
>  	ida_free(&gadget_id_numbers, gadget->id_number);
>  	cancel_work_sync(&udc->vbus_work);
>  	device_unregister(&udc->dev);
> 
> base-commit: f286757b644c226b6b31779da95a4fa7ab245ef5
> -- 
> 2.48.1.362.g079036d154-goog
> 

