Return-Path: <stable+bounces-81458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0E993536
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB89B20AD3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4701DDA1F;
	Mon,  7 Oct 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8tlhxTe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5241DDA15
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322869; cv=none; b=TYdsfypC2bFgPwA8jKzgydf3wzTj25+x7e+d3oZaXab+WPzSGISCqt/qz0Gwe/m0YsZAkttSTeMOeAFSD+dQSY9iVmtj0fL3n6Wl+29HwJ+KkQKRARHLUDl9p+sARegCDfAKuvdI7N44lyWvC/4sVvUcjnzIWGpRFEeT1jXA83I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322869; c=relaxed/simple;
	bh=7BSaHzrHSCMRKVmhnPuYU0niWj9Xx0tG60DDvvxeXN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sagydrvnUXDxFVoRVhSjGgM26ojGVgtxI9CcjrPXwCiVN1nOjcO+q5qaaOdefrvY1If/AAc4yooqvc+z9MhPv/tAVv/NpLxcpbvJ4IaqhOaCqtJ5cG0KeidMBt5TcepyLPwousMieWQv0xsUp0QQBnKRaC/9YYKJNOHr28UqQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8tlhxTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66345C4CEC7;
	Mon,  7 Oct 2024 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322869;
	bh=7BSaHzrHSCMRKVmhnPuYU0niWj9Xx0tG60DDvvxeXN0=;
	h=Subject:To:Cc:From:Date:From;
	b=B8tlhxTexwyLHenF2DGfTuwYifxxlQIXyWylb5a75SrHikXigIIN05ICLlGIVK6un
	 JfcpwKLSn/WN5+yhJQviA/gBhDPT9QeVkA8U4Ym2VGaRqEaiqUmcUaSpIuLESen19R
	 GG16MNjpuo/5qigAVhGfVe1wHO+V49nWrHiC2OHI=
Subject: FAILED: patch "[PATCH] close_range(): fix the logics in descriptor table trimming" failed to apply to 5.10-stable tree
To: viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:41:05 +0200
Message-ID: <2024100705-pursuable-relenting-ba02@gregkh>
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
git cherry-pick -x 678379e1d4f7443b170939525d3312cfc37bf86b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100705-pursuable-relenting-ba02@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

678379e1d4f7 ("close_range(): fix the logics in descriptor table trimming")
c4aab26253cd ("fd_is_open(): move to fs/file.c")
f60d374d2cc8 ("close_on_exec(): pass files_struct instead of fdtable")
a88c955fcfb4 ("file: s/close_fd_get_file()/file_close_fd()/g")
021a160abf62 ("fs: use __fput_sync in close(2)")
11f3f500ec8a ("fork: add kernel_clone_args flag to not dup/clone files")
54e6842d0775 ("fork/vm: Move common PF_IO_WORKER behavior to new flag")
c81cc5819faf ("kernel: Make io_thread and kthread bit fields")
fb04563d1cae ("sched: Show PF_flag holes")
f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
9963e444f71e ("sched: Widen TAKS_state literals")
f9fc8cad9728 ("sched: Add TASK_ANY for wait_task_inactive()")
9204a97f7ae8 ("sched: Change wait_task_inactive()s match_state")
1fbcaa923ce2 ("freezer,umh: Clean up freezer/initrd interaction")
5950e5d574c6 ("freezer: Have {,un}lock_system_sleep() save/restore flags")
0b9d46fc5ef7 ("sched: Rename task_running() to task_on_cpu()")
8386c414e27c ("PM: hibernate: defer device probing when resuming from hibernation")
6684cf42906f ("Merge tag 'pull-work.fd-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 678379e1d4f7443b170939525d3312cfc37bf86b Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 16 Aug 2024 15:17:00 -0400
Subject: [PATCH] close_range(): fix the logics in descriptor table trimming

Cloning a descriptor table picks the size that would cover all currently
opened files.  That's fine for clone() and unshare(), but for close_range()
there's an additional twist - we clone before we close, and it would be
a shame to have
	close_range(3, ~0U, CLOSE_RANGE_UNSHARE)
leave us with a huge descriptor table when we are not going to keep
anything past stderr, just because some large file descriptor used to
be open before our call has taken it out.

Unfortunately, it had been dealt with in an inherently racy way -
sane_fdtable_size() gets a "don't copy anything past that" argument
(passed via unshare_fd() and dup_fd()), close_range() decides how much
should be trimmed and passes that to unshare_fd().

The problem is, a range that used to extend to the end of descriptor
table back when close_range() had looked at it might very well have stuff
grown after it by the time dup_fd() has allocated a new files_struct
and started to figure out the capacity of fdtable to be attached to that.

That leads to interesting pathological cases; at the very least it's a
QoI issue, since unshare(CLONE_FILES) is atomic in a sense that it takes
a snapshot of descriptor table one might have observed at some point.
Since CLOSE_RANGE_UNSHARE close_range() is supposed to be a combination
of unshare(CLONE_FILES) with plain close_range(), ending up with a
weird state that would never occur with unshare(2) is confusing, to put
it mildly.

It's not hard to get rid of - all it takes is passing both ends of the
range down to sane_fdtable_size().  There we are under ->files_lock,
so the race is trivially avoided.

So we do the following:
	* switch close_files() from calling unshare_fd() to calling
dup_fd().
	* undo the calling convention change done to unshare_fd() in
60997c3d45d9 "close_range: add CLOSE_RANGE_UNSHARE"
	* introduce struct fd_range, pass a pointer to that to dup_fd()
and sane_fdtable_size() instead of "trim everything past that point"
they are currently getting.  NULL means "we are not going to be punching
any holes"; NR_OPEN_MAX is gone.
	* make sane_fdtable_size() use find_last_bit() instead of
open-coding it; it's easier to follow that way.
	* while we are at it, have dup_fd() report errors by returning
ERR_PTR(), no need to use a separate int *errorp argument.

Fixes: 60997c3d45d9 "close_range: add CLOSE_RANGE_UNSHARE"
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/file.c b/fs/file.c
index 5125607d040a..eb093e736972 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -272,59 +272,45 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
- * 'max_fds' will normally already be properly aligned, but it
- * turns out that in the close_range() -> __close_range() ->
- * unshare_fd() -> dup_fd() -> sane_fdtable_size() we can end
- * up having a 'max_fds' value that isn't already aligned.
- *
- * Rather than make close_range() have to worry about this,
- * just make that BITS_PER_LONG alignment be part of a sane
- * fdtable size. Becuase that's really what it is.
+ * punch_hole is optional - when close_range() is asked to unshare
+ * and close, we don't need to copy descriptors in that range, so
+ * a smaller cloned descriptor table might suffice if the last
+ * currently opened descriptor falls into that range.
  */
-static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
+static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punch_hole)
 {
-	unsigned int count;
+	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
 
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	if (last == fdt->max_fds)
+		return NR_OPEN_DEFAULT;
+	if (punch_hole && punch_hole->to >= last && punch_hole->from <= last) {
+		last = find_last_bit(fdt->open_fds, punch_hole->from);
+		if (last == punch_hole->from)
+			return NR_OPEN_DEFAULT;
+	}
+	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
 /*
- * Allocate a new files structure and copy contents from the
- * passed in files structure.
- * errorp will be valid only when the returned files_struct is NULL.
+ * Allocate a new descriptor table and copy contents from the passed in
+ * instance.  Returns a pointer to cloned table on success, ERR_PTR()
+ * on failure.  For 'punch_hole' see sane_fdtable_size().
  */
-struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
+	int error;
 
-	*errorp = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	atomic_set(&newf->count, 1);
 
@@ -341,7 +327,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, max_fds);
+	open_files = sane_fdtable_size(old_fdt, punch_hole);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -354,14 +340,14 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 		new_fdt = alloc_fdtable(open_files - 1);
 		if (!new_fdt) {
-			*errorp = -ENOMEM;
+			error = -ENOMEM;
 			goto out_release;
 		}
 
 		/* beyond sysctl_nr_open; nothing to do */
 		if (unlikely(new_fdt->max_fds < open_files)) {
 			__free_fdtable(new_fdt);
-			*errorp = -EMFILE;
+			error = -EMFILE;
 			goto out_release;
 		}
 
