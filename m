Return-Path: <stable+bounces-75428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52697347F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29321C24FA1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8724188A28;
	Tue, 10 Sep 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dskWaEOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF717BB0C;
	Tue, 10 Sep 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964703; cv=none; b=IAHYUxFfHB4zoUzml9LBJqXm5MXrqE4bQ9pemF55CVzcLDrSWFZJLrN5VBY5gweJIBXC7JjohCkcexTJWH5ggVyqvj4QpZUF/GrJaf0DiPWNUU+ct5KS1AWWE4nw/p3S1ViI0CPixnvyFA80oUrRY63p8KA95OVNaijx9F7o+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964703; c=relaxed/simple;
	bh=fTxUe5weBlr5wMurbPZiRGuBtHbQu0JpnMrpWZvNnmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BILwHdxuzx8zXGBcrm6KFHGYa7KSEs4Pgdxj8KR9ZIykzSoKslPcxdTtCgMbj8OEdAP0dL82lm2AM/a2OSSM2a7l9qhLNkuL0qh9d4CnG82ZvlA84cpAngwXRdyX3BVSvi8qRuf/9GXI0zqkVpam+iov80WszACVTrcfaXEqcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dskWaEOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE650C4CEC3;
	Tue, 10 Sep 2024 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964703;
	bh=fTxUe5weBlr5wMurbPZiRGuBtHbQu0JpnMrpWZvNnmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dskWaEODLnKE7RlK3dZP0NGIPKiL73wFr+sVOFqf55ObWiSNMog0srcF0jHhjhu6k
	 RjNI6KF8CEq22o69BeOS/GUW82cLd7MJGvMGve4MSpq3cMd836BjiszfAqGXl+jp8b
	 UaQSzoZJ+oLhdLQxytltdLBX3bj6vdSGauN8/5Hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Dias <paulo.miguel.dias@gmail.com>,
	Andreas Jahn <jahn-andi@web.de>,
	syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 265/269] btrfs: fix race between direct IO write and fsync when using same fd
Date: Tue, 10 Sep 2024 11:34:12 +0200
Message-ID: <20240910092617.185837738@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit cd9253c23aedd61eb5ff11f37a36247cd46faf86 upstream.

If we have 2 threads that are using the same file descriptor and one of
them is doing direct IO writes while the other is doing fsync, we have a
race where we can end up either:

1) Attempt a fsync without holding the inode's lock, triggering an
   assertion failures when assertions are enabled;

2) Do an invalid memory access from the fsync task because the file private
   points to memory allocated on stack by the direct IO task and it may be
   used by the fsync task after the stack was destroyed.

The race happens like this:

1) A user space program opens a file descriptor with O_DIRECT;

2) The program spawns 2 threads using libpthread for example;

3) One of the threads uses the file descriptor to do direct IO writes,
   while the other calls fsync using the same file descriptor.

4) Call task A the thread doing direct IO writes and task B the thread
   doing fsyncs;

5) Task A does a direct IO write, and at btrfs_direct_write() sets the
   file's private to an on stack allocated private with the member
   'fsync_skip_inode_lock' set to true;

6) Task B enters btrfs_sync_file() and sees that there's a private
   structure associated to the file which has 'fsync_skip_inode_lock' set
   to true, so it skips locking the inode's VFS lock;

7) Task A completes the direct IO write, and resets the file's private to
   NULL since it had no prior private and our private was stack allocated.
   Then it unlocks the inode's VFS lock;

8) Task B enters btrfs_get_ordered_extents_for_logging(), then the
   assertion that checks the inode's VFS lock is held fails, since task B
   never locked it and task A has already unlocked it.

The stack trace produced is the following:

   assertion failed: inode_is_locked(&inode->vfs_inode), in fs/btrfs/ordered-data.c:983
   ------------[ cut here ]------------
   kernel BUG at fs/btrfs/ordered-data.c:983!
   Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
   CPU: 9 PID: 5072 Comm: worker Tainted: G     U     OE      6.10.5-1-default #1 openSUSE Tumbleweed 69f48d427608e1c09e60ea24c6c55e2ca1b049e8
   Hardware name: Acer Predator PH315-52/Covini_CFS, BIOS V1.12 07/28/2020
   RIP: 0010:btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs]
   Code: 50 d6 86 c0 e8 (...)
   RSP: 0018:ffff9e4a03dcfc78 EFLAGS: 00010246
   RAX: 0000000000000054 RBX: ffff9078a9868e98 RCX: 0000000000000000
   RDX: 0000000000000000 RSI: ffff907dce4a7800 RDI: ffff907dce4a7800
   RBP: ffff907805518800 R08: 0000000000000000 R09: ffff9e4a03dcfb38
   R10: ffff9e4a03dcfb30 R11: 0000000000000003 R12: ffff907684ae7800
   R13: 0000000000000001 R14: ffff90774646b600 R15: 0000000000000000
   FS:  00007f04b96006c0(0000) GS:ffff907dce480000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00007f32acbfc000 CR3: 00000001fd4fa005 CR4: 00000000003726f0
   Call Trace:
    <TASK>
    ? __die_body.cold+0x14/0x24
    ? die+0x2e/0x50
    ? do_trap+0xca/0x110
    ? do_error_trap+0x6a/0x90
    ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
    ? exc_invalid_op+0x50/0x70
    ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
    ? asm_exc_invalid_op+0x1a/0x20
    ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
    ? btrfs_get_ordered_extents_for_logging.cold+0x1f/0x42 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
    btrfs_sync_file+0x21a/0x4d0 [btrfs bb26272d49b4cdc847cf3f7faadd459b62caee9a]
    ? __seccomp_filter+0x31d/0x4f0
    __x64_sys_fdatasync+0x4f/0x90
    do_syscall_64+0x82/0x160
    ? do_futex+0xcb/0x190
    ? __x64_sys_futex+0x10e/0x1d0
    ? switch_fpu_return+0x4f/0xd0
    ? syscall_exit_to_user_mode+0x72/0x220
    ? do_syscall_64+0x8e/0x160
    ? syscall_exit_to_user_mode+0x72/0x220
    ? do_syscall_64+0x8e/0x160
    ? syscall_exit_to_user_mode+0x72/0x220
    ? do_syscall_64+0x8e/0x160
    ? syscall_exit_to_user_mode+0x72/0x220
    ? do_syscall_64+0x8e/0x160
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Another problem here is if task B grabs the private pointer and then uses
it after task A has finished, since the private was allocated in the stack
of task A, it results in some invalid memory access with a hard to predict
result.

