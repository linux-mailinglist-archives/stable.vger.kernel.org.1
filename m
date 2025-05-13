Return-Path: <stable+bounces-144265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF7AB5D0D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A6117E660
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C602BF96B;
	Tue, 13 May 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eqov+s0g"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD057DA95
	for <stable@vger.kernel.org>; Tue, 13 May 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164126; cv=fail; b=T+BDqk5F5me5bMRPNr3cNU22LfC27lVpuuEIN1NmuB7pJM+Lx0HKHLLJpDOkPhYTSXENPf3j+kJK1grU4PGanYapWkDQeMPW7OPuKJB/4NaLyOmeBzSZiy2J+cr0jGL44DGsOtdXOTxjq8/R83MxyT6cX7fuRi76hbZ3Gs6R/U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164126; c=relaxed/simple;
	bh=YIMxQAbxuFFI8JIhQlVOtR89WkOEhYWd36xcIorORZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ItbPLc4m/9rDGy1Qx44yXqgDxng5+IrBXhDNhByL40IOquCDIP6dsN1eg5JeINDc7LqdSO0sAf315GcOWs4rMaZBksbxLPxs1Uu4usynwaKA186TUxPYr2O11uT32/EVHQ9Jyf+jmTDwW543b0gsBATe6UZIq7Cr6mRkJEGkEE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eqov+s0g; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niyIS6O2W/0kDgWIx0+ydCDACqa+GFjVeax6jXNWV5ZHZN7VWsMGLmWh+DHOppKosgIwArOp+dUSllsEfERJKESXkkIL2bJqG3OgqomacX1TRE3DjWzgOsEnjwAVfx8nnyF9ty50lhE4Kg43pOZid05Ns3JuGbnPeBk1sVo6pZMUGnvsf1rw3vl6XyXtGMRhJdVWRV54yKp6Oh0JRUATF7+2ptd539rLleWhGLvvCW0dJAK/Ms3YKAfUzaG7j+WWOqgEJ+nNYVksFC2va/1/I00kBG5POz52rgu8WZbno3voYTckefR8ny3KDHqMuQcPLz3r0GSdOND+voJdJAdlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYXO8OYbP1XEPffSlW9PdfrM5kjVPLtnSZfXrjXbk8c=;
 b=HXjzrZY56fO4I95hJXdUvv0b2P5Rr3xQvpuSX4+kpeVMr7Hnpwzqq9dY+iSGFkquXkcTGgcPPMkiOudfozzaNoUQ/db6ME4HNwiigo82T2SeWAFD2uSBK/lM9WuRtA+9eTNzP/biNUNVCIs1tbyeCVMbjGWl2Wd+snBsgwG6sk17+9nF8B2MPv4DLR+3VQTOhudPFmnXrumQG1vOqmNRKPtxHdz8D8+bYU8OPATWXJ1Uq3W0kq+CDEEOtjDyujxnEuAbinJn85wlWR6HGgggnRAAqLniQxBFpJH8jnlLToQr6VdJbBgtH755I4PRlGXjHe9zBwt69L2TE/3BQSqwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYXO8OYbP1XEPffSlW9PdfrM5kjVPLtnSZfXrjXbk8c=;
 b=Eqov+s0ghbHTtFXFBM0pqhDkeOaIkS+jHthjIG3PYTKZ9MQjcQJZKsKHNR/D4KnrUSRQp8JOOIIhEpLqa2RzCQSWDIh3UwYqjIhecxM6rTdxrHWbFKMWXyQl9OpP8/i4XxAlZbBsMmfnealEAMqw6SfcE+ZKcdGUdWM2i2BCeqE=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 19:22:01 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::9) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 13 May 2025 19:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 19:22:00 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 14:22:00 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
	<ruijing.dong@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Tue, 13 May 2025 15:21:46 -0400
