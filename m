Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F37DD47F
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjJaRS1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJaRS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED478F
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698772656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KItUmro+eQMn3OtC7hcwqT1jD+OcEM3bVlAzhSK/rtQ=;
        b=JmuqbkxJHE6t9blA7JH0cQyPIeLN3XVioKCn6pmVtptKSlK26m8sle6d61SzLeSWSBf5MO
        OF1fWeyDGKkIP2KydOW24rkrsV775q36nIW+UrC4S26ffcPrt/jnOCSDKLbK6Z5n4mb0pM
        xa4s4rho59nhHvNaVkh73BeKgewx3rA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-eScYHzCiPQ6pOZB5DxRIkw-1; Tue,
 31 Oct 2023 13:17:27 -0400
X-MC-Unique: eScYHzCiPQ6pOZB5DxRIkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A8F29ABA2C;
        Tue, 31 Oct 2023 17:17:26 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D58F33D4;
        Tue, 31 Oct 2023 17:17:26 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id BE00830C2A86; Tue, 31 Oct 2023 17:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id B97CC3FB77;
        Tue, 31 Oct 2023 18:17:26 +0100 (CET)
Date:   Tue, 31 Oct 2023 18:17:26 +0100 (CET)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
cc:     Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <ZUEgWA5P8MFbyeBN@mail-itl>
Message-ID: <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com>
References: <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com> <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz> <20231030122513.6gds75hxd65gu747@quack3> <ZT+wDLwCBRB1O+vB@mail-itl> <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com> <20231030155603.k3kejytq2e4vnp7z@quack3>
 <ZT/e/EaBIkJEgevQ@mail-itl> <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com> <ZUB5HFeK3eHeI8UH@mail-itl> <20231031140136.25bio5wajc5pmdtl@quack3> <ZUEgWA5P8MFbyeBN@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-713297632-1698772646=:87896"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--185210117-713297632-1698772646=:87896
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 31 Oct 2023, Marek Marczykowski-Górecki wrote:

> On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> > On Tue 31-10-23 04:48:44, Marek Marczykowski-Górecki wrote:
> > > Then tried:
> > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=4 - cannot reproduce,
> > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=5 - cannot reproduce,
> > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=6 - freeze rather quickly
> > > 
> > > I've retried the PAGE_ALLOC_COSTLY_ORDER=4,order=5 case several times
> > > and I can't reproduce the issue there. I'm confused...
> > 
> > And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> > causing hangs is most likely just a coincidence. Rather something either in
> > the block layer or in the storage driver has problems with handling bios
> > with sufficiently high order pages attached. This is going to be a bit
> > painful to debug I'm afraid. How long does it take for you trigger the
> > hang? I'm asking to get rough estimate how heavy tracing we can afford so
> > that we don't overwhelm the system...
> 
> Sometimes it freezes just after logging in, but in worst case it takes
> me about 10min of more or less `tar xz` + `dd`.

Hi

I would like to ask you to try this patch. Revert the changes to "order" 
and "PAGE_ALLOC_COSTLY_ORDER" back to normal and apply this patch on a 
clean upstream kernel.

Does it deadlock?

There is a bug in dm-crypt that it doesn't account large pages in 
cc->n_allocated_pages, this patch fixes the bug.

Mikulas



---
 drivers/md/dm-crypt.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-stable/drivers/md/dm-crypt.c
===================================================================
--- linux-stable.orig/drivers/md/dm-crypt.c	2023-10-31 16:25:09.000000000 +0100
+++ linux-stable/drivers/md/dm-crypt.c	2023-10-31 16:53:14.000000000 +0100
@@ -1700,11 +1700,16 @@ retry:
 		order = min(order, remaining_order);
 
 		while (order > 0) {
+			if (unlikely(percpu_counter_read_positive(&cc->n_allocated_pages) + (1 << order) > dm_crypt_pages_per_client))
+				goto decrease_order;
 			pages = alloc_pages(gfp_mask
 				| __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN | __GFP_COMP,
 				order);
-			if (likely(pages != NULL))
+			if (likely(pages != NULL)) {
+				percpu_counter_add(&cc->n_allocated_pages, 1 << order);
 				goto have_pages;
+			}
+decrease_order:
 			order--;
 		}
 
@@ -1742,10 +1747,12 @@ static void crypt_free_buffer_pages(stru
 
 	if (clone->bi_vcnt > 0) { /* bio_for_each_folio_all crashes with an empty bio */
 		bio_for_each_folio_all(fi, clone) {
-			if (folio_test_large(fi.folio))
+			if (folio_test_large(fi.folio)) {
+				percpu_counter_sub(&cc->n_allocated_pages, 1 << folio_order(fi.folio));
 				folio_put(fi.folio);
-			else
+			} else {
 				mempool_free(&fi.folio->page, &cc->page_pool);
+			}
 		}
 	}
 }
--185210117-713297632-1698772646=:87896--

