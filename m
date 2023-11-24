Return-Path: <stable+bounces-882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469927F7CFC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C001BB213FB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8F39FFD;
	Fri, 24 Nov 2023 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5/HNLa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1939FF7;
	Fri, 24 Nov 2023 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183B1C433C8;
	Fri, 24 Nov 2023 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850013;
	bh=UTiALbmFByWclZCabLwWGahfkUXDKg111/ywpORXRsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5/HNLa+AYXOiPB8pOztloIZBBck2tppOF7lsdA0jL3uyKRLHEjKOhCr7gSfulWxw
	 UGz6aZ8grZXZPZIin9KZdd7F91aImcFbPeQ0z5s/Ex0JT+IWSeJFc50dwIU3UAAfHW
	 DC8B8mNFJezhkuFUuWpBhReEW/bi3/z1nKBzSh9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 411/530] selftests/resctrl: Extend signal handler coverage to unmount on receiving signal
Date: Fri, 24 Nov 2023 17:49:37 +0000
Message-ID: <20231124172040.566327251@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 3aff5146445582454c35900f3c0c972987cdd595 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/cat_test.c    |  8 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 69 ++++++++++++-------
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++---
 3 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 97b87285ab2a9..224ba8544d8af 100644
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
index 1ac22c6d8ce8f..31373b69e675d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -67,15 +67,39 @@ void tests_cleanup(void)
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
 
@@ -83,7 +107,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
 	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = mbm_bw_change(cpu_no, benchmark_cmd);
@@ -91,8 +115,8 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
@@ -101,9 +125,8 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
@@ -111,14 +134,14 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
 	    (get_vendor() != ARCH_INTEL)) {
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
@@ -127,16 +150,15 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting CMT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy") ||
 	    !validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
-		goto umount;
+		goto cleanup;
 	}
 
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -144,8 +166,8 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-umount:
-	umount_resctrlfs();
+cleanup:
+	test_cleanup();
 }
 
 static void run_cat_test(int cpu_no, int no_of_bits)
@@ -154,22 +176,21 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
-	res = mount_resctrlfs();
-	if (res) {
-		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+	if (test_prepare()) {
+		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
 	if (!validate_resctrl_feature_request("L3", NULL)) {
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
index 01bbe11a89834..b8ca6fa40b3bf 100644
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
 
-- 
2.42.0




