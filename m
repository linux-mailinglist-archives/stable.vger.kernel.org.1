Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6227E3477
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 05:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjKGESm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 23:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjKGESl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 23:18:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E7FC
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 20:18:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD399C433C7;
        Tue,  7 Nov 2023 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699330718;
        bh=5PvihFHBU7SqgdRwrtVBo1+6I/pEiB/RH5ISX/VMPpA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Bp79TRjy24dSDD/qE6n8ck8XIFc1iINY8FONEu+yGlfyIKf7sAGTIkE76bM888oZi
         t/diEaICWenT4mb89FLqqlQdr/kMR8ohF/pvt10vL2t3MlUQZ7W5Ej0iBA4Ey2oOkN
         piKy8MQFGWSR8jbtWOGfriFcQA+cCu5jAMkoeQ0AKDSBphqAXqQgoJX2EBGq7AUs9m
         ioOn9opMSHLLz4obHlrt6gDID/c0CNS2W8XpnuwKZL3U7uIcedn3ZGSugjsSZyBJeb
         8rD6UJHi0B64OlMSCYXWFRgCRWeUB583TG1QBgNuSaaCB5p2ZG8ANgU7du4WCoaekW
         pOdtrknRPGb8A==
Date:   Mon, 6 Nov 2023 20:18:31 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Mike Snitzer <snitzer@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        dm-devel@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v2] swiotlb-xen: provide the "max_mapping_size" method
In-Reply-To: <151bef41-e817-aea9-675-a35fdac4ed@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2311061211080.3478774@ubuntu-linux-20-04-desktop>
References: <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com> <ZUUctamEFtAlSnSV@mail-itl> <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com> <ZUVYT1Xp4+hFT27W@mail-itl> <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com> <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com>
 <ZUZOKitOAqqKiJ4n@kbusch-mbp.dhcp.thefacebook.com> <20231106071008.GB17022@lst.de> <928b5df7-fada-cf2f-6f6a-257a84547c3@redhat.com> <ZUkDUXDF6g4P86F3@kbusch-mbp.dhcp.thefacebook.com> <ZUkGpblDX637QV9y@redhat.com>
 <151bef41-e817-aea9-675-a35fdac4ed@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-46487316-1699301481=:3478774"
Content-ID: <alpine.DEB.2.22.394.2311062018170.3478774@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-46487316-1699301481=:3478774
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2311062018171.3478774@ubuntu-linux-20-04-desktop>

On Mon, 6 Nov 2023, Mikulas Patocka wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There's a bug that when using the XEN hypervisor with bios with large
> multi-page bio vectors on NVMe, the kernel deadlocks [1].
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
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Link: https://lore.kernel.org/stable/ZTNH0qtmint%2FzLJZ@mail-itl/ [1]
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


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
--8323329-46487316-1699301481=:3478774--
