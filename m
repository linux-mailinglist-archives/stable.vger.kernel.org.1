Return-Path: <stable+bounces-227241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SES8Fl2/u2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:18:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19D2C87BB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD78A3040019
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791753B27F9;
	Thu, 19 Mar 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hp3dqVLI"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04315B998;
	Thu, 19 Mar 2026 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911828; cv=fail; b=WC5X9EN8zgcAopcKNCzkccZ03YvHdWC1Y+uVrI6nCv4/kRR6SyArpEDTf1D8CBAMaXOuqEqQtlQ3XpGeZOi9sGMLZsSZ7Txb0vCef9HUO0RpHvq/5r/0OSX/5l4f+SO1/7HKxUSSedCW1B3SY7sPhjCuzL1CXK/P8hPtPSmDxlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911828; c=relaxed/simple;
	bh=YinSE1FycKYCc7EY7vSOLe0agHLOddRh0qrp6I8vKaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=reZj5fzfQ19RnAG5KvHODTNMDQdsgWd1q/wGJJdVySCwQHg8IPIMGRlHGnCllZhxPz3/jE65lx3HQPhWaftGXLBSZRmFzKd9BQjUoIINETLwZ0vpvuzQ5zXcygtPdEWhTdS4mVINbVc7Jcl1ryPyU5gkr+peqDgr5WdCt+Z5b98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hp3dqVLI; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg9j8VWgGzyrGzj6tmlw7dsBDZ93RjI1rqUVpP12OUR8mXiFLuNdCakt9A/OHQwwnUbAc5qvYCHMP7jr18h0c00QuqUHy/FaonpgKNcswxas5A6L0pVJ/4W7l2h/D6CUzXnQ4YkdiImj+FGREHHKMzN/fa/hYGmBksuJ1ROIihCmofuAQHBYTKKDv29O1qViR2bJd/WxKzUUYDECoQvfGqeGCPQl9G53bxYRCeMEWslZP45PD2X3nYwNOXr6KEnufQZORFQqfOPcmbH+2N7mP2wmWXZSOiv3YDyRVEttcqnfIHeo4dR1ekFulNchIk/7jyk1MOZ4H5g35a8EQL7hqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3c3BsfKFwoymCJKdSYZATovVwGnMW4S2bdd/8fEhz4=;
 b=YO98oSW6LjcOAoAg+HXZnDD99iA/sCxsGyQ2J0bVcX4ASdkGPdsKCxaZSTcBTpX7lPbag0vpQSG53d78sO8RxOdzkEsWdgaqTtdj+rKmtewKM+6b+8fmgCGXzKyPwnT7NHYp6iATTULpAvt0XwGW251vHnPCzdwX6lR39WJQPKBsTCMf7VcR/g/hbQ9yLn/g7wl3G9zJkDOlp0nQd78B0eKeoR6NuCRrQbjn4e5nJ/EmQUpCCjqcOLMkOktpAi8HNcobapbbb0YJa4mpZ7wX8tqoMv9yZWbkDlIQs2raEhRp7OIxQhMDDEE8UTN5ErCuyNXQkwOYIYhICbrGB1iDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3c3BsfKFwoymCJKdSYZATovVwGnMW4S2bdd/8fEhz4=;
 b=hp3dqVLILpPLyD1AVQ/JtkdkPs9dyz9nsQmX95SmcRn2I4cNptj6MRJqxShATxX6+eoH9eRD5AmA0FHy3Xun460Pz5CofYc6+Yr0Og8wvxn9pVkfMtdvPHKL9pg8Ue82jyWHfVfUid4gY2D1N0H9nFtsShpfaoBjgbhzSHWeJMI/UMLFBa1BLlz9otjL3iBAoEO+qsSVCIwI9KLsVhMr/Gtw01nGjefg8a2TTxT1enKjL3LNhLP1JVVvzwcIOxkuHZ47HGn0Zsax5ZitBE33uQSAnnfmM0T9Guw+FyIsO8utYj05Zfl7FiXNjhKkDM7Dl0/5+34wZDlg030FVbQRdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11353.eurprd04.prod.outlook.com (2603:10a6:150:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:16:56 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:16:57 +0000
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
Subject: [PATCH v2] PCI: imx6: Don't remove MSI capability For i.MX7D/i.MX8M
Date: Thu, 19 Mar 2026 17:18:23 +0800
Message-Id: <20260319091823.446030-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11353:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fe0d14-eaa0-42b4-7214-08de85984547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3twUY9aTjIuZF6ngJS9M8CRRqDmWQUcOXGYcVFPo+s/8VCKDHqWLAn/PCkfOPvBiC4bOwuqZXYhk1IUDbbYeF6AkH0DupwlvQTAfFzNn/pA+YID9tqfPRN9ugEwRAKHSkx0Rh4/b/b/qx1fiLNoLv3hy9OLW55yTtIBeSoMa0iEdmR3ydUAfPQLU+avk/2j0g6luyza//W49wZJsfyPbx6GmgoSBg6INTRkVcjz8GvsTP1z7bfvXlVNBLqublB1s1K5m8KH1ZuzKmdoFw8Xb4ZDl7vWzxWJE+riik1vduo6LXuc08bj9RrNWv66hOPTJT7dU9xOC9EaDh6CKSzuYpzJIwFO2x0s0B/+P+aF0tqh7wVQqexrIia3jdls0bnbO95wc6up44+Q2risC5q+uvrwtZ3nu4yJUIPHPfSC1CrPrxN0rlxHvzeWX1raLqROOVdJneQoEhBfuwEoixNZUPT3jRpZ2LzwCdTAuiio1W8PztamT6RxivaGpT9mcvVZKdmdxg9PT4gNYktlpAcd1LqyGFEKZvMzsH7UnQKQ5bw3NAPO4Ina3ivD0UIbJ9cexd1aLKTrDZVlj28KaT+iqdvS1HKhy3vnXYghNm9j1YW0YLmuCNtjp0edblbsMoTG2dAnOFtwuDSWIDV2SduKt0Hscd+GDinmF510Yrto5lNmnoI29wSli21aHfyfULbAA4toelJdNOPYq8hfZo0+EmkxU1UGqkRWUkNvv+ivnE5HxSNG8h9sO0l/8JsPfwLHtga9wB2N0MCfeUFDsFrmnopBDbBwsXXv6mukEoRR64vpfVhO1XHumjx3+jerJXVKp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dIgA06q43ApZUqLF6Ch+/1JNdSnElDwPGzht2b5BkJj9Y8uSR6yx91ocFB2?=
 =?us-ascii?Q?LRwwHOO2N6uPn+UNYt3N9MsfeIiqDWXf0OQBnRYKdALpkpLpFaPp3P1p+z5K?=
 =?us-ascii?Q?uSkpQoJ8xFY5glguYG3MmKkxfvJ++ZhUolmLghqm5ICQ01T/nB8etXoNwrKI?=
 =?us-ascii?Q?XERVyvMqGVtQT7G9+y+900oVyIjoXpDRvj83YBzuzjdcDnubv3vC3WvnBzf7?=
 =?us-ascii?Q?tPoDJMg28leXZr6Zz2jOx4V2ApSklKLCtK3RLHPvcCyeWPejNpXq7gBoVKnz?=
 =?us-ascii?Q?7ZLFKUmYcQOQATqrg2Y1Z0UB89AeSqp0VA3+tF4xC2SQU4AlYr1XS9zwUi1T?=
 =?us-ascii?Q?o5DnFqxomTWSDq5iUrZ4bmUj+yPCgoKFE0y+VBd6a/I58gygsuGSV6aVTl3i?=
 =?us-ascii?Q?3gRHzkPZfJV0lG4VdpQgvBMBpHEupgV+c+SL0zBNVe3A0t9A2YXsHw6WkwTd?=
 =?us-ascii?Q?+oqhrXvnZ6L2q31Wj8ZYq4UfSyIWf5BLNt90l5bPO/QFIihs1XqG51VGpW6I?=
 =?us-ascii?Q?N0+G1/u2bwSF6YLI9KJKPDOCRW0WYj+PhDJlFoud5OO49txTVO88R6/lk5wi?=
 =?us-ascii?Q?mmKqb6x+AIhpmgsXxStfHaLG1vbIkP4rW99Z+k6mkccvVhhyyq/WS1malCNK?=
 =?us-ascii?Q?VM2/Z/qCCJlq+69blDEVo+Yufq/vTatqfjhkU0hz5UiZLXeogk7TJSMI6r6a?=
 =?us-ascii?Q?hN7dBgFQuv61NnYB2QITNNQc7Nxm8VOVt8Q3x4lS4cQfmVVcjh8fRFEvmdLO?=
 =?us-ascii?Q?ZZmuUqhzXoBvh2M8TsCvDEHKibBDWfVVqAlMeMKkNrAZRgYo24X/qDMz9n8D?=
 =?us-ascii?Q?Vfxt0ki/L8qTgmu/ATW5TRwTs0COOJDQIT+oNKoU7bgxIevpKEI+czvfIreo?=
 =?us-ascii?Q?sGFGJ1bflL+g0Ak8JpXG1Bu3p4L6U/XCTaOKwvICbxBe5tUr125C4NeSSaFe?=
 =?us-ascii?Q?2AyhyYQ81oDJFfMRvpJD9bbjuD1rZGwgr8ZH5Ag8OBy/3rcUDx/fA1dJ3Ed6?=
 =?us-ascii?Q?LqYhDFLjN4kT3p8mhJXzuehD2L8x26dBuEoakCWc7/PSmfzznrlqahG/ocgj?=
 =?us-ascii?Q?gjKyXpCp+y0MCiGxQhjdvV8FK7dN9FJ7lbg5du7weeWd2uFRJurAaC8N8P6I?=
 =?us-ascii?Q?QANgjzeYCK+IpvVysDcneDY7F9QRJXNI8M8IM/RHlgGMf+qp4ckIR7ZVvenW?=
 =?us-ascii?Q?dxlyzJE/C6bFgGl5zc+sR25EXHw74ot86HDmAIWLezpAk0JJJ6Lj6OLelLPc?=
 =?us-ascii?Q?/OdSdK7dQ+g/1gCLvT1zgXdsT5QVSqKVicbizQFrL1uuEACOoBs9Aq7DTcsh?=
 =?us-ascii?Q?Rtk51OjqJ9VEAH9h5NV++v90lwP4fkKOttFXG4tm9rGB9OgUXtVmJW0UqqWI?=
 =?us-ascii?Q?LRBrhi7GoRoNyLRVPbj7nNVO+SePDGmCl4NHb1SI/zZuwBB7mCLAiSnuPyTp?=
 =?us-ascii?Q?wZ1Mgs4bW2icVhEZgBSrmTKvDnohLTYn/A2eWP1OTLlVhdB9q8drXOzU69bd?=
 =?us-ascii?Q?4PgLZMRfl0lGkEvBakc4k2aie6NLkInCSlDF/IEfM9lZXu0cwk4r9DQEzedF?=
 =?us-ascii?Q?O2ORqahEBa9KapgWDUTZVqFnRGhlQyC7cq74EwEcnMKUDNvFkysFvKBae/Qe?=
 =?us-ascii?Q?NT9u1upElqIKpibEG6fSJd7imds6sSWHEBwxOO8Unv4ApUPKuxobUBo6bB3H?=
 =?us-ascii?Q?R1PHB2Mbgyxo7dIte7E507nm4qN7tcYnzw6DBwFwKcrGz9nci3gua4v5p2Tr?=
 =?us-ascii?Q?SIaEpPfPfw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fe0d14-eaa0-42b4-7214-08de85984547
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:16:57.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKkwZ3Ob5xxzTtoi+tCsy2b1Bg4H7A7eEvctUA1qOEg/A6oqiFYC526TCcKJJ6njB9WyeS//5AJUzVhR/kiRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11353
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227241-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA19D2C87BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MSI trigger mechanism for endpoint devices connected to i.MX7D,
i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
capability register settings in the root complex. Removing the MSI
capability breaks MSI functionality for these endpoints.

Preserve the MSI capability for i.MX7D/i.MX8M PCIe root complex to
maintain MSI functionality.

Cc: stable@vger.kernel.org
Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v2 changes:
CC stable tree.
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 20dafd2710a3..0b0d6a210406 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -41,6 +41,7 @@
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
+#define IMX8MM_PCIE_MSI_CAP_OFFSET		0x50
 
 #define IMX95_PCIE_PHY_GEN_CTRL			0x0
 #define IMX95_PCIE_REF_USE_PAD			BIT(17)
@@ -117,6 +118,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
 #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
+#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -976,10 +978,17 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset;
 	u32 tmp;
 	int ret;
 
+	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_KEEP_MSI_CAP) {
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writeb_dbi(pci, offset + 1, IMX8MM_PCIE_MSI_CAP_OFFSET);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
 	if (!(imx_pcie->drvdata->flags &
 	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
 		imx_pcie_ltssm_enable(dev);
@@ -991,6 +1000,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	dw_pcie_dbi_ro_wr_en(pci);
 	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
 	tmp &= ~PCI_EXP_LNKCAP_SLS;
@@ -1897,6 +1907,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_APP_RESET |
 			 IMX_PCIE_FLAG_SKIP_L23_READY |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
@@ -1909,6 +1920,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
@@ -1923,6 +1935,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
 			 IMX_PCIE_FLAG_HAS_PHYDRV |
 			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
-- 
2.37.1


