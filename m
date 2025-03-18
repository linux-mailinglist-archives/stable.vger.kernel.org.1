Return-Path: <stable+bounces-124837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B136AA6792C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E94519C4557
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1C2101BD;
	Tue, 18 Mar 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TPpgldlJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71E20DD59
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314814; cv=none; b=p6HRyPY90XTNmmmiHHBtn1Gzo8aktdM9tnmm/XW8/s0yYnzNQcCFHRHqrPzgtCy/Tv6Fm2JDtBnigaMigoZQjsoeV5FRnWtxOdzWL3pFBrqSZELHQmDhQLRwd92DxQKM8MlsbtenH+d2H27TqSsW38b5aCX0LCn/n2H2I89X2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314814; c=relaxed/simple;
	bh=SWUFyclMEDRn/vERlm7WudHu+qwRw8rij0FmLjXeJwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9w8yXXmnuWhfrlo/1jzjALZFBg0FkWkQ44LbyNLmogzLqWta2R4XKkGcDUSwY8nHeqrJ2AsONZJloRlruo7c5crWFPDqfyWl95vFCszIHfhcKXpt3E17Lezf6ekvIarKcO92d0FZzSVMeBCL9OjxtlUDAT8SFaIJuKh9EWrT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TPpgldlJ; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH41410czKmb;
	Tue, 18 Mar 2025 17:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314497;
	bh=dKAVrbb92NHt/wrbgBJH5t1iGYU5WOEUkcj7GfcPvjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPpgldlJQqtwWlGXhLAdvAQDZNcA19DXMGLjYAYxZdYTgPcuoEpD/8KW/Ns6h9dLK
	 XFOKGoC/4wwqB6Kh7jq8grgT335ZzN6LFtiwomwy7VNQF7E9OVhEi8NuFD1DN9B2ae
	 QzxWVUcCTUkH9K14XqK5mOJoSAXCd73HTYrHTwJw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH404t2nzTlH;
	Tue, 18 Mar 2025 17:14:56 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 5/8] landlock: Always allow signals between threads of the same process
Date: Tue, 18 Mar 2025 17:14:40 +0100
Message-ID: <20250318161443.279194-6-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because Linux credentials are managed per thread, user space relies on
some hack to synchronize credential update across threads from the same
process.  This is required by the Native POSIX Threads Library and
implemented by set*id(2) wrappers and libcap(3) to use tgkill(2) to
synchronize threads.  See nptl(7) and libpsx(3).  Furthermore, some
runtimes like Go do not enable developers to have control over threads
[1].

To avoid potential issues, and because threads are not security
boundaries, let's relax the Landlock (optional) signal scoping to always
allow signals sent between threads of the same process.  This exception
is similar to the __ptrace_may_access() one.

hook_file_set_fowner() now checks if the target task is part of the same
process as the caller.  If this is the case, then the related signal
triggered by the socket will always be allowed.

Scoping of abstract UNIX sockets is not changed because kernel objects
(e.g. sockets) should be tied to their creator's domain at creation
time.

Note that creating one Landlock domain per thread puts each of these
threads (and their future children) in their own scope, which is
probably not what users expect, especially in Go where we do not control
threads.  However, being able to drop permissions on all threads should
not be restricted by signal scoping.  We are working on a way to make it
possible to atomically restrict all threads of a process with the same
domain [2].

Add erratum for signal scoping.

Closes: https://github.com/landlock-lsm/go-landlock/issues/36
Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Depends-on: 26f204380a3c ("fs: Fix file_set_fowner LSM hook inconsistencies")
Link: https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/psx [1]
Link: https://github.com/landlock-lsm/linux/issues/2 [2]
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-6-mic@digikod.net
---

