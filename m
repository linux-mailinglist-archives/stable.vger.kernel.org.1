Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FEB7039B7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbjEORp1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbjEORpD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB313C2E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A2C62E7F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B35C433D2;
        Mon, 15 May 2023 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172562;
        bh=Tg+tl9AP14ckMuqAgef54ar+JhIYxUs7Pg3x8AV+pis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRvXfE3QUwtJzTWO0WJjm73fQyqwmzKS9151Yy8eZuAEzFbLf286HyawU3O7P00Om
         WI8dVYgmFhojOu/gfXn/IwPMdt6D8ZV9PqehObaRUorPMYkBbIJFg+XOn855qXYT8q
         SbYhZ4RY5zNUBzL4J6n831F08LSoqliQK0klh+U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 165/381] f2fs: fix to avoid use-after-free for cached IPU bio
Date:   Mon, 15 May 2023 18:26:56 +0200
Message-Id: <20230515161744.258928136@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5cdb422c839134273866208dad5360835ddb9794 ]

xfstest generic/019 reports a bug:

kernel BUG at mm/filemap.c:1619!
RIP: 0010:folio_end_writeback+0x8a/0x90
Call Trace:
 end_page_writeback+0x1c/0x60
 f2fs_write_end_io+0x199/0x420
 bio_endio+0x104/0x180
 submit_bio_noacct+0xa5/0x510
 submit_bio+0x48/0x80
 f2fs_submit_write_bio+0x35/0x300
 f2fs_submit_merged_ipu_write+0x2a0/0x2b0
 f2fs_write_single_data_page+0x838/0x8b0
 f2fs_write_cache_pages+0x379/0xa30
 f2fs_write_data_pages+0x30c/0x340
 do_writepages+0xd8/0x1b0
 __writeback_single_inode+0x44/0x370
 writeback_sb_inodes+0x233/0x4d0
 __writeback_inodes_wb+0x56/0xf0
 wb_writeback+0x1dd/0x2d0
 wb_workfn+0x367/0x4a0
 process_one_work+0x21d/0x430
 worker_thread+0x4e/0x3c0
 kthread+0x103/0x130
 ret_from_fork+0x2c/0x50

The root cause is: after cp_error is set, f2fs_submit_merged_ipu_write()
in f2fs_write_single_data_page() tries to flush IPU bio in cache, however
f2fs_submit_merged_ipu_write() missed to check validity of @bio parameter,
result in submitting random cached bio which belong to other IO context,
then it will cause use-after-free issue, fix it by adding additional
validity check.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index db26e87b8f0dd..e9481c940895c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -849,6 +849,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 	bool found = false;
 	struct bio *target = bio ? *bio : NULL;
 
+	f2fs_bug_on(sbi, !target && !page);
+
 	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
 		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 		struct list_head *head = &io->bio_list;
@@ -2917,7 +2919,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_merged_ipu_write(sbi, bio, NULL);
+		if (bio && *bio)
+			f2fs_submit_merged_ipu_write(sbi, bio, NULL);
 		submitted = NULL;
 	}
 
-- 
2.39.2



