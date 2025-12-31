Return-Path: <stable+bounces-204325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899BCEB543
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4296E300C758
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216931065A;
	Wed, 31 Dec 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bPVqz0D9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B12D3228;
	Wed, 31 Dec 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161799; cv=none; b=Q9DQYPeN/rBMk6qJ+0Zh9W+Y9ukDyZ/JBGmez0ju4t7WTBkM+UZ0Tq34sc1HGy9MB9p9jhV5/etsZz9Bg6nq6yTzUV4qFGSObFTJTse5Prkz79Xxa+tNFy3Hxyx+KgRzT59vNdj9SmzWREHh+Jc+0LPQy294j340nv6+dxiPJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161799; c=relaxed/simple;
	bh=2Jt9GsjsSGPC0WcZcDrsd7TH7UQiaJBHb8A2yfsQ+eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md2CZc5za3SiLYK8dSw1gmxteez4kKyB1LgEg6CMwHKBt8+wiB3p2XliPmey98XFouH/KXNQShPxkXHdejTH8foF8Od9DnSAM80SUQwg4Ap3OjgB79V6FJG+J8AV2RNHADsUabZeG+xpWMCydy+oeX5+w7gly9/fQgP2kb8k6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bPVqz0D9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV0HOAp1075540;
	Wed, 31 Dec 2025 06:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=it3f+hcoxO8E8SSBho9WFDyAJ6zTtQDOoPTTP8A0hcE=; b=
	bPVqz0D9vl5R8PFfLm8+fG45iem2Uyj1nDIXLxXqY044nMCTifhwZzNL8opgUVfi
	y6DdLbJVHzNCWoUvxJh9oO5TLKatgU9kmTB0emtxvrswjwQ3yOQHWFNj/qPzRdUk
	MyvjK6BMzOZoNNEQvt0V60LGcjpzg69v4fn9GFPdA2VFtrMCTk7m0w93PiU3TvU7
	NATdqbfp8Wdkr/j0N4UI9b4zjkFYaGyzt7YlvE9SqyIGoFvFdhvTKYN4LbiuqUt2
	fdAcOLbCNEsE121Niu6YGUfUCkrFxgKGh7C0FrLvfolul59APYxJRI1wbnGhCNzh
	3Xft+22gETgM2fTOWDu54A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba5va3cn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BV2tW97014684;
	Wed, 31 Dec 2025 06:16:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w8c7tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BV6GE8c009609;
	Wed, 31 Dec 2025 06:16:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w8c7mt-4;
	Wed, 31 Dec 2025 06:16:21 +0000
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
Subject: [PATCH v3 3/3] x86/kexec: Add a sanity check on previous kernel's ima kexec buffer
Date: Tue, 30 Dec 2025 22:16:09 -0800
Message-ID: <20251231061609.907170-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
References: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-12-31_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512310052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1MiBTYWx0ZWRfXwSmACOuqGClY
 59+IeJ26iBmw7YWE05wx1Vy2eh2T6l50b/u/yEDHAlSdekoI4PHoE2FMqV208pwoLr/6mjCjrqF
 0srpLOU+bOk4Fs8mfPp/Iu1i0I+WoSOv0uWWfQqnkuYaRciDv4OJTwMUlQe5xN6qlq1/vGb/1tU
 3UmQXAyUYoKnqFjyjbicV+JuDTAUxH8suwRMCs1g4cWDUo9U/jThRZCwrzGlYlLF5cRaEh1IWj7
 nMwAEMtrZzSJHNmMJk9YDJ3x7nTXry732yRmYS2vG+z2oPSylnu0cqonK8w1ri0DwXxGGryelcT
 Wpm27k46zQui4WuJUia4x7Q4iXwEjgX+gKH0w5kHJPiaXh/wV4A3REGmPe8xyBjdCa06Y77mIew
 h7e8ymSHAXyyqh3Dywc97JoQ0WRpMmdYe/AepiLT8v5Rre2YdIH52tqBXKd0HSkmNJ0cgTOecDv
 eZsf1IvvvRbmH7EdFvA==
X-Authority-Analysis: v=2.4 cv=NMvYOk6g c=1 sm=1 tr=0 ts=6954bfb7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=nkYO0nU_c48bT3HRU-QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FS6XxfocCnB06pXnCy2v5_fDAFVUa4iq
X-Proofpoint-ORIG-GUID: FS6XxfocCnB06pXnCy2v5_fDAFVUa4iq

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>", the physical range that contains the carried
over IMA measurement list may fall outside the truncated RAM leading to
a kernel panic.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

Other architectures already validate the range with page_is_ram(), as
done in commit cbf9c4b9617b ("of: check previous kernel's
ima-kexec-buffer against memory bounds") do a similar check on x86.

Without carrying the measurement list across kexec, the attestation
would fail.

Cc: stable@vger.kernel.org
Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Reported-by: Paul Webb <paul.x.webb@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
V1-> V2: Added a line about carrying measure list across kexec based on
suggestion from Mimi Zohar. Made use to the new generic helper
[Suggestion from Borislav]

V2-> V3: Add RB from Mimi Zohar.
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1b2edd07a3e1..383d4a4784f5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -439,9 +439,15 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
+	int ret;
+
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
+	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 
-- 
2.50.1


