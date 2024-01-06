Return-Path: <stable+bounces-9954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE218261BD
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 22:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E9F1C20EAF
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4CF9D1;
	Sat,  6 Jan 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvjBlBaI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C3F9CA
	for <stable@vger.kernel.org>; Sat,  6 Jan 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 406ITGW5026604;
	Sat, 6 Jan 2024 21:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=A0rEAIPr3s6/9zrc3C5q33OW/XS0xdd7HuGRbWDthYw=;
 b=ZvjBlBaIlNb5GiSayV8bfOnYfpt+2n3JN8SP92Hg8JVj4L8JOziHSmPqm6yfHnyqG9Y/
 RNILUCunniRJjclZgWQbvJweHhzAXOMBh73q2wY669UAEVd28I9QgDWpQC5FpTiipk6j
 E9Yj3Rw8a8VoGMjpWUq4a531DScsWxFHR8nPZDYB0mbuwxazHpRknju9SdIM9bTJgc5Z
 RInzfeISiwRLpJovRgI9Cmd+kzzfxlPcmWTQU9/+ghez2fSyloVYAs1ZQ1di1yo0nXzN
 6BGy+0lfFAjtgtnvEIqDDVuvC/w2vf4dByVFxYHs9tWIKQhVnXbCVimb9gVJoPrIHm62 UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf8smdut5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 21:41:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 406LegA8032439;
	Sat, 6 Jan 2024 21:41:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf8smdus3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 21:41:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 406IOJvl005097;
	Sat, 6 Jan 2024 21:41:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vf1ueuds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 21:41:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 406LfBiD44302700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jan 2024 21:41:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4E62004B;
	Sat,  6 Jan 2024 21:41:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904A62004F;
	Sat,  6 Jan 2024 21:41:09 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.171.48.80])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jan 2024 21:41:09 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: [PATCH 5.10.y] powerpc: update ppc_save_regs to save current r1 in pt_regs
Date: Sun,  7 Jan 2024 03:11:07 +0530
Message-ID: <20240106214107.552029-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EXk4jqfmdy5AU-32RjSY3_bDertxzeIb
X-Proofpoint-ORIG-GUID: sYa8-7fjSLKcGZderG32ucW3iU5LD2fm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-06_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=583 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060141

commit b684c09f09e7a6af3794d4233ef785819e72db79 upstream.

ppc_save_regs() skips one stack frame while saving the CPU register states.
Instead of saving current R1, it pulls the previous stack frame pointer.

When vmcores caused by direct panic call (such as `echo c >
/proc/sysrq-trigger`), are debugged with gdb, gdb fails to show the
backtrace correctly. On further analysis, it was found that it was because
of mismatch between r1 and NIP.

GDB uses NIP to get current function symbol and uses corresponding debug
info of that function to unwind previous frames, but due to the
mismatching r1 and NIP, the unwinding does not work, and it fails to
unwind to the 2nd frame and hence does not show the backtrace.

GDB backtrace with vmcore of kernel without this patch:

---------
(gdb) bt
 #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=<optimized out>,
    newregs=0xc000000004f8f8d8) at ./arch/powerpc/include/asm/kexec.h:69
 #1  __crash_kexec (regs=<optimized out>) at kernel/kexec_core.c:974
 #2  0x0000000000000063 in ?? ()
 #3  0xc000000003579320 in ?? ()
---------

Further analysis revealed that the mismatch occurred because
"ppc_save_regs" was saving the previous stack's SP instead of the current
r1. This patch fixes this by storing current r1 in the saved pt_regs.

GDB backtrace with vmcore of patched kernel:

--------
(gdb) bt
 #0  0xc0000000002a53e8 in crash_setup_regs (oldregs=0x0, newregs=0xc00000000670b8d8)
    at ./arch/powerpc/include/asm/kexec.h:69
 #1  __crash_kexec (regs=regs@entry=0x0) at kernel/kexec_core.c:974
 #2  0xc000000000168918 in panic (fmt=fmt@entry=0xc000000001654a60 "sysrq triggered crash\n")
    at kernel/panic.c:358
 #3  0xc000000000b735f8 in sysrq_handle_crash (key=<optimized out>) at drivers/tty/sysrq.c:155
 #4  0xc000000000b742cc in __handle_sysrq (key=key@entry=99, check_mask=check_mask@entry=false)
    at drivers/tty/sysrq.c:602
 #5  0xc000000000b7506c in write_sysrq_trigger (file=<optimized out>, buf=<optimized out>,
    count=2, ppos=<optimized out>) at drivers/tty/sysrq.c:1163
 #6  0xc00000000069a7bc in pde_write (ppos=<optimized out>, count=<optimized out>,
    buf=<optimized out>, file=<optimized out>, pde=0xc00000000362cb40) at fs/proc/inode.c:340
 #7  proc_reg_write (file=<optimized out>, buf=<optimized out>, count=<optimized out>,
    ppos=<optimized out>) at fs/proc/inode.c:352
 #8  0xc0000000005b3bbc in vfs_write (file=file@entry=0xc000000006aa6b00,
    buf=buf@entry=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>,
    count=count@entry=2, pos=pos@entry=0xc00000000670bda0) at fs/read_write.c:582
 #9  0xc0000000005b4264 in ksys_write (fd=<optimized out>,
    buf=0x61f498b4f60 <error: Cannot access memory at address 0x61f498b4f60>, count=2)
    at fs/read_write.c:637
 #10 0xc00000000002ea2c in system_call_exception (regs=0xc00000000670be80, r0=<optimized out>)
    at arch/powerpc/kernel/syscall.c:171
 #11 0xc00000000000c270 in system_call_vectored_common ()
    at arch/powerpc/kernel/interrupt_64.S:192
--------

Nick adds:
  So this now saves regs as though it was an interrupt taken in the
  caller, at the instruction after the call to ppc_save_regs, whereas
  previously the NIP was there, but R1 came from the caller's caller and
  that mismatch is what causes gdb's dwarf unwinder to go haywire.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Fixes: d16a58f8854b1 ("powerpc: Improve ppc_save_regs()")
Reivewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230615091047.90433-1-adityag@linux.ibm.com

Cc: stable@vger.kernel.org
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---

This is backport for the upstream commit b684c09f09e7a6af3794d4233ef785819e72db79.
This solves a register mismatch issue while saving registers after a kernel crash.
With this fixed, gdb can also unwind backtraces correctly for vmcores collected
from such kernel crashes.

Please let me know if this is not correct format for a backport patch. Thanks.

---
---
 arch/powerpc/kernel/ppc_save_regs.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
index 2d4d21bb46a9..5d284f78b0b4 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -58,10 +58,10 @@ _GLOBAL(ppc_save_regs)
 	lbz	r0,PACAIRQSOFTMASK(r13)
 	PPC_STL	r0,SOFTE-STACK_FRAME_OVERHEAD(r3)
 #endif
-	/* go up one stack frame for SP */
-	PPC_LL	r4,0(r1)
-	PPC_STL	r4,1*SZL(r3)
+	/* store current SP */
+	PPC_STL r1,1*SZL(r3)
 	/* get caller's LR */
+	PPC_LL	r4,0(r1)
 	PPC_LL	r0,LRSAVE(r4)
 	PPC_STL	r0,_LINK-STACK_FRAME_OVERHEAD(r3)
 	mflr	r0
-- 
2.43.0


