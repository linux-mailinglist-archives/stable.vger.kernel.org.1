Return-Path: <stable+bounces-118476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C54A3E0F1
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601E53AEDF0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803AA20D4EA;
	Thu, 20 Feb 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nRBKXTyg"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F11D63D8;
	Thu, 20 Feb 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069155; cv=fail; b=oQaumhoICq5AamizR2VGTWMJo1C8J9efdktvLXKgUpq/H3R7Cyi31xFgfBMHtrPeOYeaLGvVkMr0TuiKsT8WRfAyUUa93Rz37ZP5uiZyYA1gykrtbiKQI13UdJnZ2dN8CNlTBhMLp7unnXYbbTQRx/M2FGZff/x6LuVfA0j1q7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069155; c=relaxed/simple;
	bh=FJqoSyCdP5biyzxdGoeldJgZaiuhZhucmWUkNpT4dfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WCWii5F+C64BqmFSSLWeCANh7tYsq5BroOl/dA0rTmyEkSe/B1/YPcrGwqGth7AHnH7whU55rIi8d7s/fN7yEQSJBKpgfSS0niC1PATzrXSWUIaLO4AhloXSbWqm431nLeCOg4cO19aJNeIMs/OSIbfUV775Ye20WS5PUD2D8HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nRBKXTyg; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx5dNwdcJG2pfIV2tUantqGSVRl1cg5mzbp9lichg+5cC1n3n1G2iiAkKo3OxvG+V3EEOJTgBdY//B1xVDrVH0XP5rvikVxWtYLPVOCaYMtdrXupp5PFdaNDCR9HAQVOPdf1qU2KvQX6pg071gtB07cxoENxIQ++jhB91dF3obmwqq7oIAPF8ZlejjqVwiv1d8xeL8Hbx2MxcXPlrAdwR6ejKDfa6k2nxeGgKeHBBo/ntN0YxzFoHxzlX/YSSyh69oEeRDi1HF+kxw5DuQPUpvp1G/3lzn8SoDOtj6O31qeBale2c6SMz+ToKd7b8Byhu5PKBsCeZZEstApZtJDhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWnLHvMVXEK+cz2QZ/pkFZC0hGOaFdtpRE0+6rlxhPE=;
 b=TrBtPlW8nMe8gEsnSHXCe5Y5CYXwXXS5j+SKLnqd8rNt0L/sxHq4lkBnP/bdQHsv4Cc07lZ9ewKUdaFPui+xtFeff+1yoLsCvz1+0aQmx7OxxPLwJLVhSfv2xBm0fu7XxSmb2Rom9xXRSTo/EsEfP/DLchhOb8g1+aGXhKamoGB8ta4m+vsIVgrqASnCYTV5p+cG9bglE7n3eYDlWmv0+yOX9cKBQPz5/5v78lSqjLCmT6otbsrU1i6gLheCxsKL7IUmOI/pO3vHSRQGqdlUB2FzNkNW2un8pQPTAgVdudH8hb+19L08w6zyJlcqzLeGi/fPoMrqwPjmeGkUxAyxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWnLHvMVXEK+cz2QZ/pkFZC0hGOaFdtpRE0+6rlxhPE=;
 b=nRBKXTygsG97eDbKbPQquv8wQj6a38tt4JtuuKXxhMJas76k3++cF9ccySB4nSUG3JdwOsXGuylQE7xoYprBUy726QXZ2ff327ZAmz0li16cFIyp1Pa86mhUtR1nVL37dvCHXWC8zMG9F2ImgpYV00WjVDXyR839kYgGc+ux1wUGvC6TzqCVZWt2r+SxRiUyzBwzbPjJWeh3wGLC/M3rBaO8JQnb5E6yIohtOH5mOSkkBz7LRitAaojz+r1y+Akm2neW0Kxm2nTgi/xAE4iNH1I+xIqY0NUQjJFw9VBdf8NZKyX61VDTtd9+1SoXdH67pkaCw3bCWapj69bS/HOg+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:32:30 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:32:29 +0000
