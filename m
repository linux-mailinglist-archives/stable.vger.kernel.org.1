Return-Path: <stable+bounces-66044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2094BEFF
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109EF286915
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC6718E049;
	Thu,  8 Aug 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FkAy9nbp"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD763D;
	Thu,  8 Aug 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125814; cv=fail; b=bR56KQULWnlKcqVOXSGSEACfXy0lXD42nZB0OvYGbj0+Nt+gBkGyExin7hB3/h5Xn5g3FZqt2KtdX+WXowLsspkmImoIlJSjipD3AhHahzL2FPXu5+A2ntSagZawOdkZsDTYt6PyY25iLTWs+yLqVuEhcwmOv3hDuOTFzXshJjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125814; c=relaxed/simple;
	bh=MDUeR6PXte4fA/2p0fQQ01PujSehsrBZ+uW/0f3p7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVRtbJ0Ye8JVnZqI9LS/F/okm07ruQ/GxjWfWth84BbH923avvxudGc36xAY7pS6ttJbb45mpqlVA7cqQuAckLh3vXhxsAfDdL6If+9AijylkxLLtS7XKTXbgaQl60lluWb6mCoI1AoZ6YMOTqqPtHudZ+XtRMkVIFgS+tOrzyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FkAy9nbp; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvApHqTKKI4deo8bTAyswdrSuOtQw0B0KwGt/nkvhF0ktMznEFA69oDlcULq5geI8Qtmp29SP//G0HD/Uh9oVTvq6K0dQPwfudEPz7ZU4ZWbtmSOvzlJOmjsmug0e9AOxItNti6XX6jQWZsVxyPHZrjXKoORKGb20dCOOdCJF2GOYpCd0m9jkEaBui8HBKkcm2jxk86yZ7RWQVLZi3Sx6JUS0lNVLXVs5xOxZRMcQpIjIcCbDp0Jmv4n1IEzJFG3abcRER+eAlRPR9IIvegTqOF5TnAciqu13a/S4K881+nGzPqtW06kk4yqmGWHPa7PlL5NloH/V/qxMGW81fNwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnE/MDGEwZwViJ8Uh76SRYmhnzn1nokWciofmccllcw=;
 b=AZF1V72WZ4TcS8thFzudln12EEURua/RaOaf3wxzn41jlI+2tx3xoXEuDbvGWdnVOh5d+tUsYvQsCZd7LWOBfPaaJxECjMWfyeO+RLhPBjvvYY18wOIdbykg2ODxigodLf0NYMwFx2zy7Li7ut8xjMEe9Ydbpmxic/GyWOgGSUjL4Edj6m0jhxdLSLi1qWrWykrVztZBTlsxXMwjpFmwkFtoFIHSTiP0YM5V85vq3V+KRdqS9mqQcx6dSdvz6O6V36ZqGszMMLingGBDjBKJMt47ABBCMkjhou7PYIJmTn2BZZk787EUm9X4d6bhPQ7RoVFCQ3occ7dBJgkiuB1NSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnE/MDGEwZwViJ8Uh76SRYmhnzn1nokWciofmccllcw=;
 b=FkAy9nbpRdmjXWf/tB3hCTrPuqlq0D312vSpF760MkoCNMAzZd5+EhTnc/2QYw7zm5tgKchLYoVf1YR4oZURvU8ppdTZHOEasB9MdBhg/h47ZroOGQeTplX76Ny7ZqMoTfmStAbhq2UhPDeKStuhCxcQzYYaqkfNROkDkkAp2VJnm7hQjdLXOC9+1pBfkOczmWnc+ESklkNUOerrpoio2o/qRGAJyEO6zZhCwa8HR5T9LRvLzxmGCjGLm63ikxMv+p0mpYqOpJNQNQPvOYb7UmTJ88VTg8mh03JXngYm5YaIEnfNRUVOfe+Z2joP5eRhXxc796cu4rvIoQ+0jcjsxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 14:03:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:03:27 +0000
