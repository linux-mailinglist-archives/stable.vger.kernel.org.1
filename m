Return-Path: <stable+bounces-118628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03418A3FE66
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78564441693
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557A250C02;
	Fri, 21 Feb 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qx8PEsR4"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1A2512C3
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161387; cv=fail; b=X+aNONKtWS+58pRWFBnA1YFHB1aQMVXHu7VdQq0SqfvtSIckrAjg8ot63827c4uXJY2rqWFqWrau2rFW4ah1nL0a9HSXzowOynDcSVhJoIoRZgpSzZwPcMLK7A/+krzqOAi09KwhbUHJL2qGs/LlpdUCpJJ6vVqcz9wEHGcGMX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161387; c=relaxed/simple;
	bh=JbqnKCQShGrxTyMdVrLVVZYvw6E0J/843RmIXZS6nIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzM74cLW+kvhixD1vfsnkrXgO2PRjLo5Q7lh6NrVtop3BPimlL2uMArKOl8biinWFnD9+4amhlt6CWGJIuw+X6d9WKDRxpuWm654RPdPBc001LQmVasNsiszBT1l5T7aFIrED81IcdAN2bx87aXmVB/uTaq3GNZ+EYMi1BNhzz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qx8PEsR4; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=malOSj1DnGTx8VFlE8vIJCYFNZlBR5TyUo7t6qZPMBgxnnw84hBc1BgQ3epSsV118A7bmWwbmEVFqpiUaXf8EuzbGmPKaF8EASaE/vGqNrueSBYrHZ33VUJ7UYuej8+hZWDV014VXggs1MzzTuMDSUG4joib1uKjUQ6co8cjieT6mLp6Fbo1Rw6vFk+9PG4cUnPdxxc6g5ER1RhL8A3+BST04XX1aGKtt9gPfQJgi6jOwc3DEgUy2LaGr5njqQXHfOLcC70nbf2Waf4c0M5cAfnEPrrT8OM0qN5ccPlj26VKOw7ulLrVjbbfSGOSiFlQKI6BA++5DCRgEr2gyGn9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXfcyjb3Hr/SK9ASERusXynoGKzhaFpg0sSEKz3SaK0=;
 b=HMhKMO43VVBOia7/vRO+ODGwcWkgkmmseA2c9+gEezzsWwudWXk9lbWPym2VXZ1uHHGiEMZOHGcoFuI4u8bSiQvTRhevYR6xLCC0cZgC/7bHirmILWuzpeqnb8iIZ6lXRrPInP97urC52sTiLP0SVSAGO9MZKuQSv8Or+3lbLpy3shZ2C8Z3v+mwQl/7vASd7gz/FNEEwVRo2xgZ+ii3BTDdj3U1iWGzMSuFAtc3mpH9xvFFjYWsrvghDUj72Wx5a3ZHV9W2dpHGTxVO+NhKsUZL92cGrq/Orw1S8p/LRrNKMQbYpjt+cI5Pmg4hGh4jhzdY6g/YknQdsLa3HJgvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXfcyjb3Hr/SK9ASERusXynoGKzhaFpg0sSEKz3SaK0=;
 b=qx8PEsR4etF9Ifi669OH1SsQ27Q8THlU0Q/IFT5Zsj1SKfQ8U/TJ7PK4bdoSgiaHCwjW25wc/dRtNhMC/59RFxloSZPriuMX2HdfJuqsoc6KNV7GT49b/s98QEpvDoK+cK0Ilsjbfra/GPQWrzoSiQpH99J/zOjhbH1b3HCPL3g=
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 18:09:42 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ac) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 18:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 18:09:41 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 12:09:40 -0600
From: Lancelot SIX <lancelot.six@amd.com>
To: <stable@vger.kernel.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Jay Cornwall <jay.cornwall@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler
Date: Fri, 21 Feb 2025 18:09:28 +0000
Message-ID: <20250221180928.466632-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021802-scrimmage-oppressor-8e61@gregkh>
References: <2025021802-scrimmage-oppressor-8e61@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ec4c74-2ae4-4ee7-1466-08dd52a2e9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHMAFizuqVSdb5KIOke0MlwQ6DvXrh09eA9wWW1YZRmBM3OWTpNcgGLVxxJq?=
 =?us-ascii?Q?qw1rtVIs2clnfs627E3WuyEml/1LWmOi+9rSKjFs4Ow5c3q7s+A2iltz9HvO?=
 =?us-ascii?Q?WL7UuvnOYWFTjvjQSM7XGaZ2AK/WlLI9hyakKHGK6BeAo+GeRLlS8KKUxRPu?=
 =?us-ascii?Q?iszOxUDdPBdjND9BNsYMB4+gq56lNZTMEI7ZjEAcq8J5d3zy0246s4xS4WJs?=
 =?us-ascii?Q?35CPv0GqJwm/WIIuL5C+HkF63WFIO5Ak8Q3RQwdoztMV3ryYOrk+vxgE4ytb?=
 =?us-ascii?Q?5zmruDDFVOaI3dajaYaIoUtM3Xj9/kpYMXytfaOPI7VTma8NApv1UYjFGSaI?=
 =?us-ascii?Q?v5S+wqh0TssMzLa1EOFktVBVtD8IMEkbSyeqj/eLTphRPeLE5zSBRvfxqQ7U?=
 =?us-ascii?Q?c+YyeE7qFVf8zckKoUA7ITCrSulNMIDeRrkZ5Y3e+BWWwQON0yToExmvtJM0?=
 =?us-ascii?Q?cQVAN6Qt4RpPrFWi2+aCU80u4R0lv1Sajr8AxBatzBy2nrrzFLHCyMcsGPvR?=
 =?us-ascii?Q?O0M/tJh8i9Gvrv5tnuNVQZhXUeKKbu7wcYdDUtNpPCZ7QS/+HsWzW27mqi4n?=
 =?us-ascii?Q?RcEvDKkYeYvZxa1QS67Jd3YAkcnBSxMqhTVKbD4hOVi442eeoXiRMoMxn1YO?=
 =?us-ascii?Q?FVX+DicZTaCkqvQImQeHKkAflHXOksnOrzA2I3QDv1BSRLIQbCqeyaHbRNPW?=
 =?us-ascii?Q?xEpEsl+jafVdOZNRghePzl1wcrSrGi0LYhVFapxqi3C+CgJA38wReBxouNB6?=
 =?us-ascii?Q?9xudlT2QYWY3jPJ55Zl9XE8VMWJVMKavZEOFrKbrtS0pjtE3CBvs0ySx1+px?=
 =?us-ascii?Q?7bQI72OXh4ELksiJaaHi496oXnUGfOeXTYKEUtokNnlg3UaDTl4U7U17zbZE?=
 =?us-ascii?Q?WYxcUfUW+M8Pb10ziN+ZegM9akO7yBI2abopah3MoCzJ3Bk0CKZJL1TAItb+?=
 =?us-ascii?Q?epabT0GofR+/FNC/YQD/dHI1bf/gyIhdHZ6JHk3gFLj3eq1FDkt4cJOs7Jav?=
 =?us-ascii?Q?mGoue+y20tzLmcK98PpN0p55a3hhQ5+NZnrgmXj0WI4l49Nf7I/nC2X1BZ/k?=
 =?us-ascii?Q?Nu4S583bOqgMuJ3KXSVPT1mQKViqR0vu4YUfq19HA00e1XR7pdkBwKGxmTjm?=
 =?us-ascii?Q?fkT8T7zEKYI7aKot8JbHG+Cjtz6EYpXE3bFW6wGh7VXmlaUEUpNfNbEwRgTX?=
 =?us-ascii?Q?rS0ZucRpNnOG2kalcYKDlM2I4/trohmlXrrFK1MgrLLHFiEoO1I5Vb+2KpoX?=
 =?us-ascii?Q?VWTtJUZ+rmPd1Yk7LyB/NSsyRekH8+WHxSIV8SfN/puFfY+sXsWVfKEbBsWQ?=
 =?us-ascii?Q?mkGkWMggkN7lfgZWU386dlEZsHqFXz+T3z/ovAhkXoNOcbfhziNzG7OQHFBR?=
 =?us-ascii?Q?jeuqti/axf/VFCdNDhz9Kd0uL+/DO6dNrVDgjnOEQb888IN8ELmmf5KWdyHq?=
 =?us-ascii?Q?la8w0W7zYSp+/wkF4VuvdVZwXslqACYcoQBuIZUnJFFrmmPwVHEf7FcTOHbC?=
 =?us-ascii?Q?HqrdBXxN7j8RKvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:09:41.7129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ec4c74-2ae4-4ee7-1466-08dd52a2e9d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

