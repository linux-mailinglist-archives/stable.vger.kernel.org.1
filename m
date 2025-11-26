Return-Path: <stable+bounces-197046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C10C8B5AB
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60F1534D6C2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573630CDBD;
	Wed, 26 Nov 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUElGZ4r"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057730BF67;
	Wed, 26 Nov 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179666; cv=none; b=hg/St1kJ+8YtCuVC5zP0jexnZdi3Fd5UK2JDnoy0Y/56mBt0UTvVIKpmkpHr+czO52loJUp9HN11jwlkKtrAYzmFj1BEbKXrOLxuZLy7s/PY5yGuGW0zim1FbF0hfvWjyaMzz4LMIJbikrYY266Crrj0rnRvR1fRMtVMhvDXCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179666; c=relaxed/simple;
	bh=dMjEhUToX/GfF9HX/QyQPqqJTHUhzNbVUsr9/l+m5hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzT4MwQqszVy49R1VQjBp30FrEw4WZ4N70SWqzwjTO3vtwjsTs1LlZyoSRdIqdV/7W1LTshEasggLtCmmGCFY3mpwaYPquuTw4zyfGqutux4mkqpWRbZAWar/ZtMl5hidYWwlgskaxi2m50NkaOCfyfnbRt6mKcPPngUYAhZbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eUElGZ4r; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQGGgtM2650892;
	Wed, 26 Nov 2025 17:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=WJEg4cYbU8pt4FxzVRcRBVeTy3a6g
	ZBr+sRQRYF+Kms=; b=eUElGZ4rSC1Cr7d29ZRxjp6hQnz6pa8aRGkhG+VaN17eO
	i4sLJi2yVTBu6j/BRUQoXjg56A9c3KzSiH7B3alswVKtsC0ENoFhbntAy9bRg9yI
	flY+Zm0XUceqC5G14b14LY/gaFR3IXksksu9uYcVZrwezbrTwlUs1HrfdZNE6fI5
	zLlowe2vKzi1CYmJ3SOI5mbEErWR+wjVB1wGaPokq+XZFmLMV3AAqpKLbsFs1Jca
	UMWn6f97yjcYnDF8KvqBlT9tbWU+QwcdR2fBi9Cebpw0r2APuCvG5EFAWuUfJ61o
	zcKi5fko8Bp//VZ8vRP7uxPKZOeD3cHt5I3Wfh6/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhvyhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:54:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQGQawM032704;
	Wed, 26 Nov 2025 17:54:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb9wyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:54:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AQHsGi1028620;
	Wed, 26 Nov 2025 17:54:16 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3mb9wxw-1;
	Wed, 26 Nov 2025 17:54:16 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, gulam.mohamed@oracle.com
Subject: [PATCH V2 5.15.y 1/2] Revert "block: Move checking GENHD_FL_NO_PART to bdev_add_partition()"
Date: Wed, 26 Nov 2025 17:54:14 +0000
Message-ID: <20251126175415.259906-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260146
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69273ecb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=El8LTbAtAdtaEuyw91sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0NiBTYWx0ZWRfX/+vjol9uc4KO
 2CofQ8KIrohRwSHZDdF3MPDvi5cs3+0s/MHgWQ5oOk16G1+WluI2RV7K8RsSC+lAuH0Ro2lIJnj
 iYSHxWWoP32rKqb/KTPFZY0Yr8kKgh1dxFqyB5Z1Khgnbbr/b/5iS3wANMMKFBU8xUSwylr8sn0
 VaOVeJVgUh7u8RN4XPmo9EmGV1Ogkxum1+GdOFmVPG5Pm9Vxvd+BcbcGBdNi5HflQfamOF405nn
 Ws93f5uDIsRAl+Dm/YGdAYF/DEiSQ7QEUvuj9d/X2B/PVjToBQoPS2NpKADys4DSX0OyYCjH278
 ijpck8aJ05rxqxP2V9LMWiUc6fnUev/Ex7F5ivExh17wRBtgdrjnp3tpOCuhUE9ZI5lIg1D5iUj
 vRFGxNvtktLgxVZ32kOwP8EWcXOoMg==
X-Proofpoint-ORIG-GUID: xSZVw82dZmXM_Xm26Ve3giUTiynAzSsA
X-Proofpoint-GUID: xSZVw82dZmXM_Xm26Ve3giUTiynAzSsA

This reverts commit 7777f47f2ea64efd1016262e7b59fab34adfb869.

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
Changes in V2:
- Added,in the second patch, the reason for reverting the patch
- Added the linux stable version 5.15.y to the subject line
- Added the version V2 to the subject line
Links to V1:
	https://lore.kernel.org/all/20251117174315.367072-1-gulam.mohamed@oracle.com/
	https://lore.kernel.org/all/20251117174315.367072-2-gulam.mohamed@oracle.com/
---
 block/ioctl.c           | 2 ++
 block/partitions/core.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index a260e39e56a4..d25b84441237 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,6 +20,8 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	sector_t start, length;
 
+	if (disk->flags & GENHD_FL_NO_PART)
+		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 0d1fe2b42b85..7b5750db7eaf 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -463,11 +463,6 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		goto out;
 	}
 
-	if (disk->flags & GENHD_FL_NO_PART) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (partition_overlaps(disk, start, length, -1)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.47.3


