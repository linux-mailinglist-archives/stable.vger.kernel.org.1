Return-Path: <stable+bounces-52966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A690D169
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCE8B27A20
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7214B968;
	Tue, 18 Jun 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xtb9H3oL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1013A877;
	Tue, 18 Jun 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714935; cv=none; b=escZ1Dw8s0XcQXMYdsmRHU+UbKSFhixPlGXU9OcuP1YL2vQE1kjZgpKrNToHOFMyN2K6dcbn7R4padt3lMq1IK+geqBxr9zYjfV6RaDNNYcO2mne0pqHWV9NpNtoEQnvFbLi0FXuL7wepvLh2MzG6PPGenCrKVqpqzijA6jAbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714935; c=relaxed/simple;
	bh=4sW5Ns5CY4HdXlQoUuCeVKURdWw9DLcNMYvyE6uFLc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RynSdSPsOaFxgrvU2xnu0VJbb6+6/wXItXyDoMEEFQI6mXmWURxyoEZzeIynBmJUfS24X9c+9Qv1qbV5GetCBXiGIzEdMNKoVT7Qb2wqWMCoaM0id09cRqD7ZUrpmF5ahZ1iEz/mB/qiIKDPLHDDUmT8wkv0BOq58vbRVId8n8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xtb9H3oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8242AC3277B;
	Tue, 18 Jun 2024 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714934;
	bh=4sW5Ns5CY4HdXlQoUuCeVKURdWw9DLcNMYvyE6uFLc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xtb9H3oLTAG/XKMrzHCYWXi4psQDjst1pJecqf/doWIYAjElXDY9wthF1D7qPVEe7
	 7c1oDC0VuZLJbpZs0GgyDzyLwoTxVQZghEEcTUSd1r7qnMc98VoQkrEUBh4kQ1DzWN
	 W0+43y3aWaUbviTY5xlrL7D+etKUbpiNnfqBg6KM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?Daniel=20P . =20Berrang=C3=A9?=" <berrange@redhat.com>,
	Jeff Layton <jlayton@redhat.com>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 107/770] exec: Move unshare_files to fix posix file locking during exec
Date: Tue, 18 Jun 2024 14:29:20 +0200
Message-ID: <20240618123411.403444264@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

[ Upstream commit b6043501289ebf169ae19b810a882d517377302f ]

Many moons ago the binfmts were doing some very questionable things
with file descriptors and an unsharing of the file descriptor table
was added to make things better[1][2].  The helper steal_lockss was
added to avoid breaking the userspace programs[3][4][6].

Unfortunately it turned out that steal_locks did not work for network
file systems[5], so it was removed to see if anyone would
complain[7][8].  It was thought at the time that NPTL would not be
affected as the unshare_files happened after the other threads were
killed[8].  Unfortunately because there was an unshare_files in
binfmt_elf.c before the threads were killed this analysis was
incorrect.

This unshare_files in binfmt_elf.c resulted in the unshares_files
happening whenever threads were present.  Which led to unshare_files
being moved to the start of do_execve[9].

Later the problems were rediscovered and the suggested approach was to
readd steal_locks under a different name[10].  I happened to be
reviewing patches and I noticed that this approach was a step
backwards[11].

I proposed simply moving unshare_files[12] and it was pointed
out that moving unshare_files without auditing the code was
also unsafe[13].

There were then several attempts to solve this[14][15][16] and I even
posted this set of changes[17].  Unfortunately because auditing all of
execve is time consuming this change did not make it in at the time.

Well now that I am cleaning up exec I have made the time to read
through all of the binfmts and the only playing with file descriptors
is either the security modules closing them in
security_bprm_committing_creds or is in the generic code in fs/exec.c.
None of it happens before begin_new_exec is called.

So move unshare_files into begin_new_exec, after the point of no
return.  If memory is very very very low and the application calling
exec is sharing file descriptor tables between processes we might fail
past the point of no return.  Which is unfortunate but no different
than any of the other places where we allocate memory after the point
of no return.

This movement allows another process that shares the file table, or
another thread of the same process and that closes files or changes
their close on exec behavior and races with execve to cause some
unexpected things to happen.  There is only one time of check to time
of use race and it is just there so that execve fails instead of
an interpreter failing when it tries to open the file it is supposed
to be interpreting.   Failing later if userspace is being silly is
not a problem.

