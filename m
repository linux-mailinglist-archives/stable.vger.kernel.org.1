Return-Path: <stable+bounces-148821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF65ACA715
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 03:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2CD17C077
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401E32CF7C;
	Sun,  1 Jun 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWqgaJOO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359A32CF77;
	Sun,  1 Jun 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821406; cv=none; b=ZUUetNpipxxi/R4Z241unhi+uNh4Jp5ko+5r5shXvc0R4K1Wr73+i0eFR4eEqw1ID4C+ZaWeI8HvMR5c63m2tpFYIKY+QHWQBHkzh7W0nkGUYWvFzRY7ePFO2e+5g6CCZYfbGM42bs/5VsKGfOEOP78DHIEhKjLTpXUvIKOWe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821406; c=relaxed/simple;
	bh=lx0sLTxwVKT7MceorPuxK8d6JHSF7evmGLh8BNW5m1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7viwbYZJBOEDWHy61y/6alNLR4xMim106k0WOWzNUtRsnPgwil5AJIPxNbPMtWDGNKxgOIcHhW7YPKz/pR9v+yo10d0lthCuhm9oXCzWJXg3DBjtcCzLNw6MGU6agtiP1SzhT5blol5PQ7MnG4D94dCS0tepplmrMTmTejZEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWqgaJOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F34C4CEE7;
	Sun,  1 Jun 2025 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821405;
	bh=lx0sLTxwVKT7MceorPuxK8d6JHSF7evmGLh8BNW5m1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWqgaJOOPrIlfxqvzpnimJZyMkSGIbPQleyKcvnis4/9TbnwKr7UDNQHMztc/fNXC
	 5CM9Yk1LJ2PxNcYjmOJVJAO17SSA2Ez8yMRtseFRTC3TAG1Y/aigITKzsYByK6BWd8
	 qQXI9KxOW5Bz02orUSDJiozEOFVVK/jRb5wbFJZ0UthrC4K6auPTbr9eg2EgzSimTn
	 i8zxBDtB4FH/yL2C+DLermhhfvS+XVoinpQm/IlmC3tViYLAbLjwK0LOFjZzcr38Sr
	 Ts/Pucc5h2f4btQfg3ChhAd/nrvuyZTc5CIkGwgOXZkmEImuifRBAdoQ1WK0qTBNwZ
	 G/BNprVoI7jQQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dylan Wolff <wolffd@comp.nus.edu.sg>,
	Jiacheng Xu <stitch@zju.edu.cn>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 26/43] jfs: Fix null-ptr-deref in jfs_ioc_trim
Date: Sun,  1 Jun 2025 19:42:06 -0400
Message-Id: <20250601234224.3517599-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234224.3517599-1-sashal@kernel.org>
References: <20250601234224.3517599-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Transfer-Encoding: 8bit

From: Dylan Wolff <wolffd@comp.nus.edu.sg>

[ Upstream commit a4685408ff6c3e2af366ad9a7274f45ff3f394ee ]

