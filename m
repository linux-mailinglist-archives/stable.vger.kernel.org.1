Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF17E1AC3
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjKFHKO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 02:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFHKN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 02:10:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21350C6
        for <stable@vger.kernel.org>; Sun,  5 Nov 2023 23:10:11 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AFC868AA6; Mon,  6 Nov 2023 08:10:08 +0100 (CET)
Date:   Mon, 6 Nov 2023 08:10:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
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
Message-ID: <20231106071008.GB17022@lst.de>
References: <ZULvkPhcpgAVyI8w@mail-itl> <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com> <ZUOL8kXVTF1OngeN@mail-itl> <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com> <ZUUctamEFtAlSnSV@mail-itl> <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com> <ZUVYT1Xp4+hFT27W@mail-itl> <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com> <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com> <ZUZOKitOAqqKiJ4n@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUZOKitOAqqKiJ4n@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Nov 04, 2023 at 07:59:06AM -0600, Keith Busch wrote:
> > dma_opt_mapping_size returns "min(dma_max_mapping_size(dev), size)". So 
> > you don't have to call dma_max_mapping_size explicitly, you can leave the 
> > file drivers/nvme/host/pci.c as it is.
> 
> Indeed.
>  
> > What about the other block device drivers (AHCI, SCSI...)? Should there be 
> > some generic framework that restricts max_hw_sectors according to 
> > dma_opt_mapping_size?
> 
> I think it's just like any other request_queue limits and the individual
> drivers have to set up these.

Yes, or in case of SCSI the scsi midlayer, which already does it.
The block layer itself doesn't even know that we're using DMA to
transfer data.

> Thinking on this again, this feels more like a max_segment_size limit
> rather than a max_hw_sectors.

No, it's an overall limit.  If we'd have a lot of segments using the
max size we'd still starve the swiotlb pool.
