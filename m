Return-Path: <stable+bounces-109142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE1A12620
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47013A1EA1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DD78F41;
	Wed, 15 Jan 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lnt051st"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98567433CE;
	Wed, 15 Jan 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951769; cv=none; b=LMnZBFe3GYw0gz7DIT19polGfu97bAaO15VGDyuSZsU1KoVBRYT/3mEX9/hVEOrlt6fX1kgTGmrVX5xlOpUlSOytnOZ5wSKYrj61XTx8Ylre2lI/b70ek02InKQLlF6G0TIwJ7rAom9sh91Dq2Dno+mlSKqlWWmvRfKz41IICI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951769; c=relaxed/simple;
	bh=c3e4qA0spOndgNqhvczt5F/tnLWEKVzdMiVKh58mEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/ukk3aHOQ2Vsut4Zul2lTOGCG0fafSItFzZgCl0gMnPyqLqpkRXPGOMfQJXxJ4sYR4EIcIleMZjap5VRle1sOJfTdcsQzf0Ionw1UzYXm9r4rYDWyWl0TlTEr9ZWP8qIF45Ml7bnuTNF/6cWPZolGq0s7OEZfkXBa/wFO4XzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lnt051st; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F3r2BF019723;
	Wed, 15 Jan 2025 14:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bRv5FAA/c71hkwafkzyrYcPe3qTn1SXwuO4ZJ3gXn
	Fs=; b=lnt051stOQEkG8ZoBJt5/n8CjIXyq+HSicHEU/B6nFlV9gaHQtaiC6c5E
	E4nqDy/h2gkSbjOcnOWaUVJ6EyEyswjvF+ZEk26TmYwI4d3ZEyLSVTWOqdfrSb8r
	dK2+ECShNON7vCcmfGfXU/bthUQRbbuXr00iKkNbPzk/xB1pFoZoYR95c4qqcVJh
	mFxzXIxUaANfsrsEb+FBRhZ0QHPCxG+5jVdWcuY6LUDZXBMLlBQ7lEQ9KLOnfgTk
	0bVln7Vz1o5MuzQlGEDiMxH3mxrTQ3F1zbbHLM2j0j88EgHusA8pp4AhMcY/Cbp6
	pOSwreSjlN92XdAVHe9Hzm6NryZCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjtphq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:35:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FEPpsu014961;
	Wed, 15 Jan 2025 14:35:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjtphn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:35:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FBKKhw017003;
	Wed, 15 Jan 2025 14:35:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk8ppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 14:35:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FEZZpv14090708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 14:35:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 399A220043;
	Wed, 15 Jan 2025 14:35:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F77E2004B;
	Wed, 15 Jan 2025 14:35:33 +0000 (GMT)
Received: from ltcrain34-lp2.aus.stglabs.ibm.com (unknown [9.3.101.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 14:35:32 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com,
        sbhat@linux.ibm.com, ritesh.list@gmail.com
Subject: [PATCH v4] powerpc/pseries/eeh: Fix get PE state translation
Date: Wed, 15 Jan 2025 08:35:29 -0600
Message-ID: <20250115143529.136704-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f7jHl0UtK7lq1PMqmIhF7h3AIW_SRpaJ
X-Proofpoint-GUID: V4gWDD-ZohALAT7S-pwnZZxoxWL2Zsi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150110

The PE Reset State "0" returned by RTAS calls
"ibm_read_slot_reset_[state|state2]" indicates that the reset is
deactivated and the PE is in a state where MMIO and DMA are allowed.
However, the current implementation of "pseries_eeh_get_state()" does
not reflect this, causing drivers to incorrectly assume that MMIO and
DMA operations cannot be resumed.

The userspace drivers as a part of EEH recovery using VFIO ioctls fail
to detect when the recovery process is complete. The VFIO_EEH_PE_GET_STATE
ioctl does not report the expected EEH_PE_STATE_NORMAL state, preventing
userspace drivers from functioning properly on pseries systems.

The patch addresses this issue by updating 'pseries_eeh_get_state()'
to include "EEH_STATE_MMIO_ENABLED" and "EEH_STATE_DMA_ENABLED" in
the result mask for PE Reset State "0". This ensures correct state
reporting to the callers, aligning the behavior with the PAPR specification
and fixing the bug in EEH recovery for VFIO user workflows.

Fixes: 00ba05a12b3c ("powerpc/pseries: Cleanup on pseries_eeh_get_state()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

---
Changelog:
V1:https://lore.kernel.org/all/20241107042027.338065-1-nnmlinux@linux.ibm.com/
--added Fixes tag for "powerpc/pseries: Cleanup on
pseries_eeh_get_state()".
V2:https://lore.kernel.org/stable/20241212075044.10563-1-nnmlinux%40linux.ibm.com
--Updated the patch description to include it in the stable kernel tree.
V3:https://lore.kernel.org/all/87v7vm8pwz.fsf@gmail.com/
--Updated commit description.
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1893f66371fa..b12ef382fec7 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
 
 	switch(rets[0]) {
 	case 0:
-		result = EEH_STATE_MMIO_ACTIVE |
-			 EEH_STATE_DMA_ACTIVE;
+		result = EEH_STATE_MMIO_ACTIVE	|
+			 EEH_STATE_DMA_ACTIVE	|
+			 EEH_STATE_MMIO_ENABLED	|
+			 EEH_STATE_DMA_ENABLED;
 		break;
 	case 1:
 		result = EEH_STATE_RESET_ACTIVE |
-- 
2.47.1


