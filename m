Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A20709DB1
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 19:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjESRRf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjESRRe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 13:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFE49E
        for <stable@vger.kernel.org>; Fri, 19 May 2023 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684516606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yR/NkvCfvmT4S31V3jI5qchDRG5AoNbgq8Ky6KegdPs=;
        b=ZJIqtpMZPh7QhNfu+0h8rFoKRV9EL0MeFmKtCrtu02pfydIB7vFWigGUeSkodT+M6Oe9gK
        VPM6JvpqouubGhFfRJmuZBIxRtKygG8xDSUUdlwIlQSNvUktl7qlZik2tPPZv10A9QVoOo
        GMQKHSw6X4BNxkZEhfGV15YqsAxUAcw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-rznDYlaLNN268rHXZLr7qA-1; Fri, 19 May 2023 13:16:45 -0400
X-MC-Unique: rznDYlaLNN268rHXZLr7qA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f39abae298so24909781cf.1
        for <Stable@vger.kernel.org>; Fri, 19 May 2023 10:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516605; x=1687108605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR/NkvCfvmT4S31V3jI5qchDRG5AoNbgq8Ky6KegdPs=;
        b=cxH2U04eV6ve26TzG5QKOdrKURBwKOsJ2OU7qSHUtCMdzMbc5I5UAjd6PztbGJ5nqR
         5AsAiPRvfT9MrfpDw8WGvEbRyziNuzpRIsNMklqYARWndNWSltYvJD0V5qF3FWni2u3O
         nGAnF3TaK7uVLTnixNvy0zSDV6KlsPodH6/uJA4foMfSFE3yXP8/I6TNSnu/KSRJ3Tax
         meWNVZAvE/qRw03XgRrwgLqClC3AbuBZnuf/OBZ6cx0sL6tFT7ph+o0FaLSWbCTkYD7V
         G7pBZJfjq2CTVqqv3PWd1FBG8HAdKpFK12AqpEg0fX/rvYnv2l/FynqTk0Gm4utkvHqb
         JKKg==
X-Gm-Message-State: AC+VfDxAWZsWp9oRnGLY6OvTSJT0s4vAaoSchEcTXZM3HfzAOWFyT6or
        qlUsvJ9hw1o+jNf6FbqomKkwkd+EMaUSf9vn0am+zsGkkqd52oV/VYXpVDEQPjYYBWvF2pKJwSm
        Wvwc9pLPbT7dZTI2s
X-Received: by 2002:a05:622a:64d:b0:3f2:eaa:6b0f with SMTP id a13-20020a05622a064d00b003f20eaa6b0fmr3715108qtb.68.1684516604784;
        Fri, 19 May 2023 10:16:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VP2sdXzCif5qwDVtl6gpXZ991V9IZ7QuC40clV6OSnUYaAaVN7v50hwqgdKY/Xz+tUl5c3A==
X-Received: by 2002:a05:622a:64d:b0:3f2:eaa:6b0f with SMTP id a13-20020a05622a064d00b003f20eaa6b0fmr3715071qtb.68.1684516604226;
        Fri, 19 May 2023 10:16:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a120d00b0074d1d3b2143sm1236524qkj.118.2023.05.19.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:16:43 -0700 (PDT)
Date:   Fri, 19 May 2023 10:16:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     iommu@lists.linux.dev, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, Stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <2meuricmfok2vumlsw4lq3ut2ulrbhmlzwfsxoo6krfa4wt5ux@j2d65uzpierq>
References: <20230518054351.9626-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518054351.9626-1-vasant.hegde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 18, 2023 at 05:43:51AM +0000, Vasant Hegde wrote:
> IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
> address space. Current code assumes it can support 64bit IOVA address
> space. If IOVA allocator allocates virtual address > 47/56 bit (depending
> on page table level) then it will do wrong mapping and cause invalid
> translation.
> 
> Hence adjust aperture size to use max address supported by the page table.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
> Cc: <Stable@vger.kernel.org>  # v6.0+
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5aaa4cf84506..e14c7c666745 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2128,6 +2128,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	return NULL;
>  }
>  
> +static inline u64 dma_max_address(void)
> +{
> +	if (amd_iommu_pgtable == AMD_IOMMU_V1)
> +		return ~0ULL;
> +
> +	/* V2 with 4/5 level page table */
> +	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
> +}
> +
>  static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  {
>  	struct protection_domain *domain;
> @@ -2144,7 +2153,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  		return NULL;
>  
>  	domain->domain.geometry.aperture_start = 0;
> -	domain->domain.geometry.aperture_end   = ~0ULL;
> +	domain->domain.geometry.aperture_end   = dma_max_address();
>  	domain->domain.geometry.force_aperture = true;
>  
>  	return &domain->domain;
> -- 
> 2.31.1
> 

