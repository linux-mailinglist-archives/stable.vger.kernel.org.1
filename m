Return-Path: <stable+bounces-245392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F1uDsS4AmonwAEAu9opvQ
	(envelope-from <stable+bounces-245392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:21:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A82519D32
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 937DC3033AA1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE132A3FE;
	Tue, 12 May 2026 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZgHZ6qre"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8A2D0606;
	Tue, 12 May 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563251; cv=fail; b=Na1QECu2doKPnCCf7R+tquiZr7tM+FcRl8elfa2KMAuYc501kUA2abFvzJClTpOWEuTGwkoYUi2GxP97C4NBDCqw75cxBo7/rhF9JlmS2kY33Us6gM84IakBPAdr4RGa5eyPWoD4y5vX9gd9KUNeWHi4R7a2eB/C4owjo33uJfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563251; c=relaxed/simple;
	bh=n5C6Ox5F82hXoRNKkIWDmoUqK20BP0SZDTI/QNvhnBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I//391E/KkSXAR5JyjFgRXjj45KC9nOF8TQ5DDO3I9GX/+UP1l8BvYvsouZRWbCSVr/AFs4d3yI3Vbri6I6i7X+Mf2cim4e+V3TX7Rrs/CDApEjma2YShmosp93gEBqnqZNJpERp3eZy+j7qXe3mZ1wDTwTURN2lOctWT3hAehU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZgHZ6qre; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjWUrjnWv5zS3wq3xPS58ViOMg+jqmCYw7Zpm8k+GFUL7PycEMyJu/T2BVRrhLvur1xMNZF9Qw/TkNN8yY7Pjk3MIyaQFSoBF9fLjVCZXSueUbp44g0I+5bzqxeZZ9dMazTTE2FbkASHr0fFHsFST+fTTDRIBWRpiKxpZS8DT6lh9gsYTU8/Za0UsEI8FxWRu4bnY9R5FIs+4vxOhcP+LmfOrdGX27Muq0baLNm59DSL0Hk5rmRGWb43ajmM+uHXg/foL9Cpt295hSronCT3ULoWkI/fWAPf3VoKF58AgCeymLWHU65uvbvMoNUx46A2FthQuUGi8fBUkaaUxTrhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEuQ5msOjZPP/C6RJtsVKsnRyE8hT4auom6WEvHp3LI=;
 b=QNcBiBwO4rWSWQceoVNGSzDdERl0ibE6fU4Qw1ZTwb5/MkICOZ2p5eZka1fk8Y2N0CQ3ctDsAQTi1gDozudmSEyAYgcjZ1ffn/iB4WKvMcAG0QZhfffTgfLfP8oEhK4fkNw0R8lK5LGWe/Wjb/zoRrqzGhXoaI2VvmdlgRv2RVTeA3AmpuaD8JH93gVuimcqAgvS3b14nDByJt/V4QJz5e+Jwmmrn7Lxsq5XajiVZGfQYUxXQ7BspFcqncX63Loe+EfjB7SxlTa8L/1p6h+BtK8DQe0G7zx8VsNbBPOdkux8yS6efDMrJ0yslUk1IJsuJa8LVFuYU1frFa1QRq9z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEuQ5msOjZPP/C6RJtsVKsnRyE8hT4auom6WEvHp3LI=;
 b=ZgHZ6qrernCrP4S3AwMBKgFc1By/p7+Dvct2T/TXKHEfp/9OM3FO10URjnjMpJB2n4qTieCp6iHnTSo7460fcjEc+OCZk1nkWAdz/9DL8WOxzzxOKfF6z1NiyZ1uNYZAJtt+eC8wI5jiPiPpANxgASDd+3Qpu0084X8+XGG49iWOjjtpILOj7YvXURkX74SAq0ESVG+YXg5xrDzsmyLVEO00YYw7xRc/yP7XDdlyflx4WiKRN+dZgHHBDMjY1tJRqOlxs23/I6v+u1FL7rj4fenG6Rx7RMArr1TmfA/bymLdGHy7JimJjf7ipPVpJn+Suq8fhyGEnX6/73xwnxl2KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AMBPR04MB12287.eurprd04.prod.outlook.com
 (2603:10a6:20b:730::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 05:20:46 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 05:20:46 +0000
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
Subject: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
Date: Tue, 12 May 2026 13:22:43 +0800
Message-Id: <20260512052244.49414-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260512052244.49414-1-hongxing.zhu@nxp.com>
References: <20260512052244.49414-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::15) To GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12019:EE_|AMBPR04MB12287:EE_
X-MS-Office365-Filtering-Correlation-Id: 98234641-1037-474e-2f68-08deafe6387d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|921020|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	jxBGYQ9pCSf1T4/bSCudLWQPfE8wGf4jvVK1lTzV/iUuYf6/M9/ZDuNPzyeskwVOKvFH+Wr07Ca/9E1Pa+553L7xePb+g3RQNA+TABbCMkH9C8gbzvM+FHiPhn7Cmghl750ZzcHyoteV1amFo8HS0ZQnuZPWTMO6//GvzVmADOJQ3z4sbUW6z1bh3okNcgRo9M6m3ZYRzpaZj0mx3Lk4TaTPGmcVBGERLhyqBMNH5ANs+iWf3MJJsRsu9+A6h3kaU8Q5SNAdN9KLtjIlfPcdXQEDZHQDNJV9dLlOl4FTFHcwHPXHn/MnD/Q6zD8Nih+1AUM9oxki9mV2VLWCODUfJyT1w+lzJbEp6ZFkNAJF7UTU9EktkIoaDdgdJ6nEkI5xr/9XTcQ2s2cIiZUx9bx7oqnGum1NGM1Ec7lcWlvP0OflVqC++Z5P2aV07o1nxvpnRVi+YHZFuswyCePzv/IIxEizR3GaxeAygQUzJq5EeDJ1xA8zAdF4q1UeWvP/1FCE3Tr2M+JZGEhOEH8fLCObVsQs9Hkt9PVVOZBUx3swHB9mz4ydJJ0tr6sHd6j+KWeup2vGTry1/lJvgKU+MQfhaxLnYEOln99xdX1ygOoTWFarfqB2yKmCfCPKd/iDM9HCMUFm5ak6ks53m8/4NiQhoxKYmm6HsDyOW7W5qMLw7+d+WjkWqjSU3ktAZeje427PrbkFMkOiFBPoVxCZLt74WQCmZ8kRfBpW9k/TyL/frXe6vZIBhuku9HIpJC/CSjtWyeJ49KCEbJGjg0tKt7APsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcWCzXLbfCBTSEPX4eibrFfsHfegNylfisdsfY7fvflOsPvFr8ZJiKyh7XpO?=
 =?us-ascii?Q?PgpehgkmQ8HiiDMeg2v2NQp/aMmSbS/eWKrDj9ZE6prbGx0cWJxabyA4gAmR?=
 =?us-ascii?Q?keKYy7v+7dgb4zUPJfMYUApoDJfyEw+QSXxCAnLn7QjSdggGp5KPUAk8YRMg?=
 =?us-ascii?Q?DyLQh5MrAEY2fxbZ0GQdyYfGjBam1y47Enz1PB+H6CKo9w7/ZwwQexxaspfc?=
 =?us-ascii?Q?YotYHtki/LFqEYDyKDXHtvJMJfk1TmRpfFuaH2buCqdK3cxnUQ652U8QDsoO?=
 =?us-ascii?Q?56MQFsfKN5jEXMGECUb3hpyQfZyTQfYNrQfF66Cv0LAJVaVV2zo3jf0vyvCB?=
 =?us-ascii?Q?RF9JqD+1WqtHdBhXUSkVNWDdr9uNv0zLk17WjzOIjDjpdsO4CiJPFYTJeFra?=
 =?us-ascii?Q?or6NTm2FGLS8RbzrkL7kswpclh6cjLRVlDp89qhIoHk+hg//r3Q8zT+FIWcY?=
 =?us-ascii?Q?FqdVEKpgYbLQueEIVq1PCK1KUOpukB8m4cE1eE1llhJ2i61hDk1yn4786aBK?=
 =?us-ascii?Q?Mt1mcIxPbuJF/nWaJjXnHeE0lNce371K7y/lml91SgYHKaJvXhbGuU9RRH0F?=
 =?us-ascii?Q?VDU1KMqKxN4bgxyCIs5NG0ZhGwIcy5unN3g54t9h9sCh7HKNakDKp+9XoKzl?=
 =?us-ascii?Q?BETxnF1/3NOClubF78QqzFOcqE04sf2h7HTQ4V9KKRY3e73YH6ZNDyg29Jp9?=
 =?us-ascii?Q?DvFTcGt/HZrFXw91WRvhRKP6nmtA0AkM6shzFCWg9HgL7YiV8TV10gb4gGG9?=
 =?us-ascii?Q?QMIxMuLm8LcMH3+Gu8VL/TxthEvki9OgVAnu2/hxN+epfsXs5T2cFxYBcTsG?=
 =?us-ascii?Q?P2RGsNB76kd26z/duPWEVd2A0b/nr5BGc0/R0+pz+PrZlxDX/8CAAu+QQXTl?=
 =?us-ascii?Q?exWfA1aMlGkc45T+RDPg1V3eaDm//6lFQMhUUSosJ8sJ+0+51lIcWL1BpQsv?=
 =?us-ascii?Q?S0pNaUZLKqpPJQXTZRkA5w4gZ8BT2MzjM6xnDhHJBbhN18IKOsDXAiOtwG3D?=
 =?us-ascii?Q?KHx3TIVUYQNZ3pF37blKwh/+1bkQ+zAaIRcadhpytOy5X2AALxBezOUpfzou?=
 =?us-ascii?Q?g9HrnVbI/8Y2qyKcsJsuXWC+zkaiWvgdylICICL7vB1/WZ8tcoCFJDHYFM70?=
 =?us-ascii?Q?b+R2ilgTAo6tu9f7zHNm//Q40ijuqaMdfEpUXsATWs/CkH7dcwKoxoBAgoGK?=
 =?us-ascii?Q?3niTRtdee6IFPwIftavjv8TuKM2Ly0TPpupFUZPE7p/tuc8L3CUEHm0HDW6Q?=
 =?us-ascii?Q?E4R/1V7gSXrZMayp1APu9hiJQChPxEoeTaZYwg0Lj6Qhy2eVQPz6LBrU2OxJ?=
 =?us-ascii?Q?FRtOQBgz/rTLtjM2B8aiM/IeobCOmoB1F71v0KK/O4eBoPuT1TkojNiWY9+4?=
 =?us-ascii?Q?sJY8pUJFzVuG5w7B3ew9KydJOlVdzNvoKRl6jC/gu9ZnRItGdY4WZrKBLUsI?=
 =?us-ascii?Q?e9dSMxCmk0Jq+FRrnUxZE6uMCG0e2oraTLsKROAPwLWNs5NBuZPjVTNbvyOA?=
 =?us-ascii?Q?Fi7p/+IuIAXBs7B53XgXN/iD0L3jLoxh14AKZQNxEJ8vJXA1XO1LFcNLAeo5?=
 =?us-ascii?Q?wNBFACTbRuLXlrVwG/7SzLGX8lrC7V2ULL5Tvi3HAKlmP6cWGlwZbldmRU+y?=
 =?us-ascii?Q?c5sefeh2jrElmV06kTA6Up9HPzLgXKBQtFlU7oQRNLY2T/phsjSHZ6NSdlF4?=
 =?us-ascii?Q?tJTd3tCQGoZgTcNIRWNZ+s8PtkEVbb9YjLbwkdipwmg3u6UoawxQ/KsMQQJ6?=
 =?us-ascii?Q?w9isNtQktw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98234641-1037-474e-2f68-08deafe6387d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:20:46.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+S/UWPS+7VbHeNfXg9kVxAGD4znAvGn9Zd5NdgGY7c6jykjR1pON/ODcoZMvWsesYPXd9z8s85E7rpSPPb3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12287
X-Rspamd-Queue-Id: 98A82519D32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245392-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

According to the i.MX95 PCIe PHY Databook, the ref_use_pad signal in the
Common Block Signals section selects the reference clock source connected
to the PHY pads. Per the specification, any change to this input must be
followed by a PHY reset assertion to take effect.

Move the REF_USE_PAD configuration before the PHY reset toggle to comply
with the required initialization sequence.

Fixes: 47f54a902dcd ("PCI: imx6: Toggle the core reset for i.MX95 PCIe")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1034ac5c5f5c1..c57f18d9e4ffa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -137,6 +137,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
+	int (*init_pre_reset)(struct imx_pcie *pcie);
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
@@ -247,6 +248,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
+{
+	bool ext = imx_pcie->enable_ext_refclk;
+
+	/*
+	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
+	 * used to select reference clock connected to a pair of pads.
+	 *
+	 * Any change in this input must be followed by phy_reset assertion.
+	 */
+
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
+
+	return 0;
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	bool ext = imx_pcie->enable_ext_refclk;
@@ -269,9 +288,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
@@ -1251,6 +1267,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	if (imx_pcie->drvdata->init_pre_reset)
+		imx_pcie->drvdata->init_pre_reset(imx_pcie);
+
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
 
@@ -1961,6 +1980,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.init_pre_reset = imx95_pcie_init_pre_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
@@ -2016,6 +2036,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_pre_reset = imx95_pcie_init_pre_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.37.1


