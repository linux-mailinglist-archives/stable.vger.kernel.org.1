Return-Path: <stable+bounces-118465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBAA3DFA3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94983B7CDE
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEC1DF754;
	Thu, 20 Feb 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HiKMLmWZ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616913BACC;
	Thu, 20 Feb 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067135; cv=fail; b=st8VinkK2oOFFvNyNlPRYhyMbsmble2qRPspJEb3XBwtlEVM58kYC8ERDucy7XskMPC6vod7CSjkIVqZOvfua0jWegRSXnzfmw8jI9QmXPH9cN/d+my2wxL+JjeGT9aNa1DG4hvqH1gkSbFiNPb1VjfPNPWHIyBrX0hwoGXG02s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067135; c=relaxed/simple;
	bh=TrIwiyeSE95gITaK/5BH9i0BKBPSXUK1CmpEOqdrSM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=STEEzNg6/ieFymAmiZ+ERYSLEh2pKacDojjoz5obOeuhc8t+cUGVvw0upRLAmfgEyJEFRpbLWlUSG0s9Y3JXIF6bIjpWuDzrNj3JypbZGgMyhJ/VdORJ2ojNUgsuAYsNXmss0/80gvguR58+1W8oDjEqoEjP6TZKsLTkJcyEmBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HiKMLmWZ; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0AjzK5Ufpmxzz6+OjonROFpnvv6STsGdpmYk1RRoxsv/C9XYrpWgqGjvJCDhneGUK862HUJw5LpcZMF3RJOX8lD3lUUCfeyyVqSlREoQShKlb1p3us8j4D76T897LVVgH6tPqm7DrX97PqBTG8D2W90D4omUSisXlkpn96EZtw7hQmCWDyqaNVV4wg6/MAPpOsfpoT0QkRqRo0H8fPC0utttzb16SPPpgOe943PJ+NgM5adDFA11F0JbgOK4ZGZ+WGUYiXwJvec8FfivmNzBwmIpSnbErw69WS0BZWADCorSocJeYzTucLkLVGqiRRL5lm05a4wdjNT9pE7Zj/4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZUlHkfop9m6WpXbm5p+EYn4Rr5r7eftf6oikbeJZuk=;
 b=TN2iYK8TOPKfwwwPpz8bJ2FzD/kK4h4w0Hgpwv2zVp64quzokwzVXhnZmAk2dhEsucL+FFjiebATpMgHBuRDO/QHsawIhl50HTfTkntLQUvefonNfg4Arw3SqC0i1tGspJzOqXJX5MSsAk3fHriolyz9nCIoz4+coAI/tYouVAk9M90clKQm2G7nlyLre2BvMLMrMTkE6ZDbpg2Evd2bkzehS2q3J3teLG2nNz9r/GzwoHxi8i0Bf+XUr3MKU/6bA+ccrzUT7QJPv2EIpw1b5XaHU4AKtbphhW1Skl+J7L/FDimKQxyrUD5aiQRdac/dvlWxi3vP0zDW14WF6Pw7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZUlHkfop9m6WpXbm5p+EYn4Rr5r7eftf6oikbeJZuk=;
 b=HiKMLmWZVNTlYkTSXAmDqayOWwJ1b+C3uaUWQkbvzB5Fmnw3ToFgdszERX6WRHb1fLeGNyke7jkvJBipCFScFNiGr3oJIVu8Cehzvr+xnoWua7BCmi+/BROCVbp9lLIJxa6p/T4erF+hWhedfHoiylBkT4UwE4KBquSmQYm+liXCoB97vmEe9KGlScSALPvlCuHO5OUq8pThkg/Ft/tdSOwOFbadfvMMCoYvYhPiNDZmfYuwXu/J+7h7yXl2GjC2LWWFxzSKhWsrXCS/RNUfNqdMb7WQMCVa2RBloeQ8T64cn0Nh8aoaufp1mhUfQmM/cd8Ou9Ls0g1nFwj3gtiFuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 15:58:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:58:49 +0000
Date: Thu, 20 Feb 2025 17:58:46 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 8/9] net: enetc: correct the EMDIO base offset for
 ENETC v4
