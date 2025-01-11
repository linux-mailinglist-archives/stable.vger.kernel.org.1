Return-Path: <stable+bounces-108278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE6A0A4B6
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09BC1888025
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967FD19342F;
	Sat, 11 Jan 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fTqa6Uig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED51474DA
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612359; cv=none; b=OOOurLRJ9vaOVaGg/Z/2K/5lG5AO+Z5Hvdqrw5VOL3zxevKxnO/zfdfLxR6laq2rFu4v1NhThx0MUlcdorJ1D4rzM/oh1VY+WOjy33VQ753oTk32FmNxRCqsjw+cGvyE7DGTSiNVfV8mHSLB3gfKJSqVD8xrnkzzkxLoC3u78R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612359; c=relaxed/simple;
	bh=aiq0cq5S3aaE29DlgjcgiPAxHa5+x3n7rx33Mrdl614=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q4FafQiNeIJ4NTqFaqRaVNfwo11MDV/R86kSsM+4Q18sssCLqXIdeBxXmiqO7XrVYzTTluP/N8253fzAMZ94yClc3NCxa4Iw0/DUVFEDzgbXstKeoNDF9jp4FFilOkYoPGpmhRIiy9UT4Zb6X3pCc3s0JDhdeiQ9CqLcM6oOJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fTqa6Uig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CCEC4CED2;
	Sat, 11 Jan 2025 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736612359;
	bh=aiq0cq5S3aaE29DlgjcgiPAxHa5+x3n7rx33Mrdl614=;
	h=Subject:To:Cc:From:Date:From;
	b=fTqa6UiguiddcbD+Mqn1yISchLL6wsOkKziMyXhtLcXz2wbvWCdt3gwmhE1Me/BeN
	 LluE1EdKMt1Bj8/iGyxvRYy9Doh7Znif0Fpl79Dp4HwSz0C7YZGzmI0hmycpg5j54F
	 Wg/aQoCeiD0ukGPUdPF7ksBseobV5419UWDfll5Y=
Subject: FAILED: patch "[PATCH] fs: relax assertions on failure to encode file handles" failed to apply to 6.1-stable tree
To: amir73il@gmail.com,brauner@kernel.org,dima@arista.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 11 Jan 2025 17:19:13 +0100
Message-ID: <2025011112-racing-handbrake-a317@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 974e3fe0ac61de85015bbe5a4990cf4127b304b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011112-racing-handbrake-a317@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 974e3fe0ac61de85015bbe5a4990cf4127b304b2 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Dec 2024 12:53:01 +0100
Subject: [PATCH] fs: relax assertions on failure to encode file handles

Encoding file handles is usually performed by a filesystem >encode_fh()
method that may fail for various reasons.

The legacy users of exportfs_encode_fh(), namely, nfsd and
name_to_handle_at(2) syscall are ready to cope with the possibility
of failure to encode a file handle.

There are a few other users of exportfs_encode_{fh,fid}() that
currently have a WARN_ON() assertion when ->encode_fh() fails.
Relax those assertions because they are wrong.

The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
encoding non-decodable file handles") in v6.6 as the regressing commit,
but this is not accurate.

The aforementioned commit only increases the chances of the assertion
and allows triggering the assertion with the reproducer using overlayfs,
inotify and drop_caches.

Triggering this assertion was always possible with other filesystems and
other reasons of ->encode_fh() failures and more particularly, it was
also possible with the exact same reproducer using overlayfs that is
mounted with options index=on,nfs_export=on also on kernels < v6.6.
Therefore, I am not listing the aforementioned commit as a Fixes commit.

Backport hint: this patch will have a trivial conflict applying to
v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index dec553034027..e933f9c65d90 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -47,10 +47,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f->handle_bytes >> 2;
 
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f->handle_type = ret;
 	f->handle_bytes = size * sizeof(u32);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 3601ddfeddc2..56eee9f23ea9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -442,9 +442,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;


