Return-Path: <stable+bounces-121425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91938A56EF1
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5007A305C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594C23F420;
	Fri,  7 Mar 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXemk93B"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31914293
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368294; cv=none; b=kSB8V03VuVdqHQ2wUGsynPi3ROuZyK/0Z57B7hXc3JijNiYcRUia0Jwe63TVXqAHyyMsEEcrSI+YZpafcbhV/V1zE9D5nX4gvg+jcz2Zogp3Mgg6+VL51MHh5jW06HAx2+AAC8gVoXrFqBVUQAb89A7E2ZreM5sT9Gn1DBWHu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368294; c=relaxed/simple;
	bh=Gn9EZX1iq9I9/ueO0wi4TvTU+oBQyT6epI+/H8TQfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MG+cDkaBQvmamip0ep5OQQwuu9Y1zzl5dOk6mGB8yedkNHY98D4D+DzG4AelTruR8jI5dfRLZt5isPABTcZ5w1oGCbDTmILmXTaBck2oq5YiIijQnHrzeolsRcXqypvHmfnnHRJRDFoE7crjI6rBEU10qB2E62oF+OhOCDs+LuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KXemk93B; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527GfjDd002596;
	Fri, 7 Mar 2025 17:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=XQ4igYjJ+Sr6AX1E
	tW7EVavxq/Pc5P9krRANMlBYoS8=; b=KXemk93BiZ12fbFIq3jCl4h4RPTSbfM2
	0GIc5+q80cw2fg/oc/9Sjt2hH4SYdQYqKhr8B6prjq9NPfG0Wjag6lYCL/6URH1d
	n5tAmgoTNyV2N1aXvFn3QqrNVzV2T24ssv4WdhRmgYL0z+W6auEis5cWygO2h+UP
	hVQ3GFXvRWQ1NEVpRFIGEXTOp/I4mI8PdWLzlBN0OMycgyF/bEuMI9Hwtn2/dAsD
	Bi7DIHwVUq6+i/TRHCUlqxIDfJeKtymu/WzAAb0fkqUJlrT2rDL44EqgHTZqLK5t
	1/KSw6bV2vsPfbvVAkdYyrVZSYr9yIpJW70UFJncfFbyW5cY2nxcGQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hmqeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 17:24:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527G0LM9013611;
	Fri, 7 Mar 2025 17:24:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpfdgtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 17:24:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 527HKevb000959;
	Fri, 7 Mar 2025 17:24:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-5.vpn.oracle.com [10.154.59.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rpfdgry-1;
	Fri, 07 Mar 2025 17:24:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: stable@vger.kernel.org
Cc: memxor@gmail.com, Jiri Olsa <jolsa@kernel.org>,
        Colm Harrington <colm.harrington@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH linux-6.12.y] selftests/bpf: Clean up open-coded gettid syscall invocations
Date: Fri,  7 Mar 2025 17:24:38 +0000
Message-ID: <20250307172439.3656157-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070130
X-Proofpoint-GUID: e-dPEuWfPVKieLzef7W3R71E_mx55WkR
X-Proofpoint-ORIG-GUID: e-dPEuWfPVKieLzef7W3R71E_mx55WkR

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Availability of the gettid definition across glibc versions supported by
BPF selftests is not certain. Currently, all users in the tree open-code
syscall to gettid. Convert them to a common macro definition.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241104171959.2938862-3-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 0e2fb011a0ba8e2258ce776fdf89fbd589c2a3a6)

This backport is needed to build BPF selftests successfully for
linux-6.12.y, as when currently building BPF selftests, the following
error is seen:

  TEST-OBJ [test_progs] raw_tp_null.test.o
prog_tests/raw_tp_null.c: In function ‘test_raw_tp_null’:
prog_tests/raw_tp_null.c:15:26: error: implicit declaration of function ‘sys_gettid’; did you mean ‘gettid’? [-Werror=implicit-function-declaration]
   15 |         skel->bss->tid = sys_gettid();
      |                          ^~~~~~~~~~
      |                          gettid
cc1: all warnings being treated as errors

Fixes: abd30e947f70 ("selftests/bpf: Add tests for raw_tp null handling")

Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Conflicts:
	tools/testing/selftests/bpf/prog_tests/task_local_storage.c

Conflicts were due to new unrelated context in the upstream version.

---
 tools/testing/selftests/bpf/benchs/bench_trigger.c     |  3 ++-
 tools/testing/selftests/bpf/bpf_util.h                 |  9 +++++++++
 .../testing/selftests/bpf/map_tests/task_storage_map.c |  3 ++-
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c      |  6 +++---
 .../selftests/bpf/prog_tests/cgrp_local_storage.c      | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/linked_funcs.c  |  2 +-
 .../selftests/bpf/prog_tests/ns_current_pid_tgid.c     |  2 +-
 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c |  4 ++--
 .../selftests/bpf/prog_tests/task_local_storage.c      |  8 ++++----
 .../selftests/bpf/prog_tests/uprobe_multi_test.c       |  2 +-
 12 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2ed0ef6f21ee..32e9f194d449 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -4,6 +4,7 @@
 #include <argp.h>
 #include <unistd.h>
 #include <stdint.h>
+#include "bpf_util.h"
 #include "bench.h"
 #include "trigger_bench.skel.h"
 #include "trace_helpers.h"
@@ -72,7 +73,7 @@ static __always_inline void inc_counter(struct counter *counters)
 	unsigned slot;
 
 	if (unlikely(tid == 0))
