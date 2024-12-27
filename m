Return-Path: <stable+bounces-106189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A299FD163
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 08:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F0D163C44
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063D142E9F;
	Fri, 27 Dec 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bYrHWjEn"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A2AD21
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285047; cv=fail; b=AQbnyWxx++6saJEJtoleLQoFwoHP1DLrNT8OYfx2hOIDExChpgyQFIef20ybFDg/U68f0jstU3HkexjZTgMJb2jS2mAp0/rEamZnjUM9bZ98Twgoo/7ahykCv4igqblg2DHoXGWIqwNnDifl+4Uo4/zITt/0ux8ZzSO56aoRFO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285047; c=relaxed/simple;
	bh=nU5qqyU2kL3aLrc1bpf7W3fVxlg8gjub8t7DXGNlr30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1NgLa5buf8O4XsGydkSSMmZPRfnPkNU36UaqTYhfGEO23Qu3MUTMLsZ1g4apsTpURo/fmVYOpcEKpLW8kB8rhtoIMyI3nY8vbqgFEJ1yJ5hYXHo843EEaQwa+UHAZ9QYRY2/32dGZwRWBU56KKqJ0aPhBlnskIKW37pK6XhMjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bYrHWjEn; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7wphCU2BRLj9CE6dlcK5z/HVu4BlLESUjpDzoMbCUsnxkBhV1rUA60aRYsTlTXpTpdvOHErIxIPhK7cRoUtap/2NncbOfkn4MpZXxElxuBlIMqIE1SZNAtHqeL3I0zYibOhDsZ6hw32lb4E9o21HbKbXfW3oQ6UqZsLw4fmyCZvpBtxTrmnQqa+v9ah+sDXic2833YnhEzTswEogO7wxQTCNzKrK3jBzV1Ew/SmzH8c7GBu6xpUYGuuRWTuENpM0u1MFKsbj2QG6klipJBSO7zRDKCmYqfffOmV/yhNHKEn8c9RoTI6paufpwu1B2lMgwOESW3E4Uv6PAFXnjd+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT34deAQ8z5gmM78rckn2dmIJatPmmi58qlII01+Bf0=;
 b=pABEfwCGspX8mO02pXueG77bqq+bOdLcaUXxMgHVmPKXmeG1NHkgZhanfr7yHymQKgwH/SxRIqkFv6/cfGxbPVOKF1qtX7sHD6SRxKXZ4d2hRvJ9dD8OMHWSuDi9de3FI/uGnvEwVFHuh9yUnDQS1nwZ9ZVdkuxEdNNf9IAvFmOK1iLyXAZbVDLxxdrVSXVC7ObeYgU7MG45Smz6Xk1KVaKqrAaMwoUf6XlHHOhHqjEtCDwj0JZsB24d8o8pHkNjz9283mJa54DxUfQOf1BMbJZU88bbRsGbHEtqFhwCn1VONWYqfDUMOlRVY+yDxtq+U5GbeWjrZuxMQaNtuOtJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT34deAQ8z5gmM78rckn2dmIJatPmmi58qlII01+Bf0=;
 b=bYrHWjEnehWWn7iFfysLtbxEGgLgPqPJOQ++8+vIDoAVukCJyuuZRsbULCD5bH9FNgsuP6I6ugAfKdAyXfwCF1SQml7RsCmGJSSclsHkeePe8QYxKwYm3N2reDMGACqQHnOcuftfUabwss4d96n4kydG40Qn5R4pYDMe0Qg4Orc=
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 07:37:19 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::42) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Fri,
 27 Dec 2024 07:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Fri, 27 Dec 2024 07:37:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Dec
 2024 01:37:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Date: Fri, 27 Dec 2024 02:37:00 -0500
