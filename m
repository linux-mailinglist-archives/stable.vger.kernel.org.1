Return-Path: <stable+bounces-128659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA9A7EA61
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A316C3C7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6E25F78E;
	Mon,  7 Apr 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ/8aQcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967825F784;
	Mon,  7 Apr 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049620; cv=none; b=Ou7ylJgUZVhr89ER1TLesIWz/Ar0xws12HWm+m4vsxu9ACBKxAhKH1cY4r0ffIriiO1sINhjuY3vebvVI+3fscfGbxKkUtJUs0V0otx5VaNDD+A04qFW5+JEG1DUa3hM4bCZarQIvpl6vJItQ0DUQPv/fw8UfeOCud6OOn5nC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049620; c=relaxed/simple;
	bh=Isbd/d1mYpd6uw+Lpuzrgoqa9G7IGOlbioYuUgzWeV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lARxfMLj1CRxyCM1BHMIPWFRB8OHcbmlZtzRS/cLeHTzvvzH1AeAvFEXfmmpt9lW4ZuRWbRt/RTQJchmz2gdz3+UyrJcKQ6QYceHuQV6SbFXJsTaOLaATsL8UBRWUUfifNhVu/g6ZsZEdOWutRCnWTkc3esJztveqvUKI0PPOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ/8aQcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB22C4CEE7;
	Mon,  7 Apr 2025 18:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049619;
	bh=Isbd/d1mYpd6uw+Lpuzrgoqa9G7IGOlbioYuUgzWeV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZ/8aQcpa6KW7uhMV8E3ptCBR/Y5j9lR0rGXrtyoD1PWIJnDxMR6/i9Cizz70GSpx
	 mHAjSZ/1rTc3nhgdl17kob8n+cIiHDzw5JySTVl5+2Z69SkgrcCXm4Gjl5B6297Ng5
	 cGykIMIKHGg4nvojxgCbBpQC0u09QJvXt/R+rFsQL6qudplx4aBvIc66cprP4JvFeP
	 LM7fPdaTZsmMeSrLMyf9HQ0csUAYGFiSRXQcimFT3FviT92kEa9IGVkQ7cj8QzTACe
	 awQ0RR/92UOt7j1a3i/mTNJ9qpmfDgvsMiA+VTrdUVXdAwG5+VeK6LKM3ZBXlhyMU8
	 GEUd12APj4xxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+5d0bdc98770e6c55a0fd@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 02/22] fs/ntfs3: Keep write operations atomic
Date: Mon,  7 Apr 2025 14:13:12 -0400
Message-Id: <20250407181333.3182622-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 285cec318bf5a7a6c8ba999b2b6ec96f9a20590f ]

syzbot reported a NULL pointer dereference in __generic_file_write_iter. [1]

Before the write operation is completed, the user executes ioctl[2] to clear
the compress flag of the file, which causes the is_compressed() judgment to
return 0, further causing the program to enter the wrong process and call the
wrong ops ntfs_aops_cmpr, which triggers the null pointer dereference of
write_begin.

Use inode lock to synchronize ioctl and write to avoid this case.

[1]
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011896d000
[0000000000000000] pgd=0800000118b44403, p4d=0800000118b44403, pud=0800000117517403, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6427 Comm: syz-executor347 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : generic_perform_write+0x29c/0x868 mm/filemap.c:4055
sp : ffff80009d4978a0
x29: ffff80009d4979c0 x28: dfff800000000000 x27: ffff80009d497bc8
x26: 0000000000000000 x25: ffff80009d497960 x24: ffff80008ba71c68
x23: 0000000000000000 x22: ffff0000c655dac0 x21: 0000000000001000
x20: 000000000000000c x19: 1ffff00013a92f2c x18: ffff0000e183aa1c
x17: 0004060000000014 x16: ffff800083275834 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000001 x12: ffff0000c655dac0
x11: 0000000000ff0100 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80009d497980 x4 : ffff80009d497960 x3 : 0000000000001000
x2 : 0000000000000000 x1 : ffff0000e183a928 x0 : ffff0000d60b0fc0
Call trace:
 0x0 (P)
 __generic_file_write_iter+0xfc/0x204 mm/filemap.c:4156
 ntfs_file_write_iter+0x54c/0x630 fs/ntfs3/file.c:1267
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x920/0xcf4 fs/read_write.c:679
 ksys_write+0x15c/0x26c fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762

[2]
ioctl$FS_IOC_SETFLAGS(r0, 0x40086602, &(0x7f00000000c0)=0x20)

Reported-by: syzbot+5d0bdc98770e6c55a0fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d0bdc98770e6c55a0fd
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index f704ceef95394..d537b1506dca5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1220,21 +1220,22 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	int err;
 
-	err = check_write_restriction(inode);
-	if (err)
-		return err;
-
-	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
-		return -EOPNOTSUPP;
-	}
-
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 		inode_lock(inode);
 	}
 
+	ret = check_write_restriction(inode);
+	if (ret)
+		goto out;
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
-- 
2.39.5


