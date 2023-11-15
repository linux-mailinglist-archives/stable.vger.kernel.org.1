Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D27ECF58
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjKOTr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjKOTr5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A5AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C280C433C7;
        Wed, 15 Nov 2023 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077673;
        bh=x8VuH09YhdHTWPlp+WRkqROha60hlm3dxzrCwxF79Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CC6q4JYQeEGi0gysXXo4sPGBSdIkD5YyIt4UTmFjW4EZVyjlk5eUs1tfu/mJTQvsW
         zNNsLTJcuUXGKrGLkK6Da1WP3wNe3Vci/pTViyHB2V/NmuW9xIaiap7OCz6/Vhkaba
         l14aqxS5xq7Aaz1QoGMp6lKKIpb5ordughZ0CoGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 425/603] f2fs: compress: fix deadloop in f2fs_write_cache_pages()
Date:   Wed, 15 Nov 2023 14:16:10 -0500
Message-ID: <20231115191642.236352289@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit c5d3f9b7649abb20aa5ab3ebff9421a171eaeb22 ]

With below mount option and testcase, it hangs kernel.

1. mount -t f2fs -o compress_log_size=5 /dev/vdb /mnt/f2fs
2. touch /mnt/f2fs/file
3. chattr +c /mnt/f2fs/file
4. dd if=/dev/zero of=/mnt/f2fs/file bs=1MB count=1
5. sync
6. dd if=/dev/zero of=/mnt/f2fs/file bs=111 count=11 conv=notrunc
7. sync

INFO: task sync:4788 blocked for more than 120 seconds.
      Not tainted 6.5.0-rc1+ #322
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:sync            state:D stack:0     pid:4788  ppid:509    flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x335/0xf80
 schedule+0x6f/0xf0
 wb_wait_for_completion+0x5e/0x90
 sync_inodes_sb+0xd8/0x2a0
 sync_inodes_one_sb+0x1d/0x30
 iterate_supers+0x99/0xf0
 ksys_sync+0x46/0xb0
 __do_sys_sync+0x12/0x20
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

The reason is f2fs_all_cluster_page_ready() assumes that pages array should
cover at least one cluster, otherwise, it will always return false, result
in deadloop.

By default, pages array size is 16, and it can cover the case cluster_size
is equal or less than 16, for the case cluster_size is larger than 16, let's
allocate memory of pages array dynamically.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 916e317ac925f..3f33e14dc7f81 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3023,7 +3023,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0, retry = 0;
-	struct page *pages[F2FS_ONSTACK_PAGES];
+	struct page *pages_local[F2FS_ONSTACK_PAGES];
+	struct page **pages = pages_local;
 	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
@@ -3047,6 +3048,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 #endif
 	int nr_folios, p, idx;
 	int nr_pages;
+	unsigned int max_pages = F2FS_ONSTACK_PAGES;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
@@ -3056,6 +3058,15 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int submitted = 0;
 	int i;
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (f2fs_compressed_file(inode) &&
+		1 << cc.log_cluster_size > F2FS_ONSTACK_PAGES) {
+		pages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
+				cc.log_cluster_size, GFP_NOFS | __GFP_NOFAIL);
+		max_pages = 1 << cc.log_cluster_size;
+	}
+#endif
+
 	folio_batch_init(&fbatch);
 
 	if (get_dirty_pages(mapping->host) <=
@@ -3101,7 +3112,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 add_more:
 			pages[nr_pages] = folio_page(folio, idx);
 			folio_get(folio);
-			if (++nr_pages == F2FS_ONSTACK_PAGES) {
+			if (++nr_pages == max_pages) {
 				index = folio->index + idx + 1;
 				folio_batch_release(&fbatch);
 				goto write;
@@ -3283,6 +3294,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (bio)
 		f2fs_submit_merged_ipu_write(sbi, &bio, NULL);
 
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (pages != pages_local)
+		kfree(pages);
+#endif
+
 	return ret;
 }
 
-- 
2.42.0



