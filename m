Return-Path: <stable+bounces-245294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC1mKCIHAmp2nQEAu9opvQ
	(envelope-from <stable+bounces-245294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:43:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EEF51282B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FCBB30ED763
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545DC43CEF7;
	Mon, 11 May 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O+QRZRqx"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F547B429;
	Mon, 11 May 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517189; cv=fail; b=lvpAqzjGcSSWXy1eGc1Vu5PlbK6N1YPn3HKre5tuJ7Fv4b6KBm/ZmQn5/jIpgLDFLmtJ8y64MRnOcJ2GaSOjWHD/aU5AjODwXVCXSZFs4OMKedNRgSKoDyK+hOv/YUZ18ZazSD4rFPGbtwBWGllFck+3L4iiFJTvNZWaS3XWVMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517189; c=relaxed/simple;
	bh=EqwMtV4cwH/I5F9YPgMoG9pTP5/zsFcC5Z6kwpRT5wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYclu/M1vgfvMd3KH6ah0X7DV9kxO3bhIKB7T+MD3cdHaPuikKeCiG4gf0wqzAES1pnuTZl5oUiZbZNbckVDQCFunKYqgPnfldGHBYsmNeAkEUzCVmFLCZtEGO94qRcK5uaBbAyHEbjj8GOPhg+WAlgi4HlnDZfjX9kGqdcHu8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O+QRZRqx; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcqNiG+CMMHU3rfXwH2iG1wF7FFzwJeet4gRlCaN8xgKp01HypAoiWCO7KuahpsvlJtAbKvE1x+eli8THa6ICC+rjcvjptXk+FWNfDOjtHLS1h36FvA13J1dnZ9ycGjFGqysM0JDYQhd7qArzsMxoPwPcC5R0G3eSlL/xIhVesWo6+L23YVzUeW7jr1ULmfZ0nxqWrYg5ctBYxJMPBtho58d9Kb5wc2yM5BMEIiRM6DPe4A5jfaL11V8E5ypJZkYVuYpCBX7Jk5WM44uH5mijNO69Wt0FV+9YUB2ae4/xYpKojTzNAamXbGeTcUPmJl9EkbQDaodX3qnDJWDLaLk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vau+agOGPE/0eA03S+pf3NTi4uwetT8K5GjSz2ATBzU=;
 b=UU5c2FY/Ejn2JU+yhnh7EnKN2VNu+Zuki2lW1UAmjicg+iIWv7ZBG1irH48Ik9upvJ7mABSq1I8Bd759PTtRnJkjlNfLp+T/y99ZryiFm06mZqBUJ88wX+J+PXCK6ETuja0+PJRMyD2yKhwuXA/OBMRWqhmB3RfQ3g5we4pYUeaPhUvmnjujqaZsOFFlq2Ii222dsaahsEboLJ+xVgLuUWiwq2HvPBKIo7Sa1fOAp1ZYFaZNXR1mY2bpiK9dzHIYPqkb69q0quRTbh3KnomLUkaahJhkfre7fUVHEnK4N/ZU3Pc9EuFb6deV9mS+MYA67/oJrhn6OJBy3emCoJnyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vau+agOGPE/0eA03S+pf3NTi4uwetT8K5GjSz2ATBzU=;
 b=O+QRZRqxTeQHjsC8Bs0kd2O4VYqF3i/5eoAAD8upSNgA7wZdqimN02Wbz0N+tCTWOUVSaP+MKcIDEuivlBF2eOKMLxfRwz07dDkAMZ9SxWIVvPg4xY1xZDKEiPaFtG2MFL0GJ23rwqHMPJKP7/wO1JgpPmH56BKIuFZWIS9vdpM=
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 16:33:03 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::ac) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 16:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 16:33:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 11:32:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 09:32:08 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 11:32:05 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>,
	<neil.armstrong@linaro.org>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <git@amd.com>, Nava kishore Manne
	<nava.kishore.manne@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 1/3] phy: zynqmp: fix L0_TM_DISABLE_SCRAMBLE_ENCODER mask
