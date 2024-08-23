Return-Path: <stable+bounces-69984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA5A95CED1
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F38B1C2407A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9F1922E0;
	Fri, 23 Aug 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJrTNm8X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743A1922D5;
	Fri, 23 Aug 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421736; cv=none; b=f9xz9wt2Ctay3qjcDch+4SrjAR35I2WPko1eGzRnC7HfZc2YpcRzqAWXtq8AOugwFmdJOQpCqUtvJu9+haYvDw6hyemcR9ztG2LaZfXWAAcdzNRRzLcs0g8RjBU60Wb78vPE2UmaoHkqyj/gFaP+YBT6/IDAZyyIqxp4xB+p+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421736; c=relaxed/simple;
	bh=hmI+p+zix87iEg319YNt7pc0rEvuw4ysuuicqIM28uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFxwHydRxLJuFCD9OsYYa/Hp9QgMqRDlBcovdtxlbJQZ5wICrjcqSuD/M4z2sZQvNGdTBViJJU4I62s9anQwGlwnLbBntYPZ/aCsbJdlLxJUarqb455fXPHpqR797DmHkOvQoOo8WlUsl3bQdIa1lGVvloFXxOlMMufgQopY6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJrTNm8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B65C4AF0B;
	Fri, 23 Aug 2024 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421735;
	bh=hmI+p+zix87iEg319YNt7pc0rEvuw4ysuuicqIM28uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJrTNm8XjefKU+BLcYalxGRsDZ6fuOjn1h8+90hF5xNB0yLDEvaW3x8XJKnOd6Ip9
	 647UrBDO/OJtqeJnmGRcUajyBw8VD3j1cY5B1qlqkeZrugQ6JhZ+QEphweL3ZTV8Jt
	 P0D4jCXurY8o53xZrIiYK2nXAVDKWKq0UrqJ2QHzao5H+1fo5qRMO84KCgFhOrWVec
	 XH5uk+UjS9FFaN/a5mQiXhy86xHGo0FWOgmVvTB4cOzWeOeft6NW84rfzhhJFXSsOU
	 X9tAbJYTB/5waFNZx21q+gpPvwNArh2SQEliAMTwkA8488i6v0le+LQDXEuTBA3iQz
	 f6l6FrhdisZjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 17/24] Squashfs: sanity check symbolic link size
Date: Fri, 23 Aug 2024 10:00:39 -0400
Message-ID: <20240823140121.1974012-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index 16bd693d0b3aa..d5918eba27e37 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -279,8 +279,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
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


