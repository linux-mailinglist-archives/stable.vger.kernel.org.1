Return-Path: <stable+bounces-108365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7705BA0AE00
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 04:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D93A6182
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD5126BFA;
	Mon, 13 Jan 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G1Crzmzm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8173C3C;
	Mon, 13 Jan 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736740161; cv=none; b=mYHQrltnNSRGBfijwTJjrPs4yFcvShxV3A+ELqkNtyYDvvdb8B27V75peSTj5L3oRmmHPHz/BFrc3wTxMkgmnUwgWsFQUIE0i3uUUTMYMJ2qQc+Mzw+Pnq5H6yJ7hpBtLAZYG5NNyV3VlZ6Zs8cvdrOxzpFEJlns5NRoF8lPYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736740161; c=relaxed/simple;
	bh=CVvMkY29d++So0/YNo0iy2pjj2rlyxWBsHLs617WkGw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=FrJCDg5aF/olZHBJ0aMploMb9UnI6zEfH3kQ9+Y7fCpdhqaYIg/iq/T/cR9PK+CIhEZnQPiRz4lV4ngsuI0ezGfgPWWZ5yUaGTjMVnqcWxehQwldVpevwmIpIgctNpGvoQCEOW4MlXBTL1i/xk9hCWuxlS9g8dN1IO7lOVJVUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G1Crzmzm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNbKww024222;
	Mon, 13 Jan 2025 03:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=/4fkptSCdc2xGU+GFFmeCmKqnsZW
	EVajCUs8N9kD/zI=; b=G1Crzmzmw4pVVQpUCb/5jChUMRWtYs5wlfuD6OYu7nl1
	Fx03NWe2W3lV8+nUVPJFZxCGYYKctu1P7gPBXn09Damkecb4a7y2LqMrFne67TVT
	86vxA8AGVZCPq16g2x/k5QNOIeE3MsVxdsJ1E7jFSAWXRh+Wk+3mbmo32Aq+Hq40
	MqdU94A8nTTMxc6LQixEyU5Upc9Y0ofnYgEjw/j/vUiqJRAgfnd9yLGUJGdcGkbr
	KVwaVM5WNKgUn/VX4z9YuUoyDWSP+751rNt5Q4MvwSGyiF8FploZ4EVWZla+fKbo
	kDI6OzMR0Wg8PewAEe7Fdly7exwV9uzGhT3P/lH93Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjagjuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 03:49:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50D3n2ja028967;
	Mon, 13 Jan 2025 03:49:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjagjuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 03:49:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50D02ixM000875;
	Mon, 13 Jan 2025 03:49:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jm4ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 03:49:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50D3mwFh41419018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 03:48:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE6120043;
	Mon, 13 Jan 2025 03:48:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7070020040;
	Mon, 13 Jan 2025 03:48:56 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 03:48:56 +0000 (GMT)
Subject: [PATCH] powerpc/pseries/iommu: Don't unset window if it was never set
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, gbatra@linux.vnet.ibm.com,
        sbhat@linux.ibm.com, brking@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        vaish123@in.ibm.com, stable@vger.kernel.org
Date: Mon, 13 Jan 2025 03:48:55 +0000
Message-ID: <173674009556.1559.12487885286848752833.stgit@linux.ibm.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DhHou8mYPADuflKu_0G5dCRbUKDq_ra1
X-Proofpoint-ORIG-GUID: 0sYiMxJ7-Yew-lvxNi327WsAUdDkktwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=588 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130028

On pSeries, when user attempts to use the same vfio container used by
different iommu group, the spapr_tce_set_window() returns -EPERM
and the subsequent cleanup leads to the below crash.

   Kernel attempted to read user page (308) - exploit attempt?
   BUG: Kernel NULL pointer dereference on read at 0x00000308
   Faulting instruction address: 0xc0000000001ce358
   Oops: Kernel access of bad area, sig: 11 [#1]
   NIP:  c0000000001ce358 LR: c0000000001ce05c CTR: c00000000005add0
   <snip>
   NIP [c0000000001ce358] spapr_tce_unset_window+0x3b8/0x510
   LR [c0000000001ce05c] spapr_tce_unset_window+0xbc/0x510
   Call Trace:
     spapr_tce_unset_window+0xbc/0x510 (unreliable)
     tce_iommu_attach_group+0x24c/0x340 [vfio_iommu_spapr_tce]
     vfio_container_attach_group+0xec/0x240 [vfio]
     vfio_group_fops_unl_ioctl+0x548/0xb00 [vfio]
     sys_ioctl+0x754/0x1580
     system_call_exception+0x13c/0x330
     system_call_vectored_common+0x15c/0x2ec
   <snip>
   --- interrupt: 3000

Fix this by having null check for the tbl passed to the
spapr_tce_unset_window().

Fixes: f431a8cde7f1 ("powerpc/iommu: Reimplement the iommu_table_group_ops for pSeries")
Cc: stable@vger.kernel.org
Reported-by: Vaishnavi Bhat <vaish123@in.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 534cd159e9ab..78b895b568b3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -2205,6 +2205,9 @@ static long spapr_tce_unset_window(struct iommu_table_group *table_group, int nu
 	const char *win_name;
 	int ret = -ENODEV;
 
+	if (!tbl) /* The table was never created OR window was never opened */
+		return 0;
+
 	mutex_lock(&dma_win_init_mutex);
 
 	if ((num == 0) && is_default_window_table(table_group, tbl))



