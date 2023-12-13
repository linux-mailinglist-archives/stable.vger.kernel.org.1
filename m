Return-Path: <stable+bounces-6007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A860580D847
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D849A1C215AC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA051036;
	Mon, 11 Dec 2023 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hEwJRG5K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1664FC06;
	Mon, 11 Dec 2023 18:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BCDC433C8;
	Mon, 11 Dec 2023 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320261;
	bh=4yTwvGnp1dOSPQR3Ty0jCoi43mhGOBt2at/xubD3QaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEwJRG5Km7vyNi9TvsFteYB/7zSzkB6xb8vAAcgUQBlN+0mYybx1xDN7YfbkAIutG
	 6gXKJo2LNVa/TiZlfxtEGk+xlpyRHVxxkqdFHu1e5FnbQfiepYKBtQcnwS8LOKILnd
	 i3ulvj2u+B/bT5sypTCTB3HIvXADP0j74M5Ic/Ew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 56/67] nilfs2: fix missing error check for sb_set_blocksize call
Date: Mon, 11 Dec 2023 19:22:40 +0100
Message-ID: <20231211182017.384799460@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit d61d0ab573649789bf9eb909c89a1a193b2e3d10 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/the_nilfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -688,7 +688,11 @@ int init_nilfs(struct the_nilfs *nilfs,
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_msg(sb, KERN_ERR, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)



