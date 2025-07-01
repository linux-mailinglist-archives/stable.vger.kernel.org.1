Return-Path: <stable+bounces-159162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86132AF0159
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A947A1769
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D027D770;
	Tue,  1 Jul 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DarWGrQo"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF51F3B83
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389849; cv=fail; b=dTuJdOa+9or8lSQCMhBrF8wUSDHFbp7v2rMKEROgQIBGWnhSkejYLcHp0t5t14/vJp3ZuP2cu0hMlEiwhrQEhslI/JqZKRWnBjt1Phl0rcp/pbiC+e6BkWjfNlEChuna/3QXH5N4pnX6555eJzN7MrBKKLXhmObUjyFUfTxkNUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389849; c=relaxed/simple;
	bh=VT84rU19bS4PpbC08K6PWW8DxAHj457XOL6bwCS6tGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAMUK5c9J0P4Cmk7O66pJVJcI8l6PuSw8YRvY3C3fZjFAac512Kih4NPN4felBS9tsNi3sW+gobHk/o7rPuqPaM86DLnhIYpnrTr/gR8Xhtz4Pm7W3EeCsskqr1aEwIcY9ofMp6TzYQnWkLlajdYKijU+4YgOhJKZA5UpVTlxG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DarWGrQo; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtcQ7nzipM7kXBz7q44d57N5FuqvcG20jv6PcXrcZE2eltux3nQcJojsPByGab698fHJ35kf7dPeAJaUHfG97Xc3MIf6nILNVqdVRUj4Nf/VQT5Zp5HU7YR9uRRbfJY0kde7dMhiNIfFT2vlXQTKN3wdlIvE6K8DUaOauy1ppiRh4G6P+y8p68yV/7Y83f7escFL+IQh+tq78dqPZrQUvcumhZfNybEza0k4fxX2V4bMQd74BF3kgFvoD2JQ1ULgPA6XFzA+vZTLdm7z9+3dhIXDoDAIBfrvREyft9QqfzO+eofXp1h/nODsxqXqMJLosVr2t7fSI9329qf0bYSDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74usTFKs3+c820WnLzQclTdlI2Wixe7H6TcPfzoFy30=;
 b=aP6leE7Wyl0BzCiZzKmnTNZuW2z4k9krwF7+CfAj3MlR8j2Lrxn6pbzPK5/+gFcPY2fEbUl5x2kZwKU2ECcqydej9ub4YRwfnVsFRdAX7Sm9hC8cE0GETavR7v5aGSi6gEAWFcGqk5tfGm2mxCMY8QcXd3W+Zo8fNnvO1ENeD1H58KU9DY32svmYkkjs3xqKwkdRlR/yRBz9fcBVtVvTzK6LaT+pkX/+YU7drMKV7huKoH18Qg0mpXJa4vQuL87O3OxQEElhqtDiISVMTATW+zNU7ihdZwVXCaF7AxveWlQ9sYmdA6Pj/PSy8Oq6e97TbdjHd9DOtqa6SfqCy/Y7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74usTFKs3+c820WnLzQclTdlI2Wixe7H6TcPfzoFy30=;
 b=DarWGrQoVR2OZj57wsvwqWfSBFDAQi0RXVKRoDz0jE6pXsSv1uv/RSlZPCyf14hZKtiStbu2ae08UyTyHOemi9V1Zk4NDWQqrF85oK6QUAmrYzP9MTGy8NGzPhdmhUUOJa3wgM5iDxXLz56htuzKa09uo7R7JQWzaUdFAKhM6ag=
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 17:10:45 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::e) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.26 via Frontend Transport; Tue,
 1 Jul 2025 17:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 17:10:44 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Jul 2025 12:10:43 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <stable@vger.kernel.org>
CC: <avadhut.naik@amd.com>, <gregkh@linuxfoundation.org>,
	=?UTF-8?q?=C5=BDilvinas=20=C5=BDaltiena?= <zilvinas@natrix.lt>, "Borislav
 Petkov" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Tue, 1 Jul 2025 17:10:32 +0000
