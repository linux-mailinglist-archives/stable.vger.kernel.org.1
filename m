Return-Path: <stable+bounces-83593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F5A99B47D
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253971F260D2
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0449208963;
	Sat, 12 Oct 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7BS3vqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52F20823D;
	Sat, 12 Oct 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732622; cv=none; b=CaPt0eG2fpBZXduY9vaxHfemyNCdipJWje1oWtjdzyiOO1OAiA7jIZelfohl+PyCwnI9zOKBsT9VzMP1IkzJ8qrHAf9s8AOzFCDRIN4la+Rhk4npHZCmbLmaQoZgihhj48IiLffOaf/NfgxjDbLvx/UNe/UFLr5C9f3MxoYz9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732622; c=relaxed/simple;
	bh=MN7u8tGEjpoxeEYLXqFBL/ktRmGnrAIKHSIM85jOWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgxYBidflC6uFCTtg29eBy9cYYz++nBT/hQ+Q46NJI27yetlfxuS6cvTbgj8WHWuPPyZ71rGpIYbCxr5yzCzqxsaw19hF7/TN8Jnqo3Rb23fYBqdf/Wf93TAB7KLffQe1+d0XKzCUuN+bmZ3+p9N7eqRQQAXgTe21b8TuRZ2lOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7BS3vqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0458EC4CEC6;
	Sat, 12 Oct 2024 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732621;
	bh=MN7u8tGEjpoxeEYLXqFBL/ktRmGnrAIKHSIM85jOWSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7BS3vqZXDMRRyhe3rL1lDKxMrcdZb1GD0fg9PtEz513eo/mLq/jDv+346XkMPVYQ
	 D/fMgA6YxSAVPCGqQmgEVsSN6gefB1FMjLDgVkFGo9p4XiHmHO5nELjIZFstyLxO2w
	 NefX/eESwVhhKmMB4nPuy/eXgjXpp+NOAxf6k4ZCe6QW4G62MhvXLSQ+jhbngulxPj
	 ffPx02cl1n1UuoIT4PlCgcZNdYoIvWB74IB7DWYY01TbLgwuJwgkGCSsqTvxFwU7GR
	 ZhrBMoUg++F6yM64/AJEVTIhygWW3RHqXLGWJ0mvy/VLEg+fEnN8L2yk43U1liffe+
	 hnrb6JWl7WKmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 5/6] Squashfs: sanity check symbolic link size
Date: Sat, 12 Oct 2024 07:30:02 -0400
Message-ID: <20241012113009.1764620-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012113009.1764620-1-sashal@kernel.org>
References: <20241012113009.1764620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index e9793b1e49a56..89ac1c6de97bf 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -289,8 +289,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
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


