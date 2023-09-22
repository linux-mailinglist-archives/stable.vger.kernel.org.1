Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137C7AB445
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjIVO70 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIVO7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 10:59:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F7100
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 07:59:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4121130e7afso14164571cf.2
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695394759; x=1695999559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=eKZpA2y265msJcQMTXQQE3jq+PG5nahlF7Gxayl1HrnVhaxeyzP/aoSiQ7FWfxh93D
         8Dc0FyizTA1T6CrjgBYOOSKckv4lUkFmZiopVVUYN/Bsc1wHSmo7/Ls5T9Fn4AAezufI
         YnnErWciT/oUee8ZCuLd7miva378Pt+DmcFrtiFjsUKJkwtrHUkX9mEEvHAFiqt31fw/
         XRumelcgt3K272aClFlo+e3rDifE0wsOfiE3aDjIakoBnBo2YujEVQpa3AucB985Eb+0
         0CH3R+ciJA5S5T9RNctYWMKyip16rsbubE2++j8XcNUvrPplFA9WF7jszHMp0r6mvL06
         lUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394759; x=1695999559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=vT4WuXhTbB9ayd6D9lXkWMig0/2vgIy6HbY2DCrgtopzjkQAy3KNPtJT7SOzhLpZ82
         UtE3uf8suwlwhl+3Cniv/gLIFdMHkZQcu6MoKs+uzvKZViXx3Oc3KlqR2TDiEaE8ZGWi
         K/MitA5ryGhzgPa6s1lOTksj8MubmIxVvHocQJTHsqnfUn8v47ZDKiyI+UUlcuEJ3dkc
         r67dqxkbeyi86uiFFQtL5bv/BIQnwbX+XQNjqV0OHg8UmJnAN1zTEWtna8Yp6CVHPrko
         YAugPwvD4gb/rZXyv2ajdXwT+wwdaEF3G8IorSNMKn3w8w9tzfmkxWJ+241HjEyWYc8d
         hxdQ==
X-Gm-Message-State: AOJu0YzZhIoYMZ6xoLvtP+FZol4AlnYHaU+9W3hmNLDv1uAmUkejMdlZ
        0vK9I48QEOKo9CZ3NwzsfahIgg==
X-Google-Smtp-Source: AGHT+IFepS22bGXECBY+vUBb2rhMrd9rmdSAqafKVqKT+SSCdNN/lwEK0LNLwifMHk5me/tHvErfGQ==
X-Received: by 2002:ac8:5d0c:0:b0:403:72fa:630b with SMTP id f12-20020ac85d0c000000b0040372fa630bmr10093264qtx.58.1695394758807;
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t16-20020ac85310000000b00405553305casm1501734qtn.86.2023.09.22.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjhcj-000Ygf-KE;
        Fri, 22 Sep 2023 11:59:17 -0300
Date:   Fri, 22 Sep 2023 11:59:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hector Martin <marcan@marcan.st>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in
 attach_dev()
Message-ID: <20230922145917.GG13795@ziepe.ca>
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 11:55:23PM +0900, Hector Martin wrote:
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and apple-dart's attach_dev() callback does not expect
> IOMMU_DOMAIN_DMA_FQ domains.
> 
> Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
> instead of explicitly enumerating all types.
> 
> Fixes an apple-dart regression in v6.5.
> 
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

It is weird looking, but I have a followup series that will clean it -
this should go to -rc

Thanks,
Jason
