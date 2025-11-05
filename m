Return-Path: <stable+bounces-192528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199EC36DA0
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3084F4062
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E91337B96;
	Wed,  5 Nov 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fC7ug+Nz"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055132936B;
	Wed,  5 Nov 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361613; cv=fail; b=nEEpWrQo2pCQ2PjqOVRLKBh+4ujC09Hd799ijL/ijyfsD40v7Os4VXNqwuPqSLUgvrrnM/H6+XHISOX+2KHyfazTFu1JydSVsaevD7DgwqhCeg2jT5x5XKdw2294hxszbhnhmmxwUTRQW/O3RWs45TzOcWV+OuxyCUWZrTouRvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361613; c=relaxed/simple;
	bh=mdw0cJFMSkkUgqCL/XNtTpkBOHcG6kvVGV1+EdxNICE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XsBcKJSUn8zrSlSTP95KvWedYLBo8Nb9fl6/qVRVWFeBGpR3RejNzUo/GjZUGuAWSD3GYNMwPB91DM+yAZsZ9ymyMW2QWnkLoBX1M6RmrJgTRx1jcG5aKKek8CTBskm7IV0nqinBkByKOMbug3/bJ56DErm3vfkeH8RspaIgsvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fC7ug+Nz; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFizffKFI6hsHwzezwZmOaRyvFhRs9qJNs4ss7TGj6bqmwqB2syqK1WKmBYrK7fWljg7a5sXEYikowNEsJNGoqG4Xc7CUEgewJ3EWCgW52IAH7nS+XmZDXf7ES2azHy/zG5HH3WyHG+v2dzij80AfNqDnzcw1/gDewq1jIU75o6S/tX2OHMRW0+j+K41FNCrg/q9Q6XfSlE2y/IL/01Ewtdmteg5JXvz8pKgEMyfcUBSiexcZLcI4lxZuWzkj96ysD88qDtumBwLsatNaS8os1rAOTdrQQ9QK4ldY1DmDzBZpNtnrM6MB+JEX8Umglb1KtN48435/cHLwYzElLmr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq3vbpW/kRSUmv1WEJxGwDLxw/jYLVEuneyC24Vc9AQ=;
 b=feSR1wkuOLC/n1tPt2LurWqH7/QQk/8wnMT3VG2oVn7PXR07wbmVI7fa3ZSSDvZkmq9YCDavklZYyHb7BogIO/zEZZH1fH71xttQgk6vpuO2gY3cx+qig2ieeQj6wkXCY/jVF0vf2XPJoR0H9e1C1gfUuYQ6pMiJVULp136noVIOja7ZoDWLJcXHLDe1O9AlImyP0nx7PG3I/3LaGCbPNuOzVlDMuMUX7vT+54IOLem9Z1gVsNPSStWUj/Ru4xG69nqfl+cSP7RsDuMlOuKfB3l9KxcUrDf0cpXGYI8ZTiiwMjFfZbeni6vY3gid6QL124fBVITrrGJXwgSMFFBmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq3vbpW/kRSUmv1WEJxGwDLxw/jYLVEuneyC24Vc9AQ=;
 b=fC7ug+NzTBrnIUN24kbc++5ZqnFCZCmlUuymstWCWzrkNZIm86cvYlXhRF8W1HD7QkvI/omZGVZaoW58lVSBMwWCeR0eLMba3xuZDWsVcMZaDrZy0jYbjmI0uCxl22du10TRlqTrOucO4aFd6+xrjKBFzt/oel6vy85DTcfFxTNumNzcxr8MqHErBTT0URGyhbxA7/ycrUomSUhlIIFpzPPi4+3AVsvUDHezE091JiKJdOjX7SZlxGFqQVFRFs2XJwmFrJfdXSaE3nQiQK9Bc1ToG3Q6Jv5KPCpWIZY2Npij9pHSr2TQs693+NhQRjAyfhkRqh0GOAKLaB3giqQ1RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:53:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:53:28 +0000
