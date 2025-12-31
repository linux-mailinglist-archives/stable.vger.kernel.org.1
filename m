Return-Path: <stable+bounces-204326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF3CEB553
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C8C3034A1A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115B63112B3;
	Wed, 31 Dec 2025 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuvyygPk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96E2C21CF;
	Wed, 31 Dec 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767161800; cv=none; b=ryoDP0cFkd4vUR/Njst/ygpPUAxRLyi7uIfOa4YpLyXUrYWo0ihikwCSGPQRFSnDyKK3wPHBuUdwmaOw7dzQsvUFnS/J/iPbs0pEU9+vHir8LGmUjHtYF9MNEUhunOa65BVPOfgJaa0gww4+IQ2/ZzHRe9wT2/AyH249ejHtd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767161800; c=relaxed/simple;
	bh=Fz7U3VlY1nbPKyBH6pYTuDd73e4BZZ4kDqrLdNjkEJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzJdWE0kfd7Wja2Kcx2oNXdrzB6NMgKihhFZ7NptLqEoeaPExSYRhNFb7tdOUYL7+Mbegss0YnNLAplw7GdR/8wzxXhdsxAFWgg3FEWo6XKgStZ3WB0Xumxj7Trw1Ny9fwyiSQj17lcoi0bQOmOaHKZQ5S5RQGoDsXmBPRuKbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cuvyygPk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV1FvGB1168110;
	Wed, 31 Dec 2025 06:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=gea8h4JcBzx/1OQZ
	1zWgw+SmgjfiT/PqHgNcFFok2Rs=; b=cuvyygPka9CEl1+QKuR1GTqmKjnJG83t
	8vZW3wDrREDIGkEWJmDmCRKQj9JfzihkXOYFlvtWdJZZWB0LwE9lFqljhQxtJCaw
	n6De3RkaBpkxGzDnyqf0S/CRgxP61bBJbbu9tsOP0sksM7hCzd/NzOhYRlbCingW
	qAISQ0G5PU9Vpwy5jC/gOKaDE1y9aDS9jo642ZVU+Qb9y0/e6sg90V4spC8FDDF+
	sdcMEQSHNIvWqO2UzljVOu1uGioe3b4Zofhh3Optl1eY44ebg3fr2BK/lhwIUBW9
	+VF0qzFHg7WYZ0E+VZbEAHw08jF4vZqHLhtY8buCNifw2AcPxtUlQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba5va3cn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BV5H1t4013715;
	Wed, 31 Dec 2025 06:16:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w8c7nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Dec 2025 06:16:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BV6GE8W009609;
	Wed, 31 Dec 2025 06:16:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5w8c7mt-1;
	Wed, 31 Dec 2025 06:16:14 +0000
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
Subject: [PATCH v3 0/3] Address page fault in ima_restore_measurement_list() 
Date: Tue, 30 Dec 2025 22:16:06 -0800
Message-ID: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-12-31_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512310052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1MiBTYWx0ZWRfXxdNCD4X/8yjq
 oicu83VwylURzt7pdOB1pxJada77LC5LWXgA7CcFnyHynMBzl+kTYp3Fihwm+fCKVrsrColBAxs
 +G2hF3D0dkYmc1ho1NByLL37AUV9Fi9c9rJ3oaHy3fV8ha4MiE3Jp1zBW0s+PdDiG11/4ExxhPG
 OaSWNkkF+YB6hT0DQzzVneaEeoX5NQdWn2aOt7COEjM9Kt/lXcp5nnmBgtpdjVNByqo7TvmxeiL
 bN2SkHa12iIkVECx986IXJqb/udpLkjqKqAgXq76+AUhwpAnDCS9SKiw+fLOf4+6huuJRxYCsor
 2Z9k+sLSTQiH6R17lox7VadpryxNq9BthU0t5V5j8Jv04t2fhqWegCNtLCxjbQ2LmeVLRwetu9x
 VY/5rpMlsazTFpLH4Eq0woW4XKletLsl6V+PSkWyy+XxCukBIDWoIREean8omDJyZLpOsHvRRtk
 wq1Tcp77lViOUrOAixA==
X-Authority-Analysis: v=2.4 cv=NMvYOk6g c=1 sm=1 tr=0 ts=6954bfb2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=o_HryE7LVYY9I7Eu9FsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vG5ozfdd-nEO8nhaJe10dhg6bTe_Z-ZN
X-Proofpoint-ORIG-GUID: vG5ozfdd-nEO8nhaJe10dhg6bTe_Z-ZN

On x86_64:
When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>" we observe a pafe fault that happens.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

This happens on x86_64 only, as this is already fixed in aarch64 in
commit: cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds")

V1: https://lore.kernel.org/all/20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com/

V1 attempted to do a similar sanity check in x86_64. Borislav suggested
to add a generic helper ima_validate_range() which could then be used
for both OF based and x86_64.

Testing information:
--------------------
On x86_64: With latest 6.19-rc2 based, we could reproduce the issue, and
patched kernel works fine. (with mem=8G on a 16G memory machine)
Thanks to Yifei for finding enabling IMA_KEXEC is the cause.

Thanks for the reviews on V1.

V1 -> V2: 
 - Patch 1: Add a generic helper "ima_validate_range()"
 - Patch 2: Use this new helper in drivers/of/kexec.c -> No functional
   change.
 - Patch 3: Fix the page fault by doing sanity check with
   "ima_validate_range()"

V2: https://lore.kernel.org/all/20251229081523.622515-1-harshit.m.mogalapalli@oracle.com/

V2 -> V3:
 Update subject of Patch 1 to more appropriate one (Suggested by Mimi
Zohar)

Thanks,
Harshit

Harshit Mogalapalli (3):
  ima: verify the previous kernel's IMA buffer lies in addressable RAM
  of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()
  x86/kexec: Add a sanity check on previous kernel's ima kexec buffer

 arch/x86/kernel/setup.c            |  6 +++++
 drivers/of/kexec.c                 | 15 +++----------
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.50.1


