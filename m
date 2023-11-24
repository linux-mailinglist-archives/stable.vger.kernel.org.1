Return-Path: <stable+bounces-1194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE77F7E76
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054C1B217DD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A433063;
	Fri, 24 Nov 2023 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtW47PK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511D34197;
	Fri, 24 Nov 2023 18:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B553EC433C7;
	Fri, 24 Nov 2023 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850792;
	bh=ainKb1olIA+rVlVjHyb6BlO+KAjmccsr6dfZs52YMOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtW47PK0PcehPh9lVZl0sc4WdNdwedMWQtde24B1pQxyPadZ0xeXdgTUi7Tr3PdbK
	 7YGogTtQ89asRMrml3eDmvbMwZAjoJj2jaw6LjUgG4Lhs1N1XBlz/n2/WS2Eg+vgso
	 0lorSar4c1mDi1k/I+GUGLnvRv9753moaj4vQP1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 166/491] gfs2: Silence "suspicious RCU usage in gfs2_permission" warning
Date: Fri, 24 Nov 2023 17:46:42 +0000
Message-ID: <20231124172029.456785962@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 074d7306a4fe22fcac0b53f699f92757ab1cee99 ]

Commit 0abd1557e21c added rcu_dereference() for dereferencing ip->i_gl
in gfs2_permission.  This now causes lockdep to complain when
gfs2_permission is called in non-RCU context:

    WARNING: suspicious RCU usage in gfs2_permission

Switch to rcu_dereference_check() and check for the MAY_NOT_BLOCK flag
to shut up lockdep when we know that dereferencing ip->i_gl is safe.

Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")
Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 117b4b5a03072..28c3711628805 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1860,6 +1860,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 		    int mask)
 {
+	int may_not_block = mask & MAY_NOT_BLOCK;
 	struct gfs2_inode *ip;
 	struct gfs2_holder i_gh;
 	struct gfs2_glock *gl;
@@ -1867,14 +1868,14 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 
 	gfs2_holder_mark_uninitialized(&i_gh);
 	ip = GFS2_I(inode);
-	gl = rcu_dereference(ip->i_gl);
+	gl = rcu_dereference_check(ip->i_gl, !may_not_block);
 	if (unlikely(!gl)) {
 		/* inode is getting torn down, must be RCU mode */
-		WARN_ON_ONCE(!(mask & MAY_NOT_BLOCK));
+		WARN_ON_ONCE(!may_not_block);
 		return -ECHILD;
         }
 	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
-		if (mask & MAY_NOT_BLOCK)
+		if (may_not_block)
 			return -ECHILD;
 		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 		if (error)
-- 
2.42.0




