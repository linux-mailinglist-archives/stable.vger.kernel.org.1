Return-Path: <stable+bounces-246905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCslOH+fBGqbMAIAu9opvQ
	(envelope-from <stable+bounces-246905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:57:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5315369E0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78279345BC23
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781247F2DD;
	Wed, 13 May 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RGKZTEec"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAA472797;
	Wed, 13 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685351; cv=fail; b=cMreDCLbEUddpu341yDclFuc/WLSCPFUbnmFEuObaOP9FLUk3w7U/mCEihpuXpwx79mbYkK4+uJGcByTUiGoj78FFDSlt4Ni+Iv9ahuGIuLPkd3CaHgQ+i72KIwxIPc0WGmXZLFBu8AyfrCwMkpStRT2qOy5xP0dJDlctERvB4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685351; c=relaxed/simple;
	bh=+S3a7PavzTD4g1CC3OQrS59HSVLV7c97oNrgFZDLFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=My7J8AZ62k7mwXG+WrGiDLnmx5B/+xKcyTgGCYU4ToDcOWTZyIwmSQMw4VlU0GaJUlz3KL/QP19u79SOayNHKPhONff1WhjCVXnherfUYbqURVIgqzpXiEYtHVlOIoRTCvrS7TXFFJWrar1+xmnFwjjwAIK8ZaiTxNyy4Agbmn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RGKZTEec; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDr7bjtLcV2kllAcRMe2KkpsaWEdIUwyPhxGWKUAUCvsKN4D1OtS9yTx05IvSdQR0BRghxma1WqWZBc/OkL+JJ0IC9d1poMVe1Qg94OzsytcBQK1hx1q4BlCRUaEk7LAjCEiluyWVsHMyfekMkuRBhlTBb6JAtY3qFZJ2RD1eKB6SpsyqNGKwyOsDp4P5emU1W1cDBz/9bhtiHSV8QZPA5R4jVMJ/Zn712CTq0NSNxfRcGN8lPSH9vb9COI1sFTYddtQ/fp+J8mHiYUFPTRlroJgcf8uLgrdcT+81G8Nb5Do/TeqmFZunu3NdjGPAIKQIbOg1ItOPkCxODAd5e8t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PhLi/gU/akWa+adOOxtrBShyISnlkKmM+tsEVdwzYA=;
 b=ZmbrwPY5GmlALqwzzBdaTnd7sLrDC7t7ibh/eoPtHfIFodVmA3qi9MwrasyDhd0PuOI+T/kgOw0ywX2dq/OFvWlKharNQWSjcMBAqQYwBMaKA+e5j/xqS+6hj3RCwJumyROwfl6ZFMZb+xtjpS2fsuim8vxT7VyNrPWMHTHO9JlprML55GJc0mVRRmmLMjsD0yNf//bSj0lcLrAdq0yq8xsIeqYqkZTJxZn/il+xKiz06PVTgXT/NWMu4pF/2Po4xBMHpaIzPXgNpuxef0kTr3JjIHUcALnKP/DSELDNDaTuTwTGHYQJ0bXPPNjSDvASzEmtgslJwwG5EWx50Dl3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PhLi/gU/akWa+adOOxtrBShyISnlkKmM+tsEVdwzYA=;
 b=RGKZTEecw8rgMfgHq8dVhAS2HWg1kKK4RMKYmjl2ImCyvIeIZOChhgOhta1doWG+cIyXS1c4gLYJCulsMS9plupLzuCu17M9qajDO3h6CWWnnINwTx0moVm94DvY0I/kfw+ixHBiywo+YNnLklR9Y+bo/cLl3dUoTOi6Xna2F0KEYjAqDPNtvKdYs8X6pHURY5FjYar5wJchp9HVl0slmZFD8SHOp3j+NGZpd5rv7ZYNraWfdqwThM/nbM0ZlEZiKhFeVjCpVJNsDpMACZZ2ooU0AGv4/sR82oz9G0v1QcRYKm2NlIq5LBrNQMmcrR/9HZHR65dYX961pMHaoydFXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:15:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:15:46 +0000
Date: Wed, 13 May 2026 11:15:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Message-ID: <agSVms2Etg1taGr0@lizhi-Precision-Tower-5810>
References: <20260512052244.49414-1-hongxing.zhu@nxp.com>
 <20260512052244.49414-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512052244.49414-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3c1115-7238-4584-5bbf-08deb1028212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|18002099003|22082099003|38350700014|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	whOWVXDS8B8U9Mm3s/MZYl1W6imGCJa5H+U0bkD4E5Vohidez4Qfi5whnBaw7m0jwplUKF3uKSbPGLl24LjYo/Pw3/B2Jb5zT3gVUgoUTz3s9CuRoWVrW9fwsM5GZn+082MEyYEz+KbyfJWjmxl9m/VbUNLxL6OxGzNidClJhk+6p8nQIUt8VjA0IZ+j0V7fHc+pOiEmp0EALcdgbWkxsuDpBKFdOHcY5nVTB2zOHSfB8Pu60Oq261ZktvM2LoyQxCdh5pT8Xq3FicVQ2hi8lKUq0Yek2vZrwpHpbDtiT7/+26PfGxpaRJl38+R2VFkplrsWcGrHSEuosmiU/03TK3UyjspEnJ4bB7Kuxr8oW//2PP3wVYKzsB3JKGBAlpHBwPTRUOJ79MWKqfYW8fUgNryGJGjC9tgg+FiEsYizPRymgmqNZfHTtbNuNunwQ4/ThTRT6xvO4A2bMQIQ6m0LpsH6D3SjQqfPxa0DaEkCe62/x+wnwZnoW74viC6CjCRH0aPO4N5gRh9SkGEyvA/Rihiv6azn8jpDNy1vx/swsA6aNjBr/s0uSH+K9hhRInFMYhyTXo6xyNRcLNEC0gmjog7apstR34psCPc8ZSdWZs+L3jREmpRQkVG/u3esjGgz5mavqhNMoOnrEDRsHVZ5vDz8kahb/ZOZA6HolI+YuN8JNi00ix5txkXpVbg3FvxkRIfQttnbU8byV2jFhjHnWawHaWsHP350YxBVRtKJzR1i13IXIdUtbLYv1nLQo6a1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(18002099003)(22082099003)(38350700014)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nIkbWvYjnGK/PerlSL+ES++Yt/judN5cOTNh1/ht0erR2s5MefI6W9SFxGo?=
 =?us-ascii?Q?h+aD+Ow1QC5jUCa9h0Ucw2P9rxjbeXt40L3MwVZRgQr8COO0LL6D8VsU4zko?=
 =?us-ascii?Q?SEum9ulj2GmDoIE5sXAH206XZOQSu3q8DcoyBUUc85QIwjVKIYPxJKFM7Q6t?=
 =?us-ascii?Q?UCSj7pr6pDDl2sbmV6wuDyS0zotQ/7dvkg8PLA51LPCIwxBxMQPUlSlx3hLv?=
 =?us-ascii?Q?tYSdXUf9viNFMCBAvo+RWySpFGr2308+Ze4rIzcpPZqVRCnOSdKSiieEtrpv?=
 =?us-ascii?Q?bz+76rlXEAGjYdJzFfmePRZi72FV1gFsqpEGpnoCkBrp/DbtpDOiXqGrcTUs?=
 =?us-ascii?Q?QkX9pOtU5kBwLnC/KYTRq0OiYxWKX0PrIE3ljz2hsvHbxZMlhNaohfUpp7Kp?=
 =?us-ascii?Q?LDIRKE/jrZCvVXSsnnc2MOGquiTqmXn9LJffcfqKKi8RwEgk8xq+5kQ/aIMF?=
 =?us-ascii?Q?AuzkA1VGPi2UyuY/21+svuhVyysGUYEjGNpeeXnoDYWmzFJgXjQ/IB4F9OD0?=
 =?us-ascii?Q?3yRdC0P4qovXUwzemsA/j9aRepyBMzmF8QBH3hdXbb+Sz9b2GRfHGXfYmaNW?=
 =?us-ascii?Q?b/BNR7lzaXUM1fhw0zhUBBt2pZ3ksVyJtQqs1/JwJcF9h359IdqntU783GFa?=
 =?us-ascii?Q?wW1XMbTDsR1TfDPtGqkhC3nrDOk4ipHDhKdJd3Mufv3tSbBuR0bJ9ksM2cPG?=
 =?us-ascii?Q?Dehw/V9xlIjBooAtGvIJclXwN1oAyk67D/r0UOUFctwEfJID2fkjm8cZNJCb?=
 =?us-ascii?Q?3PL48wMBf9UQ5IDWeOqWRsPZV7o5Ey6d2CVCND7CqV+bVUG9y0E0BmbS+gNI?=
 =?us-ascii?Q?lHhCpP3wByfdogKYuVJfG2C31/8jBThzTKgkCfOcOHufGVQ0R++VxWHV2J9f?=
 =?us-ascii?Q?4cneK/OgGI+UDzy8rrlf3n7+ISC1y9g4JMVhrIzXpY2xikUa7EqXzwiOavcI?=
 =?us-ascii?Q?4uT0kwrXhorR8YroWJORC1zNCg70vBMFXJPQAbb7golYKbx+SdTV3smUAXtX?=
 =?us-ascii?Q?Zr48cDIWDwZ7Z2unwjG3up1vp+CnL0v3jJIpH5RlLmerxdWrlGNtL/FrMSoG?=
 =?us-ascii?Q?KC7Se1ZCS7qlrI3LIkJYaybtPKm+poX+R4jE0HOFpT6C82dm+fN6MEwFk3v5?=
 =?us-ascii?Q?lntiVGnwIlM9hLO+azEwxjeRLDDUM4dLZz3DZea3WKPk28qCeOCN4cU2vPoX?=
 =?us-ascii?Q?c8EC13saxuSWkCIxMXFHtUs5F/pIpft+uKexwV+KGMdolj71kY9ml2kCub2Q?=
 =?us-ascii?Q?jNBvIQXz2Etu0+yiehBfHzgo9usXWMdS5wh+Rmxr8o1uTuSVpv/joKZUVDlI?=
 =?us-ascii?Q?8QFPIX2R/LChTbsti1O2MsVLneg3U8bWEZibtw+92cTJMYFkPm3O1+s3IHdU?=
 =?us-ascii?Q?Su4NSEfvAHIZKv2xs8YUBFsLbBa9X4oKkXMMr4jNT42/52KP4Unr5L8vKzUK?=
 =?us-ascii?Q?Sb3iuZbDq0Yqr5C7epIfoDCpDdCT4OJjKWZTCSrMOwnp5xEy1DQvZExSrezK?=
 =?us-ascii?Q?hc8NmKHbRR9EyLAijCOMJ0hCQifnrLTwDVnEV005tUKFbDzA/oGCQpPEZl0P?=
 =?us-ascii?Q?BeVzf9nKemFYhuuUnV20ma2P3f9fxheH7P1yyYZqvTK/A3KvklmLN0N2ETrM?=
 =?us-ascii?Q?ZWDw5fexjue3cBLR180fPW8kwC9uvQaPpEIY4i+DjX9K9ewfjiqtWPaxDGSp?=
 =?us-ascii?Q?vj2+AIOziLQtxz4oqTZbDGkF7K695u59KGxry3AwCp4NY//r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3c1115-7238-4584-5bbf-08deb1028212
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:15:46.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6WjIfprk0oz3/5sYC3OKsEx94Dj5bzgBpNQgRhupv3uNVJ+BNeuEMqVrKfJXyfz2gLcR06brj64rwBLMQ6yGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985
X-Rspamd-Queue-Id: 6F5315369E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246905-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:22:43PM +0800, Richard Zhu wrote:
> According to the i.MX95 PCIe PHY Databook, the ref_use_pad signal in the
> Common Block Signals section selects the reference clock source connected
> to the PHY pads. Per the specification, any change to this input must be
> followed by a PHY reset assertion to take effect.
>
> Move the REF_USE_PAD configuration before the PHY reset toggle to comply
> with the required initialization sequence.
>
> Fixes: 47f54a902dcd ("PCI: imx6: Toggle the core reset for i.MX95 PCIe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1034ac5c5f5c1..c57f18d9e4ffa 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -137,6 +137,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
> +	int (*init_pre_reset)(struct imx_pcie *pcie);
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> @@ -247,6 +248,24 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>
> +static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
> +{
> +	bool ext = imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
> +	 * used to select reference clock connected to a pair of pads.
> +	 *
> +	 * Any change in this input must be followed by phy_reset assertion.
> +	 */
> +
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_REF_USE_PAD,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
> +
> +	return 0;
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	bool ext = imx_pcie->enable_ext_refclk;
> @@ -269,9 +288,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD,
> -			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
>  			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
> @@ -1251,6 +1267,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->bridge->disable_device = imx_pcie_disable_device;
>  	}
>
> +	if (imx_pcie->drvdata->init_pre_reset)
> +		imx_pcie->drvdata->init_pre_reset(imx_pcie);
> +
>  	imx_pcie_assert_core_reset(imx_pcie);
>  	imx_pcie_assert_perst(imx_pcie, true);
>
> @@ -1961,6 +1980,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
>  		.core_reset = imx95_pcie_core_reset,
>  		.init_phy = imx95_pcie_init_phy,
> +		.init_pre_reset = imx95_pcie_init_pre_reset,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
>  		.enable_ref_clk = imx95_pcie_enable_ref_clk,
>  		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
> @@ -2016,6 +2036,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> +		.init_pre_reset = imx95_pcie_init_pre_reset,
>  		.init_phy = imx95_pcie_init_phy,
>  		.core_reset = imx95_pcie_core_reset,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
>
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> --
> 2.37.1
>

