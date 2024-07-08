Return-Path: <stable+bounces-58224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179C92A341
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B4D281011
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E1824A1;
	Mon,  8 Jul 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHPRp32T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E081AD2
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443125; cv=none; b=hMp09Ke6r9S26NqhbUQ0Jo0CCgiiMcB7CjO9uJPTqy0CshO30eZXwNWfn0ec3VFwe9q/6p3HU2wI/eQ96ZL5mYNy2xKxcHo8kYYP7h8aYQ3omiLm0NKF/8Gwm9HaSk2mfzAkANGwoeDwwbgBVFxQEnvzjiyzE2F5CgGymyKVAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443125; c=relaxed/simple;
	bh=MlWAef71KRfNo5YehGPXEHOZCRtHa9usHAy4i2l4ors=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qELEMtbQvogGoiYn1T5vHaeVEPKk4Ls5f2gHfNxQIyqeKn7Q8yqTDi71t6pc4qRNIubWHH2h+Vd+t5e8adV/3FyTaC7R/TyObSHpedsPP0I0vMdd+G9knpZ2q0oVNmqOAOSIUT57Fsy1gii2I90kl454ZqoVrYdX4yGgtpuL+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHPRp32T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B3C116B1;
	Mon,  8 Jul 2024 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443124;
	bh=MlWAef71KRfNo5YehGPXEHOZCRtHa9usHAy4i2l4ors=;
	h=Subject:To:Cc:From:Date:From;
	b=SHPRp32ThlFKY7rjW6c1xzylpvcN+INd8fzJC8blihzpuESnvUqKUYjgW6Yq0Rshk
	 V0S7kNp6/KCbbpcx8hQi/z1hypZxQRCRnuMCruQkhGEiGhyEuJrQxFAJ8Fu1ZJxC7V
	 5p7EbzF/mw1G4Jqo5kxl1pAbnXFgSH3I1fquzGTk=
Subject: FAILED: patch "[PATCH] filelock: Remove locks reliably when fcntl/close race is" failed to apply to 6.1-stable tree
To: jannh@google.com,brauner@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:51:59 +0200
Message-ID: <2024070859-celibacy-goldsmith-46fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3cad1bc010416c6dd780643476bc59ed742436b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070859-celibacy-goldsmith-46fd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3cad1bc01041 ("filelock: Remove locks reliably when fcntl/close race is detected")
4ca52f539865 ("filelock: have fs/locks.c deal with file_lock_core directly")
a69ce85ec9af ("filelock: split common fields into struct file_lock_core")
3d40f78169a0 ("filelock: drop the IS_* macros")
75cabec0111b ("filelock: add some new helper functions")
587a67b6830b ("filelock: rename some fields in tracepoints")
0e9876d8e88d ("filelock: fl_pid field should be signed int")
6c9007f65d14 ("fs/locks: F_UNLCK extension for F_OFD_GETLK")
dc592190a554 ("fs/locks: Remove redundant assignment to cmd")
3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3cad1bc010416c6dd780643476bc59ed742436b9 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 2 Jul 2024 18:26:52 +0200
Subject: [PATCH] filelock: Remove locks reliably when fcntl/close race is
 detected

When fcntl_setlk() races with close(), it removes the created lock with
do_lock_file_wait().
However, LSMs can allow the first do_lock_file_wait() that created the lock
while denying the second do_lock_file_wait() that tries to remove the lock.
In theory (but AFAIK not in practice), posix_lock_file() could also fail to
remove a lock due to GFP_KERNEL allocation failure (when splitting a range
in the middle).

After the bug has been triggered, use-after-free reads will occur in
lock_get_status() when userspace reads /proc/locks. This can likely be used
to read arbitrary kernel memory, but can't corrupt kernel memory.
This only affects systems with SELinux / Smack / AppArmor / BPF-LSM in
enforcing mode and only works from some security contexts.

Fix it by calling locks_remove_posix() instead, which is designed to
reliably get rid of POSIX locks associated with the given file and
files_struct and is also used by filp_flush().

Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
Cc: stable@kernel.org
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20240702-fs-lock-recover-2-v1-1-edd456f63789@google.com
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/locks.c b/fs/locks.c
index 90c8746874de..c360d1992d21 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2448,8 +2448,9 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->c.flc_type != F_UNLCK &&
@@ -2464,9 +2465,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->c.flc_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}


