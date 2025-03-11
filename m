Return-Path: <stable+bounces-124107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A90A5D1FC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 22:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71659189D6EC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C23B263F3F;
	Tue, 11 Mar 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbei2aZN"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FB228C8D
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729834; cv=fail; b=oLr1zFYbFxHWZZl7X6E4bSiCTc/9cGFChvFtiu7OXg3farsVsDf5Sr/tHevf6iGMwKtIxvpHxl4KYfSizUaVmZJURJWkr/kTTqLcOsTdtLcFQPrUYMR4RBPU0vE1TLxoCo6/F7qb32JMfEijoMi/+Dv/bK/EHBPe0LgHV1/p4ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729834; c=relaxed/simple;
	bh=s1Y5HXuuscFoljVK/wKZin2yp80yX2Xzq7iLG538gLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frUEIB9mjaZs7MIVGbpbekStMp7f1fUc9/1osLyVFnhaqJ0ZX4pWUx32rc+SX0Xfw7WcRSgxgZuvf1tYKRiZTNwwdh78ErMTbuR0XfG6HdNsQ/vayhdBSwmdrRCb17Emqmz6Kui1VYtBMUsYWMLwrIEyrvJ9YCd1FYj9htW4qt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wbei2aZN; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps6amvbthuBEX90Xmd/HJhxtoUyIix6IjJKflaRQmexq+hOIjCqMGybPQoYRGt7ywKdQMp5g0DRmsXJ4eijI+/2WP2jepzH74z0hjWj0aTXnfDyjW4zireF4jQ4Bpl7irdIjvH1ivzwcRhMANrQhXbXjNqhwwtV0bqIFulJifPSLh/F4kKeNRKYFGLsol9yWSSu8XhBK6Ow2TjEPY4lzWcixVbZfHQZFOGTx5kzlJAsWVb3H97dRgwQ5x6wEM9pjG/OLor71mBnqCXGaddSAt4WeReHDyFCyFijwBcqx9f5f774h9ZyjDBkjZLFHEu9QmXyctGCFESYuHfKMdF5Vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGn+t69dtIPKKgLDboGzXjue5yl5cEusMcLtSgJ3ogA=;
 b=xgI9LCf/l/USESyJAwgnlmXkNg911Xa4zxJey8nK+U+DrmxBL55rHNj/L/vdss5AyPVACREwsV9J4m8yzhTy4/8RKuKQxd2z70AGUwtenFWhMteUiEEmdi+UIAjrXY3vjP7HkVeNEqkP99yusR45pkIMPex3rFzdr777cs6AwokHYJ2Yx59S/CHLoBpAr8FMIqgdvGiyFakxlbvtGP/FJbNXVv6e1NO9VVhHEM1r8I9UnkGNQTU9K05Ed5UsC5+ZcO358HzNlSPTcoEttZ5R1dZN0BS9Ebl6bsW2sBq1rYjbgnytQC3ZBPd1RMlUJf9juEgUwiIGal2k5bMIGEFq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGn+t69dtIPKKgLDboGzXjue5yl5cEusMcLtSgJ3ogA=;
 b=wbei2aZNZtsnKwI3RCHW/fevgtQyRqqeYuDg7cthZDfMljqw/2EcnwgfmjrcFpjwIhcWBIeRMMr4YXxyRZBRna9MYpvx/Tzuq6aNU0dBc4MOsEDmeP9IuZUROAlZthVKbsmPN9NvUKX170lK4DWLjPiAwygOe43gmAAOkN3haPI=
Received: from MN2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:208:1a0::30)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:50:29 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::cb) by MN2PR07CA0020.outlook.office365.com
 (2603:10b6:208:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 21:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:50:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:50:26 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 07/11] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP
