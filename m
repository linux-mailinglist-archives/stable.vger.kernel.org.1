Return-Path: <stable+bounces-188264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5268EBF3C98
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 23:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A13F4E68DA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3C2ED866;
	Mon, 20 Oct 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peE+KRLi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35E2EF652
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997088; cv=none; b=ilEc1APe6aYxliGm8TJEBMkXIwrNXVYakSokpl5FYQzPXqxKm7URmOcgwTXhsc+CdyUNXK0RvxL4ia7bUEOfXoY5RAS1+XitfuGzAYMoN90MtnlNY7OpP20WtMzQ8cI3Dk08NosrGwoC/W7gku0t0VTJswjz4RKm9CBKgDaEtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997088; c=relaxed/simple;
	bh=pGZ1x10+/GpMhSTkTmZaQL90Pu2Vsed0cARmOBR2aCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGZWwfArkQRgePBBGhPOzQGtSC13GgSbg8PqUS5/S1+UGvG3QyAcHkg0sNMpD6JaM821JK8ORA2PHijh0Ol14fzHZX1BlU7M+GU4YqBwYYCPUepWx+rYM6Otg8LULcAO+LR1l2klJVTw2mvJPfufOi+07CbH3pKoRjebDXch8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peE+KRLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E99C4CEFB;
	Mon, 20 Oct 2025 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760997088;
	bh=pGZ1x10+/GpMhSTkTmZaQL90Pu2Vsed0cARmOBR2aCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peE+KRLiaBpWfU8ri8DP12orPHZJs6juypfP/bbVp3Z7hxFGeLd5G/Fw8rfnT/6S+
	 VYmP3RRnfkTq6/l9p8ExRNB62fbfqxBSX5NR3kbFs7QzErAtsChuw6Sy+5ABO7DVLW
	 CisDuaf82nVgJ0ymfrzqqoGzZRPMv72/jAU54OwHciRCxUmK8PTz7qjRi4OCUUpxrT
	 obr3oOa54JoU8j+2ChOoDdET8iYCL1zVA54tHTfLg8S+E7EUSctVdvKE2N/WOZmixA
	 Rb1RhS7n4/SqCLmrELuPVJ5UN4ILD2nFDPidsU8wwUv09a6T7Q4XmQPcUm8USb5cm9
	 dbf+j7WpgWPTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vfs: Don't leak disconnected dentries on umount
Date: Mon, 20 Oct 2025 17:51:25 -0400
Message-ID: <20251020215125.1928136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102038-pogo-backfire-3d6e@gregkh>
References: <2025102038-pogo-backfire-3d6e@gregkh>
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
index 4030c010a7682..74d49b2b3b6e2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1861,6 +1861,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
-- 
2.51.0


