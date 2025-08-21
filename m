Return-Path: <stable+bounces-171957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F7B2F317
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AFD189F54D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2B1E32B9;
	Thu, 21 Aug 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJITT+dB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DB211290
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766829; cv=none; b=JAJl4kYay4yvJM5SAnJX1XaeTkq5p2+q2yEp/E+kuieAAi1BgINpmC7Ef0mNMkVm7v7YRzvGCNxGPnr6XIqKP0X4W39R2O/HXxXUnccESA2UXa6+GnifXGUbpcRG7d8DVqSfgZAXNSxEnLzOaHd6jQ79445l2momLCK1Eb0Oeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766829; c=relaxed/simple;
	bh=F1bQCaVkknpAXmD3Y2LWgtDLgRsVad+mR861NV5ZCaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suS1Wnl43YuGnbHfMWBAHX0ASPxuVcLrfAQGD2pFgg8xETBiyU+mHgHX3xl5N8kigx588PB0Ea73PrMhif8438Ylcsd1rD2VvdjUy+VQ7oDeh6B0FqOUkWkw8mVDUoCmoJEvZu3GRlKzaPyBJqq/ZLNdkiB4bwD6GV4vmrj45t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJITT+dB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766827;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZryWVFyVtFZSWAWYLNDZgexNLIyxMGbOeXWK21db0Rc=;
	b=LJITT+dBxOBDEJUfxmPym2YQHKkg/YLRW67ZXfGp6EqZOn7sh2Wy5Ep5lrUN/yFQFGPbeY
	S7pR+wpHwfU1PKHLsQihEZIQbHj15EGS5OPQkCdQkDXf5kQGn8Ru7pUSSdomZ1sP4SGfwg
	RkqcJeckuq/I7zmUc5IuKxp0k92UV9M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-AKmIaqCBM7q7Kn7OcWyZ0g-1; Thu, 21 Aug 2025 05:00:18 -0400
X-MC-Unique: AKmIaqCBM7q7Kn7OcWyZ0g-1
X-Mimecast-MFC-AGG-ID: AKmIaqCBM7q7Kn7OcWyZ0g_1755766817
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9edf2d82dso380948f8f.2
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 02:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766817; x=1756371617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZryWVFyVtFZSWAWYLNDZgexNLIyxMGbOeXWK21db0Rc=;
        b=DD2KmqOuxT0mitEoHEBXvtd/3C5se5twUADohzOVAbI0Bzuu+Hptk7tv9V1AyhbN92
         YYZRWiQtrZFNaHT/SXfas9ZEWDDVyI+lA8nuYaqFc9JVsJl04OoGJargsBqwb821KQSD
         jVQ/tRHaW9ez7tM+M23yVctbI7PBpd8KQmhSTNIjpA93/IxkL+2Py3BVWuxsuvDhOIX5
         v2HCuMDU2C/ZCUWoCwpoME7uTxfBpbMxtEwkMORn195wZAHmnNXeNzq9ONQNYj04Y3Ed
         uXWMsY7kZHVM9T4L1tVnkwxgeimHUTcK29MEnTiO56CD1U8BO3CRzF44/crsB+WdCjX2
         c0qA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2Vgr2Z2HuF3AOu1WK0R30QbnBFsM+/XRRmAWQQ3EdsSYy6xr2WZou6l41OAwxjpuZhlMef8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcuJcJg39Kh8qjrvSuerb4qGJA+F+24KmAQkQw87qr/Rso7kj
	JT3Az7eox4nAqAWTrbHUVZybFVLo6PHnzObx2iYj5oF3F8uNYziny4fmY+WcSP1l67r7vnLoDts
	rfPPMbM7puLhBjfEEqt5LP9y5b1g3GJtmbPIvCX8FYwE4AAqSZlCG532k6Q==
