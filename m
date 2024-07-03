Return-Path: <stable+bounces-57608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BA925D35
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E373294B98
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA917334F;
	Wed,  3 Jul 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCQ8lCyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0C173334;
	Wed,  3 Jul 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005394; cv=none; b=iI7/LQO6kF1EZ3xKZu1ZTZix94HkYStUdcxFRahGz2M9li/Afgq2OYLHlLJCS7j3fXarH2RpLrZsOnMhXTaYg/56thq5MIQiGyP+Mk1nTzPY5xiAqE5s5QUoUjr1v2ItFH4Tb3QXDaW/5OD87+JP04Q/dsJnrnQhyAtDNdAuu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005394; c=relaxed/simple;
	bh=dvSNmikJRxcA9veEUGSIa5yYvSusBNWdXjkUB7TDy/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNo/eSn6qS/A7DDzGzQxkvgrFtnoMsFqWl+FpJ0EcxD8rELwFV+kHPMogaW8uRyRoD0mZRYnvo6+VqnxRoxIqgmG3TpNswWB/dMU08u226gx5Ydg4Tu4HzitKapVB6ylekAaRf8MoxJCBqdt78U2gKe5UAO5Z4AOo/DjxlRQeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCQ8lCyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC20C2BD10;
	Wed,  3 Jul 2024 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005394;
	bh=dvSNmikJRxcA9veEUGSIa5yYvSusBNWdXjkUB7TDy/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCQ8lCyWJMafwqa6Ji7jZLTF1MRIk8N4glNgPZ3HTrPhT3E95yTKnvJ6N7hvudthl
	 KiMu/r3LI3Glv78aj2kIRBYCMqPPFmwuEBjOhcd1wrOB659itP+h+KmZFLpqBZQ/6t
	 wPthZ8kKl7O8yeUXUjeUNCl5wXR+F9MgVrngpTRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/356] selftests/mm: conform test to TAP format output
Date: Wed,  3 Jul 2024 12:36:42 +0200
Message-ID: <20240703102915.597720666@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 9a21701edc41465de56f97914741bfb7bfc2517d ]

Conform the layout, informational and status messages to TAP.  No
functional change is intended other than the layout of output messages.

