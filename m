Return-Path: <stable+bounces-134526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C054CA931A3
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 07:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05954611FF
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 05:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B71214A90;
	Fri, 18 Apr 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n1aMFpG8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E51CF8B
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744955292; cv=none; b=Q7JWgYEH+y/jngnkMNB+KVwPZdHCpsAzzRx26psfEotfclSsBhcaMbEnYIApux+w+Q9rRM4dhpS8zq3jW52TbFwlqvQXzioY29x4CfZL8PjKHqPZdT+CAXDnNtcTaTTGSIJOdeCG6xcCenBVl3KsiF/QAw5mSp/Enad3q5q7nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744955292; c=relaxed/simple;
	bh=TipMqh+jY419M0FE6C4EHb3IMR85PPT/ksOHSlta85g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn9ho4ZHfsLwi3Iq4+X9IFtESRZTr4WdTTnVxHX1Na2Izs1Wd8NJgC6oUhc6HzYZvf+3inr9nViLUIiOxN7D6kOZecxaxq0kdr3K9W8hD1WRN2h3uOrz/aqopWQ2b6rOyX2FNnVrojKFjDgEz/xxRIJwOWY/o1UhEHCvhXBgKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n1aMFpG8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I5NcHN002787;
	Fri, 18 Apr 2025 05:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=+adpAbdYLs38FhIOhHdHbujyLz8AT
	wIWgf4obfGpmRM=; b=n1aMFpG8AJgT3AqY4fjpd+mJS3+7LE1CUienPM8CqMRHD
	glz/lSe6UtfzAo2UJ1EHYbkH215/48wka5AEORG9WJTx5+69TPrfUuwfmZUvzbV2
	egwPzgt0Q3HdYEB5LLvZtc/jSzpJx2eQGF8YVV1N0md/ILFDg/GLH6zfl/Hwy9ad
	4rwIG4vG9n59d1M+GIMdHVZ7OKc4PmtFtQOYl81q6IF/ntMq2MOCOLzCHHY2sKQH
	9uBRqkru2a2TFRy3ky9qcABzQSro+iNnGwMTTArD4Jp9NmyUekEk6bmAT7PVdb36
	rYfkYJS3kMVLmSjGjHT7wTy0Vt7fZi2vJ/Xz6Ne0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xyrhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 05:47:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53I5XBLs024756;
	Fri, 18 Apr 2025 05:47:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d54fy9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 05:47:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53I5lq6f036462;
	Fri, 18 Apr 2025 05:47:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d54fy32-1;
	Fri, 18 Apr 2025 05:47:52 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
Subject: [PATCH 5.15.y v2 0/1] Manual Backport of 099606a7b2d5 to 5.15
Date: Thu, 17 Apr 2025 22:47:25 -0700
Message-ID: <20250418054726.2442674-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504180041
X-Proofpoint-GUID: Mg-v3doRh43UKoQ1jKtAblkZyhHc9mAO
X-Proofpoint-ORIG-GUID: Mg-v3doRh43UKoQ1jKtAblkZyhHc9mAO

The patch 099606a7b2d5 didn't cleanly apply to 5.15 due to the
significant difference in codebases.

I've tried to manually bring it back to 5.15 via some minor conflict
resolution but also invoking the newly introduced API using inverted
logic as the conditional statements present in 5.15 are the opposite of
those in 6.1 xen/swiotlib.

Harshvardhan Jha (1):
  xen/swiotlb: relax alignment requirements

 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.1


