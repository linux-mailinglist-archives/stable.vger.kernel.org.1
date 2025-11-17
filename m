Return-Path: <stable+bounces-195003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB2C65936
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 283B729213
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AF309F1D;
	Mon, 17 Nov 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLYtDrHU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72C2C08B6;
	Mon, 17 Nov 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401403; cv=none; b=Iy+FF3HdvfifV1bQ1w72vYYfgqmZuGTvP7n//L+UplhoPBwJm4HzjutzOey8RJYmFxK+717uC2v+h/KryYbofiyduKQENfIjmPP+ly+s5OSiY+DFgG66fkkjP0ZRuaFlEjmcpm7u3czTxmlZD28bWhVdyJ4PjiFs7trqHkuMl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401403; c=relaxed/simple;
	bh=gkVu4xUXE02VCNChrdPHs8V3rtrDNlocT3ebklEH1w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4U00Pl6/08nDUTMGq+w182WFYIdmM8AVe60AyISKZd0biojDcB37lTJ7T9D5BCWdx0nPwZQLZ3P+/eprtxSS6qXyYzme8IqLsVD3UKpjpQpbJ/XiHHhd4GfKg8CaDFigjBoTJgTYpPjwScL+11rXACYjjIudIs38nb0awiX8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kLYtDrHU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8KkI002085;
	Mon, 17 Nov 2025 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=86Lc4AOt4FE+4KBUZdUgjm4tsvaT1
	Qvuzb8noyOvlbs=; b=kLYtDrHUu5CfVi/tTawC3LfmZw7Cn1xjv95jpTqHlbJhu
	jQk0X6xE6p3qq+66WLMrd6BjzL1HnXNVegZyUkrwmRJNEXq6fF6VQ94I9n/vZhLt
	R3xPnVVTQ5aCnTR4OKtHnmhAzqfkEyKLU+Tr54ojpOYM8pIzYU5hBd1MOHoFVAWq
	QeNalEqeURC8hrz4k/XxfZ4DA3W+kS/+oRvLNRBN4bjlaK0T6E6WMwE1jGRu0uTK
	TpGO4HHzMXSGLLX4sEu4ZBlepR4Hc3eGswdTkUcbiytBdADZYKjm12OhMsw8F6xp
	yO2ERCwZArUghQ5W4LK2+nUa6x1CgjQElawgvVr8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej962xp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 17:43:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHHDdoV009433;
	Mon, 17 Nov 2025 17:43:16 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyc17eg-1;
	Mon, 17 Nov 2025 17:43:16 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] Revert "block: Move checking GENHD_FL_NO_PART to bdev_add_partition()"
Date: Mon, 17 Nov 2025 17:43:14 +0000
Message-ID: <20251117174315.367072-1-gulam.mohamed@oracle.com>
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
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170150
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691b5eb5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=El8LTbAtAdtaEuyw91sA:9 cc=ntf awl=host:13643
X-Proofpoint-GUID: H0aHDNUePCdAV_HuzYxgEeOt_mwz3gEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1rRdxsdaZ2FE
 XVhpk23qe9LtULvWBOD/sXa63BQ6P0fXn20pryQEMZ1lksJsvevYci/JfYeLuS/BGzJuP1HQMyT
 vVIiTo7m0eY6asYruq59Z3EmE4Sz58vifeXRXKkUykgVLw2STdwnDRA6qhSSgbQECKcIwbTHnpf
 gQB6tCHpBbbekUhdRAq+oIDBoTN/vyRLfvekutSq40nc0wEOgsPzYGOrnsuyfQRA9ho/1DeqkyJ
 Wa7zbx27EWgzCdWjIONwui5HJto22fOI8HJVeZHpZ6ZnMHvNmYVbzqURKAZguWEQp0q7D3lYYpJ
 3Z+IW6K06enkwLKG8zuJ6gzXGSnNVnzXFouFu3R514cG6usO9MK5O5Kmwu9H9Dqbd+ZZ654gfq5
 olH9jrOcyY98R0jV45a4i/TZDTd39DkH6YJw10EzyUolufbJ5eI=
X-Proofpoint-ORIG-GUID: H0aHDNUePCdAV_HuzYxgEeOt_mwz3gEh

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


