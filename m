Return-Path: <stable+bounces-119390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB055A4282D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59844174819
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C0263C8A;
	Mon, 24 Feb 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mcYJK5By"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C952155342;
	Mon, 24 Feb 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415501; cv=fail; b=dgbl5B5ZtQAqDVD0MPYG9/ljNaV3MkmHgBSJBi0EniNMLCR5vWR5nfcw8NzmV6thXTYttcVqfx5SoTHCdnLapdoPhSbXmBYV9bRSQJmlm1EB24tIBpqZkOWdnVzqU8Om4/XtGPsY46io7QMj9MYla5VGsDi/XRuu0w4XU019464=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415501; c=relaxed/simple;
	bh=8UcQ30uCe/hgeEDam/gu417HcoaY9KZMpZpCVrgFXuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nv1qpvVmkz8atbKeYfIjng53xipVgTP+0mde+8zxP21OMkLoFdLFmjNqrVL5uRYRQB/v7i81lZDvNRqaBEabLG0IRbeO/foGCcyVupjgCyZ/VZ27AMQKjVRl9RIo+D+SgpDufvuq46EjVDy4w2WygzkGTav+6yDguDXpiLx1hHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mcYJK5By; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHiqJpJufiK/XEueLiVbvXEWWlz2gFJ9yUimSHfIP1whe2QpsQYlwQ/OznTXLkuFaOaCDTHV075GobPcdn941u+dUbjOhV1I+d8DWg99bM0BI/Ps60mNQ05Hae8eKi1jF/l/6y8GVCQVd326ZcrdTAD4KGGES633/cHT9erTRznap1piyrrLPop+blRcb/pvNpQYlHEdiL9GqLcTsZakSnwsSe31regTjoOaXU5L2V7xfke6ULnP6c7wrcqkQfCcPxj90lVxA6aqU7aB5hlHDoyZ4DC7iP8WsyhqCOfJ488MVIYo7bb4Vk7xj+bEzwuraZrbd0UJxFH51sXzYatEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XAJkJEcdx3TsO0lnIxxZxuTjofSdK5sJ+tYBADpHTQ=;
 b=ukihAVYLs0n0JzCVukxeRwejIs8L5H1dosnf9wOKyd0geRJL0QP5K7wC3kFbaKBzrtLlnSrHFrrobU3OXywaQKpjWP0TQjIx8IDRvgT76i3MHjxzgiWMMY55PVNp6JMg0QC3Rd2HXuDQSSjBe9/ivQlz/3M43c2XoEgbtyjoo/Ws0eSkm3v+CXYnwSWAuWtqZIthLed00rcxS8cwUbPaH+KerLM8pohph2lsGBRofrMtWlv4tZn2DDi+mOKEPBs8MP8UMa65t7ltADuOr/0VAou7R41+km6PMWRjY2AC69gRp7putbBQpiKUDWZvmCssPdyd1rou3P+rHPqjvqJ61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XAJkJEcdx3TsO0lnIxxZxuTjofSdK5sJ+tYBADpHTQ=;
 b=mcYJK5BywscFdtY4bDsHl0aKKNL4I69JPqahffTUNnCCCAfvoj7efWXYm4Q+6RhxUaEPBz4tG90tkNs/l9iH2EhuX60lRFlGZZz8T6zZbvUHJjJQNf/jwyutEL8qw43uzVaSL7Kuui9x6ku8DXVy6Q1poOr6K7HvIyeWKUnBq1K0J/K7GCXa86hxtPomrEvRClkHTAmzRj2cB0zhlx0Ph8KFKKtKomb38SGTvC71Ag7r8jcsPP2swpojej7F0Bd+7kh2qar3lkZWTFCm0zJ/KDNwfHH/4Af2jcCn/pM7YxWYbl+IBH232NPOOO5wOjkfI9knY0ARrZgSqmQOV82N1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8978.eurprd04.prod.outlook.com (2603:10a6:20b:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:44:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:44:57 +0000
Date: Mon, 24 Feb 2025 18:44:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 net 2/8] net: enetc: keep track of correct Tx BD count
 in enetc_map_tx_tso_buffs()
