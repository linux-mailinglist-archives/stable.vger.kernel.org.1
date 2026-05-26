Return-Path: <stable+bounces-254255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIinA8NIFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 797305D19A2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 723BC301F4A7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910E2F8E80;
	Tue, 26 May 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSCaqYk9"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116213438B5
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779776; cv=fail; b=mpqmOZtdlWx0E2bE/asNAxArCWAUiRrBJxugYIuN933SLfVW262/SP9ZlRwSuXeuxWMq9y9GyiElnloHsZLSp/1d8a79C1hKZeXgLQTaTXPNW/AY0B49/UupMBU5fgA2p2/K0vE+2B5glnJjOL+3jh+aZGbJqDM5Rb1MSvNjw/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779776; c=relaxed/simple;
	bh=JJMUolYuZ0vp7DDF54+q24fLF4j5pO02r8Fk5lKtjws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMYyCJm8uXVBm/Na+bXTDPSaEwsSJPwiP5ugn1Duz+DGbvHb86Pdjp5t4UUlOrx78JPZ5QJNbUM2IUEdrLmcLzi8R78gmlBa4Ly559FbwwQLfpYFj/Py1HJGbeAmu/RdYYhbEPwI+SDAjHMMt/zT+6nhJkWnTqbs+ENl/D7Nc4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSCaqYk9; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjzvZE83r7SpLTDnqCcOL1MOHq6XJLbI3yffokW2Fnc/a9P53Le3Ngu32eJ8HwGCUe1cRP5xYVwln63StK/Athx+VdUXclYHudt3xGh79CJzgEdo8Im3MGI9UbFeN5QQYQ1OSAXRe0dWIUPw75BSTlEfXz/Q8bb9ayIXaLpIdGoQodMgcFyLC+jt5UYHRVVHiJmhOvEgaS9BkeEmyobk+mvY4uLSc/9PVQ0zeC65vPYCdbLipFkgzkOw4DDsdXpXUoiAC784YBkwT4vs10SzIDlX/J87A50UT2wWf5KKI3IP8rqqeSEZyfV3r1EahYpJ16BJAoR0TZz1k9xZg8TSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3guDWY1jYbDWFiu0PnH7B4XwdoGJJOLqJ/T57F/oKww=;
 b=QLShB4dXKZ1azT+/DsOfvfR6npI+KSBjVad01ZCfMecYQjfFPM0XsV4yTflK0VTm0/g1lJxBWLF4sck7OL5krKmrOCGyLYFTgR/YK5Y+eeAaUFosVFkxClOYYkFKIV1O/hBDqT/6I20cUyBK8ciTx0FkeyNX28ZIxQ6ZqcrrKtUaNe2Zx/+p1zFsC2HaKslPvm4RZ+XYGlEoUPLxZe8JOPiasdsHtkph/5PMypDpzKd+P+J8lMDlW7XPmqsw/008tCuwvRB7vusFBc0oJIZQPKoCZL93HVBxKJATC2GO6xiSaW3k/WG1GnCJixqzieNLHMKaYndp7qXIMFeHPi8t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3guDWY1jYbDWFiu0PnH7B4XwdoGJJOLqJ/T57F/oKww=;
 b=QSCaqYk9PUmaDwpJ1yhd7zPlgOyqdzNxmT5Y/0cbthZr/vJiRveR4z5PDWIpR0r5nIVpCiHue4RKwz9h9olV5eILyi99kfnTRCb3jEiRlmQB2J2ck99JNmyTFXD44Zbg1MMV16W5sq88SBG0QRF0SzSUHZV+hpGFFVrLzH+1uN0=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:16:10 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::39) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:16:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:16:04 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:55 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/41] drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
