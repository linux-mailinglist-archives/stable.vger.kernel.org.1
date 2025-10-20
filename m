Return-Path: <stable+bounces-188212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C16BF2B6C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE7918A605E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369F3314DE;
	Mon, 20 Oct 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiiCCs5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73537256C7E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981346; cv=none; b=VeH4ojQoRECjCwMZQwM45Zm42AwFBT8+nkCvrSQBt+MpOzdED2syCYaXVCXpzqQDKO1NuXEVpPeYEZsUNB4AU+w9EdyCIBo4cyeAhckagypF+FWAz+Cj7w/RMtBZx5rPmrpni9lAWJ2WZRRD53d2jAKGqb3AGG3FxCcdeEr76cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981346; c=relaxed/simple;
	bh=vXEDTyZpecp0OLhq8E+eHgqjd69iId5OfLVYWpsYI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYwBfKXa0itVRliJM48+z2h9w+rVIZWkBkSeQPqwgRInFbHjhrBsAkWApRKodJyANNC9B3oDjmSqds1pvMAtvV2Y56MHa6/yzSYQA1SVoqhsmr6mTvFeg37sbOgqKCOKj7Wx5kKp0cj8swjHm8JG/Y0r2/KglaXHcd9FGIVUyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiiCCs5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BCFC116B1;
	Mon, 20 Oct 2025 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981343;
	bh=vXEDTyZpecp0OLhq8E+eHgqjd69iId5OfLVYWpsYI0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiiCCs5I75E4gf5b28dLXgDetsGrPoyTsNZ1CnLDxdPwEHG5TpppJxwW+CdkIbkYC
	 t632SwEUO55xTxMt+ZIg25TV5EW0rU57+WsV36eiJGig4ILN2DOJUVj9g4qdH7rKOo
	 CZsksAiqmvGfxV4fzFTXP2ewPFWIbeCBdy3rJuvjfclXcNRLN+efSLhEjGeIDsBuvT
	 xjOzFOAMIOb3xf+kvEOZ+5NCna73mdoTh/mknSH7yusWnKTNNa7tY95vzxphEImAo9
	 2QcJaBHVLv4VbXB0SBfWHCqTIXS1aA0LsQGDBgD2sSVQqOlz19j4XeHwCq6xfriO5s
	 qRSlcGB5qnxSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] vfs: Don't leak disconnected dentries on umount
Date: Mon, 20 Oct 2025 13:28:59 -0400
Message-ID: <20251020172900.1851256-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020172900.1851256-1-sashal@kernel.org>
References: <2025102038-hash-smashing-4b29@gregkh>
 <20251020172900.1851256-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 56094ad3eaa21e6621396cc33811d8f72847a834 ]

When user calls open_by_handle_at() on some inode that is not cached, we
will create disconnected dentry for it. If such dentry is a directory,
exportfs_decode_fh_raw() will then try to connect this dentry to the
dentry tree through reconnect_path(). It may happen for various reasons
(such as corrupted fs or race with rename) that the call to
lookup_one_unlocked() in reconnect_one() will fail to find the dentry we
are trying to reconnect and instead create a new dentry under the
parent. Now this dentry will not be marked as disconnected although the
parent still may well be disconnected (at least in case this
inconsistency happened because the fs is corrupted and .. doesn't point
to the real parent directory). This creates inconsistency in
disconnected flags but AFAICS it was mostly harmless. At least until
commit f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
which removed adding of most disconnected dentries to sb->s_anon list.
Thus after this commit cleanup of disconnected dentries implicitely
relies on the fact that dput() will immediately reclaim such dentries.
However when some leaf dentry isn't marked as disconnected, as in the
scenario described above, the reclaim doesn't happen and the dentries
are "leaked". Memory reclaim can eventually reclaim them but otherwise
they stay in memory and if umount comes first, we hit infamous "Busy
inodes after unmount" bug. Make sure all dentries created under a
disconnected parent are marked as disconnected as well.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Fixes: f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index d81765352cf81..d7814142ba7db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2486,6 +2486,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 retry:
-- 
2.51.0


