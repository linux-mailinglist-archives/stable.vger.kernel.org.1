Return-Path: <stable+bounces-195009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C349C65DAA
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7DE535F957
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86433DECB;
	Mon, 17 Nov 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QekUqVBh"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E433D6E3;
	Mon, 17 Nov 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405863; cv=fail; b=jg5RQaHznlUgfmPesAYiupvLLVhBP2RBRSTX67KEWQhCK+Qifb5xDaO5VZ+vkXjZb/8wVxieVLkwNJeo56TSQbRxsG9gEwLQjPoV40CO7uR3LF2CnAfnLXGYMim3UuZnsmzrJ6Owf92a6B87Y5PtYdz1gmRY2NSP+V5k9qrAPVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405863; c=relaxed/simple;
	bh=0uN/uGtczxynqFoN2/XBmulyfhU7vx4PEvB2ALMS+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrFtvyTIKWiOB8V4dNfaKfJpqv9XRkxJ8vCLOPeAx5P5JTNVPtLtG8KIPfbKCwaIAS1TtTbFnTcGXJ2UXWmAAC5eMtQxEyuNLJ0M11f2z7NKohDrYN1QsCM1LaIMLH4yBhh6OVMHdYEfyw1U5AYpmH6ozin2NAXCzPL4+mo9uoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QekUqVBh; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg2s6cmpto9xwA85CppuCpJZa3rByC2uoYm0TKSMNVcLU2dZRQY9zsMVJN9exmZvCp8+l3GyJMq1DD3hq6WInaLM45+FAjqvQX/TpYDxrmsy1FVQLyOLVxHIarZGUJJGFzPxf6Joc05t1ps2749XlYQ8U25zAyT4OhiiyI/V3alIWapd25bPl5cW4MmDjxpsNiqSBIpFX3If3R0knDRVPinWjCgorRQllUWLpca+KzsJh8vOwYJUutDVEkjarvkltcyVllpW90+HSXXuetaojAhlclyOVfLcroyyuFn92Fmsrpuf9kg0EydE7CsJoA6P+7j1HaZlT1NgbAseKrusvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuY4Dfmt4ITXraWM5NIM2ejkZJ4T4ww9LqJ4fbRoWHk=;
 b=ZV7j2ZwKV3O9gHEdF3I7Exr2lPCeAs1SksQSaMJDczPWPeKFG54VCSkN2S5tXWViy/fQ/WYPkgf+YAJq0nndH2YukEMFwi5CRRsN3Mp3+kz8nDeBzUW3nwu0hGrmG47KTvednQEIIzW8o9GzUhQXmIOGUm7P3cepFfQguvx99d5OCLdwIugylhk1+A936VNJGYnJWLrbzwnfGaWinrkL1K2/7qyTxmQn6kerX1WNzG/pT7WL4Z22RFSv51abz+ar30asYm6KIid0LsmvStntkORJUzWRZpmZYusSQkvpwd1nh+9S7fReT0EgTuk52B3JLmgIWdHSj5d5hwgmP5yDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuY4Dfmt4ITXraWM5NIM2ejkZJ4T4ww9LqJ4fbRoWHk=;
 b=QekUqVBhPX91r5x1xliANhHtdUD0vwiG5Sd/jduRvFImFA3wKS/m/jQB79/7QhrBlCrBVugb2dr1rsihdiyPAVU2ran6gZT00aO2T9PkQDhksa/EM16qlcpTJdEoSRupKMItDhVRN4kPeE/4dXVznegAINPtEAhF3fHIj8e45L/FEObwaLQ8LCxNayQngDUjZmIXJ630ClXdRWlIzh4LTl3no9E4wWnoGJYnd9MqS1Msy/I9kwvWVaY9wMqalnCdk8Ej501yCKxcR/584w9EmUYA46mBqHENp9R1K5OH6TMc4xghViMl4rvfgsR82qgqq2pOiMwrI+rWWUGqmfnOYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 18:57:38 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 18:57:38 +0000
