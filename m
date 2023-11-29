Return-Path: <stable+bounces-3180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711407FE27C
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C60B21035
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000374CB39;
	Wed, 29 Nov 2023 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i26vP1Xr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF04CB34
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 21:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17517C433C7;
	Wed, 29 Nov 2023 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701294966;
	bh=Pqi8Rt5+uzSxF4vwhRrCwKA6lnhucqxIfAQYngS21wo=;
	h=Date:To:From:Subject:From;
	b=i26vP1XrZNqpA+8D2iJ4ayCKWg56/jHX/aKl8JVPAOxM0ngN6ffF61MfUWI9wEd2I
	 tCYzNKKCXPCzh6AgiPtX4dQ+hasKBnp54pJ+izaeYkZ17SL2KtyTYdfZN0f4WDU8M0
	 ZHd/ARPoeaDP/PmDb5PVY6jyqN59Fnt5N1MTzUYI=
Date: Wed, 29 Nov 2023 13:56:05 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,konishi.ryusuke@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch added to mm-hotfixes-unstable branch
Message-Id: <20231129215606.17517C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: nilfs2: fix missing error check for sb_set_blocksize call
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

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

nilfs2-fix-missing-error-check-for-sb_set_blocksize-call.patch
nilfs2-move-page-release-outside-of-nilfs_delete_entry-and-nilfs_set_link.patch
nilfs2-eliminate-staggered-calls-to-kunmap-in-nilfs_rename.patch


