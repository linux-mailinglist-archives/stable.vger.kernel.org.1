Return-Path: <stable+bounces-150247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCCCACB7EB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB4E1C22046
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62341219A9B;
	Mon,  2 Jun 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ylUAK1Yb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205ED1FCFE2;
	Mon,  2 Jun 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876508; cv=none; b=HajqlKIFr17PscRPdoUEdvYp6OQyEN7m8O6Ddi29/zVRPYr3S/yC1AWyFemDJ3euzho29RW/e3BEOGkXhMD5k8jYGEu000isMI5nWy75jUkCIfhnaiGpafqbgRplZM7Ygil84hBumM+4oQ5rdQ2natkzwhR/gu0hMFdhQQiJd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876508; c=relaxed/simple;
	bh=kVmy/9iXLbg3J5Y3UH5Tbdqv7r1RvZ9HRVCFXUnQWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT/CWxGsBNEilqwO/T11lqbKXRUt/QkcetQjnw5t2075YYDCoIrh/bsMSDQ7I9Q0+eQSnfL669tAef/jjbT7I4bppYccqyof+N9/LIB2kDyZjAIAelKwNJ/u+OwAuO/dJeG3Vt6X/by+ZYL4xOIjTnGTBzLD2et+sOXoSOB4REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ylUAK1Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A837EC4CEEB;
	Mon,  2 Jun 2025 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876508;
	bh=kVmy/9iXLbg3J5Y3UH5Tbdqv7r1RvZ9HRVCFXUnQWLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ylUAK1YbrfJMGAbStNvV/pV5pVsCiBwqaDekfU38LYjfF6YotOFy81c8/LEl1mMfY
	 hF5w/7PvdQ05hGe3Z73nANfgdCx0/oIrb9gzISrhHxYiVi7xCfyeZiz1vVm2f6Km6d
	 UcAcwHFI2N3gn0V1jfIupFH/DE8gDP0KipR57UVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 197/207] coredump: hand a pidfd to the usermode coredump helper
Date: Mon,  2 Jun 2025 15:49:29 +0200
Message-ID: <20250602134306.495328068@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit b5325b2a270fcaf7b2a9a0f23d422ca8a5a8bdea upstream.

Give userspace a way to instruct the kernel to install a pidfd into the
usermode helper process. This makes coredump handling a lot more
reliable for userspace. In parallel with this commit we already have
systemd adding support for this in [1].

We create a pidfs file for the coredumping process when we process the
corename pattern. When the usermode helper process is forked we then
install the pidfs file as file descriptor three into the usermode
helpers file descriptor table so it's available to the exec'd program.

Since usermode helpers are either children of the system_unbound_wq
workqueue or kthreadd we know that the file descriptor table is empty
and can thus always use three as the file descriptor number.

Note, that we'll install a pidfd for the thread-group leader even if a
subthread is calling do_coredump(). We know that task linkage hasn't
been removed due to delay_group_leader() and even if this @current isn't
the actual thread-group leader we know that the thread-group leader
cannot be reaped until @current has exited.

[brauner: This is a backport for the v5.14 series. Upstream has
significantly changed and backporting all that infra is a non-starter.
So simply backport the pidfd_prepare() helper and waste the file
descriptor we allocated. Then we minimally massage the umh coredump
setup code.]

Link: https://github.com/systemd/systemd/pull/37125 [1]
Link: https://lore.kernel.org/20250414-work-coredump-v2-3-685bf231f828@kernel.org
Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/coredump.c           |   77 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/binfmts.h |    1 
 2 files changed, 71 insertions(+), 7 deletions(-)

--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,6 +56,13 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
+/*
+ * File descriptor number for the pidfd for the thread-group leader of
+ * the coredumping task installed into the usermode helper's file
+ * descriptor table.
+ */
+#define COREDUMP_PIDFD_NUMBER 3
+
 int core_uses_pid;
 unsigned int core_pipe_limit;
 char core_pattern[CORENAME_MAX_SIZE] = "core";
@@ -327,6 +334,27 @@ static int format_corename(struct core_n
 				err = cn_printf(cn, "%lu",
 					      rlimit(RLIMIT_CORE));
 				break;
+			/* pidfd number */
+			case 'F': {
+				/*
+				 * Installing a pidfd only makes sense if
+				 * we actually spawn a usermode helper.
+				 */
+				if (!ispipe)
+					break;
+
+				/*
+				 * Note that we'll install a pidfd for the
+				 * thread-group leader. We know that task
+				 * linkage hasn't been removed yet and even if
+				 * this @current isn't the actual thread-group
+				 * leader we know that the thread-group leader
+				 * cannot be reaped until @current has exited.
+				 */
+				cprm->pid = task_tgid(current);
+				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
+				break;
+			}
 			default:
 				break;
 			}
@@ -550,7 +578,7 @@ static void wait_for_dump_helpers(struct
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -560,27 +588,62 @@ static void wait_for_dump_helpers(struct
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
+	struct file *pidfs_file = NULL;
 	struct coredump_params *cp = (struct coredump_params *)info->data;
 	int err;
 
+	if (cp->pid) {
+		int fd;
+
+		fd = pidfd_prepare(cp->pid, 0, &pidfs_file);
+		if (fd < 0)
+			return fd;
+
+		/*
+		 * We don't care about the fd. We also cannot simply
+		 * replace it below because dup2() will refuse to close
+		 * this file descriptor if its in a larval state. So
+		 * close it!
+		 */
+		put_unused_fd(fd);
+
+		/*
+		 * Usermode helpers are childen of either
+		 * system_unbound_wq or of kthreadd. So we know that
+		 * we're starting off with a clean file descriptor
+		 * table. So we should always be able to use
+		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
+		 */
+		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
+		if (err < 0)
+			goto out_fail;
+
+		pidfs_file = NULL;
+	}
+
 	err = create_pipe_files(files, 0);
 	if (err)
-		return err;
+		goto out_fail;
 
 	cp->file = files[1];
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
 	if (err < 0)
-		return err;
+		goto out_fail;
 
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
-	return 0;
+	err = 0;
+
+out_fail:
+	if (pidfs_file)
+		fput(pidfs_file);
+	return err;
 }
 
 void do_coredump(const kernel_siginfo_t *siginfo)
@@ -656,7 +719,7 @@ void do_coredump(const kernel_siginfo_t
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -701,7 +764,7 @@ void do_coredump(const kernel_siginfo_t
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -90,6 +90,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct pid *pid;
 };
 
 /*



