Return-Path: <stable+bounces-128901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B09A7FB42
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D8B3A817A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480420CCD8;
	Tue,  8 Apr 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShIDaJis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D4215066
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106948; cv=none; b=jkiHx3BGNMsVJKHsdiRQ+9eIO004djpWfG0AailOzKFIUosXO9BqEyc2Q11aZ4ZalA3wZbkP9YdCMyVcSw6exV/b4Te7MzZQIxvT1nLuRANMLlQB9WAuKSHyEUYmKjtHzkScRjwYCjmTfPIL9N7+AHxwVVoRbbk8tsDXIEgcfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106948; c=relaxed/simple;
	bh=38lEkkxcDI6IGlIc/VKZNbeBU7E3upl+1GEOl8koJBo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XXI3H49fPGhFvBXGcEkRDrfyh2IX0fWaxhmIo4QJhN/ujyIrsLtHyNPHsn99sRwJ3wPfXmpQWSD4f9uDo/3AdYalVhj5CBhdELInGesr4X/fZMrM/MlGO7sofZYuuM/f2PSy8cC8/XOLby2NsSKSTOITTfHhIr7Yp4qr2a/QEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShIDaJis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359ADC4CEE5;
	Tue,  8 Apr 2025 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106948;
	bh=38lEkkxcDI6IGlIc/VKZNbeBU7E3upl+1GEOl8koJBo=;
	h=Subject:To:Cc:From:Date:From;
	b=ShIDaJisviX6bTKSBJPazt65AEz+CJuRG5WLfqlkVMNVyu57BKGuCRl47sR8oJp8c
	 uvDNbSNOPyAS2IwUE0e3GqC3Chc+b3ohmC7azB5vOSzfWLIISqb6TzbcEOl/AkxJEb
	 FNEJmSteG3+Rmi2RA8R0ONjJujRlhvh7We6LDpEw=
Subject: FAILED: patch "[PATCH] NFSD: nfsd_unlink() clobbers non-zero status returned from" failed to apply to 6.6-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:07:35 +0200
Message-ID: <2025040835-legroom-backshift-766c@gregkh>
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
git cherry-pick -x d7d8e3169b56e7696559a2427c922c0d55debcec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040835-legroom-backshift-766c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7d8e3169b56e7696559a2427c922c0d55debcec Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Sun, 26 Jan 2025 16:50:17 -0500
Subject: [PATCH] NFSD: nfsd_unlink() clobbers non-zero status returned from
 fh_fill_pre_attrs()

If fh_fill_pre_attrs() returns a non-zero status, the error flow
takes it through out_unlock, which then overwrites the returned
status code with

	err = nfserrno(host_err);

Fixes: a332018a91c4 ("nfsd: handle failure to collect pre/post-op attrs more sanely")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 188c978a0c79..749dd84bdb41 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2010,11 +2010,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		 * error status.
 		 */
 		err = nfserr_file_open;
-	} else {
-		err = nfserrno(host_err);
 	}
 out:
-	return err;
+	return err != nfs_ok ? err : nfserrno(host_err);
 out_unlock:
 	inode_unlock(dirp);
 	goto out_drop_write;