With this change it the following discription from the removal
of steal_locks[8] finally becomes true.

    Apps using NPTL are not affected, since all other threads are killed before
    execve.

    Apps using LinuxThreads are only affected if they

      - have multiple threads during exec (LinuxThreads doesn't kill other
        threads, the app may do it with pthread_kill_other_threads_np())
      - rely on POSIX locks being inherited across exec

    Both conditions are documented, but not their interaction.

    Apps using clone() natively are affected if they

      - use clone(CLONE_FILES)
      - rely on POSIX locks being inherited across exec

I have investigated some paths to make it possible to solve this
without moving unshare_files but they all look more complicated[18].

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Jeff Layton <jlayton@redhat.com>
History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
[1] 02cda956de0b ("[PATCH] unshare_files"
[2] 04e9bcb4d106 ("[PATCH] use new unshare_files helper")
[3] 088f5d7244de ("[PATCH] add steal_locks helper")
[4] 02c541ec8ffa ("[PATCH] use new steal_locks helper")
[5] https://lkml.kernel.org/r/E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu
[6] https://lkml.kernel.org/r/0060321191605.GB15997@sorel.sous-sol.org
[7] https://lkml.kernel.org/r/E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu
[8] c89681ed7d0e ("[PATCH] remove steal_locks()")
[9] fd8328be874f ("[PATCH] sanitize handling of shared descriptor tables in failing execve()")
[10] https://lkml.kernel.org/r/20180317142520.30520-1-jlayton@kernel.org
[11] https://lkml.kernel.org/r/87r2nwqk73.fsf@xmission.com
[12] https://lkml.kernel.org/r/87bmfgvg8w.fsf@xmission.com
[13] https://lkml.kernel.org/r/20180322111424.GE30522@ZenIV.linux.org.uk
[14] https://lkml.kernel.org/r/20180827174722.3723-1-jlayton@kernel.org
[15] https://lkml.kernel.org/r/20180830172423.21964-1-jlayton@kernel.org
[16] https://lkml.kernel.org/r/20180914105310.6454-1-jlayton@kernel.org
[17] https://lkml.kernel.org/r/87a7ohs5ow.fsf@xmission.com
[18] https://lkml.kernel.org/r/87pn8c1uj6.fsf_-_@x220.int.ebiederm.org
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-1-ebiederm@xmission.com
Link: https://lkml.kernel.org/r/20201120231441.29911-1-ebiederm@xmission.com
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fb8813cc532d0..42952cf90f4af 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1245,6 +1245,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
+	struct files_struct *displaced;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1264,6 +1265,13 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/* Ensure the files table is not shared. */
+	retval = unshare_files(&displaced);
+	if (retval)
+		goto out;
+	if (displaced)
+		put_files_struct(displaced);
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visibile until then. This also enables the update
@@ -1789,7 +1797,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 		       int fd, struct filename *filename, int flags)
 {
 	struct file *file;
-	struct files_struct *displaced;
 	int retval;
 
 	/*
@@ -1797,13 +1804,9 @@ static int bprm_execve(struct linux_binprm *bprm,
 	 */
 	io_uring_task_cancel();
 
-	retval = unshare_files(&displaced);
-	if (retval)
-		return retval;
-
 	retval = prepare_bprm_creds(bprm);
 	if (retval)
-		goto out_files;
+		return retval;
 
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
@@ -1818,8 +1821,12 @@ static int bprm_execve(struct linux_binprm *bprm,
 	bprm->file = file;
 	/*
 	 * Record that a name derived from an O_CLOEXEC fd will be
-	 * inaccessible after exec. Relies on having exclusive access to
-	 * current->files (due to unshare_files above).
+	 * inaccessible after exec.  This allows the code in exec to
+	 * choose to fail when the executable is not mmaped into the
+	 * interpreter and an open file descriptor is not passed to
+	 * the interpreter.  This makes for a better user experience
+	 * than having the interpreter start and then immediately fail
+	 * when it finds the executable is inaccessible.
 	 */
 	if (bprm->fdpath && get_close_on_exec(fd))
 		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
@@ -1839,8 +1846,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
-	if (displaced)
-		put_files_struct(displaced);
 	return retval;
 
 out:
@@ -1857,10 +1862,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
-out_files:
-	if (displaced)
-		reset_files_struct(displaced);
-
 	return retval;
 }
 
-- 
2.43.0




