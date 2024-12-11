Return-Path: <stable+bounces-100698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6699ED4FF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC78164EF9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1A236942;
	Wed, 11 Dec 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFWkbcTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26F23693E;
	Wed, 11 Dec 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943043; cv=none; b=o+9CJBIE/327euowGx5IL+TFe0Qapkeu2ihN47R/aHCIQQMuPUtyVL7nInLRGXa3fPCephVMNUE8MkzfdGF47Rq6KDBe4Ex87maOiFKUn50wYftYOoYNQn2K00wQ7XYZf7S8SaCA4PQ0/UXVEklocHc4hUiUH0WR4phjk0+S9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943043; c=relaxed/simple;
	bh=2vb5YGLHDUV5tJMqDZvDzN+Oziahd/J33DB+9fNplFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DICIp6BfyFyb+0Hqgv3fGKWSuEfo4ZqYaD2SsAmamZbPe0MMzzxGu9yOsOL5CE6zqOpn43XYe3xtpDeHgmzdTfkTwZGdQBSlUP8dWxSfGJ+TB1UKXOnlg2Y7E5rrbo+L5/8bLJg7UJ3GMp+ug4fjvldm6FidhEllmTUO5wYEIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFWkbcTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0655AC4CEDD;
	Wed, 11 Dec 2024 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943042;
	bh=2vb5YGLHDUV5tJMqDZvDzN+Oziahd/J33DB+9fNplFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFWkbcTaJFl2UmwG9o4nLHQDrKb0l6QvWNLJ3C+M8u3xMmPnugxXo+vUptARZQEDY
	 +mI8T8Of0UVVebMNGiDDiLtGnTpAa8zfkTJt3p19BRZBfueBVDpJkpBVn5WINyS7tR
	 CecMx5iepZyLyFYFr3QuFHqmg7p78RKmDmLfvO+K2cgMJECgIJNIZt1o6R1CLq/J2Y
	 Byz6ETTT3rmNNKnFOX8i3foJs7vlzeuyfgMLxs0PUzX2lw+jy99W0hpzL0x79xw2ip
	 3Jtk5+V0eLJCCFvJg3AK/AMuvdJLpPkYsmZzfqdC3qQeeTz76FWggInl2v71Co1mvu
	 6yk2noTW+Js7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.12 08/36] udf: Skip parent dir link count update if corrupted
Date: Wed, 11 Dec 2024 13:49:24 -0500
Message-ID: <20241211185028.3841047-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit c5566903af56dd1abb092f18dcb0c770d6cd8dcb ]

If the parent directory link count is too low (likely directory inode
corruption), just skip updating its link count as if it goes to 0 too
early it can cause unexpected issues.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 78a603129dd58..2be775d30ac10 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -517,7 +517,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 			 inode->i_nlink);
 	clear_nlink(inode);
 	inode->i_size = 0;
-	inode_dec_link_count(dir);
+	if (dir->i_nlink >= 3)
+		inode_dec_link_count(dir);
+	else
+		udf_warn(inode->i_sb, "parent dir link count too low (%u)\n",
+			 dir->i_nlink);
 	udf_add_fid_counter(dir->i_sb, true, -1);
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
-- 
2.43.0


