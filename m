Return-Path: <stable+bounces-54861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5579132F4
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4E4283DEB
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361E14B959;
	Sat, 22 Jun 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIVTEvze"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91714A606
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719051066; cv=none; b=IG0BRV9xRZWXHoj/q+SrifhEjvbwrwgWXT5nZGC7EP/gVJQuWwK7JSdinhhgwSkQajfXQHSnqcTwyNGqodU2ZxFUSBFMS8Kw2Up3FLQYtd5rFW9dKt3mBCWxAqyvGrF2csI5KEhTlB5NWNzyudPzJQAI4jMFbf7Cg9wm37XBbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719051066; c=relaxed/simple;
	bh=xStPxu56NKR5AZX+Gj7MCK4+Fcx4CxuAPdTvEB6csKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYUjrwAir7zVA9MQEz+dYkgZKkaXgwo+orhYijy+jIBqernjETR6LSr4dcQVE0h6fgouMjv/fVFA1Zlr0XcvGXtVTT7U++3208t7TMB5kN2rac/bOizNsYbTxrGgs5uGr93binzl0Yv4S+VCnI+6V3Ea+b8cyl3oqmJdN+BwV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIVTEvze; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217136a74dso23523615e9.2
        for <stable@vger.kernel.org>; Sat, 22 Jun 2024 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719051062; x=1719655862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsQGvp+qGQjpw8YL28OmQskK7HTEsVWEKYoqU07XWo0=;
        b=oIVTEvzerf7JKPbCXH4cjNUemQYHZjxow4hYGrcngX8o30KzU1zSZ0iXaY2PEY0VEC
         NB3YLIdXVsnojhh6JGIEfOWdHSA1Q5vetD3FMmRPoZcX2IWywl5XF66W/mlLLyJw2jZ7
         4POERxeFW7IRAld8jrKJzMA2x/Iymxm4FaBAk7u5E+I9OtQez4+b/IK0RGGaPCoFBCt3
         yCL7ajQAtKfZGtvq/AoUXycFyaMma+BOcozpN8JQiMlBicHS+rkglwQChTF3IPbC4Sa+
         P0YhR1m0y3O9Vd3KTFq9TfKhZchzQTuH8jhBq0hkHjZ+p78eOzX+yH6E3lrE4EFSKVpU
         qOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719051062; x=1719655862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsQGvp+qGQjpw8YL28OmQskK7HTEsVWEKYoqU07XWo0=;
        b=mYuryqPYgvzq0Yh4h/oK2sVxYKA5+8nSh5ccwcNVWCzPclAq7rPkonLtPCeJXlfanX
         JCYttr+9pxwsFJAwmP0N2YLCBphZXj/toyIgdJuriLte8qb/qQJ6Ml/5HSsckswZ1Zs8
         fOMx1o8B3x6S4swo+B/DmEK3F+3DsiKMQtk0kXO0jj2cpiGIeEVVK/AnHkjpwkSyKp6N
         MUiXE+zurw2cPJPEUdvcrfuZ/h2Aqr//Lc3YB/IweoQjMozkm9KjYc0zsNhbLyZyqvXG
         haM1eHxPTeMKQLja06/KIBcVGiflxE6Wi/DLwewf/5oknoMQANoRVDG2L6PZBOEre0Ms
         g/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDTZjop/df4hJpxJzFJct1E22ADlXWYaFM+cFhh0slPDaUv22aXOb+Jhmxb/CkTW40PnOkNxN1e/fLab/x18o3AgIUogHg
X-Gm-Message-State: AOJu0YxtAyQnZh2cppDXHcxgRfbyzLco3d40BbeFSeXiAi9smVyswgZj
	B1EEAmglH8eGWJaqs+1YttmrZfDucq+/4G7/0Vcz9yFxAX8KXfMcFCORQpH88f4=
X-Google-Smtp-Source: AGHT+IGu1VMVHM1in3bew6TKF/LOVzW8ud+KEi2XpY8URRBQjXEnSYQfIbrIgVM07kRbmhpQ0baWuA==
X-Received: by 2002:a05:600c:4896:b0:421:d8d4:75e3 with SMTP id 5b1f17b1804b1-4247529bcd9mr70390545e9.40.1719051062029;
        Sat, 22 Jun 2024 03:11:02 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4248179d3afsm62166325e9.5.2024.06.22.03.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 03:11:01 -0700 (PDT)
Message-ID: <9af37f6c-cd44-4a57-8a34-969e23b0342f@linaro.org>
Date: Sat, 22 Jun 2024 11:10:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: limit cell sysfs permissions to main
 attribute ones
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/06/2024 19:09, Thomas Weißschuh wrote:
> The cell sysfs attribute should not provide more access to the nvmem
> data than the main attribute itself.
> For example if nvme_config::root_only was set, the cell attribute
> would still provide read access to everybody.
> 
> Mask out permissions not available on the main attribute.
> 
> Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> This was also discussed as part of
> "[PATCH] nvmem: core: add sysfs cell write support" [0].
> But there haven't been updates to that patch and this is arguably a
> standalone bugfix.
> 
> [0] https://lore.kernel.org/lkml/20240223154129.1902905-1-m.felsch@pengutronix.de/
> ---
>   drivers/nvmem/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index e1ec3b7200d7..acfea1e56849 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -463,7 +463,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>   						    "%s@%x,%x", entry->name,
>   						    entry->offset,
>   						    entry->bit_offset);
> -		attrs[i].attr.mode = 0444;
> +		attrs[i].attr.mode = 0444 & nvmem_bin_attr_get_umode(nvmem);
Why not just
attrs[i].attr.mode = nvmem_bin_attr_get_umode(nvmem);
?

--srini
>   		attrs[i].size = entry->bytes;
>   		attrs[i].read = &nvmem_cell_attr_read;
>   		attrs[i].private = entry;
> 
> ---
> base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
> change-id: 20240619-nvmem-cell-sysfs-perm-156fde0d7460
> 
> Best regards,

