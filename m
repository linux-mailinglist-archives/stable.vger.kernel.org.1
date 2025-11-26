Return-Path: <stable+bounces-196965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81DEC8855A
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833FA3B65AE
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9F314D35;
	Wed, 26 Nov 2025 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bRxmKfoO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FF3191A7;
	Wed, 26 Nov 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140355; cv=none; b=nI06cavO5asiPZSoOrg1aFNlRELScbWnY3U5+e3m1PmgjkyHbK3Ui2RUvqIrmFEUKK6K4SQggvSUHC1hKSjAFbOz+gGXnUwCERHTDKaG7pZcVdeE2Biu2sLu1v/RpfXAQFtotHqjA7WBq0ae4Ca3Hyg2semNiXAAoHjhRFiObTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140355; c=relaxed/simple;
	bh=gkVu4xUXE02VCNChrdPHs8V3rtrDNlocT3ebklEH1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/B8fifro0qVnLLw8MsJuEtous/Evs5iCGTp4oebjo0HsdPCpVv9f8DyIQChMwfh+TCwXXHirXjBxB1wJ5XE5Gq9gMSQPkunau03Ls9JsN8xzjZ3dZRhHfdHpI085TJyndddGwmJ2Gvzt29UHa5HBsnIRUyENZKRQAOhW1ghB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bRxmKfoO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5uvDB1586514;
	Wed, 26 Nov 2025 06:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=86Lc4AOt4FE+4KBUZdUgjm4tsvaT1
	Qvuzb8noyOvlbs=; b=bRxmKfoOswiSq/dPQ5MLUWgccLKbzA0hM+lKOV+0hm0AA
	ppJhxhukVhUIYoaCQEEkWWbJpbmJBQJOnwAKUQpZ88bYMjYcxNgyNxwnoC2J37xa
	lEIFVEglK3kEJ8abwHoumZxstry3nUbZJ2dx+/4Q9ZVSOpu9NUYzTZtVv3xM8Oqj
	ul3/GJmbOu17ttwO+hJ24wvoMUtnmU1TLlF5q1329tQIQSgTjKOms3DyGPl8IYa2
	gRshzPNU5w1jSR9J2Pay0EQ5Alp6khJ9kVwn09bHgzvKnDqBkeG3qCJ2ZuxEhP5g
	1FM31W8jQ7MYUCt+sZo27yq8uyNj3Gbnc3VLFJ8qQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycjnvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 06:59:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ6u9Tp032787;
	Wed, 26 Nov 2025 06:59:02 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3makgk8-1;
	Wed, 26 Nov 2025 06:59:02 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] Revert "block: Move checking GENHD_FL_NO_PART to bdev_add_partition()"
Date: Wed, 26 Nov 2025 06:59:00 +0000
Message-ID: <20251126065901.243156-1-gulam.mohamed@oracle.com>
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
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260055
X-Proofpoint-GUID: COIlknvoW9NX83Wf3Dak3FBzVnRptfU2
X-Proofpoint-ORIG-GUID: COIlknvoW9NX83Wf3Dak3FBzVnRptfU2
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=6926a537 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=El8LTbAtAdtaEuyw91sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA1NSBTYWx0ZWRfX1sDQbDWDSHCz
 1bxjXQz3GXMclEdYqZvHzUnBPIeIS0e4cx/hwz75fFUT07mzTofXm4VVf/zhcqOtL4wRjqRNqvj
 KBqKNbZTblbFWLVyH0fULO3Z/fU/yIrhJBdBwXmVUZ1RpByK7THKLDpFC9spUIcqPZva4rIB4Cq
 mippEBEMd2EOFW6h9WF0s9vXwElrSj9ZSpTJ0IiPJW/Jc6kExrWru6ovxiD/QrpeBaK995lxiJb
 2uKg7kcIBEWWKmKQBQRrXs0lamxZFbnw2BUX3sN9WhqrCyzjAZVJXQq9rJiee/TZ/r6q9eba5rc
 yu9CEdLthVTbgR82Jw35Qktgy97TbNf3E27UK742jpOtGKJsmeoG5IKtAYjbdHSHnmz4UhItuH3
 pmCE/FWaAJZfPX8ekyrkX81wVn4GGw==

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


