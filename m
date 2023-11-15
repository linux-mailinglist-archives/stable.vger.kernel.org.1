Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B57ED101
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjKOT7C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjKOT66 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDE91B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B49CC433C7;
        Wed, 15 Nov 2023 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078333;
        bh=0qGc4ZGaI+ciaXcEUFaIC8CfexPzKUuBJcxqwPpHOJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaL0nAgNQiW/J+1UWI6HWRx7fcTSKHC8cvY5tHKoZtJNgoD/WmXJYmX6/5EsUakBn
         fWIxhqK6ffJJ0jv/ysje2SRQtzgx1AAXVgYhfxfQhOHu/GM80vLcaQoBNA+ZzCO/Uw
         DtxvJYHlQ9dRr3RtiN+rrGdgvv6q7ZFvOl2lqR/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 259/379] f2fs: convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed, 15 Nov 2023 14:25:34 -0500
Message-ID: <20231115192700.471391699@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

[ Upstream commit 1cd98ee747cff120ee9b93988ddb7315d8d8f8e7 ]

Convert the function to use a folio_batch instead of pagevec.  This is in
preparation for the removal of find_get_pages_range_tag().

Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
of pagevec.  This does NOT support large folios.  The function currently
only utilizes folios of size 1 so this shouldn't cause any issues right
now.

This version of the patch limits the number of pages fetched to
F2FS_ONSTACK_PAGES.  If that ever happens, update the start index here
since filemap_get_folios_tag() updates the index to be after the last
found folio, not necessarily the last used page.

Link: https://lkml.kernel.org/r/20230104211448.4804-15-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c5d3f9b7649a ("f2fs: compress: fix deadloop in f2fs_write_cache_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 84 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a982f91b71eb2..f4d3b3c6f6da7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2951,6 +2951,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0, retry = 0;
 	struct page *pages[F2FS_ONSTACK_PAGES];
+	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
 	sector_t last_block;
@@ -2971,6 +2972,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.private = NULL,
 	};
 #endif
+	int nr_folios, p, idx;
 	int nr_pages;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
@@ -2981,6 +2983,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int submitted = 0;
 	int i;
 
+	folio_batch_init(&fbatch);
+
 	if (get_dirty_pages(mapping->host) <=
 				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
 		set_inode_flag(mapping->host, FI_HOT_DATA);
@@ -3006,13 +3010,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !retry && (index <= end)) {
-		nr_pages = find_get_pages_range_tag(mapping, &index, end,
-				tag, F2FS_ONSTACK_PAGES, pages);
-		if (nr_pages == 0)
+		nr_pages = 0;
+again:
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0) {
+			if (nr_pages)
+				goto write;
 			break;
+		}
 
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			idx = 0;
+			p = folio_nr_pages(folio);
+add_more:
+			pages[nr_pages] = folio_page(folio, idx);
+			folio_get(folio);
+			if (++nr_pages == F2FS_ONSTACK_PAGES) {
+				index = folio->index + idx + 1;
+				folio_batch_release(&fbatch);
+				goto write;
+			}
+			if (++idx < p)
+				goto add_more;
+		}
+		folio_batch_release(&fbatch);
+		goto again;
+write:
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pages[i];
+			struct folio *folio = page_folio(page);
 			bool need_readd;
 readd:
 			need_readd = false;
@@ -3029,7 +3058,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (!f2fs_cluster_can_merge_page(&cc,
-								page->index)) {
+								folio->index)) {
 					ret = f2fs_write_multi_pages(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
@@ -3038,27 +3067,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (unlikely(f2fs_cp_error(sbi)))
-					goto lock_page;
+					goto lock_folio;
 
 				if (!f2fs_cluster_is_empty(&cc))
-					goto lock_page;
+					goto lock_folio;
 
 				if (f2fs_all_cluster_page_ready(&cc,
 					pages, i, nr_pages, true))
-					goto lock_page;
+					goto lock_folio;
 
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
-							page->index, &fsdata);
+							folio->index, &fsdata);
 				if (ret2 < 0) {
 					ret = ret2;
 					done = 1;
 					break;
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
-						fsdata, page->index, 1) ||
+						fsdata, folio->index, 1) ||
 					 !f2fs_all_cluster_page_ready(&cc,
-						pages, i, nr_pages, false))) {
+						pages, i, nr_pages,
+						false))) {
 					retry = 1;
 					break;
 				}
@@ -3071,46 +3101,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				break;
 			}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-lock_page:
+lock_folio:
 #endif
-			done_index = page->index;
+			done_index = folio->index;
 retry_write:
-			lock_page(page);
+			folio_lock(folio);
 
-			if (unlikely(page->mapping != mapping)) {
+			if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (PageWriteback(page)) {
+			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					f2fs_wait_on_page_writeback(page,
+					f2fs_wait_on_page_writeback(
+							&folio->page,
 							DATA, true, true);
 				else
 					goto continue_unlock;
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
-				get_page(page);
-				f2fs_compress_ctx_add_page(&cc, page);
+				folio_get(folio);
+				f2fs_compress_ctx_add_page(&cc, &folio->page);
 				continue;
 			}
 #endif
-			ret = f2fs_write_single_data_page(page, &submitted,
-					&bio, &last_block, wbc, io_type,
-					0, true);
+			ret = f2fs_write_single_data_page(&folio->page,
+					&submitted, &bio, &last_block,
+					wbc, io_type, 0, true);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
-				unlock_page(page);
+				folio_unlock(folio);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 result:
 #endif
@@ -3134,7 +3165,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					}
 					goto next;
 				}
-				done_index = page->index + 1;
+				done_index = folio->index +
+					folio_nr_pages(folio);
 				done = 1;
 				break;
 			}
-- 
2.42.0