Date: Thu, 20 Feb 2025 18:32:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Message-ID: <20250220163226.42wlaewgfueeezj3@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
X-ClientProxiedBy: BEXP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::28)
 To PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d58db83-79c7-4901-8d73-08dd51cc2ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtlPq3hf1C7S5aiOyG5VTKDtsfXXsfaAp8Qtg8E23AVBDW1KbXV/+DD4ew26?=
 =?us-ascii?Q?XjAA71rriPBBh5JDwo6dgWgBW5Sh6EQ1vWjNB5Ywl/wYovmgyQg+x38irbht?=
 =?us-ascii?Q?sdEeMOIvcjXDxiNB9WsTRPMvZEBOF96TACprvn3+UVvzjFsDApKYz/A5ospX?=
 =?us-ascii?Q?9AofFPD5BKgXYKZQ50W2pEJYsh+IYp6pjCtPdvoFdSRlnAOxw9lLyt8Giq/d?=
 =?us-ascii?Q?WkASENlzQJQ4reD/WqbcGc0IJ5hMcag6Vvhipxy/4W9sOOgXjoiQWFRm61mI?=
 =?us-ascii?Q?qzVFELDSRiubi4G+sL8efHeEozgwo2gr5Y0WMWBxPp6ZeCc50GuGYpAVPIO1?=
 =?us-ascii?Q?9v467rMFlpHht6GBD//aBHxTg11O/BV1Ry6x6Owfq9ogzFIOuyGfY4pln81d?=
 =?us-ascii?Q?ln8qX/EcSl9b+B1tIOxgBWm8azssSn7yB0xeVfaocbCAsn99JeEjkf0/W07N?=
 =?us-ascii?Q?eHfToUBA86wV1ZK5xS4H30AU/XJ+7MRo3Lam7HKJZcX+YEF9RJt1WA8rh3zx?=
 =?us-ascii?Q?Pn+LuiF3ZlR8uHHaexFjARum31tU1yOppmY19J12puspSeCmPj/JC21BYRDE?=
 =?us-ascii?Q?IrphjkgSM3SFlvYyc+vcWHI91n6nAnNR/SAa8fBOohN+ShxEqxoIO/eIiyqk?=
 =?us-ascii?Q?clYO9ZU+1BVmgSRBqgeOGvgy0uqSdxPNntJAkcWl1x2r5i8Xv2rdHIVHjvG2?=
 =?us-ascii?Q?SMFGAEN+O1cHQsqqQPZGFDfZQbFvfHpFy/bQxpzZzZZTIEu2JqHPtmcvEzun?=
 =?us-ascii?Q?LG8+rzQ3t7wLLu/PlPUv7RiPVE7imA+xe0HDerRQUSBJFPkkv7PERcYbePTK?=
 =?us-ascii?Q?YCzsPnB/a0jHFm4VPYdX7WtH3ECK7YOp1uL53sGdB68aqbAQICVjdBFB5LWE?=
 =?us-ascii?Q?4E9rDI6XceJ/DUH1ZCcZfTGfWEvDAjQ0t2cNdm5bZGD6cU/2NEcBJ5RsVmcb?=
 =?us-ascii?Q?dMnePPp1ZL5dHKt52HPQQwYlYuQHCcxttZPT/ZmHuM5eSuGIBj3dXy8g4Pn8?=
 =?us-ascii?Q?WkG2WWXn6idyDgBqciyyT9elBwkB5E49ZEYPXJDnvWr1M+RCb2CDgSbX6C7a?=
 =?us-ascii?Q?Q0r9P/FCLKq4j2Gzvu2/iMs89aZCkdtfJ9VNjl32sWm3k6n1TOqxXnLAAzWP?=
 =?us-ascii?Q?rMfuIHQTaq/LvA6WZoTbY1LURvgni/AG5BtruixRTPFdfjKPulPvOAlTObYS?=
 =?us-ascii?Q?vCpWnEhBHJ+bKev1ifk4xDxu55fL3/gB7wQ1H44lBMa5QzGTH6y/Opibv3pq?=
 =?us-ascii?Q?ZIQVf4DBx+kyQx7K8+Ra3sCE4dya9eaSA+JGfWsysHTJV+7uLx7yZtxMAcQE?=
 =?us-ascii?Q?4pW7u9TH9irMIt6AFKX3U+EdDuaSu+aj8RcJpqxwKlMsUKXSIviw30DOpCpR?=
 =?us-ascii?Q?k8nj/z7F73InbmdTTMpKUOSNV+Nn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6kmQAr1Sq4DPtoACzbElckiVE3dKXWZH3sCPS33smibm9LGWR63hQ0snnBw?=
 =?us-ascii?Q?pZedVX5oyRKmxI/ZJens5UYxKcxcuhp9VmUDsZkG+p3JlgYI6MeH8PwdRZ/6?=
 =?us-ascii?Q?MJluMjHdb6BnOSUHUNhGiZTBlN4OqgVDEN9bVbYDBdYCn+GW2rmUSR0KEcSp?=
 =?us-ascii?Q?2KY0KMo+Icbgv8/Zb+LLIbraph2ofqLxDVTleKT5829ssMphBLOsjIfKB7AW?=
 =?us-ascii?Q?UIEccPIs8DTPQ3RTyyqpm6OiiWfcr3rXKrEeX1JQhgu4oX9R4a0QEUaDLLv3?=
 =?us-ascii?Q?Mwa8EIGHYEt1Lg7th2c1NnhkOZWG8ehGe8+n1tU4Vxk5hYjXzWwifm7a64U6?=
 =?us-ascii?Q?/4bMDxbMxYSaRbSmhoDztAD5kGNMfaBuE4oVfTA87NVzJrRdZAYO0ZKTWvoa?=
 =?us-ascii?Q?PfZKThvQyVDXhTju3RBUObNinQ9phl+5imxVQ1wmjBRT4AdH9BzhVwoFyvc2?=
 =?us-ascii?Q?zALolHgRFTDZDHvjR72tgYXrWIDSxE8sipNBUs1uXnMQZkks3tyfyflCPnhO?=
 =?us-ascii?Q?0VzigKYws5i8d+tBikhUMoa8qY7uB3DLXUk38j2SVqLFSQPIK33l8eh+iWy/?=
 =?us-ascii?Q?GK2BDSmmPQlvQC1Dj06x55vJu3w9uoUMqHSAtFvPNZoplDUMENr9IUvZo5eS?=
 =?us-ascii?Q?PWtV4PfOiU4MZLdgGp5BDeMBBEcT0JKG4aNsgK/bWVSbVQuSq2mdmXF1+w6M?=
 =?us-ascii?Q?6ophmPUUjTSImeU+L4Nk3lUWRk3ruR89CrfI3NJyGJJ/g/ZK2goZU1/NNGZz?=
 =?us-ascii?Q?CgAf4vYE1vFafcOdybfbqcYxrf/ZMvpwB7/cRfKyjw38gyakWmASSoemRGdY?=
 =?us-ascii?Q?XeUB0dBMCmB/oLwWdvBGWSlngDt3YhYczYSezOG5yokjfGfq8g7QEOCG02s6?=
 =?us-ascii?Q?mdVaauQWThmkbkUpsuujzOaW+6Uz2vZqCwB4bFL6X1UwHQXrgXXi3EpTo3dx?=
 =?us-ascii?Q?wQUl526zmz0LYgmyLtBLGQZ2djiJLwwKw/sbG8JbQZ4erhwSPJjB1hcwdcKr?=
 =?us-ascii?Q?xRAx+BgveprRNu4rhsiWQtX2kmtepZoUQ8Xl5bDAhCNxjfsmHNaHe7Yyy2Yg?=
 =?us-ascii?Q?kdOsF/nxleYskCBCk+WEyAQ1Bv9q6sb3cUzb0aGaM14Zhb4YmKkb32YQ3XvX?=
 =?us-ascii?Q?Y6ONJziG4LFmv4itWfXBVOYDS+mm1O87l0B9sOykSqSc6TQ8HI9YxNytviOC?=
 =?us-ascii?Q?A//IrxsvWuY6v1gq1VfxgwUt1dq33UlDg7Uahd1M15YbbneiHPs2bWyEHjM/?=
 =?us-ascii?Q?rSFZx7ZqkD7EP8BiuUblUrWwE7rWkyarhJKJ8UC/3KFHS0mCWCE+7FDDxmmN?=
 =?us-ascii?Q?IMQHATyPJb5o11JdDosk6+34I5NvRwoDaX8SQeiWCFa6kh5duJ4GlFFNOAHP?=
 =?us-ascii?Q?yVAgbicRHJa+My6TbU4DxXLeMZH0pTmuHuNDp4GAsgm/+YsiMgmL6D9dNLkl?=
 =?us-ascii?Q?XkcYu6Kd39E6jRC/df70yQq1TxFbYlgFP7TpnuDK2MqgShqepGhzXlW8O2SV?=
 =?us-ascii?Q?IsYpyxYz5KEGYBQqOQTye1tk1F57UnrNddS/vG1Q73G07n0AWNzJ28A/loFo?=
 =?us-ascii?Q?NgHQVHxQd23pPbYw8J8l4YvQXEmJbSbkqyLvRS/qVassH9+41tU7amF5JUZU?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d58db83-79c7-4901-8d73-08dd51cc2ac5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:32:29.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsT4BOTTycEipey5U+ttueUoPNuP72+Wi0GYTzFinolQXJp3KsOPrh4gX4H2VDXVnI1fOGeMiQYKbgf4yqlkqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756

