Return-Path: <stable+bounces-132214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF40A856AC
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E384E0B19
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427E29899E;
	Fri, 11 Apr 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N63FYE2v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1A298988
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360443; cv=none; b=ZIXl4CGAY4lV1E3/hjiLrwf7/NcKSpWaYX4hs/QuJAbfIdhxgBWOHkQuYAieSmksZIVXJTlDq78pdAUnO0nf+ThXk4ikQx2fLbjd1oKbDgbdY2jLR/y52Jx53yYLRIWsbziuLRGjp1pR0Tduj0BpmHI84E5DAtzt34nLN6BcP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360443; c=relaxed/simple;
	bh=/qo4gcSDylw9y3Y13r/kFOd4wQ4zfDTtcYDq9dLoHDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlckx7zkivQeCuKejnPiBx18VA/CaqpbRrRrzAZ0mebGfniC2Mn7IpRF3M68p803/lcB6/nw9fPTQodoHO4M+nMHRxMRoH92dDID23Zsi+WC7q7UOQ3x1eM1TGqYqh21sA0ejYyk2BNh34DnV2gyPWcFNA9xA74K3t42uIxvCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N63FYE2v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744360439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rauBmq3K5j+aZ4ym535sl8BVfHytZNjgSVdV1u6bHGA=;
	b=N63FYE2vnKS307Bomlroh845SDNXq43yDCKTsX3PVc0x0F/0GC/6DGEPBVjhKnE7om9gOv
	ah+0Wrw8QG4tcbS/pADIEohPCBWGKJAMRoXFBL8xgerKY5GOhCRaSCPq86HyGPD3lFhtgM
	y+pSoGdpUdAm6Uv9chN0VxZUcqWsp0Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-wxKKFW_jNiu-zL3bUPdE8w-1; Fri, 11 Apr 2025 04:33:57 -0400
X-MC-Unique: wxKKFW_jNiu-zL3bUPdE8w-1
X-Mimecast-MFC-AGG-ID: wxKKFW_jNiu-zL3bUPdE8w_1744360436
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3df3f1193so140696966b.2
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 01:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360435; x=1744965235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rauBmq3K5j+aZ4ym535sl8BVfHytZNjgSVdV1u6bHGA=;
        b=VozRMTl42jAlz4lmfzJ2N4mjI37D1ffmadvawnP2wbUtNagR+KdSSwDEVqMIt/q3cg
         RZjd+0jkLKH7m3az7L92K/j06Xixr+CBEayjKKI3lTCQmT5WyIubVSdz6cbyKXGIn9mJ
         xw4mxy2oDeZPCLOIuTy75JYYTpDeqJqQV8DQhR9/c2SRqQcoKcRAoz++YR5z18qcJHrG
         P6Rs4NGeiZKP/fvHtEmvpq5Q1yc91pQ/SfUSksSjrmPDG4Vq6rd+M83jCr8iTZ0w0K38
         wLH76Orr1L+Nq8L/CB6+9coE/UoYwcK10Innj56On8kOehvPUjyS5VqjuWPxNf23qiee
         1vfg==
X-Gm-Message-State: AOJu0YwENFXooQHiESLYVc8aLqVTfiUkMOBqVkhj+f+cjzgvtt3G+OS6
	w14dXE9VKzbr+bNufzwthoMONu1THI8nbqix9FxwaQNX/LcD1kd5DpcZX1s4US3NPgNkwdrsz20
	ic89FPdA//U8bjeNJE+5k0oJYsAylkfa9GOXrWxwS1hmDTYHbVK3vC7QQ6l0ydg==
X-Gm-Gg: ASbGnctOQJ1bstFHKamxUbDWNYCbTH5mDuC/OTCtNw0V8r6SEs6qrhoEAvxmTSNtABP
	j0zCxPnBzQDafAQjky7tgPSWc1NhKH+qV9GN/lI4Tz0qurz3dqfd4nwrKGMbHqLtuBUNSExF6JL
	bTf7HKovgERC+RIVhMsBg4xbSM6ZzLraiZE9NJCMLD9cXDQZY6hqmEY/k8ViArn/ysrBRvxeq0r
	obMQZMjVxJE/RGm3MhPPQ40bHP24BZd7uU24zIbtetyfux2h99+tvpDgdE4z9rkaRYsukDHF7IN
	g87wjhO57y0xK89Qhn61WxY+8zMh8XpF09maYTG8pVNrjSQIsG6OYvoIvtm8klu4OBw7Kb8rp43
	uB8BT6SFPSzCp+o699oXyJvmjNERAuZcdh5DhoaDkd/s4SiXi+X0viPpRzasGFg==
X-Received: by 2002:a05:6402:1ecc:b0:5e4:99af:b7c with SMTP id 4fb4d7f45d1cf-5f36f644fa1mr1206356a12.9.1744360435268;
        Fri, 11 Apr 2025 01:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5ETctPXgmYy/3kOvhR7THcmsbYSpYhk7jhIPW9DPlhKebFvCO4nVWQ6lXtvrje1+ZZMpM1g==
X-Received: by 2002:a05:6402:1ecc:b0:5e4:99af:b7c with SMTP id 4fb4d7f45d1cf-5f36f644fa1mr1206330a12.9.1744360434865;
        Fri, 11 Apr 2025 01:33:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f507687sm624677a12.56.2025.04.11.01.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:33:53 -0700 (PDT)
Message-ID: <cfc709a8-85fc-4e44-9dcf-ae3ef7ee0738@redhat.com>
Date: Fri, 11 Apr 2025 10:33:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] platform/x86: int3472: add hpd pin support
To: Dongcheng Yan <dongcheng.yan@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
 hverkuil@xs4all.nl, andriy.shevchenko@linux.intel.com,
 u.kleine-koenig@baylibre.com, ricardo.ribalda@gmail.com,
 bingbu.cao@linux.intel.com
Cc: stable@vger.kernel.org, dongcheng.yan@linux.intel.com, hao.yao@intel.com
References: <20250411082357.392713-1-dongcheng.yan@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250411082357.392713-1-dongcheng.yan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Apr-25 10:23 AM, Dongcheng Yan wrote:
> Typically HDMI to MIPI CSI-2 bridges have a pin to signal image data is
> being received. On the host side this is wired to a GPIO for polling or
> interrupts. This includes the Lontium HDMI to MIPI CSI-2 bridges
> lt6911uxe and lt6911uxc.
> 
> The GPIO "hpd" is used already by other HDMI to CSI-2 bridges, use it
> here as well.
> 
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
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
> index 30ff8f3ea1f5..28d41b1b3809 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -186,6 +186,10 @@ static void int3472_get_con_id_and_polarity(struct acpi_device *adev, u8 *type,
>  		*con_id = "privacy-led";
>  		*gpio_flags = GPIO_ACTIVE_HIGH;
>  		break;
> +	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
> +		*con_id = "hpd";
> +		*gpio_flags = GPIO_LOOKUP_FLAGS_DEFAULT;

This looks wrong, we really need to clearly provide a polarity
here since the ACPI GPIO resources do not provide one.

Regards,

Hans



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


