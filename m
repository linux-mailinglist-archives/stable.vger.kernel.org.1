Return-Path: <stable+bounces-118461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82312A3DF5F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736B319C56C2
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54F1FE45A;
	Thu, 20 Feb 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6fygrVz"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEB14A82;
	Thu, 20 Feb 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066627; cv=fail; b=Ulzk6VVx4IAMBOronn0sVwOnTdxb8+eXQVYpQn3HYUkIhlnggyDmyyOcAuqK5Za8S90ZpweSPqRolspZ982Zfn/JGiSqZGt5knhqGd3AfoDGVaZVgC8Bsq3iYXP6AxzVrX+I1qmV5QvPsOKqDUjp8L3o8XoIH7sUE/ebnpB6Tkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066627; c=relaxed/simple;
	bh=SewKkjOvFKZ0VwZOnkpnFeuXiPXlcN5XGQ0Jv7XH3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1+1WqalEovvjOa3jRIYdMBf64Y1hewMI+577mQ+hZby50Yq+g9UEno46hS4MoBij2tL5eHTxYQBYSlBgH+F22wJ7ZoNF1K8mijVBaEpXxkKFUVSIbDcDQiRiq0fnlz8kacjS0ZVgVh372CG2XU4iJ3i0MbCeeRYGuYq3s9nCic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6fygrVz; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4YK0v0ff16iNJeHGJnPaywdsjrfSggnTNIcoqkggmB0tqSM97LGBzaUetAcsapqU2gdev1yhOaS//1Dp4v3XBhdpfF1LTjSoMAr/q1QGjRt1xxnYuUaEuWSKvXrtP5Hi6ZNo/FgIqLK0bNAcryHWw4vNFIlpmlhVQKwn9tn4n9fvqWaBdJbpHlnx8oDTPtcNnbEasJzeqqU8V/NsAHv7Wl3gpYsNjo85sOfYptU7T/1lFRJ4P84IUuMFM9zD9bxf29ZIe4q4vmMD1rKu5DCziGXZzwV5VA3D9IvUgKvRGUBSsUqGjajWGGLPpFmaXK5IJ7rZEkZoFmaKhRvM1DkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDvAIJyFnAqdKCcRhp4rQ8ccN3zM/dHwNxD/etsia+k=;
 b=IOpcE88SePRmZ88Wsy3QsJMICkVzw10p6YvcK5/TCXWQ936GchKp3peJjHRri93xqRwvyjIUbWZyBDN2TUiSPIS32W0iv6TRQWuFq2Fa8arJeare7eDPU8/eKR7ph+8/2v53sjE+3eO84yGoDhVmmj9Krqfefxm0I4kaGw1i+3dUgaYw33N7qymELWqj0L1GVfoPN4z1HNYVG4eL+fEa6A4LYAwZ5DJqSXnHNWDu5tEp49P0kctWt7aPdPRsPZ7Ja0Zxa0fkVEBhTEbbJRykP1Gb5I76ZL2GAEwZMGqx5t0jyfD20xDBoKzBq819GNJbunHVQeyhiFzMNMnglj+QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDvAIJyFnAqdKCcRhp4rQ8ccN3zM/dHwNxD/etsia+k=;
 b=d6fygrVzeR66RbVFJLnmrLbqs0RTVJd60ragl6F8DrZytM1iqV7DVpGaGitwPfs7oGJkLKjC9Zkw28ELalCGHqMLsafU5b4yqXWA7LJ9sn7blDA9C+7XaO3El7KSTp9QEBRMnjVtA0SidARwu/icSJFCubAIMM4EU7AtAkR7TM6czCeR46zL6UT3gN9COyx8izNZvn0RAI2VKR1pOGnJ05f4ct6uXuDduujlgKda7tpI+u15yEEQxRAVplN2n2mZFxq5YDV/+ISbs436PcZBM9ZcHlNh/FMPYdANQ2Agb+VRBdMp25DVnKwlbqYXznppa9OVQbFjp2h5uoXt1BU+TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10146.eurprd04.prod.outlook.com (2603:10a6:800:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 15:50:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:50:22 +0000
Date: Thu, 20 Feb 2025 17:50:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 5/9] net: enetc: update UDP checksum when updating
 originTimestamp field
