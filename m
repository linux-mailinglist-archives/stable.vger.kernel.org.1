Return-Path: <stable+bounces-82963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A2994FAC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832E51F22743
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB171D9A43;
	Tue,  8 Oct 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFS77lh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1181DF963;
	Tue,  8 Oct 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394021; cv=none; b=t2XwvAZPQiIjLFK+rOmE43D2fbZ2Arfwt1FfG1xPmk1LRE0yIRaxkEx9cknprjn/FrbiShyqOBWru5M6NNPAKuUStWy8+ysIQoZbrAHZyK1CKA/XxDn6y5XL1A1PVs9WbldNPkB39V53zG6Zk30AIJxrIIyFMOKRODbuzSZCjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394021; c=relaxed/simple;
	bh=XbG0fiHx9kv/daCA8xMMqgi65Uwe7GfH4xF1rri2ZMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alKHIER5WjtyY/uI6RwnG7iikkCHXfKI8DgV5yL3TG1+hvQ3ZvWyNKYNAMnhtOv6OAwEjdauZ4CX5jWysbnrAM9UNqY8slK3nCVFw4iuTP40RItRmwo3EgK8snzMQ4PSqFjE3rtr32s9p2CDC9HwyF+bf9+q7U2wkgCx+KF4PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFS77lh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E33C4CECC;
	Tue,  8 Oct 2024 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394021;
	bh=XbG0fiHx9kv/daCA8xMMqgi65Uwe7GfH4xF1rri2ZMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFS77lh7lj5wriKbPnDU6kQ36o2i+FckFAGpsSTU96Q74R6yrS6WUc8nTDL85DvOr
	 OUAac4z8RO2JSCbMJcQB0outQi0zCqXIUJbhqg2VcGF2Tn6O+kjUwVtYh1clNYRz2H
	 Q8jXpZl9OqVjHbZXJMmSZXJYXX/kEnIx9CFKcVRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6.6 322/386] close_range(): fix the logics in descriptor table trimming
Date: Tue,  8 Oct 2024 14:09:27 +0200
Message-ID: <20241008115642.056069015@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 678379e1d4f7443b170939525d3312cfc37bf86b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file.c               |   93 +++++++++++++++++-------------------------------
 include/linux/fdtable.h |    8 ++--
 kernel/fork.c           |   32 +++++++---------
 3 files changed, 51 insertions(+), 82 deletions(-)

--- a/fs/file.c
+++ b/fs/file.c
@@ -267,59 +267,45 @@ static inline void __clear_open_fd(unsig
 	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
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
 
@@ -336,7 +322,7 @@ struct files_struct *dup_fd(struct files
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, max_fds);
+	open_files = sane_fdtable_size(old_fdt, punch_hole);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -349,14 +335,14 @@ struct files_struct *dup_fd(struct files
 
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
 
@@ -367,7 +353,7 @@ struct files_struct *dup_fd(struct files
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, max_fds);
+		open_files = sane_fdtable_size(old_fdt, punch_hole);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -401,8 +387,7 @@ struct files_struct *dup_fd(struct files
 
 out_release:
 	kmem_cache_free(files_cachep, newf);
-out:
-	return NULL;
+	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
@@ -736,37 +721,25 @@ int __close_range(unsigned fd, unsigned
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
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,7 +22,6 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
-#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -117,7 +116,10 @@ struct task_struct;
 
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
@@ -126,8 +128,6 @@ int iterate_fd(struct files_struct *, un
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *close_fd_get_file(unsigned int fd);
-extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-		      struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1767,33 +1767,30 @@ static int copy_files(unsigned long clon
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
@@ -3358,17 +3355,16 @@ static int unshare_fs(unsigned long unsh
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
@@ -3426,7 +3422,7 @@ int ksys_unshare(unsigned long unshare_f
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
+	err = unshare_fd(unshare_flags, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3518,7 +3514,7 @@ int unshare_files(void)
 	struct files_struct *old, *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
+	error = unshare_fd(CLONE_FILES, &copy);
 	if (error || !copy)
 		return error;
 



