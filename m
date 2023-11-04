Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C9B7E0FC2
	for <lists+stable@lfdr.de>; Sat,  4 Nov 2023 14:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKDN7M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 4 Nov 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDN7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 4 Nov 2023 09:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA34184
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 06:59:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F88C433C7;
        Sat,  4 Nov 2023 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699106349;
        bh=ngBgbPjGe4VY0Szfr2ipMZungHmONQzt8eNm8Edd7KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KG3xZ24g4Ms6FoAbNpBwwlbXSEpCSghDUU+fDRae+OdLWpsin4az0vCy6r8t0IynX
         Ms26ILWTYmmM/OqNh7nFgxdyD2K4CHSQBztulYHjiVwoF8yM2KZPtugp9o3XN5yFRj
         fNxuW7ALkEZ17/Ujy3nn+avLV3YOP0NQwLPLWuiT7ghkZY59qRXl6xmMPsogLhrTVP
         Wvj+grpXl/EASsVcR+TiRNBcwRuTo/8C7YafC7qdESsEbYISlQDH1QLGdSoHPhCQhH
         Ci67QLIMLP3AeN0hCKZo66ixY6JFtQwwRZ40Agr2GSrBJOe4P32sJzeGO/NJwwQwKd
         6VRw2CIosBc4w==
Date:   Sat, 4 Nov 2023 07:59:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
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
Message-ID: <ZUZOKitOAqqKiJ4n@kbusch-mbp.dhcp.thefacebook.com>
References: <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com>
 <ZULvkPhcpgAVyI8w@mail-itl>
 <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com>
 <ZUOL8kXVTF1OngeN@mail-itl>
 <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com>
 <ZUUctamEFtAlSnSV@mail-itl>
 <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
 <ZUVYT1Xp4+hFT27W@mail-itl>
 <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com>
 <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Nov 04, 2023 at 10:27:32AM +0100, Mikulas Patocka wrote:
> On Fri, 3 Nov 2023, Keith Busch wrote:
> > On Fri, Nov 03, 2023 at 09:30:07PM +0100, Marek Marczykowski-G'orecki wrote:
> > > On Fri, Nov 03, 2023 at 10:54:00AM -0600, Keith Busch wrote:
> > > > On Fri, Nov 03, 2023 at 05:15:49PM +0100, Marek Marczykowski-G'orecki wrote:
> > > > > On Thu, Nov 02, 2023 at 06:06:33PM +0100, Mikulas Patocka wrote:
> > > > > > Then, try this patch (without "iommu=panic"), reproduce the deadlock and 
> > > > > > tell us which one of the "printk" statements is triggered during the 
> > > > > > deadlock.
> > > > > 
> > > > > The "821" one - see below.
> > > > 
> > > > Thanks for confirming!
> > > > 
> > > > Could you try this patch?
> > > 
> > > Besides min3() being unhappy about types, it works.
> > 
> > Oops, should have changed the constant to "ul" instead of just "u".
> > 
> > Anyway, the overall idea makes sense to me, but I don't know the swiotlb
> > stuff well.
> > 
> > Christoph, does that patch make sense? For reference:
> > 
> >    https://lore.kernel.org/linux-mm/ZUOr-vp0yRkLyvyi@kbusch-mbp.dhcp.thefacebook.com/T/#m8d34245e0eef43f8e9fe6cba6038d77ed2a93ad6
> 
> dma_opt_mapping_size returns "min(dma_max_mapping_size(dev), size)". So 
> you don't have to call dma_max_mapping_size explicitly, you can leave the 
> file drivers/nvme/host/pci.c as it is.

Indeed.
 
> What about the other block device drivers (AHCI, SCSI...)? Should there be 
> some generic framework that restricts max_hw_sectors according to 
> dma_opt_mapping_size?

I think it's just like any other request_queue limits and the individual
drivers have to set up these.

Thinking on this again, this feels more like a max_segment_size limit
rather than a max_hw_sectors.
