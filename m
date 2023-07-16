Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D67553AD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGPUVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjGPUVn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D61B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE5660EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBDAC433C8;
        Sun, 16 Jul 2023 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538901;
        bh=lJyTzmpmLEKb6OuldQt4ezrELGjxmj0Qpl9HeM63lWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8l/QrAfk1aORKupmGWTwHwmYZIjfFtf05C560oM1k/CNhPKupAy44RAI5uc3xhCS
         efjC5ttLrHr239HWbZeuJsadKR+MxJoeahpZ2TpEIPm99Eq3OvphQmZXVt+x25vvYM
         Xgdx49y548chzocaTf97UTaZ1hA60AW5P5/sie9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 616/800] f2fs: flush error flags in workqueue
Date:   Sun, 16 Jul 2023 21:47:49 +0200
Message-ID: <20230716195003.419322357@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit 901c12d144570ed2558f4a6806201453c5b01bea ]

In IRQ context, it wakes up workqueue to record errors into on-disk
superblock fields rather than in-memory fields.

Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
Fixes: 95fa90c9e5a7 ("f2fs: support recording errors into superblock")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/super.c    | 26 +++++++++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 905b7c39a2b32..1132d3cd8f337 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -744,7 +744,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 
 		/* Avoid f2fs_commit_super in irq context */
 		if (!in_task)
-			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
+			f2fs_handle_error_async(sbi, ERROR_FAIL_DECOMPRESSION);
 		else
 			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
 		goto out_release;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35a025d7e305b..d867056a01f65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3558,6 +3558,7 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 							bool irq_context);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
+void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f4595813..17082dc3c1a34 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3980,6 +3980,11 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 	f2fs_down_write(&sbi->sb_lock);
 
 	spin_lock_irqsave(&sbi->error_lock, flags);
+	if (sbi->error_dirty) {
+		memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
+							MAX_F2FS_ERRORS);
+		sbi->error_dirty = false;
+	}
 	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 
@@ -4019,12 +4024,10 @@ static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
 	return need_update;
 }
 
-void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
+static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 {
 	int err;
 
-	f2fs_save_errors(sbi, error);
-
 	f2fs_down_write(&sbi->sb_lock);
 
 	if (!f2fs_update_errors(sbi))
@@ -4038,6 +4041,23 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
 	f2fs_up_write(&sbi->sb_lock);
 }
 
+void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
+{
+	f2fs_save_errors(sbi, error);
+	f2fs_record_errors(sbi, error);
+}
+
+void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error)
+{
+	f2fs_save_errors(sbi, error);
+
+	if (!sbi->error_dirty)
+		return;
+	if (!test_bit(error, (unsigned long *)sbi->errors))
+		return;
+	schedule_work(&sbi->s_error_work);
+}
+
 static bool system_going_down(void)
 {
 	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
-- 
2.39.2



