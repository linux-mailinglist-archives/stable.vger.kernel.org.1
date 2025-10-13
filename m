Return-Path: <stable+bounces-185510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D1BD611E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B2A401DB3
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8676D2DC79E;
	Mon, 13 Oct 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flLaFhsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E392D94A9
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387088; cv=none; b=H47s92Fbx3qagy4SGOYevG2hJyiKgKk3z+CpofQyTXkhn8MwdHGWZNVeANr7Z+aBC00I0OeIa2A8SFf6Z6appsXZMpKvunkUeMK2EpmAC4rjRZT2i+r8JqyCnaQbpg2DbR8GdTxbRJ1M0CXm9npYfd03LAjogd9YRGPq4wTF7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387088; c=relaxed/simple;
	bh=U99zOOjgIIaw1j6ANIlYgzC69zrQoXk1xebwZlR1V/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTAfZTCTdCc9TiZ+AdDv1y682FOGdb/hu9uOM2HiW0y1bdP4SivboCjr5FsutPr6iV73iKLLc8BTNzJ29seFuXyaBML+h8qwibC5ZXCrFPCxqIGRInT2olaBrqNY6QOZ7/kR6UPNglHliLlF+7PtzVpPAocwG38s7dqCu1TGMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flLaFhsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF7FC4CEFE;
	Mon, 13 Oct 2025 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387087;
	bh=U99zOOjgIIaw1j6ANIlYgzC69zrQoXk1xebwZlR1V/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flLaFhsXo67aPfLMNxCrw13aYkrgDVlyrAsmzPtc9ePXuGmdxcB4qpt78hbl9tBw2
	 VMkeRS0+eBOyGuldSMbFYa/+u6EZsjr+XJ4RH6wI2XXDwYaPlUMvl587yxY4EgiEGX
	 Dqa11MHKtOn+aTDFgckHKPwotQcuRVTbrNsGphnQvfgnWzakweGSM27y3bVT9KpEnt
	 AWZCNi7DefUpOy12zeaiEqyELozhg2JcFsQk48ZRGRVbyI+ZyH/Yf3dyJzwPhAR587
	 NFBDBslyTlTRkeCAqpa2QcNXpBY1DVqobmy7aLisiHU6Mus7nHO16seOt8obiwrLV+
	 8HjHM8AO1YGUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com,
	Amir Goldstein <amir73il@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] Squashfs: reject negative file sizes in squashfs_read_inode()
Date: Mon, 13 Oct 2025 16:24:44 -0400
Message-ID: <20251013202444.3589382-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013202444.3589382-1-sashal@kernel.org>
References: <2025101320-sulphate-crafty-c0c4@gregkh>
 <20251013202444.3589382-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Lougher <phillip@squashfs.org.uk>

[ Upstream commit 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b ]

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying Squashfs file
system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

[phillip@squashfs.org.uk: only need to check 64 bit quantity]
  Link: https://lkml.kernel.org/r/20250926222305.110103-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250926215935.107233-1-phillip@squashfs.org.uk
Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/squashfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 77eec1772998b..de8657a77703a 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -192,6 +192,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
-- 
2.51.0


