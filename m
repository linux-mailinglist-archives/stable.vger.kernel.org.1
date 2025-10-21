Return-Path: <stable+bounces-188276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DABF429C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D6718A5A96
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082F1F91F6;
	Tue, 21 Oct 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT6XTCet"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10311C695
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007342; cv=none; b=CjAvQF+RjpGLbs6La4W9887BJAFNQGi3e+tru0m+Extp6HnijPPHdLQ4LB5bELE3ygD2TvMhraHT/pvXjS/gZrM5lRJkodJCFoKmIhH/BCEBklC+uGvm+qSk/9PbGO71d0LbIbRghfsKNrk+fYvye9sUvfppTQ/WztgHt6cYUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007342; c=relaxed/simple;
	bh=h9N8E+vUOXhxu5FnAqA//fMWlLr2ooRuhzrFKSGBJZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKBrC/FmEmFlo8WNrISTSr73m3eOxA15/8dY+r5XggWYLKN2rzHC+AyNNbm6VOsmNi85rRHrQj+/vMtS+v8Z8N/OPVgXcJedb9jsgLW/+WpeLaM8Bm6z35+Mg07WCzPRU23Hv9CPaANi387IzdRt//Tr0xDcq7krGz7bnbgT4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT6XTCet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C6C4CEFB;
	Tue, 21 Oct 2025 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007342;
	bh=h9N8E+vUOXhxu5FnAqA//fMWlLr2ooRuhzrFKSGBJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT6XTCetJkeBKNOEEIIuRGp95a54zJDhMZpg9YDXpIYcxPw0UVfGaHqeDEhU3h1Qd
	 WCW54DPMgLnAkHQXoBWc48DcqkdcO4Ns6vUrMSCCelHTZfjeBXAV8KmNTzfuQmtUQG
	 rcsoq9WCd2DdgJZLn2LS1aED3O1LIbds4uO7bZO+pqHmOA6B3Ld3hziOEYRtyKBX0Y
	 CsYumFcgja4025gemIX8tGvpcBIYqIImubtlX9gQDO6iRdExX0rAz6T95uaWWCPDc6
	 Ro/YE3hYOJ5mpWxFt3AyUCyIgIFhzy8GbI7bz00Paz+I8n6NXJz1kzQDPxZdCb7BoV
	 /+8NpC9L/XJCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] vfs: Don't leak disconnected dentries on umount
Date: Mon, 20 Oct 2025 20:42:20 -0400
Message-ID: <20251021004220.1957034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102040-uninstall-uneatable-a789@gregkh>
References: <2025102040-uninstall-uneatable-a789@gregkh>
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
index 43d75e7ee4785..54208fcef3389 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1836,6 +1836,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
-- 
2.51.0


