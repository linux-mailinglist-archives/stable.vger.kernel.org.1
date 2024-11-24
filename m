Return-Path: <stable+bounces-95311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023B9D7528
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56019287640
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8381FF7FA;
	Sun, 24 Nov 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu4Evgin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892A1FF7F6;
	Sun, 24 Nov 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456661; cv=none; b=nIhDyTUZknl955fCR+I6fMDpuO5r9IoZdPQTVzVq0o8UR4qEyA2zNHQ3Mm186kFYQddgnBnWSKhl6gbm5Aqq1c9eRf7/n5fb7MN0MyMAk058ygGnaJHh+1pvCbexVcXZ235OVhUpmGo2q56r6l6W06Ke9REj4KcqwAfk1nKon4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456661; c=relaxed/simple;
	bh=fm1dZV3d5q1fcXLnoZP6kTkvH7/sJ9cBIzqjhc6X4t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XumhGK6OuYvh7Tu9VK8ucu++F5aTOyxEe9FDT293Qrzafbv8ljKcr5yk9TOzObe//8hwUj18RQNAwwQB3RZonSrMV4tYeLleONR+gvnfgrJfqWFJQrtUiepMDLVwIli+HikNs+mfXK604QeyEgGVBTU+0pmAlUshAaS9xgD0a7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu4Evgin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A127C4CECC;
	Sun, 24 Nov 2024 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456661;
	bh=fm1dZV3d5q1fcXLnoZP6kTkvH7/sJ9cBIzqjhc6X4t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yu4EvginoKQp1e/66n2HRnaRmw61fd68q7R8l5+x/CFM9YJzDLp8uZ2eS362nyp36
	 Zi+WVdo6Phxa/gVyGTZ5ty8+ixw2Dm+zEg7grMhIloVE0AITPirMUmtSUbdFkDcVe2
	 /qsHKnPCaIfaaDG2cdcn2e7RrHspoWlLBGnksdNYReeMKEWP65GcCnHkiV7n6RFdJU
	 SgJx3WAKBXrjyhqvT6ueFnlSszWOhCJ4Rb63Gmwa9yGePSD+iTp9CvMEZHwx0wwYVT
	 e0/4fgTcX6DM1UfbDXLjKOQ71bsj54rI5cNZDn6Mwdp/T3AV0qjU6xhTABWglVmU6G
	 PLtpKqOEvJDQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 15/21] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Sun, 24 Nov 2024 08:56:48 -0500
Message-ID: <20241124135709.3351371-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit 839f102efb168f02dfdd46717b7c6dddb26b015e ]

The stbl might contain some invalid values. Added a check to
return error code in that case.

Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index a2186b6f274a7..cedbef8045cb9 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3200,6 +3200,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		stbl = DT_GETSTBL(p);
 
 		for (i = index; i < p->header.nextindex; i++) {
+			if (stbl[i] < 0 || stbl[i] > 127) {
+				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+					i, stbl[i], (long)ip->i_ino, (long long)bn);
+				free_page(dirent_buf);
+				DT_PUTPAGE(mp);
+				return -EIO;
+			}
+
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
 			if (((long) jfs_dirent + d->namlen + 1) >
-- 
2.43.0


