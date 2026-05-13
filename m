Return-Path: <stable+bounces-246884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hu3JiWNBGqvLQIAu9opvQ
	(envelope-from <stable+bounces-246884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:39:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81D535417
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E00C8307F6A7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9443E9C3;
	Wed, 13 May 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5hoDLRd"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565144BCAF
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682840; cv=fail; b=P+QJsf77v0nSd2wlOjfap/DZ1Ki/zRjyWdZ4k8z6LiQuXkx7lbCcFCIT7OBPOt2asIjxojlVS2lkUNihSU++9EPaJ0w/CVZ1OjjvgBbMTehZS1vG1dzsZEqWbgZ30+A05vHxoofGruxWP9nwBcNiqHp5L7cKr60z1LA83/sccTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682840; c=relaxed/simple;
	bh=dWot0XW65rtsphJZBjvp15PRiQzs7kQRzTuTxA58wAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYfZxYDlO51Y2sLaYdpfivg0jUPD4ZrfqKGkUK7CpV3DmS0KZV5WWC9TXCia+vmhengUikgOvhPbwTlvCWdJ2AJieVnjGEnCHj1PL8aIfTn4NLOiKbTB/ewXGZ+3y6luKBOidiRA78ILOduh32EfADBgTSkOyiKaxKyZzafNGgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5hoDLRd; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHNsDCcUwjkp6TZHywA08o+gocRxdz6/J6+iyAG01Lb4Ix3VN9f/Bj/GALpUqTIbxxBtk/olg2SYvqCkmKTlSUFQkMprSkpnP95zPCCtQJ6VYjovFGJEVBH8ec4v4eY23NGrQo8wo0B4qnfRC9qktxBLg3dwqIzgOjIk99g8ZsGfLMVyKkux8vBYILqnVPqgMGXmhGmtEHeof4BrJMxSDKUdM7RWzuMOzu77YZ3bEVuV3092FkkSPMpldXaYke13kTnDRmhXvV5oKoiDq4Azu98y+b808vNOfD6PrcBvbihgJ7cWHQKth9wGvrLqGO0zji8V82vDmGos+25tMaeh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC7pUqZ/I3IEtdJR3nbOXf3Ihtb+bvgvfCTXvYb41xg=;
 b=rB7/LjWrSWAaZEZGBAIuRJrvZvmfjhGrVEEDOpI+FxJTY9JZUgS85PsHReccts0iM8wB05e2sl4/qv2B0vXxqI001ce2MILN5alSy0EPEdjehclnUT9i4zTqRaQvSAtdk8/LDZSMzDgxCZvL6PCAz6egEaNQqsoNpjwdk6nW02+LFShZJ6Ndl1M96ZWf4HjoabJOvZe/2R2DpW+fJag643l8kXebsl3m7rw+cL2IDmQID1A5h7y8Z4h+dF9+60OyDQuIiO3Pcy+34IqDqiaw0FBrnKUGJpYZdaCEifvZO3SlqcIrhGshiQrVY2Vsm/DFXXQaF88OClAOnLGkuAHm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC7pUqZ/I3IEtdJR3nbOXf3Ihtb+bvgvfCTXvYb41xg=;
 b=g5hoDLRdyS7HSXuVphCiB1djCyTg2Hipw9MV118XxIYCijPwJagxKbjgrLIXIM2AJdv5QgFwcRa9TsTA4hcbNhHdisg7bGEdsrvAOjqyvtpKTl579pqvj6e4gNmqvXDFmrWqxWM1+h8G1SWnwltaoOGTd/Mne0aI8BtBF1xi2wc=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:48 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::74) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:41 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:41 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 26/28] drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async
