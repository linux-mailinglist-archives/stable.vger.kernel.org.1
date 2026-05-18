Return-Path: <stable+bounces-249205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRLOhG/Cmrb7AQAu9opvQ
	(envelope-from <stable+bounces-249205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D35677C1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC8D1300118B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A33DFC6D;
	Mon, 18 May 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oX4eRUWt"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2A3DEACD;
	Mon, 18 May 2026 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089121; cv=fail; b=nnmtjkoNi/C9MSFrIsoIRdZeNPSQsw6kbr+CqwsvyzIWW432Zb2gFjD0o0BgpxkkEnqN2Ao0a7sDW7qijfbdIErtwJ+QxDIrfGeY9UkCUEvFSxTEF+SEzSMmmeWJBaO1H7GUK3AcBeQq7m7O9VrA+dgGbW2XwcN/xZ090JzPs8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089121; c=relaxed/simple;
	bh=za2d3chhKezojUPxMX54MKUiQbp8EBZWsIw1aXq7/PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMWo9TGhG1XGwFxG71dw4DOq7vcIHbWs5cq8ozgcQX5yPz9h7zZXMM9im3lEezCzKpskZFcktSAKTKYy8AYWwdV884sXM/UTvK9KNzB+bK2Nb+1ABrabW05LHc1RpNKXIyPmiDI5Wzy5iYXjnySucWfIxvrJUi3wJgM7fh5hrjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oX4eRUWt; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2ZnsKjKdFHVSxmuz9zxOJODXSheyr2yq6xr1xpb4t+nJF9PNGBxOKv6FV2on6/ay42+oPerIxSsSx2wmUuWRQEWgKnHnALNf+jFv2VR8Vva2lJmzLrQYRm8bkAGPHq3r/1fdXORvIL0bGOhVe+J4fbfdQTchPlSiTjUKs3wcfEeT+AG7Rk2e70CKx0i+WTJkojhf6vv7+9psPHkLw+mHGkUqR6MQdT7oJVLf2aYIDHwh5K7Qyv+xpVqHbQU9s3ymA65+H6j8mMwvtZrxvArqb+9+6Nn4HncqZWxSQBVVqpj5bFW9eMfdZ86SMkX2CZLAP5HM30+UEV1HKEgBMPbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl1oXe440//sxdum7zOpEh241bWXp5tMGr4OeKibUT4=;
 b=beU0Erc4/oek+HgE6gh1qI5kvNGhOyeMqe/niMOU9K+W6ofs5FMZtqoGYnCZdY7Hnj9r+6uBqKJc7b72HQNCewZIKfD/0g8ymThE2h4Hvy8AqNBALIeDM1LK3GYabmj9CztY/NwIccuFwmFq7mH1euvu4UgK9Wu6eyMWJWO3ASzaH/d25Rz0qS8JV1G7t0YQqIFE5ariWVxLru8s+0gQq23eZ/+P6CbESsFPkUmvNgpjVx60qIXFdiKLNEzZKwjzt9dnWEk76EkoRScvfime2W5+hXNYrthl0hDxgVscVdZt7/jBpAK3EYrlTQKtiSBdMl3VYR+qCCe+wd2k45bh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl1oXe440//sxdum7zOpEh241bWXp5tMGr4OeKibUT4=;
 b=oX4eRUWtZbAtYofQsB1+sl5+IZ3/PMAY5M4kiW09sy5Zr3KPOc0ykGSZq7SM0hVcjKsjRqOKx0Jz+aeIhUd1Mi7E93+6j0AJUyUySZ37YaV1ZfvQLPUbvMbGEPoD7rTEnlQTuvjqdo7Oev9XVLATnr2IkZEM8qc5fNA87QfXMjW+RejSHtU3exlOAEiEoTaOTCXiu7lbwzhKzREmxof19LuRcg0VJtHgnWi5M0ZEb7XDZ3ZhUB22GQusgsM8WEGV/5fqkXldXhwXIGJQcsNshYu9fr4NUdR2CIiL84nZCs6jJWvj/s7TbAG0VHwrBWGtNEPip/XqOMK96QOHPZ3ciw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by AM9PR04MB8422.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ea::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:25:16 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:25:16 +0000
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
Subject: [PATCH v2 2/2] PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95
Date: Mon, 18 May 2026 15:27:15 +0800
Message-Id: <20260518072715.3166514-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
References: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:990:76::24) To GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12019:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c81bbee-5b59-44c0-683e-08deb4ae9bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|19092799006|921020|56012099003|18002099003|22082099003|11063799003|3023799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	V5ZOcU8Q+jWF5k0m8sOyrDv9IRGmieUoKa0mhSo5QCQIMHhW9dhCixkka/rETWO7wtAaw8KYuJZnKLxdywO0hmhRlfSkCK/eY/Iu+AIijuNtcWwEuPOIXhyzFgrhkW+XKVdeqt3CRyYwUhaiAWgHEwvYAB5OywDHYGNK6rOuZ0p6ECXUrIeFoCVGdtlL16jfhOlD2O/+NIaNX+iWbNVG/qGyMhnU2N4KDUrjw5NyDh6VhUINNCIZ2OR7SbfdDLLIXOC6c6XdvN06BdpBBDAsEeVGiqrmOowFWLg2gfeTVKXrh9e6GBWrsZtcPUfpJpK3td1g27F/B81V4LNydJUZI23GzrPaN/TycsHlouuEbTs8rfbJbKbHrNjnbXBuuNg81SzFwJgZVmjFWm7nL/5k/8p+AQzomcmITja2W3Tb7DYa36x9BR7DAPPsMfrFP4+YWwqHvuM4dwk+EIKXq0Jhs39Xv8MX9Hd8bkkA9sjvBwyYqyqTxyYuY5tL5pCmojAEdl6OZkzkxR/F4c1KM/jQ1o1AeArajES55kUtun2Ed5ytKO9ofCtjt4ob4OWx7R0e5cSZtDZpGrBLXTr92Jw94etcuUhcH3mzdRWEGjl9bhbPAEJg0tPpP2USTkE83SuxSSff/VHxg/3CJWNefr35bA+KSpqqqzLLMNiPaGpkGVwIgmwIhJU2eD43yZ9wfHr1wRuAx+lPl839xVWaW3gnOrIZNyru6A/YUcirH9vnJK6HCXsAsg6TuBD9FBCAP4fPs7SJ8DK2fbyjR7HpqDbKWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799003)(3023799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSl0iqeub/5FAvgkSIJ+oz8epT8dkPNdY8JME3E9gF4wZZuk3Y4kDGn92N74?=
 =?us-ascii?Q?9o6YLOrdEzX9xhjfCKQTF4A4mcLjHpJ+aS5ZTj8UtRU+GhwTxmPRw+8KUJ0j?=
 =?us-ascii?Q?oWPdW/BdtQRYlvBvUb9638hvKsmJ0kILhn16PMPfge7u7Wo/nc2oFTU8lhQH?=
 =?us-ascii?Q?KOPVn9Jsu7tYZeK+yLdynV28tR23tF887Yqqrbz69vMkkGnUq9bgfTJ/f6qp?=
 =?us-ascii?Q?OHKR5tr6NxRwXZ3uC7PefztIuWX7YImK0QC7Z2H6MwMdpWCmOSzPtR1NE2tr?=
 =?us-ascii?Q?U+0l7Mu2A+T7yVPiooTPmyT2eSqAQp97IuDY13+XyjG88uAD1pSMta4eH47I?=
 =?us-ascii?Q?n7wap8M71D0snRvzYbwRvB25t4yT+MEmMur0mjQIiZMH7R4sierBYAzxm00T?=
 =?us-ascii?Q?nzJQ7DtU2RF6CEob0o2ur2So70/eh6mcMicfOsTxG3GKkMHmZX8vTmDSjGyP?=
 =?us-ascii?Q?PXW7oJnmdiMHoOzpca37/q6cp3wexfZiyczrLG5DsoPb3kc8FiC2K6uZFBuD?=
 =?us-ascii?Q?CPLzfJ2sFNH/Ezi0NGcXbyJyL0Jxl2FTDg6AnLvJ4ZOMEc+PzSDK3s5q6bsG?=
 =?us-ascii?Q?odhozkSvL5R6PxJSjzVfH21QtIhZvNqz6NZCBqcKPePUK/I/WEn6Tig31JXb?=
 =?us-ascii?Q?WB8Lqwfxq1EzKLRdxigZ21+20s8hzUpYt+8KROKRuI72lGjBfvWIslz9poU2?=
 =?us-ascii?Q?zGX1a6Uv4Ru07JgKioh2Rxe4B0KtlnfwhhFSdey7vSENhg+Xd5tdz8/44zRS?=
 =?us-ascii?Q?hN0bJxrHMO582zWCpk3MOBTZGQEZYLv9fICcpROVekT/SZ3uYxvhMyhT3N2L?=
 =?us-ascii?Q?JLrj4rBHS0RzRsXw43xp/ZzhtvcXvXUrlFfon+y2ZhNHUi3wOQZoUq8vacK4?=
 =?us-ascii?Q?088OaCqnlr0V2qKvVOW7lEMtvs00dwJmJXpXL0LDSTig0wIlsm9LlX4KjTB8?=
 =?us-ascii?Q?MYpwPza8i9EU/WP1Pq8koEMOsSH6jt8Hfb3d/IABS3w/yNEc3BrDJ1eJXUN/?=
 =?us-ascii?Q?w4p+kbSYM6180iV4mOgnxGKw5rq54MyAObfDMJ2qNdiQj2rdf26GmvXzYczq?=
 =?us-ascii?Q?4AO//x9KICuobMD3YB3300pUrfAYQyziSsjn6MjQflIqNOX1PGzCY8WlnGNM?=
 =?us-ascii?Q?tTlukFEfQ2IdGG0p/gAoZ2160gplmMTMQwJSeil73XtppQCMB3mtHZjZluF8?=
 =?us-ascii?Q?BffGPr+kqe4+vBt+vp4y405oF4X1eKN0s/l4S6xbsushlu7TO1rDN5IKcQ6x?=
 =?us-ascii?Q?tK4XA1DL1c39+9dGJVvEu1Bl7Fa6IVDFwTpdW97/Tastczk4TuAZGy6LkWto?=
 =?us-ascii?Q?RRmZBrChpSuwlOAYp7LsNttbrgyiFk0416ATb1fIuz1tbWINrvDo4g4okfEr?=
 =?us-ascii?Q?MSAn9JhxkYkz7DP9DI/bLJjGYEWfdj+NibcN/NtlaIIum1uqzG1kbhQTpbil?=
 =?us-ascii?Q?7J8eTcMu/ItObg3Xw3xkjg0I8fKMHwmA7kjYNyikYGy6OvUat607XVyRUDsE?=
 =?us-ascii?Q?2SQTNqHHPcjOQe6hTR4Um/8SGYHfd7CDQYYxE+JkVk1OnvNtYBYpy4NXdGYd?=
 =?us-ascii?Q?bn7TDAEEa5du6BnhXKfVEfA/hUnEVigqMLGXbKSIYwF5C9WaLPDPzwqxqwls?=
 =?us-ascii?Q?YFtVW5Mna9s9m7y/lE1/HMJPEdu5SKeJD7O28m98bQGksOCrwyunMt0diehe?=
 =?us-ascii?Q?HyLLBEVayGmReqHfP2dWzTS4H2Kg72Wg2uL80AKjYGDAemKCSxVg8pVwBTRr?=
 =?us-ascii?Q?9KJGh2pWvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c81bbee-5b59-44c0-683e-08deb4ae9bbb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:25:16.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC77rakSVaxzBOGsd7+8RhhvNQ9WcCfSZ61+sC2hMJF3xZ1pXhObFrm7wzztGAfc/s6SJuaJL9oyoDq5wqAfwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422
X-Rspamd-Queue-Id: 039D35677C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249205-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

According to the PHY Databook Common Block Signals section, the
ref_clk_en signal must remain de-asserted until the reference clock is
running at the appropriate frequency. Once the clock is stable,
ref_clk_en can be asserted. For lower power states where the reference
clock to the PHY is disabled, ref_clk_en should also be de-asserted.

Move the ref_clk_en bit manipulation into imx95_pcie_enable_ref_clk()
to ensure the reference clock stabilizes before ref_clk_en is asserted
and before the PHY reset is de-asserted. This aligns with the timing
requirements specified in the PHY documentation.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 66e760015c92..c4b079c93648 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -270,8 +270,6 @@ static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	bool ext = imx_pcie->enable_ext_refclk;
-
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -290,10 +288,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
-			   IMX95_PCIE_REF_CLKEN,
-			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
-
 	return 0;
 }
 
@@ -742,7 +736,29 @@ static void imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 
 static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	imx95_pcie_clkreq_override(imx_pcie, enable);
+	/*
+	 * The ref_clk_en signal must remain de-asserted until the
+	 * reference clock is running at appropriate frequency, at which
+	 * point this bit can be asserted. For lower power states where
+	 * the reference clock to the PHY is disabled, it may also be
+	 * de-asserted.
+	 * +------------------- -+--------+----------------+
+	 * | External clock mode | Enable | PCIE_REF_CLKEN |
+	 * +---------------------+--------+----------------+
+	 * | TRUE                | X      | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | TRUE   | 1b'1           |
+	 * +---------------------+--------+----------------+
+	 * | FALSE               | FALSE  | 1b'0           |
+	 * +---------------------+--------+----------------+
+	 */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   ext || !enable ? 0 : IMX95_PCIE_REF_CLKEN);
+
 	return 0;
 }
 
-- 
2.37.1


