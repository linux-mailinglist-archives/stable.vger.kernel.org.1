Return-Path: <stable+bounces-41343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409778B0509
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BC91F24247
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53D158A06;
	Wed, 24 Apr 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SFCHfbu8"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B0157468
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948831; cv=fail; b=rPKle1jcf5XVUWiuWU9WGjyZJDONNNYPNeIWLnUlNh/GQBbVaHigS7PUqi83T75ZVwsjznZOSylbos2kFKbJYluuhXfdzR2hfdMAViCPAO+bhSdO/rs9CVmddUCFaVVzDyZ7vP9dvEZ2RO4xGaFyhSwghTAn1qifBP90CsbNYZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948831; c=relaxed/simple;
	bh=u4d5MIN0pPtaRV936p8MSyLIYqIEsjUmwYXwUCCeKsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB9ondeOtLpjRI4TfKRbQg4ufJbS3dX61oCm/LvzPYJlKvEqJE8KwM+5iBlmiKEcscZ8uvlfPV3yH81ICygW2rGmMhWAXDIVjn/7OU44u0qTtH0RFfV2e0IkqsioQ3lXY9P1GNdLa0nKjbPzV8iy4LvTamu5adeu6W9Kx4wZiZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SFCHfbu8; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9+CjiEAvIsfYjqZad7QtE8GuDfnHQTPmxl3IWc0DEt+57RUgnYYYF6YTtC+6M5xtltOCv5rSfd6zRn4Nqz8BK3xUQeeJQIxQfTUpF/Z285NwaeobeL2DEjOlaYQPDnkmIYysjuWaZZmdpMQNxL3HPtvFL93jZPROxp8NoQaO3PfJW/Ati6+njFKtrc1i50kHG6rY4szxM2Pf0iyuWzzlXVB+TJzDmxodTT2VnC507fVqlem4U2qzU6wOLWlUlPkW/wI0jElik8DeHAukIW99W/lOcRTjCZGdI6XO/+bvyZvQ4mj8kiPUdKhOoWttJr0mL5sg/TUkNmll8akFXFuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc7Cqiw1fSrL+V5HyN1mR0SLyKLZoaRdx8Nt0ZQp1qI=;
 b=nLyLxLNwIL5OAA5YBb4wJSbp/brBwjftynroUcycjAOU9cUXPp2uya13b6036iKZMheetOUOTdetqZ8QhqvupdJPZ/kX3xGDtZFjDH6x5JW1bY/NVu3zbhxSmqWWvt+Nm6vyjMQbQI6xgHsDeXmTtTYlpCioWQxpdCDmlAy6kDMbu2hkKthr6xggW0G9UrFcHkLamFLd7aM6fUNmgnLV4D8Wi4cFYk707g9y65PjVjQ/rNqYeIW3qjFkXxJJltYsa9TMgN6ZYi0OuMmhR9XobeFhXQCzxym5gt7zaIWohlCCxyV8ZeYs7V2Cu8L9U/pNob9jwu/nW02EMOhWNPTcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc7Cqiw1fSrL+V5HyN1mR0SLyKLZoaRdx8Nt0ZQp1qI=;
 b=SFCHfbu8l14c8nTrVBmDktm9oeYrywo8zVyTemUoSAfSh28I/5NC4UfdKPebIegk7/JEzeoTEEEY98GihPNiyKFStgCFX3r1Crr53/6PTzZuyCNhNlazTjYXlOsp9WQgzBypuAXla3SHsgGzQT30f+6BYtvdSPWsUaplmdqfJt0=
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:47 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::b7) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:45 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:40 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ilya Bakoulin
	<ilya.bakoulin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
	<wenjing.liu@amd.com>
