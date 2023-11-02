Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C57DF478
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjKBOCn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOCn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 10:02:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0E83;
        Thu,  2 Nov 2023 07:02:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B93C433C9;
        Thu,  2 Nov 2023 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698933759;
        bh=fgOZjn0WdFzXtcn8lGgDLoPHzxr8QdP2NR/ys5t0Tbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SX4WtNKm5pDj9w492ahqKstWDnWh6M4sJIDEesfWnzHG+qb9Q4yNf6O/VTmBrzQ+B
         J+lN6pLndYpPJ2///jW3lO8ULdP1cvkId8z0QLLU9SCD1Vn3MCh+blaB22zqDAiR/o
         XR4l+VlEP7zQokYYie6zAycHpAphfEalcKMzDRGBY7DIFdzBxEoSIM1JcGC8CJxbij
         F9Ali9mUj5nbbM9wS1hvCdR6/H4SvGkafHYkIN0s4b7pqOGcZS/Zcm6+PYMZJDJNev
         2MmTfCZEAoTWDPXuEvghazEUvKAcFhgHBcECGGT8wd3jtYaMQqEyBmgULjji+2X7SU
         nEdY57VcxKcNQ==
Date:   Thu, 2 Nov 2023 08:02:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>, Ming Lei <tom.leiming@gmail.com>,
        Marek =?us-ascii?Q?Marczykowski-G'orecki?= 
        <marmarek@invisiblethingslab.com>, Jan Kara <jack@suse.cz>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUOr-vp0yRkLyvyi@kbusch-mbp.dhcp.thefacebook.com>
References: <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com>
 <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl>
 <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com>
 <ZUG0gcRhUlFm57qN@mail-itl>
 <ZUHE52SznRaZQxnG@fedora>
 <ab02413f-4bf2-4d92-baf7-62fbd106f5df@suse.de>
 <ZUI1GSSL4vdsFVHq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUI1GSSL4vdsFVHq@fedora>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 07:23:05PM +0800, Ming Lei wrote:
> On Wed, Nov 01, 2023 at 11:15:02AM +0100, Hannes Reinecke wrote:
> > > nvme_queue_rq() on the above request.
> > > 
> > And that is something I've been wondering (for quite some time now):
> > What _is_ the appropriate error handling for -ENOMEM?
> 
> It is just my guess.
> 
> Actually it shouldn't fail since the sgl allocation is backed with
> memory pool, but there is also dma pool allocation and dma mapping.
> 
> > At this time, we assume it to be a retryable error and re-run the queue
> > in the hope that things will sort itself out.
> 
> It should not be hard to figure out why nvme_queue_rq() can't move on.

There's only a few reasons nvme_queue_rq would return BLK_STS_RESOURCE
for a typical read/write command:

  DMA mapping error
  Can't allocate SGL from mempool
  Can't allocate PRP from dma_pool
  Controller stuck in resetting state

We should always be able to get at least one allocation from the memory
pools, so I think the only one the driver doesn't have a way to
guarantee eventual forward progress are the DMA mapping error
conditions. Is there some other limit that the driver needs to consider
when configuring it's largest supported transfers?
