Return-Path: <stable+bounces-187940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDDCBEFC2F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF2189CF31
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0312E3360;
	Mon, 20 Oct 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVh5rbMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF22E2DFB
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947070; cv=none; b=fdOg1WHoEBH5PDcNmvVMMhINgyxNbUITphvdRTTws3729V61/qtuWhSwm2zgpXNcXeAZuNvDw4H7CHIUvPbISrFIu9UdshdCH4Mi7QEmlQoH7WXXyP6qbcb3qak7UNN5l+XXutGCp4rbjnewHnluzgwA7jakhXq23ZGh3dDBHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947070; c=relaxed/simple;
	bh=/KsuW5zW3orAYfKXIqtLOCZwRdpEwleGDvKkWpHJO3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PvB1nDuoFNBVU7oW3JVrcwWPMrNcmDTU5Sl8SCoceunasMIOdRfQOCPCoUkkPwo3Si7Go9NP8UC9Z+P+jOWvVlxZ4NHcCuxppW+35Omz0UUfjhP3QAqv3CXIYk5MlJ3IDyST0L5vi7OZQBZKrADsh7Efv95y5GUAtvFhtL0ROTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVh5rbMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB5FC4CEF9;
	Mon, 20 Oct 2025 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947069;
	bh=/KsuW5zW3orAYfKXIqtLOCZwRdpEwleGDvKkWpHJO3w=;
	h=Subject:To:Cc:From:Date:From;
	b=FVh5rbMBYALE3iUuWXufnlgXpEN0Jre64XKVpXfY9MRIkn1qO50XJ1V6hxlDJcSNc
	 k4J8VFC9v1J2Q0ANjk2ue2NOLcegXNe+LfyuRueN4qmDy7R0KxhX0cAoEdlr5j+FRa
	 351ZZ8rzvzEL5EkPTJ8SDn+JWDcn+qCV8TVpt5s4=
Subject: FAILED: patch "[PATCH] vfs: Don't leak disconnected dentries on umount" failed to apply to 5.15-stable tree
To: jack@suse.cz,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 09:57:40 +0200
Message-ID: <2025102040-uninstall-uneatable-a789@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 56094ad3eaa21e6621396cc33811d8f72847a834
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102040-uninstall-uneatable-a789@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56094ad3eaa21e6621396cc33811d8f72847a834 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 2 Oct 2025 17:55:07 +0200
Subject: [PATCH] vfs: Don't leak disconnected dentries on umount

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

diff --git a/fs/dcache.c b/fs/dcache.c
index a067fa0a965a..035cccbc9276 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2557,6 +2557,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 retry:


