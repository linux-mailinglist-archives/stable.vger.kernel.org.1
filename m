Return-Path: <stable+bounces-249340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHlROv0/C2p4FAUAu9opvQ
	(envelope-from <stable+bounces-249340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:36:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BE57102B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 661A93039C8E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024F48B384;
	Mon, 18 May 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukhi34VE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA048A2D1
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122132; cv=none; b=GEasNkaipgcp6Hrd6rFN6Wwi5bF8BROSJ1wLA4BWMl3ZqDU4toHnkLXWiLc730qF4qxc4Xz1Aiqyq8m0Ms7cmSs3/aPuEGlz/GAh9njZFFx7co1Hx7eLYW0Z4TtsNxvph/pJcjid+65A2nNIyhPl7VFZdNl/LlW6WW+FZwcrZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122132; c=relaxed/simple;
	bh=J6vYP+pwxqJtl3IXGpjK6NcN9iylazyz59URcLbnfuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gR+tdX4DZEfuJ56iu6HnNXIJ5ZSso8fNXUE84OhKRD4HPAt1ihr2NKonf7uc40lnBms6VrKpdml9m8rWM37UdC40xC4KlBB7vQ0XcyyMsDn+3CswTo6+vK7hKkz4dZD3mPEtuYSut+w+uPpXoTOHd+YSwePiGoiYq781pxOsJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukhi34VE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d1c670255so375e9.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122128; x=1779726928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JIolJGgKb991CwNklVUCVvleyM5JMSNh06xqnYIkkE=;
        b=ukhi34VE7hisDw8lB9rjG8v4kOMjx9/9N+vbJOg9cN2rdFS4tLh3yx3DwwwrTB1+bn
         QyOHu0q7mDWGdRK3CGDh4oT5idAc6UoeD2P1+k9ODKsRWSTapIlF5qHx/qjiQ0RMkJVf
         2afRtWw4YpBCeq/fAyq4DVWK8yU9UVo9KfXKHRKFI3H8d5thqlBDJxFl4n4uS4k1C9IV
         etxsoRGc/6kve1d9hFgV4YtIhtmwFzp15rhFRyaKSnFyGQbWMbuBaakohMlKOGkxuAnK
         mPZI7s5bUYm6GUOVvdXO1H7hVOVa/cJB5c8z4GsvUmiFRhzg1FICol5EZj3BqC+vB4zm
         AExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122128; x=1779726928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9JIolJGgKb991CwNklVUCVvleyM5JMSNh06xqnYIkkE=;
        b=h0F0lJONEKpaLgXdrqrZ7IQEV52x9CQ8XUdT3uk8PVnFafU+IcKW/WLCwfc5uazGfh
         mJnbqLCOGUcDy9I2uGWiqoT+WcNkfmxyIMuEBpPD8GEijozVwE4CvkDNzJgnc8H65gQ0
         BR5dnw01oMGRrmRBRRbPTJ8s7NutHVWeUUKZAq88k8SUSKcd4NV2BSX0XMps2TphzLIU
         CcAv23vzSIDdcTmHXjR/10Fsd8C8zcc272+WxzfA1dVdUjAjWn08wCMbXevMLS2Tfv8d
         e7o4yJ/4o1kEYEuFQyz5M7Ezxg1GYJyxzeO18uo43dOlVm7m3a0TRDQ8gufTLHPJWW2S
         rFeg==
X-Forwarded-Encrypted: i=1; AFNElJ9T/6LoFmDWkHirXIim6gNV78FVThMWMMRqtVj//Nb/Y7SPGPXuHoEZdKFRDqVGTbeLuwpJAQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWq4wyhlbgbWp+O97VT7xNSeEv5Ytevahh6rg5LVlW7inL2xxT
	hUUs7BvOyrLg8VuoALvZZwikqqhnFQ00UoouFLcsP/9KTcEvq7fagKF3kMoFcgrVZA==
X-Gm-Gg: Acq92OHN8Srx/XjuY9gIr2uXVqLP/kgM5ZyuDJ4sIExO5Z173awDVe7itHp554PubVT
	EUWDP+KuzYl/0UiNNlqwTiX2n3Ahs8y5PJxcti6Mv1cwg54vwgz6eKHDesUxiw81iMU93qnkCF9
	p/+p9GW9CkxuFq+UDlKzCeFe91KvVa5J8wZAG4USKK74KRwihG8rHmeUKwwPQM60PsVxPwsxva5
	e1pUYHvBKJ1GT4gUXraDt47hH94N31jzAwvyXuGa79Rw/g7ofvloA8ESEM5sZOPWB4Nhqnmdp/U
	2gwyJ6fzxsyD+B/sDBPWb7rLqb7BpJTXRudjVVFoZOKh3iXxmOQ7HJAskz7djph+bm+RLPzKEaw
	2mjutS0x/5lSznUUkh7h3m+6k7akcto3RDw2dxj5AxL1amrFjylihTX8l9+h0ZYyFcRh7PQcBXJ
	lpYfT3qjpPAMsWXwPwjywPIqOB8YeDZ/MhDUoyIYzBq6zgN3SLLP8nmP82EqSO
X-Received: by 2002:a05:600c:6986:b0:485:2ab4:c1f9 with SMTP id 5b1f17b1804b1-48ffa5a381fmr2897155e9.4.1779122127357;
        Mon, 18 May 2026 09:35:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:866a:e549:273b:bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm40394849f8f.23.2026.05.18.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:35:26 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:35:16 +0200
Subject: [PATCH 2/2] proc: protect ptrace_may_access() with
 exec_update_lock (FD links)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-procfs-lockfix-part1-v1-2-5c3d20e0ac33@google.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
In-Reply-To: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779122120; l=7748;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=J6vYP+pwxqJtl3IXGpjK6NcN9iylazyz59URcLbnfuQ=;
 b=VGuWqwO60b4SF4T9W/cDNEZOqXEC7aVVevIZX9SsSb7uy7X+b/lA73E07zjsjHEDTj1bkJKC4
 Sr5mX0rxXNWBNf5FqcB4mV1qb5KBWiQZz4gXJvCc1GPzB4bRclzXhJN
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249340-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 897BE57102B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

proc_pid_get_link() and proc_pid_readlink() currently look up the task from
the pid once, then do the ptrace access check on that task, then look up
the task from the pid a second time to do the actual access.
That's racy in several ways.

To fix it, pass the task to the ->proc_get_link() handler, and instead of
proc_fd_access_allowed(), introduce a new helper call_proc_get_link() that
looks up and locks the task, does the access check, and calls
->proc_get_link().

Fixes: 778c1144771f ("[PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/ symlinks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c     | 119 +++++++++++++++++++++--------------------------------
 fs/proc/fd.c       |  27 +++++-------
 fs/proc/internal.h |   2 +-
 3 files changed, 59 insertions(+), 89 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 09b02d1621e5..ef2f59461374 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -218,33 +218,24 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	return result;
 }
 
-static int proc_cwd_link(struct dentry *dentry, struct path *path)
+static int proc_cwd_link(struct dentry *dentry, struct path *path,
+			 struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
 	int result = -ENOENT;
 
-	if (task) {
-		task_lock(task);
-		if (task->fs) {
-			get_fs_pwd(task->fs, path);
-			result = 0;
-		}
-		task_unlock(task);
-		put_task_struct(task);
+	task_lock(task);
+	if (task->fs) {
+		get_fs_pwd(task->fs, path);
+		result = 0;
 	}
+	task_unlock(task);
 	return result;
 }
 
-static int proc_root_link(struct dentry *dentry, struct path *path)
+static int proc_root_link(struct dentry *dentry, struct path *path,
+			  struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
-	int result = -ENOENT;
-
-	if (task) {
-		result = get_task_root(task, path);
-		put_task_struct(task);
-	}
-	return result;
+	return get_task_root(task, path);
 }
 
 /*
@@ -710,23 +701,6 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 /*                       Here the fs part begins                        */
 /************************************************************************/
 
-/* permission checks */
-static bool proc_fd_access_allowed(struct inode *inode)
-{
-	struct task_struct *task;
-	bool allowed = false;
-	/* Allow access to a task's file descriptors if it is us or we
-	 * may use ptrace attach to the process and find out that
-	 * information.
-	 */
-	task = get_proc_task(inode);
-	if (task) {
-		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
-		put_task_struct(task);
-	}
-	return allowed;
-}
-
 int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
@@ -1783,16 +1757,12 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
+			 struct task_struct *task)
 {
-	struct task_struct *task;
 	struct file *exe_file;
 
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		return -ENOENT;
 	exe_file = get_task_exe_file(task);
-	put_task_struct(task);
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
@@ -1802,26 +1772,42 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 		return -ENOENT;
 }
 
+static int call_proc_get_link(struct dentry *dentry, struct inode *inode, struct path *path_out)
+{
+	struct task_struct *task;
+	int ret;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return -ENOENT;
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		goto out_put_task;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		ret = -EACCES;
+		goto out;
+	}
+	ret = PROC_I(inode)->op.proc_get_link(dentry, path_out, task);
+
+out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
+	put_task_struct(task);
+	return ret;
+}
+
 static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct inode *inode,
 				     struct delayed_call *done)
 {
 	struct path path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
-
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = nd_jump_link(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error)
+		error = nd_jump_link(&path);
 	return ERR_PTR(error);
 }
 
@@ -1855,17 +1841,11 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 	struct inode *inode = d_inode(dentry);
 	struct path path;
 
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = do_proc_readlink(&path, buffer, buflen);
-	path_put(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error) {
+		error = do_proc_readlink(&path, buffer, buflen);
+		path_put(&path);
+	}
 	return error;
 }
 
@@ -2256,21 +2236,16 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path)
+static int map_files_get_link(struct dentry *dentry, struct path *path,
+			      struct task_struct *task)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
-	struct task_struct *task;
 	struct mm_struct *mm;
 	int rc;
 
 	rc = -ENOENT;
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		goto out;
-
 	mm = get_task_mm(task);
-	put_task_struct(task);
 	if (!mm)
 		goto out;
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 05c7513e77c7..0f9a1556f2a3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -171,24 +171,19 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+			struct task_struct *task)
 {
-	struct task_struct *task;
 	int ret = -ENOENT;
-
-	task = get_proc_task(d_inode(dentry));
-	if (task) {
-		unsigned int fd = proc_fd(d_inode(dentry));
-		struct file *fd_file;
-
-		fd_file = fget_task(task, fd);
-		if (fd_file) {
-			*path = fd_file->f_path;
-			path_get(&fd_file->f_path);
-			ret = 0;
-			fput(fd_file);
-		}
-		put_task_struct(task);
+	unsigned int fd = proc_fd(d_inode(dentry));
+	struct file *fd_file;
+
+	fd_file = fget_task(task, fd);
+	if (fd_file) {
+		*path = fd_file->f_path;
+		path_get(&fd_file->f_path);
+		ret = 0;
+		fput(fd_file);
 	}
 
 	return ret;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 64dc44832808..d31984c3c797 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -107,7 +107,7 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
 union proc_op {
-	int (*proc_get_link)(struct dentry *, struct path *);
+	int (*proc_get_link)(struct dentry *, struct path *, struct task_struct *);
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);

-- 
2.54.0.563.g4f69b47b94-goog