On Wed, Feb 19, 2025 at 01:42:47PM +0800, Wei Fang wrote:
> There is an off-by-one issue for the err_chained_bd path, it will free
> one more tx_swbd than expected. But there is no such issue for the
> err_map_data path.

It's clear that one of err_chained_bd or err_map_data is wrong, because
they operate with a different "count" but same "i". But how did you
determine which one is wrong? Is it based on static analysis? Because I
think the other one is wrong, more below.

> To fix this off-by-one issue and make the two error
> handling consistent, the loop condition of error handling is modified
> and the 'count++' operation is moved before enetc_map_tx_tso_data().
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 9a24d1176479..fe3967268a19 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  			txbd = ENETC_TXBD(*tx_ring, i);
>  			tx_swbd = &tx_ring->tx_swbd[i];
>  			prefetchw(txbd);
> +			count++;
>  
>  			/* Compute the checksum over this segment of data and
>  			 * add it to the csum already computed (over the L4
> @@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  				goto err_map_data;
>  
>  			data_len -= size;
> -			count++;
>  			bd_data_num++;
>  			tso_build_data(skb, &tso, size);
>  
> @@ -874,13 +874,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  	dev_err(tx_ring->dev, "DMA map error");
>  
>  err_chained_bd:
> -	do {
> +	while (count--) {
>  		tx_swbd = &tx_ring->tx_swbd[i];
>  		enetc_free_tx_frame(tx_ring, tx_swbd);
>  		if (i == 0)
>  			i = tx_ring->bd_count;
>  		i--;
> -	} while (count--);
> +	}
>  
>  	return 0;
>  }

ah, there you go, here's the 3rd instance of TX DMA buffer unmapping :-/

Forget what I said in reply to patch 1/9 about having common code later.
After going through the whole set and now seeing this, I now think it's
better that you create the helper now, and consolidate the 2 instances
you touch anyway. Later you can make enetc_lso_hw_offload() reuse this
helper in net-next.

It should be something like this in the end (sorry, just 1 squashed diff):

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6178157611db..a70e92dcbe2c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -106,6 +106,24 @@ static void enetc_free_tx_frame(struct enetc_bdr *tx_ring,
 	}
 }
 
+/**
+ * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer TX frame
+ * @tx_ring: Pointer to the TX ring on which the buffer descriptors are located
+ * @count: Number of TX buffer descriptors which need to be unmapped
+ * @i: Index of the last successfully mapped TX buffer descriptor
+ */
+static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
+{
+	while (count--) {
+		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	}
+}
+
 /* Let H/W know BD ring has been updated */
 static void enetc_update_tx_ring_tail(struct enetc_bdr *tx_ring)
 {
@@ -399,13 +417,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	while (count--) {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	}
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
@@ -752,7 +764,6 @@ static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 
 static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
-	struct enetc_tx_swbd *tx_swbd;
 	struct enetc_lso_t lso = {0};
 	int err, i, count = 0;
 
@@ -776,13 +787,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	return count;
 
 dma_err:
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (--count);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
@@ -877,13 +882,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	while (count--) {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	}
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }

With the definitions laid out explicitly in a kernel-doc, doesn't the
rest of the patch look a bit wrong? Why would you increment "count"
before enetc_map_tx_tso_data() succeeds? Why isn't the problem that "i"
needs to be rolled back on enetc_map_tx_tso_data() failure instead?

