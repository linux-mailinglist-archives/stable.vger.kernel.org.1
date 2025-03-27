Return-Path: <stable+bounces-126901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0320A74161
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 00:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F91E170854
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03721E8357;
	Thu, 27 Mar 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WL0HObut"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F491E1E15;
	Thu, 27 Mar 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743116737; cv=none; b=fsxEq2c4kzYNoNdaBl0Gc++xARsexIQSXNq6Mo0qU3TfnvaqByb8bXhxteXMTblcfdlNUNmcim59f3Mx5RcXfEs3kGmeLg1BYXUsh9SKtToDx/cxykXWTksMCMesS1HnwYC19JIiLINBHuoTa/T0GA6SzZx33lnJYcsVBV38W4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743116737; c=relaxed/simple;
	bh=ggIfUmt++Gps7w847R6bruiw+olRtcsCE7lgRjB2zXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAVik+SKxy0GycnF2EtOU5REQld6mts3WV0V9dxypemzR8HxY0xrOXI5EeQaqNOXceTn2EaGNYKHac2lroFIRwH7cqwOB9++Ku2XDlHh8cSdrPT+T02jaGX/laSffgfMyJOShgNqRXgDjVQ6FdQRqB13rELcwoRqbZRvWCfoLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WL0HObut; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RLN0oJ013090;
	Thu, 27 Mar 2025 23:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=UZNdc
	xMN74AlQNruWe+u0F09HA6EMNNI+n9NhhuUgvs=; b=WL0HObutTVplwZfem+kQr
	5E9la55F6+M2Mvnj/JTENhuZAukr65fkiRwlI10PfpyaMF6++QYyt3G9WTI6fHYq
	7C9bn55DBmFJ27gxXwxfb9OJ5uvYKRhohyZTXqwPMNB/3dlKBYJ6wXc+QtoVE2BH
	D8Uxu9LzDSzPYBH6gBHYAeSmGPCygENAQ8qdfbirNzkhM0kb72JlQaNXgjKydCP9
	yH8E3KqN1BDHnSXNRN8BF6hOXYINC1CAYQCoz/flflf+2BESr2YnsvY086eei9KJ
	XYKDIrY6JJpBx1vIBjmrwEVbIv3QRi2cgNaYa3mOMpHLr75+ZcOHT8JmAQoNutuJ
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrwtev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 23:05:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RMVQKd022855;
	Thu, 27 Mar 2025 23:05:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcha7vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 23:05:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52RN5HQX033345;
	Thu, 27 Mar 2025 23:05:21 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45jjcha7sa-2;
	Thu, 27 Mar 2025 23:05:21 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] x86/microcode/AMD: Fix __apply_microcode_amd()'s return value
Date: Thu, 27 Mar 2025 19:05:02 -0400
Message-ID: <20250327230503.1850368-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250327230503.1850368-1-boris.ostrovsky@oracle.com>
References: <20250327230503.1850368-1-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270156
X-Proofpoint-GUID: LWhWlk-O0PiRPgVBLp7OFnKnh2kD7mr7
X-Proofpoint-ORIG-GUID: LWhWlk-O0PiRPgVBLp7OFnKnh2kD7mr7

When verify_sha256_digest() fails, __apply_microcode_amd() should propagate
the failure by returning false (and not -1 which is promoted to true)

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 138689b8e1d8..b61028cf5c8a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -600,7 +600,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 
 	if (!verify_sha256_digest(mc->hdr.patch_id, *cur_rev, (const u8 *)p_addr, psize))
-		return -1;
+		return false;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 
-- 
2.43.5


