Return-Path: <stable+bounces-118436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67FCA3DAAA
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB613170835
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B201F55E0;
	Thu, 20 Feb 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwtxARk9"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63808224F6;
	Thu, 20 Feb 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056490; cv=fail; b=l1RyOPmbNKHu5b8QNfQy3F+RFMBBkCeQDyypeTO0NnQAqFWqJ14Fr/jcl70s15a2uMLmNKxlbibjbKozG8lWgz1gcqVg5kufLu5mS8pkloo5/fvqROjm/b/QY4obXgGhX6koYzrXQaVyW21xXIPlDdg17OHS/BHRvRw4XI4PEs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056490; c=relaxed/simple;
	bh=sx3joi43Z7ro/Uz++eNn0LYDnoy6dBqFMZpeypLxoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qTN+dyk2qxvdalHiuxVehojdQbJkgf1VycscTmtHMsA9oKjOoeoR1IznHLZ+GbPqS18VlMoZSjztybNTkycDWB8OPF/gRPqSEB2I0/NSwrn2JVEgH9dGEfs5bbsg5dcNbLqzKFNyx/4R1FFFkOrRI+EiHFh5v179lw2HvDVWe/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FwtxARk9; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIjmb+Kk7XadSLz2ulo4+y4C9gwezgNSiNkS1rzDDI+ZyX//VsJ+we2KrX1PbzQXfchZI/4Gdw33vQyOZp84TCEvvFdJTrm5VoQ/JkUssM6g42oj0mNXGptLsqfrphycfIBnnEd/rzGmcyuJSR3iLugPsJW8JqB3828GGkJdmK0A4YzLTlEew5Uw/87DRoYf2qjrqqy3LOOXqhCx46Fb/Z7j7tCBcPY0fhI6ix1w/65OLe6m93j4QQQRRQHAb4d/jiw2IsDZAGQhOwrCH+1y1zzBDICMK8c6yquJRBlLZh/274O+XaJtCYT9QJlHG0pdP1FRhrOCQUYTyE1zb1glOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mOIpL+BTRMqaUMD0f8BNVLjUeRUjfXHJ46BlkYQLeU=;
 b=kJj+Fgd6eoMh8i2rFHVHGKzJoaPyDlaHl6VQvrE1HNLsg3ockvhPHRcHgu0Ur3GnB2/i1NQUMIlQgQ9d2kwPnh3wI1KimpqraGWg3ECuBjy3sLo60jJrZDcGMK/4lzRnkHvhVSiHKxn+SV4z6h6kNQK/EdWu3iKiz8ZCaD8nnVfQ1GopY4vUI5Z0l30NXEjPQVq+++X1cm7kXoW6ptJMAIU2Wu9zDc9aOvgT868AgG4zyF/VGxB7LQeaWrbRdsHyK6aA2xIEuzXYd5p6lTOHAT/viLnUykuALJseersg2J9bjeKbx+xcb+Q2NmrshiXPX2A+IRMTNH4+uFTMcqcOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mOIpL+BTRMqaUMD0f8BNVLjUeRUjfXHJ46BlkYQLeU=;
 b=FwtxARk94PJQlu6LYHm8jhXtZNBgD8b3XWzQa878UsxCGDMqpuJut9csZC8DhnqHSJK+BF7Q1PoEgVKSVK8hPmKB6gaUbdf3T/l/iBylXN69Nq6IDcM1yIOHPYTyShGWCrhD6rM4lCqeroV5LEh4BQkqYbbbUcn89IlatV36Kl7QaWJpJw/mH+N6k81ViB9Q2FEd7zjn2dJjH1yxHi/t0Swc5/IqM10oZL3fKPkRBLS/kZAkKUF7Vlw4fGEMm8KLu+5hwU7CgX2hdI/eIzd7qdST3OL+L1uEnskUudFOt81BSYtSpYeLBEGbMdAQNVNeo7180msc7HcFBr1AD7/zRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 20 Feb
 2025 13:01:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 13:01:24 +0000
