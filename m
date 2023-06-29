Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C882742C68
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjF2Ss2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjF2Ss1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABF2681
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA8E61575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B664AC433C0;
        Thu, 29 Jun 2023 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064504;
        bh=BwgWa4pe5c3TgDwaWenw+X9dmZ9oAdttw/SMw4P+HCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNgCxug4+JHbCSCeNdygXhgbmpTgn6u7X3TkQPFmnIy2gfE/9t2mJWevJVp+o/06w
         7L3e2RquhU+E/Pa6npHpsy8yicw4+VpOU/mNifTEUU6f9/RkGq7cuNvG6fP8Wc5zSE
         GZ5Q6VUstikl1ny6L5SOFLDlvqgyHsrTYNOPkem8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hugh Dickins <hughd@google.com>,
        stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Stevens <stevensd@chromium.org>,
        Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 24/28] mm/khugepaged: fix regression in collapse_file()
Date:   Thu, 29 Jun 2023 20:44:12 +0200
Message-ID: <20230629184152.832327871@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

commit e8c716bc6812202ccf4ce0f0bad3428b794fb39c upstream.

There is no xas_pause(&xas) in collapse_file()'s main loop, at the points
where it does xas_unlock_irq(&xas) and then continues.

That would explain why, once two weeks ago and twice yesterday, I have
hit the VM_BUG_ON_PAGE(page != xas_load(&xas), page) since "mm/khugepaged:
fix iteration in collapse_file" removed the xas_set(&xas, index) just
before it: xas.xa_node could be left pointing to a stale node, if there
was concurrent activity on the file which transformed its xarray.

I tried inserting xas_pause()s, but then even bootup crashed on that
VM_BUG_ON_PAGE(): there appears to be a subtle "nextness" implicit in
xas_pause().

xas_next() and xas_pause() are good for use in simple loops, but not in
this one: xas_set() worked well until now, so use xas_set(&xas, index)
explicitly at the head of the loop; and change that VM_BUG_ON_PAGE() not
to need its own xas_set(), and not to interfere with the xa_state (which
would probably stop the crashes from xas_pause(), but I trust that less).

The user-visible effects of this bug (if VM_BUG_ONs are configured out)
would be data loss and data leak - potentially - though in practice I
expect it is more likely that a subsequent check (e.g. on mapping or on
nr_none) would notice an inconsistency, and just abandon the collapse.

Link: https://lore.kernel.org/linux-mm/f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com/
Fixes: c8a8f3b4a95a ("mm/khugepaged: fix iteration in collapse_file")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Stevens <stevensd@chromium.org>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/khugepaged.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1918,9 +1918,9 @@ static int collapse_file(struct mm_struc
 		}
 	} while (1);
 
-	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
-		page = xas_next(&xas);
+		xas_set(&xas, index);
+		page = xas_load(&xas);
 
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
@@ -1935,7 +1935,6 @@ static int collapse_file(struct mm_struc
 						result = SCAN_TRUNCATED;
 						goto xa_locked;
 					}
-					xas_set(&xas, index + 1);
 				}
 				if (!shmem_charge(mapping->host, 1)) {
 					result = SCAN_FAIL;
@@ -2071,7 +2070,7 @@ static int collapse_file(struct mm_struc
 
 		xas_lock_irq(&xas);
 
-		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
+		VM_BUG_ON_PAGE(page != xa_load(xas.xa, index), page);
 
 		/*
 		 * We control three references to the page:


