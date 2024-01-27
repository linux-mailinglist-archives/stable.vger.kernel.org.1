Return-Path: <stable+bounces-16112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5B83F05F
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8732F283D90
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1295175AE;
	Sat, 27 Jan 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VoIAE+a7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C41B5B2
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392814; cv=none; b=o8Wzn9w8jihjHQ4hirY3AXoJ3nEumMahDEjAD14V0tbu/CTY5dLWudXFKShLwV9U/bCWGI9+OaXwdomSCiwhyqEu/AimGQgqeoayqfPIiUMRRfWaucS5zwV7gZW2SOqZXMq/Kp2faQ26BqDJ8NQk/zIHq2FUVBUV7CTj3Eo7EOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392814; c=relaxed/simple;
	bh=kkUBtIyTui10GzbtaKVMAx/m0J7gNwVJhmPyAVR2ZmU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eUHql9c9XSL14JC6f7h0QZExX6jGsH8DOkMTi9/sRO3xM/Jm50J71KuMMaEuiRTfcpJenjVk4Pn31e5xye441i1x72hys30jdhjcfagIuRfRUmAyuJM1drTht34eCLPltHP4sITb1Q94fcuBqJOca6M4jQWxK97UHc6Q6vCc8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VoIAE+a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61EEC43390;
	Sat, 27 Jan 2024 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706392814;
	bh=kkUBtIyTui10GzbtaKVMAx/m0J7gNwVJhmPyAVR2ZmU=;
	h=Subject:To:Cc:From:Date:From;
	b=VoIAE+a7q7iSiflCGFka18ZHANIvjkMZe/zuZo7WksowgEZCXx2ZAlrkq9cu96NvX
	 gnNC0VC2zRFWYHS3DHfZ7IV1d9CDnrTxEsJH0i57mYV52YElDU+BNNSQg3RXr37jAR
	 zCTsQfzIE88uR/9AvdtSD73ALLqygLqQQBK8fbnY=
Subject: FAILED: patch "[PATCH] nfsd: fix RELEASE_LOCKOWNER" failed to apply to 4.19-stable tree
To: neilb@suse.de,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:00:12 -0800
Message-ID: <2024012712-spherical-huntsman-cd8b@gregkh>
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
git cherry-pick -x edcf9725150e42beeca42d085149f4c88fa97afd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012712-spherical-huntsman-cd8b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
043862b09cc0 ("NFSD: Add documenting comment for nfsd4_release_lockowner()")
bd8fdb6e545f ("NFSD: Modernize nfsd4_release_lockowner()")
ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")
eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to nfsd_file")
fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use nfsd_files")
0c4b62b042fe ("nfsd4: show layout stateids")
16d36e099980 ("nfsd: show lock and deleg stateids")
78599c42ae3c ("nfsd4: add file to display list of client's opens")
97ad4031e295 ("nfsd4: add a client info file")
bf5ed3e3bb84 ("nfsd: make client/ directory names small ints")
e8a79fb14f6b ("nfsd: add nfsd/clients directory")
59f8e91b75ec ("nfsd4: use reference count to free client")
14ed14cc7c06 ("nfsd: rename cl_refcount")
2c830dd7209b ("nfsd: persist nfsd filesystem across mounts")
3ba75830ce17 ("nfsd4: drc containerization")
e333f3bbefe3 ("nfsd: Allow containers to set supported nfs versions")
029be5d03357 ("nfsd: Add custom rpcbind callbacks for knfsd")
642ee6b209c2 ("SUNRPC: Allow further customisation of RPC program registration")
8e5b67731d08 ("SUNRPC: Add a callback to initialise server requests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edcf9725150e42beeca42d085149f4c88fa97afd Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Mon, 22 Jan 2024 14:58:16 +1100
Subject: [PATCH] nfsd: fix RELEASE_LOCKOWNER

The test on so_count in nfsd4_release_lockowner() is nonsense and
harmful.  Revert to using check_for_locks(), changing that to not sleep.

First: harmful.
As is documented in the kdoc comment for nfsd4_release_lockowner(), the
test on so_count can transiently return a false positive resulting in a
return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
clearly a protocol violation and with the Linux NFS client it can cause
incorrect behaviour.

If RELEASE_LOCKOWNER is sent while some other thread is still
processing a LOCK request which failed because, at the time that request
was received, the given owner held a conflicting lock, then the nfsd
thread processing that LOCK request can hold a reference (conflock) to
the lock owner that causes nfsd4_release_lockowner() to return an
incorrect error.

The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks, so
it knows that the error is impossible.  It assumes the lock owner was in
fact released so it feels free to use the same lock owner identifier in
some later locking request.

When it does reuse a lock owner identifier for which a previous RELEASE
failed, it will naturally use a lock_seqid of zero.  However the server,
which didn't release the lock owner, will expect a larger lock_seqid and
so will respond with NFS4ERR_BAD_SEQID.

So clearly it is harmful to allow a false positive, which testing
so_count allows.

The test is nonsense because ... well... it doesn't mean anything.

so_count is the sum of three different counts.
1/ the set of states listed on so_stateids
2/ the set of active vfs locks owned by any of those states
3/ various transient counts such as for conflicting locks.

When it is tested against '2' it is clear that one of these is the
transient reference obtained by find_lockowner_str_locked().  It is not
clear what the other one is expected to be.

In practice, the count is often 2 because there is precisely one state
on so_stateids.  If there were more, this would fail.

In my testing I see two circumstances when RELEASE_LOCKOWNER is called.
In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results in
all the lock states being removed, and so the lockowner being discarded
(it is removed when there are no more references which usually happens
when the lock state is discarded).  When nfsd4_release_lockowner() finds
that the lock owner doesn't exist, it returns success.

The other case shows an so_count of '2' and precisely one state listed
in so_stateid.  It appears that the Linux client uses a separate lock
owner for each file resulting in one lock state per lock owner, so this
test on '2' is safe.  For another client it might not be safe.

So this patch changes check_for_locks() to use the (newish)
find_any_file_locked() so that it doesn't take a reference on the
nfs4_file and so never calls nfsd_file_put(), and so never sleeps.  With
this check is it safe to restore the use of check_for_locks() rather
than testing so_count against the mysterious '2'.

Fixes: ce3c4ad7f4ce ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..6dc6340e2852 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7911,14 +7911,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 {
 	struct file_lock *fl;
 	int status = false;
-	struct nfsd_file *nf = find_any_file(fp);
+	struct nfsd_file *nf;
 	struct inode *inode;
 	struct file_lock_context *flctx;
 
+	spin_lock(&fp->fi_lock);
+	nf = find_any_file_locked(fp);
 	if (!nf) {
 		/* Any valid lock stateid should have some sort of access */
 		WARN_ON_ONCE(1);
-		return status;
+		goto out;
 	}
 
 	inode = file_inode(nf->nf_file);
@@ -7934,7 +7936,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
+out:
+	spin_unlock(&fp->fi_lock);
 	return status;
 }
 
@@ -7944,10 +7947,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
  * @cstate: NFSv4 COMPOUND state
  * @u: RELEASE_LOCKOWNER arguments
  *
- * The lockowner's so_count is bumped when a lock record is added
- * or when copying a conflicting lock. The latter case is brief,
- * but can lead to fleeting false positives when looking for
- * locks-in-use.
+ * Check if theree are any locks still held and if not - free the lockowner
+ * and any lock state that is owned.
  *
  * Return values:
  *   %nfs_ok: lockowner released or not found
@@ -7983,10 +7984,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		spin_unlock(&clp->cl_lock);
 		return nfs_ok;
 	}
-	if (atomic_read(&lo->lo_owner.so_count) != 2) {
-		spin_unlock(&clp->cl_lock);
-		nfs4_put_stateowner(&lo->lo_owner);
-		return nfserr_locks_held;
+
+	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
+		if (check_for_locks(stp->st_stid.sc_file, lo)) {
+			spin_unlock(&clp->cl_lock);
+			nfs4_put_stateowner(&lo->lo_owner);
+			return nfserr_locks_held;
+		}
 	}
 	unhash_lockowner_locked(lo);
 	while (!list_empty(&lo->lo_owner.so_stateids)) {


