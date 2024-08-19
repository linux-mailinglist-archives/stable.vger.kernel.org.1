Return-Path: <stable+bounces-69489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754B956716
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224BBB22699
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEE15EFAF;
	Mon, 19 Aug 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ZwutRr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DEB15ECFD
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059891; cv=none; b=FZOTAnpuxkqf6BnTu4RySUhVCj+ks1Fg75nDyCMW+APM++iv4H6UEFsACKmTsRO23VV9r8cPmi9OgcCjBV9BSpCWAlI0OMtrAl2EaUAi+qGdykMbK+BHmyAbvmsO3KYRTY1+Fdh3ic96HQfJ5gvH04Svnp8OW/dJl7tYTCJxjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059891; c=relaxed/simple;
	bh=YpaWZbi0RLxAdwWZlJ4U/ylT/TM8xlqkb65KMqbdE1I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mj+rhQZI8n3Q+xLsMeCHKl+64ZuPA7sV/zoTm5y0gIipwxBGzY4hc3cOJjD7R81gV/JrsWw+Jjjt6AhmNhmTjtPYAbjICfvF6BnxH5E8uQtFmlKEhTf/W/Y2IWkXRSeP4A27uxY4gWGGf8Wn2Mj63fFc9tC9Tp2+2w9hCsLvbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ZwutRr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7CC4AF0C;
	Mon, 19 Aug 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724059891;
	bh=YpaWZbi0RLxAdwWZlJ4U/ylT/TM8xlqkb65KMqbdE1I=;
	h=Subject:To:Cc:From:Date:From;
	b=0ZwutRr80NxkchoAgHefD1Qv2n76D03IVIKoC9/5jQZvPaIf8jyL6bF+mK1PLW2yE
	 NEjK36pd5I3KziC8snrkbpWYbw7x4FXTEvtL9scxaZtBQFmypWQH5ds8jJewVRkKO1
	 KnTOJD75ZUB9VXlaZ+26NO8RZPIp6FqwvJFsam+g=
Subject: FAILED: patch "[PATCH] smb3: fix lock breakage for cached writes" failed to apply to 4.19-stable tree
To: stfrench@microsoft.com,dhowells@redhat.com,kevin.ottens@enioka.com,piastryyy@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:31:15 +0200
Message-ID: <2024081915-antitoxic-kennel-6f2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 836bb3268db405cf9021496ac4dbc26d3e4758fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081915-antitoxic-kennel-6f2e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

836bb3268db4 ("smb3: fix lock breakage for cached writes")
3ee1a1fc3981 ("cifs: Cut over to using netfslib")
69c3c023af25 ("cifs: Implement netfslib hooks")
edea94a69730 ("cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs")
1a5b4edd97ce ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
ab58fbdeebc7 ("cifs: Use more fields from netfs_io_subrequest")
a975a2f22cdc ("cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest")
753b67eb630d ("cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest")
0f7c0f3f5150 ("cifs: Use alternative invalidation to using launder_folio")
2e9d7e4b984a ("mm: Remove the PG_fscache alias for PG_private_2")
2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
f3dc1bdb6b0b ("cifs: Fix writeback data corruption")
d1bba17e20d5 ("Merge tag '6.8-rc1-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 836bb3268db405cf9021496ac4dbc26d3e4758fe Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 15 Aug 2024 14:03:43 -0500
Subject: [PATCH] smb3: fix lock breakage for cached writes

Mandatory locking is enforced for cached writes, which violates
default posix semantics, and also it is enforced inconsistently.
This apparently breaks recent versions of libreoffice, but can
also be demonstrated by opening a file twice from the same
client, locking it from handle one and writing to it from
handle two (which fails, returning EACCES).

Since there was already a mount option "forcemandatorylock"
(which defaults to off), with this change only when the user
intentionally specifies "forcemandatorylock" on mount will we
break posix semantics on write to a locked range (ie we will
only fail the write in this case, if the user mounts with
"forcemandatorylock").

Fixes: 85160e03a79e ("CIFS: Implement caching mechanism for mandatory brlocks")
Cc: stable@vger.kernel.org
Cc: Pavel Shilovsky <piastryyy@gmail.com>
Reported-by: abartlet@samba.org
Reported-by: Kevin Ottens <kevin.ottens@enioka.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 45459af5044d..06a0667f8ff2 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2753,6 +2753,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file->f_mapping->host;
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct TCP_Server_Info *server = tlink_tcon(cfile->tlink)->ses->server;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	ssize_t rc;
 
 	rc = netfs_start_io_write(inode);
@@ -2769,12 +2770,16 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (rc <= 0)
 		goto out;
 
-	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(from),
+	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) &&
+	    (cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(from),
 				     server->vals->exclusive_lock_type, 0,
-				     NULL, CIFS_WRITE_OP))
-		rc = netfs_buffered_write_iter_locked(iocb, from, NULL);
-	else
+				     NULL, CIFS_WRITE_OP))) {
 		rc = -EACCES;
+		goto out;
+	}
+
+	rc = netfs_buffered_write_iter_locked(iocb, from, NULL);
+
 out:
 	up_read(&cinode->lock_sem);
 	netfs_end_io_write(inode);


