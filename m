Return-Path: <stable+bounces-249204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePOtCea+Cmrb7AQAu9opvQ
	(envelope-from <stable+bounces-249204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33E7567794
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 049653006690
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083473DFC70;
	Mon, 18 May 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PRwLO7yb"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AC3DF007;
	Mon, 18 May 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089116; cv=fail; b=bJ4NWu7eA+FEEg6Za1gZ8vDmroS0CtZTFGkhhLXnVzav4MJ74nCG9TxXSm5FgVbw7ORA2LqSpyoGH+Uzini/g1OQQ6ilyzqSg7OHc7J0HvIXpkSuabt/KNfVL7Kly9fBKZhj5/ixO6agsXJJef/pZO1Zco3ku7p+Vv9ZNTt3j1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089116; c=relaxed/simple;
	bh=6J/lxFYcfoOS+F5PMpXzcn0bha5p7YchSpFjkNoubNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5tjgmPxHX77wc0V/cf6JFsWu89xaZoTIU3yOolkBGbjBm9IgWKSIBaWk+vIG0XCZCr6L+Hh7h7DqTfeQ+ZB7XVJGeS4bA06g2/aYqFcoWanhIeki1LAVHBoZhCPV+weGN1y4rtHut821Lpxe/YEJvHxIEnkJ2FGSEJ3Yz0gzBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PRwLO7yb; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNf6wIBLDpSqe3zF0KxModb/Pg6mTqHmAzGaqrSyKcrsvgOrnDRej6v5JRUI62XLi2wWLJUVzgLKexUUZZV0Sx8ip1/yrEJGe4fPWgfsFAS2QW5BGB1OL57aZxzZk+OGbq6gpUOmiMoaIbeumaloJY12p1qwpn2otG7f7VXqCk/yPrp1FPX5LYMhvWJ9EpQFBw7pPA0JRe1C/N+FyeWWOGSawDsNxO+DEqtawH1JcyQw5zQQKVzpeygmxPemlydCi3Svx7E5TxX4A6bRCY4H4BLz2acb+aBtxTVwOAK8gTf3gN2wdxAsDRR1pnjbtceAiqqSYpBOHxCVE+WLM2B+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO7yZe50uMoCexyziuiw5fJISB4NTG4nRCyWXqQlUOs=;
 b=ra/JjAr+xn0heFD+y94auS+FxZCmORSuRM5Wi2TJ1dZkR4UZLfNKiIV45JhwmH5JXAj5K/u8uME4TKK3HzTjilgkHcIEEjYsfRFtre6iUrHYeFPlOk/nvM1Hipk3XAdwfdX1hcgV8bK3P8B/6arvDydNCgbMnBlYXeSep2rn7pdxQ0eKplR6J0mvneCvgim2g8o6u0e7mjo5ZtEYNjQClJm4KeK11Lj1C7dmUX4+V4/ktkZBRXbUjI+xDUaQcz1PYu6oIX/HYbVHC3BVIPj91uZMkPdYyUSh6QZ9YT5qqw7eRF82FQxP57MutIIUJ3k/WBEhj+DZ5T+gQLsqHqT9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO7yZe50uMoCexyziuiw5fJISB4NTG4nRCyWXqQlUOs=;
 b=PRwLO7ybaZ2vusADJTW9gGHaOeCDofKNTkUoHT7f1QmbgVKXOIQSECvY2bcSaUDFCkbt6lc2eFVlhggssIHhRVcgKBRkPYWLfeB453GM/Z0o+5A+gU6WWum/z2buvKxexiioGV7gwaFjPhK0ZtAL8ebnSiqkr1a/4PF/JZzAnKluA+sV5R/VASUIV86edOsQodMaL61W++Y9cMT05p6F5qpDu6YoW6bg65nUFOQQSgnOs+qKC+PGOMfpn1KwSP3LoE5BggsbF8wPH9gEG2vwRSG8HIV06STxFJpOidcZweVgI7JBfyZOu4Bo1r7A1dEQkijsSwm7QHzgJrADDlIPBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI0PR04MB10998.eurprd04.prod.outlook.com
 (2603:10a6:800:262::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 07:25:11 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:25:11 +0000
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
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
Date: Mon, 18 May 2026 15:27:14 +0800
Message-Id: <20260518072715.3166514-2-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB12019:EE_|VI0PR04MB10998:EE_
X-MS-Office365-Filtering-Correlation-Id: 339b3f4f-bb4a-4cfd-22ba-08deb4ae98a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|7416014|1800799024|18002099003|22082099003|56012099003|3023799003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info:
	DxW37R1nDlO7XB+7lxH9o/DWCNPiNSKk3CcLe3eGSh6Lbt3X/pUlg6RdgEOnnMNXpRcXKU4r6Ve2Uav2IahtaX4tws8SLifzAw4Z1zctwlGg9EF6URz5AHW1jiEAxQOgowwWBsvYKyQzK1zkxk0SpxEoCpWN31k1kohfJWEeIpZucekxhk0jOrund3OtyKhSBHT41I1RbqvZ9ysAJpjBm2vizxvzxs3bJ3yW4WBc0VrRRn/+8+WD2GoP8z95UjBNVoz33O/VO3+cVimG5Lduy9VHhELUsTS3mfg5nRU8tSeF2DOqFvtgG67oXTROTdbhD/P+fFl8+/SUIXX2biXxVM9QpNxGkXudfXU7l++Gqde+31Que7+8WKrGzLpCPPI6/3I+M6AS5v1bpBKXD/LpsQgYSKrOIouFJyJ9WclaWAOsrbIo51c+/jg7e16HQ5e/yh/SWQ8ytmogeDpNXJQUyofE/QBroLr/cnbfsYk7bffBpEYF7A1zpjhJ986P4nbjNiaTEq6qVEAEg8fGH61WHubmZb2wY4yE3V2lbBf6OaiLRut319R5q0DOYPR5LwTl7QPqaQkOgd3p8aDcvH46v17kytgAhvpzS+X56SRX0Ln5Imx0QK36Fm78DRtQDjVY9BKD74JjCrIxEOu8aOK5Y1S1Y1y1KFmHgyCeZ+Tdym/21FmReI8dI4vq0qmY2CoXSuFZdy4uZ9hPhO1mJ9Ta37YBIGW+LrUBUNf7QaCCj1nzCicvPiasGwZrkfLwGLQ+sRgEJHmvphTdcLaXXWVhoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(38350700014)(921020)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7hByjWdgeVNlAjr49mtrATqqEdAVVV9GOyRNT2lJUEG/0nsIi/b5SszgTlH?=
 =?us-ascii?Q?o5wORwpm15DpVlykddkoQYmtE3fpXRy13vE25/dF4k12tZTBIN0F1iIXzFvh?=
 =?us-ascii?Q?z10lpvlaC8kT0SJTN+Qw8h9u6gJbU/d7yOuyaUEVwFP0aiiL6904Bv90JfF/?=
 =?us-ascii?Q?YdoX61/67lPdJRfRMPPEomb0P2kxsoTYftmeqHUwJkLDHBE6jtHVBVNP7Jzv?=
 =?us-ascii?Q?FWPJT58aD8IWjh8gXr7L4WCS1HR4i/STYgBOwd+PAWckhrdoTrR6etrZVddM?=
 =?us-ascii?Q?q0G77QFLEwfKlwHJTyLF0lttSOBodr9pndFphaeEA2bYw4+DbCmKr4L9QVXK?=
 =?us-ascii?Q?7FlzobeZD6pmrHvoIF6EHULvSspRhO5/uP8gzT8trznAxtnsHtfB+oS1egTG?=
 =?us-ascii?Q?lIuPBxhg36G9O7wX7D8SfwDf8ax35akLHnlyDOQ5+DJ0Mb5sqYw+Kcawv0Ee?=
 =?us-ascii?Q?T06kT8g6HADDdkGvBCLe6FiLlNzO0UI4Jc0epmstB1092RWuLI2qkTXw+DjV?=
 =?us-ascii?Q?DFTUCx8n2RXKp/DuoLIrR0PdPTJ0QD7E6K8sLnNpYZKphrAT5XcuBs4ILnPZ?=
 =?us-ascii?Q?4SX5Eg8YwWWCavWSCoa0GLHoHaRL+69uB9wY25TjeH1dEOo15j2DKwBvlFsb?=
 =?us-ascii?Q?CTTSQRd+Z30LVttuYvoVNmKI7yKfhwuXiT1s/muQ9oZPJ1IJspVhiHgiKK6E?=
 =?us-ascii?Q?B2vdxhoJfGbpFTW6ldzwzs2eIcRgL7anOC3QgcPfUCABpalsJeizZSL8uaxu?=
 =?us-ascii?Q?IhEK8U0Y/8v7JKEu+GSKcemmwDsX06tRVxlCYhPdBSsq9i3PzuuxEzWKIsH8?=
 =?us-ascii?Q?QH0Uq+/TCfJiN0a/Exgl5CN+5Cw2+Z6BZWLoEfCdOrvvm+1MD6MCpyXJw8/O?=
 =?us-ascii?Q?JBH+2PNUYrn4XLvcOy0jizsJBp7+kIB0ykIypdXuClFM3K3NjK7kWMwAhgQH?=
 =?us-ascii?Q?/5WFbF06P2nziyaHmkVHKaeNv2HH1d7DFy+7TrnA+bGpzq2K0F6OLRA98uby?=
 =?us-ascii?Q?m+d1Wi+Vf3Q6kbN07NBnhD/I2WCLUJghqH0rk9B83kWXdMaeZOe4X94+3i3c?=
 =?us-ascii?Q?k0et8fKJKJULb1pC2zAczhfVu/FzKPL3PkaVpE2wdcd8YsR5r9luOVP8J3lt?=
 =?us-ascii?Q?nABUnoDveb3CTKk1UdW0nE1LPJM+uUlfVEsXC6spKYTRLwi42PtO3mZClkgq?=
 =?us-ascii?Q?JJ/xYtssV0PDZvy5Pz07Oj48kdNqhiiqkHzGHX+hcfgg8msHgNHAH6Zs9v4M?=
 =?us-ascii?Q?/MveA04HwTrIOVM2BmPqjlJY27HmTusTjQco86Qe6r85EDOU+4avEVa7vbzJ?=
 =?us-ascii?Q?MLFSQlVF4BUdA08zvBdrFdUTmdxUpzNcA06dalq3eK6cgT0EhTnqrnp9Vv0H?=
 =?us-ascii?Q?tj4trZDyhxsYLxf677BYy5o6ENaRw3lMjwxjs9Ju0WzHEz5Rjj3c7zZrm6n/?=
 =?us-ascii?Q?/5RCQhFsH4s/+R4UJ5VujGoKHzCxOnsKKhSOdvBOECz0EgE2c5CIBAcMBQAb?=
 =?us-ascii?Q?iMYWeEw9xrMpCsz65hCMf4RKiH0D0ZPgWgkIU/kMHezhEVADV+rP0PfiC8fe?=
 =?us-ascii?Q?HdnRHIJCC9YRRkpRJ1BlWwKQi+p+u/1fbPTnvUZd5EyOjqlIPzx2wBExVoCE?=
 =?us-ascii?Q?dFe+9SXAuq+hXMWhgl3Ur5jrm4CMNtK+6Np8sHhEEXDpUMQ9qoXHnR+mQovZ?=
 =?us-ascii?Q?4Nritv5TQg45mM8RceA6GXuELMmciSGyrKowtVe3OEZFWmv+ehMINjYHTcOs?=
 =?us-ascii?Q?SAW2g8BDcQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339b3f4f-bb4a-4cfd-22ba-08deb4ae98a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:25:11.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw3FeT2jxs1oCLuvnSVh9hppDhDvXzcflDjtGs2BkmU0BgRRsEsKwD9xil/b/JefpsdFaDpunvEUzaCk1YwvHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10998
X-Rspamd-Queue-Id: E33E7567794
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-249204-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 002e0a0d9382..66e760015c92 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,7 @@ struct imx_pcie_drvdata {
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
+	int (*init_pre_reset)(struct imx_pcie *pcie);
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
@@ -249,6 +250,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
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
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
+
+	return 0;
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	bool ext = imx_pcie->enable_ext_refclk;
@@ -271,9 +290,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
@@ -1348,6 +1364,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->bridge->disable_device = imx_pcie_disable_device;
 	}
 
+	if (imx_pcie->drvdata->init_pre_reset)
+		imx_pcie->drvdata->init_pre_reset(imx_pcie);
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -2047,6 +2066,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.init_pre_reset = imx95_pcie_init_pre_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
@@ -2102,6 +2122,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_pre_reset = imx95_pcie_init_pre_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,

base-commit: 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31
-- 
2.37.1


