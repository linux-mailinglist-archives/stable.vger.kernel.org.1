Return-Path: <stable+bounces-136691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3656A9C4FA
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE433A8A72
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C224468B;
	Fri, 25 Apr 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVmXPmUD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769823BD1D
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576008; cv=none; b=FcL4pjytlXrqa/NVWD0du3VivvbKSHhWFqPmh5kS5uWfbEYS0CDs2Caz5UxPm0Af6m414OJyOijzPqaPKXkdQ3SDCBt0dTysXBsIDUJx/bh4xLv58UVsRG3ViAvneuPx0+Ir2NRdI5xI4AgA4uSgQUsjfzopkV880yjs1+1AfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576008; c=relaxed/simple;
	bh=G/slIN/YQejFKxJKe0AEMCbMJu1x7O2oA2+moybJ5hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=METtVHvRTMwuAHKG96yt7S7uYFn4/w+lfcW3973xJzO+qOpMZ6Xk34/lzJlZPv/THCR8xNuX9PK4EfyXsPXJKD9xRwV9dfkhpQA2m1hdb/CwvNpnM5rRid0Y+BX1YiRIZYfszf0dO2J9q47S8QoOYWa9gbnIjdNxA1RJLfShS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVmXPmUD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745576005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3mmkWVGcSdiSfH6kfLgKeVG303ccg/Ai5NqIFewYeI=;
	b=gVmXPmUDSevHRLEHPrmN6dDIT+qpbIS2/y4sn8tQPifqKzE8MCeNAjpyjKy6/nQ7AuMc1r
	lCfA4OrIQ2SYZTNm3SW+KFIjSKlo+SNFsOIJWopauCdrqadTu1qI81oiXPr1l7qRwgzB3g
	n5v+ydIqKqYlOfejcJBAFrARtInciAY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-wAeWe3I3O_-bRaAvUFdIoQ-1; Fri, 25 Apr 2025 06:13:24 -0400
X-MC-Unique: wAeWe3I3O_-bRaAvUFdIoQ-1
X-Mimecast-MFC-AGG-ID: wAeWe3I3O_-bRaAvUFdIoQ_1745576003
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso154128666b.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 03:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745576003; x=1746180803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3mmkWVGcSdiSfH6kfLgKeVG303ccg/Ai5NqIFewYeI=;
        b=LNKvz5hgjNGMG6Pjz61QbZWVIZbm+b0Hiv9waI6QGOQlvFiI8/TF1JM2+Yp2KBbVg7
         9RMjpRx6HIB4tbNPg9qb/0Ggj0UYvlp/b/Rm0hpWKYNejBfpx/amqimMsLWOviKcDfYr
         O69M6cHi8fqV4et/8qye20udXO8nE6cunIvfM6/iCUbWgxUZD3Mv+hYyWJGtRMQXlknY
         LC2oyd+w6MDpM5S8lgBzvaneErnh0QFO9hd3at9L1tuLcqCScS6VEO5+mkcffTygz9ot
         Qwvtqn+GANQCCRi1TwwNV6K9pilQTlBkop+477Jc5hFwh0zLFuG7NgN3Oz9Y3Ths4+Ys
         3dKA==
X-Gm-Message-State: AOJu0YwchVYVHi8YHLoODJTsD29gO9nyQKlQWa3f6sVXbO4/ojWA/b52
	1aq1iaU/jD3WRpxmj13iTbFz+aU+hrsBTCfQyYmyFlU7BpIUTSkizdXTCINfUE/0BGwKTlBzZ0u
	ZYIR/WK+VbrvAtwMej/HJISkCsvG2xepQ36K89OhypnffT/dLee+apg==
X-Gm-Gg: ASbGncsv2nSz6pECriDv5uZ1BTR3t32PsBsjVJX4tEtjYI9x2xmz1JaR9NDSbOXCAbY
	v5m2oL2oD6+wuqNSXBsz2gOqWsUt+IWqL2VBqVVEtLntZJk7rQEXL3sDGfXn1lph8B/uCexjYm5
	VumCmWTThV6cwpOk2455yx6Z4p9titXt3fOo6HliOnV8IfiP78akdzy2SY0OxhJ8p3t+FMuvn3z
	dtsH9Qh+n7O82u9KTKxY1jJLJ5vNwJiSdKOrjYGGHlokr6Lvq6/rqZc4SeISuQ5ULyW5TBhTQT9
	SyZHlX4qrubV4scVgQwWHZyEtySGnfJYRP8Tn0ax5lO7BEAo1TOn9RP1ND1kK1egktGNLP5BOQA
	6CLzRUumO/lbbmzenDmgH69VKgTRH7AwRiIfvKAuJQdaPAKBnufsYuVtk7V4Z8Q==