This issue, triggering the assertion, was observed with QEMU workloads by
two users in the Link tags below.

Fix this by not relying on a file's private to pass information to fsync
that it should skip locking the inode and instead pass this information
through a special value stored in current->journal_info. This is safe
because in the relevant section of the direct IO write path we are not
holding a transaction handle, so current->journal_info is NULL.

The following C program triggers the issue:

   $ cat repro.c
   /* Get the O_DIRECT definition. */
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif

   #include <stdio.h>
   #include <stdlib.h>
   #include <unistd.h>
   #include <stdint.h>
   #include <fcntl.h>
   #include <errno.h>
   #include <string.h>
   #include <pthread.h>

   static int fd;

   static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
   {
       while (count > 0) {
           ssize_t ret;

           ret = pwrite(fd, buf, count, offset);
           if (ret < 0) {
               if (errno == EINTR)
                   continue;
               return ret;
           }
           count -= ret;
           buf += ret;
       }
       return 0;
   }

   static void *fsync_loop(void *arg)
   {
       while (1) {
           int ret;

           ret = fsync(fd);
           if (ret != 0) {
               perror("Fsync failed");
               exit(6);
           }
       }
   }

   int main(int argc, char *argv[])
   {
       long pagesize;
       void *write_buf;
       pthread_t fsyncer;
       int ret;

       if (argc != 2) {
           fprintf(stderr, "Use: %s <file path>\n", argv[0]);
           return 1;
       }

       fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
       if (fd == -1) {
           perror("Failed to open/create file");
           return 1;
       }

       pagesize = sysconf(_SC_PAGE_SIZE);
       if (pagesize == -1) {
           perror("Failed to get page size");
           return 2;
       }

       ret = posix_memalign(&write_buf, pagesize, pagesize);
       if (ret) {
           perror("Failed to allocate buffer");
           return 3;
       }

       ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
       if (ret != 0) {
           fprintf(stderr, "Failed to create writer thread: %d\n", ret);
           return 4;
       }

       while (1) {
           ret = do_write(fd, write_buf, pagesize, 0);
           if (ret != 0) {
               perror("Write failed");
               exit(5);
           }
       }

       return 0;
   }

   $ mkfs.btrfs -f /dev/sdi
   $ mount /dev/sdi /mnt/sdi
   $ timeout 10 ./repro /mnt/sdi/foo

Usually the race is triggered within less than 1 second. A test case for
fstests will follow soon.

Reported-by: Paulo Dias <paulo.miguel.dias@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219187
Reported-by: Andreas Jahn <jahn-andi@web.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219199
Reported-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000044ff540620d7dee2@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h       |    1 -
 fs/btrfs/file.c        |   25 ++++++++++---------------
 fs/btrfs/transaction.h |    6 ++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -445,7 +445,6 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
-	bool fsync_skip_inode_lock;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1543,13 +1543,6 @@ again:
 	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
 	} else {
-		struct btrfs_file_private stack_private = { 0 };
-		struct btrfs_file_private *private;
-		const bool have_private = (file->private_data != NULL);
-
-		if (!have_private)
-			file->private_data = &stack_private;
-
 		/*
 		 * If we have a synchoronous write, we must make sure the fsync
 		 * triggered by the iomap_dio_complete() call below doesn't
@@ -1558,13 +1551,10 @@ again:
 		 * partial writes due to the input buffer (or parts of it) not
 		 * being already faulted in.
 		 */
-		private = file->private_data;
-		private->fsync_skip_inode_lock = true;
+		ASSERT(current->journal_info == NULL);
+		current->journal_info = BTRFS_TRANS_DIO_WRITE_STUB;
 		err = iomap_dio_complete(dio);
-		private->fsync_skip_inode_lock = false;
-
-		if (!have_private)
-			file->private_data = NULL;
+		current->journal_info = NULL;
 	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
@@ -1796,7 +1786,6 @@ static inline bool skip_inode_logging(co
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1806,7 +1795,13 @@ int btrfs_sync_file(struct file *file, l
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
-	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
+	bool skip_ilock = false;
+
+	if (current->journal_info == BTRFS_TRANS_DIO_WRITE_STUB) {
+		skip_ilock = true;
+		current->journal_info = NULL;
+		lockdep_assert_held(&inode->i_rwsem);
+	}
 
 	trace_btrfs_sync_file(file, datasync);
 
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -12,6 +12,12 @@
 #include "ctree.h"
 #include "misc.h"
 
+/*
+ * Signal that a direct IO write is in progress, to avoid deadlock for sync
+ * direct IO writes when fsync is called during the direct IO write path.
+ */
+#define BTRFS_TRANS_DIO_WRITE_STUB	((void *) 1)
+
 /* Radix-tree tag for roots that are part of the trasaction. */
 #define BTRFS_ROOT_TRANS_TAG			0
 



