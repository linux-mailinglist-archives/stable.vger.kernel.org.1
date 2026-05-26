Return-Path: <stable+bounces-254261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNvTFjVJFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:18:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A15D1A4A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DAC13036D58
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208593B7B8E;
	Tue, 26 May 2026 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W+58ALXU"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A23B38A1
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779825; cv=fail; b=jBAt8FAyDGXbo7ldkqeqVj6x+D6wLdXCsNUcaPwHzGDIbbWGcUTyZRKAffasPqF/rcaGdKpG1e5JW/vrkfAFVbkEVnnq69rySEoGnoQ1pKUWQMAN34g2DbZ76x2PB8ddQLw4bSR41phCxy7JWg66hFcRkfvxLoDWwT3oiu8Peaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779825; c=relaxed/simple;
	bh=Mt5HQEAiJiVh6ANQjqJGpeWhMf0hjkfAT1xtMd3u5r0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtCa7ea9kND46Vc3VT/5OYGXP+oicp/RzIftnHC0Ph2D2oNgk0SzMIukqsMn7ilTIs+ClnpG4McMVCPkygMTXaC2DiWp/ENlaFrHTv6YVeGJo0UGo+mgZ/azyBT4XK0WlUVH1K6f7jeNwsh2REWEbBO3CA0nndfaidOn5PyD020=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W+58ALXU; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVgXF9tFTyeI/cOpyt/xnjb3uvNLu+XkqMTiuPMmAqCGQyDZsRkVSZIRPb/3c7e7K9nxvhIEMHy10fq3+WVsDVtRuW+hs0+GarvLF3YF06GDvuN+aDzAGuVqXoD+Yea5faLQadGkKhUeMxBXqt9Fsuzsh927+frhFfOM20mWI3QSOWy15gIoMRzYkzQspezxp6+uybZZiJEm8ofFgkFaOV/CPIozingRFLnOHwM+Xvcp4F9PydQ5+ERlbD2YSF4HiJ4/tRuO2ADY5HSBdeyghng3m0VooLTtR63k/fl5/gS+m64CnpST8rtvjnqQfwbWUnS9KJ/tf6hlN6MaQZCDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96eyvPAVFHAROCJYcgDdlbsEmsuIBTbhSG0oH5sZRXI=;
 b=cztXuuyZWi3f/7J3rx8Zz01xr5GCRFSq+HlWNVIuFoNrBhUubmlhqz8ayr1VpY8yVgyuKJ+PphueSj9eVX2pKOPNGBmkn6T+7znZsurCalKGqZ+vmzPC8vBOxq/yhFLrbrZvwk9l7W3qXGvfaXN9PehacxOPCzLRTbEaLK7fUTjPVBURODx3pqxxAGUMPNrnsFidl5WghYLHz/y3dEB7b9j7jqA3CuNvM6g1eypdGwCMpKXdHhbFVcsuBBayqi6tn55ig2GBhS+1uMP69btZLZJMsLDiPyIvT9QeCw3MpcVhMOSozywKQKZOmetQ6kBpsWntM/qYxGQczxZYzCutXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96eyvPAVFHAROCJYcgDdlbsEmsuIBTbhSG0oH5sZRXI=;
 b=W+58ALXUUII5XOTdnJm6VkJeMBGYWz2i/n3/f/GCrZ5sWfP0CFVvciM5c94p7d/oa6SrLTmbVIGgrtelc47jeJxLkNO3qNqA9hDSabcsR8SpcSfQJhEH+LSJkQE60yNskC7DkHCoLujfYVr42yqX0Td4Vfz/wQ/xYOOn9QZfc7g=
Received: from PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::16)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:16:58 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::92) by PH8P223CA0026.outlook.office365.com
 (2603:10b6:510:2db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:16:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:16:57 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:49 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 18/41] drm/amd/display: Bound VBIOS record-chain walk loops
