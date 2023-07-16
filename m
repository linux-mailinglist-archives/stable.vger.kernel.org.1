Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCD75566C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjGPUu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjGPUu1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A2E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25CB360EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E13C433C7;
        Sun, 16 Jul 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540624;
        bh=lLXcF4hRbzFMzyPYAWRYx6IlvZ5bXZ4CReogufbvYi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBkxUlPDEZ7W74Q8mNVHTkWSOx4nWlJ6CD3KHHg/G7Kbof8SBJKPqEyvkHrZFL/Ir
         yVUMMmtd1MmF3OVycVW4QKEb1kI22dS/SDXq1IZgF9rDxHrQTWPMvcVV4KSzNREu4+
         QDkvCfvy7q1qkW37HLARc2zI8uVAeIPKIPuFEDVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 429/591] f2fs: fix potential deadlock due to unpaired node_write lock use
Date:   Sun, 16 Jul 2023 21:49:28 +0200
Message-ID: <20230716194935.015494345@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit f082c6b205a06953f26c40bdc7621cc5a58ceb7c ]

If S_NOQUOTA is cleared from inode during data page writeback of quota
file, it may miss to unlock node_write lock, result in potential
deadlock, fix to use the lock in paired.

Kworker					Thread
- writepage
 if (IS_NOQUOTA())
   f2fs_down_read(&sbi->node_write);
					- vfs_cleanup_quota_inode
					 - inode->i_flags &= ~S_NOQUOTA;
 if (IS_NOQUOTA())
   f2fs_up_read(&sbi->node_write);

Fixes: 79963d967b49 ("f2fs: shrink node_write lock coverage")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 7 ++++---
 fs/f2fs/data.c     | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b160863eca141..e50d5848c1001 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1235,6 +1235,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	unsigned int last_index = cc->cluster_size - 1;
 	loff_t psize;
 	int i, err;
+	bool quota_inode = IS_NOQUOTA(inode);
 
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -1242,7 +1243,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		goto out_free;
 	}
 
-	if (IS_NOQUOTA(inode)) {
+	if (quota_inode) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
 		 * checkpoint. This can only happen to quota writes which can cause
@@ -1364,7 +1365,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (IS_NOQUOTA(inode))
+	if (quota_inode)
 		f2fs_up_read(&sbi->node_write);
 	else
 		f2fs_unlock_op(sbi);
@@ -1390,7 +1391,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (IS_NOQUOTA(inode))
+	if (quota_inode)
 		f2fs_up_read(&sbi->node_write);
 	else
 		f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 36db9aab47790..c230824ab5e6e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2759,6 +2759,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	loff_t psize = (loff_t)(page->index + 1) << PAGE_SHIFT;
 	unsigned offset = 0;
 	bool need_balance_fs = false;
+	bool quota_inode = IS_NOQUOTA(inode);
 	int err = 0;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
@@ -2816,19 +2817,19 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		goto out;
 
 	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+	if (S_ISDIR(inode->i_mode) || quota_inode) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
 		 * checkpoint. This can only happen to quota writes which can cause
 		 * the below discard race condition.
 		 */
-		if (IS_NOQUOTA(inode))
+		if (quota_inode)
 			f2fs_down_read(&sbi->node_write);
 
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 
-		if (IS_NOQUOTA(inode))
+		if (quota_inode)
 			f2fs_up_read(&sbi->node_write);
 
 		goto done;
-- 
2.39.2



