Return-Path: <stable+bounces-240389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDjANqkr6WknVQIAu9opvQ
	(envelope-from <stable+bounces-240389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 22:12:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88E44A8A9
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 856F73016644
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B53F2110;
	Wed, 22 Apr 2026 20:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TbeHpANv"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7F25A2C9;
	Wed, 22 Apr 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888737; cv=none; b=ccNYq123daS+VBN/Zo63MTZs6cvAGwVGek4Y/rCclBuCM/fdPRj9MVTeg6hhY5fiMnmKrPlhF+wzHBB/ItRmDCW2W4xH6oQ1Aa/7d2dIEbmk0NIVw6SgbGYodUNLXRVPSSMqAp7CcKISmZb8Nq5MAeJ+TP8832YoZ+n67MAZLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888737; c=relaxed/simple;
	bh=AAvj+WOHDEfzwznq97OWxqOX5M2P8HyhH+QQ7EXjqMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOxjhS5qb0oPnh20Cth88LavLpBjNk/rX/H3tXpnPztiZEl79vvMd4KNv+Z4C0CfoHenq15PSwjpu8HDToB7mbQFpMjXngfHgOR7nzRDpT0Fongpxsj4GpWfAIA5LtRQtvV48BX13z1kG1dLWjmH8YKSzllb+vaW3SswClr5n3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TbeHpANv; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776888735; x=1808424735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9z24XJWNlBNwDR/2tGf8AAiF5iQvYDUFLpIFzGx9FQ4=;
  b=TbeHpANvxTAlMB94BED/O4S1rIZi+kopAONsfAybCJ4A4JA7lN5kOZrP
   40YK//PqxJQXYLaaygtYp4Vt0xbwvv7zekBKJbKjz+6GrZz4x3A9ll5MK
   dyEI1K6XcQD9b1MvD5XI6qMio0jSgZ0cKuAeaNb08NL9sIeZpY0b21vFv
   rLOruUFVUsN97xQ/DnnN7CTvw7yiIdDsSBx0jX2vI7c/L44Ibe5sBwwiK
   V0Vbzazp7V51tWkDBhzup5UmbnffHRxc9LPsCX/j8poxE5srklJLZxpvS
   qNrSg82BVeWCRR9p9v3YYbYvlIQwJaG9EmVA5hIqyYolTAQZN6KUlJ5Oo
   g==;
X-CSE-ConnectionGUID: 9tvQVbmeRd6alBzof6Pdfw==
X-CSE-MsgGUID: EewDP2mwRPyATVEZvuYO0Q==
X-IronPort-AV: E=Sophos;i="6.23,193,1770595200"; 
   d="scan'208";a="17853712"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:12:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:10110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id 11b8706c-1700-478e-bc8a-301b1ce871ed; Wed, 22 Apr 2026 20:12:12 +0000 (UTC)
X-Farcaster-Flow-ID: 11b8706c-1700-478e-bc8a-301b1ce871ed
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 22 Apr 2026 20:12:12 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 22 Apr 2026 20:12:11 +0000
From: Bjoern Doebel <doebel@amazon.com>
To: <linux-kselftest@vger.kernel.org>
CC: <brauner@kernel.org>, <ptikhomirov@virtuozzo.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Bjoern Doebel
	<doebel@amazon.com>
Subject: [PATCH v2] selftests/pid_namespace: compute pid_max test limits dynamically
Date: Wed, 22 Apr 2026 20:11:51 +0000
Message-ID: <20260422201151.3830506-1-doebel@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260421194344.2981537-1-doebel@amazon.com>
References: <20260421194344.2981537-1-doebel@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_FROM(0.00)[bounces-240389-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doebel@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DF88E44A8A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pid_max kselftest hardcodes pid_max values of 400 and 500, but the
kernel enforces a minimum of PIDS_PER_CPU_MIN * num_possible_cpus().
On machines with many possible CPUs (e.g. nr_cpu_ids=128 yields a
minimum of 1024), writing 400 or 500 to /proc/sys/kernel/pid_max
returns EINVAL and all three tests fail.

Compute these limits the same way as the kernel does and set outer_limit
and inner_limit dynamically based on the result. Original test semantics
are preserved (outer < inner, nested namespace capped by parent).

Signed-off-by: Bjoern Doebel <doebel@amazon.com>
Assisted-by: Kiro:claude-opus-4.6
---
v2:
- use global outer_limit/inner_limit instead of complicated config
  struct
- make use of FIXTURE/TEST_F macros
- reduce buffer size in write_int_to_fd() to 12

 .../testing/selftests/pid_namespace/pid_max.c | 156 ++++++++++++++----
 1 file changed, 124 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index c9519e7385b6..5d686a09aa15 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -12,10 +12,74 @@
 #include <syscall.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include <unistd.h>
 
 #include "kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
+/*
+ * The kernel computes the minimum allowed pid_max as:
+ *   max(RESERVED_PIDS + 1, PIDS_PER_CPU_MIN * num_possible_cpus())
+ * Mirror that here so the test values are always valid.
+ *
+ * Note: glibc's get_nprocs_conf() returns the number of *configured*
+ * (present) CPUs, not *possible* CPUs.  The kernel uses
+ * num_possible_cpus() which corresponds to /sys/devices/system/cpu/possible.
+ * These can differ significantly (e.g. 16 configured vs 128 possible).
+ */
+#define RESERVED_PIDS		300
+#define PIDS_PER_CPU_MIN	8
+
+/* Count CPUs from a range list like "0-31" or "0-15,32-47". */
+static int num_possible_cpus(void)
+{
+	FILE *f;
+	int count = 0;
+	int lo, hi;
+
+	f = fopen("/sys/devices/system/cpu/possible", "r");
+	if (!f)
+		return 0;
+
+	while (fscanf(f, "%d", &lo) == 1) {
+		if (fscanf(f, "-%d", &hi) == 1)
+			count += hi - lo + 1;
+		else
+			count++;
+		/* skip comma separator */
+		fscanf(f, ",");
+	}
+
+	fclose(f);
+	return count;
+}
+
+static int pid_min(void)
+{
+	int cpu_min = PIDS_PER_CPU_MIN * num_possible_cpus();
+
+	return cpu_min > (RESERVED_PIDS + 1) ? cpu_min : (RESERVED_PIDS + 1);
+}
+
+/*
+ * Outer and inner pid_max limits used by the tests.  The outer limit is
+ * the more restrictive ancestor; the inner limit is set higher in a
+ * nested namespace but must still be capped by the outer limit.
+ * Both are derived from the kernel's minimum so they are always writable.
+ *
+ * Global so that clone callbacks can access them without parameter plumbing.
+ */
+static int outer_limit;
+static int inner_limit;
+
+static int write_int_to_fd(int fd, int val)
+{
+	char buf[12];
+	int len = snprintf(buf, sizeof(buf), "%d", val);
+
+	return write(fd, buf, len);
+}
+
 #define __STACK_SIZE (8 * 1024 * 1024)
 static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
 {
@@ -60,18 +124,18 @@ static int pid_max_cb(void *data)
 		return -1;
 	}
 
-	ret = write(fd, "500", sizeof("500") - 1);
+	ret = write_int_to_fd(fd, inner_limit);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
 		return -1;
 	}
 
-	for (int i = 0; i < 501; i++) {
+	for (int i = 0; i < inner_limit + 1; i++) {
 		pid = fork();
 		if (pid == 0)
 			exit(EXIT_SUCCESS);
 		wait_for_pid(pid);
-		if (pid > 500) {
+		if (pid > inner_limit) {
 			fprintf(stderr, "Managed to create pid number beyond limit\n");
 			return -1;
 		}
@@ -106,7 +170,7 @@ static int pid_max_nested_inner(void *data)
 		return fret;
 	}
 
-	ret = write(fd, "500", sizeof("500") - 1);
+	ret = write_int_to_fd(fd, inner_limit);
 	close(fd);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
@@ -133,8 +197,8 @@ static int pid_max_nested_inner(void *data)
 		return fret;
 	}
 
-	/* Now make sure that we wrap pids at 400. */
-	for (i = 0; i < 510; i++) {
+	/* Now make sure that we wrap pids at outer_limit. */
+	for (i = 0; i < inner_limit + 10; i++) {
 		pid_t pid;
 
 		pid = fork();
@@ -145,7 +209,7 @@ static int pid_max_nested_inner(void *data)
 			exit(EXIT_SUCCESS);
 
 		wait_for_pid(pid);
-		if (pid >= 500) {
+		if (pid >= inner_limit) {
 			fprintf(stderr, "Managed to create process with pid %d beyond configured limit\n", pid);
 			return fret;
 		}
@@ -156,15 +220,19 @@ static int pid_max_nested_inner(void *data)
 
 static int pid_max_nested_outer(void *data)
 {
-	int fret = -1, nr_procs = 400;
-	pid_t pids[1000];
-	int fd, i, ret;
+	int fret = -1, nr_procs = 0;
+	pid_t *pids;
+	int fd, ret;
 	pid_t pid;
 
+	pids = malloc(outer_limit * sizeof(pid_t));
+	if (!pids)
+		return -1;
+
 	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
 	if (ret) {
 		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
-		return fret;
+		goto out;
 	}
 
 	umount2("/proc", MNT_DETACH);
@@ -172,27 +240,28 @@ static int pid_max_nested_outer(void *data)
 	ret = mount("proc", "/proc", "proc", 0, NULL);
 	if (ret) {
 		fprintf(stderr, "%m - Failed to mount proc\n");
-		return fret;
+		goto out;
 	}
 
 	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
 	if (fd < 0) {
 		fprintf(stderr, "%m - Failed to open pid_max\n");
-		return fret;
+		goto out;
 	}
 
-	ret = write(fd, "400", sizeof("400") - 1);
+	ret = write_int_to_fd(fd, outer_limit);
 	close(fd);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
-		return fret;
+		goto out;
 	}
 
 	/*
-	 * Create 397 processes. This leaves room for do_clone() (398) and
-	 * one more 399. So creating another process needs to fail.
+	 * Create (outer_limit - 4) processes. This leaves room for
+	 * do_clone() and one more. So creating another process needs
+	 * to fail.
 	 */
-	for (nr_procs = 0; nr_procs < 396; nr_procs++) {
+	for (nr_procs = 0; nr_procs < outer_limit - 4; nr_procs++) {
 		pid = fork();
 		if (pid < 0)
 			goto reap;
@@ -220,20 +289,26 @@ static int pid_max_nested_outer(void *data)
 	for (int i = 0; i < nr_procs; i++)
 		wait_for_pid(pids[i]);
 
+out:
+	free(pids);
 	return fret;
 }
 
 static int pid_max_nested_limit_inner(void *data)
 {
-	int fret = -1, nr_procs = 400;
+	int fret = -1, nr_procs = 0;
 	int fd, ret;
 	pid_t pid;
-	pid_t pids[1000];
+	pid_t *pids;
+
+	pids = malloc(inner_limit * sizeof(pid_t));
+	if (!pids)
+		return -1;
 
 	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
 	if (ret) {
 		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
-		return fret;
+		goto out;
 	}
 
 	umount2("/proc", MNT_DETACH);
@@ -241,23 +316,23 @@ static int pid_max_nested_limit_inner(void *data)
 	ret = mount("proc", "/proc", "proc", 0, NULL);
 	if (ret) {
 		fprintf(stderr, "%m - Failed to mount proc\n");
-		return fret;
+		goto out;
 	}
 
 	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
 	if (fd < 0) {
 		fprintf(stderr, "%m - Failed to open pid_max\n");
-		return fret;
+		goto out;
 	}
 
-	ret = write(fd, "500", sizeof("500") - 1);
+	ret = write_int_to_fd(fd, inner_limit);
 	close(fd);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
-		return fret;
+		goto out;
 	}
 
-	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
+	for (nr_procs = 0; nr_procs < inner_limit; nr_procs++) {
 		pid = fork();
 		if (pid < 0)
 			break;
@@ -268,7 +343,7 @@ static int pid_max_nested_limit_inner(void *data)
 		pids[nr_procs] = pid;
 	}
 
-	if (nr_procs >= 400) {
+	if (nr_procs >= outer_limit) {
 		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
 		goto reap;
 	}
@@ -279,6 +354,8 @@ static int pid_max_nested_limit_inner(void *data)
 	for (int i = 0; i < nr_procs; i++)
 		wait_for_pid(pids[i]);
 
+out:
+	free(pids);
 	return fret;
 }
 
@@ -307,7 +384,7 @@ static int pid_max_nested_limit_outer(void *data)
 		return -1;
 	}
 
-	ret = write(fd, "400", sizeof("400") - 1);
+	ret = write_int_to_fd(fd, outer_limit);
 	close(fd);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
@@ -328,17 +405,32 @@ static int pid_max_nested_limit_outer(void *data)
 	return 0;
 }
 
-TEST(pid_max_simple)
+FIXTURE(pid_max) {
+	int dummy;
+};
+
+FIXTURE_SETUP(pid_max)
 {
-	pid_t pid;
+	int min = pid_min();
 
+	outer_limit = min + 100;
+	inner_limit = min + 200;
+}
+
+FIXTURE_TEARDOWN(pid_max)
+{
+}
+
+TEST_F(pid_max, simple)
+{
+	pid_t pid;
 
 	pid = do_clone(pid_max_cb, NULL, CLONE_NEWPID | CLONE_NEWNS);
 	ASSERT_GT(pid, 0);
 	ASSERT_EQ(0, wait_for_pid(pid));
 }
 
-TEST(pid_max_nested_limit)
+TEST_F(pid_max, nested_limit)
 {
 	pid_t pid;
 
@@ -347,7 +439,7 @@ TEST(pid_max_nested_limit)
 	ASSERT_EQ(0, wait_for_pid(pid));
 }
 
-TEST(pid_max_nested)
+TEST_F(pid_max, nested)
 {
 	pid_t pid;
 
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


