Return-Path: <stable+bounces-203475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DDCE638D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9533300B9AD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8B4221FCF;
	Mon, 29 Dec 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J99jiIGz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056641A9F84;
	Mon, 29 Dec 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996165; cv=none; b=vEsO0tLXtQOQB2NATnwi43LnpAAhV5l9xJhGviSCowneF5IVDFX1jlAN6pppDQitO+7UlDSAY14fXfHS9nXvC49Lacf/H8W0Hw6m6MWbGa1rv+ekLBxVkWbV0LcIFzZZ+Zu8085iNkh8713kTUZ1GM4UcQqe2zBDisyxB5nBgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996165; c=relaxed/simple;
	bh=kWFY7U8PvmqWwQiqjOhTVBQEJTUw4UMJwJdysV/gGxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT1Rn2CfFyvdJP85lEzDL+Fp5TZ9fJ3sLmX9/rcG123VDue1mbobzAj9evRiMkAcVLCUeTIFqWFMJXh8RliDzTEIwTtrI/egZWArKLQ39yEj9J06IzPVhdKhkPXaU8Lkbem7Vasbb5CtGKEUqoDIK8EMLR/4eXRaqHl3e1tJ4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J99jiIGz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT0RNgA694107;
	Mon, 29 Dec 2025 08:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lHB0/J787mnSR9SkGM/Vuf+mrrFlbP8x78mioF8t+JE=; b=
	J99jiIGzF96g5gcVCDRzoXtpUkecxNwP4ohJ+NK+nOFN82TiyQOooC2yaP3VSLuM
	hc91GW4PFWnRaJr4i4c5pqYDdmqHbU2Akm5FnegU8+XHxNc8z+6lBmEttLhaXppX
	q6R1dwWTEHvFjCEZ2CTcch5ZwLdBYeNu/zneU+zD5BCP3hDz6DYZUOa8xSGbT9LQ
	V0S+1nh+tucJ5jjHAdyAVaKEZxC7bxZBRaY3Z7Ve1u3Vvqvj/LMg9bOLRCpMk0qk
	ekr4DN/uonxb+MBiHfjGCyweqM1uODHdZpGAxztuRrNy4oyW8q8mMG9gOaGdl8pX
	uSI8MadZLClJVABxd/de1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba680hcv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT8EEp8039021;
	Mon, 29 Dec 2025 08:15:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6xkgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 08:15:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BT8FRel007295;
	Mon, 29 Dec 2025 08:15:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w6xkd1-4;
	Mon, 29 Dec 2025 08:15:34 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: zohar@linux.ibm.com
Cc: akpm@linux-foundation.org, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, graf@amazon.com,
        guoweikang.kernel@gmail.com, harshit.m.mogalapalli@oracle.com,
        henry.willard@oracle.com, hpa@zytor.com, jbohac@suse.cz,
        joel.granados@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, noodles@fb.com, paul.x.webb@oracle.com,
        rppt@kernel.org, sohil.mehta@intel.com, sourabhjain@linux.ibm.com,
        stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        yifei.l.liu@oracle.com
Subject: [PATCH v2 3/3] x86/kexec: Add a sanity check on previous kernel's ima kexec buffer
Date: Mon, 29 Dec 2025 00:15:23 -0800
Message-ID: <20251229081523.622515-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
References: <20251229081523.622515-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512290075
X-Proofpoint-ORIG-GUID: mTrnVpmVVnXBMx9vjB6SC8LHuuKGGYJq
X-Proofpoint-GUID: mTrnVpmVVnXBMx9vjB6SC8LHuuKGGYJq
X-Authority-Analysis: v=2.4 cv=HPLO14tv c=1 sm=1 tr=0 ts=695238a8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=nkYO0nU_c48bT3HRU-QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA3NiBTYWx0ZWRfX4eVbANUdtb8V
 Q6sjqi0WYMVICEmLFUEBzzMN4yXddN+Yp1k5tfrmltUJt8ixYUuuR64lbz7KPon21X3EwQobUFq
 fHz5UvdguY1Wdz+7I3q23bohy7xroPVqHiAnj8FHnr11fdyG6mrXSdOPaTc27sLnKtof0sD5BA/
 AD9g086wLrLg5ng0Yt4bGwtPUdnUNk+DT2j3ibzMkKQfeyvrN47aH6CZ37SNEkBKBRwoaai4AO+
 ige3b57Is1nn9goxdVwlxfAPqbKQ/QfP6eo/u0YqQE4jZ5S069U2C81v4CAFWHFymbm8XmNJJro
 3UqwxmR809ltE9sRTWFQCdTCUyzOTU2aIwI+7laLqYUgUfc7UHpjYo0dZUPPw10HFm7Coz/dpzP
 iV2Hg2MQoKAgDunzTkdRDu8Rh3g111YqKRhiTbxthkhSUb2WQJSlnC9BqqVG2xbfFTwt7iCi2q4
 miN7AReU/4NZIMmK4UA==

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
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
V1-> V2: Added a line about carrying measure list across kexec based on
suggestion from Mimi Zohar. Made use to the new generic helper
[Suggestion from Borislav]
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


