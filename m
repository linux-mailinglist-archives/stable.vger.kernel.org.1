Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D57E1ABB
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 08:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjKFHI5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 02:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjKFHIx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 02:08:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0163123
        for <stable@vger.kernel.org>; Sun,  5 Nov 2023 23:08:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3581C6732D; Mon,  6 Nov 2023 08:08:45 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:08:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <20231106070844.GA17022@lst.de>
References: <20231031140136.25bio5wajc5pmdtl@quack3> <ZUEgWA5P8MFbyeBN@mail-itl> <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com> <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com> <ZULvkPhcpgAVyI8w@mail-itl> <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com> <ZUOL8kXVTF1OngeN@mail-itl> <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com> <ZUUctamEFtAlSnSV@mail-itl> <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> -	dev->ctrl.max_hw_sectors = min_t(u32,
> -		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
> +	dev->ctrl.max_hw_sectors = min3(NVME_MAX_KB_SZ << 1,
> +					dma_opt_mapping_size(&pdev->dev) >> 9,
> +					dma_max_mapping_size(&pdev->dev) >> 9);

dma_opt_mapping_size is already capped by dma_max_mapping_size, so no
need for this hunk.

>  	dev->ctrl.max_segments = NVME_MAX_SEGS;
>  
>  	/*
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 946bd56f0ac53..0e6c6c25d154f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -405,4 +405,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.get_sgtable = dma_common_get_sgtable,
>  	.alloc_pages = dma_common_alloc_pages,
>  	.free_pages = dma_common_free_pages,
> +	.max_mapping_size = swiotlb_max_mapping_size,
>  };
> --

And this is the right thing to do.  I'm pretty sure I wrote this
myself a while ago, but I must not have sent it out in the end.