Date: Tue, 26 May 2026 15:01:35 +0800
Message-ID: <20260526071413.2181251-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 585c7efe-d558-4455-df5a-08debaf6a8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0NVbRPLaLdpRRM6Uh/vPq89j/U5odONpGS1hC1ixWdXju1nbFww21yUZUamD6Mfk5BSuEZZghHpg+ylDacTjmqw5c4GFNIqhPSIEUDfSwH1h4sUTgLbawGfz4U+IUe8dOtXUwb0zS65ZH7fOykKBlyvT9863+WG8Q0o6It/ML73LNNM8PBNQf076jwU8YjjhD2VSOfitKDgINAfVns5p56jq5wygyDshiUgkCuy68zekgdxTsHIe69K2xySHpJT4oI3ka0snSWi7pBw6NF64cXdHoON2fTpV65wnF4Z94k48FvElmwWZzdHS8OlG7NI4CarxrQBL0cW5XTt3YzcT+scAs/od6rSbnAPzZhQvBkPPPUvhpC7oAAt0cRdI9kc+R73t3uXe6AbDwgJsIBVrQC4nwCjUdY0IuF7nwE/U4/09i2U8GUFo9t7/xSaArtdCet/+ceSC1bagQuJ76My5pGuqjeFNt5uFU7WCksprwN2GGmMW1diEKiSYc5Bya2aKuPGDmKpQMqDaKM0ej5WX774Siuej5MwWnwxTuOUGDyZBWqh4AcdSwpuMR8jHX+mbLXBcj8yt6WvIeFqTmKTqD48WYg6VREG/3HXnGyInG9JMh0sxFgWbwQbMthpG9QcdX/n/RJdXjy7w3J1g7TqwpB5x8jii57jEMw+0hbNFwGiYzC4r80cqFo/wrG+e5Sjz8OBQkm1iGGu00a3ExgQUAwvtgz0c6GEhIwjY7ve/tec=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mbYFERLO05w2lPz2nrQnXKO7TgazLQq+6r7h/Z+8Ap4/ipjp+/enXK1BesFhSWmuZGMUHCzEv5+EQB5QVFLnTotIDxXdo5VFcnTfwHxfKu7QxwTjhmNKFH2d5AX6Ouay3plKrDSKA/z2knk6Xz+zueXexcQCw9WIOhO7OarHAIvzCa4o4C+gn/jZKEbpkmNvQd3yL/XMNEfcikKU7nl6BByQvQrPjJPbhPsHUjUBuFVdZeemMs3+Cu5h+QctOrQsOiL28Jx8u1HTxDs5FUy9d0L/tT3tYSYt/Ml34pZymdmBBFho3xUYw7qKp9x9bkgz8HifDlxKuQaN61nmlTzTj6jgDQp/7ALD9LrNljueM1cICTBaj4+3p7mxe3LhofzQxlERS5SIPldhXA3rqd7tqYMQLpgUI2JLJu9Gs4cBgIRGw8nl68msbcyX+3b1O+k5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:09.1070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585c7efe-d558-4455-df5a-08debaf6a8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ray.wu@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 797305D19A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
The VBIOS integrated info tables (v1_11 and v2_1) contain HdmiRegNum and
Hdmi6GRegNum fields that are used as loop bounds when copying retimer I2C
register settings into fixed-size arrays (dp*_ext_hdmi_reg_settings[9]
and dp*_ext_hdmi_6g_reg_settings[3]). These u8 fields are not validated
before use, so a malformed VBIOS can specify values up to 255, causing an
out-of-bounds heap write during driver probe.