Date: Tue, 26 May 2026 15:01:41 +0800
Message-ID: <20260526071413.2181251-19-ray.wu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c4c172-3e5d-439f-7362-08debaf6c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RgblyovFNgyUFpRFIwuVxs5VWQzqcGO+8cCeG9jzfcM3Az2fofJmTY/hPn32BWam1Xw0e12gSaEpp9XXaNt3RohVqh1gG/vpRlajxZ9/Z3QI90xg0YzdGCy7ku2TuIrZ9Z8ZP0xsCbZduaf1wmIAN4s0SpvduFW/siPZlCreOt2vb+O35eZuc/CYBV1TAbwbrOwiYziew8bkW9/iZVzg5mEq9K7uNkOnpv+Tdhf5Wpz9QgY2FyaPPAoYPCZXLPv+lWq8PdmHcI+YZJeQ6hdF06tH/qECyz9WBCXKq4lg4zANCOoMnPDEoNzIBJQc+Y0QR8n1Ld7+MOns+g9UegHvhHI8NzYkOCOA1NNI5ZujLd9PkcV5GGTiNcOOJ2CM4HIQg3Or8VpEaErGzbhuyNJr4RlbwXnMg6pTq9VXsucMIzjEfCD6g5NNEm4C6o1zVuBTLKroZrRROTKXNc9SsmK2D/QjvIqEoDnTa45q8HSegc6ZI21BHJcJmCgqv6w4HqEOOTlrveLH39PyOt2QHWAE/dcE/iqLHQoVttxAQIhGpjtniOIKYZO84pLITFMypPNawnocvMiYI8lkoj4SrusUsOQxnNnEiMoHZiYHCNsJQCq2QRtenZMONHChadfIHpgopt8YSHi55ZgM2mMgAF+ZjIKcyRZIFNEu5nrLos2oRfPpvuInbZFfhLwEIWs2ZkQp43IGprnMkNgtIg2+4OnqJ5A/gwvRjYVUAeVqLChCnK8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rONuePSmZW4BvAQKMdbdB8pXJaaX1acV7K3V255ZzyIZaCmHm9ViPBG3D/cXz6Il9xrC8merL1beCA2s09NR2zUSq6crJwT8FVB5zeTC3TMCzaSWLm+v155PoGdLb21XDdOCxWBazOwLWrRGXHP/0P/jzmp253BZBUQC6GwafsFQUlvAceIhSzic3Kp3BksDgZXNGI/bVStpUWMQcFIbWlUZi7ucO4bqgOWCvie/TkjEAbKQx/lsnT6KpGrV6VigTPRfYsKaaiRA9cU+eE1fuagyYHmUTJdultMJUCS82K2DtqRkhxtYvLenPfX+niaVPg4RLiE3U+lCgtqGVexercF/DO/XwjDYLArxnTVUd006J1feAGluz99699FQ2hRBDPWv8AHQQf6g7GphOLxa1sxvF+9Hvw0/MBznQqkUVlhr/FShFnAq+G+XCSHzceZ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:58.3095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c4c172-3e5d-439f-7362-08debaf6c638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254261-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B21A15D1A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
All record-chain walk loops in bios_parser.c and bios_parser2.c use
for(;;) and only terminate on a 0xFF record_type sentinel or zero
record_size. A malformed VBIOS image missing the terminator record
causes unbounded iteration at probe time, potentially hundreds of
thousands of iterations with record_size=1. In the final iterations
near the BIOS image boundary, struct casts beyond the 2-byte header
validated by GET_IMAGE can also read out of bounds.

Cap all 14 record-chain walk loops to BIOS_MAX_NUM_RECORD (256)
iterations. The atombios.h defines up to 22 distinct record types
and atomfirmware.h has 13. Assuming an average of less than 10
records per type (which is reasonable since most are connector-
based) 256 is a generous upper bound.

