Return-Path: <stable+bounces-180679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB59B8AC4E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A38564BF0
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169824503B;
	Fri, 19 Sep 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qHxUfN8v"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AB3D6F
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303221; cv=none; b=Ok0AgZIdXVXyhFc+HpU+h7OkbOHQdlAvt6e7X9+PZDWf1VFAeQz3qmMbdQ6NSYIPItgf7At8dmoihEkj0Sgq/MSvtyGNxK7/w9eA4FkzU0K5x+1Xjsuzc5+DuXt/W6dllSTUWVE6hAQdTRIxNSi/FA3oR871Ep4P1Gtpq63mVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303221; c=relaxed/simple;
	bh=bOj7w/AuPXR5UmlynBXZOpcQtsEsQhGaFaPRIiUozQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDvBCJq//Snge3l0lYFQoIUeSUKQHkVZ0KSonCiW6uEw5cFAAR63JgjnLMNalcaH06VpwHwZJBBk3hFDR9m515rTc7OMU7wSlCSuPN9DV4D7UHZPfz4+ZjNCgmjZPff9vKIROekvDks9wiJgpqieafO3BDKQRcjo4sDnDQ3kpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qHxUfN8v; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuSAF018787;
	Fri, 19 Sep 2025 17:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=G89DQwPlPYzU5eyXRS/PRq/AeumF2
	wEPmc1PKVRHxa8=; b=qHxUfN8vPfENEPkb64scL9Bkbwh5RMGQl+UlYwWg2HfZ2
	qbreSjEAaXU9Ksf9eaNL8HdjQsmHHowpj4L4/jREi7/wx7rewbSMYP90m3CKjQAX
	6Ig1lHlSz/CQkG/BaChhHD+dg0gmFn1kjTV1gYhkZhD8mPColw8zUjmd+B+TDBJa
	nagC0xUc8ShHgEbkP5nAYliGnQKr5H7TIa1u4PztqhxFZIAE2LwNQZNhQKpN30XL
	E9RJ1YOqKdzLC1GnV2BrJoRBjnp1ESBtpAHD3zV+WLLE4fy7nriXjX7iQyuRd8Uf
	GjgN1rh4o6kC3zTLrLAs/l1ns/xItjwyJ9v2tn4Ew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9x35c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JG6Iaj001595;
	Fri, 19 Sep 2025 17:33:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gy13g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JHXUud001465;
	Fri, 19 Sep 2025 17:33:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 494y2gy0w9-1;
	Fri, 19 Sep 2025 17:33:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ankur.a.arora@oracle.com,
        boris.ostrovsky@oracle.com, bp@alien8.de, darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 0/3] Fix a backport of VMSCAPE enumeration fix
Date: Fri, 19 Sep 2025 10:32:57 -0700
Message-ID: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190164
X-Proofpoint-ORIG-GUID: MPa0uI6mzKxTaaDsEVq0F34Wwj_WWqkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2wcGMPLiZmyZ
 KFp8827YoqBj9YG5KPIE0JXwl3l0iO7vFEiSNKY7Ofwo5GBE3AhivhwSxFSGmduuhqQwhexgIla
 Ie/b/YQjmG+xysa9J9vMRNAy5KVaKFHMI4r6+crKU/Efep0/lBbZSv31Y5bH/D0oWls99LxvU36
 F2NN5jrsLUr4/MrTYC8iE0sT+N2EEt1vVf5pPDIyIC7o6AmRIAog7cdQUdB56X6uxHU/DwiG6j1
 fcQzBluP1ik1hHH9gR444r/e184FGY/tmwpj5hWMVe9CzFsCkDLvXEhSrrxrziZA4tHVZGH+iKy
 PG7G03i0i1j7oVYQIAs1L0wvtmVAdBcSEh+7xZkWWoHTSlxo7nNZZ6XesqLYFCJrJsIyM2mOgIV
 bzat0Yl+
X-Proofpoint-GUID: MPa0uI6mzKxTaaDsEVq0F34Wwj_WWqkD
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd93ec cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=JRmoFRQgYutMhVdIDhoA:9

Bug-report: https://lore.kernel.org/all/915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com/

Summary: While backporting commit: 7c62c442b6eb ("x86/vmscape: Enumerate
VMSCAPE bug") to 6.12.y --> VULNBL_AMD(0x1a, SRSO | VMSCAPE) was added
even when 6.12.y doesn't have commit: 877818802c3e ("x86/bugs: Add
SRSO_USER_KERNEL_NO support").

Boris Ostrovsky suggested backporting three commits to 6.12.y:
1. commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO support")
2. commit: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX") 
and its fix
3. commit: e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 
<=> 1 VM count transitions") -- Maybe optional

Which changes current mitigation status on turin for 6.12.48 from Safe
RET to Reduced Speculation, leaving it with Safe RET liely causes heavy
performance regressions.

This three patches together change mitigation status from Safe RET to
Reduced Speculation

Tested on Turin:
[    3.188134] Speculative Return Stack Overflow: Mitigation: Reduced Speculation

Backports:
1. Patch 1 had minor conflict as VMSCAPE commit added VULNBL_AMD(0x1a,
SRSO | VMSCAPE), and resolution is to skip that line.
2. Patch 2 and 3 are clean cherry-picks, 3 is a fix for 2.

Note: I verified if this problem is also on other stable trees like (6.6
--> 5.10, no they don't have this backport problem)

Thanks,
Harshit

Borislav Petkov (1):
  x86/bugs: KVM: Add support for SRSO_MSR_FIX

Borislav Petkov (AMD) (1):
  x86/bugs: Add SRSO_USER_KERNEL_NO support

Sean Christopherson (1):
  KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count
    transitions

 Documentation/admin-guide/hw-vuln/srso.rst | 13 +++++
 arch/x86/include/asm/cpufeatures.h         |  5 ++
 arch/x86/include/asm/msr-index.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                 | 28 ++++++++--
 arch/x86/kvm/svm/svm.c                     | 65 ++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h                     |  2 +
 arch/x86/lib/msr.c                         |  2 +
 7 files changed, 112 insertions(+), 4 deletions(-)

-- 
2.50.1


