Return-Path: <stable+bounces-194712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A530C5930E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E924A0047
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FB3659F0;
	Thu, 13 Nov 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQxymL23"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF33659EE;
	Thu, 13 Nov 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053018; cv=fail; b=IAo/A7MgNCZOkbLPC3AFEfyTkfKGhHmMzgyrwXF/4l5VJDgnpsq0PCiQYzhK7MN/sKAGxd5eAaRZ0lYGQ1i8Kd+lJBdieWtK1iEdgYV/+O187YVb+Ppr7gENweOwsrrrHoTPgg2j8cd78C5b874vK6tc8uQa6Rnpwf6AUUh6w38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053018; c=relaxed/simple;
	bh=C1pfNV7wQ9XYPEjN5FIyxvYgkV6cwGJV0FXLNB4xY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Osni2pGK1RGfL/RpYYPMT7aMSq/Ve7Y2InsbTLa6Gck2VqeFPrmhX0vvCVtCM1vg5BTtbzORBADBgNFPvMqMYXux0GutllVThYdxknAYHS38ORNAWtN9KuIAch1hLZbeVmsPYA4VXPvWr7zaesJoeK53fK2TW88N2VCc5YuQoZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QQxymL23; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjrf9IcyINFi2zIwTryh0TVv9lZNq/OAoN+LnHDRSg7qDvtDkjyGzus1hRUvKnFkzW02dC66w0KrQREqtX6mF9JRS+WDaCNUtQ8snS5PpC9lH8HGalpCuXioYq0HU0oXR4Q45fGeKZDP9LLeD6JzBCFxQagC5DU2YYEh8TH7izNBN6ak29z89I2Tg/gx5AShrOf0Fpi3+rxzORopLZou89HlznCWu3uI94+af2vRVG8rjqz20pRVHnI3u31y0y2CRJEwDVU29I7hrXGm2BQ/l1HKI4f5jrvguSZQchvx9bpRmmWv7o53Ijo4gDmWfrPTNAR48BTfDaG4E5rERE9e+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1XihqziW4npdm6ovNbVSBt3ttgHs/96ZoPoMzvrI9A=;
 b=n2ixu60x8nXM8BMMPx1oSSCvMrHCMTZdTyXRkj6CM2m5hdUDN3+pWcYc2ZsEa6J66QBX445rXWetoOnen8SO9PXeCn6n5fINJM6L664/5WPu4byuneheun+0HA6+IX+lBRLBzJn2AmlO5swpJ1m8u0JfStiAVKZqbJ0VeEv3DDF0B+dutmcemJ/ZCwt7yLCQwQOFbSFtgKcY2sH8gH2Xanw4t4IHvMRh2x2yTJWcg2ibLBwxNbNl4JwsNFmpJFhTIw7N8Qy9FQMokGqijpe5Kvc6ebQuWw2MhPJv+JycjQhCgEZSl5wJ+JEutodirPrVlnysxcEoHH3UihXRbLOq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1XihqziW4npdm6ovNbVSBt3ttgHs/96ZoPoMzvrI9A=;
 b=QQxymL2394zdb4pVshUWD01xUar+DDXKNzoY30XlTi9G31dG++cYv2y2mn11IUJgHxRxZa53f772jiDO368caynhr7A0s9w+UuUSHDGpZXOLJkmxxDSmA8XSUSHXAceg+sL1CBxX3q3DtABK4FAywiDmivR1fB0Fdl9SWxpC7yEXCUuD7kNmZJFR3MN4pOuo9GdjwMu/AbB5qB92TsvWg29/zxwKC+IQ+fNK8NgfPKMuOKvsEXOJ+4T0Xt+cMmIK/0n1av3iE046zYblKykLITewNwp+b9D8SLtKXVzVat0lPEZo4z74dgwLoT6melyzRDRAeOmcSvNSOKR7k7QWdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB11275.eurprd04.prod.outlook.com (2603:10a6:800:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:56:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:56:49 +0000
Date: Thu, 13 Nov 2025 18:56:46 +0200
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
Message-ID: <20251113165646.bopsvjiipcslvokj@skbuf>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-3-vladimir.oltean@nxp.com>
 <aRYMM3ZuyBYH8zEC@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYMM3ZuyBYH8zEC@vaman>
X-ClientProxiedBy: VI1P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB11275:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fe4ed1-f188-4190-114e-08de22d5a302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxYtrtv6+pLSevHvHx3qeaZp6do/BaE24VXk+Bmz1e2yInOwJhRiftX/jQkL?=
 =?us-ascii?Q?V7cNKys4dslGrj2oDasAwfn8knLjosd6dKX+Okgs1d/wMS1fdWEYptANWUAT?=
 =?us-ascii?Q?+YXLHipa9OCsYjJyrFEOtgaV/YpKhAKyrC1Ya1o+orS/uUq49C0d/UiywXj0?=
 =?us-ascii?Q?5iDljkwV4F1EGS+uDdWvyISkmUR29jtJSrUOy+5dDDKsQLTC3ZyJ7b5bp70p?=
 =?us-ascii?Q?IY35PivA7/6Gh8d3u28HPaGc3abLuXbThVBXXehRwjrOPMtNkjk4hPMK06a0?=
 =?us-ascii?Q?tAbN4bmORssdvOZMFAV+NP2dcdyZzoEXF5AzrFKHhpsfXOJBj/IvHeIUiQKD?=
 =?us-ascii?Q?RfMMwkOQwxewCuL1qN3A/91gpYFgTTMZ0InQepdIhHdj908eixuujN15K+yb?=
 =?us-ascii?Q?MV64y0v3oQbjCZkgjU3wIrCXgNPSe/O7xoDr2PSTnc44lCNto0BpDXZnjVSe?=
 =?us-ascii?Q?LlWFVwd0YpDuY7Fyh3u6PKDvjYi2eE8141hQfCvcBI2fjtkkdZJnyLo5RuHx?=
 =?us-ascii?Q?hDlBLkMnoHGKi5DjUt4Y1Cp1Bk6RzreUxX+33GdDAgu4+PelsqIUxJDZDK3T?=
 =?us-ascii?Q?X+nXcWqtTt+hV4fTUxQdvhvA4y0+Q2NF4TzK4g9ulvvHyYpsYap/bKq4f+up?=
 =?us-ascii?Q?+zPdTtSw+1clAGMHuGfT/3vTTbp0ALfcBKd72PkDD6jYKT0e5WKn7V5y30nr?=
 =?us-ascii?Q?29UpRvSQdocz323/U8ePM0CfxiQ10CzKyzCmneVA66iwMSu/T01MQD34O24p?=
 =?us-ascii?Q?WnncsQva0zu7MP+6/33LZyFpKGJ88swWQfadFu3UShaIfMQtQjb8XCMVFbfw?=
 =?us-ascii?Q?BlenTnvZ7hesaQ3F0gZ3KFK/MYFx63W9BeILg+xpHTc47AMQVLV60PC3GtuL?=
 =?us-ascii?Q?zqWObZ5lpYbcQQW6txlHwy+3Oqj2llEItBgvqWtaLnB5GGDdNAQBLG9oQD8k?=
 =?us-ascii?Q?4aBMwYMoA+onMjJX04rQiEAAxzhOT61s9FgAMFQyCXTzE8tq54fs2epx6rdr?=
 =?us-ascii?Q?fCuYEQOguDXEwfxHL93WznyuNVgxRGMt97L3cHdwMltpvis8qjXbxYRzJg5z?=
 =?us-ascii?Q?Pxyf4sCM8ZpPDpUHZ+rBlAwjGugIi1WLQZp//42U8e3LjdwSW6sPZ2RqxILk?=
 =?us-ascii?Q?Cd6PrCoZNV7KKxaleEa9aoFjTcKtUuA3YWf/y77vh0gCT8GDCBIp+u4Xt3gq?=
 =?us-ascii?Q?3zteEMXe6KZhRxVVK3RLg81wXpXjZ9xZox0SfsLiMB+EsCgxIxAvXCaKvsK3?=
 =?us-ascii?Q?+s5BJ8PW2uiV3+k4C9fdkhHH9vFhwTzz2jnqPLEk1CN7USOE9obdyTlf1gK5?=
 =?us-ascii?Q?B1NP8gFpnsIDqiogJKHUy87GIaEkO4l7t6NKvth+HiMqbCmf8dJhlGclpnbj?=
 =?us-ascii?Q?XCxLeTDdk9eUmLNl6RoXBCrz2+g1+yuI1fW9IpKAzN8fbPhV8qsbEOmJppCg?=
 =?us-ascii?Q?f7IVkwuc+3snjEHc7yhvYMwwLQ23B6rO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Do2JfyfZwvIqedLtBMUglxQy77VW3JRix/cYt+2z89H/uFt/jVirbt4YPOQP?=
 =?us-ascii?Q?z3tI92aWboCxJXfVHSvKK1YwD7QEYvU2/MhldRo1zZh6IO59nEGC3coXoGzN?=
 =?us-ascii?Q?+qB3uAYQqgIK375Y54SX/X8km84DwVXcVora/unwOpTEOOrFa6KpFpM06drh?=
 =?us-ascii?Q?t0QDidHmrI/0irTsg23mo0pbRvP43L/B0Pluh1/6Gmomow/k14E5gFjwU8Gj?=
 =?us-ascii?Q?hxsrxuybSIPdCz3KK1lNNEefR0y8TcgVijtnBcdSCo44uYO0UjOsrrclTKtg?=
 =?us-ascii?Q?RZ70Dvbs0OXZf0xl8/fN7iP/9pShhr/mMkJ2me+oYLYWmJNjsXA8r9IxpZGD?=
 =?us-ascii?Q?YG2mKIQzUEX7FVLoUv4O5fGym8gZsdRC6MbRE9EI/esUXHSUYEvXZlu7cbI+?=
 =?us-ascii?Q?wuherwStqKKcGwurCgHsIBZ+jDaLI4Yk5FMWIG2UGhoGTeUdUf0qHmYFbrWv?=
 =?us-ascii?Q?N9yJPAeMfLq/p1xEJBZqDSLnTk2JRl02lSbGJVrsAXQGhfwmBGCJMyZf9FSu?=
 =?us-ascii?Q?p94kzAREbUd+w9MybtHxzAsEUpwRjB1raofQLLXAdopFU4BfTGAP5xjxH8Pp?=
 =?us-ascii?Q?qGN80VAhtNKU4lYoZ2dLPd/ByLlOAAptmbmKPYwnlrW6o5BjgGKbAcccKIvn?=
 =?us-ascii?Q?XsE5+ZjtPmAyo7W2D2RaDDpelCaJfC7OLXcYX3T4m3ylmv43ZgJe6h+K8opP?=
 =?us-ascii?Q?Jc4gnLFHuv4mKlNBEREDwB1d5OSH/IXU6yNavgPbFmCnbdJK4YuEJP6IyBK9?=
 =?us-ascii?Q?i2zaY7tX+NkDXrlYmHjG//yvGZgJokAYffSjylU1Pvri7+WL3aFdUNc4Wumb?=
 =?us-ascii?Q?sD5N/7PGwFWOsH04/TJWG/Wbaey6SMR0cQfzqz88hqm2ZQmWwjap3x7C1LDF?=
 =?us-ascii?Q?0LEDOpjGsIOdS74i3R0DKa3m+UWudperfEDlww3GpgGveukWFkyERZzWShjq?=
 =?us-ascii?Q?JkMvheEJNx43d1Ay9xnkBPO4CkP7WbHpS67/U1ei9neiLyqUIDqWwDNOSrE2?=
 =?us-ascii?Q?0QD9GsYUrlRaNbszHgOFwQhUO/I6+rSC5skvh5NPVHIrH09bCpa0BY88CkMq?=
 =?us-ascii?Q?V0ucvLp31tH0tygWr3kErVN/Tlx0anNmPkWS6N7DxDOgb9CkuZFLn6G6RAfC?=
 =?us-ascii?Q?dY/s9IPgAVFmrYYb9bG1mJXsPYklGQb0NuBinTA6B5PFF7oJKz1r4IVDr/Zq?=
 =?us-ascii?Q?WcwowLkQDKzXMmwMh4S6vmV731ZsoKZxGbof5mu7lzIzmESa67bSEgSHX0k3?=
 =?us-ascii?Q?w0r+eCaA0DwX7EDQuNNxuuPliaVZxZrKv0MG21HdAQqPh23FHZyPVrlU4YLv?=
 =?us-ascii?Q?f0/oiM+caAgrQ+dNHy0fQotxmo0tezXxT9FHF9cK7hzZN1ypGR0OQRXwaCf+?=
 =?us-ascii?Q?+2h36l57Qn0wvM/2btQ58S/VxO8il/H593ckrHVNzKjsrbJuz/cK8iMHoxcm?=
 =?us-ascii?Q?JAietM+eL57vclTcIUaj3NefFQARTSJ+3WbgyWfiv8mEU4cVWBP63MVc7TTk?=
 =?us-ascii?Q?MTaMZlDTYC9WYS1/t+KjP+Bx+ibU9idb8KjZdrEBwFcDjbf35qzUeaYnuEQP?=
 =?us-ascii?Q?SMM3itWphnjU2tNJqaELskR4xH3/uO6ypJyVw9MSfi4kxGYMjKFl4MbPEQVn?=
 =?us-ascii?Q?FNRc2E6XwtyOq/Zl3hJEGDgeQbXaXUvMNsB31TAPdaV8NqUeAwvN2qLmhW4v?=
 =?us-ascii?Q?/5KhIA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fe4ed1-f188-4190-114e-08de22d5a302
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:56:49.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq5ddQ4oDgVa68E/lPD0trCjNbwH+98+1pR41MVRoWuP+lx9wgCcFiCbqZo83QHWQ0IJCgSCKx+N3Mgtm26+Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11275

On Thu, Nov 13, 2025 at 10:19:55PM +0530, Vinod Koul wrote:
> On 10-11-25, 11:22, Vladimir Oltean wrote:
> > diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > index c20d2636c5e9..901240bbcade 100644
> > --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> > @@ -579,12 +579,33 @@ static struct phy *lynx_28g_xlate(struct device *dev,
> >  	return priv->lane[idx].phy;
> >  }
> >  
> > +static int lynx_28g_probe_lane(struct lynx_28g_priv *priv, int id,
> > +			       struct device_node *dn)
> > +{
> > +	struct lynx_28g_lane *lane = &priv->lane[id];
> > +	struct phy *phy;
> > +
> > +	memset(lane, 0, sizeof(*lane));
> 
> priv is kzalloc, so why memset here?

Great question, but this is a pattern that was pre-existing in the code,
and I don't like modifying code as I move it. I had to put a stop
somewhere (series is already 16 patch long). I can absolutely remove the
memset in part 2 once this one is merged.

