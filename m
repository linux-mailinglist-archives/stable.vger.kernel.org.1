Return-Path: <stable+bounces-17202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781284103B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37B285FD4
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE7615B963;
	Mon, 29 Jan 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSkd3vuZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B015B962;
	Mon, 29 Jan 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548585; cv=none; b=tr27ZzTG0y103ZPCmX/9Utv7kEZwI60la5EY1UOpVRYInY+OF+11J/SD4GxAg5T/HRFZzhSYraJaY4bct2IYbs1Tgi40SUrfIdqcKcI35/Kv5qKi7YsItjHT7JNlr6BUpsUog1WYSS5IVc+wvo3v3doeuAzifVJsaSEJ20u40sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548585; c=relaxed/simple;
	bh=LFLcsm1kiGLRAJfCYArJGwrqAFs4RTGTrX3V6pbs/IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSCWtNID7Ik9y90LtuOri4Ct535JwMAZpOhseRcq1IbvmZB/phEpCh1QLk715LFzGymqe4Mid5eLEuJ1R4AFYFgxiJQ8hos/c55sKeI/5UmZiu5ranN7RWPxUbL6bnjqHIaOV5//3ZxvUeziVxbub3WLiSda8iGKuDEa6B4Gisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSkd3vuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85873C433F1;
	Mon, 29 Jan 2024 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548585;
	bh=LFLcsm1kiGLRAJfCYArJGwrqAFs4RTGTrX3V6pbs/IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSkd3vuZkTkL3vBBCghalD85682/acsOn/AAKw9hCN0sYpVmQpvMyjD+uMhGS23c/
	 xT/6UHcuv6BFfFxpv+UX02+05bok8/LAw9NzNogQFcW6bxG0evpnVfkge5w2drIVlt
	 bDWPsyXEO9TISKnqBhHDJtgFIrXtlI0gr6evRdRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 241/331] nfsd: fix RELEASE_LOCKOWNER
Date: Mon, 29 Jan 2024 09:05:05 -0800
Message-ID: <20240129170021.928913463@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

commit edcf9725150e42beeca42d085149f4c88fa97afd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7890,14 +7890,16 @@ check_for_locks(struct nfs4_file *fp, st
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
@@ -7913,7 +7915,8 @@ check_for_locks(struct nfs4_file *fp, st
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
+out:
+	spin_unlock(&fp->fi_lock);
 	return status;
 }
 
@@ -7923,10 +7926,8 @@ check_for_locks(struct nfs4_file *fp, st
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
@@ -7962,10 +7963,13 @@ nfsd4_release_lockowner(struct svc_rqst
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



