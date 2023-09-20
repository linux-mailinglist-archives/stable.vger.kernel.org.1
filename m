Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041577A7B56
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjITLvS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjITLvP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22ABE4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4576C433CA;
        Wed, 20 Sep 2023 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210668;
        bh=Q1yYSFJYyeH5i0ev/h0GfUo7WUeFEFhNnucgseW89rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEPz2yJ2/37tzYkGcRdS/42ztm6QVyF0JcGdS4MaG78WG33cNmjWAiJjnIFZrh6gR
         gkg+f7X9AmD8sJfJma1AjNyNyEqCqtKgSzdFoxH2uXOb/Y5UPjJBNvWyE4y+5DDkgg
         Z3DwBPlQIevd8qQlwheFymM56VsW/FHyt9hL6mFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 134/211] btrfs: introduce struct to consolidate extent buffer write context
Date:   Wed, 20 Sep 2023 13:29:38 +0200
Message-ID: <20230920112849.982067599@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

[ Upstream commit 861093eff4f01319edfc1d1ee276a7f2bf720f1d ]

Introduce btrfs_eb_write_context to consolidate writeback_control and the
exntent buffer context.  This will help adding a block group context as
well.

While at it, move the eb context setting before
btrfs_check_meta_write_pointer(). We can set it here because we anyway need
to skip pages in the same eb if that eb is rejected by
btrfs_check_meta_write_pointer().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 fs/btrfs/extent_io.h |  5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 90ad3006ef3a7..b3bf2e2704888 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1877,9 +1877,9 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct writeback_control *wbc,
-			  struct extent_buffer **eb_context)
+static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 {
+	struct writeback_control *wbc = ctx->wbc;
 	struct address_space *mapping = page->mapping;
 	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
@@ -1908,7 +1908,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	if (eb == *eb_context) {
+	if (eb == ctx->eb) {
 		spin_unlock(&mapping->private_lock);
 		return 0;
 	}
@@ -1917,6 +1917,8 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
+	ctx->eb = eb;
+
 	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
 		/*
 		 * If for_sync, this hole will be filled with
@@ -1930,8 +1932,6 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return ret;
 	}
 
-	*eb_context = eb;
-
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
@@ -1954,7 +1954,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_buffer *eb_context = NULL;
+	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -1996,7 +1996,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, wbc, &eb_context);
+			ret = submit_eb_page(&folio->page, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c5fae3a7d911b..ecc1660007c11 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,6 +94,11 @@ struct extent_buffer {
 #endif
 };
 
+struct btrfs_eb_write_context {
+	struct writeback_control *wbc;
+	struct extent_buffer *eb;
+};
+
 /*
  * Get the correct offset inside the page of extent buffer.
  *
-- 
2.40.1



