Return-Path: <stable+bounces-118387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBFA3D340
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3EC189D00C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2A61E9B07;
	Thu, 20 Feb 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RuorPP/h"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224C1EB9F2;
	Thu, 20 Feb 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040292; cv=fail; b=g33c2TzYis602SLjhHlbmyWDvCZYoaUptdAvd/DkeZU6LDUMECRI/ootzK5ye1qmsjwiV5/YKF63qsWl3QFP3H98Yoam/xHSQvRAd6CugKXwnpg0pW4qDEYXoxFZ0P55knux7T3ve4eH8uD/MbTLrLE72tfAmGuw6GYFqlnLt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040292; c=relaxed/simple;
	bh=FMS4Ffi9EQ9j6al5hIpLAyJ8TBhZ1PN/FdqVw8Ag/SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5z0TqCK5LzQXLYTDMWJipbOdfOBoVPt/rVmAMlPGPmz5wzRBj1GONvk1Sd0bEnlT06s2ctyEo/TPjnCOU/tWk5I3fLDNM+ptQ7kcO8CrShOEiH3y/3v3yaR29fpemkWq6sxiOO8AVHdk/3NHH36KZZ2Eq8IarWPBTlwfn6pOFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RuorPP/h; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ0o7O0Xmy2yBgGPj73XGtEgh8dDwETvzQJGBJqFaJ00TnSMcbm2IBOSeZErTdxJrZ9lCeZPuPhKrvCZyzruhgNx3Cm1S+i1GQY3SeF28B2xwLAEcvR4uYWqau8vuCAcw4D7sq9LRp46xs1SqdZddaJwwehLQYvhiCHYkkEqnDswJieOv7YcNcYe1T7uvyLVK0WaPwiZhtqZZlgbJ5+Jq8tHcbu9PaqJzWEOAkkBgCyuKqzpGrmQQgQ9PsWnlNRhosCFifRgvoIKXHNnIQ27R0eOYv49bCh5SsmqW7RnxdB+54U0J0WQl9HwvlxBkfwPmjCf2hqNmc68XcdUhC2fLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIiOcFK/5OsBtZ0Q1qX4POS12wEWWQo0otJbG6phFJg=;
 b=k9S6OnZPqDmesGbJPvB7U1LrGZA2eLGWDZy3VPvo7xblSyeK67/FNDBkK9muEZbK6X6CqloRHl7hEGZBZLq++q4r85K2KtThpJFiDFhKGnZTsT6YZpIeEMb/6VU1vSx+f6KEiwDDdHtTj6OGqqhhudMlNgIr+NAmvOGAVTZdXvvt6DxL+66AacnKI3zfAabQDGhpwcVmIJflwUzR/7Snm7G6b1XyudsjMnwTRkHSwlmrl/oRd4b9nwB5Cnoi5afq5DuauEW1DLiyjzhFOLUapMHrTB35HpPABvS0mHQYcAaYWqlvZ7rb9i7XN69G9aQ6eM78gdVd7Q//M3AkCleoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIiOcFK/5OsBtZ0Q1qX4POS12wEWWQo0otJbG6phFJg=;
 b=RuorPP/hbBzbawBU5VwXuSIgBNoLFtQAhpepy9x134U2wk2XeQc3uI5bvh6TNb2igAP3Ftuu6G8HGGPehoWMtKdPXwDg7zZWP7hXMPHNlBhdSOBMWlIiHf6BaSLH9OGhugC5XHbKVKWQ92mZlNxrcZ9GRYQy5ozoH/FsuwAjd+Fqmj4qywYWC/xB7iVeujRSHBwUIhVXFq0YR+x2OqwhQNup090PDTh/tv4W2WXUCsOmTZz4KQqK/5t9qsV4K4kCoXYTx8uDg6oz8w9Q3a6nfE1uHFSk3I/d3xlQCetf8oE2WWHiJIPqcuyYk9yEOgogWAUlf7KImtl+/N263hYRMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AM0PR04MB7012.eurprd04.prod.outlook.com (2603:10a6:208:19e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:31:26 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 08:31:25 +0000
Date: Thu, 20 Feb 2025 10:31:17 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, yangbo.lu@nxp.com, michal.swiatkowski@linux.intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Message-ID: <4thzzugomrg5ybn566s3qyap6rbrtdynib3cg43lwnigk32kan@wemohyixsadf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-3-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AM0PR04MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db9ecc4-f527-4579-7a07-08dd5188f6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MJGZzk4+MIrh9zyo2KBvpeaRqPPCbJtTaCX7sbBy1oM8qfYuRFs2ezKRntE?=
 =?us-ascii?Q?TLmLygPKKKCAo3WpbXK0N0aZvWYJN0kVlC1pnOlpPzbSMbm+qTiuZKX0JQvB?=
 =?us-ascii?Q?s0MukjJvCLSkE3gyP8PEbI46PLfB7e69ZGEaegpQ884yIKOfU2oBpHvHmKoc?=
 =?us-ascii?Q?gDfLzn71WRMkSlfKdx4lCVdEYNQH9U/1RJFl5HJ7yVSsw25yXHot8T+mHXRP?=
 =?us-ascii?Q?dth6mu4eYlP1zObJZVbd/0hIWmbb7nwU0Nl9ppxoSdRibEv4/l+3MxSnsl6l?=
 =?us-ascii?Q?iOwz/ffmLL9pQwLDEU4Oj8CXyNdcG7O+SuxjvM5QcHw2pB5HDUHFupsNhAip?=
 =?us-ascii?Q?61diaY+dJm3P8dzBNfQ+2NmTPAw7Tm5xEuGzKeD5PoMbqsB/O0rnvCDd3uUe?=
 =?us-ascii?Q?lVy3hKHKhqSp8+IqhczHh275bXkMgQW3f75FJfg1fYCFHK1SH6lFDIf+oApI?=
 =?us-ascii?Q?ARCeatKfndRqDZa6TUiV0wsNtHcjnDO+WondZZW2V4KxxzpDpWT9GEpYxK3N?=
 =?us-ascii?Q?SIRn+2baGpxg2qh1DvlAwt10t4w+bM+r1aLMqmpopqLKtRRyF4nUinupicQN?=
 =?us-ascii?Q?pdZLYxqvFFOEd1m+erGDMYVJRajs6WDz+Dgn0mrracm/fYWylzE2lLrAKb6Y?=
 =?us-ascii?Q?PKE3NKdeXt41a6fkqKNUffOR78M/92P9iX7ogGNXufnWeri46ItEZj2C6iO7?=
 =?us-ascii?Q?cKJeyUx2yVkSaKX+3/jSP3n3ZVVulb6tz+/u1koRrByZbkuKa5jQwfqQbhXO?=
 =?us-ascii?Q?lX0U4kC39wSldh/+LtHjSoZn9S1qzQLfKMgvD4wn5ja5RZXqqc8s0e728hWu?=
 =?us-ascii?Q?nZoJxiILw5dHT0EH0PGOcBiYlrJQOd2rg/aBXMCAbfKq5OM8GmX7XlIiqo1S?=
 =?us-ascii?Q?bVopfwgkj9AjK+3mscFi0Y4JsaBE+/6gV1VImzqP0K0/B8GdbjFccBXxYPUJ?=
 =?us-ascii?Q?NHKnaX8cUrM3AiT5IW/YpQB1Rb3REjQioy4lJwoRBvlsrf6EKbV/ZLUKDxRF?=
 =?us-ascii?Q?CMVg1m8110FlLQrdER4+UUj4eZWf6tu6Ec2tkauczlkqz9e7MGRqTY+ToZfd?=
 =?us-ascii?Q?x/i9btMfR+Ya+VwQMvB4yVNk/WJlXJgZrASnUazxIjBLJ6ilVRogsWwqahhr?=
 =?us-ascii?Q?nVUuQ28f7w1YP4RMm85De5b5YHMympxhy+i0aEKaZCPMNoXOosfZUYGpy8Og?=
 =?us-ascii?Q?qmRFvn8RkCca92AXE20+mv10RjHYp0B/9l3A+mCmVuRdqIs5f632pkJklAwH?=
 =?us-ascii?Q?dzf9x8xFtZKKbk189S36lWoeYGABnzwHCKamtPh6dBD8wN6bdBkDnRBlbV25?=
 =?us-ascii?Q?mw5/3vjls2iPTT88Br1VBvPZIDsKTQ9iA57FJ/wdGX5sVCCsrESNccns+zZA?=
 =?us-ascii?Q?nBPoLhBPqbSa+v0nrYuRoyfVYdwc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsUuFjIBs57qHhi/K4qOd3MZxtCloTUwAeDeXSSUtr91PHxQpKdpGSl+mH7/?=
 =?us-ascii?Q?9/HrleNeLp6PhXPbmmbmTV4WK9kcxpGOlttMeiFk8GSTr+o9693upZM2ep3t?=
 =?us-ascii?Q?Ob6nzZIcOAgeNiWt3fBgxUleZrfRc9qGpNcPPlGamAp4sT2HldFXW5Cpqha1?=
 =?us-ascii?Q?tryoii5LT66hq6fNVmD6Z7BgTqqiY5xVESbiZ5TXllOHdCuWJ9fkbWunhx+v?=
 =?us-ascii?Q?HA1pdHCPe3GCnbq0I1AP4Wa2CukSACJ7AzcAuJIjeIq0cn5IenH0u7bVVs8P?=
 =?us-ascii?Q?4FOJIxBVb8fJfk79CDczjl4AtMSih0yblXB3MLB07OtVCqgxTPgkMRGpByhe?=
 =?us-ascii?Q?t3qIjJAvDlkKpXMCKusLHMqMVDXvA0svON3e4mAASAuiR0dRieXTfxF1MUst?=
 =?us-ascii?Q?rhrChLr7Vj+ec9TKEPxpoZ3Hs5rTQw/GGek/OJLTKKWk7mxb9j6jfHiu1vH9?=
 =?us-ascii?Q?ryLRi6WAuYLvo4aP2CalpARMnIY3lbX4hxU2v7+ERUyX6s8tSuBwdWD+J4d1?=
 =?us-ascii?Q?QVzBvos1AOImxz5RFx4OsMC6elnySgZSeDjgeVYsOetYNFPDLRZLFSvp2UrY?=
 =?us-ascii?Q?aRp48e5JH73OYYwToiBGvXsGR70/Yv6VUonGOQVW6Ztpr9+eh7J1ySn7e+GD?=
 =?us-ascii?Q?URwKjEC5euc7mU6sdmpmc/aEgyn2CVzzoFPUsLeiW1qsnaWltaY6CDo/Wxd4?=
 =?us-ascii?Q?TIfCLOVf0lddn7scrRsmEVtjs9ubyBYvA0gGMPq2nNK8Zn2eVLYaA35JVdX0?=
 =?us-ascii?Q?w+NRMywIv3cY+Ddg3dLZGmFTDdEX0jwvgj9Wf4478wjwNx04t+pequ5G8XjM?=
 =?us-ascii?Q?27W1xi/oE1fkHYHx6TWhctyjeqBkvHEpMoXpE+CQIggn8QNwgT5BMSA3Y8O/?=
 =?us-ascii?Q?36DeNkiHDm5NhrarWPi2SbDURNzJJouhtjZOGCjEujtXzAhZFb9CUv0P4jhF?=
 =?us-ascii?Q?iK41Xt4DV98VAph4QdQM9qb+oG5rtKhbBKFxg0mY8FixZZz6LZKfdkBjvK1n?=
 =?us-ascii?Q?OnKFMroEJ2WwSuhUQ1FlGsHUM2nKeCDYPGZrQroF6SduIjinZp8zjH5N8SY9?=
 =?us-ascii?Q?q8hfeADmynwkjsytwhGVXHqrD7OJ5cwJiaqn06UCoxLVrmDqP/rL9mlnnkkN?=
 =?us-ascii?Q?eubV9SVTXlKaZ8OSnONJy/yeXSw04GJwrEmQScbYbQIlVGdt/RJL2l1LMSeu?=
 =?us-ascii?Q?LObWlguJwd3zosEhAuXp9E+qv9woY+234JFOmoIpm+d5zSmoku/zHw8WTV/m?=
 =?us-ascii?Q?CEXuNbyJrWsPzdkb4R4y0+c/uO5lT4irWZQO6vn/aiI2wsR8FLwuFmkbok9x?=
 =?us-ascii?Q?wg/dohJ4OXS9t0tY4INdbABVnHhsDTL5XfLp5mpbi7egqxfjkrANklV4A4Hw?=
 =?us-ascii?Q?5phCsncAXoNxvK35QjOW2fqiOyOe39bJFjyY3wrI7ovJc1Ak0Du0yk6RmJjz?=
 =?us-ascii?Q?/psirEsWFb6VOSOIkd+otJ0AvOik1XZMPX2hywU0oHfhg/u2qXDyALcxOQNY?=
 =?us-ascii?Q?LC9m8LV61ZcCpXie2FFvACKMq4sORcdAKtzJ+Xd/VqSgiL6Usvuggyd+5eCT?=
 =?us-ascii?Q?wIFOFEgt1QnUDmMmJ3RSDy67wzBGCiUUPw5Oxzt0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db9ecc4-f527-4579-7a07-08dd5188f6ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:31:25.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +X8D5Utx54P5XPzxP+un22yuYSQ+3Kx20ifEnFWorN65jgA3wdPcMgGAs51qgiQKG3Vdd93bQoZ65rwHQTdK6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7012

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

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