Date: Thu, 8 Aug 2024 10:03:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Message-ID: <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrP2lUjTAazBlUVO@x1-carbon.lan>
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: df6a013b-8972-4e2a-005c-08dcb7b2e028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5t9IptoOScRp3KGIoI8dMhRcpa7FNNnWd4SCsglEow3mGJPdqRTOFrvXegF?=
 =?us-ascii?Q?EDRVaLJqiWEOif5esrJ3sqCP0JPAKcekSgF/ryT+4ZQtnWKMfZm8UNqh4cbt?=
 =?us-ascii?Q?0bKQpWYM90TDKtWUGwCZ4d9NWQYGCQAVjJ/CxlmK6kpG/C55UFmeqMITncGn?=
 =?us-ascii?Q?LEFya23u+LCZH/vugXvZ9mp0ZbzAphRbzjN5C3YURqMudzEyAwvga+8o4Ft5?=
 =?us-ascii?Q?c5cCWx8dzuvDFpn4HO3uPKVbiGlul1x+fCgKah1Z+4wo3eGmEcgE/4DVxEJh?=
 =?us-ascii?Q?u+DqPKDr/wMAEGrN3xVhdRvJexcY1Q9KHPDXg05ZCQgS44ZB+/nNasicHg8z?=
 =?us-ascii?Q?LXXi/eQvCtbX0Y8lTXY23jPYELVaVc9WJ9WngkqymV18fya6QsDJGEpJRMgJ?=
 =?us-ascii?Q?il4ILpHIvATcx9NAJBZ6Pjd9VZsoR9l35Vbw4kxa4v7EXt6/na075jB9REsd?=
 =?us-ascii?Q?6UQY2hrsLZkcFuaf3l6cmh0TfJkq3ue+O6bqtr/TERY9yktLoIUU4dJw4GKB?=
 =?us-ascii?Q?n2t/F9qzanTRCgNMvBtWbM4PMtMd0HM1Y4niUJxgdcaTASB30IZLRSFQSAZG?=
 =?us-ascii?Q?Sbo6UthJgZgdcx812wNABrPDTpiuzeyxCemjKzm/RGOrRrm+gUF3zVvM0EKQ?=
 =?us-ascii?Q?ek/s/prTzq6g3d5fyfPo8/+XqCE1PE1rdEZOt8UqjTsaY7isPgfeJaXzw93Z?=
 =?us-ascii?Q?LlpVWYQplYQLmqjKS3O+b4nmW3SlwH2t9mJ8Gdk1UDqqbAghbYQbVGylLHYh?=
 =?us-ascii?Q?lnfu1/eOfAQ4fNtfz59iRoewiZ4MjWoClkHXzIqI+HokFfYE2kcc4bZjPl2/?=
 =?us-ascii?Q?jP/f0oNud+rB0un30kH6Uip3EIKtME4cpaC5BhDSY634WWRuscrfg6GR3H+u?=
 =?us-ascii?Q?vFceSBYRunqOEohD9ouhxXW9cC/xwGe0dn+WhITbQzU7FB7KUAoPSYp/Uwr4?=
 =?us-ascii?Q?Ro1lN/JFQzi3+NvMXVnpJY++NVrnqchBXy/bC0McRi7wMz79hOal8iwyIEof?=
 =?us-ascii?Q?bZ/AHdx+gKQ7SacyUF43I08hqw3VjnaJyuS72uG63ImNjsypvdrnzefajamm?=
 =?us-ascii?Q?rdShQrHsA9lC+720+bz2LxV/5nZv/et0RTSW6MCX2jxcUmere7ExrudduCVz?=
 =?us-ascii?Q?il/zjMNZWRdBw+fAC+fGQd5lZCxF/PvicxyXezKBXIec2b9P5zBzxiRUm6DZ?=
 =?us-ascii?Q?ewS3bD9bfovtFtWSQegFjnWjYSSp0H5snmmRvSax2CS4cjmqMy0sIhNwwllt?=
 =?us-ascii?Q?oggGXuchdbDd23XbxzXPWBSbwswoptr1btifDVx2zDKl4IqJ6xl3rI08PKzE?=
 =?us-ascii?Q?k2v0XiAKiq6l2nifIcobQO38l5FzKoFTjbH0wcfKPQBbmmbZf2BjGK5iNjAM?=
 =?us-ascii?Q?q1K+zhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glszVPR+km/q/oV706hoeBH+z6UiDlsQON0BGp/YhX8WMkvO7YGClx4hpOxn?=
 =?us-ascii?Q?eIzLB+g28WU9LKBxnwK1yvEpCwu3Nt2K4OqnzzyBAFad20wC4cx+TToPUU4/?=
 =?us-ascii?Q?KjMoU9xFNZ2CVdrAhZfdzRwiu/r69Z+jXFVp3wP3Vf/+Xvihye7DrcWdUfbG?=
 =?us-ascii?Q?J05liuReOTPnT7Hc6axFwCrBn+fMcekGW7ljFt4NwvXlPFp+J5y7rV/k9rhE?=
 =?us-ascii?Q?wqaHjGKlCcebYfJOsIP3pCBF04rhBm7fUGF95lnjXT1t3i47xvqEc14/MLkw?=
 =?us-ascii?Q?S36lEx5dCpHb2Fzyfv7j9g9+SZkVW9AVJJ2rWqMNxBTmZZE0uYmKdeYTprUL?=
 =?us-ascii?Q?N0eVzu31zdnMH44M1CeA0HV41HXnMNckgLgP2GiRhznChMuVOS8cCtmmfdve?=
 =?us-ascii?Q?rIFsqx8NnsSvgTwWRR7RwZxiSkyQMe2JNgXkJprMSLB1mA/qnkeI5h+0+ESE?=
 =?us-ascii?Q?i/5Z6pAjp71pcL//QAlyIbRGdAB6sOGejen17F9zmBlCVOszdQhfpAiVFOTC?=
 =?us-ascii?Q?25+ZYJ3gRM3HvnRvzk6Q+45I9rnSrSxv1bjB+B+3Oq4w9BGtttXHolBqZqga?=
 =?us-ascii?Q?buAnrJRRDWKNbH0fkdTc13CwIxloSEz/RGXB+gMKcfWDgn0zEmMf7l76VGo0?=
 =?us-ascii?Q?vafRxSbcxF47uyqWPLH54PiwYeQCiTidXdT7NK/8kdOM/KIEaAMWtcFTOmYA?=
 =?us-ascii?Q?9mrtE+CKggm3W/MtTuD5g/TNW41RVabK1KN9dWUzRwxJhtx+s7Jw/tCBdvwS?=
 =?us-ascii?Q?aCzgjBUfK1mgrQ5p42rQiVFxLUOsUqWzBzhR4udxC9fA4g5/JoDjhMgusiWd?=
 =?us-ascii?Q?Lcq+MIoeag8FuXTrFljRf9DaH/A75rM5/j4hloxqmX8ZQ98ubg8qIYe9VM2e?=
 =?us-ascii?Q?yXJms7s3TZ0Bk6LntUWZin4wEwbTEw7HgmR8b4YTStWdrYAENCTCXAEJ9m2X?=
 =?us-ascii?Q?OQJ1UfUaO3qdir0DL0jKBzDzXDMVJoHUPPx57ktFbysB2mGcjzAa9nccQwRp?=
 =?us-ascii?Q?/5+PRwGe/X86UNIzEu9DXQ3VmyeDg8rBW1GWrq4DBwRFQbVcx31Tj0N3IOtN?=
 =?us-ascii?Q?O92/zzgkQJsCugIoWrkO89cZmurfD9Q+KGHe8QO9w6i2P+uFuWhmLFJnJ9Tl?=
 =?us-ascii?Q?t92nsH47wFNZWVFyyY97RVW05atP0EG1IjVrWONSNMXKmRW1vu0hd31OGUVV?=
 =?us-ascii?Q?zAeX5J2e91Nhj25eCcCs861O4ugwWlE54MwMQlnFSXEwxnz7J8cRZ2gx9SnO?=
 =?us-ascii?Q?wD6RjBI7BxlNss3jy9h6M+/Sgj8pNu8jyiiMW+T/oyOSVAeH0LZpmaXQ9KM1?=
 =?us-ascii?Q?fgV7u00i78jVfnXi07NqH8N+8W/BI/3kFQ7vFJlV1LaLkEOWn3bOIZqt4ms3?=
 =?us-ascii?Q?vLJnNyqhRZ7l3tsrMEH4YFvP5aSERX3FZOzemil5bks8rA2kyd+pTHlt+IR0?=
 =?us-ascii?Q?dTDIBNsDoTBlJw4tZ9UOpPCfFGpcXIGT1A9IH+qTbVuL3Gr9wvxGuPstR3QN?=
 =?us-ascii?Q?+cUyJPBcWxf6T8FLt84ZMS5kDXNOcdHH6CiPmtavebO3h9m1fuxPbi8ofIux?=
 =?us-ascii?Q?yVKX2E3WilEwJhGdVG9zmKD9spmJPwQP3jBsSJ4s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6a013b-8972-4e2a-005c-08dcb7b2e028
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:03:27.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdNTK2pc8TacuoVMbm0zM/zjhZeqcXKdBqA7TJkterZJArOq7F/GTS2Pq4J5kI91zQSoDQfk37m2N1RjsmlB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9426

