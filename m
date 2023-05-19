Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7316709E8E
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjESRvN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESRvM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 13:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A57F9
        for <stable@vger.kernel.org>; Fri, 19 May 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684518632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdI27anb7eL6qAyMiv6nQ13HyxwYxmrDZjQAillNruI=;
        b=jUF3z14j8iRKArzby8nli8rGGcTvJAF/tei1MDMXq1oCW4xcnsxdODymoysMDlntBb3aws
        AgdSW3YrMGGxRkZ1rknBxosi4N2I12Ks1f3do8wQBLgCZwhQ28yP4lgKkV0MSzTHySW5VT
        SJmnpJKX0Ao/SEud7DECE/O5KOLx4uY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-wzdYpj96MIec9CLfwlt7_w-1; Fri, 19 May 2023 13:50:30 -0400
X-MC-Unique: wzdYpj96MIec9CLfwlt7_w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f5320e9520so7483301cf.0
        for <Stable@vger.kernel.org>; Fri, 19 May 2023 10:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518629; x=1687110629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdI27anb7eL6qAyMiv6nQ13HyxwYxmrDZjQAillNruI=;
        b=Mq3q8YaMBcUCLMYBw0WSp8m0Rf4rBUUBeTp/jE5Le2CrHPrwWKA9XFCAe2zD7XXXsv
         1mwfTnfiWXV2+zzaBBPpoXmq1dSeczpV+TCKPwel3YTA8qM3JR8VjCD4hZfUo76yz7m+
         +tAqGwzRezL08rDADhU54V6nFnfrtO+D/L7b8he83inH87kK3GG2OUA5359D8/6sWBiZ
         jjGt0R8c5kJ8y58vQNgALqSGrpuY2Kn39PPKReBS4sjV76lvULRoxfJEEDjYvHGNr0oZ
         vSUXefTWWT2of55Pyqr9WHur7uV9KN7svrppVqt+0spSI+B0809Zxq3CZur+71WcVOba
         HFGg==
X-Gm-Message-State: AC+VfDw3BIeXcagB7ZGpsbydNxe2cAVidgibPgcKsGC2qKqpugowqH8p
        LZV3q6j1I47jLls7btAn+7k209jgLD07ZP7zWb+IaCOOciE/kI9iCXkogbKHdDFOnmr7hUC/jci
        paBsJVgdNS6keJgV7
X-Received: by 2002:a05:622a:11c1:b0:3f4:f522:dd8c with SMTP id n1-20020a05622a11c100b003f4f522dd8cmr7576389qtk.18.1684518629740;
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Wufbot9sDPScxQAkOS3FcC3/sNYf+m1UaSKx2C/VToTdizBKNtGmbdmPqRaOymi2+LcIHQw==
X-Received: by 2002:a05:622a:11c1:b0:3f4:f522:dd8c with SMTP id n1-20020a05622a11c100b003f4f522dd8cmr7576367qtk.18.1684518629505;
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g11-20020ae9e10b000000b0074ca7c33b79sm1269098qkm.23.2023.05.19.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:50:29 -0700 (PDT)
Date:   Fri, 19 May 2023 10:50:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     iommu@lists.linux.dev, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, Stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <wusnt6x3ynryimgwh2dj5bp3haeb3ux2wjq7y7sym7l4q6tzcx@loyd63j2q63j>
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

Hi Vasant,

For the stable releases, this will need to be PAGE_MODE_4_LEVEL
instead of amd_iommu_gpt_level? The 6.4 merge window is when
amd_iommu_gpt_level arrived with the 5 level page table changes.

Regards,
Jerry

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

