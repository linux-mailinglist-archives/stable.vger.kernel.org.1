Return-Path: <stable+bounces-125950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DBA6E02B
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8069A3B257E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD18263F3E;
	Mon, 24 Mar 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2s1VdOym"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471443B1A4
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834976; cv=fail; b=fRONd6I1JYD0cZVg31/7gESCoKJGLHZ4P2/yGQOExylpy6WkQ1h4YS37rw9bJzryLe3zAzU/FA8qHWFI+FbyJD1u+dTtgej4j0v3RnJMeyn6dxVa1NQvgnk/HD4sDt+TJ4xlJQBtw2EOsaO0kz3kCCUxrGLHZ+s0x90iDU2aK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834976; c=relaxed/simple;
	bh=mvgNJqBS46DMmgo56XlFOFlIGTEeBfR2WeF2JREq4GM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ7f2QbjCunIYG4Q+hi+a9eMbey3Z22dK7e+UTKP57YFZt6wCcyxwxRwa6D1k89vOIF/8hCqZxfMasGA/vNi44vMy9UrbwR0A9pCA84cxzLdXrc5He44q9K89Cq3fce/U/hAHTNqaX8t5ELynRFlI4EHHKLBiyleBE6KVdyyIG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2s1VdOym; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKY26fO9W9PHUuJL3ys5ZdQzCLWsEK6CnLxn2OSRYdHoLLhgnlX+ZJNT84C8aUpMauHRb317cq4F6NNbasr4Lz5hOhqEwhMd/PRgBUBJPB7gK7DRXRhHFRS7jx/ukpXHMDtlgNyoXu80UQHCogIlLYoh6DIvUJS5BauZb1bpfuGFfAFq+Emy4Q8KWuUuJPk+zqghm63wZOMHSmAt1XzDjzgb7YiyTk3Jt3pgZ2JrccxDvd82fLxgv1OTLsvJMcgOKdk+XAbnyrFkmJRQ7L0AZcfJcmYL/LS8Wt4D6bynuywBOheDtewgsNSNe7gPMDOc9Z36NmGIKx2KMH6mMAN0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r+KMopXqZX0vHNaZnpOaXrdxTt+zyBHpj7CQ1tI56Y=;
 b=L2/4IpuT89YHKuN5uL5fIY+9vjZn3QTOv+C60bIOSZjbC8zLeQ6g/pIWd4V0clbVNpdYF1djONdTYsny3tKszYzfEEutdIrgILiaar0R48nvPc0WmwxVEgKNG3ZI4lRMc4f9rD+67ych/gWJRZ9YE3Vg+EI4WE8k4wPeTXYl/WZB9Q+ze78YWjuHxNcWwv7TXzRf0KwXCrOQr92PpDAFEYDAMhKP6VCIBGfyOrmGSVZJuioE29X/LIrNpkWq/xfAaefQ0kY1FcxuHM2WBWlA3o/PiVVguQjjoEViDBMWe2QGniJrNkTL0d/qPNz3/QZR8ZYYbQsgqA/fciUVet/MnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r+KMopXqZX0vHNaZnpOaXrdxTt+zyBHpj7CQ1tI56Y=;
 b=2s1VdOymvOfjjCnKG0kM57QycC7b3veUCFCgNFlQ/foPgsEqxBdp/MM0M36sgGNrgdcq3MdNsHdUh/MZ2Af4J6ft6/+cBK1UfuMI+p+hJmpkwhZb8e7ZA7tU0HpaGhD17saABSJm/3bdAkob3a8/3f3OCJVoqdv7u65j9VdWs0g=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:49:33 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::f7) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 16:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 16:49:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 11:49:29 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 24 Mar 2025 11:49:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <stable@vger.kernel.org>
CC: Martin Tsai <martin.tsai@amd.com>, Robin Chen <robin.chen@amd.com>,
	"Daniel Wheeler" <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: should support dmub hw lock on Replay
