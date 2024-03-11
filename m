Return-Path: <stable+bounces-27244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B0877CBC
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B294C1C20F0F
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A860179AD;
	Mon, 11 Mar 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyhTnjrP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225520DCD
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149406; cv=none; b=HGDdtwjKcRaDkPOGIXkHak6yKY018e+OEwts1qgdUMqV7tWgBSeClmW+KLeKSZABievOPVH4Bs1Y62MVky7xFLfH2etdGBDTdel90dN/8zuLTcvkhQNMuIVGedt5LFOWpa1kpww0ND+u++FahjL773rpV+R6/LaqxWnCeeKmlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149406; c=relaxed/simple;
	bh=Nkp7FKBZ7PEcXihd4+KUr6u1TqOc6m8McJG6ktm5IUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvvvX0OPGff1FglvRmQNkBx9mTvMDwvsRm6x6vsQ9C829QYBZHwMZfvzfSSF6S6Id0Zl/ZS554tEFBKcBaDlt/4csvrGV+XF+AMarzxwoMAMOb4xmbGpiRfyda03sm2wGpPMMxqv3/4EhSbl6PY0kx/HvpQPqbOy0B17yb7yp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyhTnjrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710149403;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq0fbqV8AiPaISwYCdRzUvNs1bOqySy/93nFBxxjiZ8=;
	b=AyhTnjrP0ySzKFM0QPNx9wortIcHHPGoNtGWjlvyBqWIgCN+vIHNqtgFix50zcjNq1vd2m
	WSotsjC5madIMdElBt0+3cML7L6F53maMEXOH/bqPBDNSwa4Br9P/fpb9sOBvfvgM7jv8G
	zvMcrLe9Mw+kAv1tQ5ek0a1+/AmSwb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-88YMWBGcO6aM-FfLhHjU7A-1; Mon, 11 Mar 2024 05:29:58 -0400
X-MC-Unique: 88YMWBGcO6aM-FfLhHjU7A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso14454975e9.3
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149397; x=1710754197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq0fbqV8AiPaISwYCdRzUvNs1bOqySy/93nFBxxjiZ8=;
        b=XNzoVpjdNRs8s5nPj9f9QLLieFBuR7QbEuAzq5h5UupprJQKgSmHksTbVe+fJwKcBw
         x8huW2EN37fKcRdsCbJcmjDXSaLhStqYleoJBbPievq/YvH9bhKjSHYZVE/t+Zb86Qlx
         oGq/xH/ExH0xxj8eB9E/VM8KL40XBZYIRHwvIJHH2LrD5MDzFaP07fZYvcEGHKy8P1ws
         YVU2PIm38YJj+DZwGV/vuX0Xdignco2qp9DP8qi5SURx2BjMfT7OR79Aaukwpq7hGh8+
         m5y6BxbXxxfJSs4gJTlYZ4Exy1yzwVrGIwi7PudI4VYTi4/Rh+clA5AmZHkeSDCawvew
         0ozw==
X-Forwarded-Encrypted: i=1; AJvYcCWep+4RfSxp1pALm2YnMH5idmwt3d38rLdbliE5yWL8jgDVLuQvFTZqgpQA0ZgpCfut8kWzTA/AVylIypRDAkWRwPpxDPgE
X-Gm-Message-State: AOJu0YxkF3pG7ReHBWmtjMqym6zl0qpkO5tXT6xoIlz60gR2eM04m6Pf
	ZF8vxcTFjS0jZ0ZF3muCYq9bQpVPBIzihsGT+DF7vx30ffTpo2dqRJRptWNSek5SvIH70/vWRhM
	RKd6PFZQfSQG9tI+dPOyrqPLVRmlgLHxtqokWOIT8ejQ9/KjMK0bq6A==
X-Received: by 2002:a05:600c:46ce:b0:413:189e:d67b with SMTP id q14-20020a05600c46ce00b00413189ed67bmr4404659wmo.6.1710149397699;
        Mon, 11 Mar 2024 02:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5v5SUG6m1goUhCZWogka/nDskTIWkmZ83IYLNOE+yRiFPV22EK88uuq2kD+5UuB+1c1qZFA==
X-Received: by 2002:a05:600c:46ce:b0:413:189e:d67b with SMTP id q14-20020a05600c46ce00b00413189ed67bmr4404642wmo.6.1710149397335;
        Mon, 11 Mar 2024 02:29:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b0041315c8ceeasm8592981wms.24.2024.03.11.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:29:56 -0700 (PDT)
Message-ID: <532d5a85-f74f-4e4d-a0fa-f8363910786d@redhat.com>
Date: Mon, 11 Mar 2024 10:29:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 7/7] vfio/fsl-mc: Block calling interrupt handler
 without trigger
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com,
 diana.craciun@oss.nxp.com, stable@vger.kernel.org
References: <20240308230557.805580-1-alex.williamson@redhat.com>
 <20240308230557.805580-8-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240308230557.805580-8-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,
On 3/9/24 00:05, Alex Williamson wrote:
> The eventfd_ctx trigger pointer of the vfio_fsl_mc_irq object is
> initially NULL and may become NULL if the user sets the trigger
> eventfd to -1.  The interrupt handler itself is guaranteed that
> trigger is always valid between request_irq() and free_irq(), but
> the loopback testing mechanisms to invoke the handler function
> need to test the trigger.  The triggering and setting ioctl paths
> both make use of igate and are therefore mutually exclusive.
>
> The vfio-fsl-mc driver does not make use of irqfds, nor does it
> support any sort of masking operations, therefore unlike vfio-pci
> and vfio-platform, the flow can remain essentially unchanged.
>
> Cc: Diana Craciun <diana.craciun@oss.nxp.com>
> Cc: stable@vger.kernel.org
> Fixes: cc0ee20bd969 ("vfio/fsl-mc: trigger an interrupt via eventfd")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> index d62fbfff20b8..82b2afa9b7e3 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> @@ -141,13 +141,14 @@ static int vfio_fsl_mc_set_irq_trigger(struct vfio_fsl_mc_device *vdev,
>  	irq = &vdev->mc_irqs[index];
>  
>  	if (flags & VFIO_IRQ_SET_DATA_NONE) {
> -		vfio_fsl_mc_irq_handler(hwirq, irq);
> +		if (irq->trigger)
> +			eventfd_signal(irq->trigger);
>  
>  	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>  		u8 trigger = *(u8 *)data;
>  
> -		if (trigger)
> -			vfio_fsl_mc_irq_handler(hwirq, irq);
> +		if (trigger && irq->trigger)
> +			eventfd_signal(irq->trigger);
>  	}
>  
>  	return 0;


