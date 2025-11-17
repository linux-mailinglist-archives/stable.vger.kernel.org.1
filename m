Return-Path: <stable+bounces-195002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C2C65954
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D2924EAF95
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45690304975;
	Mon, 17 Nov 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUspSFQY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66C2C027A;
	Mon, 17 Nov 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401403; cv=none; b=bhx4t6jJ9ntQQGmiFto6leuFHHrlOpgejwuaiYxX6XsL0rOxq2JdDUzRZ87dBEppjiqbOoDXrwm4gzV4HiPsT+cZmO+XW+m9Sw7E2U+ZH748CIphF/S14+BYaLLaEbdEOXIx+oODwOG1wT2Tp2gS2GHWS9H1jxaMI2gttCGoZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401403; c=relaxed/simple;
	bh=Ikv2orSgXa+lRs4pEEEHhX+ZDTTEt4g3K5nGbPBDlgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWiaaBnazjBWSX6L/8aDTuH+YkW4liwMtZhxrAypGM+N/pgKNZt58nBlm3qbc3V85Dcbxcki7Kp00Wdev3Wt0Fs3nmWcrQB219PNthb4CldEdJayb6dIcYfyimxuPuxCeh4Lzjbol2w92gb/9IbTfvXeN0DkpXSWYkQQydUOwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUspSFQY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8LrJ005261;
	Mon, 17 Nov 2025 17:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mjyMv
	xBmHl03DJNBX7ilTYwYjd25CftVGAIOMgHYt0c=; b=YUspSFQY5Xo1XTwosprdv
	wwLEHfpL5GsZA+nJDDclyx6kjsDKNMZ5Gj/HXvBrg/0RGlnB/edEAC9isOJ3nN27
	wuB90+0nd+czTkcPsGxy0thc4o5QIuk6fgK0p70ZMkN/RHcKM3MKw9+xp/aoJXNI
	xNh5IwUaMTx4dFsAurn0G16vGzV9KUBoK/f2iwYaMnuoSSLL27gZruh2s61gTBef
	LhjR2R5RXdarHH3tc67WIek4Dj3MCVjcWNydFrS1f5Fopf+B3UAkJ3ofk6xSk1fB
	zEC2V8fUQt2Juap75ac6jPqo33zB8uXq+uYUwy7iDoBjBeSedf60sQS4fGMUyJn3
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbujxb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 17:43:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHHDdoW009433;
	Mon, 17 Nov 2025 17:43:16 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyc17eg-2;
	Mon, 17 Nov 2025 17:43:16 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] Revert "block: don't add or resize partition on the disk with GENHD_FL_NO_PART"
Date: Mon, 17 Nov 2025 17:43:15 +0000
Message-ID: <20251117174315.367072-2-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117174315.367072-1-gulam.mohamed@oracle.com>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4h145icuctEw
 +F236olxGsMJmCvThIWcP4yiMqVxYGUhUcrM6t8BmHNpJ08nrfWKjEp19vJxWkeNqpN384Y306G
 2Lyqjm4Vrxb28hQ75cp65pUjKmjx4I2D6tL2i1dexovV6aGBQIWuOMPSfiaKauX7CCTJdeGnRw5
 8ZmmDfTDupc6o6XFUgCLdAJVOEPKem4WknP+kAOThnNHAdedFBWWhasvmKnq1fAeDbSYUi4HRJH
 mIAyeo8P1aBBkRlgyNoA5+q7mIUkzjv9NU3FIKNYBIj8CK3Zx7ka1OWc1BdaFYnwscgWnRd2Giy
 WzWrH3d/3CtUUhqRIn0YRcdGBl64q3AtIcW2hwuGTUCrwHjwXdSmEpABtUoRoUTG8hjk+OJ4rLr
 czcgVlX/ZKfN5Hy7wW1CNaNypZqAF14BpGxf7HG07j9rLfEYFEg=
X-Proofpoint-GUID: O5zqdjqz9Q5sFVpkIA3Xqog9x8IEDvnE
X-Proofpoint-ORIG-GUID: O5zqdjqz9Q5sFVpkIA3Xqog9x8IEDvnE
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691b5eb5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=EQAZtT0oh2qUFc-cViwA:9 cc=ntf awl=host:13643

This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.

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