Date: Mon, 17 Nov 2025 20:57:34 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 phy 02/16] phy: lynx-28g: refactor lane probing to
 lynx_28g_probe_lane()
Message-ID: <20251117185734.hgeclxizxmnvlaxr@skbuf>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-3-vladimir.oltean@nxp.com>
 <aRYMM3ZuyBYH8zEC@vaman>
 <20251113165646.bopsvjiipcslvokj@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113165646.bopsvjiipcslvokj@skbuf>
X-ClientProxiedBy: VI1PR06CA0209.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::30) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 980b782a-39e7-4680-f43e-08de260b2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1XprqJyOMEJ6CgjxGEm1VIrrVfH7fnHFNFnRA3VsJSqvpG72rPpoJOf7C1sR?=
 =?us-ascii?Q?o/PfnnoKEeDMia2iPvaHrvqDhRXOAbVBam9/MFfVuE5btOFXbVZUrWzxmBG2?=
 =?us-ascii?Q?WPdJEJKm4O2YZJxQOJJ6S5oT/TVI4GUplDKAl9V3npjWdFOFKeLIgTEkESKT?=
 =?us-ascii?Q?i7OWqMJSj7Vc6/Mfmbmn8zcdG8aitSvYZahQXGgs29G0XKglQox+3Kda2KA9?=
 =?us-ascii?Q?E+Qrn5LZTHjL7OtMVtbrBcfO9luxCvmLHYd5qsBNm6QKnST2RzOVJ2wqyByh?=
 =?us-ascii?Q?l/8UlNrqJ7uIpzm5sgmCOdX/wVLSPWqdkmoQneST/AQEJGrOoVr+hVCUhOg/?=
 =?us-ascii?Q?xOdhqzUi/mMCEH0lApmUWe/6EgwHZFSqFIs4veGA9tAzR9G+Wxkpwdx8MJfK?=
 =?us-ascii?Q?0DTLEJjGRvszDx+aw7zJQxSQ5jC0yToY/jrG/siax7fYd3hjSge6L9tNQ3RG?=
 =?us-ascii?Q?9eX+LlhwEgw5Xe9to52Ar5O2m9D79VVlYTIJd2CeMarCrRET/DReJ9NtfwZX?=
 =?us-ascii?Q?w/sWFOCAFmmOJAaIdxs33eac8Bjl+4RKWkl95yplNv7rfQ9vP5ROx+0+7M5c?=
 =?us-ascii?Q?+pGW87TWwaMP08aYF3rCQXB2Bf/1Az7ME7rYTQfiCRznrwk+nQCAdOkBRNnW?=
 =?us-ascii?Q?5TYy3PtMqYn6AcjHsWUBDe1R98k+WWuxM2x9U++otfpBTnV8U0f/fs72NSol?=
 =?us-ascii?Q?ZTFFw/VuqZx1t2qIfuJ1WK8szmwLUC4O4fsvh5KRZ7dh8hjFTsGwU/2AX7Zb?=
 =?us-ascii?Q?lzTZn6INiqof6Jfl9LwLM4411g6iXqPkd5xhqWKcblyyu/kXUaira0TQEX7y?=
 =?us-ascii?Q?O4ASKQH6+s1QQcPteKMFnZDeFgY4W8Ie75owYewSyzsjkfOBN9yhY7czXKTR?=
 =?us-ascii?Q?dOGQLHSjzHh7G+aVC3Dx+wsxSL/gJRj1jMOf1vX8jfwyI8YZRTS3g6kHuihC?=
 =?us-ascii?Q?BOfkkXWuQhLPy1s/ILV8dYPoZpLSuikfZKRb40Lcrm047fv2mBpEsX7APB1X?=
 =?us-ascii?Q?M1y5kxhLJixqN7tpUO23F2t+n+bWMNrVnjDAjyc5WzkI0n5SkgUONtYPBfke?=
 =?us-ascii?Q?opdYn4PrxsjhBefJlJrFYE/6yu9N+N/E+DO9X7VzCmpBiacKRo2iQTB9+JjZ?=
 =?us-ascii?Q?odIHhSpMxkRDXDYH+j54/7K3q5vRzbSNjilz6XafTinI9Jh/fY0T5TlVOkCM?=
 =?us-ascii?Q?Up3im3+Y3rg8hrXDhd7+hOBnAbRzBfXMbGqDgp66Ov4+y+j62dOXVRdV95oA?=
 =?us-ascii?Q?gc3XDcR7b1Tohoj5zN+VXHnUfTjkyvm6sH5OOnwidA2WKUkjbWvQmXyALTJ8?=
 =?us-ascii?Q?tbi74rReQxmFErIz94BU4eIFMGJdpUiSnxUjZq17jeroL4uqD9pgssNuWamJ?=
 =?us-ascii?Q?aoz6pLOrmp1xX7ALchHlSs70f7e2rZAqlNvWmCr3ByBdnvX7S4DuvB4sPdwC?=
 =?us-ascii?Q?vykGHAUts94/TO0w5pVnhiLSFl1FXPps?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2VKLCsOf9vchSLEP8bSF0PIatTTg9Kfq2tAxS1aMlgVSossZkMCc6+xNm0X?=
 =?us-ascii?Q?fZed9d9aNJ0x40bVpv14bNQjGMlwYxPVzEbpe0Y2qTq8Tp9LvIeoy+VtVirs?=
 =?us-ascii?Q?fA+m2482hU1bTm4RdsvsfNRJNnJEkV9+/vsQWYUKU7htwseBCPQLoQ4LcrpO?=
 =?us-ascii?Q?RkwBbNQNqoy/JkF47xHvqOwuANt0MsBqkSEhw3cdi21v/g7QCEX+Vc5fkuLF?=
 =?us-ascii?Q?NE1v1gUzHP+nuFLK2ZcnBO9BaDNmf8T3I7Iq8psefWTn1zAlMPay7qw9ycG5?=
 =?us-ascii?Q?LSIDZEnqiJagPdFSSq3oNkYaaSdxsgip3JZXUvQgJnqwTc9Kxqgmk7CXbV7X?=
 =?us-ascii?Q?rWVJQe9+PJOl3IfbAAFvkf+FSPbnme8jHsdcoxsmBucqsNxuJlMMlJzbhiYT?=
 =?us-ascii?Q?ecZIMIFwRAZGhN5H8iV8qSlceYtOQYhg5se0fPwoKwvpmBSkFd2Fs4lm1t6B?=
 =?us-ascii?Q?On2IFp4lVE76VZbCXYxS0ElmV9CK78tbxGWnDyBDL3LYilcz/FZXvCN8OYXW?=
 =?us-ascii?Q?IYrUan+zJWmV7Z4isN/4f0POT39DHkFn6JUvArVt/ELxW6R3cLxS3ciX3QLr?=
 =?us-ascii?Q?9Ily7bGeG+JP5YJjT/F6lIDsPWUn1eMh50X6/pf4r+LiZ9os8KQ9nGbN9L4B?=
 =?us-ascii?Q?qeqUouNbz61X3OKm3XdQ0mvWWZ7LghdkGp42Is0Q+GgenvRjYzxB18Mb8MLB?=
 =?us-ascii?Q?e9oOesjkh49IIjZ6N5wbRgffrqnW8qTrVbY++KVjR7UflsNCq6Li5YThaEWd?=
 =?us-ascii?Q?U2q++xYGXOnil9cjOrF1XVP5j8a1afMFlun6eXcM8GxQjT8bljv7c5JzTXYX?=
 =?us-ascii?Q?UaOoUBqb22fqeZ4GU9+vwudKvr9rRuV2ApID6Y1VOf2U/BgEGUhEs7uKWbw4?=
 =?us-ascii?Q?pzGpQh4JDcTc5p484AXwnxCN8P52uzRz7WnGA+TdViB4XpE3VKrAHubv4GE+?=
 =?us-ascii?Q?cGvBvl5Ajq+Xn9j2+lrGe9iPWrimP8Il8hb0Q8o9KqdFE3qmHUy7aA/J7Jiw?=
 =?us-ascii?Q?CJw6of03wvsf5MXS0oZtGmdrgB0nTS0TB5eO7Frgh+9gXGM1JQRffJc0wpwD?=
 =?us-ascii?Q?PzznDwDfIpAoMAVEmJ7A+2HMgHuYRyZiHPIpjrwx9AsWJxLInTWnSWzTuqzF?=
 =?us-ascii?Q?d8E5GIHeKIxpFDCQkyMm1+dJScUrMAeRoliZhh0rnjqRPMOmkl2zkPM7QXCm?=
 =?us-ascii?Q?pvJdRm3Zap/wSemAj1h1EEbM+OcCWQ5NwwnMyrGWWl6GfI/hMHVioeWAEvrW?=
 =?us-ascii?Q?bsR4REcOJFrbSIGapI225+5FSxzbUiNEUKc4c3Jh/dD/R8C1WAXwn6gYvmSg?=
 =?us-ascii?Q?8PB2BKMDY4TQUqQFHZ2TIbUQf2s/CGMFYoswsCgcdKp2w6OqVB1//2eVohWm?=
 =?us-ascii?Q?7vc36jHFKcEAs5lrycUMU+Thc0hAT6W/sm2Ca4JhZpEGFjTlPT9AIkQ72jQN?=
 =?us-ascii?Q?wzuLiQHNVJC/luVBiWARZo8X+vhvqGPqw/1YXNTKoJIJ+kf+lwaIFPOyyskT?=
 =?us-ascii?Q?R1d1rirCLdducGMzdhwMMH4+J0XijEbHIX7mQ7z3pONWneoA6WLEz/+4j3OH?=
 =?us-ascii?Q?RbNnScrAhcx/iPIgPtjpT1yTVirT2tgDuU9h/Byb/IDs5r9T+1thKaPuKg4j?=
 =?us-ascii?Q?eSQW0w2Ux3caWFXgzKsKTrK+6cdqG35tjsiYtW4uqvurXhi2io84aHdaxH3G?=
 =?us-ascii?Q?H7fLsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980b782a-39e7-4680-f43e-08de260b2d53
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:57:38.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXXxqnX+1ZfKHuAk/600Z0VSDkx5Kcz2H/N39ZHUnJP5gkasAF7pgX/mJ2Q4U1GdlPFXIpjqGlt2AlWbDEwL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359

Hi Vinod,

On Thu, Nov 13, 2025 at 06:56:46PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 13, 2025 at 10:19:55PM +0530, Vinod Koul wrote:
> > On 10-11-25, 11:22, Vladimir Oltean wrote:
> > > diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > > index c20d2636c5e9..901240bbcade 100644
> > > --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > > +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > > @@ -579,12 +579,33 @@ static struct phy *lynx_28g_xlate(struct device *dev,
> > >  	return priv->lane[idx].phy;
> > >  }
> > >  
> > > +static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
> > > +			       struct device_node *dn)
> > > +{
> > > +	struct lynx_28g_lane *lane = &priv->lane[id];
> > > +	struct phy *phy;
> > > +
> > > +	memset(lane, 0, sizeof(*lane));
> > 
> > priv is kzalloc, so why memset here?
> 
> Great question, but this is a pattern that was pre-existing in the code,
> and I don't like modifying code as I move it. I had to put a stop
> somewhere (series is already 16 patch long). I can absolutely remove the
> memset in part 2 once this one is merged.

Do you have any other comments? I'd like to know what your plans are
with this set.

