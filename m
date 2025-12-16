Return-Path: <stable+bounces-201746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E686CC379B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7683051D32
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA034F486;
	Tue, 16 Dec 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pW+h9rFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF334F270;
	Tue, 16 Dec 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885652; cv=none; b=i/xOi/snuKRJGfpf5twdPGO1TJbgJ/e+KNgM2YWb4AAYjFRU8O5JdW9q/6RmajmgVNhcq4ynjWqOPXgiUaEAkFHlLhr4x6K+Na5lOZolEEJgFQhgurA2Fm6Nk7m7cGrSgcVit8/H7mJbOdzxtSg/S+sGDSFisAGpl5JeU4rqv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885652; c=relaxed/simple;
	bh=W16Er8FZ4glxsChahzms/ybamlRAa53870Mrh24YcfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDVN+3wLrJvCDSqHgRxvDm8FTvNkTjefGWBU7Q+ReNjN5buO52zVZYa6c3hLQqyk4+dSn1/WR2CElWK3d3+gVNTBDYDC9JZw4i0H0zVo9ioiTla3Q/7/aYvvOX5X78enUEuqaRiE8kgf61YfLqNugweUasKllfLLeKVJ2d1nPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pW+h9rFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C53C4CEF1;
	Tue, 16 Dec 2025 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885652;
	bh=W16Er8FZ4glxsChahzms/ybamlRAa53870Mrh24YcfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pW+h9rFH8gg4uNQHxraKQn5MqY9x9GoaawFdZCjplIQhbaaGafgX5PiFdaT5w98hM
	 SlsvMnmecwuRyCmIG7Bo5/TQuzey7Lidqj2NycyqhGrw1qnfwH2H4lzpvUaaGwaelE
	 AkZSU6oA25uAth+FNH7A5igXIx/TPtV/1kLxVq3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 202/507] ntfs3: init run lock for extend inode
Date: Tue, 16 Dec 2025 12:10:43 +0100
Message-ID: <20251216111352.830570140@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit be99c62ac7e7af514e4b13f83c891a3cccefaa48 ]

After setting the inode mode of $Extend to a regular file, executing the
truncate system call will enter the do_truncate() routine, causing the
run_lock uninitialized error reported by syzbot.

Prior to patch 4e8011ffec79, if the inode mode of $Extend was not set to
a regular file, the do_truncate() routine would not be entered.

Add the run_lock initialization when loading $Extend.

syzbot reported:
INFO: trying to register non-static key.
Call Trace:
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 ntfs_set_size+0x140/0x200 fs/ntfs3/inode.c:860
 ntfs_extend+0x1d9/0x970 fs/ntfs3/file.c:387
 ntfs_setattr+0x2e8/0xbe0 fs/ntfs3/file.c:808

Fixes: 4e8011ffec79 ("ntfs3: pretend $Extend records as regular files")
Reported-by: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bdeb22a4b9a09ab9aa45
Tested-by: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index cf7e869fdc40c..d085bc4370348 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;
-- 
2.51.0




