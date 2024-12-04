Return-Path: <stable+bounces-98485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99F9E44E9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74D3BC0847
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A2231C9A;
	Wed,  4 Dec 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD7H+vSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A76231C93;
	Wed,  4 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332313; cv=none; b=qgwHRZCOVOscBDyPjvLgNBoWCQqWOv5hjhEp566pFQCFhY5z7oSXCT+QNF/Oek1YOw3BH5LicQuN1+bM3NDXYdkfb/1VvJjJK5Q6KrlR4DDLtwHnOPiyLh7JSe1bG/y4JCaIAFytoJbWCv+38kT0vbubtCiJcac1CnPyY3s0Hek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332313; c=relaxed/simple;
	bh=3pxWEnxr6XMjjy+AhRxPK8q2FLeIUsRi6U5y2ZV0sxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjFzK/ZCsjQGbjaEcOKcl9pqJnNsagtD8cUHO4xL/zsZoA/HFGUY1qoZZd2lofs+8yHVkMvmgi5OXRs62wQSACAWg6tatrbbft3mGO/htHGZAATDPacZPCCm30BP9FWihqwCSaMM8aDXBdgWayMmsFp29rTtnqgHSpgff2wmnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD7H+vSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF68FC4CECD;
	Wed,  4 Dec 2024 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332312;
	bh=3pxWEnxr6XMjjy+AhRxPK8q2FLeIUsRi6U5y2ZV0sxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD7H+vSx9rwCuZ9mk0FQJn0JXsOxFsbunCiF7red3OCmOfOdLXbAD5Lcxkvsb0hJh
	 8uXm6/nVIDADypKNKpAnj5BT5769gsOKTWMcOL16nA8Ug04X2ZEFQ1FNa32ncyu3Hs
	 xzBWhTzsS0tVzQxvxXxjPZ2POTh1drXRT4feevl+WHP9kf2VxjufR69LemPxHJnZKZ
	 9B2XQwUfieL1XC8gi6PLebYvkQd3zOS0ThrOvZ4ePY/ZvmZsY7tPn8aAtzSf7QJl0k
	 UNQd3+iH9LdLzPO6Wh46svD15tm89BXRSUac+ot3AfWmTGhkgAfTKDmmviOQrDVK/b
	 mN48tTEYDohZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 13/15] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
Date: Wed,  4 Dec 2024 11:00:01 -0500
Message-ID: <20241204160010.2216008-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 81520c684ca67aea6a589461a3caebb9b11dcc90 ]

If fs corruption occurs in f2fs_new_node_page(), let's print
more information about corrupted metadata into kernel log.

Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
NULL_ADDR which means nat bitmap and nat entry is inconsistent.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 59b13ff243fa8..601ae810349fe 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1331,7 +1331,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		err = -EFSCORRUPTED;
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+		f2fs_warn_ratelimited(sbi,
+			"f2fs_new_node_page: inconsistent nat entry, "
+			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
+			new_ni.ino, new_ni.nid, new_ni.blk_addr,
+			new_ni.version, new_ni.flag);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
 		goto fail;
 	}
 #endif
-- 
2.43.0


