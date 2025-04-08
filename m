Return-Path: <stable+bounces-128905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF03A7FB27
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D8216A05C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D5264FB0;
	Tue,  8 Apr 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvgRRXHA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019C8488
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106976; cv=none; b=t44U6eGiYlaynG+zxYatCQIJDpL/7KeHaTZl6zUFTXId45fEQcuLUxY5mJJAyWcY+s8Dp+Ex5fYekKrBHJOySWTKoTjVwTDnO/ZQP/gwd0qC1pUmJS5SO1ItX5DorCP3JX8ByH22N9DJT9S+Gbkxy/5+DMQrfI2LACDO3JafmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106976; c=relaxed/simple;
	bh=XbDXpALzNM6WhSDQ6zBhPPzbLsEv7ky96syfTRtn4co=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IbkvT5hAKcrfmilLFCyF3tyjb/5ejYCAb82nFo2P3MwC1NGbhx4ixJH3DhOotgFblQRiiLPz65gm2zJzVnH1yY/Kku0o8gdcCMFHhQdwbMTrv0d9RI3i9Om7TWkvfPoqvABIlW6/rzdUIC+IOT7xxUgpbGDyuXP/Ef4jSXNVtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvgRRXHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77828C4CEE5;
	Tue,  8 Apr 2025 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106975;
	bh=XbDXpALzNM6WhSDQ6zBhPPzbLsEv7ky96syfTRtn4co=;
	h=Subject:To:Cc:From:Date:From;
	b=SvgRRXHAxAEfTHZ2DJUroN1BDrblSPv9mkXH7lG14OPYMWw38LNxx0/Oz8MkFGldZ
	 P+f2HMXq3aZeUEDW8cQ1O+O4O/H3xs/QHFBi37GsIKtWFLNejfg6gNYHFlBQdlqbmc
	 n6ojGWNSwJk9XhVXCa9RAahOj7cOtgZvqPtXTriU=
Subject: FAILED: patch "[PATCH] NFSD: Never return NFS4ERR_FILE_OPEN when removing a" failed to apply to 5.10-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org,trondmy@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:07:50 +0200
Message-ID: <2025040850-carwash-detention-d475@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 370345b4bd184a49ac68d6591801e5e3605b355a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040850-carwash-detention-d475@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


