Return-Path: <stable+bounces-82628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C19994E2B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1130B25D6F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F81DED48;
	Tue,  8 Oct 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXfEDZ1h"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FA1DFD1;
	Tue,  8 Oct 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392895; cv=none; b=Tt/+Fr5VGISQSN8a0RBGAzv+uekzKLksWQjuGKSTtaCdtul+V/MFqcBDen6NLCZHFwLzjdzWWGZ5XaTkfzs8r4M0FcjIX2t21OWy9DBCSsrzZ9MdXTm/Uja2lPv2W7hlMIkGgQrNe6KJuagdr+R5nnP5eHcJ7oQjG8ZZgnYPs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392895; c=relaxed/simple;
	bh=1s8jDLz4xsPK7rdXBwFDX7m1XmwgNdlX1mlSZLpHbZ4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c9R+EQ7oQSkhrBC8GSP/ojLCdG/ObiwZ0GgcZ7kA+d+dLKU6jd67OHl6T9rrLamTBkgIAwhERjRMYPaygRr7zd7scZvJsts2jjiscHSDM1DirgV77ZwzpyW+0pb0RWA2PsHUWfk44qQR5EyhIhpMAwY0hKLD0A6TYv1wb48seOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXfEDZ1h; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498CtsVf006392;
	Tue, 8 Oct 2024 13:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=rjSoOMSa
	uMzXhjoJcHAzY8r8uKcpbwQWm8/vJhmG4qM=; b=kXfEDZ1hPJL8/YY0Mbce0Q0H
	kthEycWPzKjHz4CYwdYDMkBEfw6K97XR6smfnUAJxpbW4wfHsY1wZvDaeYXsEbYx
	Pf140liBmBcqoksnfdhbbrIfi9fUhkwQ/EV4V0EN8DRevF5p3xDhOm6bUig0mKHy
	tLzH8deTsDW9LdrjIPitX7gLyW+SofUJ+vuEUjQgFKWTiSEhGpID/S+lra7sop8f
	4MlRpZZlhILspBA1DqSDZHDnvrOol2/yboR0lpowWSaMKK87TXUjL+tu2grfCD8M
	IpmhnNHMS/JzorgCi3NUTjZZilCvYsRttZ1UWHoVk8BgkLSmzeEWI02gKTgK2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv5rt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:07:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498C6r8B001243;
	Tue, 8 Oct 2024 13:07:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw75ryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 13:07:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 498D720i035615;
	Tue, 8 Oct 2024 13:07:02 GMT
Received: from gkennedy-linux.us.oracle.com (gkennedy-linux.us.oracle.com [10.152.170.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uw75rwg-1;
	Tue, 08 Oct 2024 13:07:02 +0000
From: George Kennedy <george.kennedy@oracle.com>
To: ravi.bangoria@amd.com
Cc: george.kennedy@oracle.com, harshit.m.mogalapalli@oracle.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, dongli.zhang@oracle.com,
        stable@vger.kernel.org
Subject: [PATCH] [PATCH v3] perf/x86/amd: check event before enable to avoid GPF
Date: Tue,  8 Oct 2024 08:00:53 -0500
Message-Id: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_11,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=889 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080083
X-Proofpoint-GUID: Csx44xj9ZCE0QeYwfVVPYRjwsxjGHVxN
X-Proofpoint-ORIG-GUID: Csx44xj9ZCE0QeYwfVVPYRjwsxjGHVxN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On AMD machines cpuc->events[idx] can become NULL in a subtle race
condition with NMI->throttle->x86_pmu_stop().

Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
This appears to be an AMD only issue.

Syzkaller reported a GPF in amd_pmu_enable_all.

INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
    msecs
Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
    arch/x86/events/core.c:1430)
RSP: 0018:ffff888118009d60 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
x86_pmu_enable (arch/x86/events/core.c:1360)
event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
    kernel/events/core.c:2346)
__perf_remove_from_context (kernel/events/core.c:2435)
event_function (kernel/events/core.c:259)
remote_function (kernel/events/core.c:92 (discriminator 1)
    kernel/events/core.c:72 (discriminator 1))
__flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
    kernel/smp.c:135 kernel/smp.c:540)
__sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207
    ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
    arch/x86/kernel/smp.c:266 (discriminator 47))
 </IRQ>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 Suggested comment now with the code.

 arch/x86/events/amd/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..6615ace15f5d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -762,7 +762,12 @@ static void amd_pmu_enable_all(int added)
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
 
-		amd_pmu_enable_event(cpuc->events[idx]);
+		/*
+		 * FIXME: cpuc->events[idx] can become NULL in a subtle race
+		 * condition with NMI->throttle->x86_pmu_stop().
+		 */
+		if (cpuc->events[idx])
+			amd_pmu_enable_event(cpuc->events[idx]);
 	}
 }
 
-- 
2.39.3


