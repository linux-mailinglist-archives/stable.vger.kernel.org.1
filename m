Return-Path: <stable+bounces-905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016567F7D12
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A53AB215D3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B863A8C3;
	Fri, 24 Nov 2023 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjvYZHv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A59381D6;
	Fri, 24 Nov 2023 18:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D8C433C7;
	Fri, 24 Nov 2023 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850070;
	bh=99GftIU5F4jI9C2kYOseLpLZKblmvfJMVa6/79/61D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjvYZHv0HkAowgK15jT0yT4yn603ks9HbavcJJgRgruN3pH/2CVPAPtb52NOWogfG
	 iLBebqQP3zhHr5dP8ywjQYaHmRIKLldNhLFSFcp1kaHS3Y2+2MStWLvgqsuZj687E7
	 flYOMOAr3kK4LTrWuO2QwpKKTInTFdYs+GCv5JcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 409/530] selftests/resctrl: Simplify span lifetime
Date: Fri, 24 Nov 2023 17:49:35 +0000
Message-ID: <20231124172040.499761909@linuxfoundation.org>
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

[ Upstream commit b1a901e078c4ee4a6fe13021c4577ef5f3155251 ]

struct resctrl_val_param contains span member. resctrl_val(), however,
never uses it because the value of span is embedded into the default
benchmark command and parsed from it by run_benchmark().

Remove span from resctrl_val_param. Provide DEFAULT_SPAN for the code
that needs it. CMT and CAT tests communicate span that is different
from the DEFAULT_SPAN between their internal functions which is
converted into passing it directly as a parameter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 3aff51464455 ("selftests/resctrl: Extend signal handler coverage to unmount on receiving signal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/cache.c         |  5 +++--
 tools/testing/selftests/resctrl/cat_test.c      | 13 +++++++------
 tools/testing/selftests/resctrl/cmt_test.c      | 11 ++++++-----
 tools/testing/selftests/resctrl/mbm_test.c      |  5 ++---
 tools/testing/selftests/resctrl/resctrl.h       |  8 ++++----
 tools/testing/selftests/resctrl/resctrl_tests.c |  9 ++++-----
 6 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index d3cbb829ff6a7..a0318bd3a63d8 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -205,10 +205,11 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  * cache_val:		execute benchmark and measure LLC occupancy resctrl
  * and perf cache miss for the benchmark
  * @param:		parameters passed to cache_val()
+ * @span:		buffer size for the benchmark
  *
  * Return:		0 on success. non-zero on failure.
  */
-int cat_val(struct resctrl_val_param *param)
+int cat_val(struct resctrl_val_param *param, size_t span)
 {
 	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
@@ -245,7 +246,7 @@ int cat_val(struct resctrl_val_param *param)
 		if (ret)
 			break;
 
-		if (run_fill_buf(param->span, memflush, operation, true)) {
+		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
 			ret = -1;
 			goto pe_close;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 3848dfb46aba4..97b87285ab2a9 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -41,7 +41,7 @@ static int cat_setup(struct resctrl_val_param *p)
 	return ret;
 }
 
-static int check_results(struct resctrl_val_param *param)
+static int check_results(struct resctrl_val_param *param, size_t span)
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_perf_miss = 0;
@@ -76,7 +76,7 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
+	return show_cache_info(sum_llc_perf_miss, no_of_bits, span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
@@ -96,6 +96,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	char cbm_mask[256];
 	int count_of_bits;
 	char pipe_message;
+	size_t span;
 
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
@@ -140,7 +141,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	span = cache_size * (count_of_bits - n) / count_of_bits;
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -162,7 +163,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		param.span = cache_size * n / count_of_bits;
+		span = cache_size * n / count_of_bits;
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
@@ -176,9 +177,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_val(&param);
+	ret = cat_val(&param, span);
 	if (ret == 0)
-		ret = check_results(&param);
+		ret = check_results(&param, span);
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index cc93cb5ae7ee9..33dbe51e77122 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -27,7 +27,7 @@ static int cmt_setup(struct resctrl_val_param *p)
 	return 0;
 }
 
-static int check_results(struct resctrl_val_param *param, int no_of_bits)
+static int check_results(struct resctrl_val_param *param, size_t span, int no_of_bits)
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_occu_resc = 0;
@@ -58,7 +58,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	}
 	fclose(fp);
 
-	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
+	return show_cache_info(sum_llc_occu_resc, no_of_bits, span,
 			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
@@ -74,6 +74,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	unsigned long long_mask;
 	char cbm_mask[256];
 	int count_of_bits;
+	size_t span;
 	int ret;
 
 	ret = get_cbm_mask("L3", cbm_mask);
@@ -102,13 +103,13 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
-		.span		= cache_size * n / count_of_bits,
 		.num_of_runs	= 0,
 		.setup		= cmt_setup,
 	};
 
+	span = cache_size * n / count_of_bits;
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
-		sprintf(benchmark_cmd[1], "%zu", param.span);
+		sprintf(benchmark_cmd[1], "%zu", span);
 
 	remove(RESULT_FILE_NAME);
 
@@ -116,7 +117,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		goto out;
 
-	ret = check_results(&param, n);
+	ret = check_results(&param, span, n);
 
 out:
 	cmt_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 724412186d636..445aea1c64e83 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,13 +109,12 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
+int mbm_bw_change(int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.span		= span,
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
@@ -129,7 +128,7 @@ int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
 	if (ret)
 		goto out;
 
-	ret = check_results(span);
+	ret = check_results(DEFAULT_SPAN);
 
 out:
 	mbm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index df75c89060329..d33452fde5b94 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -33,6 +33,8 @@
 
 #define END_OF_TESTS	1
 
+#define DEFAULT_SPAN		(250 * MB)
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -47,7 +49,6 @@
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @cpu_no:		CPU number to which the benchmark would be binded
- * @span:		Memory bytes accessed in each benchmark iteration
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
@@ -57,7 +58,6 @@ struct resctrl_val_param {
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	int		cpu_no;
-	size_t		span;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
@@ -93,7 +93,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(size_t span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd);
+int mbm_bw_change(int cpu_no, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char **benchmark_cmd);
@@ -103,7 +103,7 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-int cat_val(struct resctrl_val_param *param);
+int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 116f67d833f75..1826b674ea300 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
+static void run_mbm_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -89,7 +89,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
 		goto umount;
 	}
 
-	res = mbm_bw_change(span, cpu_no, benchmark_cmd);
+	res = mbm_bw_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -182,7 +182,6 @@ int main(int argc, char **argv)
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
-	size_t span = 250 * MB;
 	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
@@ -276,7 +275,7 @@ int main(int argc, char **argv)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%zu", span);
+		sprintf(benchmark_cmd[1], "%u", DEFAULT_SPAN);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "0");
 		strcpy(benchmark_cmd[4], "false");
@@ -294,7 +293,7 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(benchmark_cmd, span, cpu_no);
+		run_mbm_test(benchmark_cmd, cpu_no);
 
 	if (mba_test)
 		run_mba_test(benchmark_cmd, cpu_no);
-- 
2.42.0




