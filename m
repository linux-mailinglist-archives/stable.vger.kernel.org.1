Return-Path: <stable+bounces-103982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828349F078F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400BF28739D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1F1AAE28;
	Fri, 13 Dec 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rAwRIFzD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9C130A54;
	Fri, 13 Dec 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081537; cv=none; b=rh9Dv0DUZhxTvjfTWCANpd6nwk3yzvAznM1o+b6+vkyucrEEqwMzP8R0SP3RiU4iAMLWzH/ra3Q8v8LeSe9xBwowHKBhp+xtW+zTczqag7uJzhU2cTNtQnCIrz3gpbE8EuuWo0PNs66XuoHfsqWoA6nZB2HcugJawRA/NnBNrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081537; c=relaxed/simple;
	bh=MA+nxvCfVzFUjouhmxBgEE/99XIjYcUxr9cOjEtMakM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJkDudMTfHToskQ0x3+9op2b/UtnRrdsve5VhIQqtU0IfzshFrt9PfhVeMibEMFnLmLh8xQkUbSvChz1HcJtZcctNgUe/+VLmK7yN0lUj9xpLkR7RxAbyGsRHffhQc1d7XrJkviD4fU7djnGv+SLqH+ryGWi9oPVt1fpD0eR9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rAwRIFzD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD85ktN011241;
	Fri, 13 Dec 2024 09:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KZFnLO1yLYbr8xUZ6RNwfEwft+lDmowGg2KVmCJtU
	6c=; b=rAwRIFzDmSqo4SwhYfqBlkcJlFnZYG0s8sviq3iWiO8P90WIRAG3UPVf5
	ZvpZi700OxmOYpqY9YrUtHLmav4JgKYGTRPVb+NxJxmADw5t0r3fb6fYrU5N4Ekh
	mgkpciGCxq0asyAjJFYGopc+8rqV2bh0Xobp/ifBFyU+HboiRdgtd90DRX3q0SLJ
	1cQ3c3mAMxsT6CKJh6CrjfTELtuPCzvfQERQrTtKw1bNd1DwETkjm32ff7oaJorS
	kXZxNRPweIgTLmZ/BLEchNWJbKF9+wu8f54N2Sv6p1vxBOsazM0Fvbsk8hc9Qrni
	BgwNlwM+ep++xoZd/PMZgpM2Mbwzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh438a6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:18:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BD9Glxj030235;
	Fri, 13 Dec 2024 09:18:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh438a6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:18:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7ppOX032734;
	Fri, 13 Dec 2024 09:18:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pswb6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:18:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD9ISQo56885568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:18:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD8120043;
	Fri, 13 Dec 2024 09:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A968A20040;
	Fri, 13 Dec 2024 09:18:26 +0000 (GMT)
Received: from ltcrain34-lp2.aus.stglabs.ibm.com (unknown [9.3.101.41])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 09:18:26 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com,
        sbhat@linux.ibm.com
Subject: [PATCH v3] powerpc/pseries/eeh: Fix get PE state translation
Date: Fri, 13 Dec 2024 03:18:22 -0600
Message-ID: <20241213091822.3641-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OpzvR0uWDg0QENT7sHOQfw863LX8BdL7
X-Proofpoint-GUID: B_LWP2tO7dDM_c0RPUz1kix-74ODXpSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130061

The PE Reset State "0" obtained from RTAS calls
ibm_read_slot_reset_[state|state2] indicates that
the Reset is deactivated and the PE is not in the MMIO
Stopped or DMA Stopped state.

With PE Reset State "0", the MMIO and DMA is allowed for
the PE. The function pseries_eeh_get_state() is currently
not indicating that to the caller because of  which the
drivers are unable to resume the MMIO and DMA activity.
The patch fixes that by reflecting what is actually allowed.

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


