Return-Path: <stable+bounces-169607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F329AB26D48
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA4F4E307F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B41FDA89;
	Thu, 14 Aug 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uspf+S06"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6F1DF98D
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191508; cv=none; b=hGRlBTOSCiroTAIW6kvNGH89DWNT9wAB23W3Jv2T2B9pAyO3vY0J6ui+B8XRutdZoS3Kfklcu+ztW9M/ynsQFf9Ep2XLJ7HnrhABZbLHaKssCs0yFsbMhuvYs27SRXRjvtrkpjx8Xw1Reh0szbCqLquZLnKKTTzaZyrSJPQtl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191508; c=relaxed/simple;
	bh=AhX5F4G0aBYzPmFDasmo2ht5cOhGbSJjHuqzpT/I+Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwgK6hmbJvYrhwWD7o4sMT4orU/jOSNrjmZlsea9x/BtlyfboKp/LMxoDokc8mUiDU7NBdAeBki+2toG3hMWblUO6j9HH7tCoF3lBQyQ1vpPCkKJTIouET8WuVJTZ0V1vPbRUiHaA6glns8ca3UOKGc9dzJcfujvVVxVFn8yo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uspf+S06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755191506;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lznyOOkV6KkkIEe59fB3MWrdJzsx93AmS4/MBGo8g1g=;
	b=Uspf+S06CRjvpvhh1zBI92fWnUIxeCJj9r4qeRXYeN/dLQTC8wPFDU3WwRrM8c57yNvIg+
	8bp3iGERf/0rYnlfPuwH/YDfvc4CXn6qrLYcECGvaqyhuAsfGIcuFp1mh8nRmMgdRRkjla
	Odvr3A1ALZrS4qoNDJbpr+ZggJuL3IQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-JpwO8nKZPcOow3Wl0J_vAg-1; Thu, 14 Aug 2025 13:11:45 -0400
X-MC-Unique: JpwO8nKZPcOow3Wl0J_vAg-1
X-Mimecast-MFC-AGG-ID: JpwO8nKZPcOow3Wl0J_vAg_1755191504
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8705feefaso312123085a.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191504; x=1755796304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lznyOOkV6KkkIEe59fB3MWrdJzsx93AmS4/MBGo8g1g=;
        b=XMZ4kFy3JFLqEMadjtZ31XQvlYeVQG/8CsCBfhxkuPoekw2j4gGvXNNZe6b17uYZkA
         H0g7SPElKp/iqXWZo2KNGS6x5PJfFYKLYq0UsXy+nSK+HrLN9UfVe//aODN0GGO4jyxk
         K3Yymm3L1QzRpHyUyNeR33vY29nzg9uPtYP8kKsrLtmWq7XSXQxFnc02KuGqqyIb0rXh
         jiBjLLjZVy+XQSVn5rdv4L/lQlSYOZQx2zqeJj9RRWbuusc6Y8WXY+3LRjRzOFWUkEvj
         0QYbmhHjfXJEqs95F6SkkF2pbokK6jXre8xOzaE63sag8wD0kxACVJnuwaahhvKEVy0+
         TSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt15rdyy3sVL9GAvKgvr916W7KAGDHxveH7keWacIlpGb0yCy81jQ49l9forcfLebTLhpsiz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCGZqaDib7VVKRAYgYpgRqkURFkGPudi1LbjfJ48Em39WboxF
	0ysU8mPdaaApJj7zxgDBMeJBDIBnHg3adOB/5w7Oxyb5m1sqxEVnP9FZWAYyMOy2WchCbmXNfrG
	xa5ozn+07GuDGIorAC/Xga9aay2m0pbl5EFei+mBGSZxJ+58ou3i71KLF3Q==
X-Gm-Gg: ASbGncvViL/r+T/F/N0LpYN2H4o+gNm1HMwMINehQ0uBgSPCxM1F95ss3U4DZfv4icC
	zIJ3FBuTPiMBWnLohuGRS7BEw/XXfJMh4iiexftKhwXlXVyypWsdJdfZLEOs+zDJ7kPUKzCFkq6
	SbZLYGdEhrl/JSsgnv9FV19pBksL3t8bxIEsodounMjYKsG0kdpwFlg8zySGQfMfYQ66xTDKxWO
	fJN12upAlKwBZHD6n4p808oxkb8vIEZ7z0bf+QlJjk35v4S87wF4HRwMtrot6ORvrU1ppIRrMe1
	WHF3VwExNZa61Bfllw3mSGYju4EFeUKVqMS9mLJWy0mPMu8xXOpFpRPzgXHEVAR+JWijgm/JlA3
	91Z91nImjLys=
X-Received: by 2002:a05:620a:424a:b0:7e8:7094:52e7 with SMTP id af79cd13be357-7e87094638dmr516634985a.10.1755191504418;
        Thu, 14 Aug 2025 10:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1WjbN3jtp13Y9aVPhnFkE4KaUT281M8OZYzkWWCEt0LdtOUTsCxK8pvtDoHGnPioaqAABXA==
X-Received: by 2002:a05:620a:424a:b0:7e8:7094:52e7 with SMTP id af79cd13be357-7e87094638dmr516630585a.10.1755191503980;
        Thu, 14 Aug 2025 10:11:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87b37e80bsm2466785a.37.2025.08.14.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:11:43 -0700 (PDT)
Message-ID: <589663b5-7b92-4366-b4c1-6d4e091a0ea7@redhat.com>
Date: Thu, 14 Aug 2025 19:11:41 +0200
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

Hi Robin,

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

This version works for me. Thanks for the diligent respin.

Tested-by: Eric Auger <eric.auger@redhat.com>

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