Date: Mon, 24 Mar 2025 12:49:29 -0400
Message-ID: <20250324164929.2622811-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025032457-occultist-maximum-38b6@gregkh>
References: <2025032457-occultist-maximum-38b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: ad934328-f981-4692-5a37-08dd6af3d8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQxUbtVkn4jt0rOgAs0fQaKNxtxZU4Z64ppH1b0VBGQ5/6Xp+eFmSyaApZk8?=
 =?us-ascii?Q?+EaRUxq+c7vb9KMndSHqmnTqt/NTlkhX2+DZrnByb2Ypi2dn2S5GOttaufql?=
 =?us-ascii?Q?tU06F1L5mjLY77oUyJWTEgSKflQ0CzxUFChP6BXDni9xPGF3j9XYERhoXoaW?=
 =?us-ascii?Q?ictdW3zYsFjBUrPMCh6ioQOv6kZ1RnlEF5Ch08sXc44+fqwuVdbVsxcFA7X2?=
 =?us-ascii?Q?+dC61j7gFcyNiLlb26OiMdq7NRTEI5/ZodqYZnySTFRgmGLVunE6ZxiEHjOq?=
 =?us-ascii?Q?evXlv/ninBdn87ex6wO6c5uoAp3fqsh7cjuxkJ4hDmsSa0/ZziaUum1Sr6F2?=
 =?us-ascii?Q?PAmlBmvXukTa0HcWJcnQPjiUvBMdVRfHQmoEA+NFU+InUV0gtN87UA7+ITZc?=
 =?us-ascii?Q?Q5hIhhbqWyoZdcpowuLh3tIbVz8onUxuAeMBJasPAbiev2OIQIgrzChefb5i?=
 =?us-ascii?Q?9V6eUnbc/Rd7q6Z39FfDCr+UuvZVZE/1wT7wJbj0XzBrST9RUPUu5UaCGQXA?=
 =?us-ascii?Q?rbZ3ZLxPr/fKYqxGjC0yijHVSZ6nVTCHhWEn865OVEMiBUG6xVczyf3bvHgK?=
 =?us-ascii?Q?UOAaw7jI0G35Q6hgY7xgxFlAwPb/e7lnqXMBeg+SHPHDz7d2JDVbLfKD7UAs?=
 =?us-ascii?Q?cGZK/Q4TReYfmYQ5d76V/Y4YXmfGouth/bFIb/772xqHqquEyVPlL24yAc8I?=
 =?us-ascii?Q?JM10GNjfgPfum0xROo+lb+pGPqhHctM+E8gOhD9Vrpj9rBLAeG/ZEyrYs9yt?=
 =?us-ascii?Q?xGT8epRL7dTUjmhS2cVYmVN7JXPR+1GRhxCS13pEDJyzIbM5k+X62ViJejr3?=
 =?us-ascii?Q?HqBjTW/PJcRiRAZAmjtLZatJ+zqu+6gAq8z6qIonhJOreErpe2QtqPkA3n6g?=
 =?us-ascii?Q?GH3AUVmyN6VC+aJ9Gbx/+z76OceosiHUUZkJNWttUsN4Pmniw2n0fxzPY4nc?=
 =?us-ascii?Q?CcWGESOA0ZMPKzXT50o1GKSGi6X60kMYukATIIgAUVhAHC9+VTRnwqJ4LxWz?=
 =?us-ascii?Q?cViiIDr1xb4nAkc4s3OBKK89039QZaX+xTKpLxxHK99GnaQ/wjZk50xZFNcu?=
 =?us-ascii?Q?DNP2VaGXXpp0eDfHhqH3C0z6Z3kMqnNcWrw2UeZ58cR4rXuzg4BDeER+ZdEC?=
 =?us-ascii?Q?F706F2RXCwbw7n+4RhDJliJr7RcLT/r8TFMO3X+pyGTzwqCYK7uIqnodgoiV?=
 =?us-ascii?Q?h0fuKHP8Ljh9IEM9BHSlJ/7Od07C/mfcBxOZR44Ky+0xr4CzxAM6GF60GYjp?=
 =?us-ascii?Q?lE4XrELyq3Cjkl3w1k0zQPqQqa2q9RZrkDeysrd6Ld9upsJw3v6t8v7IRCeG?=
 =?us-ascii?Q?EcscgynvvHNEK1woE2ieBM+teqYbgsm2maXymcGJ5/StZ/7ztFYVUBASobpi?=
 =?us-ascii?Q?c5hVf9JBSBwn8eGS4p+YHay4fKjtiIL089V2Af/9fVPY3fLwoyorUXrartQU?=
 =?us-ascii?Q?JiqlvG40kPqrkTw4h/farmcmt903nIhGwK1PaxZyVMmUMV1lbYv97qvBI1rr?=
 =?us-ascii?Q?vhc70faOP1ebeOI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:49:30.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad934328-f981-4692-5a37-08dd6af3d8bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

From: Martin Tsai <martin.tsai@amd.com>

[Why]
Without acquiring DMCUB hw lock, a race condition is caused with
Panel Replay feature, which will trigger a hang. Indicate that a
lock is necessary to prevent this when replay feature is enabled.

[How]
To allow dmub hw lock on Replay.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bfeefe6ea5f18cabb8fda55364079573804623f9)
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 6e2fce329d73..7407891286cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -69,6 +69,9 @@ bool should_use_dmub_lock(struct dc_link *link)
 	if (link->replay_settings.replay_feature_enabled)
 		return true;
 
+	if (link->replay_settings.replay_feature_enabled)
+		return true;
+
 	/* only use HW lock for PSR1 on single eDP */
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
 		struct dc_link *edp_links[MAX_NUM_EDP];
-- 
2.49.0


