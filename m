Return-Path: <stable+bounces-22198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0FC85DAD3
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715771C20BE8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D157F469;
	Wed, 21 Feb 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWtAqRUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9407BB05;
	Wed, 21 Feb 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522405; cv=none; b=rOh3ERVLR8Qv3D3W9tyzrdZrGPVn3pN/F/p0m5RU0kmglVhK0d2859zOHaPaK+/TsMPkqKtpdlfGo+irJTfG6As3ioBouODQBl5Q5JvDFPL5wGG7NsGD3GKvbyGNgv0+ew0iRu++Zquu50TCcq1N/+y0/dE8gD5jXeezZR9wpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522405; c=relaxed/simple;
	bh=CuOco8qf6sJcnKWOupL28jlHzSDKCX9RsCyV8Xch89Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNpWXuZ0cmfgMkdIUodh4I6SUaMP7/oMbLxp9Hy1i0/pJRr14OHtcV09JTllx2yQkymxZUHq6wumfcgKXx7frh1HGsoyxwgVdJoKXsM8aIYLR3Sp8VF0HzQRAbqx/a2uo1iJpXostwulphT+T+suLJSpAfxWD3YXzDd0OVF/Vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWtAqRUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FB7C43390;
	Wed, 21 Feb 2024 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522405;
	bh=CuOco8qf6sJcnKWOupL28jlHzSDKCX9RsCyV8Xch89Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWtAqRUh6v8ZR0VDWSbVmnbnGTshSgX+TnvJQm/glBa2FYmezJ7xXSdrqFpyOPYRO
	 tYFmnNFIBMSnyY89nRAN0ghqTBaW7ABbxpHcDSyrhft1cbtemUORQaBKxx4xrfGdMF
	 xaqlX9blPleiLyGzQ+PcY3l/bzekMcxwWL3F0REY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Subject: [PATCH 5.15 155/476] jfs: fix array-index-out-of-bounds in diNewExt
Date: Wed, 21 Feb 2024 14:03:26 +0100
Message-ID: <20240221130013.654311595@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 49f9637aafa6e63ba686c13cb8549bf5e6920402 ]

[Syz report]
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:2360:2
index -878706688 is out of range for type 'struct iagctl[128]'
CPU: 1 PID: 5065 Comm: syz-executor282 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 diNewExt+0x3cf3/0x4000 fs/jfs/jfs_imap.c:2360
 diAllocExt fs/jfs/jfs_imap.c:1949 [inline]
 diAllocAG+0xbe8/0x1e50 fs/jfs/jfs_imap.c:1666
 diAlloc+0x1d3/0x1760 fs/jfs/jfs_imap.c:1587
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xb90 fs/jfs/namei.c:225
 vfs_mkdir+0x2f1/0x4b0 fs/namei.c:4106
 do_mkdirat+0x264/0x3a0 fs/namei.c:4129
 __do_sys_mkdir fs/namei.c:4149 [inline]
 __se_sys_mkdir fs/namei.c:4147 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4147
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fcb7e6a0b57
Code: ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd83023038 EFLAGS: 00000286 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fcb7e6a0b57
RDX: 00000000000a1020 RSI: 00000000000001ff RDI: 0000000020000140
RBP: 0000000020000140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00007ffd830230d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

[Analysis]
When the agstart is too large, it can cause agno overflow.

[Fix]
After obtaining agno, if the value is invalid, exit the subsequent process.

Reported-and-tested-by: syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Modified the test from agno > MAXAG to agno >= MAXAG based on linux-next
report by kernel test robot (Dan Carpenter).

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_imap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 6ed2e1d4c894..ac42f8ee553f 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2179,6 +2179,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
-- 
2.43.0




