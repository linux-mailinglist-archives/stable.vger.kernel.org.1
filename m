Return-Path: <stable+bounces-118769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9BA41B16
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186113AB152
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F3933993;
	Mon, 24 Feb 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uKguSruU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BE18EB0
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393094; cv=none; b=KSkgZ2Cmzn8zQuEMMQbMRQjB0jZtIM9F/r2Gw7Vi5zaM3Ys1snr5GdmWwK9kBWovgTx7ZUncqVeuF6H02cT+/TSXz8YuTCv1msmwgu3YzBNNVl6dYkBJsVYrGeqKZMc3dBN6+UGfHIP1N/JGoj2Ny7o06uOOeYU97VAPwA+bznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393094; c=relaxed/simple;
	bh=cprmTRN+o+TVWuh5V4QPaibUPQ7c2x07Za20Lsd1kwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YyDMJ9FB8n3rdEiW6ADDNW9QRzdZoyVznvi+R8PkJ+ChEUS+OuhxqltseWhCBYd8JSn6CFTBGVS/kgxwICK95RYXdqLWtYPfxU96juCsW+qPdO3/nO9GIE8Gs9mE2CzaOb8MFJy4BDG8oGQaybiW56bPNWf1np+Pn4HAXqbVk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uKguSruU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93544C4CED6;
	Mon, 24 Feb 2025 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740393094;
	bh=cprmTRN+o+TVWuh5V4QPaibUPQ7c2x07Za20Lsd1kwI=;
	h=Subject:To:Cc:From:Date:From;
	b=uKguSruUStOzXlOx2IkdY5R+wei3XRSmVmT4f9nPX41GXJ2g8A8ollHSk1aDvuHxG
	 oE3XfGOUf/r05BVdPmgCLhwhgXbTDLB6uT1yb3mib9So0xtEsNqMEySOCsumcZ360d
	 GjUWU5dBVHB8KGlRpDtDlLi2sWqgHlgCUxO41Oz8=
Subject: FAILED: patch "[PATCH] acct: perform last write from workqueue" failed to apply to 5.10-stable tree
To: brauner@kernel.org,quzicheng@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:31:14 +0100
Message-ID: <2025022414-grumble-cahoots-e4b7@gregkh>
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
git cherry-pick -x 56d5f3eba3f5de0efdd556de4ef381e109b973a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022414-grumble-cahoots-e4b7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56d5f3eba3f5de0efdd556de4ef381e109b973a9 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Feb 2025 18:15:59 +0100
Subject: [PATCH] acct: perform last write from workqueue

In [1] it was reported that the acct(2) system call can be used to
trigger NULL deref in cases where it is set to write to a file that
triggers an internal lookup. This can e.g., happen when pointing acc(2)
to /sys/power/resume. At the point the where the write to this file
happens the calling task has already exited and called exit_fs(). A
lookup will thus trigger a NULL-deref when accessing current->fs.

Reorganize the code so that the the final write happens from the
workqueue but with the caller's credentials. This preserves the
(strange) permission model and has almost no regression risk.

This api should stop to exist though.

Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com [1]
Link: https://lore.kernel.org/r/20250211-work-acct-v1-1-1c16aecab8b3@kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zicheng Qu <quzicheng@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/kernel/acct.c b/kernel/acct.c
index 31222e8cd534..48283efe8a12 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -103,48 +103,50 @@ struct bsd_acct_struct {
 	atomic_long_t		count;
 	struct rcu_head		rcu;
 	struct mutex		lock;
-	int			active;
+	bool			active;
+	bool			check_space;
 	unsigned long		needcheck;
 	struct file		*file;
 	struct pid_namespace	*ns;
 	struct work_struct	work;
 	struct completion	done;
+	acct_t			ac;
 };
 
-static void do_acct_process(struct bsd_acct_struct *acct);
+static void fill_ac(struct bsd_acct_struct *acct);
+static void acct_write_process(struct bsd_acct_struct *acct);
 
 /*
  * Check the amount of free space and suspend/resume accordingly.
  */
-static int check_free_space(struct bsd_acct_struct *acct)
+static bool check_free_space(struct bsd_acct_struct *acct)
 {
 	struct kstatfs sbuf;
 
-	if (time_is_after_jiffies(acct->needcheck))
-		goto out;
+	if (!acct->check_space)
+		return acct->active;
 
 	/* May block */
 	if (vfs_statfs(&acct->file->f_path, &sbuf))
-		goto out;
+		return acct->active;
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
-			acct->active = 0;
+			acct->active = false;
 			pr_info("Process accounting paused\n");
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
-			acct->active = 1;
+			acct->active = true;
 			pr_info("Process accounting resumed\n");
 		}
 	}
 
 	acct->needcheck = jiffies + ACCT_TIMEOUT*HZ;
