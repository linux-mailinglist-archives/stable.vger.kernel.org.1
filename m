Return-Path: <stable+bounces-63359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FBE941885
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A0B285E71
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD91A618E;
	Tue, 30 Jul 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jp33akp7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862101A6161;
	Tue, 30 Jul 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356576; cv=none; b=jFtnGXw325eTPBN80va8IdZPVmCZPvj2A/dORWCiDL7tKqRpwk5tFo92HaWqTExNJ8aEdfQPryAKANasNJHLuyLN3lQqVhrXhHTgqDOcUxj7AfkmRZIGH3h1R5115ZJqfTfEoxUbbBRNmCtObfshTBbwRz+x50yBnQfhJL9JbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356576; c=relaxed/simple;
	bh=LCa1rvFD2qq2Uw2nXz20ClqRlzDmP7STtg0VcvjSpKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJS2YZX5Q8VIo7lUbykl1gAJzDpDEonWvr3m1wAAYjNKbPcurT98sIZ8An/ztGv+AVcXbqhck70/+j9XWFJIS0vl2xRNpGYa0+I5w/zX86y9pA14oK8sBYw6iHSrSrYm5get0IuqywqdHM/UAsZlNDJ4N8Ta6y2K8cpiZoBhdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jp33akp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB29C32782;
	Tue, 30 Jul 2024 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356576;
	bh=LCa1rvFD2qq2Uw2nXz20ClqRlzDmP7STtg0VcvjSpKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jp33akp7FkhD7EMFCm67qIrdoz30nH0HM+ykEAsRCOoDnHA48Vk2vOPVwTnLI8lY8
	 Jcw3BlwIkE7hspGhJxP7dIatYYFnTsSrmqNZDjMe840pL+kumNYvcMUEOYBMPYXZxc
	 CAhXjKL2fsB8DsubKBEczwFzLPSZyr4XGDPrvPmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 163/568] selftests/resctrl: Convert perror() to ksft_perror() or ksft_print_msg()
Date: Tue, 30 Jul 2024 17:44:30 +0200
Message-ID: <20240730151646.257411982@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

[ Upstream commit cc8ff7f5c85c076297b18fb9f6d45ec5569d3d44 ]

The resctrl selftest code contains a number of perror() calls. Some of
them come with hash character and some don't. The kselftest framework
provides ksft_perror() that is compatible with test output formatting
so it should be used instead of adding custom hash signs.

Some perror() calls are too far away from anything that sets error.
For those call sites, ksft_print_msg() must be used instead.

Convert perror() to ksft_perror() or ksft_print_msg().