Subject: [PATCH 38/46] drm/amd/display: Fix FEC_READY write on DP LT
Date: Wed, 24 Apr 2024 16:49:23 +0800
Message-ID: <20240424084931.2656128-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: b48fbbc2-a53e-464a-8c52-08dc643c0d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RNOWjI9qGypLtkO7H62WVzS4Oe5FOVfGZw/hAXozfhL+suuVLq3jorvdZ6U?=
 =?us-ascii?Q?m+AAS8/4bJhZfmVEWwa9m6gw0ZkRCDnFRTQvRkoXaFGnWqaCeh4vv7gFWgs2?=
 =?us-ascii?Q?4BZMrPnxjbkgpDCg6bMZjn+o3HWA12YZCUOO+VnKFKnRDuhlvTeBlv+lV135?=
 =?us-ascii?Q?kPtR3Yvdew/T8wnLuRLCOavSTJOxwar6GoBGTvTDNZh+WWNoUPPHS4IYePB7?=
 =?us-ascii?Q?B8yMUkQ6VUExvobz+Yovq6zEMJIJWBMrEifgROM8UtEhE7maLQHKc5W/ctN3?=
 =?us-ascii?Q?9Kg4W5cO3p1vStKCWJDkaiy552dqNaxGYrNia2iKEw31LkSSWYOFC29BVCKe?=
 =?us-ascii?Q?fQB27aMvFg/5LQWK4TfUp7UEjMvFsrKeiz9J4MXIhAWeuuPyauguxm8gtDgl?=
 =?us-ascii?Q?x1QE88H/8dRM+yZH7riT/WLGP0wjyQ+rhEeqHgbLeYxvHW3BLy5XWf98+vrz?=
 =?us-ascii?Q?XPAvZJuzEOl0GfCZ2hTg4bGPy2o3vgXjbdHOwB8sCuAv3+dz4A/qTLqPjyWo?=
 =?us-ascii?Q?79kn2wnV3fAZfGeOmeP0OStujuj5Or6jhd8f2sZtoF9z+86SG1Nodf0gu+6z?=
 =?us-ascii?Q?73vNwwl1OcViNMk6mrUNTbWmCsJVJzXtczvTjiNlbgSf2pXF0jKpGnqCHD0y?=
 =?us-ascii?Q?7StSDEE+zxyd5a7qSNyUaNZMR0X60X13aLnaDfC0c7ruRx2rYGB8ntkV+TbT?=
 =?us-ascii?Q?O1tVIrDAF2hSaW15NSSUBiahnPLfZ/5Le0c71ymbhW8SoHzeDBUgwGxjKkRb?=
 =?us-ascii?Q?UG1KqOidOYC3CvHft0NZ047Som0mPamEKpMk7Y7N+WFnJ9J8SAJfY/N4G7sN?=
 =?us-ascii?Q?qOIW6VjAdgv0s5wQQuHuveZWnGgZwCcY3KstY60pkbGOKYdRHG55lH8MK5e8?=
 =?us-ascii?Q?K3MEvT/HUeVLQsmEfUulnzc+kzyaKposPzSqan3ZSmEHmHsVguY/bXkSsekd?=
 =?us-ascii?Q?3KAbJBcH4StajAciYIvXPhOdrzb1gOFqqhHBf07LD+QLRUuuOtWDq4cLKI+q?=
 =?us-ascii?Q?4yFDGN3fqQQObHUhXVamHo7cI82qD0y/DO58JrdTktvRv21zEHZzNTfJjrsu?=
 =?us-ascii?Q?+/wQGVwKU8Ov4FRFGIh71ybQSHsXNiMih+DDfh8wMFakMcU6Vzpfdjo6huAi?=
 =?us-ascii?Q?mPtzQxuCYH0YhRjimxj6BvHtsu/aDy4QK/NRs3SARsn69IWrx75LeYk8PyGD?=
 =?us-ascii?Q?zQfsYa3ruyqZ0BuZB0hE3ET8Jtw2E69PkYChEDbI5AkiPsn8PWPx4nDuAa1P?=
 =?us-ascii?Q?xUvXfN9FfAvyxBDxLu169V57XcAWw5Ye6kFc56o8quk4cg0oQWLHw+stHCPr?=
 =?us-ascii?Q?wKSDqMH4Uo+e2QIyVllBs1khyeKO8vvMYkrKjXKF40IB5pcQGmc+yly33a6T?=
 =?us-ascii?Q?y1swYa7aJNN06c4iSm0BGWXnhSSq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:46.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48fbbc2-a53e-464a-8c52-08dc643c0d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why/How]
We can miss writing FEC_READY in some cases before LT start, which
violates DP spec. Remove the condition guarding the DPCD write so that
the write happens unconditionally.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_phy.c    | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 5cbf5f93e584..bafa52a0165a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -151,16 +151,14 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 		return DC_NOT_SUPPORTED;
 
 	if (ready && dp_should_enable_fec(link)) {
-		if (link->fec_state == dc_link_fec_not_ready) {
-			fec_config = 1;
+		fec_config = 1;
 
-			status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-					&fec_config, sizeof(fec_config));
+		status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+				&fec_config, sizeof(fec_config));
 
-			if (status == DC_OK) {
-				link_enc->funcs->fec_set_ready(link_enc, true);
-				link->fec_state = dc_link_fec_ready;
-			}
+		if (status == DC_OK) {
+			link_enc->funcs->fec_set_ready(link_enc, true);
+			link->fec_state = dc_link_fec_ready;
 		}
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {
-- 
2.37.3


