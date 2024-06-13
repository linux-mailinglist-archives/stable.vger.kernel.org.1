Return-Path: <stable+bounces-50439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D19065F2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6536C1C20AC9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D913D26E;
	Thu, 13 Jun 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ibe67fXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A308E13C9CF
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265413; cv=none; b=ZfSZuXnbmXhRYkmiqWn9PjeCParZaAw8BQ2A/V6l5hiA2/0OfJJiLVWQkbDX3a98mcNzKvokEsMPS0elgR9xi2StPZDKeq1+4tMropyRslMYuxCBR9th88KjPMSZnDh0lhdqrJEy6882uXuNswyGSuPx4UiJMAhsPjicKjwL3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265413; c=relaxed/simple;
	bh=80ugb39wkCV5vo3zXYKbJw2/6EdCUgRj8UE3wSzaNIU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=raja1G1kZH55Sv5TpS0kw5Zl6I7FNqQsM5+hGAmRBbYFBD8sOxUZcxuMK748zyFVSSAnbpUJSL5xpVVs5606pqX+vALnjjh0rnXSYXtziDRJEZiHMzhPKv6Xh4TGi1323J6pBsp1JLcjlUM0VzZIwzU0mJ0tWi0ogVSrXev1iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ibe67fXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2809FC2BBFC;
	Thu, 13 Jun 2024 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265413;
	bh=80ugb39wkCV5vo3zXYKbJw2/6EdCUgRj8UE3wSzaNIU=;
	h=Subject:To:Cc:From:Date:From;
	b=Ibe67fXyR2oAR4z2AhxMf1kZqousNKh8QcnRi/I6Tt9rLjaCUlifB8XCpQwnwJpjn
	 QkP7wIDnG4sX5DsAAQNOVmfIYJBlcExKzfsVl84kY+3VZk+nO655IyLGguHvJWbS5k
	 D+vxNpaw3v38WQfX2w6Hf7FTEcwYRGNugtt+33Po=
Subject: FAILED: patch "[PATCH] selftests/mm: compaction_test: fix bogus test success and" failed to apply to 6.6-stable tree
To: dev.jain@arm.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,shuah@kernel.org,sjayaram@akamai.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:56:46 +0200
Message-ID: <2024061345-fanciness-reheat-95c1@gregkh>
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
git cherry-pick -x fb9293b6b0156fbf6ab97a1625d99a29c36d9f0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061345-fanciness-reheat-95c1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
9ad665ef55ea ("selftests/mm: compaction_test: fix incorrect write of zero to nr_hugepages")
d4202e66a4b1 ("selftests/mm: compaction_test: fix bogus test success on Aarch64")
69e545edbe8b ("selftests/mm: ksft_exit functions do not return")
f3b7568c4942 ("selftests/mm: log a consistent test name for check_compaction")
9c1490d911f8 ("selftests/mm: log skipped compaction test as a skip")
8c9eea721a98 ("selftests/mm: skip test if application doesn't has root privileges")
9a21701edc41 ("selftests/mm: conform test to TAP format output")
cb6e7cae1886 ("selftests/mm: gup_test: conform test to TAP format output")
019b277b680f ("selftests: mm: skip whole test instead of failure")
46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb9293b6b0156fbf6ab97a1625d99a29c36d9f0c Mon Sep 17 00:00:00 2001
From: Dev Jain <dev.jain@arm.com>
Date: Tue, 21 May 2024 13:13:58 +0530
Subject: [PATCH] selftests/mm: compaction_test: fix bogus test success and
 reduce probability of OOM-killer invocation

Reset nr_hugepages to zero before the start of the test.

