Return-Path: <stable+bounces-17781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E4847E0E
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C2C1C21C84
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813210E6;
	Sat,  3 Feb 2024 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QkQaH9yQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF31369
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922769; cv=none; b=jXqLOSm8EJVQmzKOmiKTx6U9amk/Laqw0wIHekq7N4+XyOGhXAamPztG3BbTkFTUCuRBxAZV0BsKZ6e3ecdKoI08WF29Lt8Rwn8z8eF18Et2w6TklRg6m1N8lpC5a28kel89OIGk2qwhivBRfD979gacXtJg98G+RZB4GoaMQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922769; c=relaxed/simple;
	bh=/RY7nYXOnqPkWXRx9WuXzsni79N+nRuNl8UoA/cTePA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7JbPiqa4GykuzuohSJx3uIK6yRXNVK5e2svYX25dBpnux3dEbIlvyNz5ggCHAGCzrN3iZWnIIDaEdoK9a+fq0PDYAiGTXN19N3HivOpYnIoYvebO93qOsGTTs0LSuRURbCByi5acCL0S3BFDD2QNTTDkBkMEAYP6e1oUNctbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QkQaH9yQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4130EWPq007448;
	Sat, 3 Feb 2024 01:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=a6KLjOb2QWt/Y18wXRyvQWFwGbGwTYm25Tg/iqQf07w=;
 b=QkQaH9yQrZVJuVjPWiAo7InFwPCQVeldnMRrz15Kw2QNZe8cYIuhOiwhJs9xZEuKLeiD
 D51VDmyo6qQ+96bNUCOr1nxtzY/dISkUoHuhN/+V68Pj3UUrtuQYcBYCZdGGwCVNS6iD
 Z5MfTCNHQyfuiO9874cCTcMKmx089wCu15fED9d9BCZ6tBXrsimAjGcAe70VKJvSJ0kt
 nNTKK+Zgs2fXMlJP6SUZx0g9OjoAinvbnWhbEQJmFmyBe2JL1KlcPifCyv/F+LG8rLiV
 jlrf7Y+Coas2GvxI0RiSA8lPQ+n5cVTdcJwT5sqk4vDovHPzGk4y1RneRaFJRAyGD62d zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqb8wsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 01:12:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4130MoKh006693;
	Sat, 3 Feb 2024 01:12:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9k0h14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 01:12:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4131CUwu020300;
	Sat, 3 Feb 2024 01:12:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9k0h0f-1;
	Sat, 03 Feb 2024 01:12:30 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: jakub@cloudflare.com, daniel@iogearbox.net,
        samasth.norway.ananda@oracle.com, alan.maguire@oracle.com
Subject: [PATCH 5.15.y] Revert "selftests/bpf: Test tail call counting with bpf2bpf and data on stack"
Date: Fri,  2 Feb 2024 17:12:28 -0800
Message-ID: <20240203011229.3326803-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030007
X-Proofpoint-GUID: w75CwO_m97nP7YiW4NbncdU5DdJi6CFP
X-Proofpoint-ORIG-GUID: w75CwO_m97nP7YiW4NbncdU5DdJi6CFP

This reverts commit 3eefb2fbf4ec1c1ff239b8b65e6e78aae335e4a6.

libbpf support for "tc" progs doesn't exist for the linux-5.15.y tree.
This commit was backported too far back in upstream, to a kernel where
the libbpf support was not there for the test.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Conflicts:
        tools/testing/selftests/bpf/prog_tests/tailcalls.c
        conflict was caused due to code overlap with the commit
        b06bde1c5ed6 ("selftests/bpf: Correct map_fd to data_fd in tailcalls")
        in the function test_tailcall_bpf2bpf_6(). As this function is
        removed by the revert conflict is resolved.
