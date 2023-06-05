Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBBD72334E
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFEWoY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 18:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjFEWoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 18:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7B99
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686005019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d28osYoXLI8aZOD+hoACaQ7w9IV0Ch+YHyXBsZQz6+g=;
        b=bAl5xC2ZpFH3c1e9iZVsfLBNZD13+Th9GDfCkqA7SiS9TGrj0JyvvzPksbvEOe1T33N5aO
        L3nyeT++2T8yG+rKnJbHBVli2g9B6UYP8fNhwOjHDFrzGEnmVDuSeRWLI5/SFs0jGyjg/A
        p5g/RyNqRMX9ZmcydrSK6hjYbT0F+dc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-jFp-CxglMGq1QZAFi8Vagg-1; Mon, 05 Jun 2023 18:43:38 -0400
X-MC-Unique: jFp-CxglMGq1QZAFi8Vagg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75ec910abd8so33882885a.1
        for <Stable@vger.kernel.org>; Mon, 05 Jun 2023 15:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005002; x=1688597002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d28osYoXLI8aZOD+hoACaQ7w9IV0Ch+YHyXBsZQz6+g=;
        b=Rf/y0TBg0iWpupuTQ9HvO2mTQJP4ivaVcBiSnlZaK8lgTD7uB+rOqDHX/XoGHZwpCR
         wSYLVky3b0lzq0QZWzsAGsOdpJN9xoY3MgJZg8CzDBUOlvgBWnWy2zeZpOr6DRbE51ys
         cnnrJAjg48Sh/wh8lYmI620DK/G/FbZkeCNTJaDXC6QHrPLXNqQ6NY5tysEYsNSMouMe
         EyLiGSuLp1f7QRqtIowZtBE7OzNtE3p1cpWyeblDT8ncO6GkF1tAQqxTK9yaqVgPKBQK
         HNhX98jVDnNtWCr9C6QT8qd0Npght+Ht7XC03cZPZqLtQIwISbMqVC+r0a9jTOkL947Z
         WKRw==
X-Gm-Message-State: AC+VfDyc1wgC4zIOzzqx9eUZdphlFiKUREZGK62liOrJMcURnzql9Kim
        GeqQt2fD/r/Kohc+rbkdXRzDcP4Pq6glghkLrahwc9HDL5YEoJ868D4cMoHUee4FUjrRHCrcXrb
        XerP4INNP2NIw5s+/
X-Received: by 2002:a05:620a:d8d:b0:75d:4ee7:f489 with SMTP id q13-20020a05620a0d8d00b0075d4ee7f489mr185248qkl.23.1686005002154;
        Mon, 05 Jun 2023 15:43:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Voqg2ctHbuSQ0Bcs6yMTOd6v5gLYeteFLrtv6U84XvMe/O+UUK0Fj173jf1Xf4BVsRE/oFg==
X-Received: by 2002:a05:620a:d8d:b0:75d:4ee7:f489 with SMTP id q13-20020a05620a0d8d00b0075d4ee7f489mr185238qkl.23.1686005001844;
        Mon, 05 Jun 2023 15:43:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b0075b2af4a076sm4552610qkg.16.2023.06.05.15.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:43:21 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:43:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     vasant.hegde@amd.com, Stable@vger.kernel.org, jroedel@suse.de,
        suravee.suthikulpanit@amd.com
Subject: Re: FAILED: patch "[PATCH] iommu/amd/pgtbl_v2: Fix domain max
 address" failed to apply to 6.3-stable tree
Message-ID: <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
References: <2023060548-rake-strongman-fdbe@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060548-rake-strongman-fdbe@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 10:38:48PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060548-rake-strongman-fdbe@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 

I'm not sure what happened, but it works for me:

# git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
 * branch                      linux-6.3.y -> FETCH_HEAD
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
# git co FETCH_HEAD
Note: switching to 'FETCH_HEAD'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at abfd9cf1c3d4 Linux 6.3.6
# git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
Auto-merging drivers/iommu/amd/iommu.c
[detached HEAD 20a7d8fdd693] iommu/amd/pgtbl_v2: Fix domain max address
 Author: Vasant Hegde <vasant.hegde@amd.com>
 Date: Thu May 18 05:43:51 2023 +0000
 1 file changed, 10 insertions(+), 1 deletion(-)

It also worked with 6.1.y:

# git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
 * branch                      linux-6.1.y -> FETCH_HEAD
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
# git co FETCH_HEAD                                                                      
Note: switching to 'FETCH_HEAD'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 76ba310227d2 Linux 6.1.32
# git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9                            
Auto-merging drivers/iommu/amd/iommu.c
[detached HEAD 75eead6b6b81] iommu/amd/pgtbl_v2: Fix domain max address
 Author: Vasant Hegde <vasant.hegde@amd.com>
 Date: Thu May 18 05:43:51 2023 +0000
 1 file changed, 10 insertions(+), 1 deletion(-)


Regards,
Jerry


> ------------------ original commit in Linus's tree ------------------
> 
> From 11c439a19466e7feaccdbce148a75372fddaf4e9 Mon Sep 17 00:00:00 2001
> From: Vasant Hegde <vasant.hegde@amd.com>
> Date: Thu, 18 May 2023 05:43:51 +0000
> Subject: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
> 
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
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Link: https://lore.kernel.org/r/20230518054351.9626-1-vasant.hegde@amd.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0f3ac4b489d6..dc1ec6849775 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2129,6 +2129,15 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
> @@ -2145,7 +2154,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  		return NULL;
>  
>  	domain->domain.geometry.aperture_start = 0;
> -	domain->domain.geometry.aperture_end   = ~0ULL;
> +	domain->domain.geometry.aperture_end   = dma_max_address();
>  	domain->domain.geometry.force_aperture = true;
>  
>  	return &domain->domain;
> 

