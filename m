Return-Path: <stable+bounces-40554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E68ADD40
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 07:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C23B2290E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071E2135A;
	Tue, 23 Apr 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/q+1J/E"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4D63C8;
	Tue, 23 Apr 2024 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851719; cv=fail; b=dcUdwP5GoQOwoFHkzn7QB85t5Ge6Uf3FTt8mAuxdl9F05V6U9Tf9vR5xFGZ5U6Cb7crpTpiXms861aGYbZixGs5cTTmklaAqf3WFmGPmEfqkTUKUnXUIfSmUb0qyTz//V9A5ut6sAn0p+0FVIkdbb8aGy12xUDu35EqU8/zdpes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851719; c=relaxed/simple;
	bh=gNo1rv13yQGdq+V2OSx6me1Lv9UHdY43T+0xbgUXH5w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ohxLCq4cTVHRh/g+avKolbGL+5l8MDW8QEoJ7MXDL2Lyu5ldGyMm7jR6nEbBFlI9auq3kHVitJ36oe99lLfjwujxWmAXuhfYrGPqjpI7mneKuXaBz4vKxJ3KeOs5OmsSkCBDVVYEjla4aRypEwfnmW5dJEzYvOYwewA7uSUptks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/q+1J/E; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCofgsDLbef4EPWy2Eu3qQcMtdBTmPvzKCESCLJyI0XwDtEVC8tSTjt4T/TJHMw9B0SeiBfb72gAkPAaQcMEqd9qdcWUIRX2unkRKgoUM0p+xm/c9QTUHawJpqqJ6g/oBNUynbdx4Ve5TiwmBjO5RAVLPNVATRStalThWw7HMVNTZISMWsCPobU/jpWbJEdcgEfWc9iEAThEhxb1j4Iakvdx0bfnqjd3afxyTU6Ahr7cuDupBtv5PJl5a6HVAm2Mjv7lslzvimmgiP+VgjHWVJfSPsm8N7JiSL1zKYDFSG9iFmykMoJ26q2dxw6PJMGGKJ5G725sV9v2CgQpluydaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKP2ORv+fbCr7qtk+XSivQaujUsJpdW6jW5pwhp0+pk=;
 b=KL94auizAonbdq1dS0pfzQ59zh4wcqgIcxUCh5RzDXsAvkhqhoe/5tgnFfEDR2EySEFmpE6Ps7RU+rRHljZrpY7xXAXaekDt2ZzGpUwE9UJ7gTFSLWqbwvMLNGqvtju2uf4mbTcEa1vTcwx75z2GkDYYHz8Uwkw5dEBDYTfZJiunrHjlDmMkb5ys9c9Y2a6hwuqLJWIMUGcUCRXhueqxnY2LbeWjWXEh+NLH0COKtB5AN3HEOotn8gcETuv34G6EGjMFADx3chS/tjzL/oAEWaaODI5Jz5LThFv+xDd/gO524xELoHWX3oRkFTs/gOjoN9mrBdL9aPW8zoUwlLVVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKP2ORv+fbCr7qtk+XSivQaujUsJpdW6jW5pwhp0+pk=;
 b=D/q+1J/EgkJrQ/V099G2YE9m8eqJ2pZCKDavl+B46Fe2ayRNmKh1nT0QWUBpR2tF7fQSiXp5PwEfpjCYHfnwhc3vaywgTW5HIC4MI6UCLrHDFeDHBYjetGmdKZ4NqI4P2wFsVoW09BM9GIIMQ9nJgnR3M55cWeQOgBU9x6W052tG0XVVodVjny8I6dyHLLtQe0ImZgFfFeon8yetXD32Xu65FhryVTtUsh8/BYCBrxtebEydEinZZ8Z2qyO9IW+RRRu30Pv6Gt+6VUfa96pOmPhLE/WQqw0E/64NNmU90sBJWxFcjtu2WIvZOquf729wzcIel2BJSTME17Eqnm9YOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:55:14 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:55:13 +0000
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
 <20240419011740.333714-3-rrameshbabu@nvidia.com> <ZiKIUC6bTCDhlnRw@hog>
 <87mspp6xh7.fsf@nvidia.com> <ZiYseYT62ZI0-_V9@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Yossi Kuperman
 <yossiku@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 2/3] macsec: Detect if Rx skb is macsec-related
 for offloading devices that update md_dst
