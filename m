Return-Path: <stable+bounces-119817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A8A477A7
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7F63A983D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E2222577;
	Thu, 27 Feb 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KKv+96nF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5C222574
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644620; cv=none; b=C6N7XuSAus6l/QuHc93WGged+8aoZnvcp5lzGjs71rDZ5OGIVrAxIFJyS0dxiuAGjHG+U1HD+KmvOEp+WkX036bwYQ7vDQn6v5AGOYA10PfHi2f6GRxNBSdWWEjMmvXRUtTJf77SfQvOaZvOpEQcKffdQG8FPV3n5pIwzC1QW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644620; c=relaxed/simple;
	bh=W9KN5pvX9x9UeQfxZLl+Kx7zYQ6RgmMlCXWT3/BihSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRCdzom8FSiI+9T1Re/Ag/3kuWVnwLmpjToyedGzg6tbyxWHS0I5zD6DMs7XwPyyH7+dXeEQfTriMrruCw1f+t/rBKZfX68C1lqQ4LrZC1kblptDbRs7qOCKmMyNvugECAM2Ihj7VoFzAu140xAN2TkEPcEmyURR3C8jlwRH6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KKv+96nF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43998deed24so6317145e9.2
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740644617; x=1741249417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etFPcrtk9Tgkn8uByeM46xjOYSvuZ71OIx9b3bGqazU=;
        b=KKv+96nF6KDkbykifiOb7UD324A7P/DSR8ZsNPZtXS/y40uf0B5CUaD197pm2gXSgf
         7IJSv/KFDsCvjyjSLlSw2zv43xO05YjUy+oF6HltCehdI1mhA7lLxSXCMQvvCtKlS0F1
         EhjaeDJ0Y+HazepRl4J9lxw5W9l4ctgedYyUt042OHEZ3kLPDGDmM/NTHZfXFc1ccY13
         S4LJlv0O+0It7ENrFP2r5Q07EdCpnqxLp3Vi4C38D0g6L0jJ17VMyw7/sGAnqmMnYHad
         r7M0SGyczi9T8zztVWHkKpJyMAWW9VZuUtEEKX/gm7lUTMjE99/yBZyP6pf/qP1Mamny
         hzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644617; x=1741249417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etFPcrtk9Tgkn8uByeM46xjOYSvuZ71OIx9b3bGqazU=;
        b=Hw05YuxUiBty69ht0XQmvJCUcT7m5zU+dTeWQ5Ee/Qy10nQ+ScT9kklOwp65oiFseU
         /H+ATRYv+eF0pPyPjrGFX/uEv3r315hdipEtP2SONagXlBhsKJz7vdQBGKE2TcENevfD
         K4kJPT+lv7q2KpdyoUofWTIrwC+8Y4eqrC7GSBaA9v88188GhdgPDkUiULxEzVT3Xl/B
         SFnsNkuKugKb/yGmPZulpk5TborLboZ55FETGKHRq7yHZDelDtTCl59PpgwvWGkyNqk0
         DQDVZ10a33Mc9H00Z6F3Xw1rgNmxT3Ws12SD2fTaEw6NS75X7JmL23O6EefXMj767TRD
         Y0OQ==
X-Gm-Message-State: AOJu0YxHV0IPkIp9I+hRy5Y+cns2Sk39ViLqrN63S0wdFXGUlcte34e8
	XwhI0pcLYVsbcHJGBfRB8DEfdOpifj/hGXJSeHocggTKmGWG6SkfpZux0ZkJ0Q==
X-Gm-Gg: ASbGncsVGECCXGa2fVPUoEq+A8F+UzJnPfODa4t+byA6YMWKui1O70SDPLbXWe7iVVO
	npwDMqC77LbFsL4omh3afceyQ2a0IzB0wT1n1fcliRPb2Gz6ReEL0hXs0Ysm/S8CP+qoz0z0/QD
	vQ4GTTQviSSb8uGoLlMtkXUBx7Q3kQ5bMVBHhFrQ5L3MZgusuah08TCFeb6iR23hxwBUIXxkX/B
	XCcsD4uEilJM/9j448yizGK7/U796iouGWoP3w117ri5LojDHc8HcAsrkfMvHHbhxqHG5mT5sUe
	41UFUcyVr1cVLqMubk6b7njUKxOlz6y8M5Dxy+Jv8+Vt3iSWJhTgND0xK728YatLmhwJgV+wve2
	SUBx+rHUCgW4=
X-Google-Smtp-Source: AGHT+IGNO4lSsKzWr9bxAoIjTpTJaMHd6X1/Kf+c9UJluJGrqU3WSg6vtNZXxKPF+NoQckaCet6dJA==
X-Received: by 2002:a5d:6c63:0:b0:38f:2a7f:b6cd with SMTP id ffacd0b85a97d-38f7079a134mr17580534f8f.20.1740644617014;
        Thu, 27 Feb 2025 00:23:37 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710f6sm48457185e9.29.2025.02.27.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:23:36 -0800 (PST)
Message-ID: <22a46f43-d60c-465d-9ae7-4d84ca9108d4@suse.com>
Date: Thu, 27 Feb 2025 09:23:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/pciback: Make missing GSI non-fatal
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: stable@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20250226200134.29759-1-jason.andryuk@amd.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20250226200134.29759-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.02.2025 21:01, Jason Andryuk wrote:
> A PCI may not have a legacy IRQ.  In that case, do not fail assigning

Nit: Missing "device".

> to the pciback stub.  Instead just skip xen_pvh_setup_gsi().
> 
> This will leave psdev->gsi == -1.  In that case, when reading the value
> via IOCTL_PRIVCMD_PCIDEV_GET_GSI, return -ENOENT.  Userspace can used

Nit: "use".

> this to distinquish from other errors.

Nit: "distinguish".

> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -101,7 +101,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  
>  	pin = dev->pin;
>  	if (!pin)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	entry = acpi_pci_irq_lookup(dev, pin);
>  	if (entry) {

While I can understand this change, ...

> @@ -116,7 +116,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  		gsi = -1;
>  
>  	if (gsi < 0)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	*gsi_out = gsi;
>  	*trigger_out = trigger;

... I'd expect this needs to keep using an error code other than ENOENT.
Aiui this path means the device has a pin-based interrupt, just that it's
not configured correctly. In which case we'd better not allow the device
to be handed to a guest. Unless there's logic in place (somewhere) to
make sure it then would get to see a device without pin-based interrupt.

> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -240,6 +240,9 @@ static int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
>  	if (!psdev)
>  		return -ENODEV;
>  
> +	if (psdev->gsi == -1)
> +		return -ENOENT;

This may, aiui, mean either of the two situations above. They would then
need distinguishing, too, if user space is intended to derive decisions
from the error code it gets.

Jan

