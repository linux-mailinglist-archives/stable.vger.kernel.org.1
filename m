Return-Path: <stable+bounces-91718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02B9BF617
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE811C21BA4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4F208993;
	Wed,  6 Nov 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O53Rgx/h"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD813A26F
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920433; cv=none; b=BvrKryxYtIIkxz4GaXHffrSORKT+hIa3IxwhoWNz1JEvMffzO905AUm31lnSwoT9M7kphgcTeUuSOqnzkq20vgTX2lIVa6CZ6iPJmkPyszv7aXCCbg4xwT7s2KzSPbq6CRXPmOCvGX1RSaPnmpC+RwQM8DvqA6p017WJzdk2ZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920433; c=relaxed/simple;
	bh=V3WOdQDunnGssZvP2vElRHU+Jjz3dxyDOM+Bff9E36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvpkyi4bZ3q3K84IT2dJRwTvLh6bXSLxISAgzqJFK8SCr+hmz47uaRUiWj+UonUBGB3Cs/jRwKT1N+kGOn/5eCaEDrB3mjnqAV1jw+d5pO6BTQJpTyaOPhijQNHCtSMlN+95kgTObcXl00L0NbGG9N71NgiDdeflNvBZ5BvIWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O53Rgx/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730920429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WokkPwMK4/QtOwYlc4n1kISM22eOS86REe3kHYM/3c=;
	b=O53Rgx/hnaEgC/InePmJCwFUO36CZFILnOCYcbAFs5AkzYrdvjDsyUJ5+nKqbzKvUID1GD
	QX3UzNijJea5ERdLJQv2UOuqZJlrkHMEcUauIiISFPWWOA/cUDLpm4gjhuC6i76aOA1p3W
	VurqgtzZjUM3d6t27OlB0ItoHSN0Kyc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-UleiN-mRPROXz9iQFJb6oA-1; Wed, 06 Nov 2024 14:13:48 -0500
X-MC-Unique: UleiN-mRPROXz9iQFJb6oA-1
X-Mimecast-MFC-AGG-ID: UleiN-mRPROXz9iQFJb6oA
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7181c3a0119so1042876a34.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 11:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730920427; x=1731525227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WokkPwMK4/QtOwYlc4n1kISM22eOS86REe3kHYM/3c=;
        b=ZwenN/F7BVRnGTpbtDi++u5v55mhD5qAecQ8tjnwWvItRwatQVAyZlYul0qZefDQ4v
         IHXLVTVVjqoSX1Az59+gP5VncjO8SOKM/ydnEDokTQ5mfFFxpWg9nn9XtGU5dUrf4M/6
         qzlmfEGO5A1IQLaTDvkRLmbrjRv55xRc6o1JKhPzG25HUHPGDkXhTfJcXrP2IXoOR4h8
         SQqbRQsisVsCSP09Q3oSKqBMwC8+EGwwZ+XrEgmP03+CbNt9YbHPRW3qI5xydKL8FIS+
         pd3kHw12oK21eTck0/tnRPV2DOyAQqqpENb8qxenancEPeneNu2bUJyXwofuYCTmoOdn
         PCaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOkTw9Tee1042G0T9Omkv7P/W6//qCsUbwbC18KwokK2PQNZHUSKvrtxnLFe2H3YEjCyOuFGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFho2NZjLe/bdVJnCZ9OGnbfdRMmg7MwyzlSG5qocMforvZv32
	r3YccPS6KYbTGcOWvtPZR5cxriY8oRnbBVWnPxz4BUSq20Cfd7jgw4oUnO7MYjSzcL5fVWb9rnK
	Ujzig3jv10/fsUErl3jkD8kVfA82u+7b8LrU+p58YmywVakuQSBoamQ==
X-Received: by 2002:a9d:6b82:0:b0:716:a99b:8f0a with SMTP id 46e09a7af769-71a0ee6ee40mr274805a34.1.1730920427534;
        Wed, 06 Nov 2024 11:13:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/gon6zRkOlaDedChecm4iprBQV15ZZVZ/MPHiCJKeuNBXkYHTN1ZbTWFZUZXsiCPjMLVfYQ==
X-Received: by 2002:a9d:6b82:0:b0:716:a99b:8f0a with SMTP id 46e09a7af769-71a0ee6ee40mr274793a34.1.1730920427233;
        Wed, 06 Nov 2024 11:13:47 -0800 (PST)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccb125dsm2945140a34.56.2024.11.06.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:13:46 -0800 (PST)
Date: Wed, 6 Nov 2024 12:13:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Reserve iova ranges for reserved regions of
 all devices
Message-ID: <vup5ms2p5o4ao3t57kfgqtnnna7e4jcvkvup2vmyf6o4qrb3qu@3aanawjzggyh>
References: <20241024153412.141765-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024153412.141765-1-jsnitsel@redhat.com>

On Thu, Oct 24, 2024 at 08:34:12AM -0700, Jerry Snitselaar wrote:
> Only the first device that is passed when the domain is set up will
> have its reserved regions reserved in the iova address space.  So if
> there are other devices in the group with unique reserved regions,
> those regions will not get reserved in the iova address space.  All of
> the ranges do get set up in the iopagetables via calls to
> iommu_create_device_direct_mappings for all devices in a group.
> 
> In the case of vt-d system this resulted in messages like the following:
> 
> [ 1632.693264] DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 173025001)
> 
> To make sure iova ranges are reserved for the reserved regions all of
> the devices, call iova_reserve_iommu_regions in iommu_dma_init_domain
> prior to exiting in the case where the domain is already initialized.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> Robin: I wasn't positive if this is the correct solution, or if it should be
>        done for the entire group at once.
> 
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2a9fa0c8cc00..5fd3cccbb233 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -707,7 +707,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>  			goto done_unlock;
>  		}
>  
> -		ret = 0;
> +		ret = iova_reserve_iommu_regions(dev, domain);
>  		goto done_unlock;
>  	}
>  
> -- 
> 2.44.0
> 

Robin,

Any thoughts on this patch? In the case where this originally popped
up it was likely a crap DMAR table in an HPE system with an ilo, as
the RMRR in question had a device in the list that as far as I could
tell didn't actually exist. The 2nd function of the sata controller
was in the list, but not the first, and the first function was the
device where the group/domain was initialized. With some debugging
code I could see it set up the ioptes for the 2nd function, but it
wasn't reserving the range of iovas.


Regards,
Jerry


