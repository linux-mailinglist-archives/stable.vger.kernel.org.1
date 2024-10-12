Return-Path: <stable+bounces-83569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5199B40F
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A11F21A3B
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B071F7080;
	Sat, 12 Oct 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEaaTp0y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF21F4FDC;
	Sat, 12 Oct 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732550; cv=none; b=d0d800pbhQsV+GEHguuIoC25SI9NTuL0AWfhKjWIFiehuAMBur7DxeGkmiPWWqsUSFd+So41+B86sGQkjznfDxU+9MDPSQgIdeaUKI9aD6PTVVV7C5MiNVlP4r5nkiLdk1D8zC93dPaa8FZeASqFlWx/TArIHzKx1kcSo6A7ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732550; c=relaxed/simple;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teVxLADTuOjv/b59bZW860Uo+GKoTPRGN60clJjbDHGgLB+iuntfTpCJkXjIL3xFzRWjkCS2vN1etLJ6NUW87/Sf5iMUfc8AGZA+rKD94yl8FdMak3Zb+14T+lVgQlK9o6Eg/LNYVIzd9/ABDFJOGMmXOv8v6rL0eiYAcKz8Uqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEaaTp0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54B0C4CEC6;
	Sat, 12 Oct 2024 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732550;
	bh=mmhBkxJq8mzJIprwJgv8yMGf2dMntwHjpI9DcPhE5V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEaaTp0yCleRppmdn2jstUEKP4xmC+nOPe7ZVrgGLpsLfF3YNpg9QENRHXp7uW3KV
	 P/vE7kFsCXQeucFZPoopNUuCr3eeJcDMzy2pVp3YXvBWh0gaqK5g+NC8KPc2DQu4Sx
	 XN6KcE6ek2lsHL0GW8z+THARe97yoKPugMS5Nm3oafgBY1GlILHPwxxKDmlBpFxNv4
	 j/cF6vCz1WEDPk3vuA+f0rtIoS+lVOoShKTLReuw8QBTZtWeN3vtNeXA0z40JFSTys
	 ju66vPkjh94vYANCU7e8Luisr5rUoZmx64SLfw5Bh9L5b8alcGIDd9lLtASMAs04P0
	 sRDDnk6+FddDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 6/9] Squashfs: sanity check symbolic link size
Date: Sat, 12 Oct 2024 07:28:44 -0400
Message-ID: <20241012112855.1764028-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112855.1764028-1-sashal@kernel.org>
References: <20241012112855.1764028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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