[ Syzkaller Report ]

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000087: 0000 [#1
KASAN: null-ptr-deref in range [0x0000000000000438-0x000000000000043f]
CPU: 2 UID: 0 PID: 10614 Comm: syz-executor.0 Not tainted
6.13.0-rc6-gfbfd64d25c7a-dirty #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Sched_ext: serialise (enabled+all), task: runnable_at=-30ms
RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
90 82 fe ff 4c 89 ff 31 f6
RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? __die_body+0x61/0xb0
? die_addr+0xb1/0xe0
? exc_general_protection+0x333/0x510
? asm_exc_general_protection+0x26/0x30
? jfs_ioc_trim+0x34b/0x8f0
jfs_ioctl+0x3c8/0x4f0
? __pfx_jfs_ioctl+0x10/0x10
? __pfx_jfs_ioctl+0x10/0x10
__se_sys_ioctl+0x269/0x350
? __pfx___se_sys_ioctl+0x10/0x10
? do_syscall_64+0xfb/0x210
do_syscall_64+0xee/0x210
? syscall_exit_to_user_mode+0x1e0/0x330
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe51f4903ad
Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d
RSP: 002b:00007fe5202250c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe51f5cbf80 RCX: 00007fe51f4903ad
RDX: 0000000020000680 RSI: 00000000c0185879 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe520225640
R13: 000000000000000e R14: 00007fe51f44fca0 R15: 00007fe52021d000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
90 82 fe ff 4c 89 ff 31 f6
RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception

[ Analysis ]

We believe that we have found a concurrency bug in the `fs/jfs` module
that results in a null pointer dereference. There is a closely related
issue which has been fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234

... but, unfortunately, the accepted patch appears to still be
susceptible to a null pointer dereference under some interleavings.

To trigger the bug, we think that `JFS_SBI(ipbmap->i_sb)->bmap` is set
to NULL in `dbFreeBits` and then dereferenced in `jfs_ioc_trim`. This
bug manifests quite rarely under normal circumstances, but is
triggereable from a syz-program.

Reported-and-tested-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg>
Reported-and-tested-by: Jiacheng Xu <stitch@zju.edu.cn>
Signed-off-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg>
Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Code Analysis The commit adds a crucial NULL
pointer check in `jfs_ioc_trim()` function: ```c
down_read(&sb->s_umount); bmp = JFS_SBI(ip->i_sb)->bmap; - if (minlen >
bmp->db_agsize || + if (bmp == NULL || + minlen > bmp->db_agsize ||
start >= bmp->db_mapsize || range->len < sb->s_blocksize) {
up_read(&sb->s_umount); return -EINVAL; } ``` ## Why This Should Be
Backported ### 1. **Critical Bug Fix with Clear User Impact** - **Kernel
Panic**: The bug causes a general protection fault leading to kernel
panic when `bmp` is NULL - **Syzkaller Report**: This is a security-
relevant bug discovered by syzkaller, indicating it's triggerable from
userspace - **Race Condition**: The commit message clearly describes a
concurrency bug where `JFS_SBI(ipbmap->i_sb)->bmap` can be set to NULL
in `dbFreeBits` while being dereferenced in `jfs_ioc_trim` ### 2.
**Minimal and Safe Fix** - **Single Line Addition**: The fix only adds
`bmp == NULL ||` to an existing validation check - **No Architectural
Changes**: No complex logic changes or new features - **Follows Existing
Pattern**: Uses the same error handling path (`return -EINVAL`) already
established - **Proper Cleanup**: Correctly calls
`up_read(&sb->s_umount)` before returning ### 3. **Matches Stable Tree
Criteria** Comparing with the similar commits marked "YES": - **Like
Similar Commit #1 (fm10k)**: Fixes NULL pointer dereference by adding
proper error checking - **Like Similar Commit #2 (ssb)**: Addresses the
same pattern of missing NULL checks leading to crashes - **Like Similar
Commit #3 (bdev)**: Similar NULL pointer protection pattern - **Like
Similar Commit #5 (jfs dtInsert)**: Another JFS fix with similar
validation pattern ### 4. **Related Context Shows Importance** The
related commit `d6c1b3599b2f` ("jfs: Fix uaf in dbFreeBits") addressed a
similar race condition in the same subsystem, but as the commit message
notes: "unfortunately, the accepted patch appears to still be
susceptible to a null pointer dereference under some interleavings." ###
5. **Low Risk Assessment** - **Contained to JFS**: Only affects JFS
filesystem operations - **IOCTL Interface**: Only triggered through
FITRIM ioctl, not normal filesystem operations - **Early Return**: The
fix returns early with a standard error code, preventing further
execution - **No Performance Impact**: The NULL check is minimal
overhead ### 6. **Security Implications** - **Userspace Triggerable**:
The crash can be triggered from userspace via the FITRIM ioctl -
**Denial of Service**: Successful exploitation leads to kernel
panic/system crash - **No Privilege Escalation**: While this is a crash
bug, it demonstrates the importance of proper input validation ##
Conclusion This commit fixes a critical NULL pointer dereference that
causes kernel panics, uses a minimal and safe approach, and follows the
same patterns as other commits successfully backported to stable trees.
The fix addresses a security-relevant bug that can be triggered from
userspace, making it an important candidate for stable backporting.

 fs/jfs/jfs_discard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 5f4b305030ad5..4b660296caf39 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	down_read(&sb->s_umount);
 	bmp = JFS_SBI(ip->i_sb)->bmap;
 
-	if (minlen > bmp->db_agsize ||
+	if (bmp == NULL ||
+	    minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
 	    range->len < sb->s_blocksize) {
 		up_read(&sb->s_umount);
-- 
2.39.5


