Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19E6755155
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGPTzR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGPTzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248AE4F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FB5760EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87AC433C7;
        Sun, 16 Jul 2023 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537314;
        bh=dSJV2Pt02hqcoAgLSATVio9w1Ze7tmF/AomDT8ytcm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZWQkHgdtuJeXXj1UJrpd91V4QNTZseLg9LniBP3aGNIR5CAhV9jCAeU85zJpu9my
         mGTljCZgaEgPFycgaQ5ozQ9MUV7i0ju6RYgiosLMibmjfF/rP4NuekuVK76u2SVKld
         ZdWwayklaBGBTX1Z2EQAGgnuIOmmYYrmllhelzuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 051/800] btrfs: always read the entire extent_buffer
Date:   Sun, 16 Jul 2023 21:38:24 +0200
Message-ID: <20230716194950.276988598@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e95382834cf885b478dbe14a66451b863eb35c94 ]

Currently read_extent_buffer_pages skips pages that are already uptodate
when reading in an extent_buffer.  While this reduces the amount of data
read, it increases the number of I/O operations as we now need to do
multiple I/Os when reading an extent buffer with one or more uptodate
pages in the middle of it.  On any modern storage device, be that hard
drives or SSDs this actually decreases I/O performance.  Fortunately
this case is pretty rare as the pages are always initially read together
and then aged the same way.  Besides simplifying the code a bit as-is
this will allow for major simplifications to the I/O completion handler
later on.

Note that the case where all pages are uptodate is still handled by an
optimized fast path that does not read any data from disk.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 7027f87108ce ("btrfs: don't treat zoned writeback as being from an async helper thread")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25dd..d1a635f237688 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4314,7 +4314,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
-	unsigned long num_reads = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_READ,
 		.mirror_num = mirror_num,
@@ -4360,10 +4359,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	 */
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-		if (!PageUptodate(page)) {
-			num_reads++;
+		if (!PageUptodate(page))
 			all_uptodate = 0;
-		}
 	}
 
 	if (all_uptodate) {
@@ -4373,7 +4370,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_reads);
+	atomic_set(&eb->io_pages, num_pages);
 	/*
 	 * It is possible for release_folio to clear the TREE_REF bit before we
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
@@ -4383,13 +4380,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 
-		if (!PageUptodate(page)) {
-			ClearPageError(page);
-			submit_extent_page(&bio_ctrl, page_offset(page), page,
-					   PAGE_SIZE, 0);
-		} else {
-			unlock_page(page);
-		}
+		ClearPageError(page);
+		submit_extent_page(&bio_ctrl, page_offset(page), page,
+				   PAGE_SIZE, 0);
 	}
 
 	submit_one_bio(&bio_ctrl);
-- 
2.39.2



