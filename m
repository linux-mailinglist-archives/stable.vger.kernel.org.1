Return-Path: <stable+bounces-163658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53DB0D1CD
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A1717EA9C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C228AAE0;
	Tue, 22 Jul 2025 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lIfYDeHN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8128A725
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165607; cv=none; b=TGE9ZGEl5eT+FZCjJqSVQqGyFoF7F1Yp8lYfEbYURW70XDkYqQUFzjh9mtiuyoZxbDozftvhEpW4lO8kH7hoR3/17oOzzpbhj9lTApzx6CncznOGoijzdZrqUamrFhBiZblbJBF+OyhVtWoVWQjujs9XcOWYwgJKCRmqV+bJVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165607; c=relaxed/simple;
	bh=9lhME5dnh6vmW/aMbSwFDyr7Lbgwa1tS0FI+ZjBQfjY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtS2Lc92JuSm60NAtzea/0IgzWUvT2qbaIu/H2G0nXpaRTAjrocKUBqcyKQ/FDd856PLFalmTO2fM33HI9fXzaRGZzaL9N412rX9fiqaKK/UDHfOxRQqeNw9ii/jlYC0f9wp0OU9hj/2EABVKhwlH+oOw0vwDcS6wos9dom34M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lIfYDeHN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCfO021343
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=y9w4c
	MBmqVRnJJr7YKO7pmlv7BRaiSbXyISQ5Dq1Xwg=; b=lIfYDeHNW5oBTl58AyBlU
	Ycyfue8V9oU6HpI3fyPzEktHXAjRh3nD67KggYZx8ibzntbiEhft9V3NgLhCyXtR
	fWBPRW9DWA12DrlSJ0hw8LjqB/0/fBPxdqU7xk+K0SUFImXmM9LlUiJ0oLCqXUdg
	wKAMMI79EQ+C5PvHYL6hdVpnQJAxnJ1J/QUpOdOLM2e6XGjroXHLJaDQUhx+XUxO
	czMDCom9n3DT+IkuOmZk3Ji6kkLO6qhlfam6TyyUUcBQ/LjhZbPyTtHlUG6Yvone
	yHfZNfX6ojGI4u7rKJuY/On0QWS+7walb5VM/DGc90XOc69EYR7qowN/qmxo8gTX
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9mhgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6JePK010306
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:44 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4801t8xdkv-2
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:43 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/4] x86: Fix get_wchan() to support the ORC unwinder
Date: Tue, 22 Jul 2025 06:26:39 +0000
Message-ID: <20250722062642.309842-2-siddhi.katage@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722062642.309842-1-siddhi.katage@oracle.com>
References: <20250722062642.309842-1-siddhi.katage@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220051
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687f2f24 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8
 a=cm27Pg_UAAAA:8 a=yPCof4ZbAAAA:8 a=3m7Ib9IVhnQMIsV-0vYA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: n-ieYkVctDXOp7uuKm1Dffosr2fllNml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MSBTYWx0ZWRfXzZpmNOKnuhtB
 JpIxb21IIp4eljGs2tWxJFAzvhlEjr0QNYl7EBzb4DtIws+DMrrP5YoeWzdIc5hdxJk3cmegjNX
 YB0vfbAGw6XW36/OjqkzbwkVOB9pKxSEAZt58WvLps8ObykSE75BKzgn/91dVgjzox65TaZ7TdG
 OJT2R+JP6H05nvkA3xDx3kdeZvZv0N5dzOvvbx20TwGokb8kcUdlx1cekKIzqqlt+jaZNaiKtcg
 pFVeuYlB6p/JA6RgpPwPHpkezNbCLT8jSAUlItvIZSqWYEtIG0+FCOLgLds+QjxKmcCxONqh2a/
 sTAS9FyEUdMEqq0G4IR+E4qIjewiZ5U0eBunHl2UjmQiRytHpVvMLMkEYbxI4HDS7exNmWFBVHs
 682V0QaYLuMKnLPhnLhi7lX05Q0G/fkc7Di8jF89n1ocpzIGOmCtgWgAwSJTuyLpDT3p1aWM
X-Proofpoint-ORIG-GUID: n-ieYkVctDXOp7uuKm1Dffosr2fllNml

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit bc9bbb81730ea667c31c5b284f95ee312bab466f ]

Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by default
on x86, but the implementation of get_wchan() is still based on the frame
pointer unwinder, so the /proc/<pid>/wchan usually returned 0 regardless
of whether the task <pid> is running.

Reimplement get_wchan() by calling stack_trace_save_tsk(), which is
adapted to the ORC and frame pointer unwinders.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008111626.271115116@infradead.org
Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
---
 arch/x86/kernel/process.c | 51 +++------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5ce91d5dfab0..a4d437727345 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -971,58 +971,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax = start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top = topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom = start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top = start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -= 2 * sizeof(unsigned long);
-	bottom = start;
-
-	sp = READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret = ip;
-			goto out;
-		}
-		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
-
-out:
-	put_task_stack(p);
-	return ret;
+	stack_trace_save_tsk(p, &entry, 1, 0);
+	return entry;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-- 
2.47.1


