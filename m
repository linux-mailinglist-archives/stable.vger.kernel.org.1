Return-Path: <stable+bounces-204263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BECEA515
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C9A301AD05
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623D2E093C;
	Tue, 30 Dec 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQdYBBfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E621C84DC
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115599; cv=none; b=RA3FSGnGCpktzqAsGEDc8FFAGl+4XdgsTyYrbclx5XoAGhdi8yVoDpt3KUIYbYvMaiAakaIexx+lN4d6PTinbm8Ti/SBsqNFuRG55OC3CM7fozQx7D1+NPcbSKH3E8d1fQzMEqAhgOC9uVlMB5w/yyXF+uyQw3rt4Z8t84zWe+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115599; c=relaxed/simple;
	bh=QhGl8CmwrpSoSy0j77rEazbJ68ii108055cOwdAGyt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXHqMlIjHPb/kdlwiQdkUK3IqDlaJzspyyW0tu76gCa0hBKhZDv77jPymQImgROH+R5G1N+Zvb8wIBKmGUotEq8DDHfDCUBTdRINzDubrvODmY07L0V4qmdD1HL7u3QRpyGOwZtv3YNGEbeyOSmlsnTH+VRcPXbkBACmImSdhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQdYBBfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1364FC4CEFB;
	Tue, 30 Dec 2025 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115598;
	bh=QhGl8CmwrpSoSy0j77rEazbJ68ii108055cOwdAGyt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQdYBBfcWJlrD/WxnaBShpxWrPehM8iYRl9nBw/Y5xo7VRQn5MFKe5mQGmweGr3/f
	 UlJ5KsvV8QNN/JLoKOj3UKexHuEocn3PJpQ+qZSk2VADwy90xwtX6xeezFPTJ9b4QZ
	 TLGd2iQU9VOc93PGIdKYR8StoAEd8CujDG+7EGfKCkJ8HRA4eVSa6zgqVxborlxa1M
	 /FaCPppX3O/VVPCv0RK/tZupBWUvjRbVVF5FVOQSs/xupknVW5xhlfN3KXaN9+QMe+
	 Z7iGVoh+dHSVB2O04mSv2KrFgHzPLp04tploMjrx6yBifeZaQACyZJ+CE/Sic/Zh9F
	 1p3RRe8nmU55g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to avoid updating zero-sized extent in extent cache
Date: Tue, 30 Dec 2025 12:26:36 -0500
Message-ID: <20251230172636.2349925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122900-ripeness-surging-a95d@gregkh>
References: <2025122900-ripeness-surging-a95d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7c37c79510329cd951a4dedf3f7bf7e2b18dccec ]

As syzbot reported:

F2FS-fs (loop0): __update_extent_tree_range: extent len is zero, type: 0, extent [0, 0, 0], age [0, 0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/extent_cache.c:678!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
Call Trace:
 <TASK>
 f2fs_update_read_extent_cache_range+0x192/0x3e0 fs/f2fs/extent_cache.c:1085
 f2fs_do_zero_range fs/f2fs/file.c:1657 [inline]
 f2fs_zero_range+0x10c1/0x1580 fs/f2fs/file.c:1737
 f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ioctl_preallocate fs/ioctl.c:289 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07bc58eec9

In error path of f2fs_zero_range(), it may add a zero-sized extent
into extent cache, it should be avoided.

Fixes: 6e9619499f53 ("f2fs: support in batch fzero in dnode page")
Cc: stable@kernel.org
Reported-by: syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/68e5d698.050a0220.256323.0032.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 685a14309406..1c5f2964649f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1470,7 +1470,8 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		f2fs_set_data_blkaddr(dn);
 	}
 
-	f2fs_update_extent_cache_range(dn, start, 0, index - start);
+	if (index > start)
+		f2fs_update_extent_cache_range(dn, start, 0, index - start);
 
 	return ret;
 }
-- 
2.51.0


