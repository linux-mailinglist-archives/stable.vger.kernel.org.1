Return-Path: <stable+bounces-118466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BD9A3DFB8
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB751889F66
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E60120E01A;
	Thu, 20 Feb 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UfTDPJ6q"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC920C024;
	Thu, 20 Feb 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067291; cv=fail; b=cGQsa73Ytf7tkV/l/pKiFGvUIWyo6Sk8iT1+QpI20osFZfqMsxnRtuDwY3+QRoCjdh8r1PibfQtx0YYGpuaUs6VPyph3gSbibdXv+aGh5JYZzxrjHKKd7MOVyb+jqT0ZDLcOTMFL/yhh0WX3ch68fFz5vLah7hYAZ4stGap67SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067291; c=relaxed/simple;
	bh=nxIKaqdUgH3I77RNCyQ2oZG+QDFxzcnCDgrtKxg6cuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JQzZBGPPMVjR1BCd2hqD90l3d63dSC0YLQzcafSBKcDEqUiE63B8uejj2qw7ZLrtmWpqjvmxSZUUJHFOLTMcOUqqkTziOxCIZZdCbn2fmimZ86F1i6TmgJChcXbUfN1EkuHCReI9TZ4Ji8gBFYuCZ9LlK0HCuGWDyZGWD89QQyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UfTDPJ6q; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYuMbBSX0sxTvW8GOG+17oAjoB8xhB6cNj8cCih65y/7iF5KR5dSfXNcYBRLLfoWmQjWXNF9B0SH8a0PUr3NMyC34aYGiq2rP1vsE1u0I79ghhV/PALVuckU54WMMszX9p3TPvxSZ/IdmFuoZLvz4DVT53t+flm6IYVK0UaJdBST1ZYLCrEzjFYfoVQdfjC4hrAT7SREWiZQW2nRMjI9sqHZqFVyW/3vYs0xF1qxC32jjlgCf8+4E5Ng+kBg4xFaoIHCtB96bSjdDLrYOS+ZBEIKdJQcMK6VkaEsLCUypx9HJZG6umkXFZmC+NuhIJwZaPy0S0RG9Z3Xi1Nu6jND/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J4jtMZmZYA/8DdmET+C5+mLSk/wm7w0l/HouecuuHw=;
 b=nzruFImqjzQStDCih0e/q+AyYYfzP7OKLF9DIRGa1U9MpSUSXNVKJNEBRaxk8JrX3Dt3auB+yWYdpw2I8+NtwluCtaVNQ6egMTFBnfryvJeRIpC5ha/eVG/ho2TXtewJ6cCX2ZOJ4YyXgcyTSjweV8wipdXzzJifamIxZhhAZjrz8qWWosyGCQFN2Vm49796MoAZXCagupFGQPya1ue9Vx27D1EYkIYFuyjIK5XVw+kKshnkraOz9kriDdJJ/3Mtz0dZ7iO2Bgn+e9vtqpthxeaFT6encZYC99gfwkYU8I7QpAy0DrMcqVD8KTRf6L9B3t4trI8ZasRRI6EsX4hyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J4jtMZmZYA/8DdmET+C5+mLSk/wm7w0l/HouecuuHw=;
 b=UfTDPJ6q5Rg2s/Y4LXSguKdE7LDpmgTddm6zcBOCksCsN/BsxTRO+kVq/P1j462AZHftpqGRzyBICox8RsnZ01jJttBvw8+ubdvuanBpnDUH/g3MFANXoy3gRIszXZqv6tk785twok0AxQpTyg0u/6FE+ITJ2vg7F+uVfHxk37JBjbr74H9hEcC6q8oig29qu1vyejSn8gLdGwEGMfnLr7vbzpdsfse5/Mh81yJPra/LN+9p/ziN+qMV5D7q+a/+IflsKVP46ZncC1DdW8H1KS1g/qZBTwrBhOCbE2qobEdEuc+Cpt3c/D+IndTEWa0IqBjQ4EJrCbFNfc6/CDtXUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:01:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:01:26 +0000
