Return-Path: <stable+bounces-39431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFD8A4F5E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D291F218F3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A66F524;
	Mon, 15 Apr 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zi7OuxjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F56F534
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184992; cv=none; b=Ay0Gilufcs7hlMdHaS6A3BPvLNu4fTFIwi+4Ld9O6YtldK3bdsizjNmmdEXeObv/+l+6kvr09i47UPL0pEkFZ80RiPYjN5arblWxIWUf8MUx31SoeGCA1HB37YR7vapYWU4VTZAnxmwyRntlGjGWaPzavtg62D4OWIGwgHf8cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184992; c=relaxed/simple;
	bh=NZ/tJ1Yvwp8vDVWbw5nBIDYIBWx+mXlUaThMjle+MMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=carexK/mGY+7Z4M5laCRMmPCmA4cdypR3kRVQtgwxMeEDU+OS96qW9AFs5Cx4gJG3DKq3vA/vSpdH+jJkU9nnFFpclXAt8uMRFrdqp67nYdxFCd8Q/hOq1aAjCas4/cu2sVq4OrEHklXfiimRiGHjIRCs8D7z+6bYPm+cPcTGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zi7OuxjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B4AC113CC;
	Mon, 15 Apr 2024 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184992;
	bh=NZ/tJ1Yvwp8vDVWbw5nBIDYIBWx+mXlUaThMjle+MMo=;
	h=Subject:To:Cc:From:Date:From;
	b=Zi7OuxjPoLQARi82c8xsIT+MbGxNgoyQ9nhSUrld9ZxIC4JtJ3Sc7OHXfk2AgFoIz
	 Zsn1IZefG9OKNsGp4gZauMRs9LnXkU7aIDFygoU9bF+pF2kZ5ohtwjvL1nEB8Ef6WU
	 IE+/GpAOMEnhd0Aru6rzt+BJukfHPh8WmXSOqDvU=
Subject: FAILED: patch "[PATCH] selftests/timers/posix_timers: Reimplement" failed to apply to 6.6-stable tree
To: oleg@redhat.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:43:09 +0200
Message-ID: <2024041509-triangle-parlor-1783@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6d029c25b71f2de2838a6f093ce0fa0e69336154
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041509-triangle-parlor-1783@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d029c25b71f2de2838a6f093ce0fa0e69336154 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 9 Apr 2024 15:38:03 +0200
Subject: [PATCH] selftests/timers/posix_timers: Reimplement
 check_timer_distribution()

check_timer_distribution() runs ten threads in a busy loop and tries to
test that the kernel distributes a process posix CPU timer signal to every
thread over time.

There is not guarantee that this is true even after commit bcb7ee79029d
("posix-timers: Prefer delivery of signals to the current thread") because
that commit only avoids waking up the sleeping process leader thread, but
that has nothing to do with the actual signal delivery.

As the signal is process wide the first thread which observes sigpending
and wins the race to lock sighand will deliver the signal. Testing shows
that this hangs on a regular base because some threads never win the race.

The comment "This primarily tests that the kernel does not favour any one."
is wrong. The kernel does favour a thread which hits the timer interrupt
when CLOCK_PROCESS_CPUTIME_ID expires.

Rewrite the test so it only checks that the group leader sleeping in join()
never receives SIGALRM and the thread which burns CPU cycles receives all
signals.

In older kernels which do not have commit bcb7ee79029d ("posix-timers:
Prefer delivery of signals to the current thread") the test-case fails
immediately, the very 1st tick wakes the leader up. Otherwise it quickly
succeeds after 100 ticks.

CI testing wants to use newer selftest versions on stable kernels. In this
case the test is guaranteed to fail.

So check in the failure case whether the kernel version is less than v6.3
and skip the test result in that case.

[ tglx: Massaged change log, renamed the version check helper ]

Fixes: e797203fb3ba ("selftests/timers/posix_timers: Test delivery of signals across threads")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240409133802.GD29396@redhat.com

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 541bf192e30e..973b18e156b2 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -51,6 +51,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <stdio.h>
+#include <sys/utsname.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -388,4 +389,16 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 	exit(KSFT_SKIP);
 }
 
+static inline int ksft_min_kernel_version(unsigned int min_major,
+					  unsigned int min_minor)
+{
+	unsigned int major, minor;
+	struct utsname info;
+
+	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail_msg("Can't parse kernel version\n");
+
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d49dd3ffd0d9..d86a0e00711e 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -184,80 +184,71 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static pthread_t ctd_thread;
+static volatile int ctd_count, ctd_failed;
 
-static void *distribution_thread(void *arg)
+static void ctd_sighandler(int sig)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
-	return NULL;
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
 }
 
-static void distribution_handler(int nr)
+static void *ctd_thread_func(void *arg)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
-		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
-}
-
-/*
- * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
- * timer signals. This primarily tests that the kernel does not favour any one.
- */
-static int check_timer_distribution(void)
-{
-	int err, i;
-	timer_t id;
-	const int nthreads = 10;
-	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
 		.it_value.tv_nsec = 1000 * 1000,
 		.it_interval.tv_sec = 0,
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
+	timer_t id;
 
-	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
-	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
-		if (err) {
-			ksft_print_msg("Can't create thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer\n";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer\n";
 
-	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (ctd_count > 0 && !ctd_failed)
+		;
 
-	for (i = 0; i < nthreads; i++) {
-		err = pthread_join(threads[i], NULL);
-		if (err) {
-			ksft_print_msg("Can't join thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
-	}
+	if (timer_delete(id))
+		return "Can't delete timer\n";
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
+	return NULL;
+}
 
-	ksft_test_result_pass("check_timer_distribution\n");
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
+
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread\n";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Can't join thread\n";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_min_kernel_version(6, 3))
+		ksft_test_result_fail("check signal distribution\n");
+	else
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
+err:
+	ksft_print_msg(errmsg);
+	return -1;
 }
 
 int main(int argc, char **argv)


