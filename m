Return-Path: <stable+bounces-230862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBTaDuHSyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:21:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D2351096
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB83301B70F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE42C028C;
	Sun, 29 Mar 2026 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8W/pJaE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900923D2AB
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768861; cv=none; b=f1/1bKS8BAkt/s7b/u/rxMRY3vF7tliDd+7JbmC2JgupSlMy53yniee/5gsitWb6wsKHfeFkr3u9tgmMnmN6lwKNgdAV83aT05GM87cRbN0zlZe1gjPl8GSwy7eiFcRqI4bVrZQKHXJ/pqzl+zQcSSK99Gwpeo+x2E83v9KpOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768861; c=relaxed/simple;
	bh=qiLaNttHlS7/q+iiWAvDRRI7EyKUy6A6wsALHMhmNJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NRL4rQKbeEKlrglnBNAQloMs7H6QezHcD6c20NGgZ/ILIhr6YTwIY4hSKUa/VginNNQt1zGo1LlAH4Dnu0JCf3wYiaLiznwPCuSn5CRH0AsLulDTC/RENuWrImHk4Tv2eezTk/7JgyfcIVulx5nM4HFDsQwIsHLyx6S10pOzst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8W/pJaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3E5C116C6;
	Sun, 29 Mar 2026 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768861;
	bh=qiLaNttHlS7/q+iiWAvDRRI7EyKUy6A6wsALHMhmNJo=;
	h=Subject:To:Cc:From:Date:From;
	b=A8W/pJaE0GNduv9I/KyNttQGFd5CIcDxcf9unDkUFHKwsaWiBujjRtjECs3lAkqjd
	 x+tRHTrgs3d1U/T4zEqxHENE8CLtcGmurwiyQkP9wFp/yaW6CsHFsZ3doBeZfrYCLg
	 OhXXAi9EXrzAoIkS3MdW8O7BptF3zKOEte25uI8g=
Subject: FAILED: patch "[PATCH] ksmbd: fix memory leaks and NULL deref in smb2_lock()" failed to apply to 5.15-stable tree
To: werner@verivus.com,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:20:55 +0200
Message-ID: <2026032955-agonizing-swooned-74db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230862-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: CF5D2351096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 309b44ed684496ed3f9c5715d10b899338623512
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032955-agonizing-swooned-74db@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 309b44ed684496ed3f9c5715d10b899338623512 Mon Sep 17 00:00:00 2001
From: Werner Kasselman <werner@verivus.com>
Date: Tue, 17 Mar 2026 07:55:37 +0000
Subject: [PATCH] ksmbd: fix memory leaks and NULL deref in smb2_lock()

smb2_lock() has three error handling issues after list_del() detaches
smb_lock from lock_list at no_check_cl:

1) If vfs_lock_file() returns an unexpected error in the non-UNLOCK
   path, goto out leaks smb_lock and its flock because the out:
   handler only iterates lock_list and rollback_list, neither of
   which contains the detached smb_lock.

2) If vfs_lock_file() returns -ENOENT in the UNLOCK path, goto out
   leaks smb_lock and flock for the same reason.  The error code
   returned to the dispatcher is also stale.

3) In the rollback path, smb_flock_init() can return NULL on
   allocation failure.  The result is dereferenced unconditionally,
   causing a kernel NULL pointer dereference.  Add a NULL check to
   prevent the crash and clean up the bookkeeping; the VFS lock
   itself cannot be rolled back without the allocation and will be
   released at file or connection teardown.

Fix cases 1 and 2 by hoisting the locks_free_lock()/kfree() to before
the if(!rc) check in the UNLOCK branch so all exit paths share one
free site, and by freeing smb_lock and flock before goto out in the
non-UNLOCK branch.  Propagate the correct error code in both cases.
Fix case 3 by wrapping the VFS unlock in an if(rlock) guard and adding
a NULL check for locks_free_lock(rlock) in the shared cleanup.

Found via call-graph analysis using sqry.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Suggested-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Werner Kasselman <werner@verivus.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8fa780e8efd0..24f8d58493d0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7592,14 +7592,15 @@ int smb2_lock(struct ksmbd_work *work)
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:
 		if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
+			locks_free_lock(flock);
+			kfree(smb_lock);
 			if (!rc) {
 				ksmbd_debug(SMB, "File unlocked\n");
 			} else if (rc == -ENOENT) {
 				rsp->hdr.Status = STATUS_NOT_LOCKED;
+				err = rc;
 				goto out;
 			}
-			locks_free_lock(flock);
-			kfree(smb_lock);
 		} else {
 			if (rc == FILE_LOCK_DEFERRED) {
 				void **argv;
@@ -7668,6 +7669,9 @@ int smb2_lock(struct ksmbd_work *work)
 				spin_unlock(&work->conn->llist_lock);
 				ksmbd_debug(SMB, "successful in taking lock\n");
 			} else {
+				locks_free_lock(flock);
+				kfree(smb_lock);
+				err = rc;
 				goto out;
 			}
 		}
@@ -7698,13 +7702,17 @@ int smb2_lock(struct ksmbd_work *work)
 		struct file_lock *rlock = NULL;
 
 		rlock = smb_flock_init(filp);
-		rlock->c.flc_type = F_UNLCK;
-		rlock->fl_start = smb_lock->start;
-		rlock->fl_end = smb_lock->end;
+		if (rlock) {
+			rlock->c.flc_type = F_UNLCK;
+			rlock->fl_start = smb_lock->start;
+			rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
-		if (rc)
-			pr_err("rollback unlock fail : %d\n", rc);
+			rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
+			if (rc)
+				pr_err("rollback unlock fail : %d\n", rc);
+		} else {
+			pr_err("rollback unlock alloc failed\n");
+		}
 
 		list_del(&smb_lock->llist);
 		spin_lock(&work->conn->llist_lock);
@@ -7714,7 +7722,8 @@ int smb2_lock(struct ksmbd_work *work)
 		spin_unlock(&work->conn->llist_lock);
 
 		locks_free_lock(smb_lock->fl);
-		locks_free_lock(rlock);
+		if (rlock)
+			locks_free_lock(rlock);
 		kfree(smb_lock);
 	}
 out2:


