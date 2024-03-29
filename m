Return-Path: <stable+bounces-33147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23E8917DE
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81138284FE8
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047AF6A34F;
	Fri, 29 Mar 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHiSefgg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B421096F
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712037; cv=none; b=sMxy3RAYN2W7KaXHK714GkrPQB5XVkEoKVJSkgB/LDGpRv7CU+4Rb3NXntvpLw6DcKm51Qv067z3Xhd4dEx2yczGcdK4FLXx94qGEvgcuCyn/ck5qlPM811DsJqCQFzrldNM80vjGQNeqoiNq43cPGGxKXImd/wnGb//usm8GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712037; c=relaxed/simple;
	bh=a98z97iZ9qMHChDUAuP9dsimB8jEj34VV0KcH9AYrnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9dosiRW5izwb2GHKaOSRd8d8QocYpAQlsGmy90aO0VtWSSjE7euVEnnWLZ69Tz8t6dfiRkCPro7B66QvLTpAyjFWK0vO5t25ejYbiehC6uQV+WflaaPoeGvzOs2dwKbdQcU7RWIBq33n0GBZGOM9I5n9S+mWXUbnf6i6nWP/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHiSefgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711712034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nxs/nhXmfqPK2CmkDAQIe64EBqgnehcVF3kvjfNJmIA=;
	b=HHiSefggm1LXlI7PlD3MlLx4/UskpwY6+OAYtDAJB/jjr6YQ0sVYZtuTtM6qfCsbQ7I8Q5
	Sjc6uzw3dC/rqFwYt+Fjt+Pt4K30OPNWrB9TI+8PC1K5JIZUbrXd4l3jq4FrqMjUUdn9Hb
	W36yPWV+DyBWacmLerDi79YFI4lhiwc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-oY1N7YXfO4icGR-4LE-WPw-1; Fri, 29 Mar 2024 07:33:53 -0400
X-MC-Unique: oY1N7YXfO4icGR-4LE-WPw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4e3e823acaso15218666b.1
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 04:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711712032; x=1712316832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxs/nhXmfqPK2CmkDAQIe64EBqgnehcVF3kvjfNJmIA=;
        b=dYMHtPJHVV+ocHV9VJ3X1bjuG5nXdB3+24SDBDjEeGyciXUXct4XxMRA/AzNF85syY
         Gk7QnfdW2O5kOhZVjbvmpb5bvfwrK19tuJKVIwW71Yrjx6jrGI/4WWYLO+izCg2kO5y1
         IpkDCOigtCtqT2q3PrbggVYtwTOjEeTn1iAuGAV62NHe1AyG5pgqw2qwfuV7476CGxJy
         Xo9fTTDHD7bZ45EucXvUyIZZXc5exDVprOXc6aJDQA6BtkpYgKAXvGaMyc80mPQHtXAx
         tu/LCbOJ45u1hV4PcVn72K9Wms5h2A6Zv9F/CXR6Lfhb+Km0ILnKCkcLvaZ7yYAR4/Ip
         VmtA==
X-Forwarded-Encrypted: i=1; AJvYcCWSs2wTjcFMroRhQSFyg6CpjUzmoues2xTCTcUCBCHWxv3+byoDxAlL/5mhb9ZTFQRVIAl+diYbpKmEBS9f3itdWg1mZZs6
X-Gm-Message-State: AOJu0YyZjhwmrslMJUlDMnl0bvw/vAbmpfAZgRBdwx7dxoAHSn6ZHQ6o
	Lvikhb9PN9ONAT3VpsSZfqts3XdMtSCqJy5TPovv5gX+wSZeso83v6A/5hOAtDD/hKNxc90CqYj
	RoYlye4BffCujpH49Va3ewi9hGnutw/xR7+gNm9iBtgTsasyuWYdCo3wvCszVtw==
X-Received: by 2002:a17:906:fd0:b0:a4e:24cf:76d3 with SMTP id c16-20020a1709060fd000b00a4e24cf76d3mr1489186ejk.50.1711712031988;
        Fri, 29 Mar 2024 04:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpicBzyNHMOLooDyw621tGAy3x2axjAjhlvNN+IR7X9qs4jXu2mRhzqMMDXByCJxKQmmm+gw==
X-Received: by 2002:a17:906:fd0:b0:a4e:24cf:76d3 with SMTP id c16-20020a1709060fd000b00a4e24cf76d3mr1489170ejk.50.1711712031656;
        Fri, 29 Mar 2024 04:33:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906581000b00a4a3807929esm1823908ejq.119.2024.03.29.04.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:33:51 -0700 (PDT)
Message-ID: <e0641bc4-2154-40ec-a188-c42464ff84ad@redhat.com>
Date: Fri, 29 Mar 2024 12:33:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] media: ov2680: Allow probing if link-frequencies
 is absent
Content-Language: en-US, nl
To: Fabio Estevam <festevam@gmail.com>, sakari.ailus@linux.intel.com
Cc: rmfrfs@gmail.com, laurent.pinchart@ideasonboard.com,
 linux-media@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
References: <20240328224413.2616294-1-festevam@gmail.com>
 <20240328224413.2616294-2-festevam@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240328224413.2616294-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/28/24 11:44 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
> property verification") the ov2680 no longer probes on a imx7s-warp7:
> 
> ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
> ov2680 1-0036: probe with driver ov2680 failed with error -22
> 
> As the 'link-frequencies' property is not mandatory, allow the probe
> to succeed by skipping the link-frequency verification when the
> property is absent.
> 
> Cc: stable@vger.kernel.org
> Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Changes since v2:
> - Fix memory leak and print a warning if 'link-frequencies' is absent. (Laurent)
> 
>  drivers/media/i2c/ov2680.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
> index 3e3b7c2b492c..a857763c7984 100644
> --- a/drivers/media/i2c/ov2680.c
> +++ b/drivers/media/i2c/ov2680.c
> @@ -1123,18 +1123,23 @@ static int ov2680_parse_dt(struct ov2680_dev *sensor)
>  		goto out_free_bus_cfg;
>  	}
>  
> +	if (!bus_cfg.nr_of_link_frequencies) {
> +		dev_warn(dev, "Consider passing 'link-frequencies' in DT\n");
> +		goto skip_link_freq_validation;
> +	}
> +
>  	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
>  		if (bus_cfg.link_frequencies[i] == sensor->link_freq[0])
>  			break;
>  
> -	if (bus_cfg.nr_of_link_frequencies == 0 ||
> -	    bus_cfg.nr_of_link_frequencies == i) {
> +	if (bus_cfg.nr_of_link_frequencies == i) {
>  		ret = dev_err_probe(dev, -EINVAL,
>  				    "supported link freq %lld not found\n",
>  				    sensor->link_freq[0]);
>  		goto out_free_bus_cfg;
>  	}
>  
> +skip_link_freq_validation:
>  	ret = 0;
>  out_free_bus_cfg:
>  	v4l2_fwnode_endpoint_free(&bus_cfg);


