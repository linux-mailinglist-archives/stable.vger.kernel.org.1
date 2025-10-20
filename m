Return-Path: <stable+bounces-187938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E76BEFC35
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DE03B4931
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090522E336E;
	Mon, 20 Oct 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z4aUbf9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FC2E2DFB
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947064; cv=none; b=d06aHkzzxS77VgtUirxHAHH6g+/DHiTXqfBIDo/CUzXauKhxXiG0v1F2q2PmvCjYasEthnxsu4cZKWpKkylgWe6t6f5IoH/6sRzeysw2jAWuq/Le2CYkIIUMF0d89WseT9ixuoJ/pE67lxHMrhLcBWm0I2r3BAB4+WCxu0+EzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947064; c=relaxed/simple;
	bh=5UooYtEOpKtf/jMu5773Rxz2nrqBx7pN3L04k89wtp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZsAqIqIYfUP76hwYFNiEQo141rl6AplIZt87GpkQeUpDNBuktHAXbWoX/5738utRQIH+jPcf7SpPCNtzOdo5PwP4uaCMONSmPm20b2axaKN0dQD4sWjIONYGNfkdjq0EVkG6xSGU+NMbhNKuFbw+ocBXcv4qLK47DCWERQpBEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z4aUbf9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84CDC4CEF9;
	Mon, 20 Oct 2025 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947064;
	bh=5UooYtEOpKtf/jMu5773Rxz2nrqBx7pN3L04k89wtp8=;
	h=Subject:To:Cc:From:Date:From;
	b=Z4aUbf9twSMhqawqqPvc7H9ehwIWQOwWWBfQjf4E19M/NxtOciVjCzrJcObpKePBb
	 XyIyMldFOqbHkZXd5ezptXqehDNjeBC2UgDWfuWD5tLDPbt3e6DbFcPeDCE3oeJtkP
	 iPOo2iPKlXAyaRst1jUZ9ybewXP7KcHVnwnQAIQ0=
Subject: FAILED: patch "[PATCH] vfs: Don't leak disconnected dentries on umount" failed to apply to 6.6-stable tree
To: jack@suse.cz,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 09:57:38 +0200
Message-ID: <2025102038-pogo-backfire-3d6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 56094ad3eaa21e6621396cc33811d8f72847a834
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102038-pogo-backfire-3d6e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


