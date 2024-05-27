Return-Path: <stable+bounces-46319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E268D02C7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E7B2999BC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19515ECE7;
	Mon, 27 May 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo6lMTJS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C115F3E9
	for <stable@vger.kernel.org>; Mon, 27 May 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818541; cv=none; b=KhWTDUnUgeMA+54I9GKzzePEW22xEEPJzestdrgLmRHLoeVy4VUBHjmtDZXEx2tY/vvxfxJOmKTeKg7+DIRXNWGng8rGxm/00PY4/zNPvsLJkiCo++s37yZWRkqxEfY03nzdlN09Lbow80O7pijjL13Q2mo6U05gFO/GUWebKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818541; c=relaxed/simple;
	bh=H9YtbJAz0lWtxxI5dSAjzObouxRSql1cjuogk2/HE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJEKk3bkDZPHGrNMK3Ais5ALRS0UoSoOZtR8YnqCOKFxCzjprbIB6lfAZZVJ2tY3qnKXwqKhrlIG1zcTK40JEYyc0Z90rRthJZ7yuFXfBJl5asx3SoB7a5Q4i5E9613l6YCSj8YZcHR9m6m3XVjet5qaog0USMGeu43tY8BU+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uo6lMTJS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so3691879a12.0
        for <stable@vger.kernel.org>; Mon, 27 May 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716818538; x=1717423338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3ZJSdg732IEDAg/X5ZtP8XP6njMmewxtfTRqhu30AQ=;
        b=Uo6lMTJSDVogY+69w9Q8XgJW5fh2hvX9So8n+GV1ffW9WlQB4t9rAhcTCvK/NWThAi
         aNb7tI51PGvJdlWrcDFdHmCulc0WlFw0J1Khqrm4klug38pcVBpE3iSwQnFhGti17Ob1
         toVh2BPVZdRPT1Ltu0FeTvzFUFR4RcxhTThTisDnEWb2/3BwTt34JLAneKpvsi/6sHEJ
         UrkPTsjYQb4a+FQkab+XT5ydscP8fqAxOlatVUvN3yoCb4BMZnPYHy18HUwHl0SZ5gtZ
         zn8Bhmnt9vMdpc5EifYiUU11gXyqRpDmEubiTPK/cqj51kHacDj7kvlqSIb2tVL62Lpr
         cAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818538; x=1717423338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ZJSdg732IEDAg/X5ZtP8XP6njMmewxtfTRqhu30AQ=;
        b=GGUo8zP/5Hy3g0eo6I2A44+fe/KC7I+aZ7fO61lhhfKEYJ1UP4pyL9OB7WSyNYFqO9
         KUCSC9bkkHrwqHnxftOPS8TS5HWvXeItaWeCOvCYn7pjPr7QpBlFay7RcfMTZS4+qwNn
         J12aZSm2F0fsV9FkuI9iRj83PVg4f1/SiP5VyOnhce8ILU31FjVlYLspyLe9Gg6ZLH8v
         +Q+eYu8+yBeH7OHqwwgROhHVbf0KuLV4XQdsvoL2/2rSF4xFm4eENC9cUjJ+zlB+5EgW
         dNpFGSH8zoMWzvd9PDQuXMUgztl9no0x+KG3sgtODr3anAGhq3lqY+SokF/Ti21ghCxS
         MIkA==
X-Forwarded-Encrypted: i=1; AJvYcCX6/Hv9mhb0D9zemeTO2CfTGBi/0WPa2pZt5RyCr+LENiLMMcqqGchvsW5+Yl1FXsvmQiTamSh/q5f+3uScmTgIPas+QsCY
X-Gm-Message-State: AOJu0Yy/XQegUpdOTmejt60CC+iP9I36SFdiXjJDpf2S7vy8F//Z7Tia
	UNe12w4xAKJ62DKLQ7GXN/bTb89WL3uPoUYTZAukUVqhuHbGbLF30MuL1DcPGTs=
X-Google-Smtp-Source: AGHT+IFgM+OP38ZRP3oP7w5ejOGXdOAIbIo0Pp+7im1U3FuKtyvAU2zaGVMcsTGgZFKwQBd5rZsEXQ==
X-Received: by 2002:a17:906:abd0:b0:a5a:896f:9be0 with SMTP id a640c23a62f3a-a62642eb70bmr725672266b.27.1716818537450;
        Mon, 27 May 2024 07:02:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62dbdfca11sm204613166b.145.2024.05.27.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:02:17 -0700 (PDT)
Date: Mon, 27 May 2024 17:02:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to
 errnos
Message-ID: <09f2f3ac-94a7-43d3-8c43-0d264a1d9c65@moroto.mountain>
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 27, 2024 at 04:23:44PM +0300, Ilpo Järvinen wrote:
> diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> index 6f3ded619c8b..3377667a28de 100644
> --- a/drivers/gpio/gpio-amd8111.c
> +++ b/drivers/gpio/gpio-amd8111.c
> @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
>  
>  found:
>  	err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> -	if (err)
> +	if (err) {
> +		err = pcibios_err_to_errno(err);

The patch is correct, but is the CC to stable necessary?  Is this a real
concern?

Most callers don't check.  Linus Torvalds, once said something to the
effect that if your PCI bus starts failing, there isn't anything the
operating system can do, so checking is pointless.  The only fix is to
buy new hardware.  There was a hotpluggable PCI back in the day but I
don't think it exists any more.

regards,
dan carpenter