Date: Thu, 20 Feb 2025 15:01:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Message-ID: <20250220130121.fq3irlaunowyvfc4@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-2-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: be2e1ff6-d294-4fe5-3dc9-08dd51aeadda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iepRGVURrwuQI4vybmve03urEGZg1aJx5Z22t6I8oOEzqZQ6TRstCjF7sc/1?=
 =?us-ascii?Q?9ezIF6+9T+fU5bMskghEnaD61sggeYeHyvvzYjGA1M0Jxxlr08Sf39kV7Qzn?=
 =?us-ascii?Q?8aRahLQGYirxs8UiW3FrWeA2A7+8n26z8z5+pkZGry3DsGuremgJpnwpp9q+?=
 =?us-ascii?Q?1pRd93LxUtB6Wiq6md36L0bnV0Sje4eIlHm6tWBuQGSkK8wKd0lA1AXqQ2Z2?=
 =?us-ascii?Q?kctc697UUJPGsYkqj9vY5KWZG3DlaxUDqdk2cvrRXYFUWd5PWA0MOW2NDB/h?=
 =?us-ascii?Q?qa0pLVuoC0nC4CzqB7gRVt94J1i7MGDDYu4+ymmXz0V8UijJlbuHdBlDSvgd?=
 =?us-ascii?Q?CjaidlY1BXMHNT8AqqMPAKvgg0RIQy6YBnBeGfsZiZ0D68PydE73fzrW0t6H?=
 =?us-ascii?Q?yh6FZgdhCNfJrTT/ys4Xm/2nDRYbjN16k93V8L0s134Ve/+tqP4I9wqBlYIJ?=
 =?us-ascii?Q?LQlS7QTFCpEX140X5E1TdkTCF3KmQzM7GXwROUcRSQgCxenhBTmtPR6bq177?=
 =?us-ascii?Q?ecEzj/8mEC7dOPnQkHjmg/fH+p/wiCuR5EM5ru8FGxmZHPAmumdbEgpoAbv9?=
 =?us-ascii?Q?B08CAtifh+C65RLypM6Gbz+5M1Swwp00q74BGM8TG23VwoazZXtosAFtcbvy?=
 =?us-ascii?Q?N857ikhkZYcosohdKO7YoxSuHC9MxVeuyoUQXHCJvB4mJ1bVsWqu4svXDaw+?=
 =?us-ascii?Q?NqH7tmlMFNRTkZTwX96MRmXUa0QtDHXyr/E/yjU2FU0xh/bSuC+GKdjQpNQr?=
 =?us-ascii?Q?z8pwsEEIsQbVOkMHA3h4v2IYhOaPuIoruI58zKgW2LxfZTTs0HdCXxDhTkmF?=
 =?us-ascii?Q?qw5gbqmmO/ekzoLq5MkzIgl66eghNWE/CyNcyFsLvn/AOX7g21VQ6P/wNEWT?=
 =?us-ascii?Q?sazwsvk6SldOB94ECFx7s6bkcCllQ08rZ+4X1iMlWzZ+YghzyA5B8sJjErAG?=
 =?us-ascii?Q?oj8O8SGwN6FLWll4Qw/fQDBRKjJRnIijJeg3mrf8NbCy/gXOWDBsG2oM2YLC?=
 =?us-ascii?Q?+yl5OaAV8jCM4Gki7+ndRNIcynkdzE/ZDWVHIzpaT5yCSDcB4YlmThGiNuWX?=
 =?us-ascii?Q?MC7ssDpek1Jtf9bVe4Q+Gv6f5iFRCu3MOGxDiOZ5518NhqW/5X+P/dUTwYIy?=
 =?us-ascii?Q?38TK6rKZxwJ2fyurVNTLn+WO2NxillXalwOP2XRBJF+KY4dWoJ1ZANx1jmW9?=
 =?us-ascii?Q?3Ev7oKfDEZZW/32DwZaFXGtyue6Bbds/BA2Rroyml9k2ZP52Gvwq6HYbU5a3?=
 =?us-ascii?Q?t0TsbGP92TDuMvb53sROTbCi/0UPWzx/UJdatEQsLSp3KlIVngl1Ln1jY+VF?=
 =?us-ascii?Q?q3Xp3bO28RARZheGl00sO64N3lWa265gacXVAYltelG3xYHQdvAVRWICy90G?=
 =?us-ascii?Q?fqhnabjcZkGJ5D6Pa7e0c/4qSp5o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2Cd0ttZcc/s5CXZ5afQOSpQEy23UfCdaxcmhUwQ2KZURxdTRCOL7A6AhWcm?=
 =?us-ascii?Q?aZhXF61EJYqKkpi4BkE2GuKPnz+PxeSEM5pUqIOF6weinFWn0tzO4Rx9zYCd?=
 =?us-ascii?Q?MXrMSN3/0sQ51ebkcKTNQkyAWyag82w2ZN3UF+ZVcaToqyOVCrmJUR6KzbQb?=
 =?us-ascii?Q?X+9F5SQepon5iOaQ4e0Q+2ADQw87cQYC1oCRJZ7jAIgMFDiQA5GBquHNlG0f?=
 =?us-ascii?Q?QHz4//TT7irK03mGy2BB0Vce0VdWsiNkZWfF24Brs82y+jkvhEHR3zDENY98?=
 =?us-ascii?Q?s7+pgRkqX978YopAvZQfk2/ZVfx80lLS/rcoiVMv8+zPpE129F+bl3IPWonO?=
 =?us-ascii?Q?ru76Qm5iVgEmidsbfvlqmZ4Ai8SkxpXTakVUjFzbOGznIeQnqTzM64jxVdOm?=
 =?us-ascii?Q?nww6fCEOhmdWH+GdamHcH4Gt0t4R5TUVNnHlmMVug2YXqvVKm1tMeiMN5cHE?=
 =?us-ascii?Q?PKbGtoTertjBULTAO7uN0J7LdEf2TMNJB4mEdtBTp7XiBZ63bwlTnlE/ML3C?=
 =?us-ascii?Q?xrOAJPlIlj3oyCFxfb5hPSzlY2iBwy1i2NeAY++fs9c6IfN5damJF9WIvepu?=
 =?us-ascii?Q?Yx2Rtb+JjyO7kh4jQxVxUduY8NDWteW9MGvEHjNSFGV9NpF2o6TCtIqDCXox?=
 =?us-ascii?Q?lAMTtbhOI8mEtLT4yy2W7BLSYKE0LckRLhzBCZfyvSHQaVhQ0VaZ3R4/Hkv4?=
 =?us-ascii?Q?sH2R1znBaB0lv9pZMADPKPOSBDzscpC6qb9WJAj7GKXq9KqUz6iDDCaUjKel?=
 =?us-ascii?Q?VoPyZ1HD9bbDQ9BFqsTBkqFsnjyA8iFv4MnOCPggd/vONtErp5IaJr+ekjIi?=
 =?us-ascii?Q?qXX9Mqk4+hMP9dFHvDxMfPixSqv6NJkeaeZbc1mGjq+0EBsKCLkntV1FnFC4?=
 =?us-ascii?Q?uho5C8iKK98dSGLlDEw+xv/FhNteczaC9up3dw2q7ktSH2K/9QC0PRJk0nL8?=
 =?us-ascii?Q?TQbjiSqegRJtsQ8vTyNOqwsl+pH/vLnuDCzKmxZWO16x2fPnBZHmaAZYjkwd?=
 =?us-ascii?Q?OIdCPSum0b86oWT7Jmjrri9qPWRYS1DfEO2fH0GKCSkg43YKLQzYRxyCyRqp?=
 =?us-ascii?Q?j4rO4gEmyuwKX4UFihisbXRybsXhJxEUY73p3cbaJ+1a97HANWMbZYaQ5fo/?=
 =?us-ascii?Q?v7HaahkAwMhRRFaMFxWC26DgIPS+ekVjbIEDGv2Srs25QZfKd0JvFJZ3yPaY?=
 =?us-ascii?Q?UUacRq+9eaKNH2wGtJGyvkKE32vD4wsVXrgl3s7AoOrM8gSXt9cz5Wo3w/EH?=
 =?us-ascii?Q?VKbmhoQN8plHrBF9An+D1wQiiRtUTYS+NJzEq1X9O5a7RodMgeMVcJbN4kEs?=
 =?us-ascii?Q?Cx/szZsMm3RuABKly/RxIkYYhhZhZ2hyqa4TjDxZaH2x5L9HGJJGBGk9RUSv?=
 =?us-ascii?Q?/wfnCIy891qup+VIZSLx8hmyMPo0TOhLRwsqy0gSY2DB0JyZnuoeISbIHGoL?=
 =?us-ascii?Q?/ET48TQYdfg+n45LkRnC50QvOOVzl1rH9KUiHbDKoP02RuwvADCJf58hjAFo?=
 =?us-ascii?Q?b5X77fedmvimKBsWcdc+SFgTVUU/5hexYlPMpfRupVfa8m0Xn1/5PEGTQtaA?=
 =?us-ascii?Q?k5OQb57jAgscuutQoywSV0+/EW8blY9KBjCn/3pHfd03InoqLyy3o4u2yhmH?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2e1ff6-d294-4fe5-3dc9-08dd51aeadda
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:01:24.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVx0308eYbB1YJO3uR1Tc1xqP01MAthKdbQdevd3dnUVVPlzL8k0CI0UbseTwZozEitOIrb4N/4C1NWA80mJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

