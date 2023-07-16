Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A7754E3C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjGPKPc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPKPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33489E47
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C427760C7D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD67CC433C8;
        Sun, 16 Jul 2023 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502528;
        bh=SNUZRkdXi7kpOmcZMuT5+Et5fo4o4p1DKluKdq4PUOs=;
        h=Subject:To:Cc:From:Date:From;
        b=k9zaxFSXQ9XLqURcyhK7+wruLYOHzOc1NVX6l2Q9+wqydjiXHz41Ck9p2vJlNr3J2
         DeQRvVpfOQhjd8NmIAZaLkwr3FE29SLTHF07GUkr7AilsT6Z1lDiWm8Er7EVgynmMT
         eSHL1eFpC+A2ei5qkdDE78PSHCtqdDnIfE508rBU=
Subject: FAILED: patch "[PATCH] btrfs: fix dirty_metadata_bytes for redirtied buffers" failed to apply to 5.15-stable tree
To:     hch@lst.de, dsterba@suse.com, naohiro.aota@wdc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:15:17 +0200
Message-ID: <2023071617-same-snowbird-770b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f18cc97845aa4ae0e795c088c979fe1642b3b8e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071617-same-snowbird-770b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f18cc97845aa ("btrfs: fix dirty_metadata_bytes for redirtied buffers")
98c8d683c291 ("btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty")
190a83391bc4 ("btrfs: rename btrfs_clean_tree_block to btrfs_clear_buffer_dirty")
c4e54a657116 ("btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block")
ed25dab3a0d1 ("btrfs: add trans argument to btrfs_clean_tree_block")
d3fb66150c05 ("btrfs: always lock the block before calling btrfs_clean_tree_block")
7f0add250f82 ("btrfs: move super_block specific helpers into super.h")
c03b22076bd2 ("btrfs: move super prototypes into super.h")
5c11adcc383a ("btrfs: move verity prototypes into verity.h")
77407dc032e2 ("btrfs: move dev-replace prototypes into dev-replace.h")
2fc6822c99d7 ("btrfs: move scrub prototypes into scrub.h")
677074792a1d ("btrfs: move relocation prototypes into relocation.h")
33cf97a7b658 ("btrfs: move acl prototypes into acl.h")
b538a271ae9b ("btrfs: move the 32bit warn defines into messages.h")
af142b6f44d3 ("btrfs: move file prototypes to file.h")
7572dec8f522 ("btrfs: move ioctl prototypes into ioctl.h")
c7a03b524d30 ("btrfs: move uuid tree prototypes to uuid-tree.h")
7c8ede162805 ("btrfs: move file-item prototypes into their own header")
f2b39277b87d ("btrfs: move dir-item prototypes into dir-item.h")
59b818e064ab ("btrfs: move defrag related prototypes to their own header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f18cc97845aa4ae0e795c088c979fe1642b3b8e5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 8 May 2023 07:58:38 -0700
Subject: [PATCH] btrfs: fix dirty_metadata_bytes for redirtied buffers

dirty_metadata_bytes is decremented in both places that clear the dirty
bit in a buffer, but only incremented in btrfs_mark_buffer_dirty, which
means that a buffer that is redirtied using btrfs_redirty_list_add won't
be added to dirty_metadata_bytes, but it will be subtracted when written
out, leading an inconsistency in the counter.

Move the dirty_metadata_bytes from btrfs_mark_buffer_dirty into
set_extent_buffer_dirty to also account for the redirty case, and remove
the now unused set_extent_buffer_dirty return value.

Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 83518ed71bfd..112c99dde57f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4621,7 +4621,6 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
-	int was_dirty;
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	/*
@@ -4636,11 +4635,7 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (transid != fs_info->generation)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
 			buf->start, transid, fs_info->generation);
-	was_dirty = set_extent_buffer_dirty(buf);
-	if (!was_dirty)
-		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-					 buf->len,
-					 fs_info->dirty_metadata_batch);
+	set_extent_buffer_dirty(buf);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	/*
 	 * btrfs_check_leaf() won't check item data if we don't have WRITTEN
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25d..a829390632a5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4148,7 +4148,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
 
-bool set_extent_buffer_dirty(struct extent_buffer *eb)
+void set_extent_buffer_dirty(struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
@@ -4183,13 +4183,14 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 					     eb->start, eb->len);
 		if (subpage)
 			unlock_page(eb->pages[0]);
+		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
+					 eb->len,
+					 eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
 		ASSERT(PageDirty(eb->pages[i]));
 #endif
-
-	return was_dirty;
 }
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4341ad978fb8..f937654230d3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -262,7 +262,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
 				unsigned long len);
-bool set_extent_buffer_dirty(struct extent_buffer *eb);
+void set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 int extent_buffer_under_io(const struct extent_buffer *eb);

