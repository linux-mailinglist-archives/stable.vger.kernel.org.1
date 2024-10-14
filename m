Return-Path: <stable+bounces-83698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7308D99BEC3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE551C21FC1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BAB145B0B;
	Mon, 14 Oct 2024 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU79CNpw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9519F43A;
	Mon, 14 Oct 2024 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878334; cv=none; b=km/DkMTl6boIm0c1rglp6jf7rgO8JCZkZlpn+zrHU1ZIp4O8slH7vFnvCFcFnZax/UQrVZZYilQnZF/k42B+RYECoVjJFLQ4CUa4fPHQYPE6D2f3xe7SIylOEYQ7fTUIv5VZHeKRTTEOJ/UPsxeoBbEKvsA7CLuiR0KtJ4I28fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878334; c=relaxed/simple;
	bh=9PyrOC4KSgcikUxcFWP7qw6w7ILMmA5X9BdM7egGWOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+5Cz+YRrnB8NpGNv9iny+rYYOyJcnQ58M7Wpo7VmCEDhbYxFQAhILP899E3xW4Iy4R4xe8TZyLIsmAV1ES1z3ou85BIngYCQU3w/0C4R1lzBIsqDwQChdgqJnyiqT7Smkle+ZzXnTSNZdC53i5+GbJbE1n8N3GvB+Fu4Qap+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU79CNpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98DFC4CECE;
	Mon, 14 Oct 2024 03:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878333;
	bh=9PyrOC4KSgcikUxcFWP7qw6w7ILMmA5X9BdM7egGWOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU79CNpwfdtp/xI6BRFDOxeuQ23ohOXoe4W+i3RHKsM9cZyjC6biCde3VZ96DfgCT
	 UCjz/gLS+UHvIdUNqUb5/jBLmIcmJBGnb94j9UqcgMBXTyd05YZO3RhFMjvHmo1GZR
	 UQh4HmdB3B2W+RZh+xxR626RawyHGXY0GFhOun4LD00spTKBevNTMLKzoTr9nbSfCe
	 LZrLMDw5zg4iCi/YtLhlQmNp21YYugpKRQDEVRkdcVHBKFG8e5J/qMcj70jrrghD1c
	 hIKPHKtrwg0sS6BzENr+js+X7Z78huqFd4BqHlgzGprhijwkMxn3XAV8yu614kk4O3
	 AzAQKDAkJElnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 03/10] fs/ntfs3: Stale inode instead of bad
Date: Sun, 13 Oct 2024 23:58:38 -0400
Message-ID: <20241014035848.2247549-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9 ]

Fixed the logic of processing inode with wrong sequence number.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 28cbae3954315..026ed43c06704 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -524,11 +524,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
-- 
2.43.0