On Thu, Aug 08, 2024 at 12:35:01AM +0200, Niklas Cassel wrote:
> On Fri, Aug 02, 2024 at 02:30:45AM +0000, Hongxing Zhu wrote:
> > >
> > > Does this solve your problem:
> > > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > > index 581704e61f28..fc86e2c8c42b 100644
> > > --- a/drivers/ata/libahci_platform.c
> > > +++ b/drivers/ata/libahci_platform.c
> > > @@ -747,12 +747,11 @@ int ahci_platform_init_host(struct platform_device
> > > *pdev,
> > >                         ap->ops = &ata_dummy_port_ops;
> > >         }
> > >
> > > -       if (hpriv->cap & HOST_CAP_64) {
> > > -               rc = dma_coerce_mask_and_coherent(dev,
> > > DMA_BIT_MASK(64));
> > > -               if (rc) {
> > > -                       dev_err(dev, "Failed to enable 64-bit DMA.\n");
> > > -                       return rc;
> > > -               }
> > > +       rc = dma_coerce_mask_and_coherent(dev,
> > > +                       DMA_BIT_MASK((hpriv->cap & HOST_CAP_64) ? 64 :
> > > 32));
> > > +       if (rc) {
> > > +               dev_err(dev, "DMA enable failed\n");
> > > +               return rc;
> > >         }
> > >
> > >         rc = ahci_reset_controller(host);
> > >
> > Hi Niklas:
> > I'm so sorry to reply late.
> > About the 32bit DMA limitation of i.MX8QM AHCI SATA.
> > It's seems that one "dma-ranges" property in the DT can let i.MX8QM SATA
> >  works fine in my past days tests without this commit.
> > How about drop these driver changes, and add "dma-ranges" for i.MX8QM SATA?
> > Thanks a lot for your kindly help.
>
> Hello Richard,
>
> did you try my suggested patch above?
>
>
> If you look at dma-ranges:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#dma-ranges
>
> "dma-ranges" property should be used on a bus device node
> (such as PCI host bridges).

Yes, 32bit is limited by internal bus farbic, not AHCI controller.

It look like
hsio-bus
{
	dma-ranges = <low 4G space>
	sata@addr
	{
		...
	}
}

This should be correct reflect hardware behavior.  force ahci to 32bit dma
mask should be a wordaround.

Frank

>
> It does not seem correct to add this property (describing the DMA limit
> of the AHCI controller, a PCI endpoint) on the PCI host bridge/controller.
>
> This property belongs to the AHCI controller, not the upstream PCI
> host bridge/controller.
>
> AHCI has a specific register to describe if the hardware can support
> 64-bit DMA addresses or not, so if my suggested patch works for you,
> it seems like a more elegant solution (which also avoids having to
> abuse device tree properties).
>
>
> Kind regards,
> Niklas

