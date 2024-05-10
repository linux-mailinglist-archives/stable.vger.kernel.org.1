Return-Path: <stable+bounces-43523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078968C1F70
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1190283504
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7715F330;
	Fri, 10 May 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iebstXhD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030D12AAE5
	for <stable@vger.kernel.org>; Fri, 10 May 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328499; cv=none; b=OrIfmhgNxAOAIo7c5nvreL1DHtOwdSr7O/MgKvWy0UosjrtpUB/ZidawRAFfTUzEycGH/N2isSWjRUhBG2HtB0uZgePMRpVfe9hA9FWGMruRO5WJwtA8MnE/GRhok3UES17c+8f/aW+AYrc3gc1rT5uJrhfpXSHM10T0xIsuiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328499; c=relaxed/simple;
	bh=eg/VPqJA7e2U3aszVYp1nFRt98coZ5ufHlodbmxg+Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDiFjLjwYZpfwpst9KC+IzRcQqfs+/aCn8swylvx8oSB0HAKvUuPaLTwJNf4JDf1grPU9wixhfcdJ3g0Pizb9EZ46DfZM2sVvR9uN1X3nnvsxuTZjBbOz3tPEvbaMYqEdMj56eoeObHxgtvLkXYhdFpCdbmculWTUEV7/2qgtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iebstXhD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A82NB1020425;
	Fri, 10 May 2024 08:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Yb/vjD8glsfq1SlBLic5YblLSj4cuO72sCftFNzR4Is=;
 b=iebstXhDp5oERp8z25g1LkwTcjwRRINFrQEc6P3gi74lT00gEpW2hZHCv0/g97WBtfmW
 6df5C3iCWGbEyvinq7YmZVGdJRce9/9zIVoWakov7LonW32AQboDjdoXYRBu4rIporm+
 A+KhcKkhn3Qs379fvnvaZ/M2yRIFKkYCgxHp9WpSADWHinEOS/f3tIQ8XfmZChFcyyQn
 lCe1233N1RkLixeX7AB/kybCMar3Zoh8jb7KebRmQqCXRwZOWxnDJxjrWM7xWIeVgmuh
 m7WnSrTEhVBC7VbamhIT8hlh0klYLxKJDckJIWdlOpZtp9+eLnPTrRi8E2Wb7RJ95pxx JQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1fqf00c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 08:08:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44A7YODI009470;
	Fri, 10 May 2024 08:08:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysfxr233-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 08:08:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44A880o751380730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 08:08:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F222004D;
	Fri, 10 May 2024 08:07:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B18262004E;
	Fri, 10 May 2024 08:07:58 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2024 08:07:58 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/85xx: fix compile error without CONFIG_CRASH_DUMP
Date: Fri, 10 May 2024 13:37:57 +0530
Message-ID: <20240510080757.560159-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: coLCGXngZv6SWSWuRM0Avfe4Vqkeb-Cr
X-Proofpoint-GUID: coLCGXngZv6SWSWuRM0Avfe4Vqkeb-Cr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100057

Since commit 5c4233cc0920 ("powerpc/kdump: Split KEXEC_CORE and
CRASH_DUMP dependency"), crashing_cpu is not available without
CONFIG_CRASH_DUMP. Fix compile error on 64-BIT 85xx owing to this
change.

Cc: stable@vger.kernel.org
Fixes: 5c4233cc0920 ("powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closes: https://lore.kernel.org/all/fa247ae4-5825-4dbe-a737-d93b7ab4d4b9@xenosoft.de/
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/platforms/85xx/smp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 40aa58206888..e52b848b64b7 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -398,6 +398,7 @@ static void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 	hard_irq_disable();
 	mpic_teardown_this_cpu(secondary);
 
+#ifdef CONFIG_CRASH_DUMP
 	if (cpu == crashing_cpu && cpu_thread_in_core(cpu) != 0) {
 		/*
 		 * We enter the crash kernel on whatever cpu crashed,
@@ -406,9 +407,11 @@ static void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 		 */
 		disable_threadbit = 1;
 		disable_cpu = cpu_first_thread_sibling(cpu);
-	} else if (sibling != crashing_cpu &&
-		   cpu_thread_in_core(cpu) == 0 &&
-		   cpu_thread_in_core(sibling) != 0) {
+	} else if (sibling == crashing_cpu) {
+		return;
+	}
+#endif
+	if (cpu_thread_in_core(cpu) == 0 && cpu_thread_in_core(sibling) != 0) {
 		disable_threadbit = 2;
 		disable_cpu = sibling;
 	}
-- 
2.45.0


