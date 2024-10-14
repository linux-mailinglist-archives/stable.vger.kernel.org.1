Return-Path: <stable+bounces-84406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175BF99D006
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7227284C79
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C795D1AB538;
	Mon, 14 Oct 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKJc8/PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858203BBF2;
	Mon, 14 Oct 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917899; cv=none; b=N4OqQLoXEsWtRmd7dp+VGyZSS5GFHXZxQDIVBBT+3fTKxeGGLl3kbwIabQ3/QfDxVHKX0P2hYgyZAs9ebwUKHlNjFz/qtjR8BzspVziPmV4JBrkVOaI8NxQ988el2s2h/EwzppAKs/rt6az31sLVOdcB+kORKpyN1I4q+w4x3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917899; c=relaxed/simple;
	bh=6L4ga1n0xT4taKu9j3HHv4/2CDIrAhePCAzP+FcYxeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Deh+GczeSEB3SVDWseSTN9YueiV/D+JgBquT7rfskSudXk4Gz9tbg5U6hohNCjvgDAkzqk3eCStugZfvXGakV6NLTgawVaO6WlWWCTepFzjqf0IB9IXsQK2mQwRAVqPA/c//lWV+PWRuQvzuvGP/tWsBy15GViyCNFgNpd2Ll6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKJc8/PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD52C4CEC3;
	Mon, 14 Oct 2024 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917899;
	bh=6L4ga1n0xT4taKu9j3HHv4/2CDIrAhePCAzP+FcYxeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKJc8/PLkfptuCm6ubFc3XBs+mGsm4E3Ibdvw179CNSb7M1KIxupELHnU+CjGfSQh
	 4R5PwrtPThRBKZtOkKfVWg0EiKHcFm3t6CMaGimBDLA6/ckpqHHIcPzbFyd+1+IeqR
	 9uJKTxQ6HkJ3kDCxeR1LdylA5gpopwWwGwXUrxBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 167/798] ext4: avoid potential buffer_head leak in __ext4_new_inode()
Date: Mon, 14 Oct 2024 16:12:01 +0200
Message-ID: <20241014141224.488788537@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit 227d31b9214d1b9513383cf6c7180628d4b3b61f ]

If a group is marked EXT4_GROUP_INFO_IBITMAP_CORRUPT after it's inode
bitmap buffer_head was successfully verified, then __ext4_new_inode()
will get a valid inode_bitmap_bh of a corrupted group from
ext4_read_inode_bitmap() in which case inode_bitmap_bh misses a release.
Hnadle "IS_ERR(inode_bitmap_bh)" and group corruption separately like
how ext4_free_inode() does to avoid buffer_head leak.

Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Link: https://patch.msgid.link/20240820132234.2759926-3-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ialloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 14831c3df0cda..99e8852c4e1dd 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1055,12 +1055,13 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		brelse(inode_bitmap_bh);
 		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
 		/* Skip groups with suspicious inode tables */
-		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
-		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
-		    IS_ERR(inode_bitmap_bh)) {
+		if (IS_ERR(inode_bitmap_bh)) {
 			inode_bitmap_bh = NULL;
 			goto next_group;
 		}
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY) &&
+		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+			goto next_group;
 
 repeat_in_this_group:
 		ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &ino);
-- 
2.43.0




