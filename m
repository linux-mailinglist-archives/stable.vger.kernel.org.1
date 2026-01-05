Return-Path: <stable+bounces-204742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE302CF361C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CD83026BF6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560A336EC0;
	Mon,  5 Jan 2026 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJt7B23w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15785335BCD
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613818; cv=none; b=F/GBWEQw9MFdjkZJPA10wRmtzUS4x+SICwb3uVGYt2r00IEImJXCAr+9Or2fqkvz6/D5ul0DSof/C3aqdZ3+CLVRwTgf2o4Rpdi5FLjECeBRsgClOwNiJ2ro2ykIYVqPdN/o1HKLeBnQBvyVKei1lRaj4ao9hqefSbjPSIF0REI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613818; c=relaxed/simple;
	bh=hdtp2MnUvqTpZ5D8MtHJgzDzvXGu0L2TcEbu02Hhaao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DdTOSecoNVeCnpWGb075mfv6fFbyT79sZAFWDpKtDhfL2I1l0EBEpSGK2VfU0YnRREeS1N3FWCLDupxfG8Ow3p27k50SL/pQdP1Af4Cf2UqKugA40wh5eo9RwsuPp2d0PWyrrOEx/FWnMk0WHokHmY0kljd5GH4k3TOErzHh1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJt7B23w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471CBC116D0;
	Mon,  5 Jan 2026 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613817;
	bh=hdtp2MnUvqTpZ5D8MtHJgzDzvXGu0L2TcEbu02Hhaao=;
	h=Subject:To:Cc:From:Date:From;
	b=SJt7B23w6RndtJv1vOyL+vdiBgji3ixhkwyfSBy8YwcU6AzaFkndYQ+fXAbdFGhPq
	 FzNW1PxsouXuZx7Hhp5yFtAgReR6LaK1MDCGSfsPRwzenIKZ3elRf52S/I32mP6CIP
	 oRklB6RvkQyetySZ6yBXdY4nZ78o2MAVamomUuDc=
Subject: FAILED: patch "[PATCH] lockd: fix vfs_test_lock() calls" failed to apply to 5.10-stable tree
To: neil@brown.name,chuck.lever@oracle.com,jlayton@kernel.org,okorniev@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:50:01 +0100
Message-ID: <2026010501-unsworn-elated-41e1@gregkh>
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
git cherry-pick -x a49a2a1baa0c553c3548a1c414b6a3c005a8deba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010501-unsworn-elated-41e1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a49a2a1baa0c553c3548a1c414b6a3c005a8deba Mon Sep 17 00:00:00 2001
From: NeilBrown <neil@brown.name>
Date: Sat, 22 Nov 2025 12:00:36 +1100
Subject: [PATCH] lockd: fix vfs_test_lock() calls

Usage of vfs_test_lock() is somewhat confused.  Documentation suggests
it is given a "lock" but this is not the case.  It is given a struct
file_lock which contains some details of the sort of lock it should be
looking for.

In particular passing a "file_lock" containing fl_lmops or fl_ops is
meaningless and possibly confusing.

This is particularly problematic in lockd.  nlmsvc_testlock() receives
an initialised "file_lock" from xdr-decode, including manager ops and an
owner.  It then mistakenly passes this to vfs_test_lock() which might
replace the owner and the ops.  This can lead to confusion when freeing
the lock.

The primary role of the 'struct file_lock' passed to vfs_test_lock() is
to report a conflicting lock that was found, so it makes more sense for
nlmsvc_testlock() to pass "conflock", which it uses for returning the
conflicting lock.

With this change, freeing of the lock is not confused and code in
__nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.

Documentation for vfs_test_lock() is improved to reflect its real
purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
future.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Closes: https://lore.kernel.org/all/20251021130506.45065-1-okorniev@redhat.com
Signed-off-by: NeilBrown <neil@brown.name>
Fixes: 20fa19027286 ("nfs: add export operations")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 109e5caae8c7..4b6f18d97734 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST4        called\n");
@@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.c.flc_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
 				       &resp->lock);
@@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 3a3d05cfe09a..6bce19fd024c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -633,7 +633,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	}
 
 	mode = lock_to_openmode(&lock->fl);
-	error = vfs_test_lock(file->f_file[mode], &lock->fl);
+	locks_init_lock(&conflock->fl);
+	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
+	conflock->fl.c.flc_file = lock->fl.c.flc_file;
+	conflock->fl.fl_start = lock->fl.fl_start;
+	conflock->fl.fl_end = lock->fl.fl_end;
+	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
+	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
@@ -643,22 +649,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	if (lock->fl.c.flc_type == F_UNLCK) {
+	if (conflock->fl.c.flc_type == F_UNLCK) {
 		ret = nlm_granted;
 		goto out;
 	}
 
 	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
-		lock->fl.c.flc_type, (long long)lock->fl.fl_start,
-		(long long)lock->fl.fl_end);
+		conflock->fl.c.flc_type, (long long)conflock->fl.fl_start,
+		(long long)conflock->fl.fl_end);
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.c.flc_pid;
-	conflock->fl.c.flc_type = lock->fl.c.flc_type;
-	conflock->fl.fl_start = lock->fl.fl_start;
-	conflock->fl.fl_end = lock->fl.fl_end;
-	locks_release_private(&lock->fl);
+	conflock->svid = conflock->fl.c.flc_pid;
+	locks_release_private(&conflock->fl);
 
 	ret = nlm_lck_denied;
 out:
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f53d5177f267..5817ef272332 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST          called\n");
@@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.c.flc_owner;
-
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
 						   &argp->lock, &resp->lock));
@@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..bf5e0d05a026 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2185,13 +2185,21 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 /**
  * vfs_test_lock - test file byte range lock
  * @filp: The file to test lock for
- * @fl: The lock to test; also used to hold result
+ * @fl: The byte-range in the file to test; also used to hold result
  *
+ * On entry, @fl does not contain a lock, but identifies a range (fl_start, fl_end)
+ * in the file (c.flc_file), and an owner (c.flc_owner) for whom existing locks
+ * should be ignored.  c.flc_type and c.flc_flags are ignored.
+ * Both fl_lmops and fl_ops in @fl must be NULL.
  * Returns -ERRNO on failure.  Indicates presence of conflicting lock by
- * setting conf->fl_type to something other than F_UNLCK.
+ * setting fl->fl_type to something other than F_UNLCK.
+ *
+ * If vfs_test_lock() does find a lock and return it, the caller must
+ * use locks_free_lock() or locks_release_private() on the returned lock.
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
+	WARN_ON_ONCE(fl->fl_ops || fl->fl_lmops);
 	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);


