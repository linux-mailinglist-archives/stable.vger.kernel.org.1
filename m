Return-Path: <stable+bounces-233040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHeILAF+zmnBnwYAu9opvQ
	(envelope-from <stable+bounces-233040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:32:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BA38A8F8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEA7301F1BB
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AF3E1205;
	Thu,  2 Apr 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lk1w95qC"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4F25A2C9;
	Thu,  2 Apr 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140272; cv=fail; b=W1Ek9sUYTOWFKM9SfbGmiv+EEQ6nqlEMboNRnrMUQ+zy5j482aE22gMCfYIOt1FgeYlwXic3IRDsBM8lXF1GyQ+p+edC/LUtK92IoWBFt3kd9xACBR/o6s9n8LzqTwlmA9EuO1x2i3pHP6cBUkDb0yh8TkX52tZNqlHSgyCLhvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140272; c=relaxed/simple;
	bh=xswyS31A3dfLWzZh4PdBtvDwAkyspSckkJWduxIKRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BgDt0NIkVC2fd+Fdq3T5CVbAeiBmue8MxjSWQWF+1Cemq70aDsivUI7gHMQfSluOoqQ8Ik80wnyEn02mdhFoKYZQ/A/HoXHAyAQXBjVf9VZcWNA8pzey0jPqjoxL5i+O1sMszo0GZ5TGeYWYtNY8XU+QKctTYkDyejYjEjGWzNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lk1w95qC; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJrZpKohiip0rC6byOcskk05ZZdZNqlyuBX5qH7KyJUb1GzlQau1/Pe62NdveUKFY+GdqJUaXxcfxUuz0Ia0Hnx5r94kCwNTkp1HVYDZsLqOKTSsKy1X2brmh1XLg0dK5Y5CutUW7pV31yNDikPLARzsY3SYZVS70UqLiys1EyD4iQzaEoz8A4C1NqI0MXPsFRCfJAH76mIDL8V1qyjLuEFUcv681GEPQCJxn8SJfPyFYoHrsVYNmxqJ6k7A10GDg+dpaTSbZK/eR+Pcm71Ulfq0T1h0sp0zdaQ/t1lAZmP/cU6QpnlBxlwpQbUe/VJr19P853+5WzFQ6caMGhE4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Kmczm5goBgm57ZNtN80xIw5gHePM04YwgJBnY9te8=;
 b=PH1kcU6GZ1JYscgQKonIBx6CvKq4QT7RRDQ4X1l7qk80Y95SJCbhKamIpRUDeAB74qDr50VYCH5EAKU/y/E38zT4HyliqHjhcr9pj9kHHrFtrC27T7p8Vnkmy6Xrcl3tckeDzFHs0caSczzPUG/dUhrYJb8PY5alPidsiIFAm0MmjoBSAbOMk8igxZs3N9w+6RjIrmqrZEIru2ZxOYJkuzvF2FbKfhBpk7V4r/5JU6UwOFv1GYm7zEG2s1/2TQf41PT0BT1fBqGyjkO7zLaTNmam+SivzjkHXyePKSgEpIU9gJKCAul1ikufhY6/33gfvkCovgSRrq/pmSBGTNUNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Kmczm5goBgm57ZNtN80xIw5gHePM04YwgJBnY9te8=;
 b=lk1w95qCxtH+6qsz47ppaTE4aSGCvx9WK/qmDV7YWQjPM8b9N5XEVBSaPaTKTTRpkqeR0QI0bxSeMrkHrpRcziXHxs5y6uEgo0sZkA8xo2t4v5uVm95anBYHZFZeGvByrbqKyFjNrv+DkKgPAUmc5dsA3e0iZOH8Ldv2ZPa62MQxXS/0AwyXzQzBvSSNlwqOjbnwAJwPIx+1S9gHAnyUP/qLRBhGKyTxEZvLozxVzjps9kCLoQwyInlCgRxnaQLgSoI4Sdg98boNpyVqAbNWYyn6GivrM3amAPO0/yoJBRdkXpYOLKidKS18rLlMbUgstewYIo8q20Hye/Z2UCYCwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11562.eurprd04.prod.outlook.com (2603:10a6:150:2c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 14:31:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 14:31:06 +0000
Date: Thu, 2 Apr 2026 10:30:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Don't remove MSI capability for
 i.MX7D/i.MX8M
Message-ID: <ac59o5IEef9oyx0U@lizhi-Precision-Tower-5810>
References: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11562:EE_
X-MS-Office365-Filtering-Correlation-Id: d142c6bf-fe3c-49a8-eb32-08de90c4797b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Q/ssONlkbpj+L45E9w1o5URIaRCKClYlxfADqHN2E77aa7jro9aNDVc9giAHDL2vEOhxh0Ij58h6QqrGfeFoOP6+jhI9Iyqn+Igonh0D4PYmUohROwACTbwyMU6j04yWhPCNaMN7sEzq+25HVmaQrPqAOralNNknMZO/d6lQFT+YFGhRJ6NfWTOcT8QQCaFyHL2detlCFmvN+qD3XVWK0xYTe8obCoOw3pI8cE6dG2OOdsSHhxsJAByhcQP9n7Iy94BE4r8DAjdpXO6JQurVnVTPx8uV3wgU85adfRc1GVFUDE/NAR+9+IVimnes7QuruuENv5vkY5gqgvbQln80NVjc8ijyHdF1ic7H8NkM/ELCvaMej4Cz0/kCmLo/VBDnbFONsdAewry3y7rOOAqVQTFHsw3Sf5i07zmtLd77SkTpTmOuu9CYYaQ+TqQfRmJwxCc9ZPUhMsQxyHVNqxA4s2cAalhcAeG/wPgwPqvduThcxNZ6ZuOlQvaOza3TV6G8DAlY3BmOewrwYMK/cMgHR0r25ZUdtiHSAPbevB8WkbPHAHFConH3cQWLAbpw7Mm7JGxO3M/HAGILi9XXinTIUgsVAVg4w3eOc+TT8jlxr4JcnLMtVqVdypHINxARo99RdqCDro1Ro1P7XRWPYXy6jUvOFGpS18iAmDQE2VBrboNeKBEeQLtfp6tdmGhs2Rg/XvlBrSu8banMmVIq2kdPaV2ZzvL5uPuFCBewDEAW2S3AsZLgTE8h+Lm15vIecaLgq8kUXBnzuHMO0ImxL/DZOtPSMLsIF9hJF6kkxd8kvg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SonnrpC4nMlbFxTd9i3t3LvGByPS+u9BV7G6KqKCXu4SkED+HQ8QhBp36tiJ?=
 =?us-ascii?Q?QNNaoHjvte1KdVa2e2R7/o9OwnyH6/7mIRnEpYeO5luQ/ZjzQ9b5zjQ6xkKM?=
 =?us-ascii?Q?t/8mo0hooJrDLfr8Irjjj6IyB72o+lLYF+PRq/It2xd+zSom9IG18IGtGvpW?=
 =?us-ascii?Q?dDY7ULI/F7EI3/YEvSDmB7YUbmaphJ4TkE8lrmwa32jiHEH1Ow5d5UcRzgop?=
 =?us-ascii?Q?scJF9iw9WqbBkNQlooZvcxIxxydTOQ9YDuo+aKLY2foqEIxgTBnKFHvwLVoN?=
 =?us-ascii?Q?NZjvgbwn0BqsOl3Psg7eIKO+owyje7r3nKdS+EvzUT+AJ2d0jSoUpd2GKp0e?=
 =?us-ascii?Q?Dko0kHJTpe96UweU7VyrOrHKHTg8tapo1+g6kz31pQdmyOQXyvJrR98KpeJk?=
 =?us-ascii?Q?30iR7sOJQOQaAaptWaT5DWh/EPpGPJOnbbw7dFj0GGpf02SpSnl1qZGvPaua?=
 =?us-ascii?Q?2KM4xDc0vS13DryFpAILd8b0Uju/FXcBpZCzwjAlAG9jzM/vUZMQNDPs/ONk?=
 =?us-ascii?Q?eafeIEgleKCXu8RKFUIW8VsMi4r3c6uc/gCZ8//+dtt/wDQ6kCmexmSPJiVu?=
 =?us-ascii?Q?BGeH+H/ma6/HWb9f2cj3a5YaaCpv13cvKyxtfmxKRAyLQnCqOPRMzh2w/xfA?=
 =?us-ascii?Q?O0dGWuhPiC917KCoYDTxd6AgnFVzLZS7edOgT/evq2aduyDgqz7HNyMQcQnv?=
 =?us-ascii?Q?w6H2JcC0Gd4WVjhW/M09QaMlecsdL1N2+91x+YSFD2whrrxPDbRGkRu8nueN?=
 =?us-ascii?Q?guoSlg+8RR/Bgt8oIzAAPL/9sJE5LjzrYA8DwfEfFOpdZS4AW2l5Kx842EZV?=
 =?us-ascii?Q?gD8mJQ82bgmW/RG3CX1Nj4cH2MyvzNVUjh1n0RzvjSesi4TXqJwc56ymP8w9?=
 =?us-ascii?Q?Pv7iBaYXMXQBlDQc05akUss9Yu9rfXLfCm1Bl06lzPar0hbLAMOKKvf2CyXi?=
 =?us-ascii?Q?Ud48PZy6TeF6ImNcsBi0yv/5slwiSNDphrY4W+FllxfhknT7j3IHfZdEeMPi?=
 =?us-ascii?Q?/nHVmrOlKpH+bLbIpUl2C/+IdHGzKOsNKezNKMuPchjvt3uO0x+NbSL3ptdv?=
 =?us-ascii?Q?zL8Wqx0Q2UJEo2ngnZlZYshK/DEAbuqGr/wRMG1tlNZ8xjAdwzBhtQCy08eS?=
 =?us-ascii?Q?7wlhW8MD8lVkr35rKJP2HZw/+k80ifk1jYpKUefjMBq+tSahAo3Fm5MvFwnm?=
 =?us-ascii?Q?PEI/X+CFGelp30PP/dC5DJOdFtp3MTHg1Gfsjl8veXnCph7aVDx8ubzugBV0?=
 =?us-ascii?Q?Ompr9Zh0VqdV3Mhr5mz12drZrmivMQJ71bX+NQUy1R+KqR3NA29tchzf4Hr2?=
 =?us-ascii?Q?bq0omMwqmc51y+imRyIPxvx4klrsQVxWsNH0ETP+3nLBASWKAXDXdg6Rxprs?=
 =?us-ascii?Q?DHOp0iczU+I//2INw/iNeY92EItuiV0+L2hdBpFqJKA27K0Asj2ASzeRwE11?=
 =?us-ascii?Q?9qG9E/7YM92f/iab3i2QFTdxlDUjWzt239TZOFkjhViB7HHtqtfArM3N0zYU?=
 =?us-ascii?Q?x/YNiP51nLMMurP/VYFTtLXQYklWr+x6ClKxRs45ng/jo4+gIMgD1EPyT6GN?=
 =?us-ascii?Q?4ZDai/DUEzD2Nm5NsUlBUU7bnqc6SuoH8FnBWUWFjBUJnp55Ij4DUzmNrN/3?=
 =?us-ascii?Q?OpX3zMI/n+bVKEIFia2TC1Rh13VovEUUOfkZFo8rvFFjCWlva54DEKungYdu?=
 =?us-ascii?Q?syse8+Gy9jyPiGfJcXa4BoY28GcQgTTyg9snrcLKXQnJBd4G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d142c6bf-fe3c-49a8-eb32-08de90c4797b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 14:31:06.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr2rivrCfIkP3uJutVnD2PTZ55JVJNh7801RPzIEUo0j2BSzEqsNbKG9nUEqRCNQufuH2P0m/vCblBzImnYOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11562
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233040-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 0D0BA38A8F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:52:52PM +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
>
> Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
> that should preserve the MSI capability during initialization.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Cc: stable@vger.kernel.org
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v3 changes:
> Use a flag 'dw_pcie_rp::keep_rp_msi_en' to identify SoCs that require MSI
> capability preservation, and skip the capability removal in
> pcie-designware-host.c accordingly.
>
> v2 changes:
> CC stable tree.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c             | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 20dafd2710a3..fde173770933 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -117,6 +117,8 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
> +/* Preserve MSI capability for platforms that require it */
> +#define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -1820,6 +1822,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	} else {
>  		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
>  			pci->pp.skip_l23_ready = true;
> +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
> +			pci->pp.keep_rp_msi_en = true;
>  		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
> @@ -1897,6 +1901,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET |
>  			 IMX_PCIE_FLAG_SKIP_L23_READY |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> @@ -1909,6 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHY_RESET |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> @@ -1923,6 +1929,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP |
>  			 IMX_PCIE_FLAG_HAS_PHYDRV |
>  			 IMX_PCIE_FLAG_HAS_APP_RESET,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a74339982c24..7b5558561e15 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1171,7 +1171,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	 * the MSI and MSI-X capabilities of the Root Port to allow the drivers
>  	 * to fall back to INTx instead.
>  	 */
> -	if (pp->use_imsi_rx) {
> +	if (pp->use_imsi_rx && !pp->keep_rp_msi_en) {
>  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
>  		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
>  	}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa..b12c5334552c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -421,6 +421,7 @@ struct dw_pcie_host_ops {
>
>  struct dw_pcie_rp {
>  	bool			use_imsi_rx:1;
> +	bool			keep_rp_msi_en:1;
>  	bool			cfg0_io_shared:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
> --
> 2.37.1
>