Date: Wed, 5 Nov 2025 11:53:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Michael Tretter <michael.tretter@pengutronix.de>
Subject: Re: [PATCH 2/2] media: staging: imx: configure src_mux in csi_start
Message-ID: <aQuBAmJkm1MvOUfr@lizhi-Precision-Tower-5810>
References: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
 <20251105-media-imx-fixes-v1-2-99e48b4f5cbc@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-media-imx-fixes-v1-2-99e48b4f5cbc@pengutronix.de>
X-ClientProxiedBy: SA9PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:806:27::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cae6f1b-8ee5-4825-260f-08de1c8bd80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8qcgUCHSf9UuYAY4/pjFiRiHnGkmT7b1w2OBQeEPQuYnXKrY0ZUlr5iEOjfG?=
 =?us-ascii?Q?07Ev9xmI6/NndP9iZOB4Z5L3jDZ2HRJ9uD9ENPUo1+N817iVftXtglETC3Om?=
 =?us-ascii?Q?8SGU7ZdZqsTz6wmN0qg+e9r/0sJk0r4pn4nOj64+p3RctFpnfjAFnpNGEXrQ?=
 =?us-ascii?Q?2NP8YJSwld3BbsLqXStnhcoCfNuEBpj+s3NMvtTG7J2wrjtlMEYO9JtZb9ef?=
 =?us-ascii?Q?rCRqqco/flVQx5SDkCUui/2ELyf5DUwpOuZRyxWHUSQ9HCt1IYWZB9uuDrji?=
 =?us-ascii?Q?ixHEHcQtuesTls90oPI0uW8tO5WnS4JqXzD2QWAf+Zl1iMLyxtJAJP1KDckU?=
 =?us-ascii?Q?NmD7LNX23TbqLZXKxQOTBJaYfdEKcLxa2+3lDD+5205rfRZYnngh7NxPchhG?=
 =?us-ascii?Q?5qGthLkLOyETzHawOPHVgGeK7rTBTPmbtVD5taVUQFu/WFWTEf1AvinIES0z?=
 =?us-ascii?Q?vCOQancQLKgLftaXh7ZTWvODGqtl9upA2DHG4nWwIIu6XI9wEJ5TNXqAGXlM?=
 =?us-ascii?Q?WNXlTxxGr9i4UC9A5rg/CzohlBcMuIrvI16tY0Rz3IcZ5j0y5HLOb4loar0n?=
 =?us-ascii?Q?iWYAEDbT3qfkBmVdFKuHpY2sUTKmhhDNdIl/yNwFmRzXEif6NistwFBL7pnr?=
 =?us-ascii?Q?68rHxf4l1y6a8afkZkVCD/GSnYSfOpmGrgy4vIVBhgjt/49W+q5PrzaGiYQ0?=
 =?us-ascii?Q?9/OBP8RrN7SFZlJV+EXI3fmWXPClmjeKop8xEFs7LuMBC1El7/xo3zPB4WvU?=
 =?us-ascii?Q?3w/qBUOKmHaQwWv8DMjf5t9XMG9VcO36VoaSL+RmL24KlXshxEUZyJPe7IEm?=
 =?us-ascii?Q?UPY3WcwoB00+3URDAzBKVpd78hxuXExm5D4tYeOGPRDc9IGSAsjldEXcaiqv?=
 =?us-ascii?Q?u5c2LYqgTzCVH3t7edzWyksnZ5SkJOxSbNRcQq/+/ggGQcQGMc9a12+/wyYi?=
 =?us-ascii?Q?n8RbQ5e6rS0N+NdkslAG6aI6aqnu2moy0OrPVqPRUKoPoZOh0VJ5llos2qKd?=
 =?us-ascii?Q?7U2I54PhON+30biMsPT6PdJC2IEoqZTq8dbF5haTBH3tzSiQ7wN3Hao0t+Rv?=
 =?us-ascii?Q?sXfr3qUPKDT0iELWgz3jlE2mpohqYpcGFktSaMZV6i47JPaQhM7cQrjwDdct?=
 =?us-ascii?Q?ETzB+hLLzuajKR9Z+VQagamFWvz333zuBrJj6oioIRKh1HvcNYsa2mSMGXNB?=
 =?us-ascii?Q?G4mn5dMq2ehufYyw75rF3B2aFfJp9kKF2fRHvLXKuAHvSs2cyNDSPPs6Va/l?=
 =?us-ascii?Q?WU9ZVGuEM6PZ5aVMCPAFIrIsOlUxdmF+T+ytBCog9+WJ4rqmRGPEdMKqytHN?=
 =?us-ascii?Q?omWaLUXZRtc6VCV4l3A0LWg9aJrrViJBZm1hiDIWGh0++TNNFWE4kyeiJbHX?=
 =?us-ascii?Q?tiQKjWZpfLuNqsyYbNoCeCI+Ist9yir0XmKuYff1YHg3ZpGPX0aIc+p/WwCl?=
 =?us-ascii?Q?ci4rxbzqn4gvqqzBkDBCyJ3wBg7osJg6vjujUebWZpGfnbqtrK2B8icb9pPy?=
 =?us-ascii?Q?/NzHLa+AKdRL+r7xr1iPeIcYm0xzIkLK0Lqw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B4b+Ig/lTGx0Oo+PPQrWCvFxfDLcwvybT8nus0OFx/1RLbBlgkCHYpp/BLzE?=
 =?us-ascii?Q?Cvu5k9v+kag0SlDZGOV81z3Odn0B0o48FLZrH5vXpNlkr3R9pPWZ/gM/UHiI?=
 =?us-ascii?Q?/73FqDcvj22MMWu0N4nO2625GLpN2eg1hkA2a2Ipch1MHoAPKDyrsrBNQRSJ?=
 =?us-ascii?Q?lbGPnczObaevBKj7hVDnHyD6ua+lmMN576HK+1AYHOX74rAwezmo3BBG6F29?=
 =?us-ascii?Q?f3qn37g2XQZwlcEekGamQAsrRAIydmi0089pqDBlo4MxQ04HOAC8boDq88XI?=
 =?us-ascii?Q?dC4jg7l6JjNIRj4bN7JVvv5lkSjUoXkWkfaTInVfgDHeux28VEWw8g/q27lA?=
 =?us-ascii?Q?uZlJfQJk2+pNtqkMgDSiJGowiZM35rTr6VEO0aA/C2h4wWs5Lg6OUfoJ9MBD?=
 =?us-ascii?Q?fLs/GV+/PLOO/uTUoXWG1cjIqv3QCC+M8r0Ws51o3qw/wRBStNGPMOpMF00e?=
 =?us-ascii?Q?wFDabfhn2dw0HSAhtdfAlhHuLjhS3Bys8hQYgiBGpMCAAEC9P06yCvJooYPA?=
 =?us-ascii?Q?pmuFWuBZ5VNV3bW/F5lSJTHYyApvtYkdwi2AdA/3wKiD/mLYSjJLrPIpntRg?=
 =?us-ascii?Q?VWEUIreFq+cGi0ezshzOeKVXGCPZjHpIzNmXCwKziCjya29Bewb+w9xFq1T0?=
 =?us-ascii?Q?h+iQ1DdTZADrxoJsbR24voGKo8r18xPHlYmki6Z40Ci43yzTZuoWaM5aHtn+?=
 =?us-ascii?Q?YxLTw1Q+ayoRrhR7mFyDkFGMxhqjVpQqhaW3heB5U+vDAncMGfm/vTzODUFT?=
 =?us-ascii?Q?B4pBAkKRmkaZWNy34Xhmr7YDPV0kEVk2AElrK8vcegu2hZmNZ/3TCSYH/FLB?=
 =?us-ascii?Q?50NxKzkI3a3rexozA1e5K6Cc9E1gURxL90GLjs4/86PaPqhVJ1s1VxlWGu0+?=
 =?us-ascii?Q?dLBu/d346ej0UMyYQBggbfriDjjo//GeKOIKcTxiXsl0WwxENwv8azABtwP8?=
 =?us-ascii?Q?I1A8K55riFJTEaPFeEmV/Zwpoictq6vkXsyjGrfvuThki1aJnf/vDIwIT1Tk?=
 =?us-ascii?Q?hQJbrkpHYPMsA5tTlcxAMM6EHYC2OM70XplS0PON9u5Pid0Pm78/WJ1j9LNw?=
 =?us-ascii?Q?jFz/nV4Imw4F+uUbCCsVOQPirb9oxNAW7neNzm1kPZg9kdAScUr5vAZDQvC3?=
 =?us-ascii?Q?meVJkIyvb/Hx7txqSYESD44wcmABNiJgammu1eR8b/NuMiwdF4uiR8BZv7Lw?=
 =?us-ascii?Q?HCgxfNJL5V0uma+Er+45Z3dDXDTSAUQH6kdaeUaDqmmxCzZp828y+DybCV+c?=
 =?us-ascii?Q?Kg7kitdFa85eMFIuEyT+GGb8v28OuBW+Rxv2hHDCi2mqREic/KpxMKzcdNW/?=
 =?us-ascii?Q?CwPy/D9Y3GMZIB7DXyc7lhK7IxFBUvQTakvz+fmCoVKDO5BB29c5m5AwwQaB?=
 =?us-ascii?Q?C5xskIc3sliLUQ8VKiNQq2bxy0jDAZtDySL9ShsGcPd9bBn/7V/MshV647zj?=
 =?us-ascii?Q?+1/s5ZHR0T7tf0OaRgDYAsIetfgEM9XpncXJMA7v+osfTtWqZoKok4xa/djD?=
 =?us-ascii?Q?Yg2aU0kd893A384+X3p0GsCfTspKTl+eyg6dUPtPzvjA9tU/tacvhnl7D75Z?=
 =?us-ascii?Q?BchtA533E6NOgAvscfOVbnygmEOQIVpfx1z6ud1M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cae6f1b-8ee5-4825-260f-08de1c8bd80b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:53:28.6082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPy8tYBsu0Id4pe+fKQepDGPtjYoE8NgAyDO1Bz8gVFyhUDjXRApbaREqvPeJxtaZEbScrlkZD9I1b5PFdTsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

