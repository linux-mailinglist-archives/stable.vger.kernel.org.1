Return-Path: <stable+bounces-254254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPxoLbNIFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5C5D1994
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79769300421A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46273C98AF;
	Tue, 26 May 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFHvIklc"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026832F8E80
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779757; cv=fail; b=I+BlyBZP7mSJT8uP7zWCGY0fSqDALAC74djexGN6P6PBtOJTgksJWGDFU9eofqrscF+q125ixw1J0PjnmydkwwzWycCYC8XETN3dvVQ1906RKCKM7wKQM+YMNqzvCbPL9EGYQAE1aAo7C386/8nCiiLX5QU9nC6PUjE6gqf9AxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779757; c=relaxed/simple;
	bh=FEblkVZlz8+NTAYyWrj7BJn1sv8uyUm+PhyYIk/WxLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsgUWVnsTLALEjRHXSgMTR5OGDtoSrWuvxfOiRq576q6BRq7059b6mXWIrh+45xJkXM2RONiWggNDR/9Me2094JkNZ+ZjSMzg5zYxziG/aplAbhBysF1VKq2b+Uj5fcawLUcWLNCZuzqAMDr0eCvNsfbgsYsGIf5CRTeD8tZs6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFHvIklc; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1RCM+urUD+MSDAdRHoZOst1L9Gpf036TSk2xNwt1EgP6Nm6orKU8fcre8O7nqO4zVIZQriTBy0WHIUUOpBzU15M9j1+KRf88r6NOAZgNIv3N5c0Eg1jBBL/EqXvlGqdRCm7EOeOdgiyofFcYO7X9BMEJhzwsaCIYvuDnd/RnA3AkNBteFoaJC7DSgzhUaCcXBbqPqEmYcHGa3b23u+pSCqEyHTnL5SCWpLhO2Z/CMbmDYVRIFPdSEQc2GAri3GlAVzMs604otiykibsxpDXJ47o711UEDyl1DMq9ZcjmjG9Jnvpi8fGZGztFby8OT3dQ3Ai5FAwsqMExTFtSOF7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxdLcHNvsX7cVDs9wJmIfaO/rAtT6H/nURYKVFH2kRA=;
 b=EJ4eLmLwczB5FaKxDMqFBSe+0gRTvEdzGdh3bJieA2V9DlumhcOriTlbcCCqUsFU3G0pDYhYnTu6tv4SaLvtJg2S5AzFQaZCWV6wyl/IrI3eNSSaQvV+fZUQy2GXgWgNj4kLF1D1KwRJTbsIwE1HZk8KnoO4x0rba0ks56A6xsnqzMgcDdkVdr/1ZqSxeJkRRuQ/q/Mkaaaw6/qHOkFBCsqxpuVwX0KfdEMpbcBHJgwsp17gfZw1I8bnSxM6sGcebvyiUCxpw7boWhfxAQ+mteDJ9XNaHbb8U2PpsB+U0K2nWyWMS4+J8enO42pgB/kK7A2xyoTM0GMmu8QTA7pd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxdLcHNvsX7cVDs9wJmIfaO/rAtT6H/nURYKVFH2kRA=;
 b=vFHvIklcy/DhTTwu3U2qIko+DY7moI/Uc3Q01aJ8ud0kEs5Rd2VByRUowm+eWiDggZ4aFN2rTEjyS5D5asQiO+tvuhtbkejiMxc3q7+4qLKQHBNjSSpQdfdidfyimr1IJEwmUSefXt4qr6tQvlezNqu60aW2LF6ZnmdKe8QZ9PU=
Received: from CY5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:930:3::26)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:15:52 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::7b) by CY5PR20CA0007.outlook.office365.com
 (2603:10b6:930:3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:15:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:15:46 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:37 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/41] drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
Date: Tue, 26 May 2026 15:01:33 +0800
Message-ID: <20260526071413.2181251-11-ray.wu@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 406d7dc6-5474-43c7-ae5e-08debaf69eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CQjA4DdRe1jmlxkaM0uOIWW0VEP0jNDntISMzKdFJuYa58uzFZ4ZguoJyP5bjR72xdesNRsCEJiSzKb6dNr6DIy9ObZHTrfyTuAhGC4L7tl0/P60SOP6vkKHpBW5e4UN1RweXIOY3GNCEksRf9L1Y2YBk2Dt/zH+mGbJJoINF417HTFeZkGjUANkYK3VV8S2z1eh1KrPMyFeZBj0dImtvU9S5VF2P4oWXjpsBKQeePY1jaUaIQsQLDVjjttdfJay5FyalljsQ0xLDhIWfV95ngyrzPkpMTDPq6nQa10QJUw1WcpcPGEiR8u/hMjcX21itaL87PCPEdERvXmGqN1ig4RB+T37lAFZeixC58biS4cJi2YMXHl0055cKAtrkdPxBL/hmj+XG2bd3SV4mhRR0ErEUCO4r8hXPHnQy5bIZDiBAS2Ih99ZJVQKZsntrDaHSSuy5knV/LkUxilnvi2AIcDHmzJk0gvdh9mBfC/PTSmDdRbCynpmW6aKNEHoXfiufYGxV6PH0a98wV40TH5sCMCNp1/pLlXapzSPPFtve4yXM5rWj1faZ+DBVWYcCKS19IVHtATqLkYyQzlKobdmZCbB+48gMM0LjpoXOVVeZn6Yft7WRd0Jk68VRM2dSyG2/aak84arOp7C4C0dJ7Ezhh7NrqvZ4n7PXEbsWCo6zKlu/3X6GX018mq+AeDGRu+Hh4RUfv6YFEphEdsEbHeCJwh1vUcLLuZxGzVsbSA3HWw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IAkgmyXQRGDWX+IrIOr4m27aAagDOQFFUt88UUSRBFlt+52N2xfu+jKL7TRpaDXWrF4XWTxActneuCtylMYhJdpLdrpTV0rU/35prxHxaO4j8uvku8+4DF1OIcPKq4t3C4MuZ1sHVYUM2PDROZSPBe9i2Lmwc5kJQyTgSp6NZChfJ1FP19YefKT1KNdgQI9hSY+S7imkiSO60+KtrHx9bXckQYdd3AZqcfz1jwyT/kzPBvfiOOJ7n9yHSDJVRQTdU4Tgmjox1XW0jJPHWwbPCvJdh1CpqZVKl26mZpupLK/kFqzCJKfE0Fze3ni0FC4jqRkK2Cqvlg4ZavlIwgtLqvYivmMg52D0y5fw6706/rLio4G9VJcqA9YJ3wxwWNokUSGWDF5OX7mWUZADBxvuUTTIH7gn9VRKVFWB1sJcx6piw4NDMXlTzJwQG1129XPG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:51.9801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406d7dc6-5474-43c7-ae5e-08debaf69eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254254-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ray.wu@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E9D5C5D1994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot:Claude claude-4-opus

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 7e5c118b2f20..fbef0dc743ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1217,7 +1217,7 @@ struct dc_lttpr_caps {
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	union dp_alpm_lttpr_cap alpm;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 	uint8_t lttpr_ieee_oui[3]; // Always read from closest LTTPR to host
 	uint8_t lttpr_device_id[6]; // Always read from closest LTTPR to host
 };
-- 
2.43.0


