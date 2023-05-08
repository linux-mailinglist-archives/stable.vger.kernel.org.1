Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C496FA7E1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjEHKfj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjEHKfO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0924AAC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253F862755
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C945C433D2;
        Mon,  8 May 2023 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542085;
        bh=tsRhihcj4Wf/LnLOmcaXku9KmggLh9pxkfuyDHP9qZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7i0f8OcMAXYyIyElN1RRRPUG5GL4uy9fIQK6HefyN3a6Jcah/OwE8HPzXjKw61Dz
         kiDJpi0O3d6gGLLiApSiw68gdOKqq9fnFhX6Nvp8v/p38zaONyIe56hFM6OdHxbLwV
         ad8D3VtAACiPS5G34VMdhTqLHx37sVhiHR4Zehuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 322/663] f2fs: fix scheduling while atomic in decompression path
Date:   Mon,  8 May 2023 11:42:28 +0200
Message-Id: <20230508094438.639469505@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 1aa161e43106d46ca8e9a86f4aa28d420258134b ]

[   16.945668][    C0] Call trace:
[   16.945678][    C0]  dump_backtrace+0x110/0x204
[   16.945706][    C0]  dump_stack_lvl+0x84/0xbc
[   16.945735][    C0]  __schedule_bug+0xb8/0x1ac
[   16.945756][    C0]  __schedule+0x724/0xbdc
[   16.945778][    C0]  schedule+0x154/0x258
[   16.945793][    C0]  bit_wait_io+0x48/0xa4
[   16.945808][    C0]  out_of_line_wait_on_bit+0x114/0x198
[   16.945824][    C0]  __sync_dirty_buffer+0x1f8/0x2e8
[   16.945853][    C0]  __f2fs_commit_super+0x140/0x1f4
[   16.945881][    C0]  f2fs_commit_super+0x110/0x28c
[   16.945898][    C0]  f2fs_handle_error+0x1f4/0x2f4
[   16.945917][    C0]  f2fs_decompress_cluster+0xc4/0x450
[   16.945942][    C0]  f2fs_end_read_compressed_page+0xc0/0xfc
[   16.945959][    C0]  f2fs_handle_step_decompress+0x118/0x1cc
[   16.945978][    C0]  f2fs_read_end_io+0x168/0x2b0
[   16.945993][    C0]  bio_endio+0x25c/0x2c8
[   16.946015][    C0]  dm_io_dec_pending+0x3e8/0x57c
[   16.946052][    C0]  clone_endio+0x134/0x254
[   16.946069][    C0]  bio_endio+0x25c/0x2c8
[   16.946084][    C0]  blk_update_request+0x1d4/0x478
[   16.946103][    C0]  scsi_end_request+0x38/0x4cc
[   16.946129][    C0]  scsi_io_completion+0x94/0x184
[   16.946147][    C0]  scsi_finish_command+0xe8/0x154
[   16.946164][    C0]  scsi_complete+0x90/0x1d8
[   16.946181][    C0]  blk_done_softirq+0xa4/0x11c
[   16.946198][    C0]  _stext+0x184/0x614
[   16.946214][    C0]  __irq_exit_rcu+0x78/0x144
[   16.946234][    C0]  handle_domain_irq+0xd4/0x154
[   16.946260][    C0]  gic_handle_irq.33881+0x5c/0x27c
[   16.946281][    C0]  call_on_irq_stack+0x40/0x70
[   16.946298][    C0]  do_interrupt_handler+0x48/0xa4
[   16.946313][    C0]  el1_interrupt+0x38/0x68
[   16.946346][    C0]  el1h_64_irq_handler+0x20/0x30
[   16.946362][    C0]  el1h_64_irq+0x78/0x7c
[   16.946377][    C0]  finish_task_switch+0xc8/0x3d8
[   16.946394][    C0]  __schedule+0x600/0xbdc
[   16.946408][    C0]  preempt_schedule_common+0x34/0x5c
[   16.946423][    C0]  preempt_schedule+0x44/0x48
[   16.946438][    C0]  process_one_work+0x30c/0x550
[   16.946456][    C0]  worker_thread+0x414/0x8bc
[   16.946472][    C0]  kthread+0x16c/0x1e0
[   16.946486][    C0]  ret_from_fork+0x10/0x20

Fixes: bff139b49d9f ("f2fs: handle decompress only post processing in softirq")
Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 7 ++++++-
 fs/f2fs/f2fs.h     | 1 +
 fs/f2fs/super.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2628c347f44fd..07c96fea76fe1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -759,7 +759,12 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 
 	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
 		ret = -EFSCORRUPTED;
-		f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
+
+		/* Avoid f2fs_commit_super in irq context */
+		if (in_task)
+			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
+		else
+			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
 		goto out_release;
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81ab..42962ee0a1179 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3576,6 +3576,7 @@ int f2fs_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
+void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 551468dad3275..3711445a2489b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3895,7 +3895,7 @@ void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
 	f2fs_up_write(&sbi->sb_lock);
 }
 
-static void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
+void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
 {
 	spin_lock(&sbi->error_lock);
 	if (!test_bit(flag, (unsigned long *)sbi->errors)) {
-- 
2.39.2



