Return-Path: <stable+bounces-128652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1944A7EA26
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF333188BB79
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC45219A8B;
	Mon,  7 Apr 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHrF79zS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD7217F5D;
	Mon,  7 Apr 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049602; cv=none; b=fajgCZ924rWPPjiSZ9HKI85YsvyOT4vItxl2IlLjaEZPD7oP6v/Z8cxhhMCADY0gWBLz8ePCaqmcqJnGlGtHWAAD5Fg6utmBIJwRl5vvWAPxbhXjzsGhQx2oJk3rQ3KmnkkqHlCiLkOuYUbbuNlqd3nYCoFsZHwUisFh2es5oBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049602; c=relaxed/simple;
	bh=VZn4mEvlVOLRAiqUlNYYOHUwjudwVhjKMLBue9TBfCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyBdSKY2bqb9xLlWyOT0S40qe2qfcSvGRgTtpVnZ8Yxw+Y/NjIRYoRni/0jE0fxLGhl0wL61S7U9RqTxTXX9BuTPw6IIHys8Eu8evSThpTRZ6FyqCj4uKDxPPRdelHg2rZIvCewb7OZW7NIuemey5aF3rwQO6rUizyOTOFZJl9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHrF79zS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3BCC4CEDD;
	Mon,  7 Apr 2025 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049602;
	bh=VZn4mEvlVOLRAiqUlNYYOHUwjudwVhjKMLBue9TBfCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHrF79zSDHJ77y54Wx1zOjUdomTR0+jpwfASp0haReN/9Nz06hdCNeW9nEbwW88WB
	 82jcBYwO3GKRlxLHE2OJeM1+e+xoAD72s965vePSsi2QyltpFVM3SPVHuk27QBSuqN
	 k14jfASBxyQAi2D4CqIToZcHkpiufHcO+ydswvJaE1tnA2Tm6Erd2rXb5zo4Uq3pVu
	 fAu3MmcEeiBqTh0IrFp6wuRdrCnUYBql2iawq8vTrXVGmNxenrGERqqMNBXbg/s4zY
	 dwS4ovHZ9aQNA8fyjoTjLtEpqgRcmynixcAq17WcmKLOtALgjBBicEQpLEk86+a5Dj
	 62fMf1NoM5Pow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 23/28] um: Rewrite the sigio workaround based on epoll and tgkill
Date: Mon,  7 Apr 2025 14:12:13 -0400
Message-Id: <20250407181224.3180941-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]

The existing sigio workaround implementation removes FDs from the
poll when events are triggered, requiring users to re-add them via
add_sigio_fd() after processing. This introduces a potential race
condition between FD removal in write_sigio_thread() and next_poll
update in __add_sigio_fd(), and is inefficient due to frequent FD
removal and re-addition. Rewrite the implementation based on epoll
and tgkill for improved efficiency and reliability.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/random.c       |   2 +-
 arch/um/drivers/rtc_user.c     |   2 +-
 arch/um/include/shared/os.h    |   2 +-
 arch/um/include/shared/sigio.h |   1 -
 arch/um/kernel/sigio.c         |  26 ---
 arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
 6 files changed, 47 insertions(+), 316 deletions(-)

diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index da985e0dc69a5..ca08c91f47a37 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -79,7 +79,7 @@ static int __init rng_init (void)
 	if (err < 0)
 		goto err_out_cleanup_hw;
 
-	sigio_broken(random_fd);
+	sigio_broken();
 	hwrng.name = RNG_MODULE_NAME;
 	hwrng.read = rng_dev_read;
 
diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
index 7c3cec4c68cff..51e79f3148cd4 100644
--- a/arch/um/drivers/rtc_user.c
+++ b/arch/um/drivers/rtc_user.c
@@ -39,7 +39,7 @@ int uml_rtc_start(bool timetravel)
 		}
 
 		/* apparently timerfd won't send SIGIO, use workaround */
-		sigio_broken(uml_rtc_irq_fds[0]);
+		sigio_broken();
 		err = add_sigio_fd(uml_rtc_irq_fds[0]);
 		if (err < 0) {
 			close(uml_rtc_irq_fds[0]);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5babad8c5f75e..92868f398457a 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -310,7 +310,7 @@ extern void um_irqs_resume(void);
 extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd);