Date: Mon, 22 Apr 2024 22:55:02 -0700
In-reply-to: <ZiYseYT62ZI0-_V9@hog>
Message-ID: <87plugpqrk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 774deafd-b638-4edf-1fb6-08dc6359f17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jUepCZca9gXJbjDNnbZ3p3xC3PPV5kxZZkgEirqCN0m65YAF8OHCXNuBPp5?=
 =?us-ascii?Q?dlZ0LvRBaJx9fi4eepRWrSKtp5s7Sz3kT8P3hFOaovvR4yi3v4FVraOr+/Ci?=
 =?us-ascii?Q?CbV9Y2d03Bw3CN9ZgwRLlBGgkZaFO45DDpNJ/8yS4lTooQNwWBwbPdpYGcwf?=
 =?us-ascii?Q?sPage9Ms6uHD0I1FQjPa+Yt4mmpMP9xiKvXQ+IDHtGwdkH5oVKKTdjuOh1PM?=
 =?us-ascii?Q?mFpKgSpbEegBWBOR2+vkLgzfbFxtY32iaDydtoZnGgRPisBWO0n+0qeQEB+g?=
 =?us-ascii?Q?bHWiOjde40yhh5eAH2wGY1mlkh9UxiCPu6P9cFch6kWS65RdR/EONgS5Dpo5?=
 =?us-ascii?Q?XyCk89bLIaIcbh+tZrqn5HsWScX0d3dEh44p2z/fDAcJxnxMFLSpGHwi0w0u?=
 =?us-ascii?Q?3509uIjDXTKUIsHEpXOW+Wk2FPVqx5CeF+k2j1SoQI2MQMFBQGfFUWHrf+vj?=
 =?us-ascii?Q?dKUGw9opUzz9kPgYDvwPSqo3MYTlZSHsILgcfB2ZEEsNaDC25bjz6Uba1YPw?=
 =?us-ascii?Q?DSqxhZKBWA9UcU8EcF7ej8w1KV6KsHGi2E1fv4+2bhHF0hgIWjIxFRYKpIrx?=
 =?us-ascii?Q?pmYe1QSLx3IcPGMPyMNx2M6gsUTbtpWqs2aH01EfOzAylac0Bza2tak+6XjZ?=
 =?us-ascii?Q?Ughz6tsw/jDjRhnDPWtNq7VAOzLuMnO3vAUUhpcGZLg/ieSzelaHSwdCf+Ts?=
 =?us-ascii?Q?13Zcjomwam9VW13v8rfZPdJwnguwa+s1yusMhCWNW4P9UzT9PUT/2UQ9SLNU?=
 =?us-ascii?Q?B+d2PvURiQeLkbFW0ojGKe5bWKLLKAIE3wWY7qf6NNENXmHHtB+Z0CizX4YG?=
 =?us-ascii?Q?0llwn97zrzhoS0Yc+1eQjqukJSc5+Y78MnN4AmcwHTeF+xS8FTIolRrZcc9U?=
 =?us-ascii?Q?GANJgD5bjsWQnn03VrXNbbaiqWopCoGI2XU4VIdWcGpYbxfX5NM2yY9UcdCN?=
 =?us-ascii?Q?1JXYyzP6Gc1sTn8BfkQp4BlrGVTW3/Fyu00NpRJqcYRUJHvdlMcFabiuH4lI?=
 =?us-ascii?Q?0EbRTa6fp9/iBlG4HbM07M14ZEsNfWAYZzC0fNlWSI8OCG0T2EzKUHkS4U5c?=
 =?us-ascii?Q?Oz1oG+BTJ7zEfCEmF5PDP4wMOMmDeFfn2uyqNt4Dis4mpCxUzt0053J2OinQ?=
 =?us-ascii?Q?4bffqT3nShBSnN0X5Ctsr08xL+kIzysPNg58BgtmkFveLdjdB6GMSxCk22nv?=
 =?us-ascii?Q?ipF/KErCEdVtDQsGRYBUlVcDIGPR5QPyGzskEsocjXveexh1h/qUmk+AGLzR?=
 =?us-ascii?Q?GvAzn3fF4025tCB0Oj5zb98V2O72qL5Q69QYEj41UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYkfV/u5gR9bBuzPS4jV1O18SLjHpYzErlhSE87k19zJsJbVoe7uYP/jQtnU?=
 =?us-ascii?Q?9lqZtTimQli8ae6f8BV2WrV87/kbDMpZmVh7jSqzZsb5qwyb26P2WTml1uzU?=
 =?us-ascii?Q?ULxnIEDUq8bojVApsvrHuPMPqObU4NDb3YrYMcDeWu+I9R2trAnkdJV4QqSo?=
 =?us-ascii?Q?oxYeMaTE8Q/M0p0Fi+UJv6TisFCAY/FD5v96RAkJDRuCVRQnTxhNqawwqjYo?=
 =?us-ascii?Q?3IFXixsPWI3vx14ZrbDLg5RNZyE+cZHcbMEZ7jvg871rtQj8hClMcy1mL3eD?=
 =?us-ascii?Q?GAEvnHmDJTWTl0EdjT5ju4/9Z9TS4feR6OVM0C0KA5Y/Q80Lp1ptBsE9IQrS?=
 =?us-ascii?Q?0h/t0+DN7nPozs43dvC1lT9BW7rwxK7TawDczJ6adLEtp7JUDiT/b6+t0suW?=
 =?us-ascii?Q?Z6WUEi9/8GK7DX7lP/4bZswLB2PH5NU4VFQSOTfDPcafElHesZ1Jr6PkBpQp?=
 =?us-ascii?Q?ND6BI2L1yXFW/H5aTMLa0EbB7fLAso9aBfuGs3AQV3776bOYR1M9kxLLpCFz?=
 =?us-ascii?Q?QC4jiYl/866exRkXv7/SvhwKnQCMdAd8CkykrpymplymxXWDZ8ZqRL0qSyQ1?=
 =?us-ascii?Q?G+5tlyI6ejjXvvMbe5C4g35znO/gOdTHxWHmsi/rRmny+8pMZCjYkC7Z4w0f?=
 =?us-ascii?Q?8DxmGSDMoPhs2iNx0Gp2LMpCbPvGhv9SMmdjK40wUCDUO0GU/m4mdF1MvUTZ?=
 =?us-ascii?Q?CaMaixRl0vtqCk3zpq2LZ+qSvu6wl7iHktiGoTKOgRanff9yP14fmw2EX+7j?=
 =?us-ascii?Q?h2GeDTLg8m7eS/DQ1FStyujGu0tMoQZOnWvf9tQPDc4PP+lm1grf6qQxmizg?=
 =?us-ascii?Q?UBDsZ+HjKWsTjB+qtWvo6UPI97Fu1QE9RUA0KItC0Jq3QwB3PE7jmuyBzDrz?=
 =?us-ascii?Q?8iHt0uaNmuJQwpSeAdykA1c5cR097bV1isp/EnyC7TxEQpLRiqyG9ANiiQwq?=
 =?us-ascii?Q?uYGNxWrJFL6QqNhccTLsAK+le+w8nImq/zyfRX/OO87JKzMXL5yKdASUbUsw?=
 =?us-ascii?Q?YqlLDuE7j5V9/Zaa71c+1FbOHNQQ3YrTEQQIL91mSqLEn2GbImZZ370XML9Q?=
 =?us-ascii?Q?gKNHBVay2awkbsT5MrKEgc8kYVikIUWRaE6mE/aOzCwhJ2VsU35uXOedvnTc?=
 =?us-ascii?Q?lMJKyGtUgrSF4EdWmW2jT8OStQm20pQIVxBHrmV7Ts+3EGmSqBxJOI/INmzy?=
 =?us-ascii?Q?tmjrau28uPic8CcH72NcrCkL1L91Qznvs8xrtEibEDbk/3XqwF3PiLWUjnxU?=
 =?us-ascii?Q?db2oWhxGgHn7OU3pRcrTS9pAV2DJPZlZ/5ovyMC4EyO+Tt6WKLrUvz97BADE?=
 =?us-ascii?Q?SGeW5g1zS5YI5SoPqE2/vRN+Atiz/dS7/Z8D/ftEEG5g87BSvM/RBP28VELt?=
 =?us-ascii?Q?Sm/Me09u+TT5IZKx54pwTQy9ZeqwMcUJwj04Aant8bgdmgQaM2+vhHj9gnhh?=
 =?us-ascii?Q?nqTvHHO+vEosjH5Zgk9/RAozUUznHEA9XVPVknCpswA3UsKJu8dTTH8ohf+v?=
 =?us-ascii?Q?KkHflywUYoRX9Z0RIkNa/zaEm2GivhXaAbj6vvoqf8y4jZ9zhPMlQg5oIfvB?=
 =?us-ascii?Q?5GkgX32yigSJuEtnryPdKE11Wt+yYSXBN7EeJ3WrEgxRkLOLq8Sf7UhW6bx3?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774deafd-b638-4edf-1fb6-08dc6359f17c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 05:55:13.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrBXVkSRl8nBlmspCpA/grl/E+peSatrKNRC4plF6gsCnV04mKXwxx/QaAVO1cZl0dmOzH9yYUj1+stIYU5Zdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

