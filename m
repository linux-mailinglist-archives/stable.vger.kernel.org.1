Return-Path: <stable+bounces-17581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0A8459F0
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082631C2439E
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2C5D479;
	Thu,  1 Feb 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2CIht5Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F05337E
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797172; cv=none; b=JatKluvO3JeV4ftPDovIAMJRzKQNMRV0d6Au5eZz5cZxvQmL3VkkkslYCPrNxrLtq0yH5Foq3npMiFfJaChoeP5iQCFtIwtNBJXFAIX2JgDa6HIjZv6eb245ZgixIoZC60YgeQ/cSAdb7ufwqNK5o/HoCsDn1UYoc/UIeeqYSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797172; c=relaxed/simple;
	bh=uxgbGZQyn/u5Kgjm4h7zKbSbJpcMbY8+HjqS5ygUfvc=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=GHTtMkk9fy08+g0QnM/OvI2rE7U3yEthfMmrFbwWM5L/XcsGXPwAU4O0G03EETJGxuT9f268hjh2Ww++Qn9DMk+5yu7PrA5viMnzuxrIycPZu+Uvjm1Uc+9WMVIteA6cs0BX4dDoO3NlBm9xs6jRpSA1ja6OfgV8+Eq5iHYqtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2CIht5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18285C433C7
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706797172;
	bh=uxgbGZQyn/u5Kgjm4h7zKbSbJpcMbY8+HjqS5ygUfvc=;
	h=Subject:From:To:Date:From;
	b=q2CIht5YL3sWbRe9O++ZMElWNIxdQiN1fALmECDZfasM0RZVRolccum1bEI1g83XC
	 4LpIfqMpZ793J284/3LbkAhlXAXz0lCLRxXxtWWxB2PhODfrR9VIW9Um1grSJDn/tp
	 adn14RrNl02TaRRkJQ0fwYkelTCmtqvQtTkpFISOwhOERvVkTmOE0EEJdfQJ3czDri
	 A+y/fFQbp06EAgBTIZBDvTB9tur286gBKXlgi0rVyNhbMfEAki50E12B2QPP4OEECv
	 lLicoYQe4cr0Stn2a7AXN3OvUTV9E8qfXHPR6RCkje4yO7yQciCtUhequXCfLrxJCr
	 lp6nl5Mi5qBvg==
Subject: [PATCH] nfsd: fix RELEASE_LOCKOWNER
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Date: Thu, 01 Feb 2024 09:19:31 -0500
Message-ID: 
 <170679716505.13743.16856969957511111004.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit edcf9725150e42beeca42d085149f4c88fa97afd ]

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
---
 fs/nfsd/nfs4state.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

Passes pynfs, fstests, and the git regression suite. Please apply to
origin/linux-6.1.y.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index faecdbfa01a2..0443fe4e29e1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7736,14 +7736,16 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
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
 
 	inode = locks_inode(nf->nf_file);
@@ -7759,7 +7761,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
+out:
+	spin_unlock(&fp->fi_lock);
 	return status;
 }
 
@@ -7769,10 +7772,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
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
@@ -7808,10 +7809,13 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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



