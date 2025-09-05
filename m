Return-Path: <stable+bounces-177811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBEB455B0
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BD1A05391
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367A2C028F;
	Fri,  5 Sep 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+p1fdb6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD712341AC2
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070286; cv=none; b=RHdrg7UofejRGIH3RiYh/Lc5eiNKtOeniagF5WtBCEvNpeo/qnRapBfKPVLHYjC7uKkE+e8Ta4zDsac1K5Se80UVc0TCFUqw4fy1ANdVUm7AA5plUzvVlTLWUC/fehpzFuG4QKjjXnjJULwMdkbZzCeywdv+JsPhkiK3t2311Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070286; c=relaxed/simple;
	bh=UaVAF+c1FkQR8vcjJgQkyiW4zflrLDEBHHM0CgoI+ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5fGhgWivrwH2OF777yqoxwJzZCxExG7VsIi/Jd4x+44/UrX7cewbp30NTbkqFvXFKx+kK8MSL+2MZd0QmKmCMZsl8L9j9fLXZTIVu7WgEymYMzcYLoQGKgcVGU/43TRoJZgvtBM43AE+wgoZeo54gAP8iCMCHCNrkUq2Ma8E8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k+p1fdb6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B0OZO027144;
	Fri, 5 Sep 2025 11:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=50+Ol
	Tk+NFJObJ/BLezuPRHRbP9n3tkGthycmOZqCC4=; b=k+p1fdb62ANs5O9Cka9pa
	+T1UxpUquIGBMZ5tEWlMHmScRKz7/J49LNjYVYfwDaJZqbwYUxWeHDqbKFNsTKiQ
	Qd0dxhf/vTzPb318cJM/8XgeM0skRCg9gnknaKSsBgrNJJnxhtR2f/xpZModaYgb
	sw4s14YhnGQTgKOR5GLw84zyiHPZuWZZYmxVDhBHSNdOeNNnN3c/Lc/J0NX0LkY1
	aBadDT7k9Cn+KjxWjuRNcd/rDSUvmocLwONXroCgqmQb5tHx5AvcdtpvAcv6ZneX
	xMHAVgzwJBzA94mdtVvfTCfBN1vRqlvEKOBs+79j/JzPtoEgnLZv9LNXsQhltCyk
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxkg80b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859JafT019632;
	Fri, 5 Sep 2025 11:04:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqrk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49he030057;
	Fri, 5 Sep 2025 11:04:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-16;
	Fri, 05 Sep 2025 11:04:36 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Su Yue <glass.su@suse.com>,
        Heming Zhao <heming.zhao@suse.com>, Yu Kuai <yukuai3@huawei.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 15/15] md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb
Date: Fri,  5 Sep 2025 04:04:06 -0700
Message-ID: <20250905110406.3021567-16-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNyBTYWx0ZWRfX6wCC807KMyHi
 owi9lvcfQ9KRKs/lnuqCLOaSsf3wGNwxfVxkPVC7e3ALCgcNFyeG0usyouBrqCd41fqCOj2CfM8
 RIqSDMDKL2NXHrfQJgLEQxFm0fSuRxkIWTDZseTLFJHOUJUFhQdB0Q9eNSY1OObF79+iPigpv2y
 LWFkqf07UOmI8xMu2JRE3i4Fll44+QeyI7ljxa6Y2nBprFSQiUGklBw54mCuv/FUT8erhd272Ve
 Im/3uZL0KLFKY5F6jA3+9GvK0kOMUHbqKCyIL+hI4vQPNlYmgy8oB0imR3oTFkKMNl+I8KZXaYu
 XcX8GX4SeVLasCY8WEv0AjH1qudAxrSw+B8RURv3mjZfSRyIQdMyMlCDtB3jAnBe2i6tyJVLIta
 EAFLw4PW
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68bac3c6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=7I6SbOQ4DexET-j4rMwA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: p_EiVUlkcD-ALAzsTX0zt4k23DnwPwoh
X-Proofpoint-GUID: p_EiVUlkcD-ALAzsTX0zt4k23DnwPwoh

From: Su Yue <glass.su@suse.com>

[ Upstream commit 6130825f34d41718c98a9b1504a79a23e379701e ]

In clustermd, separate write-intent-bitmaps are used for each cluster
node:

0                    4k                     8k                    12k
-------------------------------------------------------------------
| idle                | md super            | bm super [0] + bits |
| bm bits[0, contd]   | bm super[1] + bits  | bm bits[1, contd]   |
| bm super[2] + bits  | bm bits [2, contd]  | bm super[3] + bits  |
| bm bits [3, contd]  |                     |                     |

So in node 1, pg_index in __write_sb_page() could equal to
bitmap->storage.file_pages. Then bitmap_limit will be calculated to
0. md_super_write() will be called with 0 size.
That means the first 4k sb area of node 1 will never be updated
through filemap_write_page().
This bug causes hang of mdadm/clustermd_tests/01r1_Grow_resize.

Here use (pg_index % bitmap->storage.file_pages) to make calculation
of bitmap_limit correct.

Fixes: ab99a87542f1 ("md/md-bitmap: fix writing non bitmap pages")
Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Link: https://lore.kernel.org/linux-raid/20250303033918.32136-1-glass.su@suse.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
(cherry picked from commit 6130825f34d41718c98a9b1504a79a23e379701e)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/md/md-bitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 0da1d0723f88..e7e1833ff04b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -426,8 +426,8 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	struct block_device *bdev;
 	struct mddev *mddev = bitmap->mddev;
 	struct bitmap_storage *store = &bitmap->storage;
-	unsigned int bitmap_limit = (bitmap->storage.file_pages - pg_index) <<
-		PAGE_SHIFT;
+	unsigned long num_pages = bitmap->storage.file_pages;
+	unsigned int bitmap_limit = (num_pages - pg_index % num_pages) << PAGE_SHIFT;
 	loff_t sboff, offset = mddev->bitmap_info.offset;
 	sector_t ps = pg_index * PAGE_SIZE / SECTOR_SIZE;
 	unsigned int size = PAGE_SIZE;
@@ -436,7 +436,7 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 
 	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
 	/* we compare length (page numbers), not page offset. */
-	if ((pg_index - store->sb_index) == store->file_pages - 1) {
+	if ((pg_index - store->sb_index) == num_pages - 1) {
 		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
 
 		if (last_page_size == 0)
-- 
2.50.1