---
This was identified when we ran bpf selftest.
$ cd tools/testing/selftests/bpf
$ make test_progs
$ ./test_progs --name=ksyms_module
#137/1 tailcalls/tailcall_1:OK
#137/2 tailcalls/tailcall_2:OK
#137/3 tailcalls/tailcall_3:OK
#137/4 tailcalls/tailcall_4:OK
#137/5 tailcalls/tailcall_5:OK
#137/6 tailcalls/tailcall_bpf2bpf_1:OK
#137/7 tailcalls/tailcall_bpf2bpf_2:OK
#137/8 tailcalls/tailcall_bpf2bpf_3:OK
#137/9 tailcalls/tailcall_bpf2bpf_4:OK
#137/10 tailcalls/tailcall_bpf2bpf_5:OK
libbpf: prog 'classifier_0': missing BPF prog type, check ELF section name 'tc'
libbpf: failed to load program 'classifier_0'
libbpf: failed to load object 'tailcall_bpf2bpf6'
libbpf: failed to load BPF skeleton 'tailcall_bpf2bpf6': -22
test_tailcall_bpf2bpf_6:FAIL:open and load unexpected error: -22
#137/11 tailcalls/tailcall_bpf2bpf_6:FAIL
#137 tailcalls:FAIL
Summary: 0/10 PASSED, 0 SKIPPED, 2 FAILED
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 55 -------------------
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   | 42 --------------
 2 files changed, 97 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 28e30ad4a30e..2e3e525e8579 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -810,59 +810,6 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	bpf_object__close(obj);
 }
 
-#include "tailcall_bpf2bpf6.skel.h"
-
-/* Tail call counting works even when there is data on stack which is
- * not aligned to 8 bytes.
- */
-static void test_tailcall_bpf2bpf_6(void)
-{
-	struct tailcall_bpf2bpf6 *obj;
-	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = &pkt_v4,
-		.data_size_in = sizeof(pkt_v4),
-		.repeat = 1,
-	);
-
-	obj = tailcall_bpf2bpf6__open_and_load();
-	if (!ASSERT_OK_PTR(obj, "open and load"))
-		return;
-
-	main_fd = bpf_program__fd(obj->progs.entry);
-	if (!ASSERT_GE(main_fd, 0, "entry prog fd"))
-		goto out;
-
-	map_fd = bpf_map__fd(obj->maps.jmp_table);
-	if (!ASSERT_GE(map_fd, 0, "jmp_table map fd"))
-		goto out;
-
-	prog_fd = bpf_program__fd(obj->progs.classifier_0);
-	if (!ASSERT_GE(prog_fd, 0, "classifier_0 prog fd"))
-		goto out;
-
-	i = 0;
-	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
-	if (!ASSERT_OK(err, "jmp_table map update"))
-		goto out;
-
-	err = bpf_prog_test_run_opts(main_fd, &topts);
-	ASSERT_OK(err, "entry prog test run");
-	ASSERT_EQ(topts.retval, 0, "tailcall retval");
-
-	data_fd = bpf_map__fd(obj->maps.bss);
-	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
-		goto out;
-
-	i = 0;
-	err = bpf_map_lookup_elem(data_fd, &i, &val);
-	ASSERT_OK(err, "bss map lookup");
-	ASSERT_EQ(val, 1, "done flag is set");
-
-out:
-	tailcall_bpf2bpf6__destroy(obj);
-}
-
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -885,6 +832,4 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(false);
 	if (test__start_subtest("tailcall_bpf2bpf_5"))
 		test_tailcall_bpf2bpf_4(true);
-	if (test__start_subtest("tailcall_bpf2bpf_6"))
-		test_tailcall_bpf2bpf_6();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
deleted file mode 100644
index 41ce83da78e8..000000000000
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-#define __unused __attribute__((unused))
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(max_entries, 1);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
-} jmp_table SEC(".maps");
-
-int done = 0;
-
-SEC("tc")
-int classifier_0(struct __sk_buff *skb __unused)
-{
-	done = 1;
-	return 0;
-}
-
-static __noinline
-int subprog_tail(struct __sk_buff *skb)
-{
-	/* Don't propagate the constant to the caller */
-	volatile int ret = 1;
-
-	bpf_tail_call_static(skb, &jmp_table, 0);
-	return ret;
-}
-
-SEC("tc")
-int entry(struct __sk_buff *skb)
-{
-	/* Have data on stack which size is not a multiple of 8 */
-	volatile char arr[1] = {};
-
-	return subprog_tail(skb);
-}
-
-char __license[] SEC("license") = "GPL";
-- 
2.42.0