-		tid = syscall(SYS_gettid);
+		tid = sys_gettid();
 
 	/* multiplicative hashing, it's fast */
 	slot = 2654435769U * tid;
diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index 10587a29b967..feff92219e21 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <syscall.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 
 static inline unsigned int bpf_num_possible_cpus(void)
@@ -59,4 +60,12 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+/* Availability of gettid across glibc versions is hit-and-miss, therefore
+ * fallback to syscall in this macro and use it everywhere.
+ */
+#ifndef sys_gettid
+#define sys_gettid() syscall(SYS_gettid)
+#endif
+
+
 #endif /* __BPF_UTIL__ */
diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 7d050364efca..62971dbf2996 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -12,6 +12,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include "bpf_util.h"
 #include "test_maps.h"
 #include "task_local_storage_helpers.h"
 #include "read_bpf_task_storage_busy.skel.h"
@@ -115,7 +116,7 @@ void test_task_storage_map_stress_lookup(void)
 	CHECK(err, "attach", "error %d\n", err);
 
 	/* Trigger program */
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->pid = 0;
 
 	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 070c52c312e5..6befa870434b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -690,7 +690,7 @@ void test_bpf_cookie(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->my_tid = syscall(SYS_gettid);
+	skel->bss->my_tid = sys_gettid();
 
 	if (test__start_subtest("kprobe"))
 		kprobe_subtest(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9006549a1294..b8e1224cfd19 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");
 
-	skel->bss->tid = syscall(SYS_gettid);
+	skel->bss->tid = sys_gettid();
 
 	do_dummy_read_opts(skel->progs.dump_task, opts);
 
@@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;
 
-	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
+	ASSERT_NEQ(getpid(), sys_gettid(), "check_new_thread_id");
 
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid = syscall(SYS_gettid);
+	linfo.task.tid = sys_gettid();
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 	test_task_common(&opts, 0, 1);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 747761572098..9015e2c2ab12 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -63,14 +63,14 @@ static void test_tp_btf(int cgroup_fd)
 	if (!ASSERT_OK(err, "map_delete_elem"))
 		goto out;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = cgrp_ls_tp_btf__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	skel->bss->target_pid = 0;
 
@@ -154,7 +154,7 @@ static void test_recursion(int cgroup_fd)
 		goto out;
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
-	syscall(SYS_gettid);
+	sys_gettid();
 
 out:
 	cgrp_ls_recursion__destroy(skel);
@@ -224,7 +224,7 @@ static void test_yes_rcu_lock(__u64 cgroup_id)
 		return;
 
 	CGROUP_MODE_SET(skel);
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
 	err = cgrp_ls_sleepable__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 26019313e1fc..1c682550e0e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1010,7 +1010,7 @@ static void run_core_reloc_tests(bool use_btfgen)
 	struct data *data;
 	void *mmap_data = NULL;
 
-	my_pid_tgid = getpid() | ((uint64_t)syscall(SYS_gettid) << 32);
+	my_pid_tgid = getpid() | ((uint64_t)sys_gettid() << 32);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		char btf_file[] = "/tmp/core_reloc.btf.XXXXXX";
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
index cad664546912..fa639b021f7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
@@ -20,7 +20,7 @@ void test_linked_funcs(void)
 	bpf_program__set_autoload(skel->progs.handler1, true);
 	bpf_program__set_autoload(skel->progs.handler2, true);
 
-	skel->rodata->my_tid = syscall(SYS_gettid);
+	skel->rodata->my_tid = sys_gettid();
 	skel->bss->syscall_id = SYS_getpgid;
 
 	err = linked_funcs__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index c29787e092d6..761ce24bce38 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -23,7 +23,7 @@ static int get_pid_tgid(pid_t *pid, pid_t *tgid,
 	struct stat st;
 	int err;
 
-	*pid = syscall(SYS_gettid);
+	*pid = sys_gettid();
 	*tgid = getpid();
 
 	err = stat("/proc/self/ns/pid", &st);
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index a1f7e7378a64..ebe0c12b5536 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -21,7 +21,7 @@ static void test_success(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.get_cgroup_id, true);
 	bpf_program__set_autoload(skel->progs.task_succ, true);
@@ -58,7 +58,7 @@ static void test_rcuptr_acquire(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	bpf_program__set_autoload(skel->progs.task_acquire, true);
 	err = rcu_read_lock__load(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..0d42ce00166f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -23,14 +23,14 @@ static void test_sys_enter_exit(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	skel->bss->target_pid = syscall(SYS_gettid);
+	skel->bss->target_pid = sys_gettid();
 
 	err = task_local_storage__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
-	syscall(SYS_gettid);
-	syscall(SYS_gettid);
+	sys_gettid();
+	sys_gettid();
 
 	/* 3x syscalls: 1x attach and 2x gettid */
 	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
@@ -99,7 +99,7 @@ static void test_recursion(void)
 
 	/* trigger sys_enter, make sure it does not cause deadlock */
 	skel->bss->test_pid = getpid();
-	syscall(SYS_gettid);
+	sys_gettid();
 	skel->bss->test_pid = 0;
 	task_ls_recursion__detach(skel);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index c1ac813ff9ba..02a484b22aa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -125,7 +125,7 @@ static void *child_thread(void *ctx)
 	struct child *child = ctx;
 	int c = 0, err;
 
-	child->tid = syscall(SYS_gettid);
+	child->tid = sys_gettid();
 
 	/* let parent know we are ready */
 	err = write(child->c2p[1], &c, 1);
-- 
2.43.5


