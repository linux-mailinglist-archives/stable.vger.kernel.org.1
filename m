Return-Path: <stable+bounces-4884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9A807CD1
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1F2282486
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D4376;
	Thu,  7 Dec 2023 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FSFvibCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE807E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66915C433C9;
	Thu,  7 Dec 2023 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908022;
	bh=8rObhyz2GiO3e4eCGKjogu6D8v/6AkbKTQXgUnPz54c=;
	h=Date:To:From:Subject:From;
	b=FSFvibCGdsQ+1SUmxiHDAjp375rR5MyvnabTLfk4BZhLjUfkcqKAf8OsPvK5uXuy/
	 vHgkTFtuUudOvTq0/BHTLQbO6k6KIr0xER5vEqwvU+Cdbw7zst1Vbr5lfroq1wnqSh
	 Q3Vw2PI8HRP0gpD9fqPqbilPyUPxKXfLqrdjtKQA=
Date: Wed, 06 Dec 2023 16:13:41 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,konishi.ryusuke@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch removed from -mm tree
Message-Id: <20231207001342.66915C433C9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: nilfs2: fix missing error check for sb_set_blocksize call
has been removed from the -mm tree.  Its filename was
     nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: nilfs2: fix missing error check for sb_set_blocksize call
Date: Wed, 29 Nov 2023 23:15:47 +0900

When mounting a filesystem image with a block size larger than the page
size, nilfs2 repeatedly outputs long error messages with stack traces to
the kernel log, such as the following:

 getblk(): invalid block size 8192 requested
 logical block size: 512
 ...
 Call Trace:
  dump_stack_lvl+0x92/0xd4
  dump_stack+0xd/0x10
  bdev_getblk+0x33a/0x354
  __breadahead+0x11/0x80
  nilfs_search_super_root+0xe2/0x704 [nilfs2]
  load_nilfs+0x72/0x504 [nilfs2]
  nilfs_mount+0x30f/0x518 [nilfs2]
  legacy_get_tree+0x1b/0x40
  vfs_get_tree+0x18/0xc4
  path_mount+0x786/0xa88
  __ia32_sys_mount+0x147/0x1a8
  __do_fast_syscall_32+0x56/0xc8
  do_fast_syscall_32+0x29/0x58
  do_SYSENTER_32+0x15/0x18
  entry_SYSENTER_32+0x98/0xf1
 ...

This overloads the system logger.  And to make matters worse, it sometimes
crashes the kernel with a memory access violation.

This is because the return value of the sb_set_blocksize() call, which
should be checked for errors, is not checked.

The latter issue is due to out-of-buffer memory being accessed based on a
large block size that caused sb_set_blocksize() to fail for buffers read
with the initial minimum block size that remained unupdated in the
super_block structure.

Since nilfs2 mkfs tool does not accept block sizes larger than the system
page size, this has been overlooked.  However, it is possible to create
this situation by intentionally modifying the tool or by passing a
filesystem image created on a system with a large page size to a system
with a smaller page size and mounting it.

Fix this issue by inserting the expected error handling for the call to
sb_set_blocksize().

Link: https://lkml.kernel.org/r/20231129141547.4726-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/nilfs2/the_nilfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/the_nilfs.c~nilfs2-fix-missing-error-check-for-sb_set_blocksize-call
+++ a/fs/nilfs2/the_nilfs.c
@@ -716,7 +716,11 @@ int init_nilfs(struct the_nilfs *nilfs,
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_err(sb, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
_

Patches currently in -mm which might be from konishi.ryusuke@gmail.com are

nilfs2-move-page-release-outside-of-nilfs_delete_entry-and-nilfs_set_link.patch
nilfs2-eliminate-staggered-calls-to-kunmap-in-nilfs_rename.patch


