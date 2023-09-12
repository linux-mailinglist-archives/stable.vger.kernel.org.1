Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4079B775
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353983AbjIKVvw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbjIKNwN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:52:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380CFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:52:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C50C433C7;
        Mon, 11 Sep 2023 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440328;
        bh=jJqhpc8EvOGHiuIEYdtVWNRTJw1+xl8FSl0zJ7igaQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2ysDyeRFJ6E28bKh4hp8FLxgvTPi5aL14iUZqsIcCebIRYHqodmuOpGfqcusfvBY
         n78VQ3uXgwxXjXOdSluOlJkCFADHl4VM0NUmCd4+xXaMsE7QpKFRYsfAA0+3w/ybJT
         aNxoCdZQBKXbKrw7WyLC7TIUfzjWulIQYgnVr5EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH 6.5 007/739] Revert "fuse: in fuse_flush only wait if someone wants the return code"
Date:   Mon, 11 Sep 2023 15:36:46 +0200
Message-ID: <20230911134651.186658519@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 91ec6c85599b60c00caf4e9a9d6c4d6e5dd5e93c upstream.

This reverts commit 5a8bee63b10f6f2f52f6d22e109a4a147409842a.

Jürg Billeter reports the following regression:

  Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
  someone wants the return code") `fput()` is called asynchronously if a
  file is closed as part of a process exiting, i.e., if there was no
  explicit `close()` before exit.

  If the file was open for writing, also `put_write_access()` is called
  asynchronously as part of the async `fput()`.

  If that newly written file is an executable, attempting to `execve()` the
  new file can fail with `ETXTBSY` if it's called after the writer process
  exited but before the async `fput()` has run.

Reported-and-tested-by: "Jürg Billeter" <j@bitron.ch>
Cc: <stable@vger.kernel.org> # v6.3
Link: https://lore.kernel.org/all/4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/file.c |   89 ++++++++++++++++-----------------------------------------
 1 file changed, 26 insertions(+), 63 deletions(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,7 +19,6 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
-#include <linux/file.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -479,36 +478,48 @@ static void fuse_sync_writes(struct inod
 	fuse_release_nowrite(inode);
 }
 
-struct fuse_flush_args {
-	struct fuse_args args;
-	struct fuse_flush_in inarg;
-	struct work_struct work;
-	struct file *file;
-};
-
-static int fuse_do_flush(struct fuse_flush_args *fa)
+static int fuse_flush(struct file *file, fl_owner_t id)
 {
-	int err;
-	struct inode *inode = file_inode(fa->file);
+	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_flush_in inarg;
+	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+		return 0;
 
 	err = write_inode_now(inode, 1);
 	if (err)
-		goto out;
+		return err;
 
 	inode_lock(inode);
 	fuse_sync_writes(inode);
 	inode_unlock(inode);
 
-	err = filemap_check_errors(fa->file->f_mapping);
+	err = filemap_check_errors(file->f_mapping);
 	if (err)
-		goto out;
+		return err;
 
 	err = 0;
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
-	err = fuse_simple_request(fm, &fa->args);
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.fh = ff->fh;
+	inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
+	args.opcode = FUSE_FLUSH;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.force = true;
+
+	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_flush = 1;
 		err = 0;
@@ -521,57 +532,9 @@ inval_attr_out:
 	 */
 	if (!err && fm->fc->writeback_cache)
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
-
-out:
-	fput(fa->file);
-	kfree(fa);
 	return err;
 }
 
-static void fuse_flush_async(struct work_struct *work)
-{
-	struct fuse_flush_args *fa = container_of(work, typeof(*fa), work);
-
-	fuse_do_flush(fa);
-}
-
-static int fuse_flush(struct file *file, fl_owner_t id)
-{
-	struct fuse_flush_args *fa;
-	struct inode *inode = file_inode(file);
-	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_file *ff = file->private_data;
-
-	if (fuse_is_bad(inode))
-		return -EIO;
-
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
-		return 0;
-
-	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
-	if (!fa)
-		return -ENOMEM;
-
-	fa->inarg.fh = ff->fh;
-	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
-	fa->args.opcode = FUSE_FLUSH;
-	fa->args.nodeid = get_node_id(inode);
-	fa->args.in_numargs = 1;
-	fa->args.in_args[0].size = sizeof(fa->inarg);
-	fa->args.in_args[0].value = &fa->inarg;
-	fa->args.force = true;
-	fa->file = get_file(file);
-
-	/* Don't wait if the task is exiting */
-	if (current->flags & PF_EXITING) {
-		INIT_WORK(&fa->work, fuse_flush_async);
-		schedule_work(&fa->work);
-		return 0;
-	}
-
-	return fuse_do_flush(fa);
-}
-
 int fuse_fsync_common(struct file *file, loff_t start, loff_t end,
 		      int datasync, int opcode)
 {