If a non-zero number of hugepages is already set before the start of the
test, the following problems arise:

 - The probability of the test getting OOM-killed increases.  Proof:
   The test wants to run on 80% of available memory to prevent OOM-killing
   (see original code comments).  Let the value of mem_free at the start
   of the test, when nr_hugepages = 0, be x.  In the other case, when
   nr_hugepages > 0, let the memory consumed by hugepages be y.  In the
   former case, the test operates on 0.8 * x of memory.  In the latter,
   the test operates on 0.8 * (x - y) of memory, with y already filled,
   hence, memory consumed is y + 0.8 * (x - y) = 0.8 * x + 0.2 * y > 0.8 *
   x.  Q.E.D

 - The probability of a bogus test success increases.  Proof: Let the
   memory consumed by hugepages be greater than 25% of x, with x and y
   defined as above.  The definition of compaction_index is c_index = (x -
   y)/z where z is the memory consumed by hugepages after trying to
   increase them again.  In check_compaction(), we set the number of
   hugepages to zero, and then increase them back; the probability that
   they will be set back to consume at least y amount of memory again is
   very high (since there is not much delay between the two attempts of
   changing nr_hugepages).  Hence, z >= y > (x/4) (by the 25% assumption).
   Therefore, c_index = (x - y)/z <= (x - y)/y = x/y - 1 < 4 - 1 = 3
   hence, c_index can always be forced to be less than 3, thereby the test
   succeeding always.  Q.E.D

Link: https://lkml.kernel.org/r/20240521074358.675031-4-dev.jain@arm.com
Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sri Jayaramappa <sjayaram@akamai.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 5e9bd1da9370..e140558e6f53 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -82,13 +82,16 @@ int prereq(void)
 	return -1;
 }
 
-int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
+int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
+		     unsigned long initial_nr_hugepages)
 {
 	unsigned long nr_hugepages_ul;
 	int fd, ret = -1;
 	int compaction_index = 0;
-	char initial_nr_hugepages[20] = {0};
 	char nr_hugepages[20] = {0};
+	char init_nr_hugepages[20] = {0};
+
+	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -102,23 +105,6 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 		goto out;
 	}
 
-	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
-		goto close_fd;
-	}
-
-	lseek(fd, 0, SEEK_SET);
-
-	/* Start with the initial condition of 0 huge pages*/
-	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
-		goto close_fd;
-	}
-
-	lseek(fd, 0, SEEK_SET);
-
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
@@ -146,8 +132,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
-	    != strlen(initial_nr_hugepages)) {
+	if (write(fd, init_nr_hugepages, strlen(init_nr_hugepages))
+	    != strlen(init_nr_hugepages)) {
 		ksft_print_msg("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
 			       strerror(errno));
 		goto close_fd;
@@ -171,6 +157,41 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 	return ret;
 }
 
+int set_zero_hugepages(unsigned long *initial_nr_hugepages)
+{
+	int fd, ret = -1;
+	char nr_hugepages[20] = {0};
+
+	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto out;
+	}
+	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
+		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto close_fd;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+
+	/* Start with the initial condition of 0 huge pages */
+	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
+		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+			       strerror(errno));
+		goto close_fd;
+	}
+
+	*initial_nr_hugepages = strtoul(nr_hugepages, NULL, 10);
+	ret = 0;
+
+ close_fd:
+	close(fd);
+
+ out:
+	return ret;
+}
 
 int main(int argc, char **argv)
 {
@@ -181,6 +202,7 @@ int main(int argc, char **argv)
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
+	unsigned long initial_nr_hugepages;
 
 	ksft_print_header();
 
@@ -189,6 +211,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(1);
 
+	/* Start the test without hugepages reducing mem_free */
+	if (set_zero_hugepages(&initial_nr_hugepages))
+		ksft_exit_fail();
+
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
 	if (setrlimit(RLIMIT_MEMLOCK, &lim))
@@ -232,7 +258,8 @@ int main(int argc, char **argv)
 		entry = entry->next;
 	}
 
-	if (check_compaction(mem_free, hugepage_size) == 0)
+	if (check_compaction(mem_free, hugepage_size,
+			     initial_nr_hugepages) == 0)
 		ksft_exit_pass();
 
 	ksft_exit_fail();


