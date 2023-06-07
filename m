Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEB37267CC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFGRwt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjFGRwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 13:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311981FD4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 10:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C1C6396D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 17:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC145C433D2;
        Wed,  7 Jun 2023 17:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686160367;
        bh=ovzk4HlUuR8V6fdrhGi1M1VQ3s99p9Wibhw0AH6dQJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqmmwi3vJPcJ+V0d19R+0YjVhNzhL1kEOCKXoOLrDvajcJxuvF7hOq4sRKn12EU+T
         /aa6HklwJzf5NhTOGOyS/BhHtKLnT9m7rPduVpXNqO2JFfBperzEQMU4VTqJ4Tj4kS
         Zf+EZybTgrpFqbvRXdtttFfHYrLosLIajyvIEUpU=
Date:   Wed, 7 Jun 2023 19:52:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     stable@vger.kernel.org, Jerry Snitselaar <jsnitsel@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 6.3.y] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <2023060734-diffused-makeshift-b7e1@gregkh>
References: <2023060548-rake-strongman-fdbe@gregkh>
 <20230606143338.5730-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606143338.5730-1-vasant.hegde@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 02:33:38PM +0000, Vasant Hegde wrote:
> [ Upstream commit 11c439a19466e7feaccdbce148a75372fddaf4e9 ]
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
> [ Modified to work with "V2 with 4 level page table" only - Vasant ]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Both now queued up, thanks.

greg k-h
