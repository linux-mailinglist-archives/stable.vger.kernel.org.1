Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326FF7D9EEB
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ0Rdr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjJ0Rdq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 13:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FCAB
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698427978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFCOmqCYSKmzzXjFht9+x7s+AJE8sjtnXGepXVqi1hs=;
        b=WxSJLhAEn58dsPMq/8a+EM1BjBwwZHgFe4GK/HVkOV9xzVjp6pvfUiEPIH8Tz+c/Ztnlmh
        UluNeFUxHupwPNA33Z611JpolOpqRzqCl6o1rFRuXYgQYrPFaDe0VzoCZ+XKXYTCyCMLZV
        6Z35d0MjhsNAy6V6OjReNYSSwTJVak4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-pYVAydJXO6S_qPgr9wWeVg-1; Fri,
 27 Oct 2023 13:32:55 -0400
X-MC-Unique: pYVAydJXO6S_qPgr9wWeVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6940D3816B40;
        Fri, 27 Oct 2023 17:32:54 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 490385027;
        Fri, 27 Oct 2023 17:32:54 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 338D030C72A4; Fri, 27 Oct 2023 17:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 293C93FD16;
        Fri, 27 Oct 2023 19:32:54 +0200 (CEST)
Date:   Fri, 27 Oct 2023 19:32:54 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>,
        =?ISO-8859-15?Q?Marek_Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        Alasdair Kergon <agk@redhat.com>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
In-Reply-To: <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
Message-ID: <34f6678e-6460-f77-73f4-fc8d3652a8e5@redhat.com>
References: <ZTNH0qtmint/zLJZ@mail-itl> <e427823c-e869-86a2-3549-61b3fdf29537@redhat.com> <ZTiHQDY54E7WAld+@mail-itl> <ZTiJ3CO8w0jauOzW@mail-itl> <a413efbf-7194-95ff-562b-f2eb766ca5c1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-1463778712-1698427974=:495964"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1463778712-1698427974=:495964
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

So, we got no reponse from the MM maintainers. Marek - please try this 
patch on all the machines where you hit the bug and if you still hit the 
bug with this patch, report it.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] dm-crypt: don't allocate large compound pages

It was reported that the patch 5054e778fcd9cd29ddaa8109077cd235527e4f94
("dm crypt: allocate compound pages if possible") causes intermittent
freezes [1].

So far, it is not clear what is the root cause. It was reported that with
the allocation order 3 or lower it works [1], so we restrict the order to
3 (that is PAGE_ALLOC_COSTLY_ORDER).

[1] https://www.spinics.net/lists/dm-devel/msg56048.html

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Marek Marczykowski-G�recki <marmarek@invisiblethingslab.com>
Tested-by: Marek Marczykowski-G�recki <marmarek@invisiblethingslab.com>
Cc: stable@vger.kernel.org	# v6.5+
Fixes: 5054e778fcd9 ("dm crypt: allocate compound pages if possible")

---
 drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-crypt.c
+++ linux-2.6/drivers/md/dm-crypt.c
@@ -1679,7 +1679,7 @@ static struct bio *crypt_alloc_buffer(st
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
 	unsigned int remaining_size;
-	unsigned int order = MAX_ORDER - 1;
+	unsigned int order = PAGE_ALLOC_COSTLY_ORDER;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))

--185210117-1463778712-1698427974=:495964--

