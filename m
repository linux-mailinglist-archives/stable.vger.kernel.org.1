Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE173E889
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFZS0p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFZS0a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F826A6
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5116C60E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56545C433CA;
        Mon, 26 Jun 2023 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803957;
        bh=TNOKYMpqXtynV043r0ftXVk+Rqw3D1IY/crP7G4zZS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7IBxBgbthcCvZdNJDOEiYNiPkJSfnHwHyaDM29b5wcDSsNg3z+wZiH/wtVI1ZP6y
         Ooo72sPkjagUAdheJ/Qc6d9LDifrzE9zxgwjuWvcDCxK6+8/otWKa8+fANF+6MmvdB
         BMPNXviJSomZ653JFPJnNkJiFtRSSrd3EEEa+LXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        syzbot+31837fe952932efc8fb9@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 09/41] nilfs2: fix buffer corruption due to concurrent device reads
Date:   Mon, 26 Jun 2023 20:11:32 +0200
Message-ID: <20230626180736.626314873@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct ni
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
@@ -984,10 +984,13 @@ static void nilfs_segctor_fill_in_super_
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
@@ -1001,6 +1004,8 @@ static void nilfs_segctor_fill_in_super_
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1778,6 +1783,7 @@ static void nilfs_abort_logs(struct list
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1789,6 +1795,7 @@ static void nilfs_abort_logs(struct list
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -374,10 +374,31 @@ static int nilfs_move_2nd_super(struct s
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


