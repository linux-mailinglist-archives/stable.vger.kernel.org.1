Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4447E0E99
	for <lists+stable@lfdr.de>; Sat,  4 Nov 2023 10:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjKDJ21 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 4 Nov 2023 05:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJ20 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 4 Nov 2023 05:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E7B8
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699090056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPvHbOHp2mpCRyE6TKuaQPvtvqV9a46GDausHS+rr5w=;
        b=AsHlb4q4JbQoizObxmGRb/dH+rhxbR1dBpMAbaZg9WS69m0dKXBbnrJHfX5WZ3072MbXw2
        u22MH30NGnQ0n9AZzus2YJzQgjtKtahu3ckM/R7rwr40V980Cfx4dyPUXFKu83ikUjh6UI
        /eCTILio3+0L3I/HS7ea/ASc4gpLp0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-jDavsoSvN169EGXm_kGPPg-1; Sat, 04 Nov 2023 05:27:33 -0400
X-MC-Unique: jDavsoSvN169EGXm_kGPPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D466180D720;
        Sat,  4 Nov 2023 09:27:32 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5140D2026D4C;
        Sat,  4 Nov 2023 09:27:32 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 3914B30C2A86; Sat,  4 Nov 2023 09:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 3564A3FB77;
        Sat,  4 Nov 2023 10:27:32 +0100 (CET)
Date:   Sat, 4 Nov 2023 10:27:32 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
cc:     Marek Marczykowski-G'orecki <marmarek@invisiblethingslab.com>,
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
In-Reply-To: <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <11a9886d-316c-edcd-d6da-24ad0b9a2b4@redhat.com>
References: <ZUEgWA5P8MFbyeBN@mail-itl> <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com> <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com> <ZULvkPhcpgAVyI8w@mail-itl> <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com> <ZUOL8kXVTF1OngeN@mail-itl>
 <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com> <ZUUctamEFtAlSnSV@mail-itl> <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com> <ZUVYT1Xp4+hFT27W@mail-itl> <ZUV3TApYYoh_oiRR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On Fri, 3 Nov 2023, Keith Busch wrote:

> On Fri, Nov 03, 2023 at 09:30:07PM +0100, Marek Marczykowski-G'orecki wrote:
> > On Fri, Nov 03, 2023 at 10:54:00AM -0600, Keith Busch wrote:
> > > On Fri, Nov 03, 2023 at 05:15:49PM +0100, Marek Marczykowski-G'orecki wrote:
> > > > On Thu, Nov 02, 2023 at 06:06:33PM +0100, Mikulas Patocka wrote:
> > > > > Then, try this patch (without "iommu=panic"), reproduce the deadlock and 
> > > > > tell us which one of the "printk" statements is triggered during the 
> > > > > deadlock.
> > > > 
> > > > The "821" one - see below.
> > > 
> > > Thanks for confirming!
> > > 
> > > Could you try this patch?
> > 
> > Besides min3() being unhappy about types, it works.
> 
> Oops, should have changed the constant to "ul" instead of just "u".
> 
> Anyway, the overall idea makes sense to me, but I don't know the swiotlb
> stuff well.
> 
> Christoph, does that patch make sense? For reference:
> 
>    https://lore.kernel.org/linux-mm/ZUOr-vp0yRkLyvyi@kbusch-mbp.dhcp.thefacebook.com/T/#m8d34245e0eef43f8e9fe6cba6038d77ed2a93ad6

dma_opt_mapping_size returns "min(dma_max_mapping_size(dev), size)". So 
you don't have to call dma_max_mapping_size explicitly, you can leave the 
file drivers/nvme/host/pci.c as it is.

What about the other block device drivers (AHCI, SCSI...)? Should there be 
some generic framework that restricts max_hw_sectors according to 
dma_opt_mapping_size?

Mikulas

