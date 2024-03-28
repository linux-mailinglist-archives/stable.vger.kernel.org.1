Return-Path: <stable+bounces-33046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDC88F700
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 06:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2EF1F26DAF
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D203FB8D;
	Thu, 28 Mar 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v8DoiVCS"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018315C0
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602659; cv=fail; b=G6RML5QlXmhPuaamRyLBBoNzCvdH3HCpdUp6voO9Gi3KB06fJDjTOQZPtrOKgnL9+h8kS6aT1MjPeA8IXpEz6oH4DMo56hs2SypZ2mmNqq5Vao/RpjRT3+67WWB3IkczG53pm2Un8hNVVg3TgjK8hKL5/BCEdH3Uw8e5rM/TD9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602659; c=relaxed/simple;
	bh=oJW0GczT4sXsmjZCrhrwYT8e0qfQeQ7bWp28xX6/JeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OD4cyBLH1OxDv9G1uPkzq0aQcL+GiFg3aYABcXWioIfRQ+LWWBLNPKKuLjnaCwF5JecN9EDJrISmPhQqcQt+Ze4NxbLjeI4OyKAtfUIwkaka7dz6exP7RA2+mAcLPoYR1jBmhL36rDWcmJfOekkYVRMn+AdqCCh3pXNiqV00MD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v8DoiVCS; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo/qvPPxFUa7jLxVRlBZF6pHNN/gXQRTSA4Sb38VEiCtbp4VbH4w6kepwoUoyOSep+Ke4FNLPgj7ULMrxKZaHTFgJPtCb024EMMyljiqqR4kgKKWCnEFlRc2vhqQBy40ahdS3l6ZaEFMP87AsY6rh3hFck+XfViOoDjfhD7pJfpMS997Av0rxjaA3jHc0JNxZzgZ4Kf1AsMfWhEBa5+lQDsDMxXX4i43DN2AI9mw5IBv4VJ4/lJ/rayn18V7Acy4e+J41jO2+wBY22zhAohGjcdjlc4siVSk+PzncYzEfU639zw1krDAcRCBWQw3M+E5Fb/vCt4S2GjFs4LCxN+5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVjEBLOlS2CwSI3OKwVT5+7mOoT79Zt1G5xS//aTaFU=;
 b=VTExxyX4g1mhL/d/LfakBcD0gZoUa6kFdMZxfp40n3tCjmssKqcdrz6wUxof4lkrlcO2ytY9qrlSswbzEwd5QAiViwyvqSt8O2+nL+ZKpj0nC0BOQJF+SYr5BytqKmSnd6QZy9b6MCa6mzRAazV49hCeCYBMHiYdT57gRPlgU3D7wmBniaBWupyYEVOg9C9x1fqBeMFOgBk35r1l3/8jWuYA2Vj/dLw3cGAuEz6TOS4cOKxepJMH8Amr7iZy2g4MGQEXRyZQx8rxmQGY0yNY+q6SPgSGuET4V7flYuUJzi9qiIqfY00FuMtHLDNQw2y25VO8gH2CN7oAuKSPSyE2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVjEBLOlS2CwSI3OKwVT5+7mOoT79Zt1G5xS//aTaFU=;
 b=v8DoiVCSQH67DrlhaU71louNWIUJgO2GX6QAxLcV6AogkjK+7I8mSnuMuFJnkPvgVDwQqxB/ddGGXzzpU54axAhSDgLaz5oLQGfu95CF9rcMYqn2/eJ9Jw3pG4zarZFe+RBPEeL9jth0jbm6sGf/O2kl+I1Am2RkBGivUH03tck=
Received: from PH8PR22CA0006.namprd22.prod.outlook.com (2603:10b6:510:2d1::10)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 05:10:55 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f4) by PH8PR22CA0006.outlook.office365.com
 (2603:10b6:510:2d1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 05:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 05:10:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 00:10:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
	<kevinyang.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdgpu: Reset dGPU if suspend got aborted
Date: Thu, 28 Mar 2024 10:40:36 +0530
Message-ID: <20240328051036.826751-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 32244ba6-0b8d-4407-6d14-08dc4ee5722e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zEcNmUd0uIgBACWfA+Tp2rLa73qFJuyy7KrnRcnCICxTn2M2vkzObaEYhDXwuqA96wKBQ2bp9zWBx5WV75dKEBFCgZWCqqFkVdsJrrq6ze24ztNe839K2xOw71jAybZovWSesu7GPxajzt6yAYKqDH3Ue/E7+d9Il4p3kKYDXqfTHdU2ozATsOs0h74reGCj1ZlZS7eze1fZCPYMI1M8i0pXCXFYXurCvb+jq00FWnV8ZJKLamk+BilyV1uPo5pl4/f2yEl+ugQz59eAyIcnWPhn1yKpB+o/dnOZ4tbxbps9mLSlI8e5eQefUUHtHmdJO6cTCf/LeTeLOI1tnmaeL1/bh2Ehchr3dU9wubG43xP44yggj7PPMM1G37trhPyARYVzqnurfEw8BKRprwToUDfZ99wWOYniy7W80HN2JDb8PEPN3onFtD2bsOeTnpTE7/JQUs+nCj5lXOKkWvsaFTyGkP6UGyjnvJmgicgwMJJ1SZF9lI9dqG+uAfMFkEusY8ryU3DQVbsIhGwQ1sG0YgRHo1Oxv3Pt4Wsx77ufwESBRKFMJzERQg7hy1WfD8ED6cB0IW23WWJ9IcGYOKYiaxzpeGQ8bcdhd4waRoDKk+E9T0B/DVFPSpVnnzGlgC7jSC1c1lU0VVPFbzsSWOlIHaXh9PxDqpYaL1BshlW/E9gDxEMad4gmbyX0Y9nJMHZHBpr2ZT40Ngw8lTl7yngKG+efzknnkAh6olHHYmjGzmR5MpooYsT3qN3prbaPkGgy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:10:54.9421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32244ba6-0b8d-4407-6d14-08dc4ee5722e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

For SOC21 ASICs, there is an issue in re-enabling PM features if a
suspend got aborted. In such cases, reset the device during resume
phase. This is a workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Cc: stable@vger.kernel.org
---
v2: Read TOS status only if required (Kevin).
    Refine log message.

v3: Add stable trees tag

 drivers/gpu/drm/amd/amdgpu/soc21.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 
-- 
2.25.1


