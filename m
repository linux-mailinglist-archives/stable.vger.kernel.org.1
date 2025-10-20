Return-Path: <stable+bounces-187937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88535BEFC38
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47FE84EF727
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0032E2DD4;
	Mon, 20 Oct 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tN+6ciS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB319C542
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947061; cv=none; b=ZLULLOGBgH3Zh4JAjMjgjP8vxk/OkzKyFpGCEucBsArUzf0qgjCeYhu8hpcqDI+tgr7u5BakpQlUtv9A+hJSv4Onv9MuOxZbZk2MaDGkkYUSkj3k5cW/3eLUoxO6iCx3eayWGF0fdrZACvvTRHvfYJ6pEjQTlSxXgNSe8nfws/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947061; c=relaxed/simple;
	bh=3wJNvd2XwVxh6zd0AomAqW9G5QlYcnEIn8Jv1SRLE2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sKg+iNN6/17TJCev07MQvEuboUfChCYr3JV3Q6uvjclGUFZ32R9hBQNS8xCIj735kr6Jw8q4futoV3gQLBXfkmB3ClKg6e5O5+VCyViX0qT8NBQguGzwSGgMGGUvwVXtu5Nr+tEG96vw16pwDFZNQOhdaS45Od8KqdQ0inlo5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tN+6ciS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502C2C4CEF9;
	Mon, 20 Oct 2025 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947060;
	bh=3wJNvd2XwVxh6zd0AomAqW9G5QlYcnEIn8Jv1SRLE2c=;
	h=Subject:To:Cc:From:Date:From;
	b=tN+6ciS3X0f2A0rl7WIVQi6D9Hk9IL1ctJLP5tyKYxA0zIuYR+RTssDAJjrejuqJb
	 KbDgJdAFvAxtGYfCC4Hob81rhBlGs+Ny5qDH7gGZCSjrBo21JOXf66gSxomKrcF6O1
	 kip0FUZpq5gbTsag0MX9edWz823OuimKfjgM8e5A=
Subject: FAILED: patch "[PATCH] vfs: Don't leak disconnected dentries on umount" failed to apply to 6.12-stable tree
To: jack@suse.cz,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 09:57:38 +0200
Message-ID: <2025102038-hash-smashing-4b29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 56094ad3eaa21e6621396cc33811d8f72847a834
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102038-hash-smashing-4b29@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


