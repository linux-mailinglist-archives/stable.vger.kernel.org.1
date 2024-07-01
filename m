Return-Path: <stable+bounces-56227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA691DFC0
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A72A1F2342F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631015990E;
	Mon,  1 Jul 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rnz+OBlb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5651598E2
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837945; cv=none; b=iLWSZYHPODPLtrNPNrqI1Q8vJCJT6kdw+/ZzrZYHSuWxF6ArFcVYeKc2J/QKYRIsw6Ae8llt5rvb5BJ1idByFtxItmkqu0JHuP7ouF2Xl+0UydM74n/s2g0kTpeDXWepS3Iz+2JFmXVvpwGf494BbPWe2K66vwgnNvtvuG4RuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837945; c=relaxed/simple;
	bh=AE0F15qB3PKtTz9YSfjHy0zx+KbyZ5tvkoVYhzr8y5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uhaoH+Ql0D9GNIh9qXthzwp82Hw9dc/2v8AL/QnDm2/T59ojDYdCX+p/ytx51tInnlQeHgaUesQBx+f4ucOu3tVg4SvuKIzJl6+WnJ5Vh5kX5bliS+IqdIuDoFiD3JtCm7Gb/x57fjNUmnDiIFNmY/J9etMh+9hl3DrUi5PQtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rnz+OBlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77879C116B1;
	Mon,  1 Jul 2024 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837945;
	bh=AE0F15qB3PKtTz9YSfjHy0zx+KbyZ5tvkoVYhzr8y5U=;
	h=Subject:To:Cc:From:Date:From;
	b=rnz+OBlboqPOsQqaWat4chxS/Evo7vc2WgubWk33Yp3L62E3WOmZ6WREbyyXoOHkD
	 YA5irVthv7nIk1syVHsQo4Dw26eZvKk5cHc5X9yDhbdatrkLHXmSfRZvogKrmsabi/
	 bX//Ne4CnQc7dvnkEND942KqZ2garNrEocrGYjsY=
Subject: FAILED: patch "[PATCH] selftests/mm:fix test_prctl_fork_exec return failure" failed to apply to 5.15-stable tree
To: shechenglong001@gmail.com,akpm@linux-foundation.org,david@redhat.com,shuah@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:29:37 +0200
Message-ID: <2024070137-bolster-virtual-0e64@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8b8546d298dc9ce9d5d01a06c822e255d2159ca7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070137-bolster-virtual-0e64@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8b8546d298dc ("selftests/mm:fix test_prctl_fork_exec return failure")
6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test case for ksm fork/exec")
0374af1da077 ("mm/ksm: test case for prctl fork/exec workflow")
e5013f11c6c9 ("selftest/mm: ksm_functional_tests: Add PROT_NONE test")
42096aa24b82 ("selftest/mm: ksm_functional_tests: test in mmap_and_merge_range() if anything got merged")
3d0745e59c84 ("selftest: add a testcase of ksm zero pages")
1150ea933855 ("selftests/ksm: ksm_functional_tests: add prctl unmerge test")
07115fcc15b4 ("selftests/mm: add new selftests for KSM")
3822a7c40997 ("Merge tag 'mm-stable-2023-02-20-13-37' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b8546d298dc9ce9d5d01a06c822e255d2159ca7 Mon Sep 17 00:00:00 2001
From: aigourensheng <shechenglong001@gmail.com>
Date: Mon, 17 Jun 2024 01:29:34 -0400
Subject: [PATCH] selftests/mm:fix test_prctl_fork_exec return failure

After calling fork() in test_prctl_fork_exec(), the global variable
ksm_full_scans_fd is initialized to 0 in the child process upon entering
the main function of ./ksm_functional_tests.

In the function call chain test_child_ksm() -> __mmap_and_merge_range ->
ksm_merge-> ksm_get_full_scans, start_scans = ksm_get_full_scans() will
return an error.  Therefore, the value of ksm_full_scans_fd needs to be
initialized before calling test_child_ksm in the child process.

Link: https://lkml.kernel.org/r/20240617052934.5834-1-shechenglong001@gmail.com
Signed-off-by: aigourensheng <shechenglong001@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 37de82da9be7..b61803e36d1c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -656,24 +656,8 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
-int main(int argc, char **argv)
+static void init_global_file_handles(void)
 {
-	unsigned int tests = 8;
-	int err;
-
-	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
-		exit(test_child_ksm());
-	}
-
-#ifdef __NR_userfaultfd
-	tests++;
-#endif
-
-	ksft_print_header();
-	ksft_set_plan(tests);
-
-	pagesize = getpagesize();
-
 	mem_fd = open("/proc/self/mem", O_RDWR);
 	if (mem_fd < 0)
 		ksft_exit_fail_msg("opening /proc/self/mem failed\n");
@@ -688,8 +672,30 @@ int main(int argc, char **argv)
 		ksft_exit_skip("open(\"/proc/self/pagemap\") failed\n");
 	proc_self_ksm_stat_fd = open("/proc/self/ksm_stat", O_RDONLY);
 	proc_self_ksm_merging_pages_fd = open("/proc/self/ksm_merging_pages",
-					      O_RDONLY);
+						O_RDONLY);
 	ksm_use_zero_pages_fd = open("/sys/kernel/mm/ksm/use_zero_pages", O_RDWR);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int tests = 8;
+	int err;
+
+	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
+		init_global_file_handles();
+		exit(test_child_ksm());
+	}
+
+#ifdef __NR_userfaultfd
+	tests++;
+#endif
+
+	ksft_print_header();
+	ksft_set_plan(tests);
+
+	pagesize = getpagesize();
+
+	init_global_file_handles();
 
 	test_unmerge();
 	test_unmerge_zero_pages();