X-Received: by 2002:a17:907:1b22:b0:acb:94d6:a841 with SMTP id a640c23a62f3a-ace7108a209mr151850066b.16.1745576003155;
        Fri, 25 Apr 2025 03:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7hpa0BS6PG9ebdCJ6WIapt6vCC/k4yEO6v7ADZBdEUPa6WQN3zZ/a7svwpaovIE6s9cT1Bw==
X-Received: by 2002:a17:907:1b22:b0:acb:94d6:a841 with SMTP id a640c23a62f3a-ace7108a209mr151848466b.16.1745576002717;
        Fri, 25 Apr 2025 03:13:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm112354166b.7.2025.04.25.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 03:13:22 -0700 (PDT)
Message-ID: <0db6de06-9d74-47d5-8625-7875bc376ecd@redhat.com>
Date: Fri, 25 Apr 2025 12:13:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] platform/x86: int3472: add hpd pin support
To: Dongcheng Yan <dongcheng.yan@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
 hverkuil@xs4all.nl, andriy.shevchenko@linux.intel.com,
 u.kleine-koenig@baylibre.com, ricardo.ribalda@gmail.com,
 bingbu.cao@linux.intel.com
Cc: stable@vger.kernel.org, dongcheng.yan@linux.intel.com, hao.yao@intel.com
References: <20250425100739.3099535-1-dongcheng.yan@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250425100739.3099535-1-dongcheng.yan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Doncheng,

On 25-Apr-25 12:07 PM, Dongcheng Yan wrote:
> Typically HDMI to MIPI CSI-2 bridges have a pin to signal image data is
> being received. On the host side this is wired to a GPIO for polling or
> interrupts. This includes the Lontium HDMI to MIPI CSI-2 bridges
> lt6911uxe and lt6911uxc.
> 
> The GPIO "hpd" is used already by other HDMI to CSI-2 bridges, use it
> here as well.
> 
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note my handshake control series has just landed / is on its
way to next, see:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-ilpo-next

Please send a v3 rebased on top of this to resolve the conflict
we now have.

Regards,

Hans






> ---
>  drivers/platform/x86/intel/int3472/common.h   | 1 +
>  drivers/platform/x86/intel/int3472/discrete.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
> index 145dec66df64..db4cd3720e24 100644
> --- a/drivers/platform/x86/intel/int3472/common.h
> +++ b/drivers/platform/x86/intel/int3472/common.h
> @@ -22,6 +22,7 @@
>  #define INT3472_GPIO_TYPE_POWER_ENABLE				0x0b
>  #define INT3472_GPIO_TYPE_CLK_ENABLE				0x0c
>  #define INT3472_GPIO_TYPE_PRIVACY_LED				0x0d
> +#define INT3472_GPIO_TYPE_HOTPLUG_DETECT			0x13
>  
>  #define INT3472_PDEV_MAX_NAME_LEN				23
>  #define INT3472_MAX_SENSOR_GPIOS				3
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 30ff8f3ea1f5..26215d1b63a2 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -186,6 +186,10 @@ static void int3472_get_con_id_and_polarity(struct acpi_device *adev, u8 *type,
>  		*con_id = "privacy-led";
>  		*gpio_flags = GPIO_ACTIVE_HIGH;
>  		break;
> +	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
> +		*con_id = "hpd";
> +		*gpio_flags = GPIO_ACTIVE_HIGH;
> +		break;
>  	case INT3472_GPIO_TYPE_POWER_ENABLE:
>  		*con_id = "power-enable";
>  		*gpio_flags = GPIO_ACTIVE_HIGH;
> @@ -212,6 +216,7 @@ static void int3472_get_con_id_and_polarity(struct acpi_device *adev, u8 *type,
>   * 0x0b Power enable
>   * 0x0c Clock enable
>   * 0x0d Privacy LED
> + * 0x13 Hotplug detect
>   *
>   * There are some known platform specific quirks where that does not quite
>   * hold up; for example where a pin with type 0x01 (Power down) is mapped to
> @@ -281,6 +286,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
>  	switch (type) {
>  	case INT3472_GPIO_TYPE_RESET:
>  	case INT3472_GPIO_TYPE_POWERDOWN:
> +	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
>  		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
>  		if (ret)
>  			err_msg = "Failed to map GPIO pin to sensor\n";
> 
> base-commit: 01c6df60d5d4ae00cd5c1648818744838bba7763


