Return-Path: <stable+bounces-38-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FD7F5E6E
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53771C20EF8
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92223770;
	Thu, 23 Nov 2023 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBYQGSd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0082375C
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 11:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EFCC433C8;
	Thu, 23 Nov 2023 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700740596;
	bh=Vk5SQGBjLz8a0R0cOyNl/a+0fBPGrcFfJsDwtP1JWBg=;
	h=Subject:To:Cc:From:Date:From;
	b=YBYQGSd2TxAkmNaNQZF45Elo/8JPdRI9Mq6pr0y888ukAxQdOdgcgdeZG1bWLqTOY
	 0c+xdzapzNoxzZdgXg8zzF4sKln9R1Yawrysaj9h/+05ZWJdsTy4ziINu/32Wto1b3
	 3KqjTDUxHtPJq79FepVhEUG0SFWstDfvtbdwJzpk=
Subject: FAILED: patch "[PATCH] selftests/resctrl: Refactor feature check to use resource and" failed to apply to 6.5-stable tree
To: ilpo.jarvinen@linux.intel.com,reinette.chatre@intel.com,skhan@linuxfoundation.org,stable@vger.kernel.org,tan.shaopeng@jp.fujitsu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 11:56:30 +0000
Message-ID: <2023112330-wildfowl-gutter-2ce0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x d56e5da0e0f557a206bace16bbbdad00a5800e34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112330-wildfowl-gutter-2ce0@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

d56e5da0e0f5 ("selftests/resctrl: Refactor feature check to use resource and feature name")
caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d56e5da0e0f557a206bace16bbbdad00a5800e34 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Oct 2023 12:48:11 +0300
Subject: [PATCH] selftests/resctrl: Refactor feature check to use resource and
 feature name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Feature check in validate_resctrl_feature_request() takes in the test
name string and maps that to what to check per test.

Pass resource and feature names to validate_resctrl_feature_request()
directly rather than deriving them from the test name inside the
function which makes the feature check easier to extend for new test
cases.

Use !! in the return statement to make the boolean conversion more
obvious even if it is not strictly necessary from correctness point of
view (to avoid it looking like the function is returning a freed
pointer).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: <stable@vger.kernel.org> # selftests/resctrl: Remove duplicate feature check from CMT test
Cc: <stable@vger.kernel.org> # selftests/resctrl: Move _GNU_SOURCE define into Makefile
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d9b5df95849d..8578a8b4e145 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -27,10 +27,6 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
-#define L3_PATH			"/sys/fs/resctrl/info/L3"
-#define MB_PATH			"/sys/fs/resctrl/info/MB"
-#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
-#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
@@ -87,7 +83,7 @@ int get_resource_id(int cpu_no, int *resource_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resource, const char *feature);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 495aeee5b734..a19dcc3f8fb0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -103,7 +103,9 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		goto cleanup;
 	}
@@ -128,7 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
@@ -151,7 +153,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CMT_STR)) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto cleanup;
 	}
@@ -176,7 +178,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CAT_STR)) {
+	if (!validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
 		goto cleanup;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..3a8111362d26 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -8,6 +8,8 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <limits.h>
+
 #include "resctrl.h"
 
 static int find_resctrl_mount(char *buffer)
@@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
 
 /*
  * validate_resctrl_feature_request - Check if requested feature is valid.
- * @resctrl_val:	Requested feature
+ * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
+ * @feature:	Required monitor feature (in mon_features file). Can only be
+ *		set for L3_MON. Must be NULL for all other resources.
  *
- * Return: True if the feature is supported, else false. False is also
- *         returned if resctrl FS is not mounted.
+ * Return: True if the resource/feature is supported, else false. False is
+ *         also returned if resctrl FS is not mounted.
  */
-bool validate_resctrl_feature_request(const char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resource, const char *feature)
 {
+	char res_path[PATH_MAX];
 	struct stat statbuf;
-	bool found = false;
 	char *res;
 	FILE *inf;
 	int ret;
 
-	if (!resctrl_val)
+	if (!resource)
 		return false;
 
 	ret = find_resctrl_mount(NULL);
 	if (ret)
 		return false;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		if (!stat(L3_PATH, &statbuf))
-			return true;
-	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		if (!stat(MB_PATH, &statbuf))
-			return true;
-	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
-		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-		if (!stat(L3_MON_PATH, &statbuf)) {
-			inf = fopen(L3_MON_FEATURES_PATH, "r");
-			if (!inf)
-				return false;
-
-			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-				res = fgrep(inf, "llc_occupancy");
-				if (res) {
-					found = true;
-					free(res);
-				}
-			}
-
-			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-				res = fgrep(inf, "mbm_total_bytes");
-				if (res) {
-					free(res);
-					res = fgrep(inf, "mbm_local_bytes");
-					if (res) {
-						found = true;
-						free(res);
-					}
-				}
-			}
-			fclose(inf);
-		}
-	}
+	snprintf(res_path, sizeof(res_path), "%s/%s", INFO_PATH, resource);
+
+	if (stat(res_path, &statbuf))
+		return false;
+
+	if (!feature)
+		return true;
+
+	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
+	inf = fopen(res_path, "r");
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, feature);
+	free(res);
+	fclose(inf);
 
-	return found;
+	return !!res;
 }
 
 int filter_dmesg(void)