Message-ID: <20250220155019.efvh7ncknmbckyox@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-6-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0271.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3350a1b7-e478-4239-419d-08dd51c648cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrIJSwBUqG6KKEImimWawNr+uRdZA+OSHcse7iY/o3BqsWnDxYgsdUkndhMF?=
 =?us-ascii?Q?f4tbxljvhCOa3PiEsLtZfEGis9CaaT9PUmsOFhw1mE/bNGYPrPl2XPnn4uZa?=
 =?us-ascii?Q?ADB59KBZ7f/4Z1Tv7O7vjpWaRfzaPYoZMKV9/B31UF4E2ZSb2mGzkCpqtAby?=
 =?us-ascii?Q?Q4+DkCjmU3DecLFbNw2aLn4cgrpbs8XfbgTb5qfyfwG+USVlCRjPfXgfWgg9?=
 =?us-ascii?Q?lIwK+/H9+2NDLMgqCDDR3pGDHlA/TMk3WDUC7O2IR5PWDaCZfCVHVjLOixU1?=
 =?us-ascii?Q?hfJCurXkDRxUpM1YGxBvfkW6G0Fv0vfKbdshswpvnYALjqziBRi7NIHoutDy?=
 =?us-ascii?Q?oLooWAJeacoFUjphUyWHALh/SmImL6GLeBuZcWHYEjipO4EL7yokZ7mEGKSk?=
 =?us-ascii?Q?5miWyKNAbaXt8WZgWMjnh4JcSAy7hJJjnvNmlecS936C8AibpsHFiyxyVCNb?=
 =?us-ascii?Q?37moH1WlDZd2IRHdFw+uF4Pf4uveBU9p4XpACvEWm6CRs0pUTEHaXOmFHkGX?=
 =?us-ascii?Q?TCi17B0KTc01TQ1lhgnK9zIrur/QFVuzvA+zEqAhM324HXpTVPzgdIijyuO4?=
 =?us-ascii?Q?/DNHVV5EFzG9Hi+QW4vk0fmKvfTL5E2FEzZ6fcrzofduIqFs9CqJ7kxs1/c9?=
 =?us-ascii?Q?ITB0Nt85eGnjwoYoUMvbLDvoEaolOodgt+i1wB3v/RWOdvaorRN8kWzrWTjN?=
 =?us-ascii?Q?Qol+scWMONXHWk66SfDGOqnNeuJYVOIot9qs4S6p31u6hbqRzs01Qf6te67+?=
 =?us-ascii?Q?iZEPGxKXrIYAIVqxssQ9751/R2Fg55tSxb+vYpcVwspHBNkuo7HSqFsGZybf?=
 =?us-ascii?Q?2DeWIhFs2C9kp63wco/vSSO2bCYejthmXOW9gTFwT1t6bAMoX89KpGwdiIr8?=
 =?us-ascii?Q?5kRPrW431kcnaWCpu5ltgZ0DP1KnGBoB8sSFTRV8xCKJXpan/Nztbsyj9yUZ?=
 =?us-ascii?Q?+LD0Zx8xND4thNPKMtVg9aAbmw9/kNoqAVJ06CbseJ5ZJEqi6m+AY+kchsLt?=
 =?us-ascii?Q?MuINBto71C9+VGeuEILS5Lu8qyWT7bwDRgq61wFau1oi5iXstw11TeeZy5UC?=
 =?us-ascii?Q?r6vZ0tkTsnk4KQBZnlkDIU54AWft/Rc1fPDgv67xp6ywRRnS5OVY3uxlcp/t?=
 =?us-ascii?Q?f752x8O8bqTR3H/R7pXN1yxYONQQb9s5HY13GtO6Zhc4A6RGTLSPjlqw3leJ?=
 =?us-ascii?Q?6H44e2bLdhFIBw766/1UCbD7PAWpe2ScBW8c8tQPV6o2YqqHYOn9oQT9sGZb?=
 =?us-ascii?Q?H0cXZ89JonGILmiAbcjNxp8kGInKSK8Zz+EcWRF7K8BYsmMP1haAsYoi9uP6?=
 =?us-ascii?Q?SJt9poOhjNaa2ynNELGSeL3Du460LQ2H3He+hElyBGjPMyBItVOtGba6UiIg?=
 =?us-ascii?Q?WGGIMDdrQCQQsj2p96+tZyW5iz7f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wp+SjrLLEaVwe/3I/Os+Ll87c6dkVDWcZeShfG/rspEC2liNOnHqAiIlNrvQ?=
 =?us-ascii?Q?W59hRyC8JdsoGVWRTDzMMVXrd6NPJy+8CNcFUXHNrsCBl7j/e/O0U+yZdRWf?=
 =?us-ascii?Q?dSZniNSF24e04VUGPNBW4XcDseuRzD4qTYYfg8LcAouwT4MGwDDQksvWxs8e?=
 =?us-ascii?Q?oa/p1tq9S5kX/Vvuf+EM70QV9WZqAA5J8sS/IRV4wUT7x0m631e4Jzo/Wate?=
 =?us-ascii?Q?B/O9nUJNyHASMGhD2ZaobvhcYqIdNibzuyxNclEPH8t7D4NFyL2Tf1rP4/hv?=
 =?us-ascii?Q?zBDolGj/gjCeW856grEfjlsogQpemlxTlt39YJSKEPh/ZGvuhmwSMeFiF0Rz?=
 =?us-ascii?Q?IzlH0UOnJmw/WTIy9bFZwTDcQlIxt2XG6Cp+BZMRguAklFPJ4ioOesxD0sXP?=
 =?us-ascii?Q?g+NTRbLNj9Bm68gtCT3Pk95OCY5T/JmX9Qk4REeLG7PINga3++p0asJ6+zB0?=
 =?us-ascii?Q?L+e9SbhZhQbLFUBy9fiaVRGXD1LQ45lfEKSK91McnJCvWYlZv+b/aBydAB6B?=
 =?us-ascii?Q?78go0vwxSRmUCdLQx3IU+YP5Sg1TzsMuvpUI6wNtYz+TXPHYUFerJA3a2XnU?=
 =?us-ascii?Q?sXL0UulgpaYaRM/MpojkPI8m01FiueeqhKKJYb3KufSci3J50ZtMXV6Ropvd?=
 =?us-ascii?Q?q/rhjon1qXOEISSUUG0+y/OXbzVw26lhOk310JGAKrGSJxBUY73kV9d7+LEd?=
 =?us-ascii?Q?1AMhpuNQWZgHld78O7Y5uuC9zqL59latKQQlnhdE9KJtRmjcrGPBQ7fllwm9?=
 =?us-ascii?Q?XdBDVcPj1FGxuz1qhw0/nPZaeKkHAHvx/bd3e+XHjtxzpKt3ewmACcd9N3+R?=
 =?us-ascii?Q?YOtz8tQ/4EJyAVADD628pmI4fD3XIReNyxdb60FsYiG5MA1P1eJ5RJ+/55Iu?=
 =?us-ascii?Q?1GI+HNW47V+xJK9gWKiQOypmss1KoEMvq7Cg4JzxMaez+EzsYT1R0gTY6sHB?=
 =?us-ascii?Q?6tBW+T6q1pUmOQYR4DFUFee5da2PzoNaa8EGRX5GKDGLegZZLG19EkRIqMmz?=
 =?us-ascii?Q?oIcqhbuGAyGeMaIePQkNJmglIheMJL3QOGlwDMG26DcwtI8zy9Lp715W9LDA?=
 =?us-ascii?Q?HPHZz7PGti6YiCeZbw+ccnVje0zDz8xTPL8xlKwjxvg0YyQLdBCBfrhA1lmc?=
 =?us-ascii?Q?ZMMz1/5UNPX3Qk0U+ZIN5lPxIW3JhrhH082+eSDf9+gIed8UWJjG7VggJP8J?=
 =?us-ascii?Q?kvfSIWtIZlFTWZ22GfRMWwaudwiuU7Bwg/28VhE7V71o+Fx2JhANjxDd1Eg7?=
 =?us-ascii?Q?UOpr19elBGAyVRsQ7QT7ISZAxwW40Tk7P4w//pYj1VIhvyxVELDTrwqZgYAg?=
 =?us-ascii?Q?5AKRtDG2Bx+E5+pMdJwloQiya5dcoce+R9YkcItEw6aPsFtOx3E2vJi93RHi?=
 =?us-ascii?Q?9wEDNWdDrWFEMN6yw4APyV8TSZbOTmZZRrGz+xMYo6DNTY63sa8fEJIOetWq?=
 =?us-ascii?Q?qbgUh+8aDihbn+IC1yTeukJPxTDv5+eTd/IYxtD/ZoMMKmw/xZaHKhCVG4JK?=
 =?us-ascii?Q?lLR9eThsvr9FvnzcybrXmzUlvLW2g66KWO4X6rFgunCQmrqzvLSJo0NxBefg?=
 =?us-ascii?Q?ai9pSsh4PK/4Yhq5pSjY3YLtgAUbNE8VpKYr2aGnGC/BTj5A2gPQCM6U8x6q?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3350a1b7-e478-4239-419d-08dd51c648cd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:50:22.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRDPscQYru98jvkR8ymB8ROnmKgtNQn+LPaWll8z+L4mnSX+EHs/jAY20TEpmXWWkj0WMnkByl4ezAQBwvVHcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10146

On Wed, Feb 19, 2025 at 01:42:43PM +0800, Wei Fang wrote:
> There is an issue with one-step timestamp based on UDP/IP. The peer will
> discard the sync packet because of the wrong UDP checksum. For ENETC v1,
> the software needs to update the UDP checksum when updating the
> originTimestamp field, so that the hardware can correctly update the UDP
> checksum when updating the correction field. Otherwise, the UDP checksum
> in the sync packet will be wrong.
> 
> Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Really good catch!