Clamp each register count to the destination array size using min_t()
before the copy loops, in both get_integrated_info_v11() and
get_integrated_info_v2_1().

Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index d19ae67ebfac..6cbdf356b1cd 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2600,14 +2600,16 @@ static enum bp_result get_integrated_info_v11(
 	info_v11->extdispconninfo.checksum;
 
 	info->dp0_ext_hdmi_slv_addr = info_v11->dp0_retimer_set.HdmiSlvAddr;
-	info->dp0_ext_hdmi_reg_num = info_v11->dp0_retimer_set.HdmiRegNum;
+	info->dp0_ext_hdmi_reg_num = min_t(u8, info_v11->dp0_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp0_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_reg_num; i++) {
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp0_ext_hdmi_6g_reg_num = info_v11->dp0_retimer_set.Hdmi6GRegNum;
+	info->dp0_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp0_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp0_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_6g_reg_num; i++) {
 		info->dp0_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2616,14 +2618,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp1_ext_hdmi_slv_addr = info_v11->dp1_retimer_set.HdmiSlvAddr;
-	info->dp1_ext_hdmi_reg_num = info_v11->dp1_retimer_set.HdmiRegNum;
+	info->dp1_ext_hdmi_reg_num = min_t(u8, info_v11->dp1_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp1_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_reg_num; i++) {
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp1_ext_hdmi_6g_reg_num = info_v11->dp1_retimer_set.Hdmi6GRegNum;
+	info->dp1_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp1_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp1_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_6g_reg_num; i++) {
 		info->dp1_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2632,14 +2636,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp2_ext_hdmi_slv_addr = info_v11->dp2_retimer_set.HdmiSlvAddr;
-	info->dp2_ext_hdmi_reg_num = info_v11->dp2_retimer_set.HdmiRegNum;
+	info->dp2_ext_hdmi_reg_num = min_t(u8, info_v11->dp2_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp2_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_reg_num; i++) {
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp2_ext_hdmi_6g_reg_num = info_v11->dp2_retimer_set.Hdmi6GRegNum;
+	info->dp2_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp2_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp2_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_6g_reg_num; i++) {
 		info->dp2_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2648,14 +2654,16 @@ static enum bp_result get_integrated_info_v11(
 	}
 
 	info->dp3_ext_hdmi_slv_addr = info_v11->dp3_retimer_set.HdmiSlvAddr;
-	info->dp3_ext_hdmi_reg_num = info_v11->dp3_retimer_set.HdmiRegNum;
+	info->dp3_ext_hdmi_reg_num = min_t(u8, info_v11->dp3_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp3_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_reg_num; i++) {
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v11->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v11->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp3_ext_hdmi_6g_reg_num = info_v11->dp3_retimer_set.Hdmi6GRegNum;
+	info->dp3_ext_hdmi_6g_reg_num = min_t(u8, info_v11->dp3_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp3_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_6g_reg_num; i++) {
 		info->dp3_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v11->dp3_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2796,14 +2804,16 @@ static enum bp_result get_integrated_info_v2_1(
 	info->ext_disp_conn_info.checksum =
 		info_v2_1->extdispconninfo.checksum;
 	info->dp0_ext_hdmi_slv_addr = info_v2_1->dp0_retimer_set.HdmiSlvAddr;
-	info->dp0_ext_hdmi_reg_num = info_v2_1->dp0_retimer_set.HdmiRegNum;
+	info->dp0_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp0_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp0_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_reg_num; i++) {
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp0_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp0_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp0_ext_hdmi_6g_reg_num = info_v2_1->dp0_retimer_set.Hdmi6GRegNum;
+	info->dp0_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp0_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp0_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp0_ext_hdmi_6g_reg_num; i++) {
 		info->dp0_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2811,14 +2821,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp0_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp1_ext_hdmi_slv_addr = info_v2_1->dp1_retimer_set.HdmiSlvAddr;
-	info->dp1_ext_hdmi_reg_num = info_v2_1->dp1_retimer_set.HdmiRegNum;
+	info->dp1_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp1_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp1_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_reg_num; i++) {
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp1_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp1_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp1_ext_hdmi_6g_reg_num = info_v2_1->dp1_retimer_set.Hdmi6GRegNum;
+	info->dp1_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp1_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp1_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp1_ext_hdmi_6g_reg_num; i++) {
 		info->dp1_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2826,14 +2838,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp1_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp2_ext_hdmi_slv_addr = info_v2_1->dp2_retimer_set.HdmiSlvAddr;
-	info->dp2_ext_hdmi_reg_num = info_v2_1->dp2_retimer_set.HdmiRegNum;
+	info->dp2_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp2_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp2_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_reg_num; i++) {
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp2_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp2_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp2_ext_hdmi_6g_reg_num = info_v2_1->dp2_retimer_set.Hdmi6GRegNum;
+	info->dp2_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp2_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp2_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp2_ext_hdmi_6g_reg_num; i++) {
 		info->dp2_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
@@ -2841,14 +2855,16 @@ static enum bp_result get_integrated_info_v2_1(
 				info_v2_1->dp2_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegVal;
 	}
 	info->dp3_ext_hdmi_slv_addr = info_v2_1->dp3_retimer_set.HdmiSlvAddr;
-	info->dp3_ext_hdmi_reg_num = info_v2_1->dp3_retimer_set.HdmiRegNum;
+	info->dp3_ext_hdmi_reg_num = min_t(u8, info_v2_1->dp3_retimer_set.HdmiRegNum,
+					    ARRAY_SIZE(info->dp3_ext_hdmi_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_reg_num; i++) {
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegIndex;
 		info->dp3_ext_hdmi_reg_settings[i].i2c_reg_val =
 				info_v2_1->dp3_retimer_set.HdmiRegSetting[i].ucI2cRegVal;
 	}
-	info->dp3_ext_hdmi_6g_reg_num = info_v2_1->dp3_retimer_set.Hdmi6GRegNum;
+	info->dp3_ext_hdmi_6g_reg_num = min_t(u8, info_v2_1->dp3_retimer_set.Hdmi6GRegNum,
+					       ARRAY_SIZE(info->dp3_ext_hdmi_6g_reg_settings));
 	for (i = 0; i < info->dp3_ext_hdmi_6g_reg_num; i++) {
 		info->dp3_ext_hdmi_6g_reg_settings[i].i2c_reg_index =
 				info_v2_1->dp3_retimer_set.Hdmi6GhzRegSetting[i].ucI2cRegIndex;
-- 
2.43.0