Date: Wed, 13 May 2026 10:29:48 -0400
Message-ID: <20260513143213.1852892-28-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf46241-0eb2-45d0-5fb7-08deb0fca554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x0GhStvRmsODOlsiZh+DklpMA2IS1J3ArZRKX9DN+1pcRzfRbCz+yeTaqA2Ql5TvswQZLLe/H2Z7VN6a9KfEdPX7VQJImeRtGeZp657ZtFjw/FitSFXNWlTszSWJzVQu7isZzsvvpZgH9IJ8FMRlxBVeH5kinXe47VABuD/LQTcbFFKp+S8AYWiuGRcHK2+9hXxfSlCMOO+Ci1EYmC1RmnGrly4MgBzKyLlAOYtFewgxh2zX2R6j6GNXbf03EhNelG9obqbBlG3+V1bfk7eytoY5FMsAE0+lMrTdKtXQCL+56zNSE0ZqpUvcii/heH9ObMv8ds3UBYEB9JOzAgFjQnZNooe8KhPOUbNyjdFKKf9PCko0gjP3iB7SRZh+aZcWMj2gIA9QKDegUsSNWsxn1SHp3uCbgpQS7hgAZR2yRTwWk7oo9RKixQzbsPlxRAzC0IwKtuPq4lpED1Up5Zp5Rx9yxsXXpHAFDt3KU7vbVdQlDbZNIuUnnjL6YsY9q4Bn6zGw3mvTDtILli9hnqdQUDFr4X1t9nJy0E9C3sBrLjPheP8W4CPMmLu6AjSn3a4X5yuovvEP1o+xNdGkyMSj5PjDOYMMDkSVp4G0bBRfNQ5/YNtXsGnso73q4w8An/fYO/0gjhyT7+OBGwjh/IeRBH4GGm+/BL0yIWtPjdO+U/orSKdamKxckiEB5FAwegrZElP5HbozrlRkNhXVc8Weq/HSNSgUlXIYaEm1g1/W5Ik=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(11063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aPEUihs4jL2iqex2B17tj+du/kxINFeaox593mbw6lvGqs9wOnife9vAC668Z9Zo1FwAy5wCB4AJHBJ9os8a14xXRNcJ9mA7DM2Lery/3HtIiS9fUQdQteTlpwZVa9fqUrHQGYSTN+MFkQcIc1nbiniG4/VBGsShTKuxQH8+VL5FXG/lRShqNpV5tAciYj+GndYOKgC6Hp6XCWePWoLWED6a7d27K/W3RZXx6GVTMsOR4rwmyvaw4LP5gnM0t5VTlnoQsCK5sNNHd2YH8+5GZ4dQM3PlDyBAGH8kwZzbdIfqChv9mvXc6z9y+HyPMa3DJTubN7dOL5srHttbg9YCkfBe3Fhld57/1VaJzWJNTj8wXUHbMUKscApybqzFm2FOG6C855MBHIdCHDFizACE4U57YzOyDY8lHB7Rvmw7STHYYuiudly9/RDX/gXRPZaf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:48.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf46241-0eb2-45d0-5fb7-08deb0fca554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Rspamd-Queue-Id: 1C81D535417
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-246884-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dpaux.data:url,amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[IVAN.LIPSKI@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
dc_process_dmub_aux_transfer_async() copies payload->length bytes into a
16-byte stack buffer (dpaux.data[16]) guarded only by an ASSERT(), which
is a no-op in release builds. If a caller ever passes length > 16 this
results in a stack buffer overflow via memcpy.

Additionally, link_index is used to dereference dc->links[] without
bounds checking against dc->link_count, risking an out-of-bounds access.

Replace the ASSERT with a hard runtime check that returns false when
payload->length exceeds the destination buffer size, and add a bounds
check for link_index before it is used.

Cc: stable@vger.kernel.org

Assisted-by: GitHub Copilot:Claude claude-4-opus

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 48d32adb9eb3..0f37209c8330 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6615,7 +6615,11 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	uint8_t action;
 	union dmub_rb_cmd cmd = {0};
 
-	ASSERT(payload->length <= 16);
+	if (link_index >= dc->link_count || !dc->links[link_index])
+		return false;
+
+	if (payload->length > sizeof(cmd.dp_aux_access.aux_control.dpaux.data))
+		return false;
 
 	cmd.dp_aux_access.header.type = DMUB_CMD__DP_AUX_ACCESS;
 	cmd.dp_aux_access.header.payload_bytes = 0;
-- 
2.43.0