Date: Mon, 11 May 2026 22:01:33 +0530
Message-ID: <20260511163135.2924642-2-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbbc1c6-15b3-405a-706f-08deaf7af8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|10086099003|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XPw2zVkwUVMKtgBfckbzflHLKynmKjMKa8VzuSR1lJgSmatERSBITI1MCKpY+f7BqwhYkIkVnJRPJCPFk097WiQ/B7UsNyEdOt7oROF/mqOuG/pKBUcMRC2kS6WgS0VSvEGQ3nKgIRORQ4c5ZtJF/ow1SeA06dnVK1yfnHCEoXhybOYStHC2SNpD6PKuq/VI4IUfnlrGHAB1FRQlgC7vx7Fe8khaMqb0n5kZnKZV6My2brTeXpaLH6b/R08TUfQrWsh92MzyaLxP15ALTJPRUKuLQUMCxQzZlfBEeUt81gjcoQFgwANJg7e6cd0N6yHGxFAGEYGHBs4nR0plWkoua5c8nCT5uEzl5uyAQn7s2qsHqjyrXXB/HtjL7aEE+8Vw0W1x5uF2DWV2uoqfuGCprugYZ5VXcwE0BsJEsSbILaSN11693y0jwX2nRP0JFheLS1I9hfaUBXaVyPQpsRWOYqQmNtp6bjyez+o/ZuSECYPoqQBQ9F5lFm5khkfuhheV9dPVEW/JmERaXIjClVI9dyt64mgHAG+nh+TtmmvWgFx7nx+hIVNfAiPSZC/0+Nm+dRRe/e9PIYNR5fUpxkupcIro7TtkMype6emJ+WYJ2T7NZjRCLMFCFRUeDnVEKKbyNWfY/67BuI1cXkyP3bZ5Br9pdbH1/sRl5XqUaIWYEJ5/AQ/KPFTjbHxv130ykZPeu+1MY68txjaO9A/Q/T6oJeCnenpHYqodHkMtzib7rcc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(10086099003)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uEr1rmZkZ52ImDjSzuhD+HAQKuE/Iu1TNEHX5mEwXV+JY+ibHT0gkWer41dx9MuDBFgszNJH3icLT5kcqgloL5vlhskRRvUns/Fyp0pnHsXfVcg9HPV5EZOqUEgczFF7KbfbETrPUSjlL9Ebsy45572I0/piWLk+NuJaxXQAaPxXPrpfIqOE0QqnpWOdB1cHifR3n1jkq6Fjg2JLImBN93H/WOkPtcy6b2fpl3OyDN4fkJKbx6m+b/19K4bj/1vMN2V7g+uJos/S5G3APU0F8whWBznCmVu48894KAtJx0J6SYuOM2ZbaVK0DhZ/OjxVrme6gifjckqJf/MvUyPHIKFuj9DfRPRM5kWhzej1ELhc5BGRAFfKnG01oBMlXHbD+XRJZeyB5LuuhT0sr70u90u2ciYYewvyp671JoArlkQ21abob4shOK9Cwwz6f9O5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:33:03.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbbc1c6-15b3-405a-706f-08deaf7af8f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-Rspamd-Queue-Id: 60EEF51282B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245294-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Nava kishore Manne <nava.kishore.manne@amd.com>

The L0_TX_DIG_61 register bit 2 is a reserved read-only field.
The previous mask value 0x0f incorrectly included bit 2, causing
unintended writes to a reserved bit on every scrambler bypass
operation.

Correct the mask to (BIT(3) | GENMASK(1, 0)) to cover only the
valid scramble bypass control bits.

Fixes: 4a33bea00314 ("phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver")
Cc: stable@vger.kernel.org
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index fe6b4925d166..c037d7c13d48 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -53,7 +53,7 @@
 #define L0_TM_DIG_6			0x106c
 #define L0_TM_DIS_DESCRAMBLE_DECODER	0x0f
 #define L0_TX_DIG_61			0x00f4
-#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0f
+#define L0_TM_DISABLE_SCRAMBLE_ENCODER	(BIT(3) | GENMASK(1, 0))
 
 /* PLL Test Mode register parameters */
 #define L0_TM_PLL_DIG_37		0x2094
-- 
2.44.4


