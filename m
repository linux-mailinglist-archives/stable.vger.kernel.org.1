Return-Path: <stable+bounces-114980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B02A31B0E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9941883321
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAC200B0;
	Wed, 12 Feb 2025 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bCrai3YL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF3C13B;
	Wed, 12 Feb 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322712; cv=none; b=pPWfH3wMpkuyjHeKT/VeJHeKQmYfvy9UDXg16nXPTQVX0709fHlWc5y5mCUhHNP+C0LFVDBby8cDiDxaZIsSGrVHZ+SPBwhHpP9kqy8GcSBElG1BHDgtxORo8nazR25GBt7FkRKH5g2JH6ieOwvct3FbBIh7DYpP7SfUcenI/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322712; c=relaxed/simple;
	bh=YGmRhOURGRVPkWkj6MJ4jt0BmXl+zy1YxR5sX/ocaLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WKX8RLPcXK7teYR4Rp958jftCdEwI5cop+cGkaPvoVZ/ALOga4eGd892sgykagebo6zUcNCYoWPp+wKBvJhrTLqI7P64DIvmrpcfrkq3y0CRu/AnR4Z0B4PMDD08DuQvcsxEEN4UcRfTmE+upRE8z+MyB0p42/2kwHr9/ZbuhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bCrai3YL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C1BZ7H030073;
	Wed, 12 Feb 2025 01:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=FVIvZlH4c2DlGQaw
	E+lbKiF27hJHQ1BybY3otaVoUDg=; b=bCrai3YLEQm0+3tgqL4MO5qFJRJWoSvm
	odHy2nHAsilCDO2BVw1mfAWESo1/BU4Co4swa481SYDWWAC9TN8JN4X95NHboTtu
	2zTlIKqbFNmN10RgoZv15ZMuleDvMD1XmMuHWX18ruDtSOYBQB7vEV5aW9fxe7AC
	vyYbttnr0SpwsC9eiMbDqZVDFsu3BjU0V3QhhwiWof4mE9MggDpm2j7oIFcuMHtY
	AQWqSG6TmhjmWB2Uo2BNK+GbFmZd31Hi40yHZ66ua041hi/+sTbk6NfIvzW2StGn
	bVyOIKpqnKuBGn9M+lAg4P2CM8S41pV9KJWQwu1JGdhI3XrjbOR3Bg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2ee68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 01:11:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BN8AcW009792;
	Wed, 12 Feb 2025 01:11:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqfvs00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 01:11:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51C1BcOH007841;
	Wed, 12 Feb 2025 01:11:38 GMT
Received: from clb-2-bm-ad2.osdevelopmeniad.oraclevcn.com (clb-2-bm-ad2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44nwqfvryr-1;
	Wed, 12 Feb 2025 01:11:38 +0000
From: Libo Chen <libo.chen@oracle.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, tj@kernel.org,
        void@manifault.com, ihor.solodrai@pm.me,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH 6.12] Revert "selftests/sched_ext: fix build after renames in sched_ext API"
Date: Tue, 11 Feb 2025 17:11:37 -0800
Message-ID: <20250212011137.2354596-1-libo.chen@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120007
X-Proofpoint-GUID: ZyCFZBnGRvrMYsx_X9G2Dw0Esu1S6WQd
X-Proofpoint-ORIG-GUID: ZyCFZBnGRvrMYsx_X9G2Dw0Esu1S6WQd

This reverts commit fc20e87419e59d86f3bbcee2d4506bcd01c6450a.

Commit "selftests/sched_ext: fix build after renames in sched_ext API”
was pulled into 6.12.y without the sched_ext API renames it depends on.
The prereqs can be found in
https://lore.kernel.org/lkml/20241110200308.103681-1-tj@kernel.org/
As a result, sched_ext selftests fail to compile.

Cc: stable@vger.kernel.org
Fixes: fc20e87419e59 ("selftests/sched_ext: fix build after renames in sched_ext API")
Signed-off-by: Libo Chen <libo.chen@oracle.com>

