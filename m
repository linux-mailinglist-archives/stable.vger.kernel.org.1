Return-Path: <stable+bounces-133973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F5A928C5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39BC1B6129E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FC259489;
	Thu, 17 Apr 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjXLxHzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF34256C93;
	Thu, 17 Apr 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914706; cv=none; b=MX6P0g66RHkY5VHSDw9B8ZMMT+JlaYJ7eDaA3zR1YlhCKDxSIhAn1ZK8moV4oEBAzakRIOcMmQ4BPyShs2dS/bxXOZbf2ioZ9CKzMnI1DFc/WEeytzKM3qaUVcGNoZttbWVQ9ao8UE/3Ur7RfHbjzyRBe1/XCjtpRIPp9mr/DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914706; c=relaxed/simple;
	bh=BXyWZLqmlqmmDb61wI352U/8NAYU89/9VlPpuBADENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLSBysOgyeGpzCTjlhgPGdg2p9Yq7Gz0QWyC0qaX00p2Nir1pgbSHHvIvPv7p+iQiW/3BJ8qQ4AmqyhIGK5lWQ4rHzEgZI5aQlxZws4kd2z0OTbzEz4fy3nOr3j4u95xpTxg3arlSHBhZ4nRIqEITBJGqeER95zvMRHLsQsgPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjXLxHzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4758C4CEE4;
	Thu, 17 Apr 2025 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914706;
	bh=BXyWZLqmlqmmDb61wI352U/8NAYU89/9VlPpuBADENc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xjXLxHzQ8rDhf8JUt+y0EgLYGy0I7uUtMiRT8IJN6qOkly0WhnSpRzWlH0yb+psyD
	 7igbim2zrcHHWHVkEI0r6uEzuWBXszJznzIGp7U9vuhUMwHFgJoANBlE32RpyQWKMe
	 mFhgQ0eHVSyHcsieuKKQFcF/4AppfssE8dWjMFlU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Artem Sadovnikov <a.sadovnikov@ispras.ru>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.13 277/414] ext4: fix off-by-one error in do_split
Date: Thu, 17 Apr 2025 19:50:35 +0200
Message-ID: <20250417175122.572381507@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Sadovnikov <a.sadovnikov@ispras.ru>

commit 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d upstream.

Syzkaller detected a use-after-free issue in ext4_insert_dentry that was
caused by out-of-bounds access due to incorrect splitting in do_split.

BUG: KASAN: use-after-free in ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
Write of size 251 at addr ffff888074572f14 by task syz-executor335/5847

CPU: 0 UID: 0 PID: 5847 Comm: syz-executor335 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
 add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2154
 make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2351
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
 do_symlinkat+0x222/0x3a0 fs/namei.c:4641
 __do_sys_symlink fs/namei.c:4662 [inline]
 __se_sys_symlink fs/namei.c:4660 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

The following loop is located right above 'if' statement.

for (i = count-1; i >= 0; i--) {
	/* is more than half of this entry in 2nd half of the block? */
	if (size + map[i].size/2 > blocksize/2)
		break;
	size += map[i].size;
	move++;
}

'i' in this case could go down to -1, in which case sum of active entries
wouldn't exceed half the block size, but previous behaviour would also do
split in half if sum would exceed at the very last block, which in case of
having too many long name files in a single block could lead to
out-of-bounds access and following use-after-free.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: stable@vger.kernel.org
Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")
Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250404082804.2567-3-a.sadovnikov@ispras.ru
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1995,7 +1995,7 @@ static struct ext4_dir_entry_2 *do_split
 	 * split it in half by count; each resulting block will have at least
 	 * half the space free.
 	 */
-	if (i > 0)
+	if (i >= 0)
 		split = count - move;
 	else
 		split = count/2;



