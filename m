Return-Path: <stable+bounces-83687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB1399BEA6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F502B2184F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641E160883;
	Mon, 14 Oct 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnCsy1NF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B285715DBBA;
	Mon, 14 Oct 2024 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878307; cv=none; b=PPqm3Ka+v7aYZEWz3zylQHVY6bgTn+G52PL/cSUbb5LTkH6MZAtGnEizeNOkjVQutY3nJsl0qPCs6dfOHwhmC+QlpZrapYMVUGtqgS26XYAx/EFYHyq/b7XPXXCkLnS4eBr/wlPbcztUT5K4K3iIcU5+zEUr+C4PcH2yplgRhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878307; c=relaxed/simple;
	bh=L4qs588DXO3P5ZVLVZ4eJJ6AhKwVt9Z6CGGMiqvOrgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctwd2NkQ6586f4sA2+BaXtZRyNWJlDluncMJe4sqzS+KQloLhVZ7BoSUrItt+QA7pbSe0/rWHEybRb2YO666zXlMRs3hQD71JkWmbZRdfSaL5pXkLctPy9vBJ7BY1H9YdLeYPp/h/WBB5hcbFtwZLT27+iA1oMPOVpuqs+mkLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnCsy1NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB017C4CEC3;
	Mon, 14 Oct 2024 03:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878307;
	bh=L4qs588DXO3P5ZVLVZ4eJJ6AhKwVt9Z6CGGMiqvOrgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnCsy1NFN0VAG165bp+WGsBvEzKHqIciJWtWjc+oRvZIrDAI2/w+Yfg100zrcYEDm
	 B+g87wwYiwu8iMTm43qPstraezD82SmvYtLsudg8wXyLAL5kXt/4Kmt8J2hNkEdC3Q
	 Mq3rOfWLLAY5XVRhaxg09qsdwPYP9JhA6TuLvQzljIhLx1oM13cAf6+UendsxgCSeM
	 Y2Ysnn1uQECYswwBYGk2ufFDkKpjaxELA+I2EoTZgJohZvMiammCWz1kd4Ahv5FXzn
	 yVSkylBeWux12XQiq0IcPMtmxXrlltsiN1rleMk1d6OrtiQo0yC7M2Ug/JbL5voHi2
	 3Xpg8K5ptR0QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 09/17] fs/ntfs3: Additional check in ntfs_file_release
Date: Sun, 13 Oct 2024 23:57:59 -0400
Message-ID: <20241014035815.2247153-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 031d6f608290c847ba6378322d0986d08d1a645a ]

Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index cd69cbd0aaae7..d05c433a55f35 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1171,7 +1171,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	/* If we are last writer on the inode, drop the block reservation. */
 	if (sbi->options->prealloc &&
 	    ((file->f_mode & FMODE_WRITE) &&
-	     atomic_read(&inode->i_writecount) == 1)) {
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
-- 
2.43.0


