Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC179AEF2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbjIKVH2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbjIKPAw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3C1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796D0C433C8;
        Mon, 11 Sep 2023 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444448;
        bh=yYGEkUXL7KtsWsqId35ex7MzLX9LmqfYDE7cRApuG/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBztEjfn9QbJaftFu+w4lDMWTCxg1qy33eo53dnU+7nBcU8y+AUIoQbhGdXSZCBmo
         a5qcEAhgAIHbxPmCrodANgOajyAdvrPmwSjjiZ0ip/wQpVViP7LnkagQn3w9/q+AbB
         yL0M1EswzXp/4mPqFRYNxoD5FDTRHloadKd56j28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 706/737] iov_iter: Fix iov_iter_extract_pages() with zero-sized entries
Date:   Mon, 11 Sep 2023 15:49:25 +0200
Message-ID: <20230911134710.240397840@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f741bd7178c95abd7aeac5a9d933ee542f9a5509 upstream.

iov_iter_extract_pages() doesn't correctly handle skipping over initial
zero-length entries in ITER_KVEC and ITER_BVEC-type iterators.

The problem is that it accidentally reduces maxsize to 0 when it
skipping and thus runs to the end of the array and returns 0.

Fix this by sticking the calculated size-to-copy in a new variable
rather than back in maxsize.

Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list from an iterator")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/iov_iter.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2086,14 +2086,14 @@ static ssize_t iov_iter_extract_bvec_pag
 					   size_t *offset0)
 {
 	struct page **p, *page;
-	size_t skip = i->iov_offset, offset;
+	size_t skip = i->iov_offset, offset, size;
 	int k;
 
 	for (;;) {
 		if (i->nr_segs == 0)
 			return 0;
-		maxsize = min(maxsize, i->bvec->bv_len - skip);
-		if (maxsize)
+		size = min(maxsize, i->bvec->bv_len - skip);
+		if (size)
 			break;
 		i->iov_offset = 0;
 		i->nr_segs--;
@@ -2106,16 +2106,16 @@ static ssize_t iov_iter_extract_bvec_pag
 	offset = skip % PAGE_SIZE;
 	*offset0 = offset;
 
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	maxpages = want_pages_array(pages, size, offset, maxpages);
 	if (!maxpages)
 		return -ENOMEM;
 	p = *pages;
 	for (k = 0; k < maxpages; k++)
 		p[k] = page + k;
 
-	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
-	iov_iter_advance(i, maxsize);
-	return maxsize;
+	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
+	iov_iter_advance(i, size);
+	return size;
 }
 
 /*
@@ -2130,14 +2130,14 @@ static ssize_t iov_iter_extract_kvec_pag
 {
 	struct page **p, *page;
 	const void *kaddr;
-	size_t skip = i->iov_offset, offset, len;
+	size_t skip = i->iov_offset, offset, len, size;
 	int k;
 
 	for (;;) {
 		if (i->nr_segs == 0)
 			return 0;
-		maxsize = min(maxsize, i->kvec->iov_len - skip);
-		if (maxsize)
+		size = min(maxsize, i->kvec->iov_len - skip);
+		if (size)
 			break;
 		i->iov_offset = 0;
 		i->nr_segs--;
@@ -2149,13 +2149,13 @@ static ssize_t iov_iter_extract_kvec_pag
 	offset = (unsigned long)kaddr & ~PAGE_MASK;
 	*offset0 = offset;
 
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	maxpages = want_pages_array(pages, size, offset, maxpages);
 	if (!maxpages)
 		return -ENOMEM;
 	p = *pages;
 
 	kaddr -= offset;
-	len = offset + maxsize;
+	len = offset + size;
 	for (k = 0; k < maxpages; k++) {
 		size_t seg = min_t(size_t, len, PAGE_SIZE);
 
@@ -2169,9 +2169,9 @@ static ssize_t iov_iter_extract_kvec_pag
 		kaddr += PAGE_SIZE;
 	}
 
-	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
-	iov_iter_advance(i, maxsize);
-	return maxsize;
+	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
+	iov_iter_advance(i, size);
+	return size;
 }
 
 /*


