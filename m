Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1C7DB477
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJ3Hib (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJ3Hib (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 03:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1447A2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698651464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9x1xINqPKW24VJSZvIxrqGM94OrSE3vzkj8Ji7WoEIE=;
        b=LuFILMnsUwGWz4JhDsw1Bl9J6JOIofV/MD26+Gbs2QVqcfp71eXjyW2d/HD2LLOHyk6mVW
        c00/dNfo6eRXQwbpC6tD7gsHmf0HrEpSNyjRj4+brxg1nmnwlrFW3L2n64N7xiJ8dVHBK5
        WDCNCDPFZgqWDsInl0i6Yq5GeO7bEdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-HtQO4g_9OzSL8hAv1k6QaQ-1; Mon, 30 Oct 2023 03:37:41 -0400
X-MC-Unique: HtQO4g_9OzSL8hAv1k6QaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2D2F857D07;
        Mon, 30 Oct 2023 07:37:40 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E2CCC1596C;
        Mon, 30 Oct 2023 07:37:40 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 088A230C72A4; Mon, 30 Oct 2023 07:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 0381D3D99F;
        Mon, 30 Oct 2023 08:37:40 +0100 (CET)
Date:   Mon, 30 Oct 2023 08:37:39 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
Message-ID: <818a23f2-c242-1c51-232d-d479c3bcbb6@redhat.com>
References: <ZTNH0qtmint/zLJZ@mail-itl> <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com> <ZTiHQDY54E7WAld+@mail-itl> <ZTiJ3CO8w0jauOzW@mail-itl> <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com> <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On Sun, 29 Oct 2023, Vlastimil Babka wrote:

> Haven't found any. However I'd like to point out some things I noticed in
> crypt_alloc_buffer(), although they are probably not related.
> 
> > static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
> > {
> > 	struct crypt_config *cc = io->cc;
> > 	struct bio *clone;
> > 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
> > 	unsigned int remaining_size;
> > 	unsigned int order = MAX_ORDER - 1;
> > 
> > retry:
> > 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
> > 		mutex_lock(&cc->bio_alloc_lock);
> 
> What if we end up in "goto retry" more than once? I don't see a matching

It is impossible. Before we jump to the retry label, we set 
__GFP_DIRECT_RECLAIM. mempool_alloc can't ever fail if 
__GFP_DIRECT_RECLAIM is present (it will just wait until some other task 
frees some objects into the mempool).

> unlock. Yeah, very unlikely to happen that order-0 in page allocator which
> includes __GFP_DIRECT_RECLAIM would fail, but not impossible, and also I see
> crypt_page_alloc() for the mempool can fail for another reason, due to a
> counter being too high. Looks dangerous.

If crypt_page_alloc fails, mempool falls back to allocating from a 
pre-allocated list.

But now I see that there is a bug that the compound pages don't contribute 
to the "cc->n_allocated_pages" counter. I'll have to fix it.

> > 
> > 	clone = bio_alloc_bioset(cc->dev->bdev, nr_iovecs, io->base_bio->bi_opf,
> > 				 GFP_NOIO, &cc->bs);
> > 	clone->bi_private = io;
> > 	clone->bi_end_io = crypt_endio;
> > 
> > 	remaining_size = size;
> > 
> > 	while (remaining_size) {
> > 		struct page *pages;
> > 		unsigned size_to_add;
> > 		unsigned remaining_order = __fls((remaining_size + PAGE_SIZE - 1) >> PAGE_SHIFT);
> 
> Tip: you can use get_order(remaining_size) here.

get_order rounds the size up and we need to round it down here (rounding 
it up would waste memory).

> > 		order = min(order, remaining_order);
> > 
> > 		while (order > 0) {
> 
> Is this intentionally > 0 and not >= 0? We could still succeed avoiding
> mempool with order-0...

Yes, it is intentional. mempool alloc will try to allocate the page using 
alloc_page, so there is no need to go to the "pages = alloc_pages" branch 
before it.

> > 			pages = alloc_pages(gfp_mask
> > 				| __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN | __GFP_COMP,
> > 				order);
> > 			if (likely(pages != NULL))
> > 				goto have_pages;
> > 			order--;
> > 		}
> > 
> > 		pages = mempool_alloc(&cc->page_pool, gfp_mask);
> > 		if (!pages) {
> > 			crypt_free_buffer_pages(cc, clone);
> > 			bio_put(clone);
> > 			gfp_mask |= __GFP_DIRECT_RECLAIM;
> > 			order = 0;
> > 			goto retry;
> > 		}
> > 
> > have_pages:
> > 		size_to_add = min((unsigned)PAGE_SIZE << order, remaining_size);
> > 		__bio_add_page(clone, pages, size_to_add, 0);
> > 		remaining_size -= size_to_add;
> > 	}
> > 
> > 	/* Allocate space for integrity tags */
> > 	if (dm_crypt_integrity_io_alloc(io, clone)) {
> > 		crypt_free_buffer_pages(cc, clone);
> > 		bio_put(clone);
> > 		clone = NULL;
> > 	}
> > 
> > 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
> > 		mutex_unlock(&cc->bio_alloc_lock);
> > 
> > 	return clone;
> > }

Mikulas

