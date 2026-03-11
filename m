Return-Path: <stable+bounces-224693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMkRAoVysWlVvAIAu9opvQ
	(envelope-from <stable+bounces-224693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:47:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F07264D08
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B90B302C937
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B813321C2;
	Wed, 11 Mar 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mzsfhPXh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FE33030F
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236665; cv=none; b=OGLVCktojMKfy0o7lFA4QdgKzeUbAciw+qLwMBKxadSuQIkiQYx7Uoqppmp9rSdFxKS626VzlnqSSZ6u/JeJXtWc/3xNceMi7Kt9UQ3KQVMr/FhRw4ZCnPdNEPUH1sWMADbkma1nDs6RLAJEX8cRaQu89FExemyWkzLYigFzQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236665; c=relaxed/simple;
	bh=t7P9BS2sJcY50Ln5tJu5I/GNSlQNIs4QZK/veht19VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8qsn4jEpk0cWwN4gGGWHajBGvHRLUaT7+ou/MY3ckagTO+bhgmgUhKB54ae0iVqhVQjHXvjounm1U5arViRca5olZZxAwaJ/IagMa8oZeBcYiVQX+huAUCrR6mc0YEUWL4pUXDAA0m2Aah9Vg7VmeITIuKjHxFIl99RTjmR+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mzsfhPXh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDCor61997845;
	Wed, 11 Mar 2026 13:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5k1WkWwJZfkjKD9Do2HFw1TYnOgPIRSt3Wavyyczg
	jw=; b=mzsfhPXhEvc4nwelrVH4U7BGp4dLGugt9eUu/imYDhVhctwImNUSLioAj
	uLSKcLhVXc0By3x0UNemgZDIYHLH61jcfNIgaapiDkCkanpVX/zvUsxWhjIqkDDz
	HcYOkvzBnTJyppe4tYFPwgNRcVlkGB2qR/mh6QvDdfUaJurtEjw3XnQ8k1lko7wK
	LiatXDmRRdn7H4YuewMaXT5OnpoYD1YNDCnay3F+fym4Zw7muFENYLccgvo2714O
	UjD6hX+1hjCTO3RulPQGIWCFD33y1xe/pTwt0W320beKIjo4Z1tBoRN9X0VvUt+0
	mZASAfqCvxL9zC7RactR91uTq/2cQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmg78e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:43:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BD1n1M024649;
	Wed, 11 Mar 2026 13:43:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk5fph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:43:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDhmEi56492426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:43:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8BA2004E;
	Wed, 11 Mar 2026 13:43:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88BF12004B;
	Wed, 11 Mar 2026 13:43:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.22.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 13:43:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: namcao@linutronix.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        maz@kernel.org, ritesh.list@gmail.com, gautam@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
Date: Wed, 11 Mar 2026 19:13:31 +0530
Message-ID: <20260311134336.326996-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Lcapkis-v769aIZLGt4_AYUvHMxk2dEr
X-Proofpoint-ORIG-GUID: NPOW6rCHcgISKzW5iGNE44AI8M38VY9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX1X3eayjuss4d
 lj7WXGJ+/etTW4mzOjVPrFw2XaYt4mdut3eptIpy63Bp5y/YbWuhbAHali6s1mjEI1PG5ECLPW7
 307uXX246STKD3y72/FIhximP6MwbUM7sQYzmZ5C5F8XKtYsLzgI3qS1EKfE2xYgQsfFPtZapbr
 d0+y9W9k5mBDj8NkWY36Cbh4jrKJFS1tmnCpgU4l/BknXqtIS0/YS+A5yCsHOafHdkBTenEygD0
 zVwxGm3UrOD8is5Nn0ao+PqRiuylxHy3x0vH5GTnDedDD2jfFGzVDuMasLC9lYXfpTFKytt9lRq
 pFHfubE548R5nzNFK/7r+a0g9k4Nm03+vfIfjT+dtcTb9q2j9UW3eP6K3XTpAwObgRjsQZ3CD/r
 xcKwv2eiuXf+6yv3noMq7hKilQNI6CAZ0qaOpasuj92gmu0azaeDILxwuYvTRXZYMLkFhmCZCFG
 UB0ffsVa0fCc45Uxo5g==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b17199 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YDLeHvHTvU_vrB_0PgUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114
X-Rspamd-Queue-Id: 98F07264D08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224693-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

The kmemleak reports the following memory leak:

Unreferenced object 0xc0000002a7fbc640 (size 64):
  comm "kworker/8:1", pid 540, jiffies 4294937872
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 09 04 00 04 00 00  ................
    00 00 a7 81 00 00 0a c0 00 00 08 04 00 04 00 00  ................
  backtrace (crc 177d48f6):
    __kmalloc_cache_noprof+0x520/0x730
    xive_irq_alloc_data.constprop.0+0x40/0xe0
    xive_irq_domain_alloc+0xd0/0x1b0
    irq_domain_alloc_irqs_parent+0x44/0x6c
    pseries_irq_domain_alloc+0x1cc/0x354
    irq_domain_alloc_irqs_parent+0x44/0x6c
    msi_domain_alloc+0xb0/0x220
    irq_domain_alloc_irqs_locked+0x138/0x4d0
    __irq_domain_alloc_irqs+0x8c/0xfc
    __msi_domain_alloc_irqs+0x214/0x4d8
    msi_domain_alloc_irqs_all_locked+0x70/0xf8
    pci_msi_setup_msi_irqs+0x60/0x78
    __pci_enable_msix_range+0x54c/0x98c
    pci_alloc_irq_vectors_affinity+0x16c/0x1d4
    nvme_pci_enable+0xac/0x9c0 [nvme]
    nvme_probe+0x340/0x764 [nvme]

This occurs when allocating MSI-X vectors for an NVMe device. During
allocation the XIVE code creates a struct xive_irq_data and stores it
in irq_data->chip_data.

When the MSI-X irqdomain is later freed, xive_irq_free_data() is
responsible for retrieving this structure and freeing it. However,
after commit cc0cc23babc9 ("powerpc/xive: Untangle xive from child
interrupt controller drivers"), xive_irq_free_data() retrieves the
chip_data using irq_get_chip_data(), which looks up the data through
the child domain.

This is incorrect because the XIVE-specific irq data is associated with
the XIVE (parent) domain. As a result the lookup fails and the allocated
struct xive_irq_data is never freed, leading to the kmemleak report
shown above.

Fix this by retrieving the irq_data from the correct domain using
irq_domain_get_irq_data() and then accessing the chip_data via
irq_data_get_irq_chip_data().

Cc: stable@vger.kernel.org
Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt controller drivers")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/powerpc/sysdev/xive/common.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e1a4f8a97393..6b1b7541ca31 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1038,13 +1038,19 @@ static struct xive_irq_data *xive_irq_alloc_data(unsigned int virq, irq_hw_numbe
 	return xd;
 }
 
-static void xive_irq_free_data(unsigned int virq)
+static void xive_irq_free_data(struct irq_domain *domain, unsigned int virq)
 {
-	struct xive_irq_data *xd = irq_get_chip_data(virq);
+	struct xive_irq_data *xd;
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+
+	if (!data)
+		return;
 
+	xd = irq_data_get_irq_chip_data(data);
 	if (!xd)
 		return;
-	irq_set_chip_data(virq, NULL);
+
+	irq_domain_reset_irq_data(data);
 	xive_cleanup_irq_data(xd);
 	kfree(xd);
 }
@@ -1305,7 +1311,7 @@ static int xive_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static void xive_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
 {
-	xive_irq_free_data(virq);
+	xive_irq_free_data(d, virq);
 }
 
 static int xive_irq_domain_xlate(struct irq_domain *h, struct device_node *ct,
@@ -1443,7 +1449,7 @@ static void xive_irq_domain_free(struct irq_domain *domain,
 	pr_debug("%s %d #%d\n", __func__, virq, nr_irqs);
 
 	for (i = 0; i < nr_irqs; i++)
-		xive_irq_free_data(virq + i);
+		xive_irq_free_data(domain, virq + i);
 }
 #endif
 
-- 
2.53.0


