Return-Path: <stable+bounces-128902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04415A7FB48
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BEE1884244
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715B3C0C;
	Tue,  8 Apr 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggyKeZdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309D20CCD8
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106963; cv=none; b=PZdH6gEoCYF3yQtKOdBlMiM7d9nDBsud8JGdzkT3gp6r+mpJ8uLTr7vAwZwltYNKjdSdPf3oapHV5KH/MT2oOxrX5Vlpv+WKbCb6ahmfr2V5WwZkSFxBhT2cYwNxV/lduVOoUCq2aO+8XD5G0pYqOYh3NB8gFgeHsuMKbkfmwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106963; c=relaxed/simple;
	bh=RA/GOJj9nDEDIyfYdpWcN5TVMAqOf942m9j0hc9pX9c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V7p7Hnv1gyLx88IPdhhR+lqct5w7HytRJXVk7ey3Di5qRoI6/RtVPKUGvVGZJ6bQpf4gDikXOYcrq9R6oHfJbo78jHoEyDUUGME5ur1XAFWBOLiDej45X8SHZO0mGKr7WbejBLnJz7bsb+/x5lWG9s56rRlIqaPuHNCqQZMySWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggyKeZdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B02C4CEE8;
	Tue,  8 Apr 2025 10:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106962;
	bh=RA/GOJj9nDEDIyfYdpWcN5TVMAqOf942m9j0hc9pX9c=;
	h=Subject:To:Cc:From:Date:From;
	b=ggyKeZdPDOVIN14l4SDSOtuwzy4E0646zvxJHLlGH9As9fuJ4aoNIZphAAH+xJe2I
	 3+hD24L4GqybgWyjolpIZTHtn+Eu5p25RcZOQC8xKfSsZVoknd9uVg8rmuMgMDu2XE
	 nUZbiHfvZCVq4iRKyxa3PtFH8XWhsvMFTRrIJUmc=
Subject: FAILED: patch "[PATCH] NFSD: Never return NFS4ERR_FILE_OPEN when removing a" failed to apply to 6.6-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org,trondmy@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:07:48 +0200
Message-ID: <2025040848-resize-avert-7b05@gregkh>
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
git cherry-pick -x 370345b4bd184a49ac68d6591801e5e3605b355a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040848-resize-avert-7b05@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 370345b4bd184a49ac68d6591801e5e3605b355a Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Sun, 26 Jan 2025 16:50:18 -0500
Subject: [PATCH] NFSD: Never return NFS4ERR_FILE_OPEN when removing a
 directory

RFC 8881 Section 18.25.4 paragraph 5 tells us that the server
should return NFS4ERR_FILE_OPEN only if the target object is an
opened file. This suggests that returning this status when removing
a directory will confuse NFS clients.

This is a version-specific issue; nfsd_proc_remove/rmdir() and
nfsd3_proc_remove/rmdir() already return nfserr_access as
appropriate.

Unfortunately there is no quick way for nfsd4_remove() to determine
whether the target object is a file or not, so the check is done in
in nfsd_unlink() for now.

Reported-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 466e16f0920f ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 749dd84bdb41..4e0a2c0549c7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1930,9 +1930,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	return err;
 }
 
-/*
- * Unlink a file or directory
- * N.B. After this call fhp needs an fh_put
+/**
+ * nfsd_unlink - remove a directory entry
+ * @rqstp: RPC transaction context
+ * @fhp: the file handle of the parent directory to be modified
+ * @type: enforced file type of the object to be removed
+ * @fname: the name of directory entry to be removed
+ * @flen: length of @fname in octets
+ *
+ * After this call fhp needs an fh_put.
+ *
+ * Returns a generic NFS status code in network byte-order.
  */
 __be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
@@ -2006,10 +2014,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	fh_drop_write(fhp);
 out_nfserr:
 	if (host_err == -EBUSY) {
-		/* name is mounted-on. There is no perfect
-		 * error status.
+		/*
+		 * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
+		 * wants a status unique to the object type.
 		 */
-		err = nfserr_file_open;
+		if (type != S_IFDIR)
+			err = nfserr_file_open;
+		else
+			err = nfserr_acces;
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);


