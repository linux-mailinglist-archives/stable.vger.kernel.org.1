Return-Path: <stable+bounces-197047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F6C8B5A8
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D81FE34D6FC
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13F224891;
	Wed, 26 Nov 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pCfpDLU5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0F212FB9;
	Wed, 26 Nov 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179666; cv=none; b=PNkL9DUJZKf31TXaz95PodANZG41Vdw1geeyAznt2GQmTzxgASzoJdg6Kid/s+MdnwQV9BgWUpg/2cK3Q/i/RvWa7D7t+Grr8UC2nx0osfhbM/2CCluaEwNYtiJdK9shk24eEHXRopRJjgqx6BOaFyK02kigTGeokFMx87JG4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179666; c=relaxed/simple;
	bh=dPQrYAd0yaGmFpABNl0IGhRPgxDlv64yTFrSiGw4j4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFKr7IsBtBKeTU4t8UHpAQZ+fkST2pwA1I4k9ibRGgqW1NZ38HW7VT4Dxo8i9pHxsyuFYyyysUoaZnjK7SsbiBDBiPTirZpS4jR0rXx84cA5iTVXKLvjZ8nMjqjGlZAe6LgoUQYiLNG3J/1OJqqxfcdq2Pn++LkOg1SAdMRUFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pCfpDLU5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQGGeLN2650875;
	Wed, 26 Nov 2025 17:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4f+MY
	tCuLUFz6+FVDmNHH1Y3y58PE9DAT+nWWrqODxo=; b=pCfpDLU5hoF2eA2BBUrlC
	dMaMcvqXcBqBJSwI8jwrAyxYPa/C0Ft7hlzJ771yeZyhdx3oj7Og8NBY5VPbcQXE
	mCi3HCKzLjBpgdWVJ856mS0omukHAVNgF8PQKlKhe0iJTvd/Pa2NwF2v9zA0A+lj
	ZR9eYbpGeMuspuGqu+WgvVQboy5nsAZqcocGPbQJAghlMgNDzBYTh8faFw1dJKOe
	eDOE2TRvhRO4Ku4iZcCkkGoRWmjCftwAIcO5BQgQwXFdL3i7VLQG9GiPkvBDHCbp
	PHfqyklrIFH3eE8QO+2bklE8OwhvRW+4OYG1a0h1f2RfdTeJ5Ae/9h07FD6nh2Ie
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhvyhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:54:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQGJOUG033001;
	Wed, 26 Nov 2025 17:54:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb9x0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 17:54:18 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AQHsGi3028620;
	Wed, 26 Nov 2025 17:54:17 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3mb9wxw-2;
	Wed, 26 Nov 2025 17:54:17 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org, gulam.mohamed@oracle.com
Subject: [PATCH V2 5.15.y 2/2] Revert "block: don't add or resize partition on the disk with GENHD_FL_NO_PART"
Date: Wed, 26 Nov 2025 17:54:15 +0000
Message-ID: <20251126175415.259906-2-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126175415.259906-1-gulam.mohamed@oracle.com>
References: <20251126175415.259906-1-gulam.mohamed@oracle.com>
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
 a=LbKDhlQmydB64s-nk6QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0NiBTYWx0ZWRfX9p1yis5P43VK
 HiLLheyI2A9teFMVZqThH9ZY7Oelp+KjO96dBgpNCye8eq7VJiP+MDWhK4dUw2cJ9IG9JfgS1YF
 XbolWNkrQp2KSj4E29dDuFUDqLIKWl4kwnsnXxYAbTSeZh0t/xEW+TzmcDqrTwr3UQTl04fxPo8
 KaVjrnhi8iM88UALrdSE0HBN/LtjBPfTdJF1kY4d3M/UjAs9gKgkdS2sIB5dtiQiwZT5USsaNvM
 N8pIZsLT2ceQ+cS+rVB1Mj7kAfl3iHX4cv8lYnDfKdH6lgollz5JcWXUGFRPbPit0m9jxYw1Rhf
 XJvCpSrAjWnarF8mWApO3pVA+p6zGdtkGRWTMHttG/AwU5I1fHrKM4bcWKca9fQxcLnsPUr/w7J
 iUU4qZVcgL9/9YnH/pCzxabtdqFqbw==
X-Proofpoint-ORIG-GUID: kF4GXjUUfVo5SRv_XX42hvE9_rjXP0HV
X-Proofpoint-GUID: kF4GXjUUfVo5SRv_XX42hvE9_rjXP0HV

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
Changes in V2:
- Added,in the second patch, the reason for reverting the patch
- Added the linux stable version 5.15.y to the subject line
- Added the version V2 to the subject line
Links to V1:
        https://lore.kernel.org/all/20251117174315.367072-1-gulam.mohamed@oracle.com/
        https://lore.kernel.org/all/20251117174315.367072-2-gulam.mohamed@oracle.com/
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