On Mon, 22 Apr, 2024 11:23:05 +0200 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2024-04-19, 11:01:20 -0700, Rahul Rameshbabu wrote:
>> On Fri, 19 Apr, 2024 17:05:52 +0200 Sabrina Dubroca <sd@queasysnail.net> wrote:
>> > 2024-04-18, 18:17:16 -0700, Rahul Rameshbabu wrote:
>> <snip>
>> >> +			/* This datapath is insecure because it is unable to
>> >> +			 * enforce isolation of broadcast/multicast traffic and
>> >> +			 * unicast traffic with promiscuous mode on the macsec
>> >> +			 * netdev. Since the core stack has no mechanism to
>> >> +			 * check that the hardware did indeed receive MACsec
>> >> +			 * traffic, it is possible that the response handling
>> >> +			 * done by the MACsec port was to a plaintext packet.
>> >> +			 * This violates the MACsec protocol standard.
>> >> +			 */
>> >> +			DEBUG_NET_WARN_ON_ONCE(true);
>> >
>> > If you insist on this warning (and I'm not convinced it's useful,
>> > since if the HW is already built and cannot inform the driver, there's
>> > nothing the driver implementer can do), I would move it somewhere into
>> > the config path. macsec_update_offload would be a better location for
>> > this kind of warning (maybe with a pr_warn (not limited to debug
>> > configs) saying something like "MACsec offload on devices that don't
>> > support md_dst are insecure: they do not provide proper isolation of
>> > traffic"). The comment can stay here.
>> >
>> 
>> I do not like the warning either. I left it mainly if it needed further
>> discussion on the mailing list. Will remove it in my next revision. That
>> said, it may make sense to advertise rx_uses_md_dst over netlink to
>> annotate what macsec offload path a device uses? Just throwing out an
>> idea here.
>
> Maybe. I was also thinking about adding a way to restrict offloading
> only to devices with rx_uses_md_dst.

That's an option. Basically, devices that do not support rx_uses_md_dst
really only just do SW MACsec but do not return an error if the offload
parameter is passed over netlink so user scripts do not break?

>
> (Slightly related) I also find it annoying that users have to tell the
> kernel whether to use PHY or MAC offload, but have no way to know
> which one their HW supports. That should probably have been an
> implementation detail that didn't need to be part of uapi :/

We could leave the phy / mac netlink keywords and introduce an "on"
option. We deduce whether the device is a phydev or not when on is
passed and set the macsec->offload flag based on that. The phy and mac
options for offload in ip-macsec can then be deprecated.

--
Thanks,

Rahul Rameshbabu

