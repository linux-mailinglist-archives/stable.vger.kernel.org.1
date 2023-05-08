Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8ED6FA60C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjEHKPk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEHKPj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D93AA0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A61C862486
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD80C433EF;
        Mon,  8 May 2023 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540937;
        bh=6lS53Np9yoehDcHFmthb/j4EXjQ0n53UtPVfqQ//r9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcN8Pl6oK7rR1e2yHQE5aJX/TAVGeBtbREV5oub02CUF+AIFgfJhwf6ct/HTIoZ8C
         RLVMKCS5J8qgjR833ttf1LI/SCqk+Oef1+FABLLWQxJZkxF1rLsVGHQlXVmyv0dwVp
         l7DWOcX5eCljb4TXNlhd0pjsLUUeo0crn9s1nrIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 523/611] ext4: fix i_disksize exceeding i_size problem in paritally written case
Date:   Mon,  8 May 2023 11:46:05 +0200
Message-Id: <20230508094439.015782209@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 1dedde690303c05ef732b7c5c8356fdf60a4ade3 ]

It is possible for i_disksize can exceed i_size, triggering a warning.

generic_perform_write
 copied = iov_iter_copy_from_user_atomic(len) // copied < len
 ext4_da_write_end
 | ext4_update_i_disksize
 |  new_i_size = pos + copied;
 |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
 | generic_write_end
 |  copied = block_write_end(copied, len) // copied = 0
 |   if (unlikely(copied < len))
 |    if (!PageUptodate(page))
 |     copied = 0;
 |  if (pos + copied > inode->i_size) // return false
 if (unlikely(copied == 0))
  goto again;
 if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
  status = -EFAULT;
  break;
 }

We get i_disksize greater than i_size here, which could trigger WARNING
check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:

ext4_dio_write_iter
 iomap_dio_rw
  __iomap_dio_rw // return err, length is not aligned to 512
 ext4_handle_inode_extension
  WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops

 WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
 CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
 RIP: 0010:ext4_file_write_iter+0xbc7
 Call Trace:
  vfs_write+0x3b1
  ksys_write+0x77
  do_syscall_64+0x39

Fix it by updating 'copied' value before updating i_disksize just like
ext4_write_inline_data_end() does.

A reproducer can be found in the buganizer link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
Fixes: 64769240bd07 ("ext4: Add delayed allocation support in data=writeback mode")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230321013721.89818-1-chengzhihao1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eea11ad84e680..42003b5c4cadc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3077,6 +3077,9 @@ static int ext4_da_write_end(struct file *file,
 	    ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
+	if (unlikely(copied < len) && !PageUptodate(page))
+		copied = 0;
+
 	start = pos & (PAGE_SIZE - 1);
 	end = start + copied - 1;
 
-- 
2.39.2