-extern void sigio_broken(int fd);
+extern void sigio_broken(void);
 /*
  * unlocked versions for IRQ controller code.
  *
diff --git a/arch/um/include/shared/sigio.h b/arch/um/include/shared/sigio.h
index e60c8b2278449..c6c2edce1f6d2 100644
--- a/arch/um/include/shared/sigio.h
+++ b/arch/um/include/shared/sigio.h
@@ -6,7 +6,6 @@
 #ifndef __SIGIO_H__
 #define __SIGIO_H__
 
-extern int write_sigio_irq(int fd);
 extern void sigio_lock(void);
 extern void sigio_unlock(void);
 
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index 5085a50c3b8c8..4fc04742048ab 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -8,32 +8,6 @@
 #include <os.h>
 #include <sigio.h>
 
-/* Protected by sigio_lock() called from write_sigio_workaround */
-static int sigio_irq_fd = -1;
-
-static irqreturn_t sigio_interrupt(int irq, void *data)
-{
-	char c;
-
-	os_read_file(sigio_irq_fd, &c, sizeof(c));
-	return IRQ_HANDLED;
-}
-
-int write_sigio_irq(int fd)
-{
-	int err;
-
-	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			     0, "write sigio", NULL);
-	if (err < 0) {
-		printk(KERN_ERR "write_sigio_irq : um_request_irq failed, "
-		       "err = %d\n", err);
-		return -1;
-	}
-	sigio_irq_fd = fd;
-	return 0;
-}
-
 /* These are called from os-Linux/sigio.c to protect its pollfds arrays. */
 static DEFINE_MUTEX(sigio_mutex);
 
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 61b348a2ea974..a05a6ecee7561 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -11,6 +11,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <string.h>
+#include <sys/epoll.h>
 #include <kern_util.h>
 #include <init.h>
 #include <os.h>
@@ -23,180 +24,49 @@
  */
 static struct os_helper_thread *write_sigio_td;
 
-/*
- * These arrays are initialized before the sigio thread is started, and
- * the descriptors closed after it is killed.  So, it can't see them change.
- * On the UML side, they are changed under the sigio_lock.
- */
-#define SIGIO_FDS_INIT {-1, -1}
-
-static int write_sigio_fds[2] = SIGIO_FDS_INIT;
-static int sigio_private[2] = SIGIO_FDS_INIT;
+static int epollfd = -1;
 
-struct pollfds {
-	struct pollfd *poll;
-	int size;
-	int used;
-};
+#define MAX_EPOLL_EVENTS 64
 