Message-ID: <20241227073700.3102801-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: b11ed92a-0748-4a2a-081d-08dd26494b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4zP0h6Lo3o4jwigRuukDSFLE2th5mJPfz2hyfz+KNHdI0FLQrJ6VJHju6O6?=
 =?us-ascii?Q?oJSg1E7mk/PPyuv/26xFmf6+XhfEMO7VISbitTbcB9ZEADYEyTofDuK6E+OI?=
 =?us-ascii?Q?TI8OWg/tujfgMYSdV/YRpaAUPdDk+d6GqbrfVLgRK6MPZI1qQLmti8J2hfbZ?=
 =?us-ascii?Q?pVA3vMIV1+6ZBWBc2OSXLALNcOIbA9r/UKz3g3WLb8Z5L+na2T+UWlvr2rkH?=
 =?us-ascii?Q?g4QP5q3Vd7c5AhUj5O/oABXLqTRKCym2AJRimTriwoBqCKJyl1TJMcCV06y4?=
 =?us-ascii?Q?1b5bYCI8U/yM2XFJ10PqRYBj/K3xo8fD+y14O8FT5/dhY5ewlHpd4TLBrP6s?=
 =?us-ascii?Q?LIeTsSaUcue/fTRms4fB5GtA3kiz8mbYkQFuYUmASgwc8WL7aI0UNCDcEkfp?=
 =?us-ascii?Q?kys2QVnPZUCwoSztwjeQNJIsnXnx2ObwjWAnyOeRUaRNqTgyBCN5Y/G9ONEp?=
 =?us-ascii?Q?mF9pRehiDKJ8I4FSw7ToRZ+CvGZbfoQUOZzLt8hNkH+66hmrCM7RRWiFKhjN?=
 =?us-ascii?Q?zOHIKwTaReaa5SMxEVH1u9uGM4BWQG4a0ZvLvdvnb4Vi7cjakpUpVTGXJueO?=
 =?us-ascii?Q?qu0oWM3KFBvZMqGxje4QvcCrSCwGK/m6UkGYNQgFaFCR4unTaQqF4NBRh4ta?=
 =?us-ascii?Q?6PLOJhEOM7y/25jTxfPqtrSb/714zGuPGWYon1hRBZbu6CYupvYgNra6/OUe?=
 =?us-ascii?Q?hGWLbWuj2WAb8s1C/V1wSk9WSU+3d5nsDu+Vt2D76790PYKxvEga6RcuuS1F?=
 =?us-ascii?Q?yUaOeBKvOotByCLcTAlqMz+D4IDGUVmKpfWUxTURhhvVl4wcLjvLDJhY1pg1?=
 =?us-ascii?Q?bgnRYM90i+Ps7iK9dkehUfFYg4KkCc7vqgpfyn9+pfEcYyNHcU7U5TReu1Hh?=
 =?us-ascii?Q?P0sTX/FV1Gzh0Ib8IHQhrSMcRL8kgBs4j+OL9B63bae0WV3xKsTF96s4YkPK?=
 =?us-ascii?Q?igiJ3CBCjBHqFlCfwIep7GHzVB6G4rnAEE+g1lC5ui7StFV/4EOx2t7ehpw4?=
 =?us-ascii?Q?6p+/TU2VgwKPEOKdzLJHsPumoQX4g2HrFDGasp33Sux/2KszkBWEUNYrE+W2?=
 =?us-ascii?Q?5cEqjYTqcMrtSci6N5V9UyQ8dzt2054UCARV/o5FbO3v9uM7ngsrERXba9Rb?=
 =?us-ascii?Q?mRXYKtVYjAzjcGwIfJ+3Y8+QpfQdlkG9KU5dPMrc2XcVajdOsdfqwLA+RT7q?=
 =?us-ascii?Q?kxKHRAU5CDVQDtOwzpmrcTu/B6EYXg2TxljZVWQJPq1it6oNCoqErFqj00TV?=
 =?us-ascii?Q?GjqD1QVpC9enxCVd1Z/vkgGubtx3YjHzdYkhiyGN2wQBMgl9BVKkJtQm56ox?=
 =?us-ascii?Q?hCGN6ge1lm5zG1nDxpSegKoBM9PbhG1IVJsJ2kZuGsFzRV9yCL6EaJKOGTu7?=
 =?us-ascii?Q?cVmIS7sw4+bZjBO7INCDsKW2FQMwCogP2w582qWhxGtNesbvz4pOXZpS/L0Z?=
 =?us-ascii?Q?HZH+MEozMr4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 07:37:19.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11ed92a-0748-4a2a-081d-08dd26494b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217

Commit 73dae652dcac ("drm/amdgpu: rework resume handling for display (v2)")
missed a small code change when it was backported resulting in an automatic
backlight control breakage.  Fix the backport.

Note that this patch is not in Linus' tree as it is not required there;
the bug was introduced in the backport.

Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for display (v2)")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.11.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 51904906545e..45e28726e148 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3721,8 +3721,12 @@ static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
 			r = adev->ip_blocks[i].version->funcs->resume(adev);
-			if (r)
+			if (r) {
+				DRM_ERROR("resume of IP block <%s> failed %d\n",
+					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
+			}
+			adev->ip_blocks[i].status.hw = true;
 		}
 	}
 
-- 
2.47.1


