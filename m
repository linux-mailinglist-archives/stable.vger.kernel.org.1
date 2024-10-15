Return-Path: <stable+bounces-85374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C899E708
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF9D28502F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAD1E7666;
	Tue, 15 Oct 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioAy4gyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696841E764A;
	Tue, 15 Oct 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992898; cv=none; b=eAl2Ce0jcQXZ4qgxiTqYznZ7xwXnpgv/MK8HPPgFpW2d/4Q6qxwMhkT16aDWWLDaHTvejHi8MiuiQUaFsd+dcc+PcA24gEx8F2y/l0wmXg9mD0Jyd5ObOBtfsuMc/MwRgLonJttxtdGN5MapTRTuSp9mZBJ2NXzgUdpTRsRXIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992898; c=relaxed/simple;
	bh=K5cHNoqjiQarSg32LSUIZ/fFAIm0s+tpChMHrai6psw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G15vNpi2UgX45svHWVzMq8Hobf2xI5OqEDnKMAyULegTWh7oZzBS6F6xloep53YtxU+ZEjOJQ59wnvRfCOcm4nbJ/+3Jc7coYTNN/tzJuWilKjq1OpBIiOjvDiQrhEH47FHP3yO2BK3dWGREPD5AHQGsWJ3K/XMkIRVeZ9c0jKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioAy4gyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4768C4CEC6;
	Tue, 15 Oct 2024 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992898;
	bh=K5cHNoqjiQarSg32LSUIZ/fFAIm0s+tpChMHrai6psw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioAy4gyh093v7A+1GveFG/JKmiLtURxSQlv59ucR9AASQxTCg/iqG9faBZnwz1/Y6
	 1r4FVUwPKeGEr0V7aUignDDRfPIm7BA5bvOZIK/5ujIwF9KGnqwAnsqFhgOYYNMBHm
	 8a30rxKHQHa04Ct20f2vkp8c+S1ybdZ/wpVvcIMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 210/691] nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
Date: Tue, 15 Oct 2024 13:22:38 +0200
Message-ID: <20241015112448.695600494@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

[ Upstream commit 9403001ad65ae4f4c5de368bdda3a0636b51d51a ]

Patch series "nilfs2: fix potential issues with empty b-tree nodes".

This series addresses three potential issues with empty b-tree nodes that
can occur with corrupted filesystem images, including one recently
discovered by syzbot.

This patch (of 3):

If a b-tree is broken on the device, and the b-tree height is greater than
2 (the level of the root node is greater than 1) even if the number of
child nodes of the b-tree root is 0, a NULL pointer dereference occurs in
nilfs_btree_prepare_insert(), which is called from nilfs_btree_insert().

This is because, when the number of child nodes of the b-tree root is 0,
nilfs_btree_do_lookup() does not set the block buffer head in any of
path[x].bp_bh, leaving it as the initial value of NULL, but if the level
of the b-tree root node is greater than 1, nilfs_btree_get_nonroot_node(),
which accesses the buffer memory of path[x].bp_bh, is called.

Fix this issue by adding a check to nilfs_btree_root_broken(), which
performs sanity checks when reading the root node from the device, to
detect this inconsistency.

Thanks to Lizhi Xu for trying to solve the bug and clarifying the cause
early on.

Link: https://lkml.kernel.org/r/20240904081401.16682-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20240902084101.138971-1-lizhi.xu@windriver.com
Link: https://lkml.kernel.org/r/20240904081401.16682-2-konishi.ryusuke@gmail.com
Fixes: 17c76b0104e4 ("nilfs2: B-tree based block mapping")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bff4c7b992038a7409f
Cc: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 8e3d343b9a793..fbb6ec56843f4 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -381,7 +381,8 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 	if (unlikely(level < NILFS_BTREE_LEVEL_NODE_MIN ||
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     nchildren < 0 ||
-		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX)) {
+		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX ||
+		     (nchildren == 0 && level > NILFS_BTREE_LEVEL_NODE_MIN))) {
 		nilfs_crit(inode->i_sb,
 			   "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
 			   inode->i_ino, level, flags, nchildren);
-- 
2.43.0




