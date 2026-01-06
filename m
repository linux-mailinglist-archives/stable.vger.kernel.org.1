Return-Path: <stable+bounces-206038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B28CFAF8A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E7653002958
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559A33B6D1;
	Tue,  6 Jan 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUsOr3d0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C51C2324
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731676; cv=none; b=szHThF5OaIQiIm++cImnu5qohmrKDAylGsFv4H0coYIBdqiM53Z2IwV+I9mt/GQgpnqL1SP14fRN5bwLGAe62kkSEhlMwYFxUZMDro/4LLKZTQgGKdQfQZ8U6Wsadd75EacKxK+byLHiAAy01TERW4Ry31TtETuKkc/LDC1HgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731676; c=relaxed/simple;
	bh=CX5JNpG5D9tkgiZ1vDfZocfHcMW1LH3tigqks33rAlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg7Rp1v3M7aMRypJpOPtHbw9p6kx6Yq415n47BG0gu0bT3cNMDqV4lWeWShxnhONhRp/stLIjOex+F8rO1vPA9q3+dsOGLaHDa1/OQ0MxBoImwFHgiYkEqxpzsebldAwNskeG0U8PCTuOgKJ/rTW0hhekWjlJLEjP/nE4TVA5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUsOr3d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49840C116C6;
	Tue,  6 Jan 2026 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767731676;
	bh=CX5JNpG5D9tkgiZ1vDfZocfHcMW1LH3tigqks33rAlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUsOr3d0SSrkghrnxKM9R6XcqX4wWFtCl9gCPQKxQYxap5oUugaJ1m+NHUi/wf+1O
	 GweQMQfSkfjJIqfNaT4PhdFY9OpmQf/lp0sIj+ISo0Z7Q26gM65W0T+hryb28jkiqb
	 CiCFpPsvCfP+KXLqP8DAj0HBFbo+J46d7d86TEPMIk3AH/p1WgCiek7JxGA+X83XaI
	 Fw76rRHjdn6BoVH4E5Kx8MenIKviRzXaoQA9jsZvRHxOP7UQ8X5jUS6UyWuBtx1M4L
	 eq8lQ/exCRDSbay1xIstghNfhUMU4AgZB2Zpx+6j6VKgWvxiyvftOhqW/aS9DzC0AQ
	 +nhSh+wvGs7Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] lockd: fix vfs_test_lock() calls
Date: Tue,  6 Jan 2026 15:34:33 -0500
Message-ID: <20260106203433.3165546-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010559-outthink-mutilated-30df@gregkh>
References: <2026010559-outthink-mutilated-30df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

[ Upstream commit a49a2a1baa0c553c3548a1c414b6a3c005a8deba ]

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
[ adapted fl->c.flc_* field references to flat fl->fl_* naming convention ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc4proc.c |  4 +---
 fs/lockd/svclock.c  | 21 ++++++++++++---------
 fs/lockd/svcproc.c  |  5 +----
 fs/locks.c          | 12 ++++++++++--
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b72023a6b4c1..28ba7b1460aa 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -96,7 +96,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	struct nlm_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
-	struct nlm_lockowner *test_owner;
 	__be32 rc = rpc_success;
 
 	dprintk("lockd: TEST4        called\n");
@@ -106,7 +105,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	test_owner = argp->lock.fl.fl_owner;
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
 	if (resp->status == nlm_drop_reply)
@@ -114,7 +112,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 43aeba9de55c..ef6d8061460d 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -615,7 +615,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	}
 
 	mode = lock_to_openmode(&lock->fl);
-	error = vfs_test_lock(file->f_file[mode], &lock->fl);
+	locks_init_lock(&conflock->fl);
+	/* vfs_test_lock only uses start, end, and owner, but tests fl_file */
+	conflock->fl.fl_file = lock->fl.fl_file;
+	conflock->fl.fl_start = lock->fl.fl_start;
+	conflock->fl.fl_end = lock->fl.fl_end;
+	conflock->fl.fl_owner = lock->fl.fl_owner;
+	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
@@ -625,22 +631,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	if (lock->fl.fl_type == F_UNLCK) {
+	if (conflock->fl.fl_type == F_UNLCK) {
 		ret = nlm_granted;
 		goto out;
 	}
 
 	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
-		lock->fl.fl_type, (long long)lock->fl.fl_start,
-		(long long)lock->fl.fl_end);
+		conflock->fl.fl_type, (long long)conflock->fl.fl_start,
+		(long long)conflock->fl.fl_end);
 	conflock->caller = "somehost";	/* FIXME */
 	conflock->len = strlen(conflock->caller);
 	conflock->oh.len = 0;		/* don't return OH info */
-	conflock->svid = lock->fl.fl_pid;
-	conflock->fl.fl_type = lock->fl.fl_type;
-	conflock->fl.fl_start = lock->fl.fl_start;
-	conflock->fl.fl_end = lock->fl.fl_end;
-	locks_release_private(&lock->fl);
+	conflock->svid = conflock->fl.fl_pid;
+	locks_release_private(&conflock->fl);
 
 	ret = nlm_lck_denied;
 out:
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 32784f508c81..1a4459763644 100644
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
 
-	test_owner = argp->lock.fl.fl_owner;
-
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
 	if (resp->status == nlm_drop_reply)
@@ -137,7 +134,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 		dprintk("lockd: TEST          status %d vers %d\n",
 			ntohl(resp->status), rqstp->rq_vers);
 
-	nlmsvc_put_lockowner(test_owner);
+	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
 	nlm_release_file(file);
 	return rc;
diff --git a/fs/locks.c b/fs/locks.c
index ccfa441e487e..19e9fcd1d4ca 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2124,13 +2124,21 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
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
 	WARN_ON_ONCE(filp != fl->fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
-- 
2.51.0