Cc: stable@vger.kernel.org
Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Assisted-by: Copilot:claude-opus-4.6 Mythos

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 15 +++++++----
 .../drm/amd/display/dc/bios/bios_parser2.c    | 27 ++++++++++++-------
 .../amd/display/dc/bios/bios_parser_helper.h  |  5 ++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 2c7cca697f5f..2a9d0dfdf595 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -222,6 +222,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	ATOM_COMMON_RECORD_HEADER *header;
 	ATOM_I2C_RECORD *record;
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -234,7 +235,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -293,11 +294,12 @@ static enum bp_result bios_parser_get_device_tag_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -966,6 +968,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -975,7 +978,7 @@ static ATOM_HPD_INT_RECORD *get_hpd_record(struct bios_parser *bp,
 	offset = le16_to_cpu(object->usRecordOffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -1670,6 +1673,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 {
 	ATOM_COMMON_RECORD_HEADER *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -1679,7 +1683,7 @@ static ATOM_ENCODER_CAP_RECORD_V2 *get_encoder_cap_record(
 	offset = le16_to_cpu(object->usRecordOffset)
 					+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, offset);
 
 		if (!header)
@@ -2733,6 +2737,7 @@ static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
 {
 	(void)i;
 	unsigned int j;
+	unsigned int n;
 	struct bios_parser *bp;
 	ATOM_BRACKET_LAYOUT_RECORD *record;
 	ATOM_COMMON_RECORD_HEADER *record_header;
@@ -2742,7 +2747,7 @@ static enum bp_result update_slot_layout_info(struct dc_bios *dcb,
 	record = NULL;
 	record_header = NULL;
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
 		if (record_header == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9fb19f75e934..c02fb2ca0317 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -396,6 +396,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_i2c_record *record;
 	struct atom_i2c_record dummy_record = {0};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	int i;
 
 	if (!info)
 		return BP_RESULT_BADINPUT;
@@ -429,7 +430,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 		break;
 	}
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -534,6 +535,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(struct bios_parser
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -542,7 +544,7 @@ static struct atom_hpd_int_record *get_hpd_record_for_path_v3(struct bios_parser
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -611,6 +613,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -620,7 +623,7 @@ static struct atom_hpd_int_record *get_hpd_record(
 	offset = le16_to_cpu(object->disp_recordoffset)
 			+ bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2195,6 +2198,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2203,7 +2207,7 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 
 	offset = object->encoder_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2232,6 +2236,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2240,7 +2245,7 @@ static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2268,6 +2273,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(struct bios_
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2276,7 +2282,7 @@ static struct atom_connector_caps_record *get_connector_caps_record(struct bios_
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -2354,6 +2360,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(struct
 {
 	struct atom_common_record_header *header;
 	uint32_t offset;
+	int i;
 
 	if (!object) {
 		BREAK_TO_DEBUGGER(); /* Invalid object */
@@ -2362,7 +2369,7 @@ static struct atom_connector_speed_record *get_connector_speed_cap_record(struct
 
 	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
 
-	for (;;) {
+	for (i = 0; i < BIOS_MAX_NUM_RECORD; i++) {
 		header = GET_IMAGE(struct atom_common_record_header, offset);
 
 		if (!header)
@@ -3246,6 +3253,7 @@ static enum bp_result update_slot_layout_info(
 {
 	unsigned int record_offset;
 	unsigned int j;
+	unsigned int n;
 	struct atom_display_object_path_v2 *object;
 	struct atom_bracket_layout_record *record;
 	struct atom_common_record_header *record_header;
@@ -3267,7 +3275,7 @@ static enum bp_result update_slot_layout_info(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
@@ -3361,6 +3369,7 @@ static enum bp_result update_slot_layout_info_v2(
 	struct slot_layout_info *slot_layout_info)
 {
 	unsigned int record_offset;
+	unsigned int n;
 	struct atom_display_object_path_v3 *object;
 	struct atom_bracket_layout_record_v2 *record;
 	struct atom_common_record_header *record_header;
@@ -3383,7 +3392,7 @@ static enum bp_result update_slot_layout_info_v2(
 		(object->disp_recordoffset) +
 		(unsigned int)(bp->object_info_tbl_offset);
 
-	for (;;) {
+	for (n = 0; n < BIOS_MAX_NUM_RECORD; n++) {
 
 		record_header = (struct atom_common_record_header *)
 			GET_IMAGE(struct atom_common_record_header,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
index ab162f2fe577..19fd7aea18f1 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
@@ -37,4 +37,9 @@ void bios_set_scratch_critical_state(struct dc_bios *bios, bool state);
 
 #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offset, sizeof(type)))
 
+/* Upper bound on the number of records in a VBIOS record chain. Prevents
+ * unbounded looping if the VBIOS image is malformed and lacks a terminator.
+ */
+#define BIOS_MAX_NUM_RECORD 256
+
 #endif
-- 
2.43.0