Date: Thu, 20 Feb 2025 18:01:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Message-ID: <20250220160123.5evmuxlbuzo7djgr@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-3-wei.fang@nxp.com>
X-ClientProxiedBy: BEXP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::19)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 44af6c97-40e8-48fe-cec8-08dd51c7d48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UedbAoFsY0pD+ZNlAD/BbTmIWFo8VA4d9EADXnRllLy4oo/PWkJbtQNq1Tc7?=
 =?us-ascii?Q?Csdzy9Hqxs6ICPSDjirlAMvHGLORc21ebrMUaFBKKUmjvvQz50KpgDRohYpI?=
 =?us-ascii?Q?e48w+2lVk8A1P7JN2+yg+/y9Dd2PmfvFM6glwTpPxVFjhGATfkzZa3Y5J9hO?=
 =?us-ascii?Q?zmFfh1fi+MKJG2fxHznOKoit8a8nFFF9QBJcYxGujHl1atV5h9XzgkulKgqN?=
 =?us-ascii?Q?2Vc0Ldr9IXxTeW5hTfQUd9XhrTkpl8SWsUfTqHQsNKDio46GhHYD/Qk0QKBj?=
 =?us-ascii?Q?SrZNsig0q6TwpFEtecWMPkJLwlwnmNBlLcGirWnMxe0vy2p1GQ+k6XBoQcR0?=
 =?us-ascii?Q?CwUyg9FP0+AcD2KGZJwyc4qRo/UfqzpxRAwfgxsaPZN2nKGWVMV94oBAPr+7?=
 =?us-ascii?Q?rS10SGrqZOBGlJEsuLOPmhIdz+iC873n6zttQrjE32AQMbx6uNp1IBe+jLRE?=
 =?us-ascii?Q?l6xtp7SNuHkPX5o7RQT+iZIVCLTqFtTmGnUgL8Jy7t57Y58FFgVgLCnDTo1D?=
 =?us-ascii?Q?223xG7HVYqvONaeWVO1eQjMx6dMveK7GP1fUOOn2BysMyvifQN7HDnNIgUgr?=
 =?us-ascii?Q?aBK1Tpwvx+uUnk0M0hKztTMzL2nVBjtl/E/zzgnEIBK6J2uFtPUS4aYfpVL/?=
 =?us-ascii?Q?gFjl56aB6JHLmQ9R9U4WttQOrmxkKNeTW2sEmRPNkH/oi4yKUWD4Bj9MTkqU?=
 =?us-ascii?Q?v5FAWj+dUfJCjCEFaBFCzMD2Qc/B5jIMVi2bLicoCHajGF8TO8zYvaveWzEl?=
 =?us-ascii?Q?NKlag9LXOcoyNR4OpPHOkXPrpXPqvbKefI6JsGvXu2/E4G+5VbBkauHbDsDb?=
 =?us-ascii?Q?f9o4YeRyWRSUMt0K9oNcR4EkzVjQBJZG0bvr87T/4cLNUQ0JzgkKve1eLKpO?=
 =?us-ascii?Q?dNfwFuP97oPnkttAON4XQKFxZZQlIjVCBn10CkUztE+VvfXNAV6RZYUCDZGN?=
 =?us-ascii?Q?d64SAz8bkoT0nVe10p1ud8uKnjniVrY3gRNcZK/vGv2a8O5cgV6s5a/cNY/O?=
 =?us-ascii?Q?Gudko7tzQBwow0o3s9VcrM/CQrqQ59rjvnhNe6fuZUtIGN91ui3WCu4Iu9n2?=
 =?us-ascii?Q?OcVXImasCALHuBYhdA1zn2SKOC8L1Tcvfmjey0HJAzEE5/uYj4NeejSJRhUS?=
 =?us-ascii?Q?zAZYBNFVwdBlE1Do9lsWyZnV48jNLD1P6c1UwTGYIeuzPj91WCNGyZdlhBHO?=
 =?us-ascii?Q?sQu/gBRZ6xrmnXh+aJ6hWJgxnThcYaI12T+5cmap2GLAjW4W1hIc2x/HB+xU?=
 =?us-ascii?Q?xEd2BwqudOdYt9QNtJUGKrvbroWsGvL71f5GLLit4Ik7CpIxXiuFUXa2KodC?=
 =?us-ascii?Q?7g1ssOgzbqW4m9z5oHI7P+glgitqc/iB61w2p7goTBkAtUL2CVplvA+MrbgG?=
 =?us-ascii?Q?RHJGXAMEECI4p28hpe/EbxMhbuxW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSwwkj9Iwg7dF8v51wNWqmKo3To1xPq87JtUAiHlE2H6ErN5/08veVoPw0QU?=
 =?us-ascii?Q?nfY5EDFzHmiaskFR+Fu350klvx8QIbx1qkJ2dbIQOQ8YgHHZYksFsPDB9vsk?=
 =?us-ascii?Q?s+yZ54uYbqnaf9ac8is/B/L8Uukky127uYVyC8SYL05lFhUd619vhegOBLKN?=
 =?us-ascii?Q?OzK+xwNBZaMb7xNJQoGl7Qy/VSvLJtN3ivNzrWVBy6Iyr5isLsrebO/Tx0zK?=
 =?us-ascii?Q?qDWjA1r8IMwHfu5w0BZ1DhynG9Ko7d4PYTIV9n0tW9FmlNG92RwWh5jjhWNZ?=
 =?us-ascii?Q?7g/leqiZwVhCMNhxQn1Ho4hBO1OwZDrFD5DeEu8XCtQUUoCXCQUBOJhcneMB?=
 =?us-ascii?Q?Ro81bGdMSEmZkRQZgHfX/7lQHAoBSdgTCR0Om1OzXyQFAXWUN78fHH/pw1zv?=
 =?us-ascii?Q?gl6/xQb/iQkxuNY98Z2b10BU1M8BgVTjGXztx6GiRDAnn+He295xBzygHXgI?=
 =?us-ascii?Q?qagQmOPaaBntrRF5SP+KOr8tDzCgri+b83/6rnUk2VZa86KASntzWdaFbZaX?=
 =?us-ascii?Q?8SLQi1MhpSkBCyxDMmEJEdB4jWCt5WntfLxwnS69vdeJ2zMdpe5qJ71qy7ev?=
 =?us-ascii?Q?u9TIGvkGVstaORI8uoLZB+2YNaIjos0Mp8dUpG3bdbnn8IDZCB3F3g6Li1Pp?=
 =?us-ascii?Q?brcc7P+QppxntqvsqzYtzsYJL2E09YsKzgcxHOXHWJfnEeAvdnZF2K7nMQPK?=
 =?us-ascii?Q?wAt1TAG+uueIjgvK8lvVecnnZTTFu52axnqUsbpx8pPpEOUQeQENnZ8iDPBH?=
 =?us-ascii?Q?5ZEkiKrHIVE+AypQHgu0Rmpmo+f2TdJlgidQI+xixLoE0DYsUlt8LWd0tsbQ?=
 =?us-ascii?Q?4lP5UVuvN1WYIq0hB5sHY2Eg3PIT9bJ2xEIXa8ESgPmDf6OmPPbjD07xSa9v?=
 =?us-ascii?Q?TJI6SJ3rygaC5wxK4tOjbDAfG+yg43+cumv4HSkUHHHt9FsXp7xnHPnvo1TG?=
 =?us-ascii?Q?/Ze/dnFzvEi6TQ3o5Y5cQy8niybhePpVRP7yGzU8+jN6SU7vwRvPidBDXck+?=
 =?us-ascii?Q?hS8zQlEJtqk1w7qCC1YqwiI4rKVM1ZsMkeP8UUuubK4PxCUlo1biGI+vBKP9?=
 =?us-ascii?Q?nrovBQ4P7UkT8AXFiAbzER3RJAJ87KTqEXVR/rKj5gnPBmbLl8iGj4HPzh1i?=
 =?us-ascii?Q?U4TD2oUK646vMtUEadCYpEo3IKbiJ/b27dbmZYMA71GzQQQJ2a3HCVSm1xhC?=
 =?us-ascii?Q?uLmiztOJvxWnY4I/udb/M/bSLw49dR4bG9DpGmIIDn7Fuqx2HQ/DXg0WhtnU?=
 =?us-ascii?Q?9BVaBL5kladQWF6auKFea0s65PItdaDSdcvO4cEO7i8dyWFS9IQaWsFoh5B+?=
 =?us-ascii?Q?8HjQNkDS4rbCuXrXW759Z6eu2ugt4QIWjjynpurpna4Fj0kXVpG1jW1u4kAq?=
 =?us-ascii?Q?htLC31jWo3nrKgUtLUjmjfQmYCbOINAxxee+ZayIX0eqqdIaO5rbWhRW2BS7?=
 =?us-ascii?Q?WS337Nrpq2t2MATYpokhZDVCp77O7yUggVPIFXtzNkznIZysmMrTC3Xpeurs?=
 =?us-ascii?Q?HsgD+UPXcPaz1noKuBAtSyx+P6XWejaUHWrCH7H15sURheDHkTQvV8lBp4/Z?=
 =?us-ascii?Q?auu9pqU5ziR5fgxPgyOLJlW8falJxiAVrBC/KpO33d5kEsYn2fzEFtRIcMDg?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af6c97-40e8-48fe-cec8-08dd51c7d48f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:01:26.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qet43X5/wxtvJPL+InzJrPXxjp/cBHJNUTZsq8FX2QUJaRm17395gt1IH6TEn8u5llI85w/k87Zc4JK9MCHX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306

