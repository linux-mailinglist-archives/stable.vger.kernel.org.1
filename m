Return-Path: <stable+bounces-71453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC496382F
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 04:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D9285561
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7CF335C0;
	Thu, 29 Aug 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Be8a61Jg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC22A8C1;
	Thu, 29 Aug 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898563; cv=none; b=loVaVCOCeUnqcUquHfRkLN7N3k9bMY66c6q6r19BhAazYWUXv16khlRArYxpe1wybvBMdDhxmqSktJWyPtfFZUJNL1O0H/XNBSd/oroJxad2g35+bVjOkxa5USa8QZhDnE6Oyzo6twi3rDo2RXTDvuReZqvE2KBolrkXDkzyPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898563; c=relaxed/simple;
	bh=75qCGzHon8pdyGnLG3VYTwkvippqAwSLlyQfSLdbvsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V2g9Ej0IgphRoDuyUoU5xFKj6ci6SpWtBX5Mf/KLTwfi6CNz9ZBaFgxZHBCoxnX66OFG52OYopL3FrxTYbA7sxHE5itSNug5k0l+V9WP16L97uQBF1zwHEQ/psezeRk1EIcUwuW/TLL+8osVW0RBHYY+sP2wnmxzINX4s4lF5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Be8a61Jg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SNemrC011659;
	Thu, 29 Aug 2024 02:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=6n95hAvz6iiMynvYEV6Mx6SzgQ
	Ob+o8pNUa8Cuw/YgA=; b=Be8a61JgWka5xaxs6C7dNK2x3R7ElRlhnJwAxElUVJ
	u8Qe+O3nFELwli7A13Cu0n9yGcHeUG4Z1bM1n/qb+mU8Q3TYVrr/C1oiLC0URJUi
	rPLdHW+qO/aQ33lnaeBZrBvKj8tJcAfRLow7BM994VBeDadhssDpSQkhYlXZp/i8
	z/lAwUjriPpSTObD+E4cFQNP8Wz02CQZ8XW6XGdyuySWH27K52QC5J8jpZ2/vOm2
	sbnPw0E9NxwdysevHo3OJbOOrxzgR68T68fX6845J8ipL4ndcDqg4KNjddW4plkU
	gEKdbLPud8h4Lq8nrw/Vw/0No4w6dbfx3iNGtutJXcMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8nx0bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 02:29:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47T2T806009060;
	Thu, 29 Aug 2024 02:29:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8nx0bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 02:29:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47SMivcs024692;
	Thu, 29 Aug 2024 02:29:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3j97c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 02:29:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47T2Sx4x40108528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 02:29:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32F620049;
	Thu, 29 Aug 2024 02:28:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF3C20040;
	Thu, 29 Aug 2024 02:28:57 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com.com (unknown [9.43.117.101])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Aug 2024 02:28:56 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>, stable@vger.kernel.org,
        Geetika Moolchandani <geetika@linux.ibm.com>,
        Vaishnavi Bhat <vaish123@in.ibm.com>,
        Jijo Varghese <vargjijo@in.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/qspinlock: Fix deadlock in MCS queue
Date: Thu, 29 Aug 2024 07:58:27 +0530
Message-ID: <20240829022830.1164355-1-nysal@linux.ibm.com>
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
X-Proofpoint-GUID: PfGf8JzG5euzKAaQ2aSkjh1ZeiBxjRS8
X-Proofpoint-ORIG-GUID: kTE9yy9dl5V4mGTgDHJF4hxYC2Xm3XZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_01,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=982
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290014

If an interrupt occurs in queued_spin_lock_slowpath() after we increment
qnodesp->count and before node->lock is initialized, another CPU might
see stale lock values in get_tail_qnode(). If the stale lock value happens
to match the lock on that CPU, then we write to the "next" pointer of
the wrong qnode. This causes a deadlock as the former CPU, once it becomes
the head of the MCS queue, will spin indefinitely until it's "next" pointer
is set by its successor in the queue.

Running stress-ng on a 16 core (16EC/16VP) shared LPAR, results in
occasional lockups similar to the following:

   $ stress-ng --all 128 --vm-bytes 80% --aggressive \
               --maximize --oomable --verify  --syslog \
               --metrics  --times  --timeout 5m

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

The following code flow illustrates how the deadlock occurs.
For the sake of brevity, assume that both locks (A and B) are
contended and we call the queued_spin_lock_slowpath() function.

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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/qspinlock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
index 5de4dd549f6e..bcc7e4dff8c3 100644
--- a/arch/powerpc/lib/qspinlock.c
+++ b/arch/powerpc/lib/qspinlock.c
@@ -697,7 +697,15 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
 	}
 
 release:
-	qnodesp->count--; /* release the node */
+	/*
+	 * Clear the lock before releasing the node, as another CPU might see stale
+	 * values if an interrupt occurs after we increment qnodesp->count
+	 * but before node->lock is initialized. The barrier ensures that
+	 * there are no further stores to the node after it has been released.
+	 */
+	node->lock = NULL;
+	barrier();
+	qnodesp->count--;
 }
 
 void queued_spin_lock_slowpath(struct qspinlock *lock)
-- 
2.46.0


