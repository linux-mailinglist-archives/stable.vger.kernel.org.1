Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE84377587C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjHIKxN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjHIKvw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55092735
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BE763138
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE29EC433C8;
        Wed,  9 Aug 2023 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578254;
        bh=vy0OOD+YSoZmSiOgeeQwh8tKBFm1C0IeJLb3ivRcqOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQqJMSGIUi+tElF5KVE5ucV3IJ4gf23sR6sz8CM4XowqF+tDmSjJ5cuDBKW631OoC
         AeCcuv+xEiV/8fLj08PeuDapJNEz5zCvNIPVoTFZaZ4x/0/QwrD6DMQE81nxa59ou6
         q7tjqQ4kmTLfIR2jZ8bBRMtPCdRB2+u/hfmDfNic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 131/165] Revert "page cache: fix page_cache_next/prev_miss off by one"
Date:   Wed,  9 Aug 2023 12:41:02 +0200
Message-ID: <20230809103647.102352796@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 16f8eb3eea9eb2a1568279d64ca4dc977e7aa538 upstream.

This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9

The reverted commit fixed up routines primarily used by readahead code
such that they could also be used by hugetlb.  Unfortunately, this
caused a performance regression as pointed out by the Closes: tag.

The hugetlb code which uses page_cache_next_miss will be addressed in
a subsequent patch.

Link: https://lkml.kernel.org/r/20230621212403.174710-1-mike.kravetz@oracle.com
Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1760,9 +1760,7 @@ bool __folio_lock_or_retry(struct folio
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'return - index >= max_scan' will be true).
- * In the rare case of index wrap-around, 0 will be returned.  0 will also
- * be returned if index == 0 and there is a gap at the index.  We can not
- * wrap-around if passed index == 0.
+ * In the rare case of index wrap-around, 0 will be returned.
  */
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1772,13 +1770,12 @@ pgoff_t page_cache_next_miss(struct addr
 	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == 0 && index != 0)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == 0)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index + 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
@@ -1799,9 +1796,7 @@ EXPORT_SYMBOL(page_cache_next_miss);
  *
  * Return: The index of the gap if found, otherwise an index outside the
  * range specified (in which case 'index - return >= max_scan' will be true).
- * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_MAX
- * will also be returned if index == ULONG_MAX and there is a gap at the
- * index.  We can not wrap-around if passed index == ULONG_MAX.
+ * In the rare case of wrap-around, ULONG_MAX will be returned.
  */
 pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
@@ -1811,13 +1806,12 @@ pgoff_t page_cache_prev_miss(struct addr
 	while (max_scan--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			return xas.xa_index;
-		if (xas.xa_index == ULONG_MAX && index != ULONG_MAX)
-			return xas.xa_index;
+			break;
+		if (xas.xa_index == ULONG_MAX)
+			break;
 	}
 
-	/* No gaps in range and no wrap-around, return index beyond range */
-	return xas.xa_index - 1;
+	return xas.xa_index;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 


