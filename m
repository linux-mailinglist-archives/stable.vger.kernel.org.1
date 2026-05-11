Return-Path: <stable+bounces-245277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPMTOisIAmqTnQEAu9opvQ
	(envelope-from <stable+bounces-245277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:47:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F351297F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4763115F4B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FA43E495;
	Mon, 11 May 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ri5SD8pf"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12243DA53;
	Mon, 11 May 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515741; cv=fail; b=PcxDPRlnTi/TFWrDrTTrERRB518ZpOH08LVbAS9sNiaTX8LSZ6lTMb8zrXMBMVTLwSNi46Cs/CxA83BQKVPRCmbpEysHPHsB2fm0uQzWKtfKT9KZc6ipJlflhowPdIxZ1d5Lamqb/h4T2fuRy7v6b6FKpNl8blij8bIbhGGz44Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515741; c=relaxed/simple;
	bh=OO2s0NXFTywGOCRlvnC1hhDjFFCvcwKO07Dd2DexLKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgGkI/5dMKBYOL5DZegGNfRhduYrwGyau1dLbwktXMOw+8gzLAWhBbeIzliO99yZveLnOWVGq5wkAsPUl0kroBSsft3MWrnOl+8SRsEJBOiJRVeMkq5aC4Gkpol9Em4uRuLZ0gL/IGfw+E+j3zsKdBIDICpFe/QjL0aRBWmpgfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ri5SD8pf; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtIaTvMKhS6R4tsqzI2g528i6zQJK7irSqWXrY7f9N11FotOv7RAvMSkqIGFYaeeACwdQ9/mIrWbbpkEJFGgHYgKFEKxFhhwWkFWRDfiL7+hP/tPErnWR+/LO1N6qf9PzYTrckSNgr0lg7KRrX8kz5mjnFctUjrL7HZ0zWhg79vqLGWVIscr4xy83PdF5fz1g7vST1vb10k+jk7GfJJkh+DD6E7pm3LxEBioSTSFIKo9kntVVO9M3FY4LtPCiCeQ3b7OcIev4fQmpsifBtb1u02IgUxwwe2mWrCU+dG94JxWCPkQ74tBpKpOPIKcOOfsK0TUK+3J1MGLCOWI5OIyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG35ACqT/FVNtqcO7uTsy9EdWEZOE5AWOCoQmz6mPM8=;
 b=ZFpn8YcdPT2VAfK+X6l62y9Qhppg4/U5aZeYuG4hp8ht0r36TT+JT6uF7g7evXRQtPrcZRZaZLcRWiBFV38KkL+zK823HI+rSqp51RoZ49g2LmEuQqiI6maYNk7DwmN7Ir25h5ttyok9XUuSiYoiICCDvnT2+q0OV1Z+jVoxugcHP61/FGPTuJPRCTZWUSjcEZO8+9SA1bxrEle/lmfAIUKzuZZ7uMGlcvwrDKin4a3WCXzQ98xx3q7mwcjJoMR90H5yoy0x1DTD2TsAVQVRQjHlwhEANXRdFJsev6Zq7lN09BXA9lDANjVmEjh/u3si2tC8rXkWG2ThoHZHJbv/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG35ACqT/FVNtqcO7uTsy9EdWEZOE5AWOCoQmz6mPM8=;
 b=ri5SD8pfJBWNIyMWGqpYPHlISWFofqOCCx4hbXZ9FvEd1rIkGtPuoXq1LUeNdO5dahM94/yduToVY8il4+S1LkgZ9TSjJiyPlB3V2fZh3OixpakAOqCg1FqP7mnbyCB6Pv6l5VpXRjftDmaRjS5Rcru75nqBkjxtIRnricdUV54=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 11 May
 2026 16:08:54 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::21) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 16:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 16:08:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 11:08:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 09:08:46 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 11:08:44 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init error paths
Date: Mon, 11 May 2026 21:38:14 +0530
Message-ID: <20260511160814.2904882-4-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260511160814.2904882-1-radhey.shyam.pandey@amd.com>
References: <20260511160814.2904882-1-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: bd34c352-25e0-4a8c-c825-08deaf7797a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	58Ja7m4y3fq4HuxufNK0tOOqLyk0w1n1jbszYLb2BPVWnJb3PM8i92Vzqjm7pSRIBJ1h1F9f6tf17FhvqW9ee/1BaKPB+6l3mDfO0g2+bStoJgGH/G0GOsVfOV8DSCmIhPWH88FYA54mRyBOkyXmDupHKafENxRiv/iIbto20m3gH9t86YdcEhN/ubffu9p/A6M5rLX/8MIpgByI4Vu9DKDYSXaE4PHnt1RhB3R4CJZ6fMiP1P4cNGEpgAUcfTZzDOLmJCLDoWfZm7AiWB+ooti5bRtkaKQjaF/zjursgRrfdcbc8MubgeVFmXbLb+/cFiTnWfuozw2xYUS3zCTO1K4+YwaX2Bn9iBnXCdRiKQqa7seOLLkFvLCES9/Vm2cRM8yGtb3fLH8iYK+ApxY3433OZSlqdmCI0X7RIqLpaB5VzGYlbnijdE1MZeSHLFTolCeAWchD5czM87M+VUnZnfwxyHVI+QLfWMsV4iNTL1HNdPtHkkbbKISxrZW3oEBzxfgpJpcoXIA7m7lS5cpYV291Xxq3CvqJkXZ/5+gMiMXToxHdEmh4m/+cky82QD98lZi7d5Exuj6Gc7fTs62pZwQMiInRl5UoZ8C3NRZlgXSq4JbDk5KLkY42U8I7GKHeM+7zATyp5wP4GWGPfXJKSvdHNUMRMbZQFEFTRaMthK01pCmkF/n6An1e9MC8xMvIq1IQWMh9pGYUbL3w/3FeFtqt/57T6/kMnDFc35jlIzk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kk2KipnSM441Jp4SkLTMjHOVZ99z5RXRXH6rnbGyYYiN8WExQAKzKKJhJ5sQDQpo0yyo6TkQpowHNvd8HGVaDBcC7rYMOJHXo6rTEiL3d+ouD9Pw1q80QmxZhdQupuFELzqTMcUSwJqBds1ikftxhQbBy+oC4sdu8pbbMFSh9JYsu7LhOaG4JxlC9qC6He06Cxw+4Q6Z6XsvMQb0Y2xb53NJ9jm+fNC7SMYjfSNbvJMyEqrcRzDAhXiJaqLEAFb90IrymTZfXWcrbnssmBiXY1n9Zgs8tvKlqrloBqbPjHbtcP1kQ88+GrwpwnaSMLx/rULrYFpk3pgPWQTlbY8ia1dOACnnaAAcok7iQtHxVNX+VyZtJABRFioaM/GD6HjT0ruU3TPlPb3Kl32DTqUu1yeafMzJLZY1yZBCnk5K1aaZSw/za+4cN+1YHkXw9gdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:08:51.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34c352-25e0-4a8c-c825-08deaf7797a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3
X-Rspamd-Queue-Id: 6D6F351297F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245277-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Fix error handling and resource cleanup i.e remove invalid
phy_exit() after failed phy_init(), route failures through
proper cleanup paths and return 0 explicitly on success.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 94458b3da1a0..b832505e1b04 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -176,15 +176,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	if (priv_data->usb3_phy) {
@@ -200,26 +198,24 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
-				     "Failed to request reset GPIO\n");
+		ret = PTR_ERR(reset_gpio);
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -229,6 +225,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }
-- 
2.44.4


