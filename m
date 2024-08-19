Return-Path: <stable+bounces-69484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB495670A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1341C20FFD
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CF15C14F;
	Mon, 19 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dBvQT9p9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E214AD3F
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059874; cv=none; b=SxXuutoTVpH5t/mXAHv+MnAL4fhZC2n1lV5fbPgPGCP4O3vp/lxWbMkACyLIegMzRA1t2yOhKtazNlNpyiVDHiDNgsWkeZLNdmvpaSK4H6HE+SxYAY9vWCRct7qjbztJjHMw2XVGA4oOIYvamL33EzOh+oBbqobsMC8E8VOQ61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059874; c=relaxed/simple;
	bh=UzwJfYh/3K1mEbYFiVZBLIN2SKdVkNKSyanrTaaSUDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g/6Sbry6UqdUDqOJTjfpLPUAVVq2ZUYReV3COWupM6fTKj8hu8spBOprgpbvBxWWSEZvbNb4BSVqACTAW0ydM9RI+MhDTIA41QCnoF66Hg7+tMDanMDfGCOcmnKEH5u/yc/0M/Zl2Gzy3Trr9qzBlGjnkrJaCFw9tyWOK9vJYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dBvQT9p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01AAC4AF09;
	Mon, 19 Aug 2024 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724059874;
	bh=UzwJfYh/3K1mEbYFiVZBLIN2SKdVkNKSyanrTaaSUDE=;
	h=Subject:To:Cc:From:Date:From;
	b=dBvQT9p9Q5txZ+gXggyWNKCtbxDjm3N4uqXTmlnS2aih2NLkPYziPvUXalJ6kdrcj
	 3WbwqQHTRDPNhiU3GyiJQevi24zOJVYOZhuIba0J9KeW/s33YvcxBSFMtGYDdBU/qn
	 YWEMIjVO0RCABCetJWFmMhcctKmPCSRGU/Zb/f9c=
Subject: FAILED: patch "[PATCH] smb3: fix lock breakage for cached writes" failed to apply to 6.6-stable tree
To: stfrench@microsoft.com,dhowells@redhat.com,kevin.ottens@enioka.com,piastryyy@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:31:11 +0200
Message-ID: <2024081910-dawn-handoff-e37b@gregkh>
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
git cherry-pick -x 836bb3268db405cf9021496ac4dbc26d3e4758fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081910-dawn-handoff-e37b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