X-Gm-Gg: ASbGncus0cKt571gkOq94YEvg/Qpb1gkfow5dXuVzH4IM5tbP/e302ijXsA4iQ32+7+
	HiC8H+EgRAQzh4KiiMLN/rbfCpUEKbY+b9/8vQ1iVKOXW0/dCfMQbFUq38uw/CZptS3EcGXe6Gt
	IYRCZLtGUVvECgR+ogRqrft9yQIxJLVL/0uqxaP25UBgFM4Vsyogtfs+2IrL3PMsjBLGAdzZh1Z
	sArtElkNfjY9diU1zaS5Z6SmACsAqln4HPolFlDveBgsudLSrg17ADM2L31kTn6RMfhBabKbWBm
	lqBKefb6ZDf6HmU1jQ3uCK3huoU5YcSkQXMlVygJlyscvDadRCQfOpMwzcA3p/jAfbvVMiK/GOC
	rq49zoMPit4U=
X-Received: by 2002:a5d:5887:0:b0:3b7:8a49:eee9 with SMTP id ffacd0b85a97d-3c494fc606bmr1222832f8f.8.1755766816947;
        Thu, 21 Aug 2025 02:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt0CUA7tv7mcfd7oFDqpqP6OD/HbUnRgCATzsnpUqKXGdeLPxh20p229NNHjxNzZKD8sh7CA==
X-Received: by 2002:a5d:5887:0:b0:3b7:8a49:eee9 with SMTP id ffacd0b85a97d-3c494fc606bmr1222799f8f.8.1755766816404;
        Thu, 21 Aug 2025 02:00:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5510a646asm90953f8f.15.2025.08.21.02.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:00:15 -0700 (PDT)
Message-ID: <d08e49ca-7089-433f-862a-8c3e9914af98@redhat.com>
Date: Thu, 21 Aug 2025 11:00:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] iommu/virtio: Make instance lookup robust
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org
Cc: iommu@lists.linux.dev, virtualization@lists.linux.dev,
 stable@vger.kernel.org
References: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Robin, Joerg,

On 8/14/25 6:47 PM, Robin Murphy wrote:
> Much like arm-smmu in commit 7d835134d4e1 ("iommu/arm-smmu: Make
> instance lookup robust"), virtio-iommu appears to have the same issue
> where iommu_device_register() makes the IOMMU instance visible to other
> API callers (including itself) straight away, but internally the
> instance isn't ready to recognise itself for viommu_probe_device() to
> work correctly until after viommu_probe() has returned. This matters a
> lot more now that bus_iommu_probe() has the DT/VIOT knowledge to probe
> client devices the way that was always intended. Tweak the lookup and
> initialisation in much the same way as for arm-smmu, to ensure that what
> we register is functional and ready to go.
>
> Cc: stable@vger.kernel.org
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

could we get that fix merged as soon as possible? the virtio-iommu is
currently totally broken.

Thanks

Eric
> ---
>
> v2: Of course generic bus_find_device_by_fwnode() didn't work, since
>     it's dev->parent we need to check rather than dev itself, sigh...
> ---
>  drivers/iommu/virtio-iommu.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 532db1de201b..b39d6f134ab2 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -998,8 +998,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  	iommu_dma_get_resv_regions(dev, head);
>  }
>  
> -static const struct iommu_ops viommu_ops;
> -static struct virtio_driver virtio_iommu_drv;
> +static const struct bus_type *virtio_bus_type;
>  
>  static int viommu_match_node(struct device *dev, const void *data)
>  {
> @@ -1008,8 +1007,9 @@ static int viommu_match_node(struct device *dev, const void *data)
>  
>  static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
>  {
> -	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
> -						fwnode, viommu_match_node);
> +	struct device *dev = bus_find_device(virtio_bus_type, NULL, fwnode,
> +					     viommu_match_node);
> +
>  	put_device(dev);
>  
>  	return dev ? dev_to_virtio(dev)->priv : NULL;
> @@ -1160,6 +1160,9 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (!viommu)
>  		return -ENOMEM;
>  
> +	/* Borrow this for easy lookups later */
> +	virtio_bus_type = dev->bus;
> +
>  	spin_lock_init(&viommu->request_lock);
>  	ida_init(&viommu->domain_ids);
>  	viommu->dev = dev;
> @@ -1229,10 +1232,10 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (ret)
>  		goto err_free_vqs;
>  
> -	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> -
>  	vdev->priv = viommu;
>  
> +	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> +
>  	dev_info(dev, "input address: %u bits\n",
>  		 order_base_2(viommu->geometry.aperture_end));
>  	dev_info(dev, "page mask: %#llx\n", viommu->pgsize_bitmap);