On Wed, Nov 05, 2025 at 04:18:50PM +0100, Michael Tretter wrote:
> After media_pipeline_start() was called, the media graph is assumed to
> be validated. It won't be validated again if a second stream starts.
>
> The imx-media-csi driver, however, changes hardware configuration in the
> link_validate() callback. This can result in started streams with
> misconfigured hardware.
>
> In the concrete example, the ipu2_csi1_mux is driven by a parallel video
> input. After the media pipeline has been started with this
> configuration, a second stream is configured to use ipu1_csi0 with
> MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
> of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
> already running, link_validate won't be called, and the ipu1_csi0 won't
> be reconfigured. The resulting video is broken, because the
> ipu1_csi0_mux is misconfigured, but no error is reported.
>
> Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
> that input to ipu1_csi0 is configured correctly when starting the
> stream. This is a local reconfiguration in ipu1_csi0 and is possible
> while the media pipeline is running.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 44 +++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
...
>
>  	ret = v4l2_subdev_link_validate_default(sd, link,
> @@ -1145,25 +1168,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
>  		return ret;
>  	}
>
> -	mutex_lock(&priv->lock);

Is it safe to remove lock? I think put justification in commit message
about removing lock.

Frank
> -
> -	is_csi2 = !is_parallel_bus(&mbus_cfg);
> -	if (is_csi2) {
> -		/*
> -		 * NOTE! It seems the virtual channels from the mipi csi-2
> -		 * receiver are used only for routing by the video mux's,
> -		 * or for hard-wired routing to the CSI's. Once the stream
> -		 * enters the CSI's however, they are treated internally
> -		 * in the IPU as virtual channel 0.
> -		 */
> -		ipu_csi_set_mipi_datatype(priv->csi, 0,
> -					  &priv->format_mbus[CSI_SINK_PAD]);
> -	}
> -
> -	/* select either parallel or MIPI-CSI2 as input to CSI */
> -	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
> -
> -	mutex_unlock(&priv->lock);
>  	return ret;
>  }
>
>
> --
> 2.47.3
>