@@ -372,7 +358,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, max_fds);
+		open_files = sane_fdtable_size(old_fdt, punch_hole);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -406,8 +392,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 out_release:
 	kmem_cache_free(files_cachep, newf);
-out:
-	return NULL;
+	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
@@ -748,37 +733,25 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	if (flags & CLOSE_RANGE_UNSHARE) {
-		int ret;
-		unsigned int max_unshare_fds = NR_OPEN_MAX;
+	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
+		struct fd_range range = {fd, max_fd}, *punch_hole = &range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
 		 * copy all of the file descriptors since they still want to
 		 * use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
-			/*
-			 * If the requested range is greater than the current
-			 * maximum, we're closing everything so only copy all
-			 * file descriptors beneath the lowest file descriptor.
-			 */
-			rcu_read_lock();
-			if (max_fd >= last_fd(files_fdtable(cur_fds)))
-				max_unshare_fds = fd;
-			rcu_read_unlock();
-		}
-
-		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
-		if (ret)
-			return ret;
+		if (flags & CLOSE_RANGE_CLOEXEC)
+			punch_hole = NULL;
 
+		fds = dup_fd(cur_fds, punch_hole);
+		if (IS_ERR(fds))
+			return PTR_ERR(fds);
 		/*
 		 * We used to share our file descriptor table, and have now
 		 * created a private one, make sure we're using it below.
 		 */
-		if (fds)
-			swap(cur_fds, fds);
+		swap(cur_fds, fds);
 	}
 
 	if (flags & CLOSE_RANGE_CLOEXEC)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2944d4aa413b..b1c5722f2b3c 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,7 +22,6 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
-#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -106,7 +105,10 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
-struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
+struct fd_range {
+	unsigned int from, to;
+};
+struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
@@ -115,8 +117,6 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
-extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-		      struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 60c0b4868fd4..89ceb4a68af2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1756,33 +1756,30 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
-	int error = 0;
 
 	/*
 	 * A background process may not have any files ...
 	 */
 	oldf = current->files;
 	if (!oldf)
-		goto out;
+		return 0;
 
 	if (no_files) {
 		tsk->files = NULL;
-		goto out;
+		return 0;
 	}
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
-		goto out;
+		return 0;
 	}
 
-	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
-	if (!newf)
-		goto out;
+	newf = dup_fd(oldf, NULL);
+	if (IS_ERR(newf))
+		return PTR_ERR(newf);
 
 	tsk->files = newf;
-	error = 0;
-out:
-	return error;
+	return 0;
 }
 
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
@@ -3238,17 +3235,16 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 /*
  * Unshare file descriptor table if it is being shared
  */
-int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-	       struct files_struct **new_fdp)
+static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, max_fds, &error);
-		if (!*new_fdp)
-			return error;
+		fd = dup_fd(fd, NULL);
+		if (IS_ERR(fd))
+			return PTR_ERR(fd);
+		*new_fdp = fd;
 	}
 
 	return 0;
@@ -3306,7 +3302,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
+	err = unshare_fd(unshare_flags, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3398,7 +3394,7 @@ int unshare_files(void)
 	struct files_struct *old, *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
+	error = unshare_fd(CLONE_FILES, &copy);
 	if (error || !copy)
 		return error;
 


