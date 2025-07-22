Return-Path: <stable+bounces-163661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51062B0D1D0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650A57A5D69
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DB28C2D3;
	Tue, 22 Jul 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVVy2UY6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E428A725
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165609; cv=none; b=F8QQ07tRlcSmrfna0tslnQ0lET8FPBGaCZfGVs0/hsIdbpwIHcEPigwmZniqghc59yZwE5/LuB6v76wAPx4VyzfmRHDj1lkb0NsBEBea2TLeYU1hCV9bFa3ttxuBsbp3/zRL1BHpP069rHzgXuxmXFAMHpjA0e+BYnCZSuJGclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165609; c=relaxed/simple;
	bh=ai3jH0z0eFu5N985JB4rpB42RQexKBqCkHJ1uDXHi2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1NbO1/sBZ4kNMnzlFSOcMDlyrfyG02qeZ/GIV2bIApe+vwhkpFFCxxDBniBOPLWQgrCIyu031ZEHcq9tWp4OUcaCp/KvnXnyZ0YrGHv+DQN/fKjuxR1sE1PRrk5yYLDouLC7AAJdujmw2gph0SUMOvolCKuvVOrRvPxC1ZZlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NVVy2UY6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCwW021346
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xX4pYcrkt4TjW4u4HOXrP6qWT+oh5BIHgWzVFCeKPGQ=; b=
	NVVy2UY67I845rToRTM2irwMGWsF4JvU7c/Vj+VuHW5g5GIhcZ7I9f26pax7jvT4
	MNt8o9g32whLhD7v7UhnMWTrsr5++js2GR9OQbcZXwmAWrhcxXZygqm2DQjHX172
	zOXLu0KdTF9wYt727cQ0hyQD2xXjuRL2qI49Sb7qW1hBsPxNiNJgP/t/Q7hQ65Yw
	BaABOBCOFVzSWygDz04KztZheoz4kzSeMYKuz3Km6lqWtvWG3wzUnhP37OQiGrz5
	cIeVR/qU+H4IcIY7ZMhoQCoYNgszOjXSfhms3mkgWlUJ4axva3PLVKKvS+89/63O
	wsk9WD4C150zax9+9GlQ6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9mhgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6JePN010306
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:46 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4801t8xdkv-5
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:46 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 4/4] x86: Pin task-stack in __get_wchan()
Date: Tue, 22 Jul 2025 06:26:42 +0000
Message-ID: <20250722062642.309842-5-siddhi.katage@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722062642.309842-1-siddhi.katage@oracle.com>
References: <20250722062642.309842-1-siddhi.katage@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220051
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687f2f27 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=NZ1Cdi6YAAAA:8
 a=JfrnYn6hAAAA:8 a=AYdrOdEoAAAA:8 a=968KyxNXAAAA:8 a=cm27Pg_UAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=IjS3zf0i93RPPnvvhdAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=VTb59HSaHn79mzR5dlyk:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=OGUpGO79hC_v-Tb66Uh5:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: y-ZcssiYZEuBQJMGrbtivZxLaXD5iPOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MSBTYWx0ZWRfX+dN3mrPUM1l4
 m2mvTkWQigirm2xBAUuChZqRRgptytmFbIOdLYbL0oaufdyOndVbH5FWWqQLLRg/Wl40ZiytMOM
 PwsN7oSmNOCOlV1UwUp9rJWjVzjPuRBvO4x2UnHdMTL8qVjX6PPFvw4ihsKTrPDjxaGjEIrO7Md
 pwQjzyO19ynJQPRMceszEsF1Y4Ts0eJ05BHyosmxl364vOP7EUAEVCHhzI5wvQa20QJShTi1525
 0BCYfV56EoLWIaGh/5dkhMmTtEh9/JFLYWapN4jie8fFHnKe8IgM6xRMn/CtHrLv0FchVou1FPZ
 DBIKZF4wRNPloUZMEAmyWvpOFX2ybwx5J8ZJ6JKr88rQ+hjAN8mDly2YLMdfBLp2kklbks8WioF
 hx4kXXEwZL3GeQMOUnngI4YJF8DjymOC2nFO9sJGBt3QLq3k+51E3qrntXirGy5yQmkItIB7
X-Proofpoint-ORIG-GUID: y-ZcssiYZEuBQJMGrbtivZxLaXD5iPOE

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 0dc636b3b757a6b747a156de613275f9d74a4a66 ]

When commit 5d1ceb3969b6 ("x86: Fix __get_wchan() for !STACKTRACE")
moved from stacktrace to native unwind_*() usage, the
try_get_task_stack() got lost, leading to use-after-free issues for
dying tasks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 5d1ceb3969b6 ("x86: Fix __get_wchan() for !STACKTRACE")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215031
Link: https://lore.kernel.org/stable/YZV02RCRVHIa144u@fedora64.linuxtx.org/
Reported-by: Justin Forbes <jmforbes@linuxtx.org>
Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
---
 arch/x86/kernel/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 16d4c5a79d68..2a4218deddd2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -975,6 +975,9 @@ unsigned long __get_wchan(struct task_struct *p)
 	struct unwind_state state;
 	unsigned long addr = 0;
 
+	if (!try_get_task_stack(p))
+		return 0;
+
 	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
 	     unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
@@ -985,6 +988,8 @@ unsigned long __get_wchan(struct task_struct *p)
 		break;
 	}
 
+	put_task_stack(p);
+
 	return addr;
 }
 
-- 
2.47.1


