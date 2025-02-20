Return-Path: <stable+bounces-118487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF44A3E1AF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD15703A33
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1221323F;
	Thu, 20 Feb 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oLqcwNdH"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821E1DFD85;
	Thu, 20 Feb 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070340; cv=fail; b=UfSzpuGEYineQ9CFG2R1uNvzR7yb2FOoxMjcwy9GPcZVbbjFqtx8GDkFOa6jO++KveKNKSUDFE4aowSPKghouUU016kK6gRfWdXjX1XAh6N/AZ5WVbr9551hl6vWK3hA4sCA69+smzdr+C1ce1QqLW/JojaYTakeNkHUpMiBwUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070340; c=relaxed/simple;
	bh=j9Zkz9cxOPOdDd/tPlAlLykBapflHDmnQMXOeinYhHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NanibSsYKP/Ccnvc271gkhgk3AiD28+ras24v6Em1sdFvnpvGpAFHsNgrou8M7dE8AsVyWfWhG0D27WFaMIWyH8DN40j2S3Xv1S5X2HoJwRMKmsBKI7wc/MJFfwE1UwaUxQLCXdD9AAcSFD7NTpqXtYFL+wG0QVf1q1Ygr3GGBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oLqcwNdH; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBps6Sm6JG3UBa7kuQyFOEDHdeY/2nRgDG9UZ3VIkZLpIbzzLxdBK/9gqZmRZdh3EucPVkoWd0aDlRfxijWY3SUgHTm/J5MgPKZ0dD1qn2V8+ebMTdUU8SQWeUIbt5Vys5n/w1+GV7qRPwZZcGgVeTtQFZkd46aZC+5EjLzpHBr6SWoPxoB1pQ6WWJ/U6RzWWfG+1IHztJU2pV64oAl4T7+TwBNEtsLmTpR56Xt6f3bAUVl+qa8ry+A2UOUpu8bLBS/81Hs+48ru5XiWVjWxjaSIucKtviuGxl3f4+yhk8ekkv2c0lygTAcdUr2FqHtCD8cCkuAQCgTTnPFrbthLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyfgej2zbVB8WXfQRE7QNhLydiqWwFsMYCl7Zdpav2k=;
 b=Hx9MshiR/S7vjqk80jo3f30oDmST6w1GqA2ezPrayQhcy4m8QMiNI8frGy5hWGEYk3YGCYB/ZniBEBMaiWDqy6gO+1x72c/WXzGfn+k+ceVx8cwoTLoAVec0HKlErJzZdmI9PVCekqV0GfOnyFVfVqnUwH08M7YUTeV1ztlkwOD1MIF1sU8y627sQRTLYMlaEBwLbmFLz+NHxz61jfQ/lX7zj60B1MvFQkjjYFWpPRJKT7p2Fq2wXgSt+pxxQURLjPkVRBFjyEE0jq8q9fGYQbeTNoyxfbE6BAU6a2q6Cm1YIZJudj3ZxOANzX9qC9p5fVRHihKHRDu4mJwN4o0tPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyfgej2zbVB8WXfQRE7QNhLydiqWwFsMYCl7Zdpav2k=;
 b=oLqcwNdH085cvZ3hw3jDk1SOwggYyvkMEcsXpEYO8yVhzUwUCVoXgGnLOU7XezSqSTxS3JcFa5piGcFlHVsDK9wbpUWQGQey/WW+Zub897eNt8nzbWPZzZEFphdHwj6G+rRXNYJPOnYyOgGREt+D4uVSy+rG174/4GvvyI+zb/meXJ/1bDzMyx4Bmlbxg8NiPh1yrzHTAeKgrJFz6scIfSz9WIPAVAfqt6PJPxNehToolq89K7oXNmrHMUqkOP2nb1xcOjDCKrQ2kttnRHmaVFxais85j/wCAsRZAyiaapamC/BMR4mmDhtGude6I4lpYxjnGgQy0z9eAhVApC+nGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV1PR04MB10200.eurprd04.prod.outlook.com (2603:10a6:150:1ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 16:52:15 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:52:15 +0000
Date: Thu, 20 Feb 2025 18:52:12 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 4/9] net: enetc: VFs do not support
 HWTSTAMP_TX_ONESTEP_SYNC