Message-ID: <20250220155846.sqpxpkbugrehujol@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-9-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6052d4de-2891-4a42-b15b-08dd51c776cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOFBetFjR37pRuHjZuqLDelGlgfGECllteQx4vZnoSPBrLJhhS3hE1IXopJZ?=
 =?us-ascii?Q?hqlHzYIeQNv7yovk17nyoGxog6fAYWWy4WsZb8RpfQYTuu3hr9R3Bl5fcpyT?=
 =?us-ascii?Q?gqitXvCgo2gQAXzbEpdoucrsREm3BhpG4RiGAyhOjd69YBAQg8ucifWTTuIE?=
 =?us-ascii?Q?mFCr5W5Dop28TACjuMd2iZCTFuk9ijW+dRuCoN83CJ1D+nUN4Mi3UZWIjXzq?=
 =?us-ascii?Q?2Le11gqQroLHs4pw3o35YV9QLIR8wtyJU/FNV3Ud4JtOzOwwT1Q6ui9GFqS0?=
 =?us-ascii?Q?P7PpkBGvy4I3aYIvH7l4ConjIona7AcTu6yezflUTxhjkxt7FFRuaguUJ25+?=
 =?us-ascii?Q?E9kuubXnvQ7rWzazDcCfONKIJQSzQUxrOOlZTSWSlyLmwVHWfB3e99JJFMuR?=
 =?us-ascii?Q?Q0xqqmiklhoiHICj2EUtiGyDVMJ9eHNqyaWBPDggwHTHPU9BE1FVzu1WRGln?=
 =?us-ascii?Q?pnoCRk+BjSWpeBZ482xebMENgU4IyQXrEwfqgoOqndqp9GshoMTJmN5E8Bpo?=
 =?us-ascii?Q?90DWnXkmIOxjan7ZlISU7SmTUuEC4XOKcklZWh3UUIJuinurimJZIncHAxUa?=
 =?us-ascii?Q?9nwqbN18Wz+kFU+yCp+PbDCiJpb3qPB64HoRYQoIq6aiaVovMlTRnFvd3/Qo?=
 =?us-ascii?Q?GZdgH3PMjDGh+hx/Tc2SdqvEd5QuCvnPK5bvv46zHHvJmA2uZvUdMl0u5IhH?=
 =?us-ascii?Q?uoDgKlaOGuwiTI5dVKxMg9qVI1mamaq4JQFuetMsUXobYPdvR1DzKMbNwOh0?=
 =?us-ascii?Q?eTFSAdZUxzMdadQGFTIdD1xiceUjx90ONwn/+3qByPuG8uTozB4DM19zlo+E?=
 =?us-ascii?Q?yO+v9cDWVjDUIt45z1fGlqbDg25ezxE4TGeI9queBiHYn0Ifzo5VMGz5zEcm?=
 =?us-ascii?Q?uJAtMyzn0w+tNFgJmDZkJuKaYvmU4+0XPmrmTMq1S/ZDIYH96Ul7F1b11B89?=
 =?us-ascii?Q?NLjNPlV2y1Bu8bLDrAbL/MLN9PAr6Nb8NNdKnOJvjYZvCkac/Lp3obcUV6Fh?=
 =?us-ascii?Q?InOtCYSUsmMpRxP+LK8poX94lkQMVeTo9rfakP50ru4sp61VMjDbeedGiEm/?=
 =?us-ascii?Q?QpouOj2iAwsCUsIHPL+qU8ViWUCkgQjIKES0qWzyDP21e4kv4Fr4U2doIDt7?=
 =?us-ascii?Q?zQUx/5w7evbwbUKqYqL52QqEyWsNhNcwSoqE5c0l3dMnny5GsGc6drfTDneX?=
 =?us-ascii?Q?kLg3v238t1BspZybc0KsVFQEel48QbdRRUijJauypwvr6Pszx9UxJIe9L11g?=
 =?us-ascii?Q?4zZa/+qK7RF1Y45/x5AfveGyDmXjacvdfl9jEDj9mTEhfqF8l611HoCPlVDc?=
 =?us-ascii?Q?4Pd++9RIdmz6yQbYYiQYEfr0CZH72/V8kd31M9V0iazoR1pkfavW+FVNc6dG?=
 =?us-ascii?Q?AOyoWBpds+eLZsZaDNW73CdeYqEr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbM+sbbHGE6iNVXbxNeVZru9skOJK0o9LojC06zyx3dcNqA8xn7wMCE3ploc?=
 =?us-ascii?Q?4FF8rtShSp0AyPLXSVd3oKBPNM7liH/l/RE1IVpCeFi7L78nPaOCyhKCp3F0?=
 =?us-ascii?Q?kj0/Mvzp+QAPxySYdP+iwU3EtRoKuAKAz2O7QU3jnkVyNCf80jG23tri3mCk?=
 =?us-ascii?Q?pV6cHTBvBylL3l/a5yncpnt7QntQwhFvZ+6igEa9zmhE3T8gEk1CNNWCAvQ4?=
 =?us-ascii?Q?LhfvkSwxPxsBkD44yCkZ2mSJIRzkTnWF1UG6kNLlNFiWtm/G6rXx4Ox+lNJh?=
 =?us-ascii?Q?yBesGnREKj3wEPgcKLDtxKauAa4ZOGuBmvM6G6fK1l1FHMA/y3b7l5ILQsLU?=
 =?us-ascii?Q?d2B3LfV3tO/HRsbf9tgLLDlWT/fKCZ8shcLR4SFQcafZiaIfKCoWL9DcgN16?=
 =?us-ascii?Q?vpcylfrJrVRv2DBho2KxcpXPbRn+US4V7it+nhoBDmyRreHorOcd14FV0FJ/?=
 =?us-ascii?Q?oC7Q5Cb4LA1LNgjDnsepbn288bJnQVtmS007MD6LrDf/f6xO7vQsbgBAADGn?=
 =?us-ascii?Q?oLDph/Qs3StqeK9gcT7B8XYkkJ8QKwzEdFM1b0HqF9rjFyC2vOAB1sqQnZZa?=
 =?us-ascii?Q?5vQkgWp5MI4wpwHmQvbyDbMi1cWNPLGdEifMLcTiXb8hrcBVA2dBpK6vmV+V?=
 =?us-ascii?Q?T5PrbtkHzu+R9n0+z6RyGD4ZEpEoJgsS4oMabKTJ3J92Kbrm5LreRWyGXhCX?=
 =?us-ascii?Q?uMtJaNRF7yqKqWoCcp6OnmSam0cfbxR7TBDw1YYke9V/D/q+c/sn6cOPot6x?=
 =?us-ascii?Q?7k5GlBzZry6Fxm9txStRuVT3hSJuuNh8sXWJHDAAwHk/fRbtSYfUA56YW6E7?=
 =?us-ascii?Q?KnrxIw65KpNdgndMKB5gxT53QlEC89A9dThTR/Ko4kssWKeFoarkvasRnhFz?=
 =?us-ascii?Q?Vd00O+5QYM0txNSQlOerwkFHuInJ/yTA4J78kDlUEveWQLqgZ+w8sT+pYt58?=
 =?us-ascii?Q?uc2NHkEYdydr13AgUIEgDV0o0krUgN2U9z4cbnd8ytQNxfYKa7nBkDDFcnd4?=
 =?us-ascii?Q?eRE+F5KfT9FlsS9LPtMwZfBVzOuDALZp89Sk8mQyxiuehE7VmbpZVTStxUD5?=
 =?us-ascii?Q?RKrmDKxdDxCPSaGXjsAx976NFSzi7xzxntYAyz93SNh5L5vqzzvLdh4dq5bZ?=
 =?us-ascii?Q?1zBZFQAaTIWxvN2qAEpXMpoaKYFvbiEzV4dhm4qClkO5cN4KvwqJhkVwow9t?=
 =?us-ascii?Q?ESzhxQIYSrGV6nQFOnsY9LBkMEjn5o/mBRntdsUCoVlZSHWHOyK2e9DVyWD2?=
 =?us-ascii?Q?HltPVPQOqJVtJByTW7qSulqQHgRNqYPQppH6bxXr/ZJTgquWYKqp7aa0dqK7?=
 =?us-ascii?Q?0DmEgORa+wXdrXzrgf+OKDlywVrUnFKVEXNIm090E2ouhCP8LaZSC7vhWjk1?=
 =?us-ascii?Q?xPB4TORduB1b8RuJS0erYjDrhJh6Ger8CqtRWMRNOXoR6p/Q0b2U7MTsuLt0?=
 =?us-ascii?Q?VYrSE5b2r2BA/Kbjo9r5dmKQ82j3jsq+aop+AUqMmUoFNjZlSmIq2hp1UjvY?=
 =?us-ascii?Q?kqxiCbcUGAp1chf9sa7Zpvcxr1+x7VY+9UxABGh35+Z4YaCe39EcpUkAepid?=
 =?us-ascii?Q?+H4fGS1xllu3aIiNBaQN+yMLH0ZtIRtpzeA20RQRC4ekzlweJ4m2nrc0Ih++?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052d4de-2891-4a42-b15b-08dd51c776cc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:58:49.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlunLZiKBqBNx3rzwZ0+CZX1vmWsuTIb5htLeTMJzb8MjmnxARKUYGfHWzgG/L46IQikNHWCu7KLsKVJLk7svw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383

On Wed, Feb 19, 2025 at 01:42:46PM +0800, Wei Fang wrote:
> In addition to centrally managing external PHYs through EMIDO device,
                                                          ~~~~~
                                                          EMDIO

> each ENETC has a set of EMDIO registers to access and manage its own
> external PHY. When adding i.MX95 ENETC support, the EMDIO base offset
> was forgot to be updated, which will result in ENETC being unable to
> manage its external PHY through its own EMDIO registers.
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Though I have to agree with Andrew. This looks more like "new feature"
material for net-next, than fixing a bug in an already supported feature.

