Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2D7DB93F
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJ3Ltx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Ltx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6D9D
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698666548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNWJb3Kj/1cIYg/Vg3MgPzg6XViSheol3KsOD/+icSA=;
        b=LKj8KEZ/AWcXlV4z1wrn1hxO8tbdL9RaS1mwFL6lmR9KVGGReh0tAS7eYRbm6XVozclnXd
        FrcEGRzgY7vpGbrBnh0SEbnjbjjAeDDIEcmsQ8enRpnwnMXmaB3x7pG6cA6lxG/BmRelb5
        AeGFoBRZ30pq96lEWg6En94jFqj8Xjg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-imiWb702NZ2UiB9qt1FnAg-1; Mon,
 30 Oct 2023 07:49:02 -0400
X-MC-Unique: imiWb702NZ2UiB9qt1FnAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D2863C000A2;
        Mon, 30 Oct 2023 11:49:01 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AFC2492BE0;
        Mon, 30 Oct 2023 11:49:01 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 5711B30C72AB; Mon, 30 Oct 2023 11:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 5467E3D99F;
        Mon, 30 Oct 2023 12:49:01 +0100 (CET)
Date:   Mon, 30 Oct 2023 12:49:01 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jan Kara <jack@suse.cz>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <20231030112844.g7b76cm2xxpovt6e@quack3>
Message-ID: <7355fe90-5176-ea11-d6ed-a187c0146fdc@redhat.com>
References: <ZTNH0qtmint/zLJZ@mail-itl> <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com> <ZTiHQDY54E7WAld+@mail-itl> <ZTiJ3CO8w0jauOzW@mail-itl> <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com> <89320668-67a2-2a41-e577-a2f561e3dfdd@suse.cz>
 <818a23f2-c242-1c51-232d-d479c3bcbb6@redhat.com> <18a38935-3031-1f35-bc36-40406e2e6fd2@suse.cz> <20231030112844.g7b76cm2xxpovt6e@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On Mon, 30 Oct 2023, Jan Kara wrote:

> > >> What if we end up in "goto retry" more than once? I don't see a matching
> > > 
> > > It is impossible. Before we jump to the retry label, we set 
> > > __GFP_DIRECT_RECLAIM. mempool_alloc can't ever fail if 
> > > __GFP_DIRECT_RECLAIM is present (it will just wait until some other task 
> > > frees some objects into the mempool).
> > 
> > Ah, missed that. And the traces don't show that we would be waiting for
> > that. I'm starting to think the allocation itself is really not the issue
> > here. Also I don't think it deprives something else of large order pages, as
> > per the sysrq listing they still existed.
> > 
> > What I rather suspect is what happens next to the allocated bio such that it
> > works well with order-0 or up to costly_order pages, but there's some
> > problem causing a deadlock if the bio contains larger pages than that?
> 
> Hum, so in all the backtraces presented we see that we are waiting for page
> writeback to complete but I don't see anything that would be preventing the
> bios from completing. Page writeback can submit quite large bios so it kind
> of makes sense that it trips up some odd behavior. Looking at the code
> I can see one possible problem in crypt_alloc_buffer() but it doesn't
> explain why reducing initial page order would help. Anyway: Are we
> guaranteed mempool has enough pages for arbitrarily large bio that can
> enter crypt_alloc_buffer()? I can see crypt_page_alloc() does limit the
> number of pages in the mempool to dm_crypt_pages_per_client plus I assume
> the percpu counter bias in cc->n_allocated_pages can limit the really
> available number of pages even further. So if a single bio is large enough
> to trip percpu_counter_read_positive(&cc->n_allocated_pages) >=
> dm_crypt_pages_per_client condition in crypt_page_alloc(), we can loop
> forever? But maybe this cannot happen for some reason...
> 
> If this is not it, I think we need to find out why the writeback bios are
> not completeting. Probably I'd start with checking what is kcryptd,
> presumably responsible for processing these bios, doing.
> 
> 								Honza

cc->page_pool is initialized to hold BIO_MAX_VECS pages. crypt_map will 
restrict the bio size to BIO_MAX_VECS (see dm_accept_partial_bio being 
called from crypt_map).

When we allocate a buffer in crypt_alloc_buffer, we try first allocation 
without waiting, then we grab the mutex and we try allocation with 
waiting.

The mutex should prevent a deadlock when two processes allocate 128 pages 
concurrently and wait for each other to free some pages.

The limit to dm_crypt_pages_per_client only applies to pages allocated 
from the kernel - when this limit is reached, we can still allocate from 
the mempool, so it shoudn't cause deadlocks.

Mikulas

