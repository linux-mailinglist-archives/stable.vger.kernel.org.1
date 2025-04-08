Return-Path: <stable+bounces-131846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0977A816AF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550C0188B11D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B722F145;
	Tue,  8 Apr 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2UyC5Oy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557F218AD2
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143337; cv=none; b=WB6FYAo2Njr9ouf5xKXlmhdbCfiBWwa+lVBeRgPyMoWfPN0cyBJ2qeSp+ju+fpAsLvJAYK9YqLR8Axp5kTFufQRGPhF3+FPsunfMC8J0rWPr0bMeKCDjWMqGbAHBwyueyHKd9ODOQtPB8d/zLmS2Rtu5zanN3J45KPNbg5bSpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143337; c=relaxed/simple;
	bh=/imu4dVQOa3vOU/oVHNu/tR40CNkT/+dS2ZPqcyshRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgJUDhUR2jhcwTmLNHB09LJN0spQIotSPLkgxqjewLEUNX4gAA9opX4JBOawvCWQv94n7BgF7cX94x5IHt7iZTnDdYSfBnw4MnvRrCdJVFx/rcZES9dvXGtVUuJ6QATWibbiqxPzhB7Q6NjrGcfvcZr+/9511NTe3MYoyGkAl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2UyC5Oy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744143334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8QjZveAu/2K/LGH7KGBQ5Sa2cguSA7xg7NHX/ZDvXI=;
	b=R2UyC5OyZshnRdhGCiBW+sv4JzBVjY808q3SoG2RO/Pip82PksM9qNURv2KR6Id+Lxf4wk
	tZJSbQcn9HBFOBc7Yl8iJJPolL0edX5BbRFLqb/n2FNNVVyutn4INKeUXxWC9VUtWAQQAP
	zwf2wbuPFwgg/FDT8U9BfiHCehbbtTQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-eev4hjw_MmK6GVNt9_2Ydg-1; Tue, 08 Apr 2025 16:15:32 -0400
X-MC-Unique: eev4hjw_MmK6GVNt9_2Ydg-1
X-Mimecast-MFC-AGG-ID: eev4hjw_MmK6GVNt9_2Ydg_1744143331
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so20370035e9.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 13:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143331; x=1744748131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8QjZveAu/2K/LGH7KGBQ5Sa2cguSA7xg7NHX/ZDvXI=;
        b=oktqjnYEo9nf/i5FNL1l5sMlz42FIMYMCKNec/3b4uL6SjtjPbREPtkXNoTu5P1w/P
         /2dBPtBUhtPjBn6El85xXZt1Vzaa1JDIb3RTd7Wy2cbTHbbKViMvaA+V6vf4b+oNe6As
         BSAM3OVY97tqDZz7X4sr01EJdNJCSEfmtmT++EhmusIE4zvwyR+iZuU9hr23ntwfMquU
         +RjTLc6UoPPfTsieNup/cbDDVKPA2qGNQrRXTa3owHgLWk/e7V9KP0gLXstqkcCQc9Lz
         N5rtsDnfBQjEmzzRZfllilv4N+CEOzFGU87DEEQRiAN4VtMB4thjF0va673/z3js0/go
         c+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUOm5QwYY5oG2gPXrS2rhedQpVA6aMJ5GM6PHD4oOB/ib+x/3gdMyFAljHHlTgCM4FzcqKCCF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6z05Dn9c4d0p0Gi1KCZkTxXA5cOZuhKeKuSQ6/V5z7Op7YnNf
	2BIo4X/pTW1vzMMnaXB+eCTqCRspQ10YNX0i1Vv5CVniULWlVw0cGCXdnVj7pJRanByc0EdOmu7
	7SdDgta7/GsJtBrh4AbWf7yKzd/W6dsPZiE68xXieBHU1b+OP92bLii4AWI9mCA==
X-Gm-Gg: ASbGncvbi4ynR1BXZcQ+kTNyZRe08NjZwKCcR0x2KXLO4A6pfpW78PEIp96e+JYWYqc
	/fx98D1eKTJbu1Gyb777jRE66PUQQ6p0k4CTX0QsMGla0ywdCSpY2o8g+Tj1oOSR6LAJ/GMOWhy
	k//pLaPYerDQMpVJj+fn3l1L2yDcD0wxjg0xYx8qh5JvhT1oEWlD/yvG4ySv4I+iigI4w5xlrJP
	294yNImVnW+Nx/4ARe6FkurMn4biHKAH2IDemS+s6ihD7NzOKAum2qL+dVxZ0w9Qf0xGfdh5IAy
	abfnrNbqLQ==
X-Received: by 2002:a05:600c:3b99:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43f1fdc3c3fmr471315e9.6.1744143330922;
        Tue, 08 Apr 2025 13:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn8z1doH7wp9+dHhoArMr/BsEh7IuVXOUKUcc5oWzI+ZgXkEyl+vRRrYAEmbGXMQXzSRRp2g==
X-Received: by 2002:a05:600c:3b99:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43f1fdc3c3fmr471095e9.6.1744143330562;
        Tue, 08 Apr 2025 13:15:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2ffsm170017585e9.22.2025.04.08.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:15:29 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:15:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org,
	lirongqing@baidu.com, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250408155057-mutt-send-email-mst@kernel.org>
References: <20250408145908.51811-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408145908.51811-1-parav@nvidia.com>

On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> The cited commit introduced a fix that marks the device as broken
> during surprise removal. However, this approach causes uncompleted
> I/O requests on virtio-blk device. The presence of uncompleted I/O
> requests prevents the successful removal of virtio-blk devices.
> 
> This fix allows devices that simulate a surprise removal but actually
> remove gracefully to continue working as before.
> 
> For surprise removals, a better solution will be preferred in the future.

Sorry I'm not breaking one thing to fix another.
Device is gone so no new requests will be completed. Why not complete all
unfinished requests, for example?

Come up with a proper fix pls.

> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d6d79af44569..dba5eb2eaff9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> -	/*
> -	 * Device is marked broken on surprise removal so that virtio upper
> -	 * layers can abort any ongoing operation.
> -	 */
> -	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> -
>  	pci_disable_sriov(pci_dev);
>  
>  	unregister_virtio_device(&vp_dev->vdev);
> -- 
> 2.26.2


