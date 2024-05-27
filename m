Return-Path: <stable+bounces-46459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C98D04DC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B628B034
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CB16FF38;
	Mon, 27 May 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrTFd1KC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C616191B
	for <stable@vger.kernel.org>; Mon, 27 May 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819975; cv=none; b=A9c2ryXZ0czFVioRrYEohI+BM4Rgm0cYnQjqtDpNCpPsj2aS+A/eN6aW89XOBNuLE9uFpa4D1oxcxP0ap5VZNFk6aj9lqWGPrQcJYWVKJdIBbaC66uM0eX9JaGz0jrhgdJ90FoRtT9WMtEDoy5Rt+ulXbmZJ+votSHgKiy3QblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819975; c=relaxed/simple;
	bh=mIexTCXVeUPx/vSiQvIkN6fMNuyrTcPp/6jeHHlIuU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAUBoKe1+h5B05zTVkbZ+wCbQG1rBGbQqBJ3RQtY/qUttpVHLNaAc47+xu3FvRn+tYJq8cTECOHEex83YRA7ygK3yp2CYD18A+wrF/6/KDbGVXeZO7ViSI+kBdswiFb72k/9PMab35PA+6jaTCcCaPo7qXS8hoi+NlrCMHxAmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrTFd1KC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso302834966b.0
        for <stable@vger.kernel.org>; Mon, 27 May 2024 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819971; x=1717424771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v7c0ZrJPynvxMLH92Q3X2WTOon5tSRNZ2c7KU9q10EA=;
        b=nrTFd1KCvlLfA//4I+gCqd8ZcWdfnLCJ3ucTz510/Os2KxkVEy/PwsXga90ubfXQiS
         belfAJa7pFpPIqeygLzvUlwUdW2WNMOQ8lfAfJmPXVjRIA86bfTA0ilOc7YnsFuGgDWN
         LRAATof3mgk1AQ5AQuHKGxCpFx9t8LDjCMeBja5hVF1GZR6stDUd62+RZfK8K9MNcQJB
         VuiXxiZbZkawFldGGq667R7AdA6X7gsuhZCaIptDCeUJ8v5w4LLNuJ3Tjng1IqZ+MD5l
         GTCDzY4+w5YJzZ6eIhqM1CtveMyzWcA5AQxGHLWQWASQWZrWfIv14ZhuNm91OSu2KKvv
         7nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819971; x=1717424771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7c0ZrJPynvxMLH92Q3X2WTOon5tSRNZ2c7KU9q10EA=;
        b=AKy317tIsqQE/X0vzeR20O3vnZpYckHYiAwIeiYucOhCYj/jiCBGOsX/Ip1MbugOzq
         bhzko/2ZdIWCXDHE8F9G8FH9fAUzHKvayVb6aheyB03q5kx+qrKx1511ttoiWEo1SMZo
         0OPwjMlLwLJZ9PFXndxpqkorim80N2cdPT+grXXbsrNmLSNt0D9LdHow23Sz62H5OQp1
         cCNf0t4JQDJ+RS8x0CKDfMIXluv9+j65DQxEoRSxMrv4Z61taIZ/+4vLav5INXcGq2hQ
         7pge01wHhxNQoabB0aPk9d3rBnPWmfQPoK40pVpMGcb8xnkzGnivC+llzvNqCQxzcbes
         lTow==
X-Forwarded-Encrypted: i=1; AJvYcCW2Wzk+cynhk/A1slhlLa6pXUgunbdDz7Ss4jHFMOxal0Kb2w1fOit6i4NugIqQhYQJz0ZEAjhIPypnS/yBb5gV235Eyrg6
X-Gm-Message-State: AOJu0YzqDKKffH2XwYuaUByyKbMBD2Bmq0ytEV9Zj51YSsxssQMC1AsI
	+FqFfxBTJVa5mrjXdj32vm4Zj1WOZF0A8h6f8j1Jrb2hX4UE10O8RgGu5kvpOFM=
X-Google-Smtp-Source: AGHT+IGDy6lBIZRlSXWUHrbdvlDpDLY1u7lkMBWjrjOr4cWf2ElMKM1ipIguJpApXRrP72OijJSLjA==
X-Received: by 2002:a17:906:3614:b0:a62:8116:cb59 with SMTP id a640c23a62f3a-a628116cbf3mr535401266b.30.1716819970946;
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6283119b12sm420845566b.192.2024.05.27.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
Date: Mon, 27 May 2024 17:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to
 errnos
Message-ID: <50e1c6a7-f583-4b5b-997b-2e505b3df0ec@moroto.mountain>
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
 <09f2f3ac-94a7-43d3-8c43-0d264a1d9c65@moroto.mountain>
 <7d475c6c-8bbf-86f4-b2d8-8bc11cb9043e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d475c6c-8bbf-86f4-b2d8-8bc11cb9043e@linux.intel.com>

On Mon, May 27, 2024 at 05:11:32PM +0300, Ilpo Järvinen wrote:
> On Mon, 27 May 2024, Dan Carpenter wrote:
> 
> > On Mon, May 27, 2024 at 04:23:44PM +0300, Ilpo Järvinen wrote:
> > > diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> > > index 6f3ded619c8b..3377667a28de 100644
> > > --- a/drivers/gpio/gpio-amd8111.c
> > > +++ b/drivers/gpio/gpio-amd8111.c
> > > @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
> > >  
> > >  found:
> > >  	err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> > > -	if (err)
> > > +	if (err) {
> > > +		err = pcibios_err_to_errno(err);
> > 
> > The patch is correct, but is the CC to stable necessary?  Is this a real
> > concern?
> > 
> > Most callers don't check.  Linus Torvalds, once said something to the
> > effect that if your PCI bus starts failing, there isn't anything the
> > operating system can do, so checking is pointless.  The only fix is to
> > buy new hardware.  There was a hotpluggable PCI back in the day but I
> > don't think it exists any more.
> 
> I don't mind if the CC stable isn't there.

I don't mind either way.  I was hoping you were going to say it was for
some new hotswap hardware Intel was working on.

Smatch deletes all the failure paths from the pci_read_ functions
because otherwise you end up with a lot of warnings that no one cares
about.  Uninitialized variables mostly?

regards,
dan carpenter

