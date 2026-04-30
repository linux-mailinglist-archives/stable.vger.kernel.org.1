Return-Path: <stable+bounces-242193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC8jIX+l82kQ5gEAu9opvQ
	(envelope-from <stable+bounces-242193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FF4A7310
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E481F303A8D2
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86447DD4A;
	Thu, 30 Apr 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoDdQhm8"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D73FE37C;
	Thu, 30 Apr 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575195; cv=fail; b=QomnXdlyxWrjAw9CQlc6AsQ71KN9pArvMGEffV2ZDEkYzRJ5GiW7PHOUJ5cePNpFnZzyaJ1c4HryLG3+iPHHUlHApJraF0GjomabuwdJwHs0b3XTy1SHjpJ2JwVevGhfG8nxUtwNp9NCQ4rmWvSE8vfpwFdz7nZwK1uvgFSbsX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575195; c=relaxed/simple;
	bh=hA8xBq91BshbpGdi8rxmxGYqtrYS11EuJjrYrzGM1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/YMCzZBrA+tLWBUBWPzXerWXIfVqUsTiqsbtR0fhf7/PLVFHkwhZ2SL1Z2VZlngbd3OIZpswStlmwcU2Ijp4MTTdMARVvwwqRLuX+LAP+1eTbYhosVkB30o2fx6hP2pguUXyMpuzG4bKjZP1xVeuV1V/M+nHIjeJNxdoqjIZ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DoDdQhm8; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdQjlXsEXOzKM4y3bM/ZnmyshInUVttxH0N6KUCv0EGnBko/zKfmapLf+RQbYMQkmR9Qcie6FXuNOzulboAFc4yRM09TjnJNZzf2P939a7th6MY09/8mq3I5PbP5Wdt58EW8WVMeye3W+TjUgGMZl963xeU9nwzTwX15uj+bYgZ2dmvDJcWiPlQ4Ac2v4rrF1k7fFWa85uoSldIVC3jn4FEY873k7v4F+nSSVpDJa0ZfRVYFipJtS1uQptBZGhFNqovRnoC6XB+3j0pnAO1hg07yZ3QKuTwP8fxqvcXXusKRflz7chug2Z9sy6aBRN9Q3WSU3x8HyamOEeci1JE9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYBHNahT27Jx06dtM0vYMNdM+egDd/5dCiDmrJKUfYA=;
 b=y0HXYhY6OOkg/j4co5bHPXxiLSCVl5dtfbPcAqhVU7d+iDkoGes7Pw37qPDy/rXRicux+b95SNkzEndqcD2KVCxYuyLvFt4+D6yrV0pyIej1h47JRb1BrmBBZoNTKkUExvj2uTmq/Cftkz+eG91dyhSvhDegmIolu+0ZjKbOWSTevheVoFxxblxDrco42hbiZ4Ejm3k8aj3Mxp3n4GGBld2/CKhsiPscWRcx8zOSgCkz1eO0wnYs0qhRVMMjt+qJ5YsdQgyAXnoPXLyanIsK8GnBZh/m0ZTvFjZmlnwoPNJR8tvcTc/c2LtD8ozbH7B0uLg2DRn2f4dEbBX33ElONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYBHNahT27Jx06dtM0vYMNdM+egDd/5dCiDmrJKUfYA=;
 b=DoDdQhm87bn/kOfAEBlh7nS4asniOaR9JKBekPpU73LDQJi3XfIoXTMFTd19G66U6cVRckqi2Fns/gPQU3+cVrm4YIeiPic50hN7RfglmFoiq1rXp7ezZBAaaN4buy8ISj1x4Tv0HJYAUjvHY4tmZgQJAZbgiogCey8yyeI0nd1n8Q99Nz3FAur8UPrdB/z9EX9zi0pZb3dT82IOWV2KjHev/jr3RnfHUfTs3qjSVqAeAwGgGbPpXIckiP6knr1maXzclU8ltZI+D2YOUZCvISdLpT6F36ZshiMXE3wCbUo1+WecQLig3x48jRWRekaz7CF/6euv/MV2pna1y7Hdtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 30 Apr
 2026 18:53:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 18:53:08 +0000
Date: Thu, 30 Apr 2026 14:53:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Soeren Moch <smoch@web.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Message-ID: <afOlDbxIKBlaNZkE@lizhi-Precision-Tower-5810>
References: <20260427115804.134231-1-smoch@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427115804.134231-1-smoch@web.de>
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b75e5d-d768-45a4-d795-08dea6e9b830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|56012099003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IEWDv3Yp7lCqQbFNZQIQPxAgV1X8k/eMlZdz8RsvQItUkwxUbB0T3V//QqxywDwwTgfq9Z36peJUyOZkZq/MH4fdagDuqDbxJx6MjGDlBDQ0jpj+T6mGGmHIOCHLA0+z+TFmx8WYVL4caLHiAfG4uGQ5h7dW3qgAomKAKoxz8FBxsrHz9jh49GXXLsbh63Pndg8yF/BWsGi5humRQG14Z7TURYJpMGoauFsIaRtckwH/2URP/C6o+suhQaJIvs9GFjmUqt0psQayxqAASMX6WybHCyd5oT7pyztzMnRDt3HUnXsA30godduot053kCVQI1GBBj/9QEWUdJI0AounlGDzKLFHnD+PcgHcYqkFj1o3oHGoj6jh2mfriv/gWEf7Czgma79Tn+LOwR4XLuopge3zld8pgxzPMJXDzgq38/6Gq9zl+IS8dc6jF6fXDlQCiJkCJvoJAMWoEl6QSVMO8mf+EiwhFgz5IF9Iovm2zkk2KP6GmE4Ro8KcwbG8oZKrKwoVFVzp98jcXKpxLD5+l5w3wE+5Uq9634BxC3PFHHV4U3Y89d4xrkH8uOP2r2tpRnOC219RFPmJ1v5aZ18aRFW/NiZ7k6LF9AjNjxPAR578hqlNf61uDxVPBy/pK1bimH6RYuKtgs0vL0+KFK5N7hAnbSGTWptEuGPqvoXw8tpFlYCf8btnGqpv1KVbKCfYtls1OLjppp1RsfcXGqTMOhY9CPB1eD/58mLYmIHJnNnrLshH9jxxXlFvWsfGT6j2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(56012099003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wPHxI41YIuLgc6jdKa1mOXHeY3uy1sTXlm40RBGMgISxHCCHyGFBnrrNd210?=
 =?us-ascii?Q?qiEIqTkvzlt1D9iNR1CIr1mK4fW0OiQqH8OOkFF3sA+UhSBZzR/IYvuVz7wl?=
 =?us-ascii?Q?8w0B6j3jVf0ySJq1o+k2FWa30rS2t8EhCvl+5NTfuw0WCsS+o2eUl/SjXkhK?=
 =?us-ascii?Q?GnTekVjnslwjYE8dmzXrOKYfu4PJV6JPKhEZ939dspepudmI0La8N6HP/o+A?=
 =?us-ascii?Q?juEmGaGVtrtnnCVoOgPlTFg2Shq+y6hwDSPY4vnXqnJ6O7ikJ7gyn9rsfBv2?=
 =?us-ascii?Q?UOuast8qU83h/eHtzc7u+bqrIgMOamjeGwKpydkkWYkPcJDlViZVtz82Z/KS?=
 =?us-ascii?Q?bDbHfxm4B5xujkpoM+kkWnPj8zgMEn8sAfYHFk/Vo2sKtk8pZHS42qy9+vRW?=
 =?us-ascii?Q?Q75F3Xrw4LuaDpUC69xJfLaoWcas9jPlMN0ArBet8Wf4qKqvSbks2bJ7t2x8?=
 =?us-ascii?Q?Kw9ZLpVqkpzATjnDOOleNgrK9Nulem3Te6f8pzCrn+no0rRagDn4V84zatBk?=
 =?us-ascii?Q?CMm+PRb63+Rj2gUr7nlZhblAA/keQd6h2zlLD6QRptao7mhq29fAbZ+aoMWW?=
 =?us-ascii?Q?579KBlAvAOQtmvr614UsPkjG5A1Jd80oBgKCqCvZk9e/qzQgKT1cDA798WSP?=
 =?us-ascii?Q?pPPBX97VTe0jnmSuSj1QZQGHd1sL5xeL9SrskGx4njlNJjdxX0kTrwAxS76s?=
 =?us-ascii?Q?d9hvSgyT2T5XCdB5R9nw35tpmpCyVJRK7uIcshMzMa8vMmensyib0ryOh/AP?=
 =?us-ascii?Q?Cy3M8oeY4mvOlgg46S6WpE14Ec18wrmK4vUpoTunj0oE/7mS4puHmj94eLmu?=
 =?us-ascii?Q?0xnNcUKnJi+TqDQ/Ik5uXPdHaTRO4XTlcl+aYguFswRWjdF6yexMu3uhGMpu?=
 =?us-ascii?Q?oM/bi+F24MdIDWANmZ6DSKz0eZ+p5gD6QZyTQlBVlE+JSk4eX0HEwW3JwLyo?=
 =?us-ascii?Q?ojZvxea9aSN4m5btycoLXBn/afHGN5TFfBkERijaVC7kUWp3G9Y+H1Q4HUTo?=
 =?us-ascii?Q?6oDQ0iZHOwQqCulHF4xIp5FoHoJkDQQSB6VsqlvTh+LNxGWNzhw/ysXSlCS2?=
 =?us-ascii?Q?rLfFoDG8WtHhE+el8rG7RFZVuKnfQ33eM4oEBHkcd6mPnQ6uGqjdXt7736wG?=
 =?us-ascii?Q?A3QERgEOf0aPfGGi8IN0FTNvvrUCHdaXMyZ1iGpncRT9d2Y2U9uiLVLQZBbg?=
 =?us-ascii?Q?JIbwW2u1xnKpwRVlswCFMRwTFxSN/as0de7Y4f0VhrlW6O7b1D4oWrKdViNg?=
 =?us-ascii?Q?YIKoPW6pcGYKfrkA5Ph0cuDDUOc2cmmuxq6juJGZqPh6s8s7i9NVYcAGLwqc?=
 =?us-ascii?Q?4u4rOJfBr81BZF85i2PHxmfOzpXqvTmU4+m2LjNk7HiaLzKFcOZifanBbYgN?=
 =?us-ascii?Q?W59ifjWIhsEnO3eZ0B/iPGvjhO2kOAA0cVWFbzTixDO1kY+griqwPwUOhG2P?=
 =?us-ascii?Q?Ty9rLGZ8HqMk4V8e508aE3wH2i/BPvBHBcq6Ce1JiRvAjnS2QSNrbXiRgXeK?=
 =?us-ascii?Q?NcZYLNAIk2sIkjFj3PbAphps2igKecb7+7hWEG9bsLxMHzJSjELC+yT/ajve?=
 =?us-ascii?Q?Nw0RUzgYL/p4tWhzFGzOvynSe4Mj6ph9gh6YEXARc/35+coTjW9rJXQJZZj7?=
 =?us-ascii?Q?OavcjC4DnJJB+1HY+BWAyWMmd/49bVshtA5B4o1gr1osEMKhKW75NhoyAt6Y?=
 =?us-ascii?Q?+Zfn5mXyB6+1juTOGaJTGMgFahLwebeEPpWFmO88BH3vVrtPuiVzOxpthDqm?=
 =?us-ascii?Q?w3kjPxnBKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b75e5d-d768-45a4-d795-08dea6e9b830
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:53:08.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61rwFEFwdIqxKj/12h1Ot667V1B2zETzCg7igjef5Qg2ce1FIz6hUCRPc9MMikY1ESoqEARTBU86eVPUInmRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Rspamd-Queue-Id: D88FF4A7310
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242193-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,vger.kernel.org,kernel.org,pengutronix.de,google.com,gmail.com,lists.infradead.org,lists.linux.dev];
	FREEMAIL_TO(0.00)[web.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,nxp.com:dkim,nxp.com:email]

On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>
> Even though the Root Port MSIs won't be received by the iMSI-RX controller
> due to design, this chipset has some weird hardware bug that prevents
> the endpoint MSIs from reaching when the Root Port MSI capability is
> disabled.
>
> Hence, always keep the Root Port MSI capability for this chipset.
>
> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
> PME and others won't be received by default. So users need to use
> workarounds such as passing 'pcie_pme=nomsi' cmdline param.
>
> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Soeren Moch <smoch@web.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
>
> Tested on a tbs2910 board [1]
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6d6a1688e7eb..3d461bdef967 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> --
> 2.43.0
>

