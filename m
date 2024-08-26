Return-Path: <stable+bounces-70143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556C95EB88
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140812829A2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D81369BC;
	Mon, 26 Aug 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWWCWAFk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA2745F4;
	Mon, 26 Aug 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660040; cv=none; b=lk7DIUQYD2bokINJqUv+vNcY/UBv1rfGTrOmr2H8pkKPFHtYLeUQrOMb+XV54URyXrShJ7rNCgxe7RwCuAS0J2Qe54k8v/l0NvKA/lI2F4AxsF/XtJsUVtOjMvJGKdhwDmInrMJB0UU5yUByWyGPD264g5ZgTeqKPzJOdsJp2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660040; c=relaxed/simple;
	bh=8OYMuhmZ8qAZW5PPqtyvvVb7qhA3xMlLBoIX0Yp8NGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/LOQ5Hsa5Kmi6CeO42reEZ4C4AYCXff0GEm93z0BG3yeEGHxlZf4SD4OvGdqIgnGrdjWIWfQ3eppCPTVo9aWfD4KnrxJPl51AQBNLr3B7TdL00ONf/wBYeGk4SdMrzs+U4WpPWDpYEJhSKSL9NWY/WyGbuXdgwU7+upqT0p+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWWCWAFk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PELtoj009250;
	Mon, 26 Aug 2024 08:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=O1iQLz2pYTyt9Kii5Zr1p4XfYF
	hxs1hC8sEBcVkRC0Y=; b=hWWCWAFk1ItNm1CGWcRdWoGdB56hqm30/Yho19l/9s
	KjU1TYfYi0EBRjTgc1DRhuwbtznX1lKwR5RTJUjy5a45uA5pl+SStvzeds9dpgtc
	bCytALS8wuSxMxfvoThdZ2yZoCUwhDW53Dcjc1yMDoCruaUEwjBWhLyAIZIf30pq
	TUz3Ph7eSsTRikNlX7ZGN44tkdYw2KVHM1yjgomhO7OtX7n7l7hMngIpxAvNIU17
	KoG/eJUOIkewaxIXlmZRhfrI8TAkfMZ6f8vIl5ftpB7k0A0LPT6cinTxFb/XTL+I
	MoelrTfj7p/QanIDwMLdxNS6BaCN6e5i6UOO+kyCzGKw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417gr35s7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:13:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47Q8DaXX000646;
	Mon, 26 Aug 2024 08:13:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417gr35s7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:13:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q4rdV9027960;
	Mon, 26 Aug 2024 08:13:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubmw1ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 08:13:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47Q8DPFk54460918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 08:13:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75CAE2004D;
	Mon, 26 Aug 2024 08:13:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC0C520040;
	Mon, 26 Aug 2024 08:13:22 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.in.ibm.com (unknown [9.199.156.78])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Aug 2024 08:13:22 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>, stable@vger.kernel.org,
        Geetika Moolchandani <geetika@linux.ibm.com>,
        Vaishnavi Bhat <vaish123@in.ibm.com>,
        Jijo Varghese <vargjijo@in.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/qspinlock: Fix deadlock in MCS queue
Date: Mon, 26 Aug 2024 13:42:48 +0530
Message-ID: <20240826081251.744325-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qs9CwdLn9GG5joS3jClLeOfaG9fV77_K
X-Proofpoint-ORIG-GUID: rOefFmJFp5CCftxSjp0akaSOkCDmx2t-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_05,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=534 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260064

