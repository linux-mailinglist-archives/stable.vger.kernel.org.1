Return-Path: <stable+bounces-168796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AAB236A3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AB1714E8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF051279DB6;
	Tue, 12 Aug 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAboN9JG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77A3D994;
	Tue, 12 Aug 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025359; cv=none; b=sOF5KVEeyYzEbc/hO5Jwu0Kf0jmcPHAkmOphYKKKzk/Su46cRhmYAsRJQ67VmzWvAScvyh6vpQGuV4aLhnPJGl0V8cwOAgk/O/QsqJBqlgGl22w6CL2pxgveZo2meG4OzdY2xVOwjFMJeQefJNY/rLEESSRx6ooJXXE4j6FtJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025359; c=relaxed/simple;
	bh=oOGluofS7HLEOPktyskzculn20dKbu56YYeCtPuAFSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9MDNXTT+LFPb3IbmtVsVhSwSCTi/jVvL17TlhvW5/lToRVbB/L3x3eTuYW+6vVeFFb0gpLoWw7tKO5hefTDBy/tERBu9J2NG87mZrXrC9bp1djN0NYI+VlbK8QmYBvXSMdLEnzc4LTm8/gBbFUkO+l/BZNgybrPIjzBvAX0Zu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAboN9JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D065EC4CEF0;
	Tue, 12 Aug 2025 19:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025359;
	bh=oOGluofS7HLEOPktyskzculn20dKbu56YYeCtPuAFSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAboN9JG4ckw/zPjfKKYgH8tp0Db7dAk+kAGQk3ozQGzHYqIMPUhTzNaM0rFrt0W4
	 TzHjKmHf6xuG3N8xvfZ5dwlw0sr7OPf/DWhReW+X3/m3fu4JHA7sbYm5n2vSozsDnQ
	 UMt8FEeA3a1FFrJBSMSZrtq4ZHeg9e6aJ3xC5MM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com,
	Yangtao Li <frank.li@vivo.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 019/480] hfsplus: remove mutex_lock check in hfsplus_free_extents
Date: Tue, 12 Aug 2025 19:43:47 +0200
Message-ID: <20250812174358.097087992@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit fcb96956c921f1aae7e7b477f2435c56f77a31b4 ]

Syzbot reported an issue in hfsplus filesystem:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
	hfsplus_free_extents+0x700/0xad0
Call Trace:
<TASK>
hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
cont_expand_zero fs/buffer.c:2383 [inline]
cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
notify_change+0xe38/0x10f0 fs/attr.c:420
do_truncate+0x1fb/0x2e0 fs/open.c:65
do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
on file truncation") unlock extree before hfsplus_free_extents(),
and add check wheather extree is locked in hfsplus_free_extents().

However, when operations such as hfsplus_file_release,
hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
concurrently in different files, it is very likely to trigger the
WARN_ON, which will lead syzbot and xfstest to consider it as an
abnormality.

The comment above this warning also describes one of the easy
triggering situations, which can easily trigger and cause
xfstest&syzbot to report errors.

[task A]			[task B]
->hfsplus_file_release
  ->hfsplus_file_truncate
    ->hfs_find_init
      ->mutex_lock
    ->mutex_unlock
				->hfsplus_write_begin
				  ->hfsplus_get_block
				    ->hfsplus_file_extend
				      ->hfsplus_ext_read_extent
				        ->hfs_find_init
					  ->mutex_lock
    ->hfsplus_free_extents
      WARN_ON(mutex_is_locked) !!!

Several threads could try to lock the shared extents tree.
And warning can be triggered in one thread when another thread
has locked the tree. This is the wrong behavior of the code and
we need to remove the warning.

Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.com/
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20250529061807.2213498-1-frank.li@vivo.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/extents.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..b1699b3c246a 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
 	int i;
 	int err = 0;
 
-	/* Mapping the allocation file may lock the extent tree */
-	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
-
 	hfsplus_dump_extent(extent);
 	for (i = 0; i < 8; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
-- 
2.39.5