Date: Tue, 11 Mar 2025 15:42:08 -0600
Message-ID: <20250311214618.3106637-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa3190f-2c64-4d8f-5a14-08dd60e6bce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYePfDzH9ANnQReijMTKULnJewFpoYJqmRjoTHsqbwquBdpRvas9AzqJmM8r?=
 =?us-ascii?Q?pPlH3Rp5IEtrqcdHfyr63GBypszr2TTXomahnHWmP2WpKOmtxn7KnXdo2a35?=
 =?us-ascii?Q?FW9d9bFw77NEcfNRvxajBCIObQEhjO+5oz2A2mt/WusOMjUUN7aukdThIxFW?=
 =?us-ascii?Q?J1QExn87kd6cylMDjlOxpwAiEjkmNEFEzl+Pc/WTyJhyLlRPiNWHkak+NYyn?=
 =?us-ascii?Q?D4OwlX8Qoas4SJymOPxyiGiUxpsOGbyrIsEZ9a0kXL4+/OsyT5qUbOGMU3U5?=
 =?us-ascii?Q?hA25P7gPwBnyOIRDJl9nto6zRBWLXL635w2Y3MyOiYKGpQlgxq0HBdKi4Yz5?=
 =?us-ascii?Q?mc5LREfnDkX+ntd2hr6xVG7Q8EhDOxW6/ugKjDNl87Zd39aR8JFZybNfbPuZ?=
 =?us-ascii?Q?7YV32kx0AyoAVxiTmdRSbTeTFsFk6WOZ2sXWB5+FiHmBtBsgkACaUZrhcrJ8?=
 =?us-ascii?Q?LrJ3MiPIhaDwm3NWZqQhy97VtF0Ti07UOMiWsaQPo7uYTl/gR7dnexSD35fc?=
 =?us-ascii?Q?GrZW/yPEk2/6Y5w5OT0vMywd67kAcL8/RXa0AmTItbalds44qRX8lg/+OIRt?=
 =?us-ascii?Q?Qv/+1aS9LiQS5PvJz3H9TFxVCZBGaKWufWOXqwINblxr6Jd10/J6kuq3rZsk?=
 =?us-ascii?Q?3mBOh5WIgGHZJk+njz+qYZS2y/ylm73WGP0IjJbnIiX8cn/94qhVcAkbmh8X?=
 =?us-ascii?Q?uxfyA3SawM1eSIozWz3fDSL0rRxpkmn6hYSJdMMBqtcztMR1RoJ2TgVbWDuy?=
 =?us-ascii?Q?UdHcAF0ic7lPzQkIlUYCtiQnLY1Ey6gtJzzoKXeJJmLCNpiH9DxTgku+OUxx?=
 =?us-ascii?Q?jq73Fmf8OMc/N4jTzhUO8HqcJZoMvtfI72SAVJKJEpBtIryXXPJuzLKyBqXe?=
 =?us-ascii?Q?9ghNi1gRR/JHeAaess8uNtdOgUWIbW1ITIU4/f8M+b/8rr9LCkzLVyzsFsjw?=
 =?us-ascii?Q?qlH9uLF4XLrFLzGMNDIxIQLQx4E3ad6dvXGxyqLTCUzHvPCMUhjebO29FU31?=
 =?us-ascii?Q?/qii/3ljirI9HBXqxpGN0alxdw9/VW4NTAX5yzZjhJLAPgseVIpIpu7sbZLQ?=
 =?us-ascii?Q?B06VXQZDfUTspEbz0URNj+1YPJYfIESpYVBxE0ruJ/MrnP0RPUcol3uG7eGs?=
 =?us-ascii?Q?hPkwGvvL1844Ev8BVveuj52ZjW/kS1hUNbV93j0Fw9s8usp+CB12Fyryed8n?=
 =?us-ascii?Q?hhD5fXblPFrxeTW/z6QpBz9Hg9yblIgRvX4HEv7a06k3I5IbAHwk6yPul2D6?=
 =?us-ascii?Q?/Q/44JG+WPSuJubVwqMDs+3M7/b7dgqcBofAybLsNU1h7MLcXxZKewe8c7or?=
 =?us-ascii?Q?k07QIf7qKvtWeuL7UIWq7TP9QaEEkvzhx/7QLjWNl/6yQ3/fLKbiaH/izRXU?=
 =?us-ascii?Q?SaZ4yUx39MvBvNdgIvOTr6GW25/+uPsh6s+eKPLvcJFrSa/IKZ9niTNcPLFh?=
 =?us-ascii?Q?ML2eaEegveI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:50:28.3770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa3190f-2c64-4d8f-5a14-08dd60e6bce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
DMUB locking is important to make sure that registers aren't accessed
while in PSR.  Previously it was enabled but caused a deadlock in
situations with multiple eDP panels.

[HOW]
Detect if multiple eDP panels are in use to decide whether to use
lock. Refactor the function so that the first check is for PSR-SU
and then replay is in use to prevent having to look up number
of eDP panels for those configurations.

Fixes: 06fbedfaf1a9 ("Revert "drm/amd/display: Use HW lock mgr for PSR1"")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3965
Cc: stable@vger.kernel.org
Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index bf636b28e3e1..6e2fce329d73 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -69,5 +69,16 @@ bool should_use_dmub_lock(struct dc_link *link)
 	if (link->replay_settings.replay_feature_enabled)
 		return true;
 
+	/* only use HW lock for PSR1 on single eDP */
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
+
+		dc_get_edp_links(link->dc, edp_links, &edp_num);
+
+		if (edp_num == 1)
+			return true;
+	}
+
 	return false;
 }
-- 
2.43.0


