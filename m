Return-Path: <stable+bounces-91359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B99BED9E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D61F25564
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA221EC01C;
	Wed,  6 Nov 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EMiLKAQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC31922EF;
	Wed,  6 Nov 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898503; cv=none; b=PxhBL4e4R9C6lrbhfv/sDcTzG72vYfzAFj6rbttAYnXst5vc62nKm85RecX2suK6X4NTyC2vslHXc17f2sCbtGaRrX6yvLwppyAjfMYlCZEUGSOeSf9CDUFKJsEW9dof8pHAX9w3bgFkXAFdV/Crg5oaB7O3Gh3SiQRUvd4evjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898503; c=relaxed/simple;
	bh=t5O+NIf4bJR2Uar2sz5RTaxkHjoCHsbzAGyYsKlhNUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEWD2s43TUn8TrsM8zP+ze+r/kCy8/d2UleVaDRj9tRnsSXHlfZqR+efpy2HlLV/hLl5BnoOXrI3oQxO7iMwWodEXUQQO/ObI1wsjhsquKNSgfQSFBU40Q99NwNBSN8YTfRYCf3QLwVCg2PSsOxBqRdAtTTzTzyh8e8xr27S8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EMiLKAQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6C3C4CED3;
	Wed,  6 Nov 2024 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898503;
	bh=t5O+NIf4bJR2Uar2sz5RTaxkHjoCHsbzAGyYsKlhNUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMiLKAQUqLrpHVuX3tlpne7CgmtICtZeBmD/3/5Y1RwWeT6gSUwv/lgBpNBssiDmu
	 nu/i3rSIZpp1+NiuLDB4vl4HXtDBn6MuCfx1SuRXxX82Ur9zZgLOJ749URGZhhogFp
	 EfEG8YBmNDinTtvnruUYi6nJ20lVcx8GnFSihyi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 259/462] ocfs2: fix uninit-value in ocfs2_get_block()
Date: Wed,  6 Nov 2024 13:02:32 +0100
Message-ID: <20241106120337.924268218@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

From: Joseph Qi <joseph.qi@linux.alibaba.com>

commit 2af148ef8549a12f8025286b8825c2833ee6bcb8 upstream.

syzbot reported an uninit-value BUG:

BUG: KMSAN: uninit-value in ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
ocfs2_get_block+0xed2/0x2710 fs/ocfs2/aops.c:159
do_mpage_readpage+0xc45/0x2780 fs/mpage.c:225
mpage_readahead+0x43f/0x840 fs/mpage.c:374
ocfs2_readahead+0x269/0x320 fs/ocfs2/aops.c:381
read_pages+0x193/0x1110 mm/readahead.c:160
page_cache_ra_unbounded+0x901/0x9f0 mm/readahead.c:273
do_page_cache_ra mm/readahead.c:303 [inline]
force_page_cache_ra+0x3b1/0x4b0 mm/readahead.c:332
force_page_cache_readahead mm/internal.h:347 [inline]
generic_fadvise+0x6b0/0xa90 mm/fadvise.c:106
vfs_fadvise mm/fadvise.c:185 [inline]
ksys_fadvise64_64 mm/fadvise.c:199 [inline]
__do_sys_fadvise64 mm/fadvise.c:214 [inline]
__se_sys_fadvise64 mm/fadvise.c:212 [inline]
__x64_sys_fadvise64+0x1fb/0x3a0 mm/fadvise.c:212
x64_sys_call+0xe11/0x3ba0
arch/x86/include/generated/asm/syscalls_64.h:222
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is because when ocfs2_extent_map_get_blocks() fails, p_blkno is
uninitialized.  So the error log will trigger the above uninit-value
access.

The error log is out-of-date since get_blocks() was removed long time ago.
And the error code will be logged in ocfs2_extent_map_get_blocks() once
ocfs2_get_cluster() fails, so fix this by only logging inode and block.

Link: https://syzkaller.appspot.com/bug?extid=9709e73bae885b05314b
Link: https://lkml.kernel.org/r/20240925090600.3643376-1-joseph.qi@linux.alibaba.com
Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Tested-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/aops.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -159,9 +159,8 @@ int ocfs2_get_block(struct inode *inode,
 	err = ocfs2_extent_map_get_blocks(inode, iblock, &p_blkno, &count,
 					  &ext_flags);
 	if (err) {
-		mlog(ML_ERROR, "Error %d from get_blocks(0x%p, %llu, 1, "
-		     "%llu, NULL)\n", err, inode, (unsigned long long)iblock,
-		     (unsigned long long)p_blkno);
+		mlog(ML_ERROR, "get_blocks() failed, inode: 0x%p, "
+		     "block: %llu\n", inode, (unsigned long long)iblock);
 		goto bail;
 	}
 