-out:
 	return acct->active;
 }
 
@@ -189,7 +191,11 @@ static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
 	mutex_lock(&acct->lock);
-	do_acct_process(acct);
+	/*
+	 * Fill the accounting struct with the exiting task's info
+	 * before punting to the workqueue.
+	 */
+	fill_ac(acct);
 	schedule_work(&acct->work);
 	wait_for_completion(&acct->done);
 	cmpxchg(&acct->ns->bacct, pin, NULL);
@@ -202,6 +208,9 @@ static void close_work(struct work_struct *work)
 {
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
+
+	/* We were fired by acct_pin_kill() which holds acct->lock. */
+	acct_write_process(acct);
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -430,13 +439,27 @@ static u32 encode_float(u64 value)
  *  do_exit() or when switching to a different output file.
  */
 
-static void fill_ac(acct_t *ac)
+static void fill_ac(struct bsd_acct_struct *acct)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
+	struct file *file = acct->file;
+	acct_t *ac = &acct->ac;
 	u64 elapsed, run_time;
 	time64_t btime;
 	struct tty_struct *tty;
 
+	lockdep_assert_held(&acct->lock);
+
+	if (time_is_after_jiffies(acct->needcheck)) {
+		acct->check_space = false;
+
+		/* Don't fill in @ac if nothing will be written. */
+		if (!acct->active)
+			return;
+	} else {
+		acct->check_space = true;
+	}
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
@@ -484,64 +507,61 @@ static void fill_ac(acct_t *ac)
 	ac->ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac->ac_exitcode = pacct->ac_exitcode;
 	spin_unlock_irq(&current->sighand->siglock);
-}
-/*
- *  do_acct_process does all actual work. Caller holds the reference to file.
- */
-static void do_acct_process(struct bsd_acct_struct *acct)
-{
-	acct_t ac;
-	unsigned long flim;
-	const struct cred *orig_cred;
-	struct file *file = acct->file;
 
-	/*
-	 * Accounting records are not subject to resource limits.
-	 */
-	flim = rlimit(RLIMIT_FSIZE);
-	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
-
-	/*
-	 * First check to see if there is enough free_space to continue
-	 * the process accounting system.
-	 */
-	if (!check_free_space(acct))
-		goto out;
-
-	fill_ac(&ac);
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = from_kuid_munged(file->f_cred->user_ns, orig_cred->uid);
-	ac.ac_gid = from_kgid_munged(file->f_cred->user_ns, orig_cred->gid);
+	ac->ac_uid = from_kuid_munged(file->f_cred->user_ns, current_uid());
+	ac->ac_gid = from_kgid_munged(file->f_cred->user_ns, current_gid());
 #if ACCT_VERSION == 1 || ACCT_VERSION == 2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = ac.ac_uid;
-	ac.ac_gid16 = ac.ac_gid;
+	ac->ac_uid16 = ac->ac_uid;
+	ac->ac_gid16 = ac->ac_gid;
 #elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-		ac.ac_pid = task_tgid_nr_ns(current, ns);
+		ac->ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac->ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent), ns);
 		rcu_read_unlock();
 	}
 #endif
+}
+
+static void acct_write_process(struct bsd_acct_struct *acct)
+{
+	struct file *file = acct->file;
+	const struct cred *cred;
+	acct_t *ac = &acct->ac;
+
+	/* Perform file operations on behalf of whoever enabled accounting */
+	cred = override_creds(file->f_cred);
+
 	/*
-	 * Get freeze protection. If the fs is frozen, just skip the write
-	 * as we could deadlock the system otherwise.
+	 * First check to see if there is enough free_space to continue
+	 * the process accounting system. Then get freeze protection. If
+	 * the fs is frozen, just skip the write as we could deadlock
+	 * the system otherwise.
 	 */
-	if (file_start_write_trylock(file)) {
+	if (check_free_space(acct) && file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-out:
+
+	revert_creds(cred);
+}
+
+static void do_acct_process(struct bsd_acct_struct *acct)
+{
+	unsigned long flim;
+
+	/* Accounting records are not subject to resource limits. */
+	flim = rlimit(RLIMIT_FSIZE);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	fill_ac(acct);
+	acct_write_process(acct);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
 }
 
 /**


