Return-Path: <stable+bounces-119389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C0A42832
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1210B3B1D56
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CF2638BA;
	Mon, 24 Feb 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lKXufm4P"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF702036EB;
	Mon, 24 Feb 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415445; cv=fail; b=izYhR/Utq999XX4O1oZDn5VNhNhQvB/0DGad8p+wCd2OngH7PWaANWFKh21JgMvF+fhGcv1IAuUV0+pLHbqyxy6sHo5yKr4VKIjX3EZzpk0lgJ/NaV+OyUc19Mbh4NLqRtnzhXpSth7Qh8BbiATrZNK9YfmP7bNm/EcXUa8u9rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415445; c=relaxed/simple;
	bh=NZMwU6NkZ+Bvi5ISLZLE4T24jaE9K+TwWQrebhR4tMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6MBB7l7ZNLJXubvSOt4bBzpgbW8HDJO3xNUsWCezzPiUxUbQZ2XffacjNvm7CYG13X5tL1MN3Uz4Z1AJ0ReOojZs80qh5c5wPH0367A4uYpKzc7a7nY3i6ps9HU+yLNjYYeah+lkKGQ0ChMkw5JtPew/mnNmjK6LVKu7W7Cx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lKXufm4P; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTNmI1+0N/9Y9jcfmDyWL4iigJUmBmNYfft9nEQDC5d1hn4hegxQjrZsg3yE+drO79qLU0V6GooyDXQrgzEodvAF5wnlzC9thUFIjYoTvarsDVYK11P46UzyI5QB0q2fmfmg2Ia4tuKzJyM56k2fEukh1C+YIPI1zLsgIZC7c+kGTLqrP4HmmJshcsgLJvY4WwOt8ETLUOZA2IZO7I2tSA9oi9eFULab5uNDg4hqQywq7HoNILJuPaUPZZFfZIz2WsFztUmoYNdN6edIOHCGO/Srx8pbmoYULnpVHQEdW4V3s4ji2QSlja3GIKHkeX2yXLn4HKwpWIm6/t3CEDXaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap2l6OmiXdI7Mz9bulMlASaZwgdMqovLH73zWQn7Yck=;
 b=E4q3Roe21Yc0E8NVttz9rC2wQsC8FO2HYMty6Visa1hH0Yp9vph8+YNCTYdTuJ7dnuR5jQZo5n+FxaXIIPIUcueOzeuPOhjngLe0sPV+PUaFY68N9Uss5RcB+qu4ZQdIS1+pOLxYfu9lOMIB1YTSHxUKa8SvaLxGyOGuKXkLVUKg0SR0s1seRk+sCp5nsU/chpf9ZcNdH5BhTsbceZI0LoKHV6TXlo1mCebnuTJzIoFTGRseGL+F9AITd5Tn3YtLATWzqdVlmnbG47uBQrkaDcc3T6tySoblijg06fjCvo+AFX8VB/Noy9YkhCvQqwCzdP1VnGDEBKbm/YkAb5dx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap2l6OmiXdI7Mz9bulMlASaZwgdMqovLH73zWQn7Yck=;
 b=lKXufm4PEQwZqaCnf5ADX4wCLATHmePYM+OU7EIUKocbOgvP+svKWx3JR5WuyYwBTra/aiS4ZVQc0oNHS6f4jiktRP0GGHwQpomkwYaHkYaBtP7JXtULSBxK9rVN8p1MksuFopjl5MQnHZkux++Dc6gJihxFgdYetXXfSsQfjNmH4k9sPnKGKaCxu6ncyPreZacgXCmulIkJYgvm1o2eKUzF8nky/0FqLP/YhgXNsiCVbU43s75Sa9q1G3kjX6fNererIhSuUzcpyOtk+BgPo3Z2wQPV7ianZ0Z7QA87/k3BxsunnbqwnaWxYWPClMdsvnF0aq2L9kciEibIoD7ZwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8978.eurprd04.prod.outlook.com (2603:10a6:20b:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:44:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:43:59 +0000
Date: Mon, 24 Feb 2025 18:43:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Message-ID: <20250224164356.vvxmmso6yaoguydd@skbuf>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-2-wei.fang@nxp.com>
 <20250224111251.1061098-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224111251.1061098-2-wei.fang@nxp.com>
 <20250224111251.1061098-2-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 082a6cda-3b79-4f9e-2e94-08dd54f2700b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eM2CSKwhGyDjpG7PAHwC3W32OvLSgUb6opos3joTjTYRJ3PwoyCb4Npk7pj+?=
 =?us-ascii?Q?a/c28B+a7Ey7IVgkyvEgEp9V8m+42vQqgCgJ3rWx3sed3FrCgYdmvQZlT6TW?=
 =?us-ascii?Q?63espo9xaPze6DKREc/9AaLrcxdFdRknbxwnOvAwOcKAp4okLylqZ4wctQ4A?=
 =?us-ascii?Q?AFVIzmrb9w4oGEcKynRaOksL0IMfZtOv/y4SZRMH9FYiaC614nenlOt8jsKS?=
 =?us-ascii?Q?XOWvqjD03FZWVuo+bLzQVCx98+HZG8AkLouAn+Ep3rk095tUFsqolD/PKLsn?=
 =?us-ascii?Q?vUeMYqQ7iCjn7twZHb8WwMdImV0rJFXMKn8NsiWfbQ+/ayqPnmQOZBrZFymP?=
 =?us-ascii?Q?JIaHlRhuIKkbLoRAF0XYaZ+c4DPFxtvt6ai6f05Lk4X/MloGyhLIHhs4TENA?=
 =?us-ascii?Q?2fQl92Hs+ImGvqtG3mecNyM09BN2JptQFlnX9q6gP7z2mpOZHYqJy1vkGP2Z?=
 =?us-ascii?Q?+/8iHB4HKJ3zp3uD03lKoJ3ZxVYNmSI89W7YwKVOhlb+NjZlebRa72ijGQiD?=
 =?us-ascii?Q?zVqCXCtZYkX7nF3sH9F456O1zvg56TKo7Yty9XY7L6g8Wepxc89HhqrGNRZP?=
 =?us-ascii?Q?/QHPB3QMaJQqIlUws+ZVlJGOosjM/48enJtBlyNhK5JH4UR+P7UFeiOWtJs0?=
 =?us-ascii?Q?IVPpZqfd/dVpWqtBTrubbjfxzoUpDejgoHSYQRrz9Wv5HDyh2zJTEWaL0XSx?=
 =?us-ascii?Q?WwDXTk2GqrF1MplOPvHEVlqZNdt1DmWxRR2/l3zv5I2Ra/9oj80R8V1aG5WT?=
 =?us-ascii?Q?gP9z4FfNNXWB7HQBOtZhPuU7MfGxjPcAqzICoN/kIHJWZ1B4BOucntOkKhZe?=
 =?us-ascii?Q?cpifvi6xvOtnZ7kNqDWZB0MmTef4/R2qionxnI+I0MDWHhAyfKqZma1Ji+Ui?=
 =?us-ascii?Q?NyssxjxwAC2qgkHEoyhNverDT5nHy8UAxH0ejOMaZSl+DvcnUm7qQfVL6/ic?=
 =?us-ascii?Q?kB+3Kg54VeydorKj9g6+sPU/zDTQbKlK48q7lSytcnulN9xtvdeJ0t8ncsnb?=
 =?us-ascii?Q?E/CsbZg0ZfkMwQIvDG+A+eJdmxMdATb6URiSIeCm0l1buBVwGd3T1XrfeMc3?=
 =?us-ascii?Q?pcZRkXb5XaG8wT05632dFpvRp6yLFmvnPZnCGoOLocZShE6TbZBdq4xbO5ot?=
 =?us-ascii?Q?b1Ff2ui86Km44WLdcUSoJC2fPSf70UDgdP/804zZLutPS1d0/k0SYMpu5/MH?=
 =?us-ascii?Q?6+qRgDEB84Bds2+nbaX4uA6Mn7ObE2t+2QMh58pfUABWWPbOc1ZxCJizZK0D?=
 =?us-ascii?Q?Skgxk2W+44gtsk2gIKpiOxM8MRHnuzLLpgAGgjbDufwT9TR3S9HEfx6OmAKD?=
 =?us-ascii?Q?y1YBIUBjSdf9lYntOn/5rPytdDrUlZJmCLDmUZwtXGvqauZ/BYwTA5JmI9r2?=
 =?us-ascii?Q?QTVGZb3VmwFoAsBGLMRFnMYNq2ij?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9mU5uD7jrVI8rTm0PwQV6wz53UH5/YmfYfsyAlPU/uPuiW/1VLlq5ASBNhC?=
 =?us-ascii?Q?RYX8dxwIl5XVLmf+JtT9TwYOW7c0q8ZNZomXJYgXYgqrySqSlsjBjQdBYppS?=
 =?us-ascii?Q?06mQ8kXOSYS2JBPRYZAO2e61wVYU1Av98tG4Y/QxHspCAoaiGfT3ankMtlB0?=
 =?us-ascii?Q?eRiVS/N4HinjjZQxYrs8MikHLH3riB9SWmf33aX5jy/H6POU9U9R7kONFlGF?=
 =?us-ascii?Q?/8WuQP5vDI7EUeMTYnNNxgB13FaIOGA6OPPR+7mA0d8bhi9mbE/fj00P4vtZ?=
 =?us-ascii?Q?MfG1lUTjt7XA0t/JQEpmJQZrQh4wPjk2PdbZFvx6KoqeBotoGW47kjUYEAbk?=
 =?us-ascii?Q?EBd3hZpiieP4fs/n5pJcF0miHNWgyKsPZPlHqGmAvsoPFOpTjXF9nV8GWmSq?=
 =?us-ascii?Q?17IZtLRdpI7Zj3yL5SrN8FPXEgIbCpu2N3SsuPKJeh0Lna1sNoHF/tWixIyj?=
 =?us-ascii?Q?WRdZv8GXV2DmINWSAEFzq7IyiGa5qRqqBXup+5tY4yJqHWB8mc0KL9QxOgBO?=
 =?us-ascii?Q?eCbXgJq3A8Mmr/m4NrNc8S4/Ot0yXEhhx07n+l10f7b1ffWBSO0lEHjyZDUV?=
 =?us-ascii?Q?Om8N0QJ31bdpnF7IXY4pUNYdv+KDf90BU4p9/h+zsFvH8kqiWnkjzNjOo3wm?=
 =?us-ascii?Q?Dh6o1cSmxc1dZfnFbxx1pKOPoS6NTXJnqVJ4Mgxcq6teKAvHXLpi1Cmblzi+?=
 =?us-ascii?Q?/4rTCdjKuBFbjrw6quAq5AZ+NvloliHjac5TB4pZlQ+6CkTFRx/mpU8X5SK3?=
 =?us-ascii?Q?+miIh0wwRktH8Xi0Fg8Lc/FfJq0qYu+NqBBFSQLGnpEQCI8QJOlMjHdl0xMZ?=
 =?us-ascii?Q?YJA4UvFMRVAx8QCnL97fkb3TRe6CRra+5W1tACA7HLIXvorD2tfOu48akhp9?=
 =?us-ascii?Q?mC0gLpGt4ShSCsmhbLc7CsS2UOjqVz6ht3yoMdlr5IobhlAL7uyGgugdD9BO?=
 =?us-ascii?Q?NuWUbcHBmyymrm6qoGfHy/4V4JZuHwy5zKlk16aS84dQsi4bhY4NPuAV9koC?=
 =?us-ascii?Q?UVi5LLm/N+Ha3Ld3J2+Ms7v8ljq7isCVBoJccBY+96tfMbpo+pfWAA+kb/c+?=
 =?us-ascii?Q?zpVmNXSVJndR6KCtJmF2lAu3VDC4rPGcVIgr32/sgUmUHqD6sbjwjOsx7nqf?=
 =?us-ascii?Q?kbq+wygv5RihtogNcQwd8HQYRBi63gZMKK8Upsaboa0Nx/pydhClTuH6m9Sl?=
 =?us-ascii?Q?ebletdFl6jlSOmkkHqa0hJdb3j/o9ZHT6FD96XSAZrX6+b5Jq/MkhEQm/Y9G?=
 =?us-ascii?Q?wtviHJg8lLWnEpBeODhMO17UixLI9WH1mqAbYsh9fBQBtDFICZ2WQHrC7uY8?=
 =?us-ascii?Q?XLTn6VeNe4CHX/1TmR2yhczJtdfRyQ1sK4eiEH6qGP6C2D4L6K0Q68/4WWB3?=
 =?us-ascii?Q?grDTqrh4v6Qk3DTdXpchHQpg+rChQriR/Hg9SW3Q+VdUTCb9zaXxtOo/b4Kw?=
 =?us-ascii?Q?TID4JRvlpHjJLmJzPng1NuMUtqSUn4cC0wu0/0STtJV4AvIDehx9GUlKhcbu?=
 =?us-ascii?Q?lolG/shgt4YZ54x5AHV1/z6gmvyen53QMDX/1pVLodjGofrGaKC6bS857ipe?=
 =?us-ascii?Q?x8COWip+fvGGqYC74ZfAB2pxAojQSLuXXCUxtFIk43+glPgWN02uvVQeEKi4?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082a6cda-3b79-4f9e-2e94-08dd54f2700b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:43:59.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ReDamff8/1hgkPbvc4Y5wNE9EtTGuuY/qnNSECQJmGpFNmsxnAJnVocKkuetnHeAUphsML9iP+maqKDp/CyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8978

On Mon, Feb 24, 2025 at 07:12:44PM +0800, Wei Fang wrote:
> When a DMA mapping error occurs while processing skb frags, it will free
> one more tx_swbd than expected, so fix this off-by-one issue.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

