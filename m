Return-Path: <stable+bounces-196971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A7C88682
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C59E43557D5
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DBB29BD85;
	Wed, 26 Nov 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vhf604+S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24309288520;
	Wed, 26 Nov 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141822; cv=none; b=bzyZGTrbH7ookcaE9hRAPj4TazsPYoS+mXuW+oiDcUwicJJoB0jo17auihfv6UdcaZAFqtZay/1oiPg1zfaMhro7JAjl55bXidnqgMmI6SM7XHcS+12ksPboMf1U5MSGvxwf6RQXxOxHVpT5ym8vkNRU5h+OQ8hgFdkzPVTsYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141822; c=relaxed/simple;
	bh=j3JA5znnYtrt4HJNDsVO1n6EPEEgfRAK84tI+gKEmfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s56Zjsu0IQab5TqCXc8cExQ5CkexsQww4VdDm+7MM4K8lYolsW7EhjLJI7lgfJJyP7UCptmW0m+zJOhwmBj30GkNwebCfmjmb8+v0yazLP4WlfD4CbmTV073Ng+g3vShxR03mkd0p+5wY7CouVJkj0BCxCZa4XLYtNdcyACnwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vhf604+S; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5uCET1585588;
	Wed, 26 Nov 2025 07:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WSJ5s
	Be2mMYGocX6oiSu7qqOCfDBCiIau1XZ5l8F3FQ=; b=Vhf604+SmfR1YHB6dU9xm
	+ti7yDEYuMm8O3TSEN32MgT3FTSjIkLFJeYSANtASRZAHdU/oUKvzdYfB3eTCKtE
	qLbndtCLJepac8ErG52Kpxt/GPwIuRqpsmehQ1DzXRB5el/bVmvR4Zt61KGso/m5
	ifLq+8UIn7/2GBzME4UUEQ8yrOpzmjPJeJU2rKLnBn7VTgGGBY7JSwvIE9dGTOgi
	uXhw6Fahej0enRyKN6Tzi/cCnpZ0Hxrz+992AYQroptwH7CNU20O/PyKXkwNsU27
	qoJ/imS392qw1PEMPcGG043czTMvptli0eN9dQ394yH2EVzu5LP6RNeRBfzzNhtM
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycjrh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:23:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ71frW029886;
	Wed, 26 Nov 2025 07:23:34 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ak3me5f1b-2;
	Wed, 26 Nov 2025 07:23:33 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition on the disk with GENHD_FL_NO_PART"
Date: Wed, 26 Nov 2025 07:23:16 +0000
Message-ID: <20251126072316.243848-2-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126072316.243848-1-gulam.mohamed@oracle.com>
References: <20251126072316.243848-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260059
X-Proofpoint-GUID: zo1jfYp5PQJQbCmobWiG_yWNbzcRn8Vi
X-Proofpoint-ORIG-GUID: zo1jfYp5PQJQbCmobWiG_yWNbzcRn8Vi
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=6926aaf7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=LbKDhlQmydB64s-nk6QA:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA1OSBTYWx0ZWRfXzUurvEEXSszF
 i5hgKdVJFdLhYH2VsY8dKuG7n7r0u23GdZZVzPs5uVJavIttgfkAq1nw8XDysmolQILiYy0hc66
 hlfsK16dCZayv5MbWOwIg+Qc6Nc4YLrSIHrZFU9wNQI9ZImaBeKyKieSS/wp+okUcdM+YoJDfRo
 T7z09l4Cv1olkRzWjxCQtjklT3+Na4t9LJ7HE/qpVRuCa3o4Sqn3SzaEe31tSNXRrhwyqpXcGCC
 Qak9ReqgleA1UX3obqSDXJsK7con99t8xmC48Hq5reFcLgogI0XjMs1NuBS9FVejt3WlNd7J4lP
 V40F/0h0zegNd9YQ1lehnH32JScjhjZB27goptw7kYYYBjfTlModgAbfX5n7dUteVC9v3S8j2qf
 o21yuzn90pRzu3F4p9/jtMczEHlaFVqDt7NvvAIUxbojdvcGEn8=

This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.

The commit 1a721de8489f ("block: don't add or resize partition on the disk
with GENHD_FL_NO_PART") and the commit 7777f47f2ea6 ("block: Move checking
GENHD_FL_NO_PART to bdev_add_partition()") used the flag GENHD_FL_NO_PART
to prevent the add or resize of partitions in 5.15 stable kernels.But in
these 5.15 kernels, this is giving an issue with the following error
where the loop driver wants to create a partition when the partscan is
disabled on the loop device:

dd if=/dev/zero of=loopDisk.dsk bs=1M count=1 seek=10240;
losetup -f loopDisk.dsk;parted -s /dev/loop0 -- mklabel gpt mkpart primary
           2048s 4096s
1+0 records in
1+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0016293 s, 644 MB/s
""
Error: Partition(s) 1 on /dev/loop0 have been written, but we have been
unable to inform the kernel of the change, probably because it/they are
in use.  As a result, the old partition(s) will remain in use.  You should
reboot now before making further changes.
""
If the partition scan is not enabled on the loop device, this flag
GENHD_FL_NO_PART is getting set and when partition creation is tried,
it returns an error EINVAL thereby preventing the creation of partitions.
So, there is no such distinction between disabling of partition scan and
partition creation.

Later in 6.xxx kernels, the commit b9684a71fca7 ("block, loop: support
partitions without scanning") a new flag GD_SUPPRESS_PART_SCAN was
introduced that just disables the partition scan and uses GENHD_FL_NO_PART
only to prevent creating partition scan. So, the partition creationg can
proceed with even if partition scan is disabled.

As the commit b9684a71fca7 ("block, loop: support partitions without
scanning") is not available in 5.15 stable kernel, and since there is no
distinction between disabling of "partition scan" and "partition
creation", we need to revert the commits 1a721de8489f and 7777f47f2ea6
from 5.15 stable kernel to allow partition creation when partscan is
disabled.

Cc: stable@vger.kernel.org
Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 block/ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d25b84441237..a260e39e56a4 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	sector_t start, length;
 
-	if (disk->flags & GENHD_FL_NO_PART)
-		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
-- 
2.47.3


