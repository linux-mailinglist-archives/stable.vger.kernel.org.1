Return-Path: <stable+bounces-176527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DFB38956
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4871895C12
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E42D73B0;
	Wed, 27 Aug 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lOUjqCoK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39464747F
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318545; cv=none; b=MqMD68gzfeCK/Xc5qLWykedfak26VCVLGw+WtZlE3q5hNlfx42J2y3mEBBIZf3ZIUt5oMKI6sGkNoxNv3RuthZLtN+Iq+atDTODTBrtM21DXpSTG1lKAp4kOPgo9oU1qxl3sSndnxs/5pkuyhXHK1Lt0ypC6r8VDysqM3KqEHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318545; c=relaxed/simple;
	bh=cjQMgr5N+xj0t3Mp1eB0hCx9k5GXfjvkfLBsnmxw4Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpQlg2ZaKejIiWhmd28GTGw+kNKJY45bPG5gXsaoCaiWxHXPIcAd1vT4I0F6JmyeRnsQHLYzqVE8kQhtV4Z/iO0F3kwLXelHvfbSk+omiKcWCgyK9K6qXpXhUYeC5KRXILU/vAQXkFC7Md3FhMqSSryYlKVyiR0ktq0tmoBzZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lOUjqCoK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHZ2wo004528;
	Wed, 27 Aug 2025 18:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=oeWOEee3N2Shr+uuoou1a7fSk5+Vo
	GRYn2S9CUM2YG0=; b=lOUjqCoKK6QdBFpEc6QRW6HGgCJxu3ApMlqzN9wElwT/X
	xXhGxJDDWyp4YHA2UQc5mnFDSNjkRMuSm4WvUXW6yqbLkBMoIU7iDasbhfnQ1XsT
	EfEW5jc/u09lrBVQ18izEJgPRteXfjVEopIljoseJyDo8/WK0sgWEV8SshU9M+sl
	h+d4sy12k8oekT55GPelskkr6sP+s+H6u2jOGEEm5W+F15JkousZ3fSTuv8XBbe3
	+ggKxxmgGMex54emk+BpqVnJfPi9dIS1+IsvohPYPk130TJKQV4BL2jdftV41oDk
	ecefUq0ujrkmmMMvjqh0467AZCjYgZCKoom8kD6kg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eq4ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH2YJC014695;
	Wed, 27 Aug 2025 18:15:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43ay061-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RIFWUO021299;
	Wed, 27 Aug 2025 18:15:32 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q43ay03r-1;
	Wed, 27 Aug 2025 18:15:32 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 5.15.y 0/2] Fix TSA CPUID management in KVM
Date: Wed, 27 Aug 2025 14:15:22 -0400
Message-ID: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=364
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270156
X-Proofpoint-GUID: y0nnl0WFc3NeQll2nNU5eb781nSkbGCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX9tbYqid6bPJG
 JAXV1gQ8hcGUiwX5zpKQ+CBPCggNlJ33EhV/hMwmSSYE9WVxm5GWG35T8MJXEM+rdm9pFLcwgBO
 0SV/A50P/6irQFN5Y822jfnv5gKfH0GiSBBblG25tHw7VGSrZ4/dB7Ov5oa6sDGRzysGiDD+Cpw
 AoUNRUShxy8RDVwpIBpgHjAh9+hMFz4ikQap0NbYub7ZNYqvsj2A3vaXCIxADlyImbu/0YrK6UR
 SP4JXvv8Tqq5+JKx02JSYhmBbgDwzlO1gO3obJ6en0aLB5v0A6i5U+NMm3Kj+UH4qEJy8AntFh5
 zLM29H/gNvM0arsrKX9prh04WlPz5L+OzgDNR5Rl5FvD1VaJ1rbx540FaGbPs0vpnzrTd01TDRX
 ucvLMEJL8+lsLpO5PDHZUXd+w9S04g==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68af4b46 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=r5FklIGwD0ZRyzmiJ1wA:9 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: y0nnl0WFc3NeQll2nNU5eb781nSkbGCG

Backport of AMD's TSA mitigation to 5.15 did not set CPUID bits that are
passed to a guest correctly (commit c334ae4a545a "KVM: SVM: Advertise
TSA CPUID bits to guests").

This series attempts to address this:
* The first patch from Kim allows us to properly use cpuid caps.
* The second patch is a combination of fixes to c334ae4a545a and f3f9deccfc68,
  which is stable-only patch to 6.12.y. (Not sure what to do with
  attribution)

Alternatively, we can opencode all of this (the way it's currently done in
__do_cpuid_func()'s 0x80000021 case) and do everything in a single patch.

Boris Ostrovsky (1):
  KVM: SVM:  Properly advertise TSA CPUID bits to guests

Kim Phillips (1):
  KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation
    code

 arch/x86/kvm/cpuid.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.43.5


