Return-Path: <stable+bounces-204324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C97CEB549
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BD7301E938
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1974310631;
	Wed, 31 Dec 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rrhwc3gF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90026561D;
	Wed, 31 Dec 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161799; cv=none; b=uLcXmYaR8w2Q9HqC2XzYOqAQv9IiQI9FeXQ2EBoNBMLkkl+cRXkh+bc/y/6tNpbfufPPGM0nDXog2qEdPNKarXh1tNhYF6kn0zuMZSVah3k5pxDYu+47hDFMDCbQQBbzVnMNi9pOeDTICH1A6uwBxCzD2nJcwLNvqdP9S/T8thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161799; c=relaxed/simple;
	bh=w8YQQYAmqAO3aKMa5LZl+18WRudsUTGz5zj8OinF7hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7OL6S90LQPrvUM+Vc8P2dCFa5VcbAvptgu7M+mqv7mB81Ax5cB57XTYVw7JZ4qnppaN4EyIg6xXT3AMG6oBLD2YQVk+UaloRRRvfd8n50LRh+31PClFXRgByzWHk9RqmPQmKRNG/OaAktzjCj3+cMQOwUYH8rKupEpQxgKasJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rrhwc3gF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV1oM931662709;
	Wed, 31 Dec 2025 06:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=S6V2X
	SjS3u9fkY7zSgFeEATXBM+YWwU4T9wYCUUs3ks=; b=Rrhwc3gFQXnLD6BZtsgC2
	KPjvGhHWBRtI0Y8NRS20SzKgsKn762OUvqIzFnZOYYljkSxYQT+dBl/lb0yTYy42
	9RAFM56FUBilqk90ttLkpCtZk2icTTKHPL2C4TqI3d0DeqdQx4m+1jBogSMgXZcx
	5rw1XVIZ7YQRJqIY+/BURsYWOB5FJ/+MKjeY4wKomFt6szBIgZevUgn1pub9UBG4
	T93OL/m3reQ8KxKWXDv59bb2vNEBhb4QZBvO91cLixXHGLKTbUg+sYQKUoqnFK+v
	DnOWANgTFQGeyxS/3dXLqWGkeckq8tQpqql7diOt4iQAQniG6G08tXvbrFc/G/P+
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7gabe01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BV26Dph013574;
	Wed, 31 Dec 2025 06:16:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w8c7qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BV6GE8Y009609;
	Wed, 31 Dec 2025 06:16:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w8c7mt-2;
	Wed, 31 Dec 2025 06:16:17 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com, akpm@linux-foundation.org
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        graf@amazon.com, guoweikang.kernel@gmail.com,
        harshit.m.mogalapalli@oracle.com, henry.willard@oracle.com,
        hpa@zytor.com, jbohac@suse.cz, joel.granados@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, noodles@fb.com,
        paul.x.webb@oracle.com, rppt@kernel.org, sohil.mehta@intel.com,
        sourabhjain@linux.ibm.com, stable@vger.kernel.org, tglx@linutronix.de,
        x86@kernel.org, yifei.l.liu@oracle.com
Subject: [PATCH v3 1/3] ima: verify the previous kernel's IMA buffer lies in addressable RAM
Date: Tue, 30 Dec 2025 22:16:07 -0800
Message-ID: <20251231061609.907170-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
References: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512310052
X-Proofpoint-ORIG-GUID: k3AHxBCUQlqLreu_zodw7F152KXBxmF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1MiBTYWx0ZWRfXzODjqK2i7DBj
 w1o7KXyR2nInxIZi9kGbOCuOB2nF3DmNZeP6OdS8NNi8CKRojIbl9vxINj7YsERTWMzbjj8YKd8
 VW7nGIiyvXqI+3x8wg15WLSuMActUbLm5i1o4JvcM1gNbTzgqAgxEXSzGAnK1ogKJcJdq0j+qFx
 HBbrbs0hb/3NuMqiVtTA4wK8qfpBNgbw9gXxBaiaVkKKGa2Nk8XiiCIqA6rkE38c1s+NPrQ57Kw
 f9htbISavuy0I6z5Qn0dId5nnl29S9rel2R8DuP5FEkDOAEclGEczNRCjkIPX7gtzBpRaLsfdi1
 8gGl9kQjl9qXU1IFAzHaTEYIzrkX7WmKnu2av16BDO8gDV37JYSmoCzCa5O5GHkj4qguAujLk+F
 6MWCb6q+Wqy7EMMMXD5q6aSbQSArWonAjsmg4onolDqJRjuuDI9Fa8zV9DZKzWxNeXoUikmBUx9
 FPlQC0zwywoQqDDswMw==
X-Authority-Analysis: v=2.4 cv=T9eBjvKQ c=1 sm=1 tr=0 ts=6954bfb3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=jkZM71ibJ-iyurowFaMA:9
X-Proofpoint-GUID: k3AHxBCUQlqLreu_zodw7F152KXBxmF5

When the second-stage kernel is booted with a limiting command line
(e.g. "mem=<size>"), the IMA measurement buffer handed over from the
previous kernel may fall outside the addressable RAM of the new kernel.
Accessing such a buffer can fault during early restore.

Introduce a small generic helper, ima_validate_range(), which verifies
that a physical [start, end] range for the previous-kernel IMA buffer
lies within addressable memory:
	- On x86, use pfn_range_is_mapped().
	- On OF based architectures, use page_is_ram().

Cc: stable@vger.kernel.org
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: Update subject to exactly describe the patch [ Suggested by Mimi
Zohar]
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e29cb4e6a01..abf8923f8fc5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -69,6 +69,7 @@ static inline int ima_measure_critical_data(const char *event_label,
 #ifdef CONFIG_HAVE_IMA_KEXEC
 int __init ima_free_kexec_buffer(void);
 int __init ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_validate_range(phys_addr_t phys, size_t size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7362f68f2d8b..8b24e3312ea0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,6 +12,8 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/reboot.h>
 #include <asm/page.h>
 #include "ima.h"
@@ -296,3 +298,36 @@ void __init ima_load_kexec_buffer(void)
 		pr_debug("Error restoring the measurement list: %d\n", rc);
 	}
 }
+
+/*
+ * ima_validate_range - verify a physical buffer lies in addressable RAM
+ * @phys: physical start address of the buffer from previous kernel
+ * @size: size of the buffer
+ *
+ * On success return 0. On failure returns -EINVAL so callers can skip
+ * restoring.
+ */
+int ima_validate_range(phys_addr_t phys, size_t size)
+{
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t end_phys;
+
+	if (check_add_overflow(phys, (phys_addr_t)size - 1, &end_phys))
+		return -EINVAL;
+
+	start_pfn = PHYS_PFN(phys);
+	end_pfn = PHYS_PFN(end_phys);
+
+#ifdef CONFIG_X86
+	if (!pfn_range_is_mapped(start_pfn, end_pfn))
+#else
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn))
+#endif
+	{
+		pr_warn("IMA: previous kernel measurement buffer %pa (size 0x%zx) lies outside available memory\n",
+			&phys, size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.50.1