Message-ID: <20250701171032.2470518-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025063022-frail-ceremony-f06e@gregkh>
References: <2025063022-frail-ceremony-f06e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab8fcfb-b0e5-4611-4e73-08ddb8c23709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3dKZTZsczg0d0RIT2JJRDQvNWdSMnVBT1lEcldOVkVBelNnT2ZleFhhV1ox?=
 =?utf-8?B?WHQwVWN4TEtnN3RpS21hRUo0K2VMd2FVbEM3UFRSTXpLS1JnVHFCbDdRTG5J?=
 =?utf-8?B?UjBYOE9reDN5aGdpMWhJVUwxY3QxbzArNWppNjIvL2R0ZXorL2ZpRm4zalc1?=
 =?utf-8?B?bVpHaVltalVTdW9ndXhUbFkrcDY4U0MvMENmNTBVRVV1SXBXd1FnZ2ZObGZT?=
 =?utf-8?B?UXM1MUp3eWtHTVV2cFZ2ajJUYS9sTnMxby82ZXdGQVJMMlZ3dkRLSTlGVHZR?=
 =?utf-8?B?SmpzeUZ6R0w4K3VDaEVUQzArN1c5aHplSzRhU3dOMlpKZGFhRFVvamhkTjNJ?=
 =?utf-8?B?TU1HTGN2NndJOFJQa0pQdkVxSzBoWFFZVld4czl5elgxN200ajM3R01nNzI5?=
 =?utf-8?B?NGY5UWVVQm5RSWJOSElRckM4RE16YU1PMlNPZnl5VlVOQ1VTQVUwMFpmMUM4?=
 =?utf-8?B?TDR6K0ErRHBHb2QvYWlJWkVQNEJNWVQwY1V4WXBOODZBdndMYm9lYjhQSEk1?=
 =?utf-8?B?eHphOW9sWWxyL2tENnU4U0hqMERPRXQyZ1orVHdrNVdhLzkwSEJkeS9OejVt?=
 =?utf-8?B?SEE0amZYaVM3bEtyRVgvemRmb0g0RStac1JqTnJuSUdVWS92eGZNTkJZdklS?=
 =?utf-8?B?dStwUWlwaUthTFk5MDB4a2tmU3RLN0NpbStpUnV3U0ZpNE5VQjJWcG1jaXVC?=
 =?utf-8?B?WnZsR0crbW9XU0MrR09nSk81TDgvSGxXRnRNOWFJNEtzNGczY2RBSzBkMEUy?=
 =?utf-8?B?eFpBYzRGSGhKdUpJTldDK1BYQTFsWWJQclM5dVZNRzhjSG41YWorSHBNSjQr?=
 =?utf-8?B?VStxWGRFR3FZcHl4R1V3TnpLU3BRdnFlbnUxTzMzZ0p6anpWWmxUYmk0a0tL?=
 =?utf-8?B?MzIvNkJVaHZPMG1jdGpLRUNPT0hUSkViRGxTZlVTdEIwd0dIUStpMmh2eWh2?=
 =?utf-8?B?dGZ4dllqaVc2RkNqbXQ5U2Mvakh1OW1aQjVZWFRVT045ZEZkNmVyL0hBKzJD?=
 =?utf-8?B?NU1KVFNtZlJvZDg5U01tRkIwMGUvSC80eCsvN2RSS2ZZMjgwUWNBRkhPak8v?=
 =?utf-8?B?QmptOTZrYkV6NDJvQzBTSmt5RkJLOTA3Y1VkVUxYNnFSanpmd29JRU5TVFpk?=
 =?utf-8?B?UE1HNlYxK1VrRzJKRGFlOTM5ZVM0dStxcjhpbmVVdnVWNVhKSWZ5ODlXak4y?=
 =?utf-8?B?V1F4cVUvaWtrSW0rbDYxYTFuYk9BeXF3dUgzV24za016WU9ackJsYXVmODBY?=
 =?utf-8?B?YXJsTXcyNEhDNUc1VHo4NE5IZEYzV1Iyck9zNjlqRHgvNlYrNkFKY1o4eG1Q?=
 =?utf-8?B?blQ2T3ZKTURJbTVzaFl5b3kwZDJMMDM1QUUxSUJ2aEc2ZjJad3pZQ0pQNHVt?=
 =?utf-8?B?cmtQbXNrWEd1NFdSMjlMNDN0bE1mRFgzQ1RkRzdVcnRBNS9OMnU2L1lOelJ4?=
 =?utf-8?B?c3JkaWFEWngraytnS2hwQW1rNHhaM1lFcGdHVDRDUVM2ZVlDL21aYzlVcitC?=
 =?utf-8?B?cWVKd09zbHBKcFFqVnFHTGo0Yk52TnpTTHFVZllsaTAzOWNVOUt3WWlyYUcv?=
 =?utf-8?B?bmlPeUdPL3hxdVc2azNBODluT2tDRFd2U0RWclY5dDVxQWx4K3ptdDFhYXkv?=
 =?utf-8?B?RjlIMTZibHlYR0xKNjN1cVVGSU05aXFPbkNmd1B1eDBiNk81UTZjQXNSdnZN?=
 =?utf-8?B?YXdNKzh0QjVCUUE1ZDI5TnJORkxGQmlMOW9xbDQwTjYzd1pkOXJ5d3ZjZGJj?=
 =?utf-8?B?cFl5NlJoM0dCSVRha1dtVitvcHNPN0NMWXB2WlU2bkdFVFFrR3pRYU03SjJi?=
 =?utf-8?B?QWxYTWszV3h5VGkzQm9xVTVLL2xmZlRxM1ZqWkdHVTdHeXpjQnFlSTVrcm9Z?=
 =?utf-8?B?U2xsWHVwVjJIM2VIRUo2RzJkVERRdS9LNkMwQ1U4YkkwSDROa3Y5OUY5MDgy?=
 =?utf-8?B?NmQ5YzFLRzY1cE92N3psTWlwUVA5Qy9tcFZhR3loYys0OFhXWE5uVFpIL2xU?=
 =?utf-8?B?cWVPMVZ4MUVIbGg1OHg5UlM3aXJFc2ZvWU5BZUkxSHA4bHhoR1RSWXFhVmJC?=
 =?utf-8?B?bzdoaW82eXRpNjRrTzN5M0JpeTRnbm5PZit6UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:10:44.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab8fcfb-b0e5-4611-4e73-08ddb8c23709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