Changes since v1:
- Add Acked-by Christian.
- Add Landlock erratum.
- Update subject.
---
 security/landlock/errata/abi-6.h              | 19 ++++++++++++++++
 security/landlock/fs.c                        | 22 +++++++++++++++----
 security/landlock/task.c                      | 12 ++++++++++
 .../selftests/landlock/scoped_signal_test.c   |  2 +-
 4 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 security/landlock/errata/abi-6.h

diff --git a/security/landlock/errata/abi-6.h b/security/landlock/errata/abi-6.h
new file mode 100644
index 000000000000..df7bc0e1fdf4
--- /dev/null
+++ b/security/landlock/errata/abi-6.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_2
+ *
+ * Erratum 2: Scoped signal handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where signal scoping was overly restrictive,
+ * preventing sandboxed threads from signaling other threads within the same
+ * process if they belonged to different domains.  Because threads are not
+ * security boundaries, user space might assume that any thread within the same
+ * process can send signals between themselves (see :manpage:`nptl(7)` and
+ * :manpage:`libpsx(3)`).  Consistent with :manpage:`ptrace(2)` behavior, direct
+ * interaction between threads of the same process should always be allowed.
+ * This change ensures that any thread is allowed to send signals to any other
+ * thread within the same process, regardless of their domain.
+ */
+LANDLOCK_ERRATUM(2)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 71b9dc331aae..47c862fe14e4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -27,7 +27,9 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 #include <linux/spinlock.h>
 #include <linux/stat.h>
 #include <linux/types.h>
@@ -1630,15 +1632,27 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
 
 static void hook_file_set_fowner(struct file *file)
 {
-	struct landlock_ruleset *new_dom, *prev_dom;
+	struct fown_struct *fown = file_f_owner(file);
+	struct landlock_ruleset *new_dom = NULL;
+	struct landlock_ruleset *prev_dom;
+	struct task_struct *p;
 
 	/*
 	 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
 	 * file_set_fowner LSM hook inconsistencies").
 	 */
-	lockdep_assert_held(&file_f_owner(file)->lock);
-	new_dom = landlock_get_current_domain();
-	landlock_get_ruleset(new_dom);
+	lockdep_assert_held(&fown->lock);
+
+	/*
+	 * Always allow sending signals between threads of the same process.  This
+	 * ensures consistency with hook_task_kill().
+	 */
+	p = pid_task(fown->pid, fown->pid_type);
+	if (!same_thread_group(p, current)) {
+		new_dom = landlock_get_current_domain();
+		landlock_get_ruleset(new_dom);
+	}
+
 	prev_dom = landlock_file(file)->fown_domain;
 	landlock_file(file)->fown_domain = new_dom;
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index dc7dab78392e..4578ce6e319d 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -13,6 +13,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <net/af_unix.h>
 #include <net/sock.h>
 
@@ -264,6 +265,17 @@ static int hook_task_kill(struct task_struct *const p,
 		/* Dealing with USB IO. */
 		dom = landlock_cred(cred)->domain;
 	} else {
+		/*
+		 * Always allow sending signals between threads of the same process.
+		 * This is required for process credential changes by the Native POSIX
+		 * Threads Library and implemented by the set*id(2) wrappers and
+		 * libcap(3) with tgkill(2).  See nptl(7) and libpsx(3).
+		 *
+		 * This exception is similar to the __ptrace_may_access() one.
+		 */
+		if (same_thread_group(p, current))
+			return 0;
+
 		dom = landlock_get_current_domain();
 	}
 	dom = landlock_get_applicable_domain(dom, signal_scope);
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 475ee62a832d..767f117703b7 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -281,7 +281,7 @@ TEST(signal_scoping_threads)
 	/* Restricts the domain after creating the first thread. */
 	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
 
-	ASSERT_EQ(EPERM, pthread_kill(no_sandbox_thread, 0));
+	ASSERT_EQ(0, pthread_kill(no_sandbox_thread, 0));
 	ASSERT_EQ(1, write(thread_pipe[1], ".", 1));
 
 	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
-- 
2.48.1


