Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA936703813
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbjEOR1J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbjEOR0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6952212E91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CB862CA9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C070C433D2;
        Mon, 15 May 2023 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171538;
        bh=WChcO2BEzLe/4FNxulPQ+wAtj0Ph2Ry9S5Mq1MViCzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlIq2zbnZkyyd8uFn4a9vb8ZzXC2cWU9Tp9Oej1uz3rqnk0auyEg8JSyrNkXCb+HK
         wBKxe1c8SgIpL1orLOypkQPEAyIHSrW6RcO7txZKwAc7Cbe9uCLga1e3WuTBAx6Wl2
         iZwNc7YbtBp1By6oNJHtXaQz1ce30cBFi6uuBKyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.2 234/242] ext4: fix lockdep warning when enabling MMP
Date:   Mon, 15 May 2023 18:29:20 +0200
Message-Id: <20230515161728.929959919@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 949f95ff39bf188e594e7ecd8e29b82eb108f5bf upstream.

When we enable MMP in ext4_multi_mount_protect() during mount or
remount, we end up calling sb_start_write() from write_mmp_block(). This
triggers lockdep warning because freeze protection ranks above s_umount
semaphore we are holding during mount / remount. The problem is harmless
because we are guaranteed the filesystem is not frozen during mount /
remount but still let's fix the warning by not grabbing freeze
protection from ext4_multi_mount_protect().

Cc: stable@kernel.org
Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=ab7e5b6f400b7778d46f01841422e5718fb81843
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20230411121019.21940-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mmp.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -39,28 +39,36 @@ static void ext4_mmp_csum_set(struct sup
  * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
-static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+static int write_mmp_block_thawed(struct super_block *sb,
+				  struct buffer_head *bh)
 {
 	struct mmp_struct *mmp = (struct mmp_struct *)(bh->b_data);
 
-	/*
-	 * We protect against freezing so that we don't create dirty buffers
-	 * on frozen filesystem.
-	 */
-	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
 	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
-	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
 		return -EIO;
-
 	return 0;
 }
 
+static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	/*
+	 * We protect against freezing so that we don't create dirty buffers
+	 * on frozen filesystem.
+	 */
+	sb_start_write(sb);
+	err = write_mmp_block_thawed(sb, bh);
+	sb_end_write(sb);
+	return err;
+}
+
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
@@ -340,7 +348,11 @@ skip:
 	seq = mmp_new_seq();
 	mmp->mmp_seq = cpu_to_le32(seq);
 
-	retval = write_mmp_block(sb, bh);
+	/*
+	 * On mount / remount we are protected against fs freezing (by s_umount
+	 * semaphore) and grabbing freeze protection upsets lockdep
+	 */
+	retval = write_mmp_block_thawed(sb, bh);
 	if (retval)
 		goto failed;
 


