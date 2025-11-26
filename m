Return-Path: <stable+bounces-196964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FAC88554
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10E633555C0
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DE315D40;
	Wed, 26 Nov 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RNP6cIv9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEB303C83;
	Wed, 26 Nov 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140351; cv=none; b=oQTTPa+1lTPo/ZeNsHf1TiJu7qgiVgNzNBixH2AN1XMnQqelrsT4RhcdQns7nhdrNYhDHjiAaORpZ/0a4Z7ikt8jhRLNYqlCbwW/siSHRemLbE+ygZNjN/+xg6gJKObWJRGXlnHubSKDOxQBnjMv2Pj+a0FnMdbJG2MhVlgQgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140351; c=relaxed/simple;
	bh=Ikv2orSgXa+lRs4pEEEHhX+ZDTTEt4g3K5nGbPBDlgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIYQKUwWPGImK5MDAUJz9PZ6p4EKwm1lqjon7P2TC9F8F8EYGbHlE94YFCjjrm9n4L4Rmm5lsXpDRs65XFEqit/X46l7mJ629QzL5nZGfebks1xxCnrPfUv2pJZSnDdK7t/p0LsFRkgq2Pzz0YnvwwI7s9jFSco/3Zj/kqzgIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RNP6cIv9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5umvF1544525;
	Wed, 26 Nov 2025 06:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mjyMv
	xBmHl03DJNBX7ilTYwYjd25CftVGAIOMgHYt0c=; b=RNP6cIv9VTilihMb1u8V0
	tT3Fw5GV+PX3St/Y8fHzXxEMGMGyPzEL34PCGlIS4TF2c0Wpqll5imW+oszKox6+
	l/lFRKOTvHBNdHvnPhulwuRhhg3FenEng4QQlLLwbxm95pBC60C9NIs/CmGK+HG+
	pPhau4s86bZ27B2CwzaTirWlRWMXWi3e3KHpjYlpJj9qjTZlrlDVHYcAMXfgKosA
	1sdR0ZNfLyXYk+eVF1nK/WofOERIHIDT5wOZEn1ovdeIXRAZt/RJdaG/G6tl7wp1
	iOPlJ4O7/ldDm3RRq9bhh4mdLo2+AGXOIdwXxIpNGMb7b0HrO+ViRbwe41TLIVun
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddjr90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 06:59:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ6u9Tq032787;
	Wed, 26 Nov 2025 06:59:03 GMT
Received: from gms-bm-13185-1.osdevelopmeniad.oraclevcn.com (gms-bm-13185-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3makgk8-2;
	Wed, 26 Nov 2025 06:59:03 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-kernel@vger.kernel.org, hch@lst.de
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition on the disk with GENHD_FL_NO_PART"
Date: Wed, 26 Nov 2025 06:59:01 +0000
Message-ID: <20251126065901.243156-2-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126065901.243156-1-gulam.mohamed@oracle.com>
References: <20251126065901.243156-1-gulam.mohamed@oracle.com>
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
X-Proofpoint-GUID: nYlTL8szelpeLZ-J9e7ks4UjFbbwQvzT
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6926a538 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=EQAZtT0oh2qUFc-cViwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA1NSBTYWx0ZWRfX+8aS7mSSfr8/
 dCDwN+FCFxYHI4MK2Ff3rtZh3gCVEU/px2rEIfRmN4tX4HymcKnBfUdCzqeWnCejx+j4DdG8HNK
 8rxmRPx1Dlvi1QobhukT3exj6mtn8S/N5koF8lfkyHn+21HFZoV2J+ZSoaL1A4JLva1B1Honsbx
 3Z/cu4+ZpmfR/aGfTN8GcFaVD5O/3+CBuTj0rQMGayJUoJXJPixI4yivxUGjSDJ8PzkgjvgABqB
 NyDn1WcQgrJKrKgSab6UU4qoauj3Qd6KISotZZ799MM8o9gSdfuR4Hep5Ah1zb0L19+czJnzih7
 ufSICm+M72i+9XePnjOlAdcHDnlP9cEbCwq+A7iAd2vFRFRIECx/wXbeEIhEjuWBPrH9nLLS33D
 f3Nq6T0cvlvM94gCs7eTSW4eEFZ6qg==
X-Proofpoint-ORIG-GUID: nYlTL8szelpeLZ-J9e7ks4UjFbbwQvzT

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