Message-ID: <20250513192148.646359-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b0c340-dbcd-4ed4-7c3f-08dd92536f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTTkHTRMU52+QA7l+FMo3OIDix8DhICihyXOWevDNgkKPI/Gg7n9KYFIEPlY?=
 =?us-ascii?Q?+ACElKZ5aIE2cerwHdplFRcRlsuykELHKqeZBZem1mFCkw5xqk/Q2isOj3Mk?=
 =?us-ascii?Q?0N41dJgaRGfWtk+OIM7dyGFa/xm83yqv/OGQwDcOuAuhLqQH/ZSJjHumh6zI?=
 =?us-ascii?Q?GtPoMOFbuYM6obDSP2CbVZuWFV6ELeQdgN4p9f9XuGW0gU4wI/s70WrVZD1n?=
 =?us-ascii?Q?0J5y2WVItEs02+2k5LP6cd03PstLwbatpaAVAWTZWZO0eV8zX//Awe6z0SOg?=
 =?us-ascii?Q?/yq5pFa1GQo85pXsW7i65RzyINwmHzgyrhMfXdXM7twc7osgBHsoGDoONioq?=
 =?us-ascii?Q?nfBh80IPK+wSat2QL+KQZXmP+SObOVkVYZmHMSdorL3rNGuq2D5Hb5dT/gQh?=
 =?us-ascii?Q?EzlXJzAxaBVBV8WvLMMY7ic4ItfkV772BG41uRZ1maF8cDR7PVtslU1lGMhI?=
 =?us-ascii?Q?mq9ArX7dJjhfWD05tPvH6M78JH/9hb2DvYxRzL1LtP7H417kyMuiYFs8fG42?=
 =?us-ascii?Q?HnysULsR7k1QLhaEvr1M+RJi8zgq5oe4qY264BUGQKPfjcj+ZQggfSNq9dMD?=
 =?us-ascii?Q?T7RVSVhIr9HKP9jE7+5taMhMCFbwLaaopmvwVnbXlVt1v7kuZjyhmobjsgKK?=
 =?us-ascii?Q?yxmjHGnrhUzHuwdnNPQQm6vb4n8BeP5oYDdFgPxz1T+C1ip+y60qiKO/knWS?=
 =?us-ascii?Q?Y+H+WQzK57inACNmpJpZGjohbsZBBxzIBvzUK1hkIdMtff4lMbXGNzpGgDRb?=
 =?us-ascii?Q?Uhq87kWLjogoxLcgpkMQ7H79nEE0k3YlKEDXRNIi9buEj4NHJ3rY9b93zdsZ?=
 =?us-ascii?Q?K+HThiQTMwiC+ov/+s56F4xl4MsuYmJAZRk4KIIBXgdFHXv/xE8xnrpi6pr7?=
 =?us-ascii?Q?SgIa/xk5XYefdUhtdx2TV5RYM8QkWTHEPgnhGqb+dQ/aHiEmCOBt91cJlz+c?=
 =?us-ascii?Q?l8JrG8u1i2CEsO4p/73KPKXNzTKA5j/9x7JJrdpBxTM2X3Wk/gQDAoHSXKBa?=
 =?us-ascii?Q?wsCjEuCXrp9NsPrnegf2S5Sn4tDPVIO8eluy+6hWmNUd+0JeIdIpE07DZ+Zm?=
 =?us-ascii?Q?psjx6wjGcnW531VEp+Ls76Cepld6Qf8vnwGA8XyqQqjQ+ftzbRftWan+dBT8?=
 =?us-ascii?Q?B/x2dBWrfCe1IggVOkmNf6vUxobuE9mZuA60TElYV8E9keLiVKczvLZuhOtU?=
 =?us-ascii?Q?SCDP8HRsBpDHE3E2c7FTXv0OWlRHAPNLQCVM9h8AsRD7C5W3rfG7tIW0JoBw?=
 =?us-ascii?Q?EhX0H/NhbQ2WEdsBy6HlatKEGKf1Uy+mawpyFWtGTuLw3H1K78W1+0AzW6yk?=
 =?us-ascii?Q?4Urchq+YogpgA/mW9pn6l2iA/S7FTs6VKM6sz7jqn6/PabrNVS0zRDKinsCj?=
 =?us-ascii?Q?oEFC4xLbf1cLa/NfVfL0e6O4hjTFsKEcPWZW7pgNwxYYqUFMrd74UsakjSAJ?=
 =?us-ascii?Q?kc65to6EMDBExkiXTW7d4chfjoNM8a3TrlTKHZI6oJFMp+z00T+kPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:22:00.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b0c340-dbcd-4ed4-7c3f-08dd92536f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

V2: not to add extra read-back in vcn_v4_0_5_start as there is a
    read-back already. New comment for better understanding.

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. The read-back
of regVCN_RB1_DB_CTRL register after written is to ensure the
doorbell_index is updated before it can work properly.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Cc: stable@vger.kernel.org

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ed00d35039c1..e55b76d71367 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
-- 
2.34.1


