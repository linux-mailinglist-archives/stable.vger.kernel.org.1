Return-Path: <stable+bounces-245292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJN3MasIAmqTnQEAu9opvQ
	(envelope-from <stable+bounces-245292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:49:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4D512A2A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61F303222E2D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C5451064;
	Mon, 11 May 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bp4kmF4I"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A842EED9;
	Mon, 11 May 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517172; cv=fail; b=F7j3mDVZ/TPALxTMsT08OCfSYUSgis+8dNaRdqoJU7jJaKlqkiopWvhgdOm7EzWMydQj8bM9QRs103P7rhJD3gFzj3d/e7Rp/Fq1kljNsIvgx+bfZ/+pOs4DyRtaxVWimc33KiLGvF2hrofg3e9SwgwoSQlmWkhDPohTKXdkPwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517172; c=relaxed/simple;
	bh=wZKZX54XoyMIF3um1+BkJRMFSh3oRUemRf0dwpg422w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEat8wi9tUoWB6lBf6tAtav8pb6+aq8fXgsMwnpoWF7YyCXrbWj8UT1pnwFj3/Vzwxnuqy00uxksIvRzdaVSwV2+U2jEAv4pLyhpsfzxAH5CUW61OvOqp9Cscz+0nz9EMO//k6rR2quNaMaJJfdI5YI8c55r6+ZbsOuqWENiM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bp4kmF4I; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxloN8TWolRaI6pQe/jT6DKzudvbRVi2wdXeehS2bamjPKIb+/47lVHLWFggl02myOPiWIa/HtKr0CSS2NsiN8zk7uz+dT868+EuEnsQmMxZDYvar4sxHNlwNse/LxZZNhHoJKCjJnHfT6J7wPV4oyQdFpy/Ek/5QEdO6lf+vB0RprxCfBnjc24cdSb+2suBHiqWhoHQQO2QqF4uq1zNqwG+Jnr5sgfIRVSIKUAyv7UQU56pNyqBuEJf8kLrMFq84oterVkiXU8ay9Hql7Rj4gjkUMcD6GyAfc1Ss1lYPgBhLdN9ASt2YH3H7ayMXPlZ/IzK7KHtTn9x3g8F4LSXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsiAOzaQ74kaxjx+Uq0MGP8ePYcDdh1dNRqbJGdqF3c=;
 b=f3woYEQ5J72TFuDj7rNhge9CfZngwO29FtpM9SkIc3kEsV46hRtSIYxL58LS9odX9zquxUq4DfVp6tH2ekc2cv9HzeFMXn3K1drEWsbQ0gDHnjSTtuLPnyvgjaQE3p9K5nNgyZRPrpM72wI64OntlLyKykJSovo/kFpgm3379hy5SWUg5WkzbOrAiCEMJLgwrE1xLewT7tqGs2IZ0OgUX4QftdfHsmTtCfPf7iVVwPNNFyj33yPJ2yMssSqGzJcnXleOg73otO1wtGyZFZGRL1EubKwlmmGbBqlyhto9nAWLOsKDleRglDrtviPlHfyMhmHw3xosfyxfpeVHINcw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsiAOzaQ74kaxjx+Uq0MGP8ePYcDdh1dNRqbJGdqF3c=;
 b=bp4kmF4I9GZuFHODyYPjsD9+5oDV9BVB8atf1RHAIQsOdktBWXK6WvIbggdZ5NZe0ELljttdCQ4sLQTejcpM4aHnFrAxUNGUW2iM61Ie0e/adwzuTtUu391owB7yl2U/0l++8ZrCpcVsc7Ei2aqwkJZq/H2AMMScCxe8QixmyMo=
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:32:44 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::26) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 16:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 16:32:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 11:32:24 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 11:32:21 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
	<neil.armstrong@linaro.org>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 2/3] phy: zynqmp: use read-modify-write for SERDES scrambler bypass
