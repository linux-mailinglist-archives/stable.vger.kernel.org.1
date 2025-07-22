Return-Path: <stable+bounces-163659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C9B0D1CF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2D3A5662
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2F28B514;
	Tue, 22 Jul 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dYwoulqZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B428B400
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165609; cv=none; b=ZWXzH7AEaGR0GbCk4rnIQ4LBuVpCkNrkTPkVss1nsgNn3xMwxcA2jkCOB6VBwjUvCmAm4Pnc6qp0YoV/8ifT0y8EoXEAUw9a0d81PeWbqpKVzyqOO4yfjuTNfksM1yJz5aWMMpMqp6qP/6bO6VDwSiczui6zaVitE0Q4B+44HV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165609; c=relaxed/simple;
	bh=pYm75PwOekPefeyfkvr6IOByh7PK4mFOxGAr29howNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq3MAoimdbaVsWOkQSmt99IgbDoRQUmaYXOohgO4aDM3Di3sL4pApK5V45USHXZFIAlnWaj2SCJp8VB5Leq/bKNTVgarsLdQclaGH3pjeVpH1yw/+EtDS9W1Da7ai4InQf/zan9ShRzucjZmnrLjZAFJ4XB9zWKy/qvNNKR5KNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dYwoulqZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TD24009205
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=c5kTy
	wbyitagFru4u1LCmA5jMwGD/3AgUM3tICtFXUc=; b=dYwoulqZJpgh/W3KNBV0Z
	L+UY6Sw8bIGjLJBvUXEFQC4hPs+oTxhfC1M/FF+UYBQKUr2SOE5b6z1XLaemswEC
	utQD+w0cmwF8oRr0H3r6Jgivp7+cDykcHBi0JPSlYYVxe9kpwc6I/7Yv3qYDpM8c
	d0BfOAa1UR2aMF1Jey1D8vSSoUYO2d5ohnsDl9oFyzP8y3ozNi+5mgz9x9Ps0BSO
	XpwZx0Pb/C/b6cNs9zxI/0NnXmVHwhBeCxXjWFwH0FeeTV5okqvFDjarAQG6bvTt
	rJyr7jbRuC/xWw+/HrCEIeYQHYnstM5N7azrYINITMhXb2EcHB5PS4hH2YSSDQ1A
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx4h6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6JePM010306
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:45 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4801t8xdkv-4
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:26:45 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 3/4] x86: Fix __get_wchan() for !STACKTRACE
Date: Tue, 22 Jul 2025 06:26:41 +0000
Message-ID: <20250722062642.309842-4-siddhi.katage@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MSBTYWx0ZWRfX1rza7l8gEa71
 8aDnqIL/JIRvHdW6bdxRSdKA08bElI1/mWH9Q3lcZIn7p2oi8AwK3I9BXYzCftXz80AJy3DClza
 JZAWeHXvN1NOUVuGjode2/9/1wGiut+Zkg4dxt9hejkNhbTyCtpTGVr17W775wGbvWWQVODh1FO
 uSWu7ijbSSMuYxH3yBfSNrxfVQxzfoUTWoHp8xCqUS3zvPgLf0pdVbrdPamOHFSFgDcNabTJVKX
 q35SbxPpgv/qxewE8oIlSWnQRrq/+EtEsAowcO7HqgMZ4gqpKVreY4gfpMEsvDcS/Ou77636+9l
 m5JbwFarJgrgzQ7qocO15sAquy8HO5H5lQBZrf4MKISsPyjYcimiEWo99ccMGtO3AEOj+K1OJP1
 Vy2QzxRZVncZBoT/HP/WbiRHR72MF+K02QMZE13r6qJhMfZRWtUWCaVx/jamdhvMFKyRnmWp
X-Proofpoint-GUID: opGqZaRaxPOUrfJ1W8gHbLsBFd0nqIoo
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687f2f26 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=rOUgymgbAAAA:8
 a=cm27Pg_UAAAA:8 a=yPCof4ZbAAAA:8 a=cxbGIsMZB6fKstJmGegA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-ORIG-GUID: opGqZaRaxPOUrfJ1W8gHbLsBFd0nqIoo

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4 ]

Use asm/unwind.h to implement wchan, since we cannot always rely on
STACKTRACE=y.

Fixes: bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20211022152104.137058575@infradead.org
Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
---
 arch/x86/kernel/process.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6d707226f4a3..16d4c5a79d68 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/unwind.h>
 
 #include "process.h"
 
@@ -971,10 +972,20 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long __get_wchan(struct task_struct *p)
 {
-	unsigned long entry = 0;
+	struct unwind_state state;
+	unsigned long addr = 0;
 
-	stack_trace_save_tsk(p, &entry, 1, 0);
-	return entry;
+	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		if (in_sched_functions(addr))
+			continue;
+		break;
+	}
+
+	return addr;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-- 
2.47.1