-/*
- * Protected by sigio_lock().  Used by the sigio thread, but the UML thread
- * synchronizes with it.
- */
-static struct pollfds current_poll;
-static struct pollfds next_poll;
-static struct pollfds all_sigio_fds;
+static struct epoll_event epoll_events[MAX_EPOLL_EVENTS];
 
 static void *write_sigio_thread(void *unused)
 {
-	struct pollfds *fds, tmp;
-	struct pollfd *p;
-	int i, n, respond_fd;
-	char c;
+	int pid = getpid();
+	int r;
 
 	os_fix_helper_thread_signals();
 
-	fds = &current_poll;
 	while (1) {
-		n = poll(fds->poll, fds->used, -1);
-		if (n < 0) {
+		r = epoll_wait(epollfd, epoll_events, MAX_EPOLL_EVENTS, -1);
+		if (r < 0) {
 			if (errno == EINTR)
 				continue;
-			printk(UM_KERN_ERR "write_sigio_thread : poll returned "
-			       "%d, errno = %d\n", n, errno);
+			printk(UM_KERN_ERR "%s: epoll_wait failed, errno = %d\n",
+			       __func__, errno);
 		}
-		for (i = 0; i < fds->used; i++) {
-			p = &fds->poll[i];
-			if (p->revents == 0)
-				continue;
-			if (p->fd == sigio_private[1]) {
-				CATCH_EINTR(n = read(sigio_private[1], &c,
-						     sizeof(c)));
-				if (n != sizeof(c))
-					printk(UM_KERN_ERR
-					       "write_sigio_thread : "
-					       "read on socket failed, "
-					       "err = %d\n", errno);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
-				respond_fd = sigio_private[1];
-			}
-			else {
-				respond_fd = write_sigio_fds[1];
-				fds->used--;
-				memmove(&fds->poll[i], &fds->poll[i + 1],
-					(fds->used - i) * sizeof(*fds->poll));
-			}
-
-			CATCH_EINTR(n = write(respond_fd, &c, sizeof(c)));
-			if (n != sizeof(c))
-				printk(UM_KERN_ERR "write_sigio_thread : "
-				       "write on socket failed, err = %d\n",
-				       errno);
-		}
-	}
-
-	return NULL;
-}
-
-static int need_poll(struct pollfds *polls, int n)
-{
-	struct pollfd *new;
-
-	if (n <= polls->size)
-		return 0;
-
-	new = uml_kmalloc(n * sizeof(struct pollfd), UM_GFP_ATOMIC);
-	if (new == NULL) {
-		printk(UM_KERN_ERR "need_poll : failed to allocate new "
-		       "pollfds\n");
-		return -ENOMEM;
-	}
-
-	memcpy(new, polls->poll, polls->used * sizeof(struct pollfd));
-	kfree(polls->poll);
-
-	polls->poll = new;
-	polls->size = n;
-	return 0;
-}
-
-/*
- * Must be called with sigio_lock held, because it's needed by the marked
- * critical section.
- */
-static void update_thread(void)
-{
-	unsigned long flags;
-	int n;
-	char c;
-
-	flags = um_set_signals_trace(0);
-	CATCH_EINTR(n = write(sigio_private[0], &c, sizeof(c)));
-	if (n != sizeof(c)) {
-		printk(UM_KERN_ERR "update_thread : write failed, err = %d\n",
-		       errno);
-		goto fail;
-	}
 
-	CATCH_EINTR(n = read(sigio_private[0], &c, sizeof(c)));
-	if (n != sizeof(c)) {
-		printk(UM_KERN_ERR "update_thread : read failed, err = %d\n",
-		       errno);
-		goto fail;
+		CATCH_EINTR(r = tgkill(pid, pid, SIGIO));
+		if (r < 0)
+			printk(UM_KERN_ERR "%s: tgkill failed, errno = %d\n",
+			       __func__, errno);
 	}
 
-	um_set_signals_trace(flags);
-	return;
- fail:
-	/* Critical section start */
-	if (write_sigio_td) {
-		os_kill_helper_thread(write_sigio_td);
-		write_sigio_td = NULL;
-	}
-	close(sigio_private[0]);
-	close(sigio_private[1]);
-	close(write_sigio_fds[0]);
-	close(write_sigio_fds[1]);
-	/* Critical section end */
-	um_set_signals_trace(flags);
+	return NULL;
 }
 
 int __add_sigio_fd(int fd)
 {
-	struct pollfd *p;
-	int err, i, n;
-
-	for (i = 0; i < all_sigio_fds.used; i++) {
-		if (all_sigio_fds.poll[i].fd == fd)
-			break;
-	}
-	if (i == all_sigio_fds.used)
-		return -ENOSPC;
-
-	p = &all_sigio_fds.poll[i];
-
-	for (i = 0; i < current_poll.used; i++) {
-		if (current_poll.poll[i].fd == fd)
-			return 0;
-	}
-
-	n = current_poll.used;
-	err = need_poll(&next_poll, n + 1);
-	if (err)
-		return err;
-
-	memcpy(next_poll.poll, current_poll.poll,
-	       current_poll.used * sizeof(struct pollfd));
-	next_poll.poll[n] = *p;
-	next_poll.used = n + 1;
-	update_thread();
-
-	return 0;
+	struct epoll_event event = {
+		.data.fd = fd,
+		.events = EPOLLIN | EPOLLET,
+	};
+	int r;
+
+	CATCH_EINTR(r = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &event));
+	return r < 0 ? -errno : 0;
 }
 
-
 int add_sigio_fd(int fd)
 {
 	int err;
@@ -210,38 +80,11 @@ int add_sigio_fd(int fd)
 
 int __ignore_sigio_fd(int fd)
 {
-	struct pollfd *p;
-	int err, i, n = 0;
-
-	/*
-	 * This is called from exitcalls elsewhere in UML - if
-	 * sigio_cleanup has already run, then update_thread will hang
-	 * or fail because the thread is no longer running.
-	 */
-	if (!write_sigio_td)
-		return -EIO;
-
-	for (i = 0; i < current_poll.used; i++) {
-		if (current_poll.poll[i].fd == fd)
-			break;
-	}
-	if (i == current_poll.used)
-		return -ENOENT;
-
-	err = need_poll(&next_poll, current_poll.used - 1);
-	if (err)
-		return err;
+	struct epoll_event event;
+	int r;
 
-	for (i = 0; i < current_poll.used; i++) {
-		p = &current_poll.poll[i];
-		if (p->fd != fd)
-			next_poll.poll[n++] = *p;
-	}
-	next_poll.used = current_poll.used - 1;
-
-	update_thread();
-
-	return 0;
+	CATCH_EINTR(r = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event));
+	return r < 0 ? -errno : 0;
 }
 
 int ignore_sigio_fd(int fd)
