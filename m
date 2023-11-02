Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A17DEEE1
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjKBJ3w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 05:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJ3v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 05:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C522134
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698917341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1JjT78ESQHu9+RVUysRtBfcjHinR8ppQOAAQBOcIyM=;
        b=Ynm2KXsLX2MZM6AVhTI29iXWdy009+lYdSeFLVU5YGJPmQFJMpb5lQCIghsJItx9nh3ZSb
        aT7BrtjTkWXTJDAlzbpbb0fmFrGy/heFSHoXVqzHhsXAl9iqa8tz7u+j/whhMzMnn4D6J8
        jgsvMouZyJZAZp4dQuTXIO7JermjsRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-UaLZFHJ7PIu_aYZZTZ7-Iw-1; Thu, 02 Nov 2023 05:28:58 -0400
X-MC-Unique: UaLZFHJ7PIu_aYZZTZ7-Iw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F89E810FC0;
        Thu,  2 Nov 2023 09:28:57 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77264502B;
        Thu,  2 Nov 2023 09:28:57 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 6304D30C72B0; Thu,  2 Nov 2023 09:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 5E29F3FD16;
        Thu,  2 Nov 2023 10:28:57 +0100 (CET)
Date:   Thu, 2 Nov 2023 10:28:57 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
cc:     Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <ZULvkPhcpgAVyI8w@mail-itl>
Message-ID: <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com>
References: <ZT+wDLwCBRB1O+vB@mail-itl> <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com> <20231030155603.k3kejytq2e4vnp7z@quack3> <ZT/e/EaBIkJEgevQ@mail-itl> <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com> <ZUB5HFeK3eHeI8UH@mail-itl> <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl> <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com> <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com> <ZULvkPhcpgAVyI8w@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="185210117-2130454234-1698916941=:474267"
Content-ID: <c4e9bbcd-d17d-7d73-83e0-6bb6d8b0a6a2@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-2130454234-1698916941=:474267
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c020389a-683d-e881-89ae-58d817e7d3db@redhat.com>



On Thu, 2 Nov 2023, Marek Marczykowski-Górecki wrote:

> On Tue, Oct 31, 2023 at 06:24:19PM +0100, Mikulas Patocka wrote:
> 
> > > Hi
> > > 
> > > I would like to ask you to try this patch. Revert the changes to "order" 
> > > and "PAGE_ALLOC_COSTLY_ORDER" back to normal and apply this patch on a 
> > > clean upstream kernel.
> > > 
> > > Does it deadlock?
> > > 
> > > There is a bug in dm-crypt that it doesn't account large pages in 
> > > cc->n_allocated_pages, this patch fixes the bug.
> 
> This patch did not help.
> 
> > If the previous patch didn't fix it, try this patch (on a clean upstream 
> > kernel).
> >
> > This patch allocates large pages, but it breaks them up into single-page 
> > entries when adding them to the bio.
> 
> But this does help.

Thanks. So we can stop blaming the memory allocator and start blaming the 
NVMe subsystem.


I added NVMe maintainers to this thread - the summary of the problem is: 
In dm-crypt, we allocate a large compound page and add this compound page 
to the bio as a single big vector entry. Marek reports that on his system 
it causes deadlocks, the deadlocks look like a lost bio that was never 
completed. When I chop the large compound page to individual pages in 
dm-crypt and add bio vector for each of them, Marek reports that there are 
no longer any deadlocks. So, we have a problem (either hardware or 
software) that the NVMe subsystem doesn't like bio vectors with large 
bv_len. This is the original bug report: 
https://lore.kernel.org/stable/ZTNH0qtmint%2FzLJZ@mail-itl/


Marek, what NVMe devices do you use? Do you use the same device on all 3 
machines where you hit this bug?

In the directory /sys/block/nvme0n1/queue: what is the value of 
dma_alignment, max_hw_sectors_kb, max_sectors_kb, max_segment_size, 
max_segments, virt_boundary_mask?

Try lowring /sys/block/nvme0n1/queue/max_sectors_kb to some small value 
(for example 64) and test if it helps.

Mikulas
--185210117-2130454234-1698916941=:474267--