Other related changes:
- Remove hash signs
- Remove trailing stops & newlines from ksft_perror()
- Add terminating newlines for converted ksft_print_msg()
- Use consistent capitalization
- Small fixes/tweaks to typos & grammar of the messages
- Extract error printing out of PARENT_EXIT() to be able to
  differentiate

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: c44000b6535d ("selftests/resctrl: Fix closing IMC fds on error and open-code R+W instead of loops")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/cache.c       | 10 +--
 tools/testing/selftests/resctrl/cat_test.c    |  8 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  2 +-
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  3 +-
 tools/testing/selftests/resctrl/resctrl_val.c | 76 ++++++++++---------
 tools/testing/selftests/resctrl/resctrlfs.c   | 42 +++++-----
 9 files changed, 77 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index a0318bd3a63d8..601ab78dbf421 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -40,7 +40,7 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
 				PERF_FLAG_FD_CLOEXEC);
 	if (fd_lm == -1) {
-		perror("Error opening leader");
+		ksft_perror("Error opening leader");
 		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
@@ -95,7 +95,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 
 	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
 	if (ret == -1) {
-		perror("Could not get llc misses through perf");
+		ksft_perror("Could not get llc misses through perf");
 		return -1;
 	}
 
@@ -124,12 +124,12 @@ static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
 
 	fp = fopen(llc_occup_path, "r");
 	if (!fp) {
-		perror("Failed to open results file");
+		ksft_perror("Failed to open results file");
 
 		return errno;
 	}
 	if (fscanf(fp, "%lu", llc_occupancy) <= 0) {
-		perror("Could not get llc occupancy");
+		ksft_perror("Could not get llc occupancy");
 		fclose(fp);
 
 		return -1;
@@ -159,7 +159,7 @@ static int print_results_cache(char *filename, int bm_pid,
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
-			perror("Cannot open results file");
+			ksft_perror("Cannot open results file");
 
 			return errno;
 		}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 224ba8544d8af..9bb8ba93f4335 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -51,7 +51,7 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
-		perror("# Cannot open file");
+		ksft_perror("Cannot open file");
 
 		return errno;
 	}
@@ -149,7 +149,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	param.num_of_runs = 0;
 
 	if (pipe(pipefd)) {
-		perror("# Unable to create pipe");
+		ksft_perror("Unable to create pipe");
 		return errno;
 	}
 
@@ -185,7 +185,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 			 * Just print the error message.
 			 * Let while(1) run and wait for itself to be killed.
 			 */
-			perror("# failed signaling parent process");
+			ksft_perror("Failed signaling parent process");
 
 		close(pipefd[1]);
 		while (1)
@@ -197,7 +197,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		while (pipe_message != 1) {
 			if (read(pipefd[0], &pipe_message,
 				 sizeof(pipe_message)) < sizeof(pipe_message)) {
-				perror("# failed reading from child process");
+				ksft_perror("Failed reading from child process");
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 50bdbce9fba95..16fc0488e0a54 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -37,7 +37,7 @@ static int check_results(struct resctrl_val_param *param, size_t span, int no_of
 	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
-		perror("# Error in opening file\n");
+		ksft_perror("Error in opening file");
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 0d425f26583a9..0f6cca61ec94b 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
 	if (!fp) {
-		perror("Unable to write to /dev/null");
+		ksft_perror("Unable to write to /dev/null");
 		return -1;
 	}
 	fprintf(fp, "Sum: %d ", ret);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index d3bf4368341ec..4988b93add6a7 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -109,7 +109,7 @@ static int check_results(void)
 
 	fp = fopen(output, "r");
 	if (!fp) {
-		perror(output);
+		ksft_perror(output);
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d3c0d30c676a7..eb488aabb9ae6 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -59,7 +59,7 @@ static int check_results(size_t span)
 
 	fp = fopen(output, "r");
 	if (!fp) {
-		perror(output);
+		ksft_perror(output);
 
 		return errno;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a33f414f60199..dd3546655657a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -37,9 +37,8 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
-#define PARENT_EXIT(err_msg)			\
+#define PARENT_EXIT()				\
 	do {					\
-		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
 		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 88789678917b6..231d2012de2bd 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -156,12 +156,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
 	fp = fopen(imc_counter_type, "r");
 	if (!fp) {
-		perror("Failed to open imc counter type file");
+		ksft_perror("Failed to open iMC counter type file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
-		perror("Could not get imc type");
+		ksft_perror("Could not get iMC type");
 		fclose(fp);
 
 		return -1;
@@ -175,12 +175,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
 	fp = fopen(imc_counter_cfg, "r");
 	if (!fp) {
-		perror("Failed to open imc config file");
+		ksft_perror("Failed to open iMC config file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		perror("Could not get imc cas count read");
+		ksft_perror("Could not get iMC cas count read");
 		fclose(fp);
 
 		return -1;
@@ -193,12 +193,12 @@ static int read_from_imc_dir(char *imc_dir, int count)
 	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
 	fp = fopen(imc_counter_cfg, "r");
 	if (!fp) {
-		perror("Failed to open imc config file");
+		ksft_perror("Failed to open iMC config file");
 
 		return -1;
 	}
 	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
-		perror("Could not get imc cas count write");
+		ksft_perror("Could not get iMC cas count write");
 		fclose(fp);
 
 		return -1;
@@ -262,12 +262,12 @@ static int num_of_imcs(void)
 		}
 		closedir(dp);
 		if (count == 0) {
-			perror("Unable find iMC counters!\n");
+			ksft_print_msg("Unable to find iMC counters\n");
 
 			return -1;
 		}
 	} else {
-		perror("Unable to open PMU directory!\n");
+		ksft_perror("Unable to open PMU directory");
 
 		return -1;
 	}
@@ -339,14 +339,14 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
 
 		if (read(r->fd, &r->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			perror("Couldn't get read b/w through iMC");
+			ksft_perror("Couldn't get read b/w through iMC");
 
 			return -1;
 		}
 
 		if (read(w->fd, &w->return_value,
 			 sizeof(struct membw_read_format)) == -1) {
-			perror("Couldn't get write bw through iMC");
+			ksft_perror("Couldn't get write bw through iMC");
 
 			return -1;
 		}
@@ -416,7 +416,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 	int resource_id;
 
 	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		perror("Could not get resource_id");
+		ksft_print_msg("Could not get resource_id\n");
 		return;
 	}
 
@@ -449,12 +449,12 @@ static int get_mem_bw_resctrl(unsigned long *mbm_total)
 
 	fp = fopen(mbm_total_path, "r");
 	if (!fp) {
-		perror("Failed to open total bw file");
+		ksft_perror("Failed to open total bw file");
 
 		return -1;
 	}
 	if (fscanf(fp, "%lu", mbm_total) <= 0) {
-		perror("Could not get mbm local bytes");
+		ksft_perror("Could not get mbm local bytes");
 		fclose(fp);
 
 		return -1;
@@ -495,7 +495,7 @@ int signal_handler_register(void)
 	if (sigaction(SIGINT, &sigact, NULL) ||
 	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
-		perror("# sigaction");
+		ksft_perror("sigaction");
 		ret = -1;
 	}
 	return ret;
@@ -515,7 +515,7 @@ void signal_handler_unregister(void)
 	if (sigaction(SIGINT, &sigact, NULL) ||
 	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
-		perror("# sigaction");
+		ksft_perror("sigaction");
 	}
 }
 
@@ -540,14 +540,14 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	} else {
 		fp = fopen(filename, "a");
 		if (!fp) {
-			perror("Cannot open results file");
+			ksft_perror("Cannot open results file");
 
 			return errno;
 		}
 		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
 			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			ksft_print_msg("Could not log results\n");
 			fclose(fp);
-			perror("Could not log results.");
 
 			return errno;
 		}
@@ -585,7 +585,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 	int resource_id;
 
 	if (get_resource_id(cpu_no, &resource_id) < 0) {
-		perror("# Unable to resource_id");
+		ksft_print_msg("Could not get resource_id\n");
 		return;
 	}
 
@@ -647,20 +647,24 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	 * stdio (console)
 	 */
 	fp = freopen("/dev/null", "w", stdout);
-	if (!fp)
-		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+	if (!fp) {
+		ksft_perror("Unable to direct benchmark status to /dev/null");
+		PARENT_EXIT();
+	}
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
 		/* Execute default fill_buf benchmark */
 		span = strtoul(benchmark_cmd[1], NULL, 10);
 		memflush =  atoi(benchmark_cmd[2]);
 		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true"))
+		if (!strcmp(benchmark_cmd[4], "true")) {
 			once = true;
-		else if (!strcmp(benchmark_cmd[4], "false"))
+		} else if (!strcmp(benchmark_cmd[4], "false")) {
 			once = false;
-		else
-			PARENT_EXIT("Invalid once parameter");
+		} else {
+			ksft_print_msg("Invalid once parameter\n");
+			PARENT_EXIT();
+		}
 
 		if (run_fill_buf(span, memflush, operation, once))
 			fprintf(stderr, "Error in running fill buffer\n");
@@ -668,11 +672,12 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		/* Execute specified benchmark */
 		ret = execvp(benchmark_cmd[0], benchmark_cmd);
 		if (ret)
-			perror("wrong\n");
+			ksft_perror("execvp");
 	}
 
 	fclose(stdout);
-	PARENT_EXIT("Unable to run specified benchmark");
+	ksft_print_msg("Unable to run specified benchmark\n");
+	PARENT_EXIT();
 }
 
 /*
@@ -709,7 +714,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	ppid = getpid();
 
 	if (pipe(pipefd)) {
-		perror("# Unable to create pipe");
+		ksft_perror("Unable to create pipe");
 
 		return -1;
 	}
@@ -721,7 +726,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	fflush(stdout);
 	bm_pid = fork();
 	if (bm_pid == -1) {
-		perror("# Unable to fork");
+		ksft_perror("Unable to fork");
 
 		return -1;
 	}
@@ -738,15 +743,17 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		sigact.sa_flags = SA_SIGINFO;
 
 		/* Register for "SIGUSR1" signal from parent */
-		if (sigaction(SIGUSR1, &sigact, NULL))
-			PARENT_EXIT("Can't register child for signal");
+		if (sigaction(SIGUSR1, &sigact, NULL)) {
+			ksft_perror("Can't register child for signal");
+			PARENT_EXIT();
+		}
 
 		/* Tell parent that child is ready */
 		close(pipefd[0]);
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
 		    sizeof(pipe_message)) {
-			perror("# failed signaling parent process");
+			ksft_perror("Failed signaling parent process");
 			close(pipefd[1]);
 			return -1;
 		}
@@ -755,7 +762,8 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 		/* Suspend child until delivery of "SIGUSR1" from parent */
 		sigsuspend(&sigact.sa_mask);
 
-		PARENT_EXIT("Child is done");
+		ksft_perror("Child is done");
+		PARENT_EXIT();
 	}
 
 	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
@@ -796,7 +804,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	while (pipe_message != 1) {
 		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
 		    sizeof(pipe_message)) {
-			perror("# failed reading message from child process");
+			ksft_perror("Failed reading message from child process");
 			close(pipefd[0]);
 			goto out;
 		}
@@ -805,7 +813,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	/* Signal child to start benchmark */
 	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
-		perror("# sigqueue SIGUSR1 to child");
+		ksft_perror("sigqueue SIGUSR1 to child");
 		ret = errno;
 		goto out;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 9ac19acaf781d..71ad2b335b83f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -19,7 +19,7 @@ static int find_resctrl_mount(char *buffer)
 
 	mounts = fopen("/proc/mounts", "r");
 	if (!mounts) {
-		perror("/proc/mounts");
+		ksft_perror("/proc/mounts");
 		return -ENXIO;
 	}
 	while (!feof(mounts)) {
@@ -68,7 +68,7 @@ int mount_resctrlfs(void)
 	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
 	if (ret)
-		perror("# mount");
+		ksft_perror("mount");
 
 	return ret;
 }
@@ -85,7 +85,7 @@ int umount_resctrlfs(void)
 		return ret;
 
 	if (umount(mountpoint)) {
-		perror("# Unable to umount resctrl");
+		ksft_perror("Unable to umount resctrl");
 
 		return errno;
 	}
@@ -114,12 +114,12 @@ int get_resource_id(int cpu_no, int *resource_id)
 
 	fp = fopen(phys_pkg_path, "r");
 	if (!fp) {
-		perror("Failed to open physical_package_id");
+		ksft_perror("Failed to open physical_package_id");
 
 		return -1;
 	}
 	if (fscanf(fp, "%d", resource_id) <= 0) {
-		perror("Could not get socket number or l3 id");
+		ksft_perror("Could not get socket number or l3 id");
 		fclose(fp);
 
 		return -1;
@@ -148,7 +148,7 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 	} else if (!strcmp(cache_type, "L2")) {
 		cache_num = 2;
 	} else {
-		perror("Invalid cache level");
+		ksft_print_msg("Invalid cache level\n");
 		return -1;
 	}
 
@@ -156,12 +156,12 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 		cpu_no, cache_num);
 	fp = fopen(cache_path, "r");
 	if (!fp) {
-		perror("Failed to open cache size");
+		ksft_perror("Failed to open cache size");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cache_str) <= 0) {
-		perror("Could not get cache_size");
+		ksft_perror("Could not get cache_size");
 		fclose(fp);
 
 		return -1;
@@ -213,12 +213,12 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
 
 	fp = fopen(cbm_mask_path, "r");
 	if (!fp) {
-		perror("Failed to open cache level");
+		ksft_perror("Failed to open cache level");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cbm_mask) <= 0) {
-		perror("Could not get max cbm_mask");
+		ksft_perror("Could not get max cbm_mask");
 		fclose(fp);
 
 		return -1;
@@ -245,12 +245,12 @@ int get_core_sibling(int cpu_no)
 
 	fp = fopen(core_siblings_path, "r");
 	if (!fp) {
-		perror("Failed to open core siblings path");
+		ksft_perror("Failed to open core siblings path");
 
 		return -1;
 	}
 	if (fscanf(fp, "%s", cpu_list_str) <= 0) {
-		perror("Could not get core_siblings list");
+		ksft_perror("Could not get core_siblings list");
 		fclose(fp);
 
 		return -1;
@@ -285,7 +285,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 	CPU_SET(cpu_no, &my_set);
 
 	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
-		perror("Unable to taskset benchmark");
+		ksft_perror("Unable to taskset benchmark");
 
 		return -1;
 	}
@@ -324,7 +324,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 		}
 		closedir(dp);
 	} else {
-		perror("Unable to open resctrl for group");
+		ksft_perror("Unable to open resctrl for group");
 
 		return -1;
 	}
@@ -332,7 +332,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
 	/* Requested grp doesn't exist, hence create it */
 	if (found_grp == 0) {
 		if (mkdir(grp, 0) == -1) {
-			perror("Unable to create group");
+			ksft_perror("Unable to create group");
 
 			return -1;
 		}
@@ -347,12 +347,12 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
 
 	fp = fopen(tasks, "w");
 	if (!fp) {
-		perror("Failed to open tasks file");
+		ksft_perror("Failed to open tasks file");
 
 		return -1;
 	}
 	if (fprintf(fp, "%d\n", pid) < 0) {
-		perror("Failed to wr pid to tasks file");
+		ksft_print_msg("Failed to write pid to tasks file\n");
 		fclose(fp);
 
 		return -1;
@@ -419,7 +419,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 out:
 	ksft_print_msg("Writing benchmark parameters to resctrl FS\n");
 	if (ret)
-		perror("# writing to resctrlfs");
+		ksft_print_msg("Failed writing to resctrlfs\n");
 
 	return ret;
 }
@@ -606,7 +606,7 @@ int filter_dmesg(void)
 
 	ret = pipe(pipefds);
 	if (ret) {
-		perror("pipe");
+		ksft_perror("pipe");
 		return ret;
 	}
 	fflush(stdout);
@@ -615,13 +615,13 @@ int filter_dmesg(void)
 		close(pipefds[0]);
 		dup2(pipefds[1], STDOUT_FILENO);
 		execlp("dmesg", "dmesg", NULL);
-		perror("executing dmesg");
+		ksft_perror("Executing dmesg");
 		exit(1);
 	}
 	close(pipefds[1]);
 	fp = fdopen(pipefds[0], "r");
 	if (!fp) {
-		perror("fdopen(pipe)");
+		ksft_perror("fdopen(pipe)");
 		kill(pid, SIGTERM);
 
 		return -1;
-- 
2.43.0




