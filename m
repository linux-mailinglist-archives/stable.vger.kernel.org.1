Return-Path: <stable+bounces-51107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B473906E5E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472301C22C32
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94381459FD;
	Thu, 13 Jun 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZ+AUG1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCC145359;
	Thu, 13 Jun 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280329; cv=none; b=Y80UjDXMu3myU5HbvUtZFBafZU/YpTdXmKjHpiw077Fo4VdQYgoz0jLUzPLmk15/K4LjE1q+ZmLpSXQ1DXxsbvQgF/hC+9zMXmEkEOYQu3uwCzg8Htr5lhSlrBb5ptEQZAX4yYdob0CQNkdPPcqG9T3VxhdJJX/fr1I6SlvkEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280329; c=relaxed/simple;
	bh=LIRuiCLE60n0FY3jWAILyiFyjeswZfE7d+ArU7tAWpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMa57+tL3tCSVH+KbPoMSnmynnAwQIyeh0IA7z+jU27PqWDD06/HVD1wFxt9ANs9uApwPNgrLK68Pe0vqbSLCD86lzRJgjyi6jMrVTdfy+UKT2/TOMYrcD9AfDWQipAy+CXEvAI83jAKePWoh6DHKYB9rA4wKuJ+n6jprTUqqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZ+AUG1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F22C2BBFC;
	Thu, 13 Jun 2024 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280329;
	bh=LIRuiCLE60n0FY3jWAILyiFyjeswZfE7d+ArU7tAWpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZ+AUG1W5PVuXd1C8BiCqV0nt7dDIyQC/3XGEnM6tufGiW3meuHQZD35aGcRPStLT
	 4OHoACtSyeQtLYC61d+zQNioOuvrYzSbeMuREKIZLo1QSSitNobhmUt6Q7tU2tZi0p
	 zQBFYAPGQr4rHRKEMlcxa71TiFxHu1NnQFr1rPiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Subject: [PATCH 6.6 017/137] f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()
Date: Thu, 13 Jun 2024 13:33:17 +0200
Message-ID: <20240613113223.959264270@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

commit 20faaf30e55522bba2b56d9c46689233205d7717 upstream.

syzbot reports a kernel bug as below:

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
==================================================================
BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076

CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
 f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
 f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is we missed to do sanity check on i_xattr_nid during
f2fs_iget(), so that in fiemap() path, current_nat_addr() will access
nat_bitmap w/ offset from invalid i_xattr_nid, result in triggering
kasan bug report, fix it.

Reported-and-tested-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000094036c0616e72a1d@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -361,6 +361,12 @@ static bool sanity_check_inode(struct in
 		return false;
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 



