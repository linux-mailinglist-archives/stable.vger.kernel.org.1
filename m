Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86773E760
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFZSOy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjFZSOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF91702
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880AE60F21
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97436C433C8;
        Mon, 26 Jun 2023 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803260;
        bh=tHt/D0h/nP4ET+sNLw5fs21PEBC0u57kv0I3AubbWW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glvFntd+Gyf11BYlXGbgNqWPU5HfdtY3btZZnfuLVVaCiUjqayYat14F2wb/RaDXq
         p1rb13WL0EvRJ4fp2CpBhFQfPsmZ0Ikq22sEBHR2szNI/xr8G6Eamnnv8Eo+ZPRtEW
         8YKuRXHcX2pwUTfu+TviveBB2pUr61il5i21nUHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.14 03/26] nilfs2: fix buffer corruption due to concurrent device reads
Date:   Mon, 26 Jun 2023 20:11:05 +0200
Message-ID: <20230626180733.820527378@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
References: <20230626180733.699092073@linuxfoundation.org>
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 679bd7ebdd315bf457a4740b306ae99f1d0a403d upstream.

As a result of analysis of a syzbot report, it turned out that in three
cases where nilfs2 allocates block device buffers directly via sb_getblk,
concurrent reads to the device can corrupt the allocated buffers.

Nilfs2 uses sb_getblk for segment summary blocks, that make up a log
header, and the super root block, that is the trailer, and when moving and
writing the second super block after fs resize.

In any of these, since the uptodate flag is not set when storing metadata
to be written in the allocated buffers, the stored metadata will be
overwritten if a device read of the same block occurs concurrently before
the write.  This causes metadata corruption and misbehavior in the log
write itself, causing warnings in nilfs_btree_assign() as reported.

Fix these issues by setting an uptodate flag on the buffer head on the
first or before modifying each buffer obtained with sb_getblk, and
clearing the flag on failure.

When setting the uptodate flag, the lock_buffer/unlock_buffer pair is used
to perform necessary exclusive control, and the buffer is filled to ensure
that uninitialized bytes are not mixed into the data read from others.  As
for buffers for segment summary blocks, they are filled incrementally, so
if the uptodate flag was unset on their allocation, set the flag and zero
fill the buffer once at that point.

Also, regarding the superblock move routine, the starting point of the
memset call to zerofill the block is incorrectly specified, which can
cause a buffer overflow on file systems with block sizes greater than
4KiB.  In addition, if the superblock is moved within a large block, it is
necessary to assume the possibility that the data in the superblock will
be destroyed by zero-filling before copying.  So fix these potential
issues as well.

Link: https://lkml.kernel.org/r/20230609035732.20426-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000030000a05e981f475@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/segbuf.c  |    6 ++++++
 fs/nilfs2/segment.c |    7 +++++++
 fs/nilfs2/super.c   |   23 ++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -110,6 +110,12 @@ int nilfs_segbuf_extend_segsum(struct ni
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -997,10 +997,13 @@ static void nilfs_segctor_fill_in_super_
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -1014,6 +1017,8 @@ static void nilfs_segctor_fill_in_super_
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1791,6 +1796,7 @@ static void nilfs_abort_logs(struct list
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1802,6 +1808,7 @@ static void nilfs_abort_logs(struct list
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -384,10 +384,31 @@ static int nilfs_move_2nd_super(struct s
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;


