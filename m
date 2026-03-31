Return-Path: <stable+bounces-231361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP8KBhaNy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:00:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14036697F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F333430602E8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC93EBF0E;
	Tue, 31 Mar 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PByHfIoB"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6353DBD68;
	Tue, 31 Mar 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947104; cv=fail; b=gGLqZQg44UQ4ROM0rFnjn6FWDjTrMKhstbj/S2dOkiCIYBfsC1yPwiwSucg6PDsHgzeJ+0k4o/nm/lVottuwCpjedtD5mZUuBoORMk6enA47jvBzDT+MRJkuaYNFyLbMrwLn7QwRyiuTdrU9LikrHaiM71SmhrMcL+tA+zIdptA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947104; c=relaxed/simple;
	bh=f6DlHgtfCH7vARDUavWWzaERVDNzpuc9gbffAMHBaMg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VM/GzRKB887+uR3D9bQDwuFQtqxZegIVZi+cWMr2RU2OwuFBtSGOz/Ky5PK60c9YGh6Sw6WeeypmbZvZpPHTB6+/mweG+RlmiwBZsHTjci+YJyZM4ie3/e01Mw7cRs8HG5kDLGJAO5Eewea7csqhAoBfMwpvljmwo/PK41hC3Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PByHfIoB; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqIOKbz0182To0k7iLTOCfBagFe3XwIfhFvXVR45hfpVqtBAe9X7xo+ngxebI2yXNHUfWY/x+Kjk/m7KHUidmj9af60bUdHMmSxt8fpbV0VDUHBQ6hfN2PqfiA6psJ3wKdyHOFgvr3gdch9uCnFHC007/EpClgOWbMu0sJBLfFhJ7OwnXJG/ApgUVhzQCKfSmVk1Vlk+FnOQEr8tMh3H3DCbr+SIKtqKtS/PdbMY9dW0EPoHdhIS69DFJXDMC0Tgi8xk3MbtKki3JgJOEQCjm/aAI4eJbKFuEtWp9MQ+tz1WCC5ZZwfdo4EN/AGouNTwWuTkX8y7etD1oYyHcirmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nlAq0sErq8j6lFkQ/QG1cZ7OEglX2oyCECUl3r9THg=;
 b=pXuynBieN/ihG/Yg0Y2NsrKSren7qMFvrIeb1FRktrvy9aHVKhl5MBw4tj/hmCm9VrDO1sUbgd2Aox28peMLEuXvjO+BSJkDadnYcUn9E3RBblLMBsQVAmm+5B58+RfzdXR1UsgHm1qChTIuBPxdIpxbweEsHBAbXSxjDAeObRGm9ZoG9+dP1G0dmo6o7HwQwTf2pzaxIq+3gaMskUvpnAQO6MHeqx/a6Q1lc6RxgmoaHAD/Auf+Fnns7CNUA7lmi9J4DWLwjnvDBe4H/Klxbz4lwkWz3HnMvGbcsZSMkRzOXrSkZb4RyHMAA6h7JdE9uHCnG+A5Z8cvsj/zKjEWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nlAq0sErq8j6lFkQ/QG1cZ7OEglX2oyCECUl3r9THg=;
 b=PByHfIoBvQstfeTz1fN3cbbA7miQQaHLtkQc78xpHrpmGWq7iio6y7rFUGpoJ5LSbEUnQatWhspD92UHIis4rhu3WJnJmoaIvXJDeryETf737VwxSaWGPEqPWOlf3tYFwdhpGO3k7OEO1PWPJ9uDvJwHe+bpm0dd2FVdObL2PxkjhW04W6mz6V8GOxEV0+BpNcTOf8i0MqFd2sadIbZ+r9BbviGRCMEI/mmXuqZ51X5/ZfMCn/vYP3OVZAwJ8XxInDMvyGhiNNxRl9qK4RMDvUB2BS+d7dMJvoDeV8enoHsNpHWUO5Nh1VXNyDyZRbsERbqRr3M0xgE7RwgKgiBePw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB9220.eurprd04.prod.outlook.com (2603:10a6:102:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 08:51:33 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 08:51:33 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: imx6: Don't remove MSI capability for i.MX7D/i.MX8M
Date: Tue, 31 Mar 2026 16:52:52 +0800
Message-Id: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PAXPR04MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df983d5-4bd5-442a-b83a-08de8f02b594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	GTbacI69yHDh9cb/M4tqfDVM0XY+UIEClTXO1grkSm5kMaY8XoPZJ9Am8iuL5p8NBpzoHaNRH+DeTg2F1rjBEizRuNyZZSSsy5rEuREpkE/Xe6ebu5o2mApr8NMu5KaaBVbySjhfzep/cMTqOIzMbh2JiGV0YHRLbASOJBhZXtNIV7lO/5pl6YpHyqH6H6Zk89hiKZTxxT9L9GlvW8/4fv6M8dP7GSft23GOYBCswwoR4X/DlEEGmuOZOsypgZqmmp80qziuyRdPIuQHuEFFwiqwP6EKFwE3NNAanFoUxZaEzYAJjIHyXvWe3aQ6+mdwpsL71ovHZKuuIhPZvHthqM/u+GQqaWJqzgR1uxaMUWxh33rRrySd1rikw2UyLi8Vp1WP2XpVZ6NRT0Cp4MDXizStpaUj5l93x6AfhJ9UBlVxd0pBhWBkMSutjkAaIUjcDOGxPu+0QC98iTUhEqXT56HgXzAf3tuIpeSb9Weh2+Q/bBva0ic+jOpEry6+6QQMEidHtchOFixt+79hRXwRpn3O46fdDRT181HxzWQNPAxXpCcpfqvz33RsAPBwve4qhXKhdmaMKBDu9nFOOXYk0P4jVGcu4eD+TmZq5j/Ahh2V5UsCqD0Bfme22JEuaoKfOC8k+Cb/1Fw9oRZUFVOKgmd/fSRK5bVVgpinGH06/boAhZvfDTATl7AhDVK6z5uWUdInhMSKEql/2BYN25N6EaiVB7pHo2YlUldf3v+Lwn2qY6mag7djaxvu1xJBE6ewpucN+WrZwL+MPtLgNUM7+g9++4jrZPIs2NMoZDXKWKqygqtDrImHOLoLFudw/ds3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeX+hVZ/eFwWbvB9TtgwJtNg8206lmermNQlldVL4gIv/pFhzPnA3X6vuAVF?=
 =?us-ascii?Q?irSvtJoYqHG995qSD4ZiMksJi9NjIeeQFrJNuVwWRUw/wPE6Z+cCw6+/PYFD?=
 =?us-ascii?Q?Zmz+JBKf7t8GJ1OewDk1aqI4EeYleU7IOMN2WSewdxs8yqKFJ2uU41/zaTeO?=
 =?us-ascii?Q?skOmcQ64Thc7iyiRYly1N5fu/WIAlzDWP+Ai3hxxsaOn20iVIBv+Y7NpTeoa?=
 =?us-ascii?Q?WC916NShJH/xE+F74HdxE6x17NhImC99Iozv7c9yHMpb+ikgmhU+CH7AFsnT?=
 =?us-ascii?Q?qY2RgMEEgjr9W2Q6aLUg5zqcFtKX/TBHbze97pqtH+6MT7MdfePKOpz3fXDf?=
 =?us-ascii?Q?ebzJ9aOU60Y4Du0lPhXDoaZVr8lJRD5q90HeyEk4qBpOybZhz6CNoNuHJeDB?=
 =?us-ascii?Q?KWNR7A/eAKV8QRd6iVMF14YlL+AbRyGXhsZYww44qmBMPblTv2eXLwFBMDhK?=
 =?us-ascii?Q?EK24y4i8T3KSy8znyUVWZAvHotTes57xesmUAnojL3sa6HGD0HZUYfPABo+u?=
 =?us-ascii?Q?WYSIG3/QZKwM3wyq36mIRgoBtbZrurc3fO+8bEWCNGYvQKp8C/YRCa0NN8vb?=
 =?us-ascii?Q?q66oJXSwx7vMxy8cHQBGgU7JRHctVLShaZGJczaljr/52NhEIMZqfhpv8yEx?=
 =?us-ascii?Q?A0U9a1XniZl1o2Rbt9r/zgHLcPDNWPfnzkLo5tvHFgscDMbXRLHL1b9sGpec?=
 =?us-ascii?Q?sc6M7v+gQktIJj1C4O9mSbIADWpsrAAMFAPrg10riDRKPdpz9GbFYphqqjAX?=
 =?us-ascii?Q?kxb1ZVS/y8PV+tVGgWK9CdwpNPOXTUs7qicil5TjrocwJAl6pmFmGP5Zr1q7?=
 =?us-ascii?Q?/rv9UD35pmV6ps5EBreF+MT0kcsUcw13P0knxf/6dopthWbrxZyHX/O9AXV2?=
 =?us-ascii?Q?6cikOIkgk/J6moCEKGzV1+xZLSjcZGMt72DWb+DGTTpqOBVbH7F5UrKNncMJ?=
 =?us-ascii?Q?Utn+8GlrWE5NEWH0PxgF2m05CDGED6+qihijtaKAnnGel0rmbUSezY1pM3vu?=
 =?us-ascii?Q?/4ujL0MVp7ZSo9YMV5kZ+6GZmgFYCRG/vKcOnGoiWf5O6fUQ4kyeXdpmBc2W?=
 =?us-ascii?Q?wLtO56r/v0FMObXGt3jMe7Ie+cDrl4OwzJrmUlm2oGPWR9jV9dFVU1FDN0gh?=
 =?us-ascii?Q?CB+Yqdgl9d/3QmQXMT6UiSdzLCyenByvqeHc3qYlrQzjhG0CbKzK8wARAZ4F?=
 =?us-ascii?Q?1bB8ge479mnYyKDZOnGXLLyJeC0TruQH/ZC5Ys5V4OJcf2yppQTggGSrk3Dp?=
 =?us-ascii?Q?8ugcZM7YkLqF1dgJ7rBacBbF2DSxAQhA5lMBtfDhy0zoYrBR5gAFWe6GTA4H?=
 =?us-ascii?Q?YXdZ8h4wnvO9sHV1rC94GrPwrRzLN3GcqHq+LXd8HEpHeHR3aRX/2iiRNbDG?=
 =?us-ascii?Q?HJnBh1fGl09KVmSB0o8Bc/KAg/n7iOuQXFJUlyO0/FG7moOCA5kavVNFJc9n?=
 =?us-ascii?Q?uUolvJ3LZXVR+TJdlRzUhjoqT9ZYkdFRqwEuoQ3IR52HbYHvqTo9TbbjwjBC?=
 =?us-ascii?Q?tpIzFCyMXUJ/HaBq1/PhgWeZhZIIQrazf1TknGqy5UFXSCvYM7bZCvloZBUL?=
 =?us-ascii?Q?L1O17zkKkIMSWkkIo0AVbkh/Dqkd/nQWrFKO7zvlqUTDkBIrTBILjINaRO/K?=
 =?us-ascii?Q?fy80Zr8q9WS7zdmO2+r7HPY96qYCYqIL40sElqjEgx3vnPM5ArfaNoCQEW8s?=
 =?us-ascii?Q?fiN7YsKsGNLo5to04ypdrupy3Rq0SBxFqEU9D8OIxG4b7sLyaTfYENoPp6d+?=
 =?us-ascii?Q?W69BmqZaIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df983d5-4bd5-442a-b83a-08de8f02b594
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:51:33.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ngt9ggx4EsotuZDBWeDEu9pBD/mfxskOFZOYGk5nAzF0U02agE5edL8Rqkvp/5ND7gNx+tJ2Tso57E2i8NlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9220
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231361-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB14036697F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MSI trigger mechanism for endpoint devices connected to i.MX7D,
i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
capability register settings in the root complex. Removing the MSI
capability breaks MSI functionality for these endpoints.

Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
that should preserve the MSI capability during initialization.

Cc: stable@vger.kernel.org
Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v3 changes:
Use a flag 'dw_pcie_rp::keep_rp_msi_en' to identify SoCs that require MSI
capability preservation, and skip the capability removal in
pcie-designware-host.c accordingly.

v2 changes:
CC stable tree.
---
 drivers/pci/controller/dwc/pci-imx6.c             | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 20dafd2710a3..fde173770933 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -117,6 +117,8 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
 #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
+/* Preserve MSI capability for platforms that require it */
+#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1820,6 +1822,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	} else {
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
 			pci->pp.skip_l23_ready = true;
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
+			pci->pp.keep_rp_msi_en = true;
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
@@ -1897,6 +1901,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_APP_RESET |
 			 IMX_PCIE_FLAG_SKIP_L23_READY |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
@@ -1909,6 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
@@ -1923,6 +1929,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_PHYDRV |
 			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a74339982c24..7b5558561e15 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1171,7 +1171,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
 	 * to fall back to INTx instead.
 	 */
-	if (pp->use_imsi_rx) {
+	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
 		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..b12c5334552c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -421,6 +421,7 @@ struct dw_pcie_host_ops {
 
 struct dw_pcie_rp {
 	bool			use_imsi_rx:1;
+	bool			keep_rp_msi_en:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
-- 
2.37.1


