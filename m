Return-Path: <stable+bounces-106415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FF9FE83B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2281882ED3
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FEA14F136;
	Mon, 30 Dec 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szbwfLZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7415E8B;
	Mon, 30 Dec 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573898; cv=none; b=IZ9e9OiISx4vjXDHGKdd2EtSM+/MFOZJhUWB/KAlA4+3l4ew8FSWJR2VMGeYPbmqQ+Yru3NO3qOtthR0QwaDbVcdNF+uTJ1o/9mTYB0qBzkqUvk8N+WlIvIJ/Gc2aDZKKjTvhKG1+ZfLwmrxvjGUWtCsEwfhU1o2ciuNFhJvFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573898; c=relaxed/simple;
	bh=+7fmk0dPqndlzcA0IPILOv/oew7/1NwiV4ihiJh2QCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c65xXBaYpR9rQ80QzvmTbkXIOAlY4PnbBvwYtXLcn7EpX1G+b+emrUuAs7+wqAa4YEaKU6Vu53Abh0xjQYxMJV2SLv429Wl6837nEwlwbi0DkV1oeV/qllOcDgIxuFLJeWH2kLA+nBrbYTUQgalc7Hknoa3speZmhOTBQyiwLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szbwfLZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89835C4CED0;
	Mon, 30 Dec 2024 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573898;
	bh=+7fmk0dPqndlzcA0IPILOv/oew7/1NwiV4ihiJh2QCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szbwfLZ1NmC2lQO4rQw5W5wffhjHv5ImzUh7O+2YDerDE8GpUBdgXQE0l+wMOk5PV
	 VIjWxmcQJ5+6MeMiZ5axc+C+fgEOKqroNrE7h82c9CTdpViqBcAJmColAN/E/w3ke5
	 7lLk7QQQDDcqcN1z830LhPNRodRZlbsuf0ETQwt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 36/86] udf: Skip parent dir link count update if corrupted
Date: Mon, 30 Dec 2024 16:42:44 +0100
Message-ID: <20241230154213.093248691@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 605f182da42c..b3f57ad2b869 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -521,7 +521,11 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
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
 	dir->i_mtime = inode_set_ctime_to_ts(dir,
 					     inode_set_ctime_current(inode));
-- 
2.39.5




