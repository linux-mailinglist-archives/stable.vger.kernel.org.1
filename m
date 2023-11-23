Return-Path: <stable+bounces-37-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1777F5E66
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EF5281BF9
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0949241E8;
	Thu, 23 Nov 2023 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GfeYDxGY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2323760
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEDEC433C7;
	Thu, 23 Nov 2023 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740527;
	bh=Os2/08qdace4DotDawia/Os55qU5jilbvnsuELnjm2g=;
	h=Subject:To:Cc:From:Date:From;
	b=GfeYDxGYrLX+9fNXYsYBavtCBfNugu3AmRSLDAjBQjo7qv6KgnChEEfW90GmPCEfk
	 AhtiPOBjZNsQFwxIXOLGaYRBIiW6XgcJ9pDK3aPJMw5AGsJ43jd0Jjje/LRreQQHnI
	 0ZQ9EZAgoIpCDTZhUfR0B1L/nk0fikMyUEJAtMQk=
Subject: FAILED: patch "[PATCH] selftests/resctrl: Extend signal handler coverage to unmount" failed to apply to 6.6-stable tree
To: ilpo.jarvinen@linux.intel.com,reinette.chatre@intel.com,skhan@linuxfoundation.org,stable@vger.kernel.org,tan.shaopeng@jp.fujitsu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 11:55:21 +0000
Message-ID: <2023112321-epic-pamphlet-c600@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3aff5146445582454c35900f3c0c972987cdd595
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112321-epic-pamphlet-c600@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

3aff51464455 ("selftests/resctrl: Extend signal handler coverage to unmount on receiving signal")
e33cb5702a9f ("selftests/resctrl: Make benchmark command const and build it with pointers")
b1a901e078c4 ("selftests/resctrl: Simplify span lifetime")
47e36f16c784 ("selftests/resctrl: Remove bw_report and bm_type from main()")
4a28c7665c2a ("selftests/resctrl: Ensure the benchmark commands fits to its array")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3aff5146445582454c35900f3c0c972987cdd595 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Oct 2023 12:48:08 +0300
Subject: [PATCH] selftests/resctrl: Extend signal handler coverage to unmount
 on receiving signal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unmounting resctrl FS has been moved into the per test functions in
resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
SIGTERM, or SIGHUP) is received, the running selftest is aborted by
ctrlc_handler() which then unmounts resctrl fs before exiting. The
current section between signal_handler_register() and
signal_handler_unregister(), however, does not cover the entire
duration when resctrl FS is mounted.

Move signal_handler_register() and signal_handler_unregister() calls
from per test files into resctrl_tests.c to properly unmount resctrl
fs. In order to not add signal_handler_register()/unregister() n times,
create helpers test_prepare() and test_cleanup().

Do not call ksft_exit_fail_msg() in test_prepare() but only in the per
test function to keep the control flow cleaner without adding calls to
exit() deep into the call chain.

Adjust child process kill() call in ctrlc_handler() to only be invoked
if the child was already forked.

Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 97b87285ab2a..224ba8544d8a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
-	} else {
-		ret = signal_handler_register();
-		if (ret) {
-			kill(bm_pid, SIGKILL);
-			goto out;
-		}
 	}
 
 	remove(param.filename);
@@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		}
 		close(pipefd[0]);
 		kill(bm_pid, SIGKILL);
-		signal_handler_unregister();
 	}
 
-out:
 	cat_test_cleanup();
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 823672a20a43..495aeee5b734 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -67,21 +67,45 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+static int test_prepare(void)
 {
 	int res;
 
-	ksft_print_msg("Starting MBM BW change ...\n");
+	res = signal_handler_register();
+	if (res) {
+		ksft_print_msg("Failed to register signal handler\n");
+		return res;
+	}
 
 	res = mount_resctrlfs();
 	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+		signal_handler_unregister();
+		ksft_print_msg("Failed to mount resctrl FS\n");
+		return res;
+	}
+	return 0;
+}
+
+static void test_cleanup(void)
+{
+	umount_resctrlfs();
+	signal_handler_unregister();
+}
+
+static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	ksft_print_msg("Starting MBM BW change ...\n");
+
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = mbm_bw_change(cpu_no, benchmark_cmd);
@@ -89,8 +113,8 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
@@ -99,22 +123,21 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = mba_schemata_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
@@ -123,15 +146,14 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting CMT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request(CMT_STR)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -139,8 +161,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_cat_test(int cpu_no, int no_of_bits)
@@ -149,22 +171,21 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request(CAT_STR)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	ksft_test_result(!res, "CAT: test\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 01bbe11a8983..b8ca6fa40b3b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -468,7 +468,9 @@ pid_t bm_pid, ppid;
 
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
-	kill(bm_pid, SIGKILL);
+	/* Only kill child after bm_pid is set after fork() */
+	if (bm_pid)
+		kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
 	tests_cleanup();
 	ksft_print_msg("Ending\n\n");
@@ -485,6 +487,8 @@ int signal_handler_register(void)
 	struct sigaction sigact = {};
 	int ret = 0;
 
+	bm_pid = 0;
+
 	sigact.sa_sigaction = ctrlc_handler;
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = SA_SIGINFO;
@@ -706,10 +710,6 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
 
-	ret = signal_handler_register();
-	if (ret)
-		goto out;
-
 	/*
 	 * The cast removes constness but nothing mutates benchmark_cmd within
 	 * the context of this process. At the receiving process, it becomes
@@ -721,19 +721,19 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	/* Taskset benchmark to specified cpu */
 	ret = taskset_benchmark(bm_pid, param->cpu_no);
 	if (ret)
-		goto unregister;
+		goto out;
 
 	/* Write benchmark to specified control&monitoring grp in resctrl FS */
 	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
 				      resctrl_val);
 	if (ret)
-		goto unregister;
+		goto out;
 
 	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
-			goto unregister;
+			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
@@ -748,7 +748,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		    sizeof(pipe_message)) {
 			perror("# failed reading message from child process");
 			close(pipefd[0]);
-			goto unregister;
+			goto out;
 		}
 	}
 	close(pipefd[0]);
@@ -757,7 +757,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
 		perror("# sigqueue SIGUSR1 to child");
 		ret = errno;
-		goto unregister;
+		goto out;
 	}
 
 	/* Give benchmark enough time to fully run */
@@ -786,8 +786,6 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		}
 	}
 
-unregister:
-	signal_handler_unregister();
 out:
 	kill(bm_pid, SIGKILL);
 


