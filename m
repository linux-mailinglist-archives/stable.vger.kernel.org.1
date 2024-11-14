Return-Path: <stable+bounces-93021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB49C8F28
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D85B28652
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9114A611;
	Thu, 14 Nov 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCCiujrf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8818CC00
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598498; cv=none; b=UixIz+HrpvxOSEtrckAZ5sGIshn6ZIKmTydcPof8xfhbfVIN1sOAhE0sROV7YnCvZPlwTfL34FUmo0ttDIJUbMo9PX/APBhvP7aTtlLqrltVthRuQyFw3nhd6vIbk6UTyvoPnpQW34hcpVlWWI8FJYOFpjiEqd8DsfjnfPtEsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598498; c=relaxed/simple;
	bh=K8cBc9ds5SrFoPNl5bVuFwjaYlrpu8fKbXKv0jHZL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6PXNnVK5ygKfushsEStefBr1PnscyNd6U0s6inFRV4NEjCNsHdtcE4HbLoHBcM+23ff2aKMXgdGz3hYZwJSCP62B9N0ArKmey0uPoHzWDOZUmJ/2lU8pyQU+Ym82zg1tqd1hht2qD9CQLTihmYzlbO3zIL/xGsRaV34wtjpddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TCCiujrf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED1YIZ018624;
	Thu, 14 Nov 2024 15:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=V4POlso7qon3V5R85x0vpB695S+qB
	bWIxEEp7Dy+f9k=; b=TCCiujrfszDxljKGEpXcjwxZ/sWhQs1sMz1Z/Qz03UuHY
	UP0ZVLSskwAuNJ7dv5/zYwkWX7PfMAFJ8CUfpNu8jETa3g2DOkVhTHtC9NyV+gAf
	t1oA8VfTLh3MQWOuBwIRpDGOd1biAnnoVBOSayf6N3eYFQLPx3PVZqd5zpqFjm33
	C5FZGxdNCS0/M0qfHIrnlv0XrjEiGh72PwzIWZmZ9tbposGvjChtPvBrNFzPofPr
	dQX5aW5YidOoxszicH7ZHIAhIyLTCCersw5S2Sp2EooJ/9wJrTqjM42lDjHEoVnu
	YpdbHIp69RvscSBbvF03vvTYZRXQetaVNh1RRbH3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc1ku2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEKDUp001352;
	Thu, 14 Nov 2024 15:34:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bayxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFXvht031217;
	Thu, 14 Nov 2024 15:34:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6baywk-1;
	Thu, 14 Nov 2024 15:34:44 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.4.y 0/4] Backport fix of CVE-2024-47674 to 5.10
Date: Thu, 14 Nov 2024 07:34:39 -0800
Message-ID: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=800 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140121
X-Proofpoint-GUID: S38BDmG7s67f8iBJ6Fu5brGd0l2An_mW
X-Proofpoint-ORIG-GUID: S38BDmG7s67f8iBJ6Fu5brGd0l2An_mW

Following series is a backport of CVE-2024-47674 fix "mm: avoid leaving
partial pfn mappings around in error case" to 5.10.

This required 3 extra commits to make sure all picks were clean. The
patchset shows no regression compared to v5.4.285 tag.

Alex Zhang (1):
  mm/memory.c: make remap_pfn_range() reject unaligned addr

Christoph Hellwig (1):
  mm: add remap_pfn_range_notrack

WANG Wenhu (1):
  mm: clarify a confusing comment for remap_pfn_range()

chenqiwu (1):
  mm: fix ambiguous comments for better code readability

 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  4 +--
 mm/memory.c              | 54 +++++++++++++++++++++++++---------------
 3 files changed, 38 insertions(+), 22 deletions(-)

-- 
2.46.0


