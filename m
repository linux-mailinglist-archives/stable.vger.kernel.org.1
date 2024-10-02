Return-Path: <stable+bounces-80564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54198DEDA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389D4B269EE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EA1D0792;
	Wed,  2 Oct 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/Oj5qaQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB81D096A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881987; cv=none; b=ehotMsGKUtotkS253TtT4PH5Lv2LSLhVFfvb1WE3LOhHGsT3NBYk7sooVqETAVEcylypSremkm1YpEC0qcM+VXZHXCJ6rCNogGvTf3rCnCnQbI9MuDIihBVPCNHLYdhpmJ+aTEBSsAjTPHXoAeSTertp9b8onbRV1Xr0egyxMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881987; c=relaxed/simple;
	bh=EESOGGdg37oswwsuhRL+x2SZR4TI55L3Nhu2C7Nbm44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAqqKGfLrOjn0ZQsHnBIexEr7V3WwtAcqIAkyjqkCIQY9R8yMieR/fUFWx1AURkbVOL4PYvydSWU4mKF+mKgNFCkt8cG19l9tHSox9qivp6kVPE614dNDON/IEisAB1GLjwnO+Th6wZIUt1zrwOjH67Kp09UIM7nROL3nGaXuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K/Oj5qaQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd956016927;
	Wed, 2 Oct 2024 15:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=+
	msH5oJUxqeZqcoda9cjcNipAuVr7tHgUnZHh/Mm9Fo=; b=K/Oj5qaQYVpm3v0w3
	ev/6EQbUMsoAvdhvUiWZ4N3MXBdX6y/aM4HiYnoGV5OLVf1btPQgT4tpERS8+FpT
	5XC74GuCLrkqp/nfiKvNrS7PVHlbrY16Qohc5sumpUJEdm/JKwxT4yDS5i3OiXpA
	E471j+n4gZKekPqyU/06yEIKf/Dt0p67MIdDbXoGxz2NYGew6OOgF9g4DhUgLi5a
	uErXZFWB9TUZ5XM9GtzVdKYOf2dWE8rUXa/JgEIz5++mz51L0KkwzecrQVSqhKJW
	FYp4SxtCjn4ylKNhZ9W2CYNz1b00keOl+bCDUZc/vHALqgx/vr+aUAFXfheBBriC
	Mg9UQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt1mxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:12:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EI7BG028440;
	Wed, 2 Oct 2024 15:12:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8897a3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:12:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492FCqrT028673;
	Wed, 2 Oct 2024 15:12:52 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x88979xb-1;
	Wed, 02 Oct 2024 15:12:51 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Chen Yu <yu.c.chen@intel.com>,
        Md Iqbal Hossain <md.iqbal.hossain@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 11/15] efi/unaccepted: touch soft lockup during memory accept
Date: Wed,  2 Oct 2024 17:12:32 +0200
Message-Id: <20241002151236.11787-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020110
X-Proofpoint-GUID: P9Zbi3t9Q6MveGvsgV0GJS0lQNwGfAwj
X-Proofpoint-ORIG-GUID: P9Zbi3t9Q6MveGvsgV0GJS0lQNwGfAwj

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 1c5a1627f48105cbab81d25ec2f72232bfaa8185 ]

Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by
parallel memory acceptance") has released the spinlock so other CPUs can
do memory acceptance in parallel and not triggers softlockup on other
CPUs.

However the softlock up was intermittent shown up if the memory of the
TD guest is large, and the timeout of softlockup is set to 1 second:

 RIP: 0010:_raw_spin_unlock_irqrestore
 Call Trace:
 ? __hrtimer_run_queues
 <IRQ>
 ? hrtimer_interrupt
 ? watchdog_timer_fn
 ? __sysvec_apic_timer_interrupt
 ? __pfx_watchdog_timer_fn
 ? sysvec_apic_timer_interrupt
 </IRQ>
 ? __hrtimer_run_queues
 <TASK>
 ? hrtimer_interrupt
 ? asm_sysvec_apic_timer_interrupt
 ? _raw_spin_unlock_irqrestore
 ? __sysvec_apic_timer_interrupt
 ? sysvec_apic_timer_interrupt
 accept_memory
 try_to_accept_memory
 do_huge_pmd_anonymous_page
 get_page_from_freelist
 __handle_mm_fault
 __alloc_pages
 __folio_alloc
 ? __tdx_hypercall
 handle_mm_fault
 vma_alloc_folio
 do_user_addr_fault
 do_huge_pmd_anonymous_page
 exc_page_fault
 ? __do_huge_pmd_anonymous_page
 asm_exc_page_fault
 __handle_mm_fault

When the local irq is enabled at the end of accept_memory(), the
softlockup detects that the watchdog on single CPU has not been fed for
a while. That is to say, even other CPUs will not be blocked by
spinlock, the current CPU might be stunk with local irq disabled for a
while, which hurts not only nmi watchdog but also softlockup.

Chao Gao pointed out that the memory accept could be time costly and
there was similar report before. Thus to avoid any softlocup detection
during this stage, give the softlockup a flag to skip the timeout check
at the end of accept_memory(), by invoking touch_softlockup_watchdog().

Reported-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
(cherry picked from commit 1c5a1627f48105cbab81d25ec2f72232bfaa8185)
[Harshit: CVE-2024-36936; Minor conflict resolution due to header file
 differences due to missing commit: 7cd34dd3c9bf ("efi/unaccepted: do not
 let /proc/vmcore try to access unaccepted memory") in 6.6.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/firmware/efi/unaccepted_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 79fb687bb90f9..6c3d84d9bcc16 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -3,6 +3,7 @@
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
+#include <linux/nmi.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap and accepting_list */
@@ -148,6 +149,9 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	}
 
 	list_del(&range.list);
+
+	touch_softlockup_watchdog();
+
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
 }
 
-- 
2.34.1


