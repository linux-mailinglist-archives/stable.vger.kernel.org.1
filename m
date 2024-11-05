Return-Path: <stable+bounces-89848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6339BD107
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EE828452F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A414D719;
	Tue,  5 Nov 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CSdltS/7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2131824BD
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821851; cv=none; b=hEb+x513W9BOCScf+oB5TJA6DlbPo2YKtkRz/yAyvrB3ttBfIF4cYU/WYHbpQnBTi3E4usTmOyjyEBVACnuR/fX+rsmOciii/+S5OL3+E4aHxeU5O93HbEIPtiDSnekXpfATfBxFVhtWwPRXuG+m4ljluT99rvgjKcheCpWDXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821851; c=relaxed/simple;
	bh=bdB0oX0h/gL1dMbHpe6fwOFkNEuwo0TZrK6SvbzVSc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGxgu3GQnUkH4ij06oHlKkoggIzhNlY+wFaNCMsQDir5m5MbDC6EQriLch8M2ULUZ00WaO+IDKp5SbVajKDrX+zhp7guE0dUv4tJPxNmL2+tgB0BHp12UCyrzDQIdNPpIr2EhmtCfl9Du4vz/N13gvd/VKrsIuavmR2O9xUvpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CSdltS/7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiWZr029632;
	Tue, 5 Nov 2024 15:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=hDfvvmkn+WM4kzM140c1dzl4702BP
	VdljW2cm1N4eSw=; b=CSdltS/7+gdsTSoAypbrLFV03QA5xUYaDDnTYaPYATITR
	R1yeACKTDpmB6PBHR+L348XMY1rcOo0rcOXEre6Ii9ixu5bgYSAPSF7AoYA8I2br
	7GLDpuc9Rg+jxHYS4PBpIThdrlWmK/Z4no4jPNkYPtaqTUWUSnI9jNmx2r6Z+IcF
	D+umVcS9FHpGaHvzw5pMPlKvb0Ui7pWr8mD6RlZL/dnCIwKStJYhG4KlosG2R5al
	SS3Bl7r0TaP34B4a1lVnJGNdXZaTEVJ+G/0xvbL1h5bEcrJik8B6ymjr/WxH2LLl
	vO7EuZAUKaYQjH9oM25JPR0AoFkKFszFnHgIBiYxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4bwqs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:50:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EIeWQ036298;
	Tue, 5 Nov 2024 15:50:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahdkgjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:50:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A5Foi0I028682;
	Tue, 5 Nov 2024 15:50:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42nahdkghq-1;
	Tue, 05 Nov 2024 15:50:44 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/2] Backport fix of CVE-2024-47674 to 5.10
Date: Tue,  5 Nov 2024 07:50:40 -0800
Message-ID: <20241105155042.288813-1-harshvardhan.j.jha@oracle.com>
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
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=728 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411050122
X-Proofpoint-ORIG-GUID: EaGGQYXg6UZlXYZJOUwaZtBb0CwnH4OL
X-Proofpoint-GUID: EaGGQYXg6UZlXYZJOUwaZtBb0CwnH4OL

Following series is a backport of CVE-2024-47674 fix "mm: avoid leaving
partial pfn mappings around in error case" to 5.10.

This required an extra commit "mm: add remap_pfn_range_notrack" to make
both picks clean. The patchset shows no regression compared to 5.10.228
tag.

Christoph Hellwig (1):
  mm: add remap_pfn_range_notrack

Linus Torvalds (1):
  mm: avoid leaving partial pfn mappings around in error case

 include/linux/mm.h |  2 ++
 mm/memory.c        | 70 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 51 insertions(+), 21 deletions(-)

-- 
2.46.0


