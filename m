Return-Path: <stable+bounces-194639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0058C5434B
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3A954EEAA0
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2334DB45;
	Wed, 12 Nov 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="po104E1y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BB1C695;
	Wed, 12 Nov 2025 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975858; cv=none; b=quK4zJxYdn4B75jfjbJziuI3kk9UnaPdytX823iVfNv+7py3NMf2MIlEoT9e821hz18vhjbqh4dfRz9hf+UyL3O+QRb4o1Kcy954Xb03FXfz+FJnKlWPTMEn5JNlPMqg4wsGZKUlqQlGfb2XfUx7ms38a82JKrlq0zot6GdMvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975858; c=relaxed/simple;
	bh=xZSbYKAA2DQzsWed2MllKNN+yX8FbxBrdxJ4Kx/WcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VEAA/P02ahBRmYs/wT7G7zj9ALaCg/rPA7WUZ4JAC+k/iZAiDGhu0ArjCg+Uzbyud+BzBStoERLk34hNb/uSHXyrWuzScayBlEb31OOFYMLtDSDELQoRlv4Hhmpo1KVMD9Z6TuOMUBXlFqo0yhOJq/+SYcRIhpNxlDF/KodmPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=po104E1y; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACJN5vR027401;
	Wed, 12 Nov 2025 19:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=HHsM76INAtnND+aW
	qeM/QwMuC+DNNp+1bFzQ2gTcQHc=; b=po104E1yTi5V1GLFuN6UrNR/46zqjX36
	4Qwaq3yB7Qb2HaR5VhxcLTbABU/EfiItxP6X/38vlEfCi9nOi4uoymcuIdkOH3Cq
	xp/xX+pPCvFxEA5AbmelprhHISmmv/f6TjOrJJo8p4v270Pi2ln0WMd+nJNq5UZr
	Ee5VPDQG61DUj/GFV73jdDt2WK1IRhTZWrdRiklmuHMbQL4ZLWBo/g92LWJ2FhqX
	iMsWjZGxepGS7qS+wcqgyDrAOCGZt952m5RSHgz3EvYE2YHZyt+KajT4ZGAO1wNr
	JMn+M2m2ZiMNQqsGQuKBtVkweI5ceVNRFDXXH4XRgcBSMkCchPheTA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqr4tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 19:30:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACHsh1R009925;
	Wed, 12 Nov 2025 19:30:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabnsyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 19:30:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACJU9Fg028216;
	Wed, 12 Nov 2025 19:30:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vabnsx1-1;
	Wed, 12 Nov 2025 19:30:09 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac <jbohac@suse.cz>, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Guo Weikang <guoweikang.kernel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <joel.granados@kernel.org>,
        Alexander Graf <graf@amazon.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jonathan McDowell <noodles@fb.com>,
        linux-kernel@vger.kernel.org
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        Paul Webb <paul.x.webb@oracle.com>
Subject: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima kexec buffer
Date: Wed, 12 Nov 2025 11:30:02 -0800
Message-ID: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120157
X-Proofpoint-GUID: f8-UTcdHB8uaU5GuMUNqxnrSbo3NmKHz
X-Proofpoint-ORIG-GUID: f8-UTcdHB8uaU5GuMUNqxnrSbo3NmKHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX8d6MvLeL3I/J
 0DTnqNzRfyKHwJ7YG41zeelfLgXKBgewZG4KvCkIgDsG3mhQmVTwd+FWHKiOe0EobkEnnuk8Bl9
 fpTCQ4gGsuN3LqiiVaU3Uju4oJtoxZx9EbBkSFymfDMU4q3vVP7eB4qaKhO9wVD+3EAOGTF5y0Z
 uU4KVKtup6P1+GkfMRv3AoRZE9oiFGFZssFH6dBE7flRDgoGDhSNg2jQ9INL9AA3ZPyf0e1+gBu
 vh2cTOz6tziYl/5t169hOvMcegJDhGOLnHvOt8j3g0+M3CXvrCKkJBM9HO0KO/opQbrjFylTRr4
 FmDekOTX3nN7G6lWZdLj9LMtfucarjTDdCwSFPpVemnmZgi/MTDI7Pe0sDINZN8K3ChHwjj/AQE
 FtnE5f8oW2oq0GWf8Dz39/aDxXvXfA==
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=6914e043 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ZoAv7Z0augqPJJ3EZH8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>", the physical range that contains the carried
over IMA measurement list may fall outside the truncated RAM leading to
a kernel panic.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

Other architectures already validate the range with page_is_ram(), as
done in commit: cbf9c4b9617b ("of: check previous kernel's
ima-kexec-buffer against memory bounds") do a similar check on x86.

Cc: stable@vger.kernel.org
Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Reported-by: Paul Webb <paul.x.webb@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Have tested the kexec for x86 kernel with IMA_KEXEC enabled and the
above patch works good. Paul initially reported this on 6.12 kernel but
I was able to reproduce this on 6.18, so I tried replicating how this
was fixed in drivers/of/kexec.c
---
 arch/x86/kernel/setup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..fcef197d180e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
+	unsigned long start_pfn, end_pfn;
+
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
+	/*
+	 * Calculate the PFNs for the buffer and ensure
+	 * they are with in addressable memory.
+	 */
+	start_pfn = PFN_DOWN(ima_kexec_buffer_phys);
+	end_pfn = PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size - 1);
+	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
+		pr_warn("IMA buffer at 0x%llx, size = 0x%zx beyond memory\n",
+			ima_kexec_buffer_phys, ima_kexec_buffer_size);
+		return -EINVAL;
+	}
+
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 
-- 
2.50.1


