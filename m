Return-Path: <stable+bounces-83667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18F99BE74
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A504FB20BA0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECD1482FE;
	Mon, 14 Oct 2024 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0PdBrDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C39146D6F;
	Mon, 14 Oct 2024 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878264; cv=none; b=ZI49hiv7yXzvjVyJ0CxQpX8Aq0s5ftkZJy5KMVHb4wcuzAViwqKlsYN7iVO2HwAJ3nAW3d1clfgR9hvAywoUAtmEA7dPvJS5avviJDF4KlqOeY1HHYiVmiAwfdsKrCHZY7xqJ8OdbPA/cwbwaCoA8tXhe1n8OuQCDZzr7GbvDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878264; c=relaxed/simple;
	bh=lUWQQJPfXdtrCatThLeQQQCMwuosa/nkq8KTKWbnBQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPguw/2dXTGULOmOb0d9/i1LrszCY4tatfNeQGhk3u+byhupC/UldQClLQK12AnyoUFzgRxoZCWzYTVlw4lYCUuD/G1OYvpZPCzJxfHBtl/tNxZzHU6J84Wq9sqVhgK8bhdt9mvTUwni03YozX6xiyWR8DlLdHW/c09oe/bQpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0PdBrDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58B9C4CECE;
	Mon, 14 Oct 2024 03:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878264;
	bh=lUWQQJPfXdtrCatThLeQQQCMwuosa/nkq8KTKWbnBQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0PdBrDcH7SXVm954aXvyiLcu7oaoxU8eSkhhRvRRkIRBtj13MNJLI+7lywi6WHtN
	 ZQaMenP4Q1ztk2GCv2a6yUJBejrGAqivA4Ta1PCRIafWkoDpERYCVZvd3HdsJ38XTy
	 4BJsMiNJLnzoVmMgK00DPEObOAkzByGegZAM/KMauTkYSCs34TtS3BK1hY+JyVj+gX
	 eqL2pRkBPW93mcBsi0hjAq6fDJ1XzQ+dpK1mdKJjJTly7H6Bac8PT5fClEzfoCDPwP
	 zGXmQbVVvTIs9dbsOLU3A2sI/zf6tbbjYaufLUjESouI/nnmGdhmjBbtFPvUHn/bt8
	 eKD6P8fyXbq7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 09/20] fs/ntfs3: Additional check in ntfs_file_release
Date: Sun, 13 Oct 2024 23:57:11 -0400
Message-ID: <20241014035731.2246632-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index ca1ddc46bd866..1ddd17b0c8a41 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1247,7 +1247,14 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
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


