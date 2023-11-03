Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8617E0B37
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 23:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjKCWm1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 18:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjKCWm0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 18:42:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21769D62
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 15:42:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C91C433C8;
        Fri,  3 Nov 2023 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699051343;
        bh=M+ptlKAOA+sEX04/48lagPpY5EWZpkTUmUL2k+ef/pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfmzVrQXas81SSCB36xz6q8EtGP9twOOIhmsKM+uoZfMsW+0wM/d/2SasJdjn2WwE
         fl/yMQXNLZ0NuKwY/i9K7SiBWM+pukZzeYlx6ZpnS8SMfWzQnDrxKXtxqJ+kLhDfA7
         sXk24jYSI/be0ykfa1mka/drdfyx724vCRMX/uaYshRasQkMCBroWscqqQv+X3HJ/R
         jyJacUYfBNZ0XqBztWabkaMXJr8qfcfcNxCJJ2Kxcstq0rnTNwgE2ArwLfNnbHRJet
         VOxYUE1gAB/nWF/jIy0KoHFAQVGPLJTenAKFF86kL4jbLv09qscuDGu8v7dQlZn83S
         WkSaQZTeGvgig==
Date:   Fri, 3 Nov 2023 16:42:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com>
References: <ZUEgWA5P8MFbyeBN@mail-itl>
 <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com>
 <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com>
 <ZULvkPhcpgAVyI8w@mail-itl>
 <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com>
 <ZUOL8kXVTF1OngeN@mail-itl>
 <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com>
 <ZUUctamEFtAlSnSV@mail-itl>
 <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
 <ZUVYT1Xp4+hFT27W@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUVYT1Xp4+hFT27W@mail-itl>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 09:30:07PM +0100, Marek Marczykowski-G'orecki wrote:
> On Fri, Nov 03, 2023 at 10:54:00AM -0600, Keith Busch wrote:
> > On Fri, Nov 03, 2023 at 05:15:49PM +0100, Marek Marczykowski-G'orecki wrote:
> > > On Thu, Nov 02, 2023 at 06:06:33PM +0100, Mikulas Patocka wrote:
> > > > Then, try this patch (without "iommu=panic"), reproduce the deadlock and 
> > > > tell us which one of the "printk" statements is triggered during the 
> > > > deadlock.
> > > 
> > > The "821" one - see below.
> > 
> > Thanks for confirming!
> > 
> > Could you try this patch?
> 
> Besides min3() being unhappy about types, it works.

Oops, should have changed the constant to "ul" instead of just "u".

Anyway, the overall idea makes sense to me, but I don't know the swiotlb
stuff well.

Christoph, does that patch make sense? For reference:

   https://lore.kernel.org/linux-mm/ZUOr-vp0yRkLyvyi@kbusch-mbp.dhcp.thefacebook.com/T/#m8d34245e0eef43f8e9fe6cba6038d77ed2a93ad6