Date: Mon, 11 May 2026 22:01:34 +0530
Message-ID: <20260511163135.2924642-3-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260511163135.2924642-1-radhey.shyam.pandey@amd.com>
References: <20260511163135.2924642-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: a14f4037-ff35-4eb8-83e4-08deaf7aedbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|3023799003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2506spoD3JHM9JRCVmKD8vDr7FUCxFKXh1+i4gSYygIh3YaRvnTYDVCi2aMbYmJHDhhFHo/QL6KnTNRvy+aQMlHDRgpz36+1w1LzedWLhjDYpCLYcyqKXgxlAsb5vPpl7AEirufTuGGbpPzlQC3ytWYfHovfRGLVjnNjrmVkjcr3HO9bLR+08zkRFZOHRO+o0n6dcdCUx9LtR2QD4XLa+kdVaFwW4xCUx6LfiHQK6Uqx9an4BFPHHfcppLwNaenPLiWYACXqlMmGta2gfV27DGiJqVUyEb0scAnJeTbL/Jb0UlyDZpx4K5HmQkIYpl5mZ5m+tJCHICLs19R8HVnwGyCyT8dHP+GmAjUSVixn4S/SY5Gkw8rdzUp64O1cLCJ+cRdD8v4gTmiC6Hyb8jxA3cf5RNngzDFgCUlju2u/BXdPo4EnxS6eAwMk6D72jI8sDzMWUwRpdioCjNQ4IknIq3qNWIj9R5SUGwtK5679ZevOyXbBJfh8xFEnOta6yPLsoMuwOT1Euy/5EzxP2NJYMVBmIc6UoScRmzP6ZVpk+UQahuCi0xteYDI8hpl6AYLeILKidHjvcnR0H/2pDzddaCbrwL6qbEVcfod+pqnMqPpKEAMwqklJLEvNuqOHRWklaiT5Sxfokw55ey/To2eKwFFggA0DPx6ISr7ikMIrfTQ2KK92Sz9N1t3ivfRGWNfLYxUkUX83qD2fJ85OfP+Sds5zfkfVTE1DI8CMOWILH5U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(3023799003)(11063799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4LvkrVA/+2t8WZk6P/JefUVcDo4ft3B2y82O7bOTXzfPiT76NdeLK95XGVusDjAhBSPBcyVAIBa77XZMpDWp7KHNdBSsM46F9hfuvxpi8SU0RbtiFT7tIiQajK72sDABkpfyT/WLskfAW/ZVU/MWb8HSUxcwrRwogcOZtn8GNXIBJcPlvEp9B0j2aQPOzWjYI47+hq4UC8OU8tv2cVQpxSxTnhksdb4yReT0p68dUB1zqfc88NmK8rUXavgqa/agGm4g+GOpY/pt0jOizrqx6TWo99dIzL9tUUv7Vzn545Lls5hYjN8L0XlEb/709vcnDaGfzzo7Qf76wTZAUKDEyjXViyEi+iyh4ZulwmMfn6Zqp9U5rDYN6kNAnXeddyj15blwGtntk4m2f63M6g8/UEcH/fT74+Pa2VXL9pGFLwpGUIt5U73f6lyVpa57HpXJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:32:44.2001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14f4037-ff35-4eb8-83e4-08deaf7aedbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
X-Rspamd-Queue-Id: 48F4D512A2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245292-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Nava kishore Manne <nava.kishore.manne@amd.com>

xpsgtr_bypass_scrambler_8b10b() used xpsgtr_write_phy() which performs
a full register write, silently clearing any bits beyond the intended
bypass control fields.

Switch to xpsgtr_clr_set_phy() with clr=mask, set=mask to set only
the bypass bits while preserving the remaining bits in each register.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index c037d7c13d48..6c56c4df8523 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -505,8 +505,12 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
 /* Bypass (de)scrambler and 8b/10b decoder and encoder. */
 static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
 {
-	xpsgtr_write_phy(gtr_phy, L0_TM_DIG_6, L0_TM_DIS_DESCRAMBLE_DECODER);
-	xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61, L0_TM_DISABLE_SCRAMBLE_ENCODER);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TM_DIG_6,
+			   L0_TM_DIS_DESCRAMBLE_DECODER,
+			   L0_TM_DIS_DESCRAMBLE_DECODER);
+	xpsgtr_clr_set_phy(gtr_phy, L0_TX_DIG_61,
+			   L0_TM_DISABLE_SCRAMBLE_ENCODER,
+			   L0_TM_DISABLE_SCRAMBLE_ENCODER);
 }
 
 /* DP-specific initialization. */
-- 
2.44.4


