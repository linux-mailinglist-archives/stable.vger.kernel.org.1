Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78270D410
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjEWGhM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 02:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGhL (ORCPT
        <rfc822;Stable@vger.kernel.org>); Tue, 23 May 2023 02:37:11 -0400
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 23:37:09 PDT
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F08E7109
        for <Stable@vger.kernel.org>; Mon, 22 May 2023 23:37:09 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4F0242480E1;
        Tue, 23 May 2023 08:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684823463;
        bh=eHzQvI5QUqoz/Lj0lFCmplzcxBOdggkDnxBKLyCSgZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ht1I1ooxYWysJaxa7r+omLTUJfWAbnxloIVNPRdVoQcXQoR4Qs6RqQsXACfv/Leys
         IAGnIxD1vYjEXYzVXA/Au2GRfQkA+aOd4aOXo9LXjtH0lZNDstpSWw9aQ6X+eK2sAA
         9Qu+OXm1VbuD0OtEqgpt0zBuZFk0f3fUivh/8K+M6VIH4S/9Wvz7w6V1oyogAoDPfF
         dXAnwcbXJCSepegU16GkWsKZsVtI90RO9A1n7R4W/EgEQXTfGB0M+LdURRGWkMetoh
         yZCoXy9JidJKE6gpwrZ79Pu28Ceieq749gRa5qIw/JuU62tjYCHk1/5JRIwEWLDW8P
         pMPgccG9T4f9Q==
Date:   Tue, 23 May 2023 08:31:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
        Jerry Snitselaar <jsnitsel@redhat.com>, Stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <ZGxdpiW47H3vAoL4@8bytes.org>
References: <20230518054351.9626-1-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518054351.9626-1-vasant.hegde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Applied for 6.4, thanks Vasant.