If an interrupt occurs in queued_spin_lock_slowpath() after we increment
qnodesp->count and before node->lock is initialized, another CPU might
see stale lock values in get_tail_qnode(). If the stale lock value happens
to match the lock on that CPU, then we write to the "next" pointer of
the wrong qnode. This causes a deadlock as the former CPU, once it becomes
the head of the MCS queue, will spin indefinitely until it's "next" pointer
is set by its successor in the queue. This results in lockups similar to
the following.

   watchdog: CPU 15 Hard LOCKUP
   ......
   NIP [c0000000000b78f4] queued_spin_lock_slowpath+0x1184/0x1490
   LR [c000000001037c5c] _raw_spin_lock+0x6c/0x90
   Call Trace:
    0xc000002cfffa3bf0 (unreliable)
    _raw_spin_lock+0x6c/0x90
    raw_spin_rq_lock_nested.part.135+0x4c/0xd0
    sched_ttwu_pending+0x60/0x1f0
    __flush_smp_call_function_queue+0x1dc/0x670
    smp_ipi_demux_relaxed+0xa4/0x100
    xive_muxed_ipi_action+0x20/0x40
    __handle_irq_event_percpu+0x80/0x240
    handle_irq_event_percpu+0x2c/0x80
    handle_percpu_irq+0x84/0xd0
    generic_handle_irq+0x54/0x80
    __do_irq+0xac/0x210
    __do_IRQ+0x74/0xd0
    0x0
    do_IRQ+0x8c/0x170
    hardware_interrupt_common_virt+0x29c/0x2a0
   --- interrupt: 500 at queued_spin_lock_slowpath+0x4b8/0x1490
   ......
   NIP [c0000000000b6c28] queued_spin_lock_slowpath+0x4b8/0x1490
   LR [c000000001037c5c] _raw_spin_lock+0x6c/0x90
   --- interrupt: 500
    0xc0000029c1a41d00 (unreliable)
    _raw_spin_lock+0x6c/0x90
    futex_wake+0x100/0x260
    do_futex+0x21c/0x2a0
    sys_futex+0x98/0x270
    system_call_exception+0x14c/0x2f0
    system_call_vectored_common+0x15c/0x2ec

The following code flow illustrates how the deadlock occurs:

        CPU0                                   CPU1
        ----                                   ----
  spin_lock_irqsave(A)                          |
  spin_unlock_irqrestore(A)                     |
    spin_lock(B)                                |
         |                                      |
         ▼                                      |
   id = qnodesp->count++;                       |
  (Note that nodes[0].lock == A)                |
         |                                      |
         ▼                                      |
      Interrupt                                 |
  (happens before "nodes[0].lock = B")          |
         |                                      |
         ▼                                      |
  spin_lock_irqsave(A)                          |
         |                                      |
         ▼                                      |
   id = qnodesp->count++                        |
   nodes[1].lock = A                            |
         |                                      |
         ▼                                      |
  Tail of MCS queue                             |
         |                             spin_lock_irqsave(A)
         ▼                                      |
  Head of MCS queue                             ▼
         |                             CPU0 is previous tail
         ▼                                      |
   Spin indefinitely                            ▼
  (until "nodes[1].next != NULL")      prev = get_tail_qnode(A, CPU0)
                                                |
                                                ▼
                                       prev == &qnodes[CPU0].nodes[0]
                                     (as qnodes[CPU0].nodes[0].lock == A)
                                                |
                                                ▼
                                       WRITE_ONCE(prev->next, node)
                                                |
                                                ▼
                                        Spin indefinitely
                                     (until nodes[0].locked == 1)

Thanks to Saket Kumar Bhaskar for help with recreating the issue

Fixes: 84990b169557 ("powerpc/qspinlock: add mcs queueing for contended waiters")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: Geetika Moolchandani <geetika@linux.ibm.com>
Reported-by: Vaishnavi Bhat <vaish123@in.ibm.com>
Reported-by: Jijo Varghese <vargjijo@in.ibm.com>
Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/lib/qspinlock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
index 5de4dd549f6e..59861c665cef 100644
--- a/arch/powerpc/lib/qspinlock.c
+++ b/arch/powerpc/lib/qspinlock.c
@@ -697,6 +697,12 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
 	}
 
 release:
+	/*
+	 * Clear the lock, as another CPU might see stale values if an
+	 * interrupt occurs after we increment qnodesp->count but before
+	 * node->lock is initialized
+	 */
+	node->lock = NULL;
 	qnodesp->count--; /* release the node */
 }
 
-- 
2.46.0