Conflicts:
	tools/testing/selftests/sched_ext/maximal.bpf.c
due to commit 21900bfd332ae ("scx: Fix maximal BPF selftest prog")
---
 .../testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c | 2 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        | 4 ++--
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c      | 2 +-
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c        | 2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c              | 4 ++--
 tools/testing/selftests/sched_ext/maximal.bpf.c           | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c    | 2 +-
 .../selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   | 2 +-
 .../testing/selftests/sched_ext/select_cpu_dispatch.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c  | 8 ++++----
 12 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index 6f4c3f5a1c5d9..37d9bf6fb7458 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
 		 * If we dispatch to a bogus DSQ that will fall back to the
 		 * builtin global DSQ, we fail gracefully.
 		 */
-		scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+		scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
 				       p->scx.dsq_vtime, 0);
 		return cpu;
 	}
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index e4a55027778fd..dffc97d9cdf14 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -17,8 +17,8 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
 
 	if (cpu >= 0) {
 		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
-		scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
-					 p->scx.dsq_vtime, 0);
+		scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+				       p->scx.dsq_vtime, 0);
 		return cpu;
 	}
 
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index fbda6bf546712..c9a2da0575a0f 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -48,7 +48,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	else
 		target = scx_bpf_task_cpu(p);
 
-	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 	bpf_task_release(p);
 }
 
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index a7cf868d5e311..1efb50d61040a 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -31,7 +31,7 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 	/* Can only call from ops.select_cpu() */
 	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
 
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index 4bc36182d3ffc..d75d4faf07f6d 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -33,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
 	if (exit_point == EXIT_ENQUEUE)
 		EXIT_CLEANLY();
 
-	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
@@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
 	if (exit_point == EXIT_DISPATCH)
 		EXIT_CLEANLY();
 
-	scx_bpf_dsq_move_to_local(DSQ_ID);
+	scx_bpf_consume(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 430f5e13bf554..361797e10ed5d 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -22,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(DSQ_ID);
+	scx_bpf_consume(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
index 13d0f5be788d1..f171ac4709706 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
 	}
 	scx_bpf_put_idle_cpumask(idle_mask);
 
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
 
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 815f1d5d61ac4..9efdbb7da9288 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -67,7 +67,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
 		saw_local = true;
 	}
 
-	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
 }
 
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
index 4bb99699e9209..59bfc4f36167a 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -29,7 +29,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 
 dispatch:
-	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
 	return cpu;
 }
 
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
index 2a75de11b2cfd..3bbd5fcdfb18e 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -18,7 +18,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching to a random DSQ should fail. */
-	scx_bpf_dsq_insert(p, 0xcafef00d, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
index 99d075695c974..0fda57fe0ecfa 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -18,8 +18,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu, struct task_struct *p
 		   s32 prev_cpu, u64 wake_flags)
 {
 	/* Dispatching twice in a row is disallowed. */
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
 
 	return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index bfcb96cd4954b..e6c67bcf5e6e3 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -2,8 +2,8 @@
 /*
  * A scheduler that validates that enqueue flags are properly stored and
  * applied at dispatch time when a task is directly dispatched from
- * ops.select_cpu(). We validate this by using scx_bpf_dsq_insert_vtime(),
- * and making the test a very basic vtime scheduler.
+ * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), and
+ * making the test a very basic vtime scheduler.
  *
  * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2024 David Vernet <dvernet@meta.com>
@@ -47,13 +47,13 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
 	cpu = prev_cpu;
 	scx_bpf_test_and_clear_cpu_idle(cpu);
 ddsp:
-	scx_bpf_dsq_insert_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
+	scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
 	return cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
 {
-	if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
+	if (scx_bpf_consume(VTIME_DSQ))
 		consumed = true;
 }
 
-- 
2.43.5


