Return-Path: <stable+bounces-904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632567F7D11
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C00B21692
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE339FFD;
	Fri, 24 Nov 2023 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lp3sJe4l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F4381D6;
	Fri, 24 Nov 2023 18:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16FC433C7;
	Fri, 24 Nov 2023 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850068;
	bh=C5YY212lGKekfpS09Ujqwja6tQ6fnTuNioRWYaO7ZpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp3sJe4luz5/Pm95/CADIB5nX2rpolYuDFFv6z7Fv0gBikr0yq99bFx1Fr3S8wWAt
	 fUTl/z4hE8wj5BgZ5mhjnRJL8cNQQFTT15P0hjd6ZQvZMf9u/nunPFgBpWutmDHyFt
	 N0NO6Jnt9gNApjg3Dz2o7goIHm+rp2a6OawK1ODA=
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
Subject: [PATCH 6.6 408/530] selftests/resctrl: Remove bw_report and bm_type from main()
Date: Fri, 24 Nov 2023 17:49:34 +0000
Message-ID: <20231124172040.471205466@linuxfoundation.org>
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

[ Upstream commit 47e36f16c7846bf3627ff68525e02555c53dc99e ]

bw_report is always set to "reads" and bm_type is set to "fill_buf" but
is never used.

Set bw_report directly to "reads" in MBA/MBM test and remove bm_type.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 3aff51464455 ("selftests/resctrl: Extend signal handler coverage to unmount on receiving signal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/mba_test.c     |  4 ++--
 tools/testing/selftests/resctrl/mbm_test.c     |  4 ++--
 tools/testing/selftests/resctrl/resctrl.h      |  4 ++--
 .../testing/selftests/resctrl/resctrl_tests.c  | 18 +++++++-----------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index c7d1ec6d81ea8..c5c0588779d2b 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
+int mba_schemata_change(int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
@@ -149,7 +149,7 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= bw_report,
+		.bw_report	= "reads",
 		.setup		= mba_setup
 	};
 	int ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d0c26a5e89fb9..724412186d636 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,7 +109,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd)
+int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
@@ -118,7 +118,7 @@ int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd
 		.span		= span,
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	=  bw_report,
+		.bw_report	= "reads",
 		.setup		= mbm_setup
 	};
 	int ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 9e46fa90e7be7..df75c89060329 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -93,10 +93,10 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(size_t span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
+int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
+int mba_schemata_change(int cpu_no, char **benchmark_cmd);
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 59a361660d8c8..116f67d833f75 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,8 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(char **benchmark_cmd, size_t span,
-			 int cpu_no, char *bw_report)
+static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
 {
 	int res;
 
@@ -90,7 +89,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	res = mbm_bw_change(span, cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -99,7 +98,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -118,7 +117,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 		goto umount;
 	}
 
-	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	res = mba_schemata_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
 umount:
@@ -179,9 +178,9 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
+	char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
 	size_t span = 250 * MB;
 	bool cat_test = true;
@@ -284,9 +283,6 @@ int main(int argc, char **argv)
 		benchmark_cmd[5] = NULL;
 	}
 
-	sprintf(bw_report, "reads");
-	sprintf(bm_type, "fill_buf");
-
 	if (!check_resctrlfs_support())
 		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
@@ -298,10 +294,10 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(benchmark_cmd, span, cpu_no, bw_report);
+		run_mbm_test(benchmark_cmd, span, cpu_no);
 
 	if (mba_test)
-		run_mba_test(benchmark_cmd, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, cpu_no);
 
 	if (cmt_test)
 		run_cmt_test(benchmark_cmd, cpu_no);
-- 
2.42.0




