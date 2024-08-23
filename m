Return-Path: <stable+bounces-70030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4B95CF6B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235941F2ABC5
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11611A3BA3;
	Fri, 23 Aug 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqGJnJqe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02718EFF3;
	Fri, 23 Aug 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421925; cv=none; b=TdqUn4rPjKDiGklWBC2Yd9+jMM0/NA+SPgmB8rYeEuIndhjlOFFhtlXsar/ptPF5I4rL2w7dmI5Tw+wSvNs2ELh/KQX21VZuupQ0G4xtYEXQge9QTBPmVXJG8DWFwxaCYWIUzpanoTJIQHz3MqNVIL5N+NuAmeji/ja+9K9orLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421925; c=relaxed/simple;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOSLVPfAaPPdr+CQnqO0WB2QPf+abRR2ElTq0k8L2ecjF/dtBrWHhMNh9xZLKE+dl7Ag8lLiUBcDXn9AvHhxD5i8cLTLAQeYD43TaxZkjzPuXJACG4zsgm2Tl1LVe/sbLpq2HO0jo4PltRM21FzzJAuIQbSpYliSyuma4n+//UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqGJnJqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1CBC4AF09;
	Fri, 23 Aug 2024 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421925;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqGJnJqeQrnwmBAIlgK+iz1Abd59tTmr5nHV9D7z3l+Lf3iHvBxTsZBW4JTQzcXRc
	 UPct2T1yNdvNeODhBSup8mfukwD0U1bbXmVQ4p3RAunFUovdYrF4cQor/Q3/Hv54K3
	 XzBgTfeJ4A6f83PpCIVB/7IIlcZRn5Y4NhnP6KYzzrxusWteBLeFMdxm7XueXKHfBN
	 vgIbCoZGY9NKNrta/5LDhsHnF1HP4ItxGVZkPSR0xpf6QFzTKO93w7luwVK8AM3aDq
	 74uvbTQFlPf3YZZrQBIkDdiay4gGBoui+WHavc7QLmevbcY1IKPmhjIole5XznJG8h
	 hU5nClbDsiLfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 6/9] Squashfs: sanity check symbolic link size
Date: Fri, 23 Aug 2024 10:04:53 -0400
Message-ID: <20240823140507.1975524-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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


