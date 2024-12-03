Return-Path: <stable+bounces-97607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB32A9E24B8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D802876E3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEE1F7071;
	Tue,  3 Dec 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V36soB1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE11DAC9F;
	Tue,  3 Dec 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241098; cv=none; b=ZdJS06ZW+ji//lvIck4anbooWxGo/SGiwC6ueOrHt4ABQvx5fRtwhvA7dagCLRjNZWa07wbonjjyja4SnG2y4H2+4+iwq2piaIKlaGnkzULfoL7HJTx1CcOOxsOGqNxHrMQbPtlRFupjCpkVQm+n+/lsBjP84d2erDmZbLDBFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241098; c=relaxed/simple;
	bh=OQLcV5tDi+mScSdkvL25dJ0M5x01c00xawrmXaAWryQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVsOlzfGMa49OzvtGPoaIIOJhngSH9vQyhnabXPyuki66MAUuwW3Xxr2tTuS/UUimCk7VEQjm6rXr8S3gIfpsEA6A1WqKUHDDtqoBX4xWjHQVEiNvEP3Gl5MkusILKq/apUrE6xE22P434e5BdgexGzvOealsojBifYKKglgRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V36soB1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF2C4CECF;
	Tue,  3 Dec 2024 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241098;
	bh=OQLcV5tDi+mScSdkvL25dJ0M5x01c00xawrmXaAWryQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V36soB1xDs+4Zj+cONgUMunAGwQdDgU5XUjlYRTBMsrpqa1Q0JhPUG5lMEdN8RR0g
	 p0UtGD7s8E/W/l6nXs7TMcIOCoEhtM0Hh/gmAxy8amPgXiY7sKZl4x4RjUs5B1z6hT
	 IsJS/Qav5qkV8KzzXhp6tJSWTWItplEhX7Jage+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Ge <gehao@kylinos.cn>,
	Eric Sandeen <sandeen@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 307/826] isofs: avoid memory leak in iocharset
Date: Tue,  3 Dec 2024 15:40:34 +0100
Message-ID: <20241203144755.738977655@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Ge <gehao@kylinos.cn>

[ Upstream commit 0b5bbeee4de616a268db77e2f40f19ab010a367b ]

A memleak was found as below:

unreferenced object 0xffff0000d10164d8 (size 8):
  comm "pool-udisksd", pid 108217, jiffies 4295408555
  hex dump (first 8 bytes):
    75 74 66 38 00 cc cc cc                          utf8....
  backtrace (crc de430d31):
    [<ffff800081046e6c>] kmemleak_alloc+0xb8/0xc8
    [<ffff8000803e6c3c>] __kmalloc_node_track_caller_noprof+0x380/0x474
    [<ffff800080363b74>] kstrdup+0x70/0xfc
    [<ffff80007bb3c6a4>] isofs_parse_param+0x228/0x2c0 [isofs]
    [<ffff8000804d7f68>] vfs_parse_fs_param+0xf4/0x164
    [<ffff8000804d8064>] vfs_parse_fs_string+0x8c/0xd4
    [<ffff8000804d815c>] vfs_parse_monolithic_sep+0xb0/0xfc
    [<ffff8000804d81d8>] generic_parse_monolithic+0x30/0x3c
    [<ffff8000804d8bfc>] parse_monolithic_mount_data+0x40/0x4c
    [<ffff8000804b6a64>] path_mount+0x6c4/0x9ec
    [<ffff8000804b6e38>] do_mount+0xac/0xc4
    [<ffff8000804b7494>] __arm64_sys_mount+0x16c/0x2b0
    [<ffff80008002b8dc>] invoke_syscall+0x7c/0x104
    [<ffff80008002ba44>] el0_svc_common.constprop.1+0xe0/0x104
    [<ffff80008002ba94>] do_el0_svc+0x2c/0x38
    [<ffff800081041108>] el0_svc+0x3c/0x1b8

The opt->iocharset is freed inside the isofs_fill_super function,
But there may be situations where it's not possible to
enter this function.

For example, in the get_tree_bdev_flags function,when
encountering the situation where "Can't mount, would change RO state,"
In such a case, isofs_fill_super will not have the opportunity
to be called,which means that opt->iocharset will not have the chance
to be freed,ultimately leading to a memory leak.

Let's move the memory freeing of opt->iocharset into
isofs_free_fc function.

Fixes: 1b17a46c9243 ("isofs: convert isofs to use the new mount API")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241106082841.51773-1-hao.ge@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/isofs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index f50311a6b4299..47038e6608123 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -948,8 +948,6 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto out_no_inode;
 	}
 
-	kfree(opt->iocharset);
-
 	return 0;
 
 	/*
@@ -987,7 +985,6 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
 	brelse(bh);
 	brelse(pri_bh);
 out_freesbi:
-	kfree(opt->iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return error;
@@ -1528,7 +1525,10 @@ static int isofs_get_tree(struct fs_context *fc)
 
 static void isofs_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct isofs_options *opt = fc->fs_private;
+
+	kfree(opt->iocharset);
+	kfree(opt);
 }
 
 static const struct fs_context_operations isofs_context_ops = {
-- 
2.43.0




