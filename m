Return-Path: <stable+bounces-208063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4263D11A1E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFBD30B65F3
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1C274FC2;
	Mon, 12 Jan 2026 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KupNed69"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25702741AB;
	Mon, 12 Jan 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211439; cv=fail; b=rV47wbOPPaz5c8c4tk8MFUo9OXbu+BaAAGu1/mpO3k76H09VPamp0+SgmW0COAkYv5eKcsIWwCn0UsqEUk00T8tGHOJm2oYE1j1gP/0qiLp+3KaS/Lpib+DZLJ1m0KFS83cM9EAp3CIsVtv8wLdOqbFS43i+GmJ8ZeWc5ap9J8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211439; c=relaxed/simple;
	bh=emYBZLYyv8LyVdheGZGCCbBx/Os5WRMDvo7yMtfBZjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BsAnvgW5iTF4omTeyunG9CnF4NRVz1/v75kYaEtryOOBmH91cX+ZIx66aMlca3e+rceCQyL+xQZoeNCaPM7ESXgcc1jIWZF1NeAmu9rVo7tQytTltxAOiKVyP4WCABOlqg4oKR46g1cszpnObL5RKjYyxDzZAQi4SO01e3zg0Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KupNed69; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQTZLUeJb/QdF/JqCt766sWOjyK5M0gB2NTk7tU6qtQifRglRzBV5jqwhIYZqhYPf/Vx9nnI4+1p2VDkcCxiPJXuSOkmn1MgUYq3NQ8DYPXyedH5eAloDxEeCjVtY7TuTJxFPGe03lCk8MnwiJ2rMjt3zocqS/KIE/vcOjENc+5z3wyK87TmVkhb4kLtjmEZHU18GlSEJi8AFv3cMf1+765yIXNMyIV/1nczpryyrS1DW/GktEaxV7Ajf847DLtaA9eUmcj6Mm2lXrowHA9msHHBpEQ0YMQGT6lrlEbZc8QJkgXmB8ylFx1iHsQUDb/IsAj8KVPiDKrTA801Jtctfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyMsddVsxUm6i5V1Ha3OBm1LcUpneGww0D9h649Ep6Q=;
 b=gnZ23O+5c9tEYldVWLfM25NpXAmaO2zEs+oBOfCSPMHJ0klWYjoXj3GZLjyfajUm5CZJKKpuYpE/UIU9MMHlc7inT0HzbXKM7d23U7YOKOJtpVsi3LYKQIG+L/KDkbE1sNaPq8NOPl+PA+IZpRD1SRFJEJVXEkReKcE8qcP0oEuHi3/31ALoOjSOPoyVsMg1U8GAPbREbOx4606WWwQx+m+d53x8FcylmDHe1y+NQEmaB0J+JiktFrjtr1SbVSIZOueSykpMiiaK19zAw2K0JF82xkDOqkLUWNpiFP4IFAUAGMPP7ngFTPUIpb8AJSo1PduGbRcj/iL5DSY4KGYJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyMsddVsxUm6i5V1Ha3OBm1LcUpneGww0D9h649Ep6Q=;
 b=KupNed69cwxW96poUJ43DE+kp/pOcyYszF1XgJM3RjlMfI0TohVci0/Codk/9vEmc/QlNaZ+Ez6RWoqzZJFlZCngeT3mntp2N7NAMvG9ubnOvEApGhokQwNfc5qgWGPNVBE9/bBU7nxZJKVct04i7v/uMuFyXv7X4lhlCM7Cu5T5grlWX5VdCRsyj3BwR0eAq21v5vHyIe0kZG91lj3BEL1Qh8S1ROqIAc6mpzoTH/o79mJjfHrGCr0lg5gzbjLkFz8vzWls223ICNZPDYP3PxbGZ3ll6W8D9zLVE8sexpJx+InPDCOCHolATsHydTR9fGH+JkcM+BZEqwwJVcctzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB11557.eurprd04.prod.outlook.com (2603:10a6:10:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:50:35 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 09:50:35 +0000
Date: Mon, 12 Jan 2026 17:43:21 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: gadget: uvc: fix interval_duration calculation
Message-ID: <3j36yvlolepk7ififzknknsdqr2gjueuqh4exlqidsiqrs6d7h@nbix74eojlyb>
References: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
 <20260108-uvc-gadget-fix-patch-v1-2-8b571e5033cc@nxp.com>
 <aV/Vg4BBAa+kl+0k@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV/Vg4BBAa+kl+0k@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB11557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8561cfe9-9715-44a8-900a-08de51c0087b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yV8WU3MG82v6cPPlZzN7lv3tY6hz/n6ovH2wLFM2LQLGPywc2YajZj0H2Wtb?=
 =?us-ascii?Q?IFqMzOZ0FtJ7i+Osgu0PHlhAQeOjcDoJ/QSIdw5xLdDTbxDGZwjvHS+ZTc9Z?=
 =?us-ascii?Q?8uFeiyHtTByDKKta8U6lLEXSzyDTruCITLcHEXG842wz66hW/JyJeAQrAwS7?=
 =?us-ascii?Q?xItT0C9i3KrSHUjat0zNzDriX/kHtq+lSw/J+WVfRaGvGy6QjQJ0Ttwk0uD8?=
 =?us-ascii?Q?+JklLZfRBzrT0MBhFSRoVkU5UkM5Pr5Fvm+yb8UN4tVBhyoXkRr+ci9BepZG?=
 =?us-ascii?Q?P6TiPBsBj2xfwAAK5ANOTM2MIp9TDO2ETGpHyM4oU52lhe6uOM1+KnOOpMOz?=
 =?us-ascii?Q?E2n32uKhrAdTOjeprPwuKW+CpWc6uglTIdwgZOje17eXHFqOM8puqsmdtY93?=
 =?us-ascii?Q?bb2Un3ORqVp6683Q2xMJkBTqWK8YjtaGuX2VpCWETokPuLwk6uvDbfTg0cuc?=
 =?us-ascii?Q?gzao+1lF2uFg7M5d1kmDUnJu4XpR9FZWK4B1bvnq0FTAXJDU+/SJM4zyzs8m?=
 =?us-ascii?Q?XpFPLnMnMl6ZAHCGfvyhNHemJqvHR3/6KSC0h4cO/osdCi7znt9YW3BOk4Zr?=
 =?us-ascii?Q?608CO8rwZWZDLEbA2IE7ZpcjxEdjdZ1bu+87LFMD2DDCaun4dlt3pC9uO6Er?=
 =?us-ascii?Q?RXZkZ3BnK64Mq28QRrUBB07Jjx3wHsv48uxihAoifmrinEYf3OVkUKZqYthD?=
 =?us-ascii?Q?BkpZuyE5PIcyWCfAJMElAiWh19rOLe/fvAH1g/SQExJlJ5fm+0F/uRh/fdsu?=
 =?us-ascii?Q?P1kJKOYvwGW7/mWIOeUbg5/JA5BSp2DlpPLBoLjY71HxKAaZIxKlriFhknSr?=
 =?us-ascii?Q?YAy2YVst+/DoH3vrhhncwsLoFe3qug5pcR+MtNm0FpwotaDMoLgsekqEPchz?=
 =?us-ascii?Q?UBVqVTs1jVY322zmGpdQ+sXeq2KalUM/pTvM78ssydtlXUNMPPv38rDW7RtM?=
 =?us-ascii?Q?fW+WgpqNCZ1LJP0T+Z1+BHCF3cYMBKk22+avFN+YjoSsv5BGqdfun2tGHEBw?=
 =?us-ascii?Q?I9haiBFMqtz5xyKVTfiHVrsRpHj7n40hNkV+ryxS7I7nw1f4LvQ7+WssBlLL?=
 =?us-ascii?Q?Ze3lBxkbrnj7+q5haN+LW39qB5vxpULQyaGrFtCdTFlbzPV/Tt62wuJHqemI?=
 =?us-ascii?Q?CqxHxLqXKPt469Tl3UyRW6CtBH/CRwQD++fn+NoucP0Mm85gIYKcetIKNBJL?=
 =?us-ascii?Q?82X1ysjjgaR7co1u5vc4fyTUhebjq5nCNsO6ign3MbbpHtF0pMGhSV84OhX1?=
 =?us-ascii?Q?exFMBSOhPdQDskbDiIpci7OnZJ+1Xjl9kyfuvEr/HeB5QQmB/GOOYhs573Vn?=
 =?us-ascii?Q?4vOFWmL8ISiOyGnAY114mStIPv5lC3KXw4vWCMFPWTQWjMs3zmrxgbC9QBfv?=
 =?us-ascii?Q?pPAhSD/LI4QwuyOB3hDGVg3DMG4olkX0wxiIpl4okaQft1nv4WgiUygOHVix?=
 =?us-ascii?Q?jfb7cGXqoEmCvHFw+qULFSVv3W6unpnGyEDpleeAKWKhOi9hlZxUerGO53hE?=
 =?us-ascii?Q?YRCCxbacznLxyYC4pAeE3AOKPnOpHZhwpw5S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8Tazalt4hki2ZbLgKD6sjRNOC38mtnAi8DlFxIgwcbAf+dEJNYCGHQV+Xs7?=
 =?us-ascii?Q?+boIPhLVtflarR5Js4aqxR+4noOTBmbzfqmZU4ekVUOP9qGTz8nojXTWlkvB?=
 =?us-ascii?Q?rbHnTovA0Xq/SCdUDcR364/gO/vwBxj7G2Ta8izfAC3DVzuwu+RMviW1Dbe6?=
 =?us-ascii?Q?YHW3jd9TlVUyO555Oa/Wf/ejJwd6sOvDSmQoafSltQh+n1AMYnB+IXrRz/yA?=
 =?us-ascii?Q?nDvLIQigDXG624/Tn6i0uDar58L9r+4ee+C7wPEwZqYWdh3fxbBzxLfBafl5?=
 =?us-ascii?Q?9H6nFq4V5cbv0ns2eMQwoyDRjpFmQxO8dcXG2LQW7+52pQCvsUmX+mo5zx9F?=
 =?us-ascii?Q?vKnB9C/iqEKT/w+Zaoe/BYu09b25uhjEnALOCAKZwkK4momprvE7hHBHTnXW?=
 =?us-ascii?Q?DdHR4+KdxKJepR9797750lTgo512U/R7DEyJVA9/FtzRYLDhe0RGiVMWdDl2?=
 =?us-ascii?Q?MUY9LXWm0nwyOF6ZXBroP/fgUlERu5CJNSZ9pX6ddFl96pjIl/cL36PWCIhZ?=
 =?us-ascii?Q?ARGHuUCQQZzDbk4OLoXs++U8oRZrB7RCBYqJGaojVB4tcgZnGWiUJx+lH6VB?=
 =?us-ascii?Q?rUUj4VgMdLpvYuPwTRcMFY4S2QfDMDZmYopVyYJ7NxXR+HSDdsZVigd0zvCo?=
 =?us-ascii?Q?IOtUhUa1hfp40MdQrZRHAZh12FDHFM60PJGXRckZO0LVUPiGjT/YmkD6nM3N?=
 =?us-ascii?Q?gKxvih3ZCjFEZaBNK9bI8MLcWFTSnQvCFaqZ6yN+27QNGIGGAErdO3FAYkqQ?=
 =?us-ascii?Q?TtfgX6h+newN+djj+cenR1urbmsx9tEMetvx69JO5kY/1/GK2B0iphSz8YwR?=
 =?us-ascii?Q?KvJZduXVSdQvyWBhWnx6M8lyWP6PxfvyF/kBoDNdP7YJI1rGcN2x/7RHv9lm?=
 =?us-ascii?Q?dFZO98GetMp7rzo83v90KeRrMskT/EIKOiTZuwWaq6VlJDiYTs5S8AMSv1CU?=
 =?us-ascii?Q?oUgrxQP2tmfES36Y4aAJzX9AFNCbWZy05sJBPWbd8KgUEOC0iXDt4gn4Dwga?=
 =?us-ascii?Q?2ypmu9YPH+L90dh60Rsowivs3FIoehN1LdySKh1ZEDdR0JjcE5M0yEzvXXYD?=
 =?us-ascii?Q?TuzYR2WhYguHt4x2lHeMG9d91YZHC4o60BufF97wz7ENDio+KfZHsVFYoAkp?=
 =?us-ascii?Q?TTfpowrB6VrwYxRVt116fyuEhyhS+8Fd7DVnwZvCRtkaY7YxlyeY2cUoW7Gj?=
 =?us-ascii?Q?0irU2q3c9KAPaQ3Lu3ekFhje6L03Ra9Bug5GxoYiDOI53skCsBoJQP86ddYt?=
 =?us-ascii?Q?x+827kML7DGDDC/N0s7ql+hcPfTaSn07ooCKJIHut1YYA6+LxXGPwaRY9zeZ?=
 =?us-ascii?Q?wd988ElBlgxT1YM9v8+HW7kia1/D2wfxItnYG5B0rezp1s9li+VSfVYUkenq?=
 =?us-ascii?Q?GTGERHf/yXZfJ/I9Xa+vkpYFY5QPiZIvIzn1Lzotq+RxUdiQ+dXJkPGv1rea?=
 =?us-ascii?Q?4X5Ue11iyxDOOHSACCDYs96aLLKZAY9m5IIiZG9NRwEm7WL9WAxjlQZghIQ7?=
 =?us-ascii?Q?4WEmowuLBvhyUdODXYf/0qerheiw+nXnC1qA6KpX7g892J4/0PYwaMaevSUx?=
 =?us-ascii?Q?OCIo8/OuHlFQFE8Hc81XzDw7fgHeB+dCvvyETPgI5cJsejOu9zfugIlA+goV?=
 =?us-ascii?Q?3peq7hagYqXGUlGs1t3nAb1E8fPklrAf9Eo9oZWtIka2o65VhX4NfvVlswn3?=
 =?us-ascii?Q?RL19JouqG9AFvMzTS2Kr9ygoEySiHVeUWfM17a5sZ7FBdQQe3DHXQ9H/PNU9?=
 =?us-ascii?Q?vZZaGv0uLQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8561cfe9-9715-44a8-900a-08de51c0087b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:50:35.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpgI/w4PhIldHVMiM+2dWhWzZmDyEoLkwrEoauYFzKk0Uj7L/QDrjLRoym2L/z+cSW3RRYMN9RcHF8fZcmxaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11557

On Thu, Jan 08, 2026 at 11:04:19AM -0500, Frank Li wrote:
> On Thu, Jan 08, 2026 at 03:43:03PM +0800, Xu Yang wrote:
> > According to USB specification:
> >
> >   For full-/high-speed isochronous endpoints, the bInterval value is
> >   used as the exponent for a 2^(bInterval-1) value.
> >
> > To correctly convert bInterval as interval_duration:
> >   interval_duration = 2^(bInterval-1) * frame_interval
> >
> > Because the unit of video->interval is 100ns, add a comment info to
> > make it clear.
> >
> > Fixes: 48dbe731171e ("usb: gadget: uvc: set req_size and n_requests based on the frame interval")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/usb/gadget/function/uvc.h       | 2 +-
> >  drivers/usb/gadget/function/uvc_video.c | 7 +++++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> > index b3f88670bff801a43d084646974602e5995bb192..676419a049762f9eb59e1ac68b19fa34f153b793 100644
> > --- a/drivers/usb/gadget/function/uvc.h
> > +++ b/drivers/usb/gadget/function/uvc.h
> > @@ -107,7 +107,7 @@ struct uvc_video {
> >  	unsigned int width;
> >  	unsigned int height;
> >  	unsigned int imagesize;
> > -	unsigned int interval;
> > +	unsigned int interval;	/* in 100ns units */
> >  	struct mutex mutex;	/* protects frame parameters */
> >
> >  	unsigned int uvc_num_requests;
> > diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> > index 1c0672f707e4e5f29c937a1868f0400aad62e5cb..b1c5c1d3e9390c82cc84e736a7f288626ee69d51 100644
> > --- a/drivers/usb/gadget/function/uvc_video.c
> > +++ b/drivers/usb/gadget/function/uvc_video.c
> > @@ -499,7 +499,7 @@ uvc_video_prep_requests(struct uvc_video *video)
> >  {
> >  	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
> >  	struct usb_composite_dev *cdev = uvc->func.config->cdev;
> > -	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
> > +	unsigned int interval_duration;
> >  	unsigned int max_req_size, req_size, header_size;
> >  	unsigned int nreq;
> >
> > @@ -513,8 +513,11 @@ uvc_video_prep_requests(struct uvc_video *video)
> >  		return;
> >  	}
> >
> > +	interval_duration = int_pow(2, video->ep->desc->bInterval - 1);
> 
> 2 << (video->ep->desc->bInterval - 1) or BIT(video->ep->desc->bInterval - 1);
> 
> int_pow() use while loop. slice better.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Good suggestion!

Thanks,
Xu Yang

