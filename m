Return-Path: <stable+bounces-129326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D1A7FE5B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896797A67DE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E7224F6;
	Tue,  8 Apr 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x+xU+aCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17A268FD7;
	Tue,  8 Apr 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110724; cv=none; b=IOHu66gwDeCAJ06jkKbF8LG08sapJPMhiITe3Am+j/G4Z11lVHsb7KFJwjYFzEqRoKveAORs33NBuZRjE73rY3Q5UiG2Ao6Rnz7isyRex1s08Y98SZBbUMxyOl+T7rt7wisMb47MSknd5TagtTF2l7P0Lyv0PdlV8lCXq60aCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110724; c=relaxed/simple;
	bh=e4ikPJn41QuDBzEw8pUN7Ugp7VbgqOUnsgP6Spn2fEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5kmm9l/lLqnWRVPDZiVQFT77USoAy+9MYJ+QXZwRS5NjTY27qtJancDZMu9lZxuzOJbGJcGPYAHFDzrFTMXej0HkPx/GdKPUMA2u+W8DlbdO5eTpu9ixwDYfELSdzuph+H6PrRcZ6kbzBEqqHKNj4WX42NyTaYB3ukpkJoJaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x+xU+aCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085F1C4CEE5;
	Tue,  8 Apr 2025 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110724;
	bh=e4ikPJn41QuDBzEw8pUN7Ugp7VbgqOUnsgP6Spn2fEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x+xU+aCj1u1wQJ1LRayO8YZjta7OZ3hyH1G0FudVpBfuT3dls8e4xzUMebZQqDzIi
	 /sSwqI5i3bmvCK6bx5lFELpXtAjHXR+4Evhx9t+sLdips+DvDGPa0QiA4pG8C7aepE
	 glae+xeoW1jQWYFUbRzLkcjGCG+xokjepyueU/6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Prusakowski <jprusakowski@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 130/731] f2fs: fix potential deadloop in prepare_compress_overwrite()
Date: Tue,  8 Apr 2025 12:40:27 +0200
Message-ID: <20250408104917.303479612@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 3147ee567dd9004a49826ddeaf0a4b12865d4409 ]

Jan Prusakowski reported a kernel hang issue as below:

When running xfstests on linux-next kernel (6.14.0-rc3, 6.12) I
encountered a problem in generic/475 test where fsstress process
gets blocked in __f2fs_write_data_pages() and the test hangs.
The options I used are:

MKFS_OPTIONS  -- -O compression -O extra_attr -O project_quota -O quota /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o discard,compress_extension=* /dev/vdc /vdc

INFO: task kworker/u8:0:11 blocked for more than 122 seconds.
      Not tainted 6.14.0-rc3-xfstests-lockdep #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208160 flags:0x00004000
Workqueue: writeback wb_workfn (flush-253:0)
Call Trace:
 <TASK>
 __schedule+0x309/0x8e0
 schedule+0x3a/0x100
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock+0x59a/0xdb0
 __f2fs_write_data_pages+0x3ac/0x400
 do_writepages+0xe8/0x290
 __writeback_single_inode+0x5c/0x360
 writeback_sb_inodes+0x22f/0x570
 wb_writeback+0xb0/0x410
 wb_do_writeback+0x47/0x2f0
 wb_workfn+0x5a/0x1c0
 process_one_work+0x223/0x5b0
 worker_thread+0x1d5/0x3c0
 kthread+0xfd/0x230
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The root cause is: once generic/475 starts toload error table to dm
device, f2fs_prepare_compress_overwrite() will loop reading compressed
cluster pages due to IO error, meanwhile it has held .writepages lock,
it can block all other writeback tasks.

Let's fix this issue w/ below changes:
- add f2fs_handle_page_eio() in prepare_compress_overwrite() to
detect IO error.
- detect cp_error earler in f2fs_read_multi_pages().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reported-by: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c |  1 +
 fs/f2fs/data.c     | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 985690d81a82c..9b94810675c19 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1150,6 +1150,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		f2fs_compress_ctx_add_page(cc, page_folio(page));
 
 		if (!PageUptodate(page)) {
+			f2fs_handle_page_eio(sbi, page_folio(page), DATA);
 release_and_retry:
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index de4da6d9cd93a..8440a1ed24f23 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2178,6 +2178,12 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	int i;
 	int ret = 0;
 
+	if (unlikely(f2fs_cp_error(sbi))) {
+		ret = -EIO;
+		from_dnode = false;
+		goto out_put_dnode;
+	}
+
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
 	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
@@ -2221,10 +2227,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	if (ret)
 		goto out;
 
-	if (unlikely(f2fs_cp_error(sbi))) {
-		ret = -EIO;
-		goto out_put_dnode;
-	}
 	f2fs_bug_on(sbi, dn.data_blkaddr != COMPRESS_ADDR);
 
 skip_reading_dnode:
-- 
2.39.5