@@ -255,122 +98,37 @@ int ignore_sigio_fd(int fd)
 	return err;
 }
 
-static struct pollfd *setup_initial_poll(int fd)
-{
-	struct pollfd *p;
-
-	p = uml_kmalloc(sizeof(struct pollfd), UM_GFP_KERNEL);
-	if (p == NULL) {
-		printk(UM_KERN_ERR "setup_initial_poll : failed to allocate "
-		       "poll\n");
-		return NULL;
-	}
-	*p = ((struct pollfd) { .fd		= fd,
-				.events 	= POLLIN,
-				.revents 	= 0 });
-	return p;
-}
-
 static void write_sigio_workaround(void)
 {
-	struct pollfd *p;
 	int err;
-	int l_write_sigio_fds[2];
-	int l_sigio_private[2];
-	struct os_helper_thread *l_write_sigio_td;
-
-	/* We call this *tons* of times - and most ones we must just fail. */
-	sigio_lock();
-	l_write_sigio_td = write_sigio_td;
-	sigio_unlock();
-
-	if (l_write_sigio_td)
-		return;
-
-	err = os_pipe(l_write_sigio_fds, 1, 1);
-	if (err < 0) {
-		printk(UM_KERN_ERR "write_sigio_workaround - os_pipe 1 failed, "
-		       "err = %d\n", -err);
-		return;
-	}
-	err = os_pipe(l_sigio_private, 1, 1);
-	if (err < 0) {
-		printk(UM_KERN_ERR "write_sigio_workaround - os_pipe 2 failed, "
-		       "err = %d\n", -err);
-		goto out_close1;
-	}
-
-	p = setup_initial_poll(l_sigio_private[1]);
-	if (!p)
-		goto out_close2;
 
 	sigio_lock();
-
-	/*
-	 * Did we race? Don't try to optimize this, please, it's not so likely
-	 * to happen, and no more than once at the boot.
-	 */
 	if (write_sigio_td)
-		goto out_free;
-
-	current_poll = ((struct pollfds) { .poll 	= p,
-					   .used 	= 1,
-					   .size 	= 1 });
-
-	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_clear_poll;
+		goto out;
 
-	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
-	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
+	epollfd = epoll_create(MAX_EPOLL_EVENTS);
+	if (epollfd < 0) {
+		printk(UM_KERN_ERR "%s: epoll_create failed, errno = %d\n",
+		       __func__, errno);
+		goto out;
+	}
 
 	err = os_run_helper_thread(&write_sigio_td, write_sigio_thread, NULL);
-	if (err < 0)
-		goto out_clear;
-
-	sigio_unlock();
-	return;
+	if (err < 0) {
+		printk(UM_KERN_ERR "%s: os_run_helper_thread failed, errno = %d\n",
+		       __func__, -err);
+		close(epollfd);
+		epollfd = -1;
+		goto out;
+	}
 
-out_clear:
-	write_sigio_td = NULL;
-	write_sigio_fds[0] = -1;
-	write_sigio_fds[1] = -1;
-	sigio_private[0] = -1;
-	sigio_private[1] = -1;
-out_clear_poll:
-	current_poll = ((struct pollfds) { .poll	= NULL,
-					   .size	= 0,
-					   .used	= 0 });
-out_free:
+out:
 	sigio_unlock();
-	kfree(p);
-out_close2:
-	close(l_sigio_private[0]);
-	close(l_sigio_private[1]);
-out_close1:
-	close(l_write_sigio_fds[0]);
-	close(l_write_sigio_fds[1]);
 }
 
-void sigio_broken(int fd)
+void sigio_broken(void)
 {
-	int err;
-
 	write_sigio_workaround();
-
-	sigio_lock();
-	err = need_poll(&all_sigio_fds, all_sigio_fds.used + 1);
-	if (err) {
-		printk(UM_KERN_ERR "maybe_sigio_broken - failed to add pollfd "
-		       "for descriptor %d\n", fd);
-		goto out;
-	}
-
-	all_sigio_fds.poll[all_sigio_fds.used++] =
-		((struct pollfd) { .fd  	= fd,
-				   .events 	= POLLIN,
-				   .revents 	= 0 });
-out:
-	sigio_unlock();
 }
 
 /* Changed during early boot */
@@ -384,7 +142,7 @@ void maybe_sigio_broken(int fd)
 	if (pty_output_sigio)
 		return;
 
-	sigio_broken(fd);
+	sigio_broken();
 }
 
 static void sigio_cleanup(void)
-- 
2.39.5