SOCs has an Address Mask and a Secondary Address Mask register associated with
it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
during init using these two registers.

Currently, the module primarily considers only the Address Mask register for
computing DIMM sizes. The Secondary Address Mask register is only considered
for odd CS. Additionally, if it has been considered, the Address Mask register
is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
total capacity is a power of two (32GB, 64GB, etc), this is not an issue
since only the Address Mask register is used.

For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
in conjunction with the Address Mask register. However, since the module only
considers either of the two registers for a CS, the size computed by the
module is incorrect. The Secondary Address Mask register is not considered for
even CS, and the Address Mask register is not considered for odd CS.

Introduce a new helper function so that both Address Mask and Secondary
Address Mask registers are considered, when valid, for computing DIMM sizes.
Furthermore, also rename some variables for greater clarity.

Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
(cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 72 ++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..dd48e8a2d1cb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1371,7 +1371,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_PRIMARY;
 
-	/* Asymmetric dual-rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |= CS_EVEN_SECONDARY;
+
 	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_SECONDARY;
 
@@ -2191,11 +2193,41 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
+static int calculate_cs_size(u32 mask, unsigned int cs_mode)
+{
+	int msb, weight, num_zero_bits;
+	u32 deinterleaved_mask;
+
+	if (!mask)
+		return 0;
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
+	 */
+
+	msb = fls(mask) - 1;
+	weight = hweight_long(mask);
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
+
+	/* Take the number of zero bits off from the top of the mask. */
+	deinterleaved_mask = GENMASK_ULL(msb - num_zero_bits, 1);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
+
+	return (deinterleaved_mask >> 2) + 1;
+}
+
 static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
+	u32 addr_mask = 0, addr_mask_sec = 0;
 	int cs_mask_nr = csrow_nr;
 	int dimm, size = 0;
 
@@ -2234,36 +2266,20 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	if (!fam_type->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
+		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
 
-	/*
-	 * The number of zero bits in the mask is equal to the number of bits
-	 * in a full mask minus the number of bits in the current mask.
-	 *
-	 * The MSB is the number of bits in the full mask because BIT[0] is
-	 * always 0.
-	 *
-	 * In the special 3 Rank interleaving case, a single bit is flipped
-	 * without swapping with the most significant bit. This can be handled
-	 * by keeping the MSB where it is and ignoring the single zero bit.
-	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
-
-	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
+		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 
 	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
 
 	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+	size = calculate_cs_size(addr_mask, cs_mode);
+
+	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
+	size += calculate_cs_size(addr_mask_sec, cs_mode);
 
 	/* Return size in MBs. */
 	return size >> 10;
-- 
2.43.0


