Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559037E2879
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjKFPQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 10:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjKFPQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 10:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FB0D71
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 07:16:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97714C433BC;
        Mon,  6 Nov 2023 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699283796;
        bh=/HAwmovzMZdoeZvZsHcdokGslREftSrFRuxNINmZTNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1efQTYvGf8rVFkUIm2klEwzrW2mtKPa5EF8rwprtr9zH5WwvnNajfJl+shtHJF50
         /ZnBBtxAYwFDXG51JGihfmCzTaX4OxyMbmJEk3SUsAA17/dTb9U9/QQvh52VD84FTM
         VfEN6nj25Eenlmdmzjt6BJwNVvI+dgDFpIybQyLD9c+5Ee4exOLb3CTy9naiQDXXhU
         Cw/TfswQygCrntLmNHPTMdYdv3g15hW+NIhMfAYqmc2HfwvR4gsKunhB1q+pSmO1C1
         Pz32FeIJO3uX+B6Vw1z/QG9JVxwaQX4FzOdrrkHTjHSL4DFDV5YjUDxfCNKfOStlS5
         LYvEnkgAbPC1A==
Date:   Mon, 6 Nov 2023 08:16:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH] swiotlb-xen: provide the "max_mapping_size" method
Message-ID: <ZUkDUXDF6g4P86F3@kbusch-mbp.dhcp.thefacebook.com>
References: <ZUOL8kXVTF1OngeN@mail-itl>
 <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com>
 <ZUUctamEFtAlSnSV@mail-itl>
 <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
 <ZUVYT1Xp4+hFT27W@mail-itl>
 <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com>
 <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com>
 <ZUZOKitOAqqKiJ4n@kbusch-mbp.dhcp.thefacebook.com>
 <20231106071008.GB17022@lst.de>
 <928b5df7-fada-cf2f-6f6a-257a84547c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <928b5df7-fada-cf2f-6f6a-257a84547c3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 06, 2023 at 03:59:40PM +0100, Mikulas Patocka wrote:
> There's a bug that when using the XEN hypervisor with dm-crypt on NVMe, 
> the kernel deadlocks [1].
> 
> The deadlocks are caused by inability to map a large bio vector -
> dma_map_sgtable always returns an error, this gets propagated to the block
> layer as BLK_STS_RESOURCE and the block layer retries the request
> indefinitely.
> 
> XEN uses the swiotlb framework to map discontiguous pages into contiguous
> runs that are submitted to the PCIe device. The swiotlb framework has a
> limitation on the length of a mapping - this needs to be announced with
> the max_mapping_size method to make sure that the hardware drivers do not
> create larger mappings.
> 
> Without max_mapping_size, the NVMe block driver would create large
> mappings that overrun the maximum mapping size.
> 
> [1] https://lore.kernel.org/stable/ZTNH0qtmint%2FzLJZ@mail-itl/

This should be a "Link:" tag.

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>
> Tested-by: Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>
> Suggested-by: Keith Busch <kbusch@kernel.org>

I was about to send the same thing. I did a little more than suggest
this: it's is the very patch I wrote for testing, minus the redundant
nvme bits! But since you already have a commit message for it...

Acked-by: Keith Busch <kbusch@kernel.org>

> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> 
> ---
>  drivers/xen/swiotlb-xen.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-stable/drivers/xen/swiotlb-xen.c
> ===================================================================
> --- linux-stable.orig/drivers/xen/swiotlb-xen.c	2023-11-03 17:57:18.000000000 +0100
> +++ linux-stable/drivers/xen/swiotlb-xen.c	2023-11-06 15:30:59.000000000 +0100
> @@ -405,4 +405,5 @@ const struct dma_map_ops xen_swiotlb_dma
>  	.get_sgtable = dma_common_get_sgtable,
>  	.alloc_pages = dma_common_alloc_pages,
>  	.free_pages = dma_common_free_pages,
> +	.max_mapping_size = swiotlb_max_mapping_size,
>  };