It is possible for some waves in a workgroup to finish their save
sequence before the group leader has had time to capture the workgroup
barrier state.  When this happens, having those waves exit do impact the
barrier state.  As a consequence, the state captured by the group leader
is invalid, and is eventually incorrectly restored.

This patch proposes to have all waves in a workgroup wait for each other
at the end of their save sequence (just before calling s_endpgm_saved).

This is a cherry-pick.  The cwsr_trap_handler.h part of the original
part was valid and applied cleanly.  The part of the patch that applied
to cwsr_trap_handler_gfx12.asm did not apply cleanly since
80ae55e6115ef "drm/amdkfd: Move gfx12 trap handler to separate file" is
not part of this branch.  Instead, I ported the change to
cwsr_trap_handler_gfx10.asm, and guarded it with "ASIC_FAMILY >=
CHIP_GFX12".

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x
(cherry picked from commit d584198a6fe4c51f4aa88ad72f258f8961a0f11c)
Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 3 ++-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 02f7ba8c93cd4..7062f12b5b751 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4117,7 +4117,8 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000ffff, 0x8bfe7e7e,
 	0x8bea6a6a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbfb10000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0x00000000,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 44772eec9ef4d..8fd7f17df494c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -1463,6 +1463,12 @@ L_RETURN_WITHOUT_PRIV:
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
 L_END_PGM:
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Make sure that no wave of the workgroup can exit the trap handler
+	// before the workgroup barrier state is saved.
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+#endif
 	s_endpgm_saved
 end
 

base-commit: 4e3ac4150cbd02585dc5cd1b4a25b8519a57c6a2
-- 
2.43.0


