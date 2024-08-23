Return-Path: <stable+bounces-70039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643795CF84
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695B01C2265A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7D1AB529;
	Fri, 23 Aug 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnfm4qtG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA61AB51A;
	Fri, 23 Aug 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421960; cv=none; b=tbv1KImkmE5PoODYAz+3reTLWH6RSrpfGA3ETO+TTaN00NfM+w7dUeVzlYbtDp/75LphT5/aFFybOJVTLn6mZOUMn/+ZxhKD5E0OBzb7CSN75xdDnBcruP9GLK1k+Ok1po2oni4XGK2hOmfd6zdSV3Y9EpGm9cblDFrD9J69RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421960; c=relaxed/simple;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH8rEr2e81toh7H7aff8DtIFq/8q+p3umbESIVtVX1VMxagPVr3AEZDbQuI0OhVqCazazE+KyZ2VSSSXRgN1xF8x/5Lbw3/Lr+bOIMfxxz6lVCGzHazknQ4MV2l1phEPIqYwQ+gidKN03O5E+jyerm83nMvTRAZAGWCRQp3JNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnfm4qtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB48DC4AF0F;
	Fri, 23 Aug 2024 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421958;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rnfm4qtGq0kkPpTa/3cwJBQQuWVufKVsd3kz6fdVsDlfaJKFA3EforM/dBTxJEK6p
	 QomT/Un2j+MwDn2IObDsLk/KZJF+RiB3XCLHkWWDm5M1lmWtP/i0s6iz2VK3foMRAl
	 CgvFrBUn1LiOfZFGG5M9/Cj6R7uVAM0sjHgehRpd/AOXO15kV4jJuBAivt4G3nLkAs
	 qQkFVLFe9JiLiPe3WlctLM5tTiOIgvAxx8MYrsHcvFERZu9/NeIc7u8RZqdzG9+6Ab
	 DNIQmziHc34KiHjn901FRTLuZtiEVEKIdYzQMevdjr5Zg/VJ7jks/Rcn8btG2cBHpB
	 xs3Bb2svVhONw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 6/9] Squashfs: sanity check symbolic link size
Date: Fri, 23 Aug 2024 10:05:26 -0400
Message-ID: <20240823140541.1975737-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140541.1975737-1-sashal@kernel.org>
References: <20240823140541.1975737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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


