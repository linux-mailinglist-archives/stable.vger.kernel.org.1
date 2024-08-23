Return-Path: <stable+bounces-70054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A178A95CFB6
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD081F251A3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDBD1B151A;
	Fri, 23 Aug 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxqs362N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98071B1503;
	Fri, 23 Aug 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422010; cv=none; b=Y1tHR3WjOI97wbFN7yKs7yxsYsY/f/hrKY1zLyVN1GbZLVEJTFxYaW+YqqOw1qdy/KJwzO1UwdKpNrPjZ7Wrzu+SyUcPMVx043rmfWuyTcM1DBvNRHaAvD46hJT2YAxNU9jTjrYy6MWlydEwm0BVqK1spj7fSghEbVprMIXX5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422010; c=relaxed/simple;
	bh=MN7u8tGEjpoxeEYLXqFBL/ktRmGnrAIKHSIM85jOWSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUTW0PKHfMlzfYJvuLnAvo2q5zlKm2Wk3dmF7Bt3s6B8cxAIK07P+dEX/g59DlwX0J2xDqO0AYJSNN1UihsKTWpZvGUIJCDDiapWrUEB8Bi2E7j9yd+t6+gvcdeMK4dwJ+7DLQ/tmee7nHv6mMPhvNPZ4NPiiK4nEe7vmU1h6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxqs362N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80AC4AF0E;
	Fri, 23 Aug 2024 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724422009;
	bh=MN7u8tGEjpoxeEYLXqFBL/ktRmGnrAIKHSIM85jOWSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxqs362Nsu+cCVJL0kH2brS56acKW5iTDcylV9GZ3A5sRxWT8VSj6MgksaoLcd+Wu
	 euu3IW6dZqxRjrCt2WgEKX0xGwn6HwsA8hcvLosLOcu2uCaKkvULSakV2xIBRAkEwz
	 VxtombwXPGvm9G9A1osuFLPoB+Nhyi087BZO4QYYAbd3UVMZeopucR7dNRGkBldBpU
	 qxLwzag5LMppGDsmzUtkcQI1UzsVimo4rveVOzXlNvih1FMSd995QdBrJLpmys+e91
	 eqijDeIFGNRU2l+gRo36UhrKp2kxMkYINj4lFUjkczAdU8Rs6rNcDaMSuU+S2aCz0G
	 Rtuh2on3GzE1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 5/6] Squashfs: sanity check symbolic link size
Date: Fri, 23 Aug 2024 10:06:26 -0400
Message-ID: <20240823140636.1976114-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140636.1976114-1-sashal@kernel.org>
References: <20240823140636.1976114-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
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