On Wed, Feb 19, 2025 at 01:42:39PM +0800, Wei Fang wrote:
> When a DMA mapping error occurs while processing skb frags, it will free
> one more tx_swbd than expected, so fix this off-by-one issue.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

After running with some test data, I agree that the bug exists and that
the fix is correct.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

It's just that there's yet one more (correct) dma_err snippet in
enetc_lso_hw_offload() which achieves the same thing, but expressed
differently, added by you in December 2024.

For fixing a bug from 2019, I agree that you've made the right choice in
not creating a dependency on that later code. But I like slightly less
the fact that it leaves 2 slightly different, both non-obvious, code
paths for unmapping DMA buffers. You could have at least copied the
dma_err handling from enetc_lso_hw_offload(), to make it obvious that
one is correct and the other is not, and not complicate things with yet
a 3rd implementation.

You don't need to change this unless there's some other reason to resend
the patch set, but at least, once "net" merges back into "net-next",
could you please make a mental note to consolidate the 2 code snippets
into a single function?

Also, the first dma_mapping_error() from enetc_map_tx_buffs() does not
need to "goto dma_err". It would be dead code. Maybe you could simplify
that as well. In general, the convention of naming error path labels is
to name them after what they do, rather than after the function that
failed when you jump to them. It's easier to manually verify correctness
this way.

Also, the dev_err(tx_ring->dev, "DMA map error"); message should be rate
limited, since it's called from a fast path and can kill the console if
the error is persistent.

A lot of things to improve still, thanks for doing this :)