Link: https://lkml.kernel.org/r/20240101083614.1076768-1-usama.anjum@collabora.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d4202e66a4b1 ("selftests/mm: compaction_test: fix bogus test success on Aarch64")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/compaction_test.c | 91 ++++++++++----------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 55dec92e1e58c..f81931c1f8386 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -33,7 +33,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	FILE *cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -44,7 +44,7 @@ int read_memory_info(unsigned long *memfree, unsigned long *hugepagesize)
 	cmdfile = popen(cmd, "r");
 
 	if (!(fgets(buffer, sizeof(buffer), cmdfile))) {
-		perror("Failed to read meminfo\n");
+		ksft_print_msg("Failed to read meminfo: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -62,14 +62,14 @@ int prereq(void)
 	fd = open("/proc/sys/vm/compact_unevictable_allowed",
 		  O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to open /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, &allowed, sizeof(char)) != sizeof(char)) {
-		perror("Failed to read from\n"
-		       "/proc/sys/vm/compact_unevictable_allowed\n");
+		ksft_print_msg("Failed to read from /proc/sys/vm/compact_unevictable_allowed: %s\n",
+			       strerror(errno));
 		close(fd);
 		return -1;
 	}
@@ -78,12 +78,13 @@ int prereq(void)
 	if (allowed == '1')
 		return 0;
 
+	ksft_print_msg("Compaction isn't allowed\n");
 	return -1;
 }
 
 int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 {
-	int fd;
+	int fd, ret = -1;
 	int compaction_index = 0;
 	char initial_nr_hugepages[10] = {0};
 	char nr_hugepages[10] = {0};
@@ -94,12 +95,14 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
-		perror("Failed to open /proc/sys/vm/nr_hugepages");
+		ksft_test_result_fail("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		return -1;
 	}
 
 	if (read(fd, initial_nr_hugepages, sizeof(initial_nr_hugepages)) <= 0) {
-		perror("Failed to read from /proc/sys/vm/nr_hugepages");
+		ksft_test_result_fail("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
@@ -107,7 +110,8 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	/* Start with the initial condition of 0 huge pages*/
 	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
-		perror("Failed to write 0 to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
@@ -116,14 +120,16 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	/* Request a large number of huge pages. The Kernel will allocate
 	   as much as it can */
 	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
 	lseek(fd, 0, SEEK_SET);
 
 	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
-		perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to re-read from /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
@@ -131,67 +137,58 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 	   huge pages */
 	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
 
-	if (compaction_index > 3) {
-		printf("No of huge pages allocated = %d\n",
-		       (atoi(nr_hugepages)));
-		fprintf(stderr, "ERROR: Less that 1/%d of memory is available\n"
-			"as huge pages\n", compaction_index);
-		goto close_fd;
-	}
-
-	printf("No of huge pages allocated = %d\n",
-	       (atoi(nr_hugepages)));
-
 	lseek(fd, 0, SEEK_SET);
 
 	if (write(fd, initial_nr_hugepages, strlen(initial_nr_hugepages))
 	    != strlen(initial_nr_hugepages)) {
-		perror("Failed to write value to /proc/sys/vm/nr_hugepages\n");
+		ksft_test_result_fail("Failed to write value to /proc/sys/vm/nr_hugepages: %s\n",
+				      strerror(errno));
 		goto close_fd;
 	}
 
-	close(fd);
-	return 0;
+	if (compaction_index > 3) {
+		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
+			       "as huge pages\n", compaction_index);
+		ksft_test_result_fail("No of huge pages allocated = %d\n", (atoi(nr_hugepages)));
+		goto close_fd;
+	}
+
+	ksft_test_result_pass("Memory compaction succeeded. No of huge pages allocated = %d\n",
+			      (atoi(nr_hugepages)));
+	ret = 0;
 
  close_fd:
 	close(fd);
-	printf("Not OK. Compaction test failed.");
-	return -1;
+	return ret;
 }
 
 
 int main(int argc, char **argv)
 {
 	struct rlimit lim;
-	struct map_list *list, *entry;
+	struct map_list *list = NULL, *entry;
 	size_t page_size, i;
 	void *map = NULL;
 	unsigned long mem_free = 0;
 	unsigned long hugepage_size = 0;
 	long mem_fragmentable_MB = 0;
 
-	if (prereq() != 0) {
-		printf("Either the sysctl compact_unevictable_allowed is not\n"
-		       "set to 1 or couldn't read the proc file.\n"
-		       "Skipping the test\n");
-		return KSFT_SKIP;
-	}
+	ksft_print_header();
+
+	if (prereq() != 0)
+		return ksft_exit_pass();
+
+	ksft_set_plan(1);
 
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
-	if (setrlimit(RLIMIT_MEMLOCK, &lim)) {
-		perror("Failed to set rlimit:\n");
-		return -1;
-	}
+	if (setrlimit(RLIMIT_MEMLOCK, &lim))
+		ksft_exit_fail_msg("Failed to set rlimit: %s\n", strerror(errno));
 
 	page_size = getpagesize();
 
-	list = NULL;
-
-	if (read_memory_info(&mem_free, &hugepage_size) != 0) {
-		printf("ERROR: Cannot read meminfo\n");
-		return -1;
-	}
+	if (read_memory_info(&mem_free, &hugepage_size) != 0)
+		ksft_exit_fail_msg("Failed to get meminfo\n");
 
 	mem_fragmentable_MB = mem_free * 0.8 / 1024;
 
@@ -227,7 +224,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return 0;
+		return ksft_exit_pass();
 
-	return -1;
+	return ksft_exit_fail();
 }
-- 
2.43.0




