Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF773E7AE
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjFZSRl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjFZSRf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95ACCC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76F3860F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD1CC433C8;
        Mon, 26 Jun 2023 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803453;
        bh=1JqGeV6kElRZlVCIvRRf3ZwOaPV09NFY6jhEEsmBf9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Juh5d5GuDiio4wRYwNC1Q1XY9h7spTL0p0QfOsgN2VYBTzOJp8mXpHBfN3nLLlJhS
         el/kSXV44cdu7je1DGpM2SVIWT/dCSRikBEvOlTo3nJq0FutEXKW+2ufgJ8VAxiQ+0
         6YMXudkzOmo0TQUIchP9NEfTM6V2WbRvOE5t6kMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 059/199] mm/vmalloc: do not output a spurious warning when huge vmalloc() fails
Date:   Mon, 26 Jun 2023 20:09:25 +0200
Message-ID: <20230626180808.156895582@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit 95a301eefa82057571207edd06ea36218985a75e upstream.

In __vmalloc_area_node() we always warn_alloc() when an allocation
performed by vm_area_alloc_pages() fails unless it was due to a pending
fatal signal.

However, huge page allocations instigated either by vmalloc_huge() or
__vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
kvmalloc_node()) always falls back to order-0 allocations if the huge page
allocation fails.

This renders the warning useless and noisy, especially as all callers
appear to be aware that this may fallback.  This has already resulted in
at least one bug report from a user who was confused by this (see link).

Therefore, simply update the code to only output this warning for order-0
pages when no fatal signal is pending.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
Link: https://lkml.kernel.org/r/20230605201107.83298-1-lstoakes@gmail.com
Fixes: 80b1d8fdfad1 ("mm: vmalloc: correct use of __GFP_NOWARN mask in __vmalloc_area_node()")
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3046,11 +3046,20 @@ static void *__vmalloc_area_node(struct
 	 * allocation request, free them via vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		/* vm_area_alloc_pages() can also fail due to a fatal signal */
-		if (!fatal_signal_pending(current))
+		/*
+		 * vm_area_alloc_pages() can fail due to insufficient memory but
+		 * also:-
+		 *
+		 * - a pending fatal signal
+		 * - insufficient huge page-order pages
+		 *
+		 * Since we always retry allocations at order-0 in the huge page
+		 * case a warning for either is spurious.
+		 */
+		if (!fatal_signal_pending(current) && page_order == 0)
 			warn_alloc(gfp_mask, NULL,
-				"vmalloc error: size %lu, page order %u, failed to allocate pages",
-				area->nr_pages * PAGE_SIZE, page_order);
+				"vmalloc error: size %lu, failed to allocate pages",
+				area->nr_pages * PAGE_SIZE);
 		goto fail;
 	}
 


