Return-Path: <stable+bounces-70021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB595CF61
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41953B25593
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D371A01CE;
	Fri, 23 Aug 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsIKRT3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A321A01C8;
	Fri, 23 Aug 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421892; cv=none; b=nVCjPiKYwnLhE2t/KotExs0WNSzzceMDAlK9r11/RyOrPh4UyMj4D1wehezgtB5GHKAmUxd6ObPMVV7TlxikKB3bXs4V8wxnQpQp4i4jhV8KkBSYU8qd22uWHukEieQqEBO/idBPWpLBVl/i891KKEDOonS8zf2scZEA3qNM/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421892; c=relaxed/simple;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqcZSfRzLf0X+scga60pmj9kptx4+XyLc8rpq/LRbkPqgHxY+2/AwyZ8XjnTrLd/qcYCokWXMDXunKC4bjRjwxErjFVhxD7uae9fhPm7OyMQAm+BI8nHxiVbbdStykpt7LQbkdAcOCch82wotbxwD7/ntiGeLfwhpkKPudMb6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsIKRT3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62B8C4AF0E;
	Fri, 23 Aug 2024 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421891;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsIKRT3cGo40SEzhFiYSiIe7f6VkFO42NxDhblYRv5g+f8i/WiawQTNP/RoC4sy3O
	 cFPPZosVxm60Xm8YSmgzpbQ+50e9dzBBR60EGxrUJXbuULkz8TlaB8NEQgCEaJVF0p
	 scoUpx9oRXipVTjsFU7KeuJCSxJtmwtnMwytNinEvwXBt75aEXVbEWB051XtzPzvdq
	 9VmRR9hHaV5lSzMK6WJ/8X62SjRTNoTsMFpfOa3n6dOlzU6x/W5LSYkM8/9gOSEGnL
	 Gbc/+AnlKyn+6T0ZIaTdP/vmQWdd/Ivp8MUZFOnnywZKACZQu0zkrJTJxGR+RxbOXd
	 c8RdieR3/3Wyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 10/13] Squashfs: sanity check symbolic link size
Date: Fri, 23 Aug 2024 10:03:59 -0400
Message-ID: <20240823140425.1975208-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
Content-Transfer-Encoding: 8bit

From: Phillip Lougher <phillip@squashfs.org.uk>

[ Upstream commit 810ee43d9cd245d138a2733d87a24858a23f577d ]

Syzkiller reports a "KMSAN: uninit-value in pick_link" bug.

This is caused by an uninitialised page, which is ultimately caused
by a corrupted symbolic link size read from disk.

The reason why the corrupted symlink size causes an uninitialised
page is due to the following sequence of events:

1. squashfs_read_inode() is called to read the symbolic
   link from disk.  This assigns the corrupted value
   3875536935 to inode->i_size.

2. Later squashfs_symlink_read_folio() is called, which assigns
   this corrupted value to the length variable, which being a
   signed int, overflows producing a negative number.

3. The following loop that fills in the page contents checks that
   the copied bytes is less than length, which being negative means
   the loop is skipped, producing an uninitialised page.

This patch adds a sanity check which checks that the symbolic
link size is not larger than expected.

--

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Link: https://lore.kernel.org/r/20240811232821.13903-1-phillip@squashfs.org.uk
Reported-by: Lizhi Xu <lizhi.xu@windriver.com>
Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a90e8c061e86a76b@google.com/
V2: fix spelling mistake.
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/squashfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 24463145b3513..f31649080a881 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -276,8 +276,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (inode->i_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
-- 
2.43.0


