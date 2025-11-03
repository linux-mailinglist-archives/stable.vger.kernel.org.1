Return-Path: <stable+bounces-192184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60745C2B3D4
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 12:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2161892C91
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96DF30148B;
	Mon,  3 Nov 2025 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="spozUV1S"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70252FF66C
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167959; cv=none; b=R+wOGBHCkl+uiITfSPeUOVxLi0Z4Mcxxad6JQMsyoJ5QbAmuqBITBJSjOcCDe38zmoG7qcuqdu/MetsgKkEfy67VuSnTpLsN/6XUYfJyvM7gE9WFMTd8CBoyKSySKT+i1vNPzrCQTZPJ5lHj3KE7zI9cYuQV6R07FLlpD+/UTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167959; c=relaxed/simple;
	bh=EhXRwTDcGRfCa9Dgf1uiJd6M8CtZQz+Bf8MEIFDBYkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFUee+v1btdtdK/xSQYv8Idkt6s47VJwRHZV1oVrzxceOWnF4p+8eGCLT+NdwxbEh/0j0TR+gMM3olzMso7ywyAwBfJW8eBNKHVLhlogevIhqRT7GNhKhiTKnP1CYMJB/5YDW1nRh0l90H3BDH8ok4aWRtFX/7u+RXWQGkxyNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=spozUV1S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2KZa8f013046;
	Mon, 3 Nov 2025 11:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Lrs0LtLdv4wrRHm7
	mefw/BPsRZoAdR5ENRlUyncv1I=; b=spozUV1Su7ZB/NrHnHnDkN9g4ADcYprvv
	Pdy/PYT4i3aXdqKU0B1MruVUsEGwIEGebaCfU0npsM34lkf/s934jpyn4yYJg+gX
	ERx5/hnIJrqNw1FE3fCd7qUCQlf+Aj4fdtddVAVvPRQJVV7ejK1Oe+YIB4LKwTnr
	sq7kFNbYxEOS8pQKMg7ot7oZqpc6n7psf4qpARB9r+0Ejf5LjZHTYI3o7Ded/v3o
	LfTqL28MgEw/rqDxZAieMZOZaqok+YkBqIBhSETzwGLzl4ZCEG6bwkZCEUaryozy
	l1TG3+CBLeaMPVQ85Au3aisdS/t6XVmvK5YTZoKy09/HcpizRUAZA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mkp6t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:05:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A37WcHg018667;
	Mon, 3 Nov 2025 11:05:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whn581e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:05:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3B5fIJ42009044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 11:05:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBF4420043;
	Mon,  3 Nov 2025 11:05:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7D920040;
	Mon,  3 Nov 2025 11:05:41 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 11:05:41 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Luiz Capitulino <luizcap@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 6.6.y] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
Date: Mon,  3 Nov 2025 12:05:39 +0100
Message-ID: <20251103110539.3428888-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025110340-immature-headband-9af4@gregkh>
References: <2025110340-immature-headband-9af4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6bPpEqdv173yYtMN-zk0dO9ws49X705L
X-Proofpoint-GUID: 6bPpEqdv173yYtMN-zk0dO9ws49X705L
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=69088c8c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=IPqCXgE9jc2f-zZAk4AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX7vn340KNvICP
 UPQsJxqEgeTiHC4D1DELOx3lznHAZnrhjaFZhmiww5Kqij56wyK61h2GfAJHPOfSWyj6WwaJB/r
 bjN+5TN0yf5/TKF+nKuXhuKTScLsmOIhhIYsyzsQsrau7KwzR1+9bi0dNWrUVrzYYVLHUcSopVZ
 2kCkhmSFDdwm9l3Er2haZyevryt0I5EHfxZNDeajts78NUVlipVaV0YPHdzJRjz6y03CrEt7Hif
 sFcuc/K/s8ek0xWSbnCpv+0x0RAHetxxsg2nBH+iXHFvWnSqiGYU39sYcaw9dXl4F5Q+bTI4crq
 CekpMkgceIWcy0S21JhY3iInjdyAi4+LKSgT07V+oPWOa10L632n0Wgfv995//gCCgEXLxjWkT9
 GIIFVRZVInppmCKukfWZyfuM6mh7LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009

[ Upstream commit 64e2f60f355e556337fcffe80b9bcff1b22c9c42 ]

As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
crashes. The problem is that kernel page tables are modified without
flushing corresponding TLB entries.

Even if it looks like the empty flush_tlb_all() implementation on s390 is
the problem, it is actually a different problem: on s390 it is not allowed
to replace an active/valid page table entry with another valid page table
entry without the detour over an invalid entry. A direct replacement may
lead to random crashes and/or data corruption.

In order to invalidate an entry special instructions have to be used
(e.g. ipte or idte). Alternatively there are also special instructions
available which allow to replace a valid entry with a different valid
entry (e.g. crdte or cspg).

Given that the HVO code currently does not provide the hooks to allow for
an implementation which is compliant with the s390 architecture
requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
basically a revert of the original patch which enabled it.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
Cc: stable@vger.kernel.org
Tested-by: Luiz Capitulino <luizcap@redhat.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[ Adjust context ]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bd4782f23f66..e99dae26500d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -128,7 +128,6 @@ config S390
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
 	select DMA_OPS if PCI
-- 
2.48.1


