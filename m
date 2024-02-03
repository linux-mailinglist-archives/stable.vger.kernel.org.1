Return-Path: <stable+bounces-18384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC3848283
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B571F26B61
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ABF495DC;
	Sat,  3 Feb 2024 04:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CiyCAC0Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4F10A13;
	Sat,  3 Feb 2024 04:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933759; cv=none; b=oqQEKkfwiakignhNG2OOshoq5LY0gWnLHGBNU4KvlRCHrfqxJ0f7Hev5qF9tV253WNKTvLHzmi38wiv5S1WbSEMowVTovhjbNwxytoOxJ+fmZVRII9ROsvwuqLHSecF/vF/xom1Uvirv8pPzOAUqndvCMFACCbx267bA6dpfrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933759; c=relaxed/simple;
	bh=LU/7qkc4qSsMiAbqAjf8jQcy68PZLHIUsQc+S4ZmiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtHPOEuVrFS05uc728Q25pRsqyPTEqdqWtsL5qDHjA03Z/qEXLBh6UPR+Ok+7Y7g03mOMRgljV6+86GouerGUGr4un4Idnoc/FmxzD8v2J2hYklKJEAHlNfjGKy1RQQlW05mp6bsMkkoNf1iO7dkV47RNqnSZVOs6yKFqC/BEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CiyCAC0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EBCC433F1;
	Sat,  3 Feb 2024 04:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933759;
	bh=LU/7qkc4qSsMiAbqAjf8jQcy68PZLHIUsQc+S4ZmiZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiyCAC0QPNfzz3hFq304h8UwvCl3p3/0LbaO15rKKcR4l/iCk0g+TAhHWTAxKJHk5
	 E1aGW8l+sqqS3MXrHbuH12eyvQap3G5a1t4lnyrqsaYd2Febdg+Jv+JtiqZbsQAejG
	 w2tUZkJS5rUY+W6IvyvqOPuYT4Nau8sOezZ5+gJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Osama Muhammad <osmtendev@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
Subject: [PATCH 6.7 031/353] UBSAN: array-index-out-of-bounds in dtSplitRoot
Date: Fri,  2 Feb 2024 20:02:29 -0800
Message-ID: <20240203035404.771693317@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 27e56f59bab5ddafbcfe69ad7a4a6ea1279c1b16 ]

Syzkaller reported the following issue:

oop0: detected capacity change from 0 to 32768

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1971:9
index -2 is out of range for type 'struct dtslot [128]'
CPU: 0 PID: 3613 Comm: syz-executor270 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dtSplitRoot+0x8d8/0x1900 fs/jfs/jfs_dtree.c:1971
 dtSplitUp fs/jfs/jfs_dtree.c:985 [inline]
 dtInsert+0x1189/0x6b80 fs/jfs/jfs_dtree.c:863
 jfs_mkdir+0x757/0xb00 fs/jfs/namei.c:270
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcdc0113fd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb8bc67d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdc0113fd9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007fcdc00d37a0 R08: 0000000000000000 R09: 00007fcdc00d37a0
R10: 00005555559a72c0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>

The issue is caused when the value of fsi becomes less than -1.
The check to break the loop when fsi value becomes -1 is present
but syzbot was able to produce value less than -1 which cause the error.
This patch simply add the change for the values less than 0.

The patch is tested via syzbot.

Reported-and-tested-by: syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d4b1df2e9d4ded6488ec
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..f3d3e8b3f50c 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -1970,7 +1970,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
-- 
2.43.0