On Wed, Feb 19, 2025 at 01:42:40PM +0800, Wei Fang wrote:
> When creating a TSO header, if the skb is VLAN tagged, the extended BD
> will be used and the 'count' should be increased by 2 instead of 1.
> Otherwise, when an error occurs, less tx_swbd will be freed than the
> actual number.
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---

I'm not sure "correct the statistics" is the best way to describe this
change. Maybe "keep track of correct TXBD count in enetc_map_tx_tso_buffs()"?
The bug is that not all TX buffers are freed on error, not that some
statistics are wrong.

>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 01c09fd26f9f..0658c06a23c1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -759,6 +759,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
> +	bool ext_bd = skb_vlan_tag_present(skb);
>  	int hdr_len, total_len, data_len;
>  	struct enetc_tx_swbd *tx_swbd;
>  	union enetc_tx_bd *txbd;
> @@ -792,7 +793,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
>  		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
>  		bd_data_num = 0;
> -		count++;
> +		count += ext_bd ? 2 : 1;
>  
>  		while (data_len > 0) {
>  			int size;
> -- 
> 2.34.1
>

stylistic nitpick: I think this implementation choice obscures the fact,
to an unfamiliar reader, that the requirement for an extended TXBD comes
from enetc_map_tx_tso_hdr(). This is because you repeat the condition
for skb_vlan_tag_present(), but it's not obvious it's correlated to the
other one. Something like the change below is more expressive in this
regard, in my opinion:

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index fe3967268a19..6178157611db 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -410,14 +410,15 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	return 0;
 }
 
-static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
-				 struct enetc_tx_swbd *tx_swbd,
-				 union enetc_tx_bd *txbd, int *i, int hdr_len,
-				 int data_len)
+static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+				struct enetc_tx_swbd *tx_swbd,
+				union enetc_tx_bd *txbd, int *i, int hdr_len,
+				int data_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
 	dma_addr_t addr;
+	int count = 1;
 
 	enetc_clear_tx_bd(&txbd_tmp);
 	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
@@ -460,7 +461,10 @@ static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 		/* Write the BD */
 		txbd_tmp.ext.e_flags = e_flags;
 		*txbd = txbd_tmp;
+		count++;
 	}
+
+	return count;
 }
 
 static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
@@ -786,7 +790,6 @@ static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
-	bool ext_bd = skb_vlan_tag_present(skb);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -818,9 +821,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
-		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
+		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i,
+					      hdr_len, data_len);
 		bd_data_num = 0;
-		count += ext_bd ? 2 : 1;
 
 		while (data_len > 0) {
 			int size;

