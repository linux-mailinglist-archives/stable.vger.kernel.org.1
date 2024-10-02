Return-Path: <stable+bounces-80562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADD98DE6B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B231C20404
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822C1D0B82;
	Wed,  2 Oct 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TsLgata3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6541D096A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881642; cv=none; b=ZSxMtbn2JozYcHGwa+X0c0gTn8HT/W5nhaeo6FuR9OR4U4irXIV81C6i5zcvbNpHEv0l0BQ0w9e/wLpqIN4p9GiKiqkFu5e12IrN+3VODIqvoOD4760tb+HVqnUkmoXWK9CjL2EO6mRFS9Xuc00Pr/Tc70IKn+fSPoJQlnQMLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881642; c=relaxed/simple;
	bh=i+72DQaKjnnKcmM+oBx6sf795VH1ZdHmSZ36n8bt+Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iK46CiSIURW6sOWuutbFZDQgmd6NYB+GUjEgH8cO6wqykjJcYT+UADlid4JD9nv4SVNdPpa55EbmSoPevpcjQFQoSjgaPziaXRt+NHp3F/7MQffm+bnD5h5NO2CUeGxS5vONDSIicUTR8J2+9xo4I/gE6nRH6ld7xUombl1DZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TsLgata3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd4AV025607;
	Wed, 2 Oct 2024 15:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=z
	DhSlSJGCRy2tHxYWnAa3EyEMaOwCGE6HdgRA4N1HVk=; b=TsLgata36R6ugaJ2C
	HZtWWu0iOrNwKU75dGGio07+YjYGKaeWYZduG4E10Ox3tdorCxU5ufa8zIMyi7f9
	OYwRLdGR/PMUql9TueFbgmCMboitrhtHHKrPHXxw6MyQXVDV9BaDzdVZjJZtl0Xu
	24lJUdZ2N6NoiuBtORhSD5N8aGKAB82No5zzGc3ylOkKZFUkJQBfLtppOqlfWJE9
	Qqx4/XQtTu4ozg0hEosR2AulS0XwopqNrPOANHURXUsKgOED7IRvOxA1s3dITSoF
	Tdlp677hlQN+ZLsfaQjTkbWRYNwDkhspCGVIFQFoEw581quh8kDL6xgCa3vGtBB0
	8TX8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucss96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492ESNjg017238;
	Wed, 2 Oct 2024 15:07:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y10d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZU012831;
	Wed, 2 Oct 2024 15:07:06 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-10;
	Wed, 02 Oct 2024 15:07:05 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 09/15] iommufd: Fix protection fault in iommufd_test_syz_conv_iova
Date: Wed,  2 Oct 2024 17:06:00 +0200
Message-Id: <20241002150606.11385-10-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: SQa6fvpuE6kbqhuGHAAuJirwxfvZqT9A
X-Proofpoint-ORIG-GUID: SQa6fvpuE6kbqhuGHAAuJirwxfvZqT9A

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit cf7c2789822db8b5efa34f5ebcf1621bc0008d48 ]

Syzkaller reported the following bug:

  general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
  Call Trace:
   lock_acquire
   lock_acquire+0x1ce/0x4f0
   down_read+0x93/0x4a0
   iommufd_test_syz_conv_iova+0x56/0x1f0
   iommufd_test_access_rw.isra.0+0x2ec/0x390
   iommufd_test+0x1058/0x1e30
   iommufd_fops_ioctl+0x381/0x510
   vfs_ioctl
   __do_sys_ioctl
   __se_sys_ioctl
   __x64_sys_ioctl+0x170/0x1e0
   do_syscall_x64
   do_syscall_64+0x71/0x140

This is because the new iommufd_access_change_ioas() sets access->ioas to
NULL during its process, so the lock might be gone in a concurrent racing
context.

Fix this by doing the same access->ioas sanity as iommufd_access_rw() and
iommufd_access_pin_pages() functions do.

Cc: stable@vger.kernel.org
Fixes: 9227da7816dd ("iommufd: Add iommufd_access_change_ioas(_id) helpers")
Link: https://lore.kernel.org/r/3f1932acaf1dd494d404c04364d73ce8f57f3e5e.1708636627.git.nicolinc@nvidia.com
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
(cherry picked from commit cf7c2789822db8b5efa34f5ebcf1621bc0008d48)
[Harshit: CVE-2024-26785; Resolve conflicts due to missing commit:
 bd7a282650b8 ("iommufd: Add iommufd_ctx to iommufd_put_object()") in
 6.6.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/iommu/iommufd/selftest.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 56506d5753f15..00b794d74e03b 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -44,8 +44,8 @@ enum {
  * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
  * value. This has a much smaller randomization space and syzkaller can hit it.
  */
-static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
-						u64 *iova)
+static unsigned long __iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						  u64 *iova)
 {
 	struct syz_layout {
 		__u32 nth_area;
@@ -69,6 +69,21 @@ static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
 	return 0;
 }
 
+static unsigned long iommufd_test_syz_conv_iova(struct iommufd_access *access,
+						u64 *iova)
+{
+	unsigned long ret;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
+	}
+	ret = __iommufd_test_syz_conv_iova(&access->ioas->iopt, iova);
+	mutex_unlock(&access->ioas_lock);
+	return ret;
+}
+
 void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 				   unsigned int ioas_id, u64 *iova, u32 *flags)
 {
@@ -81,7 +96,7 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 	ioas = iommufd_get_ioas(ucmd->ictx, ioas_id);
 	if (IS_ERR(ioas))
 		return;
-	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	*iova = __iommufd_test_syz_conv_iova(&ioas->iopt, iova);
 	iommufd_put_object(&ioas->obj);
 }
 
@@ -852,7 +867,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+		iova = iommufd_test_syz_conv_iova(staccess->access,
 					&cmd->access_pages.iova);
 
 	npages = (ALIGN(iova + length, PAGE_SIZE) -
@@ -954,8 +969,8 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
-					&cmd->access_rw.iova);
+		iova = iommufd_test_syz_conv_iova(staccess->access,
+				&cmd->access_rw.iova);
 
 	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
 	if (rc)
-- 
2.34.1


