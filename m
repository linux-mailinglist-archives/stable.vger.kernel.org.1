Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B457DD4A3
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbjJaRZa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346801AbjJaRZZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903EB4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698773069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLanOpI8RfAvOTY5kOuVRF9a/IYXbIbMQg6yPwFdFS0=;
        b=SxJw49P/XJSf3CFu57aA82wQkvAq8IT869np7gcktM2UnXHmgz+96gMZOcarrIkcAT9GgG
        JHpeiI+ljxm0+2Zu5LrROTuBufC0xDdZH2wudFB6Bm4LlXxwFgfKd2Q8RdCouyqJ9FEx5E
        4Jez0maUl3MziMVcqvssVzIDCFt1fh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-94IZp1Z1OZik0zdRsm7hOw-1; Tue, 31 Oct 2023 13:24:20 -0400
X-MC-Unique: 94IZp1Z1OZik0zdRsm7hOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EECB9917D85;
        Tue, 31 Oct 2023 17:24:19 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D17912026D4C;
        Tue, 31 Oct 2023 17:24:19 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id BEFAD30C2A86; Tue, 31 Oct 2023 17:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id BBC3A3FB77;
        Tue, 31 Oct 2023 18:24:19 +0100 (CET)
Date:   Tue, 31 Oct 2023 18:24:19 +0100 (CET)
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
In-Reply-To: <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com>
Message-ID: <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com>
References: <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com> <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz> <20231030122513.6gds75hxd65gu747@quack3> <ZT+wDLwCBRB1O+vB@mail-itl> <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com> <20231030155603.k3kejytq2e4vnp7z@quack3>
 <ZT/e/EaBIkJEgevQ@mail-itl> <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com> <ZUB5HFeK3eHeI8UH@mail-itl> <20231031140136.25bio5wajc5pmdtl@quack3> <ZUEgWA5P8MFbyeBN@mail-itl> <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-1983441990-1698773059=:87896"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1983441990-1698773059=:87896
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 31 Oct 2023, Mikulas Patocka wrote:

> 
> 
> On Tue, 31 Oct 2023, Marek Marczykowski-Górecki wrote:
> 
> > On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> > > On Tue 31-10-23 04:48:44, Marek Marczykowski-Górecki wrote:
> > > > Then tried:
> > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=4 - cannot reproduce,
> > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=5 - cannot reproduce,
> > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=6 - freeze rather quickly
> > > > 
> > > > I've retried the PAGE_ALLOC_COSTLY_ORDER=4,order=5 case several times
> > > > and I can't reproduce the issue there. I'm confused...
> > > 
> > > And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> > > causing hangs is most likely just a coincidence. Rather something either in
> > > the block layer or in the storage driver has problems with handling bios
> > > with sufficiently high order pages attached. This is going to be a bit
> > > painful to debug I'm afraid. How long does it take for you trigger the
> > > hang? I'm asking to get rough estimate how heavy tracing we can afford so
> > > that we don't overwhelm the system...
> > 
> > Sometimes it freezes just after logging in, but in worst case it takes
> > me about 10min of more or less `tar xz` + `dd`.
> 
> Hi
> 
> I would like to ask you to try this patch. Revert the changes to "order" 
> and "PAGE_ALLOC_COSTLY_ORDER" back to normal and apply this patch on a 
> clean upstream kernel.
> 
> Does it deadlock?
> 
> There is a bug in dm-crypt that it doesn't account large pages in 
> cc->n_allocated_pages, this patch fixes the bug.
> 
> Mikulas

If the previous patch didn't fix it, try this patch (on a clean upstream 
kernel).

This patch allocates large pages, but it breaks them up into single-page 
entries when adding them to the bio.

If this patch deadlocks, it is a sign that allocating large pages causes 
the problem.

If this patch doesn't deadlock, it is a sign that processing a bio with 
large pages is the problem.

Mikulas

---
 drivers/md/dm-crypt.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

Index: linux-stable/drivers/md/dm-crypt.c
===================================================================
--- linux-stable.orig/drivers/md/dm-crypt.c	2023-10-31 17:16:03.000000000 +0100
+++ linux-stable/drivers/md/dm-crypt.c	2023-10-31 17:21:14.000000000 +0100
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
 
@@ -1719,8 +1724,13 @@ retry:
 
 have_pages:
 		size_to_add = min((unsigned)PAGE_SIZE << order, remaining_size);
-		__bio_add_page(clone, pages, size_to_add, 0);
 		remaining_size -= size_to_add;
+		while (size_to_add) {
+			unsigned this_step = min(size_to_add, (unsigned)PAGE_SIZE);
+			__bio_add_page(clone, pages, this_step, 0);
+			size_to_add -= this_step;
+			pages++;
+		}
 	}
 
 	/* Allocate space for integrity tags */
@@ -1739,13 +1749,21 @@ have_pages:
 static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 {
 	struct folio_iter fi;
+	unsigned skip = 0;
 
 	if (clone->bi_vcnt > 0) { /* bio_for_each_folio_all crashes with an empty bio */
 		bio_for_each_folio_all(fi, clone) {
-			if (folio_test_large(fi.folio))
+			if (skip) {
+				skip--;
+				continue;
+			}
+			if (folio_test_large(fi.folio)) {
+				skip = (1 << folio_order(fi.folio)) - 1;
+				percpu_counter_sub(&cc->n_allocated_pages, 1 << folio_order(fi.folio));
 				folio_put(fi.folio);
-			else
+			} else {
 				mempool_free(&fi.folio->page, &cc->page_pool);
+			}
 		}
 	}
 }
--185210117-1983441990-1698773059=:87896--