Message-ID: <20250220165212.62bs6p6tzl33tc24@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-5-wei.fang@nxp.com>
 <20250219054247.733243-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-5-wei.fang@nxp.com>
 <20250219054247.733243-5-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::10) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV1PR04MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c76d31-9cf2-4230-ad56-08dd51ceede7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n222nNVGVuxdj4Cb2LPHE+OYBl9O2FldxUhMJR2X6NrtPLlLQqJ7T7MJIVvv?=
 =?us-ascii?Q?/LT3uj1ILdrYIhT648k8nM2QGjDUZAb9hArKN1JHw/mZjmGr50a1Ld3telYc?=
 =?us-ascii?Q?mMelT5H7ibGs3jmXD+LiUFtxrlTri9ewzEtpk0rVIs3thiH6uXWD0/asoTGo?=
 =?us-ascii?Q?KRRpazAIXuztxwLoeYbCzVtOgNBx7rrBLWJZkVXXlAM6na6P0WAcbyLa+nbZ?=
 =?us-ascii?Q?fwUBDuIyf7NkYWmG1Fk7nYjChjj/Dmw/cz46jpEAjWx1Lpe8EH/baDct8nAN?=
 =?us-ascii?Q?4bA1Z+iUbrKemsES2NFWdGWTPcKa33P52COGy4kKmXU9Mbz8ka+ZQQsPuf8l?=
 =?us-ascii?Q?7QrnVBBbyyRm5C777EGdr2flkBIjMj5e3Cbti1nWvRvahtfafXK5/dqfsSpd?=
 =?us-ascii?Q?A8oWRaEsj2rgx2/g3Udt4zGlN07naUCqWqYi5WGQunZhLZCGazIyD5lCJ8do?=
 =?us-ascii?Q?l1k+pdnRZ1/z1A9F5MSPrTMeE8J+V4whe2ypH0rOtshbCb8jEkv+UrHYqVvb?=
 =?us-ascii?Q?wPkE4Iq8CsBerNy2/Z8cTOlINe2Ff8C49tGg1omFdIDoRsUvpHnxBQPMPgNF?=
 =?us-ascii?Q?PpigK7DuComIw+ZWd5yq+ZbCQl4MJYkTn2GApybg5V0y7/dHiyigsu+FRkxt?=
 =?us-ascii?Q?48Mt9TbjOHe/771xOdlcUvD72WnDbr6XKJZ/+Cg5FGcriw5OO4F97fBaljwL?=
 =?us-ascii?Q?jsml09vUmz4JT91Kuu/LjRrNyxycfDy615hLVQ071Oqb9bmuH8R48fdOG+SR?=
 =?us-ascii?Q?YGzbRh6T96kTEqmfJpUHtU2i73l5lJorc7XGlxZM+mBDLhOJCOyFf1DQLoks?=
 =?us-ascii?Q?EI8YemAF7lYwM64LDRWKW0mJ2Z4bRBE4aR+lnyCXKp6mIp2oq1bIDyKdL7CX?=
 =?us-ascii?Q?pfSC8Pq4VvicbaLySnDvbjzmnd0tMC4Zr8kKyUXxKWj8OECDmO7zJgNyJzzl?=
 =?us-ascii?Q?s3GNyMCHiqSvY7ij7SVQxlwI2m9CPubIoxpQHlBgdX6li2xK9gZByuZqRjoK?=
 =?us-ascii?Q?YGGsUonIwhuXvRAKmVy+4IsNhWeyT8OQfcUN9EC68vfSxNBpInDIuTxwap6Z?=
 =?us-ascii?Q?Ac+Jo5zzLzCxPSOqaa73xx9Ljd0Ryuxv8w/2ZHEE9a3g2YHYoX5Kaqa3i8Ac?=
 =?us-ascii?Q?m5AoWToIyZ1VJj4+46Xnf1HaKjMAoQbZyFFQEUZlWhGPjhM3EMrk57yD/eqL?=
 =?us-ascii?Q?YzpY104D0ri3RybvUNatAC9Laprt0EtP9Lmn4BtU7kmP4cdgWox/srMbHdv0?=
 =?us-ascii?Q?TZMSieBg5OxNLXGb8VnSoK7SjalhvxnrkznW5AiKdSsEy1/UUl623VChV0IX?=
 =?us-ascii?Q?U4TcUsUy7BOlUzf6W6hTeOx6M0r8ntPg1hSPSzs+f2ibZOW9m+fr7NdLOq8S?=
 =?us-ascii?Q?ggAsfZ5jJpzJeeKvefs7HdWg5/JV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYvrLvLMxkGbv1b4lHqpR4tClzmI/ow3V79ILXhl9+VzmiiKPpKDVAbD+prt?=
 =?us-ascii?Q?NXTb2FpN7KYRGtbB+VPukCmOA9pkes7Cg/zt7Q7TLIWfVXkJuFXvbY8DETR1?=
 =?us-ascii?Q?IrSAPFsIUpTu8kV+EQteQ67XX4umsYNRict8u9AWyleYHgTSYwGJTjJVmoZo?=
 =?us-ascii?Q?Zl70vgqPy8ZE5rRB5d+HU41P+9m270ncomUkzhojGUaFHuUgjK49oO2+Cb2W?=
 =?us-ascii?Q?IawOv1ELjxBSAsrDGtXOfvR4lH594OqsuZoz4SmnbzcdpXUVcHq6gf85k14z?=
 =?us-ascii?Q?BGxGqS+Ll4Q8JO4H2fZmdjKfMYfaevLX7fuJvdqshEj7gZzcTm4cMh9ZEspe?=
 =?us-ascii?Q?md1n8f1iEOYIvJWDRaIOale8KPFOZlbTgtJhVBa6qPtq0hZOybHjp7DFOgnH?=
 =?us-ascii?Q?j7/cYLvnipPiWCb5Fq+vy1oSVgZENXgbjuLP8d5s88UXf/kN3YDI/AEHbbUH?=
 =?us-ascii?Q?dhRCqAj9d03EiwoblcwV189Y0cBvOtCDmqLxoSkOeL2XB4RCse94p3sPeRbi?=
 =?us-ascii?Q?mxjcj1+5gy6afTQMJZPjzTl/Y/1dcSgD9ERNe3641q0MrrWQdlZoCsAaiyFT?=
 =?us-ascii?Q?ljpT/WTGVFiIoCQP2oQL1UNZrrGz52SyMcAclpmc2klPNZsD3z7bSKuPZfBq?=
 =?us-ascii?Q?ZSLLI78pAfbeZoWO75IpkO9RzSXMsYFL0XJXMjSISV6Mo3B5Ey/CK64B6rPi?=
 =?us-ascii?Q?Gczop4uzRmDi0LaDiQdgiYKMyUkwNUPjs+ievMFasUsZl87zvsL3/XlUFqnG?=
 =?us-ascii?Q?4pZEGQ/cCJDt/LrkxLHCsMFnYh3OcYBrmncrynO28GPnAf+Jg9oby8lcRdT5?=
 =?us-ascii?Q?UqvMa0yxrA8hooy53Y18xs9rqmAvICnLXAKOLoQ/foK3g0DrSsZLOu2Ps1Tx?=
 =?us-ascii?Q?+V1XVV6e7BMyK7vZwnHCmr4cZGAXS9havoKyZn0tqgwvm9a1qGVKgsoWkw2q?=
 =?us-ascii?Q?QQuBIdJFw5WNp7D7kv9vb2kfgHpPQ0fOKLrkautMXOTJAeY2Gmdg4GLRqYFm?=
 =?us-ascii?Q?BYDjJzyUW2WXd/Il/vixDzwSdyStoIaBV6TbXfpN+YvF3LCgnYyJ/5dO8TiA?=
 =?us-ascii?Q?I/je/Rzfav6xKadfI00gSqfgs6cfM11Kv1d7kpREAwQppycfEjYVifL0Oent?=
 =?us-ascii?Q?OFbKkI0It5b4BuatusjWjhiXCdudBfs5D8UiSpA7BJ2c6xWqfnlkVStgrbQY?=
 =?us-ascii?Q?eA3H277ny0+pmUWjTuumXsaKrtyCDe+RucE7j3tlnrfXGBdko8mEnEbXX7ov?=
 =?us-ascii?Q?Tdju1D3sU1MNEloHiwYP5CJ3/DnL1F23Uqud4QzBcpLGemf70rjSO1lweLOG?=
 =?us-ascii?Q?osW7En7lUu00o5o6bWqWuGZkM7Ws/m92xIMYWIlQ3mWX0hgKSqrLkmGEXiUw?=
 =?us-ascii?Q?FxOSV+EhMEOYV+0LvRsNA4asH6VTHvkYwQQ8vk0CyF99N0rErpxu+rURIFdT?=
 =?us-ascii?Q?r5ebODjSGdltfxpgLekUSugTjD9BgEOYRItZ+070A7xdJwopptaSgiFw51o4?=
 =?us-ascii?Q?IgMzR/GSiq57DjckD5fdXxWAaegLm94DxVcDFQ8hdfkVYSmr2Oeq5w7uMwLR?=
 =?us-ascii?Q?CLqIxGSwFPlnPz5zCIIFOAdPdBWQKM0xR7wcVgrLZdaWbF73Hk9o7XfGu5V7?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c76d31-9cf2-4230-ad56-08dd51ceede7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:52:15.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYJAa6PMswdzRkz+N5e9Ii1+zta8cUBpmQuFcY+4AoitYPGaD9Mr89ptDwbZlH9cNg4XblPkPPD6R8Es80xojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10200

On Wed, Feb 19, 2025 at 01:42:42PM +0800, Wei Fang wrote:
> Actually ENETC VFs do not support HWTSTAMP_TX_ONESTEP_SYNC because only
> ENETC PF can access PMa_SINGLE_STEP registers. And there will be a crash
> if VFs are used to test one-step timestamp, the crash log as follows.
> 
> [  129.110909] Unable to handle kernel paging request at virtual address 00000000000080c0
> [  129.287769] Call trace:
> [  129.290219]  enetc_port_mac_wr+0x30/0xec (P)
> [  129.294504]  enetc_start_xmit+0xda4/0xe74
> [  129.298525]  enetc_xmit+0x70/0xec
> [  129.301848]  dev_hard_start_xmit+0x98/0x118
> 
> Fixes: 41514737ecaa ("enetc: add get_ts_info interface for ethtool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

