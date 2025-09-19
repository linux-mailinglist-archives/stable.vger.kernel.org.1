Return-Path: <stable+bounces-180680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65140B8AC5D
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9FA1CC5364
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5532253E;
	Fri, 19 Sep 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lT7V67nx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EF3D6F
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303223; cv=none; b=hCa3b9yU8D9OeCIxztGTnYAesWMjhd/OzyGMRX86oCetPcbbYEyjx/Qm4XuQIg29GuTv9IyuqfZeUslApTqh9zZJKxhE8vYj6686gilq78uAg6HJbSIGmjJZg4jDTZiiQvRGtDCxuxx/aLhN6/fsMk6AiPtY71GKGcARWc68Tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303223; c=relaxed/simple;
	bh=hQkGeGSU5dENHIBAgWxHjV/TQ5W7q1BBUOxQ1zNFYHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/YHnIwXeGqgAYBWOkeXw6NVSQv/0ueidK0uvDh0TyP1vt+Fq4ENFuj2lRJNGBvItN+9HFIzWrK1Rrzqe1uWDWKkK068YQpEdKNzzSBDcr6wo/uoIxGN0Dl0XZDmZ/QRk0IqCRlAxWp2vcPoIZNrimsP26jexSCPt+39v/vOjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lT7V67nx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDto7D015791;
	Fri, 19 Sep 2025 17:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WbWN9
	yBJVDv7fSgOLiXRIYuDXQ9VSOrOBCWRfRSpujY=; b=lT7V67nx3fMbcFllrdeCa
	SMo77kOHzf6vycUqtxH4FqMTGWGAKYuS/SmRB/BV/lT0fHxqmpehyFW1U0qQNvYI
	T6WO5vk1i3IMuKOHd4uXCSYXWTRlH/X3GtI+WTb7/wUKYrgHw5BlpsUl4+qEfv0w
	tOzlPRH9FuPvAIgC9bhRhrDx6WPn52SnL0ajV0N10hwY95gwJmhKaSfX4+yZILhU
	0Jo7akLOwV+mzCEZsClHSaPapU7IeruDIxgIfnXBvMMArLuKxZLXsPqvm4qf4HZH
	/d+HxwQnmckaU2j8ykZeJwM5lMPYfRp4kxvGJq/jKGmnvdL9gxLKpjgpGmm6G2+K
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx960m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGrHl0001464;
	Fri, 19 Sep 2025 17:33:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gy14g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JHXUuf001465;
	Fri, 19 Sep 2025 17:33:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 494y2gy0w9-2;
	Fri, 19 Sep 2025 17:33:32 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ankur.a.arora@oracle.com,
        boris.ostrovsky@oracle.com, bp@alien8.de, darren.kenny@oracle.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 1/3] x86/bugs: Add SRSO_USER_KERNEL_NO support
Date: Fri, 19 Sep 2025 10:32:58 -0700
Message-ID: <20250919173300.2508056-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
References: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190164
X-Proofpoint-ORIG-GUID: c0BILaM7Nxw6WhTWvDrizhBwyS9SFHFq
X-Proofpoint-GUID: c0BILaM7Nxw6WhTWvDrizhBwyS9SFHFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0J/UzXFzYk53
 7epbIo4qAPqnGHHhAfC2qHX2PJM1GZMfFXp5SldIQs3XgRRloXsQWG33ae5MPTMz+FZR2851aHc
 zrlqVcPZ3VGTm8vFMjar54Tx1R58lK9CDWRF3+VYQgrfiotoR7S08p8KLrbvMZHOtSpAocUHnQr
 rojwDr71iai6uyQJfnLNGc6PZvwvjRUKd338DfFuXDuOOtZQo52b5YiHlqJIAVkgwO+YlcLiRCY
 im56BoxZ0tJbUJNi9O4mrUASpUSoaeE5PUAWaeGmlsUCHgl4PzeAYt4ltn4XqlnNvfVJEwXGaHX
 WUyNa52bZ5oDApyYYj+DsOoJFjQe5kTCuuLZpIBe99uGPlCx3kKF6J/XYRN1JDWkKK/tuPenibY
 Sgtf1Jxe
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cd93ee cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
 a=DRKTPbcrGwltoMcJ7Q4A:9 a=WzC6qhA0u3u7Ye7llzcV:22

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit 877818802c3e970f67ccb53012facc78bef5f97a ]

If the machine has:

  CPUID Fn8000_0021_EAX[30] (SRSO_USER_KERNEL_NO) -- If this bit is 1,
  it indicates the CPU is not subject to the SRSO vulnerability across
  user/kernel boundaries.

have it fall back to IBPB on VMEXIT only, in the case it is going to run
VMs:

  Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20241202120416.6054-2-bp@kernel.org
(cherry picked from commit 877818802c3e970f67ccb53012facc78bef5f97a)
[Harshit: Conflicts resolved as this commit: 7c62c442b6eb ("x86/vmscape:
Enumerate VMSCAPE bug") has been applied already to 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/bugs.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 90f1f2f9d314..3fc47f25cafc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -464,6 +464,7 @@
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
+#define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 06bbc297c26c..c3ea29efe26f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2810,6 +2810,9 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_SAFE_RET:
+		if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
+			goto ibpb_on_vmexit;
+
 		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			/*
 			 * Enable the return thunk for generated code
@@ -2861,6 +2864,7 @@ static void __init srso_select_mitigation(void)
 		}
 		break;
 
+ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
-- 
2.50.1


