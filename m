Return-Path: <stable+bounces-188279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6702BF43A2
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 03:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328344F37F9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFD222564;
	Tue, 21 Oct 2025 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2ACnNU2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43905220F5D
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009083; cv=none; b=Qc6wCC/CFgpr4ToK+hqQ7m6MCgsQR5/4HCKf36MKI60BugGLFZARjraRdrFtSD35MxoL828kYlGLFOsUynzqixrj48wKKCnjmgTptkYtxInIjwAVdYQ+lHtCOF7rJjl5cyioVi0x+BD9qbnJPOnigHsqUfzT/1WkXAbbl8Se80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009083; c=relaxed/simple;
	bh=Ohb57XTT0PPeAsOfOfde1qhjR2LW4fbniN8oeiiygIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJmErvmTLCs7r7ZK5AdGFU/rSH6TrNmFtUj68DSSxim+q9fNxfWiNMCAfbFVQh+uBrtifVVJhMLX1Be21yUukWTu+gnvB9+AtX0OGXuHMqjRKw02Da00ft6uv2Hr3aLPIrfu7WcCwjeW4sw7OSWhe7unLGh1uRemHJsU3lFsbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2ACnNU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17871C4CEFB;
	Tue, 21 Oct 2025 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761009081;
	bh=Ohb57XTT0PPeAsOfOfde1qhjR2LW4fbniN8oeiiygIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2ACnNU2Sm19jvod0iyTCECTsDb54x7NkI9TlBhtxLTFGAgQtpXFwAU7qhGJDF4Z7
	 Po1boK/LagD+2uZLFL+YvPUAr3dCLNgLkHaPA8QJ8jWtPPRdK9yaqq7O8Myse3Yf19
	 e0wlNjtGmCc/Os+GLv+7zFXLtGt56iMd4NahOkVONwPfZgxkrFuaDqCq0Iz71kNsrF
	 Iop77mQkRV5DKcXoBuJz8An1fWVFWeACkd4kn7HGBRGD5buSsUgn7wQcDG2nXF5kko
	 z5lmDRGPgN1sqZ7mNYXvh7RYMkEQaTnqZQG6M3zte30pLiQBtlWCpVBfVEATviwmhk
	 Ic4bcBjFcagKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vfs: Don't leak disconnected dentries on umount
Date: Mon, 20 Oct 2025 21:11:19 -0400
Message-ID: <20251021011119.1965137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102041-bonus-amid-8eda@gregkh>
References: <2025102041-bonus-amid-8eda@gregkh>
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
[ relocated DCACHE_DISCONNECTED propagation from d_alloc_parallel() to d_alloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5febd219fdebf..85fffa3d7ac53 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1801,6 +1801,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
-- 
2.51.0