Message-ID: <20250224164454.hjpcfdax5hv5jq2d@skbuf>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-3-wei.fang@nxp.com>
 <20250224111251.1061098-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224111251.1061098-3-wei.fang@nxp.com>
 <20250224111251.1061098-3-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:803:1::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: afc5bcfb-4707-4660-596f-08dd54f2924e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mar4oB6n6Tqof29YHRAYun3iekvHk2csyM8vYsEcVB8UdKILF1vgL3KbpcZl?=
 =?us-ascii?Q?mB3xEHtvnhQFMeu6Iz8euA3cNXbH3Q9s5Mv8NScjWj2WjE1qcRtOtw788T22?=
 =?us-ascii?Q?ne1sAFU/dA/KEntO1+eIhn8PbI5yK5ylDNjRi9X5wYDaQntEsgipiAvfXY+e?=
 =?us-ascii?Q?cUlHVV8rDoMXM5qJkha/+BRGm74OJq5tCP7Gx8lvt3o7029qhZhNBB4EThgg?=
 =?us-ascii?Q?VY6uNie5nion0DDF1GqvW4n4xYrZScap4XVzppi2x3JlWdCV/UKsKtTcRrkQ?=
 =?us-ascii?Q?ihKjGZmOsShjZAiR0vPHBRXDqr3UXTQhnJzo2IkkvSpgDk7oVRoSuuLM6S46?=
 =?us-ascii?Q?DyKF/iJMe6NC2fu9ZfozDHGMmUqdkYp0gm6Cgk2hiKtdEhCrYtxHTk0zurdm?=
 =?us-ascii?Q?kn5B8EYYkO/cUt5m74ROXVPHcXgLsqHDWRR8aOmZ6SoVI6UDwaWYhkaBveF1?=
 =?us-ascii?Q?ghUbwv5f6j+0Jenu4DcPgB9M0bMpEApwGA4MR3FeqwSC9zDQVeUH6BRYq4jy?=
 =?us-ascii?Q?n+cDWOyIFimJfsrgVQjAgSjiB4DQTgkXvIlNlmpCxgmvW156lVyjhVXSxfZQ?=
 =?us-ascii?Q?G2DLopXmNCikaDHh+zKb4KgMJZ7OAncGzx0FjsNffj0y8yzwgvU8ftSXoCWs?=
 =?us-ascii?Q?/xZr9+pdYVyRg8P+7gERNclDx8bqKAHddadedfGzeXwBSAyXPrYaS5RBEP+Z?=
 =?us-ascii?Q?pBEGKJDUVmyZy9CoO/qbYt2CWCOR2JCK8I2pBvc9k2anmMT9Empv4VlGhSyn?=
 =?us-ascii?Q?QMkVTu7agES2o3uw7l7Rf4LqIfrylTbQhsj4bbIp+OEZTcDL8z4c9ceFCT3r?=
 =?us-ascii?Q?7UpBN5jjdOWlmeb7DY7FYyJb6geNkJEksDaQKgd8SxzGQ+TR+UfTh7f7L3PX?=
 =?us-ascii?Q?yDzkayJyegU4Re2aTepQ3XqZYSg9gVt23/qNt51HS3PA+vajRgy04WKkpRBw?=
 =?us-ascii?Q?Hv2i0ZcabnGkbS3nK2Re4AgDH+T9FlN1vaP/UaWjlBI+kXjAGCK1qD9GPzNn?=
 =?us-ascii?Q?O6/gGx5smeedQrae8PaAQ1x9kk5oNvVCpqoF8FcPJF6TxUgbNj16q98o6rwJ?=
 =?us-ascii?Q?xcxQnDq4lqk1SHIHZMmrncN7LoWQ6eIPqLP3DJU9vbLhRq6aCJPU6zzx+jw+?=
 =?us-ascii?Q?ek3b5SM1vQvuOoWwBhg8/mJWc5V1D0R4FuSi++gc8uNKtJveb8pcnm/Ng3RY?=
 =?us-ascii?Q?YJmvg0QJCowao7Vob1FSEAS8UN20k3UxoFTd1Vy4UJ7kR4AX+pPZobjibu45?=
 =?us-ascii?Q?ORomKjHdmd6dmYvNn5d5b+vXeaqBEZcoZPYrDY7xEbWhCYjdRreUJdBw/Qav?=
 =?us-ascii?Q?VQO0kF+ayg+wAz5o3UKDmGHYZ29JTYfhthZ7Jj1tE7qP1x1Nas1pXDDHgHL8?=
 =?us-ascii?Q?O8Sw5GDIPsY8VZ9W6YyHhIhl1o7T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWMbLROtRfmWqyUpBOI8z6Y1rUcYGoUBJejS5+GKBPNDtHqXahwpnB9AkJ4v?=
 =?us-ascii?Q?J0L+YlAqd4i+9GxoILLytPek9uRjQDqaXpzbdYB/aNBmOAOsHmwtNM5m7bXL?=
 =?us-ascii?Q?stZ6sLuSvsWjnRYTRc+XHE5nkVuCmhuunGYN9dZp76HExjFiJU9NGswlzyn/?=
 =?us-ascii?Q?2kovWX36JuUgSgrJLebsWuPvqccpwF5UR8R4JLVJdfFYJMQX4TOAjTayH6aU?=
 =?us-ascii?Q?vuZRAIJSPwF6zPCL0we27CRvcze7OIlLGD345Do7ek4T2P5idretRS+rn43x?=
 =?us-ascii?Q?9ztS/DJFIhAdOVaZtJj42uevdD3ROmHW0Af28fvC3aVWN20405o/nPr2SOoG?=
 =?us-ascii?Q?slARkes7wLi9aYL8zctT0kzL4oIY7S6OnJA9suE9Lsk54AIkWF0WIJAGwNCW?=
 =?us-ascii?Q?ZusQJ94b8LOgVUOypKOaCU0lj+XzXfmfUZei57d8oNOx/Y4srN8ikLiITDTV?=
 =?us-ascii?Q?RZcAEQH9M4jh6p1aEyqNyg2N07lUGYTFygW5b7UfwoIYpMrZe4DlSVNCo2SZ?=
 =?us-ascii?Q?VRopKR6Cv6QKBJWKUG3TWz7k9n3HFRw67IJf2SDigQxctMTA2pa1xEB0FZ81?=
 =?us-ascii?Q?nTjv2jg9r9h/XYDHICwOSQKqgtav/F9zCwiSceqyG4JPrNAoF44dhI754WmU?=
 =?us-ascii?Q?Vm64irbybAvJfvPGUvDpggpzjbbK9UaG/ZK9a0DtNT4fu/43SY/lRz0LxZVv?=
 =?us-ascii?Q?dxca12QqWOlKICx0a7sHaY809FWCreENn0O15rMeVHr/Xo3DKiZQvLYXDNz0?=
 =?us-ascii?Q?fyT5n87ROLHVBtg9M0WksUKZlih6LZgXqlERQ6czdQPpX0u950QNFc3C9QMQ?=
 =?us-ascii?Q?VffoK7VXeNDHKSg8vWxBjCplmTN31A7SBRJuU49UlgVCz7UxQwS2cWvqta3r?=
 =?us-ascii?Q?5wApHLOLQLOQj3wdoZW7W8klfAN39mzNRFqYB63o/1L1GaK62oHAiUL1Q2sy?=
 =?us-ascii?Q?QjC8rIhxbNrrhiaO27vSDwqCcNIOrK6mRMhUJcvwIVXBJZlEcPGYBU+IC5a3?=
 =?us-ascii?Q?2pn5I8lkeDWek2+WVqbEeUBbdkDeHvp57cISagTiehnZ0LyAAOiyeAUfbiCe?=
 =?us-ascii?Q?cjaFdkpbmCWm+A1iQPZdPI+he+08uLfMVr3o1RVkmOVHDNmD5+pBZ4gv2IYa?=
 =?us-ascii?Q?y9PBY3KQJVfbOjjK7tq54mC+AMfHUESW9GjsGNaCcXOjT0LmBUwQ7isyq/hn?=
 =?us-ascii?Q?B9kMvdPaVh1xHpQ227sjkvxXH6Bj8DJ/8LxQWO0rLaXr09B53BEmYNBvViNX?=
 =?us-ascii?Q?5w93yGM5JjYj9+EOqxukgDTgG6+TnseB+axTDVK/kPXeHq/1l2IlhqvAeU+S?=
 =?us-ascii?Q?uW00NejI2wJ4mpRD2INStgsKHMjMpB0KxBX2r1GTbKxeK4+xXIrNm5OOgi+3?=
 =?us-ascii?Q?OOZOT2PV3NBb+qbONN+jTtAvn+ck9ycjDLohnigp2f7lY9SlItnIADf7XVYt?=
 =?us-ascii?Q?vbKyZYoV+8NA9cvHnrxXdP1W7yimW9vcJJsWG11AWhST0maqr0/OanBMe0gW?=
 =?us-ascii?Q?y55gC/8C+z5hgWZ8mQZXuo1cgxbjmNxcroR/eVN5McMSOZFUbPrNUmmn4Tlw?=
 =?us-ascii?Q?L+Ptgpw5E/UOwo6M0Ep5G8MFqA+qHFkcqdFHKn9f3os8F34GFErYeOQoRhE+?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc5bcfb-4707-4660-596f-08dd54f2924e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:44:57.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCif0Blvl52g/uSrhLYBI1jb6ekt1Gg5j8rdWK2Q3GVTO9Q0X1v2IMcEwf0KOmU9y1gjXiNZL5eXC05pREchbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8978

On Mon, Feb 24, 2025 at 07:12:45PM +0800, Wei Fang wrote:
> When creating a TSO header, if the skb is VLAN tagged, the extended BD
> will be used and the 'count' should be increased by 2 instead of 1.
> Otherwise, when an error occurs, less tx_swbd will be freed than the
> actual number.
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

