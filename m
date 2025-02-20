Return-Path: <stable+bounces-118391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BDFA3D357
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316043B1DC3
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA81EA7EA;
	Thu, 20 Feb 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gd4QtSeK"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A745223;
	Thu, 20 Feb 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040637; cv=fail; b=mYLeMyOXfH64dXzXlaM8D5ua0dwaVxJph4JQ5APHkSEjHAWlaks/qHj9r3OUiOV1cNO6F1pdmzU1YeLtaDrBWbXx4Fe6wNwkBlecOg944CvFeROc8buaWSIAokqIINcYyPl2ytsLOEdJo6sEfq98QphZeIRKQflVLdhlrIV0bp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040637; c=relaxed/simple;
	bh=jguxd3TAuXyZnte/pl5Sy1CzxbOmOCiQu2PQMpz6Yhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+KdJrTSKHkTQVDFskrLTU9+3qNNNqbWqKYiYizAEYdcXrByzHD+UcXd3dUz6ydJZi1rq+GkQkIM+GIxkzdLcDyg5uHvtfjGPuIjiBJmhxvr/mfrDDtW+oxbjTaOaj0L0/U+mvXCcqaxkCh3hnf0tRAuPvD6XDKt058cb4E/QM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gd4QtSeK; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnFf6Nf5Z6PDIzBARXhFaru5ZYPuZ4v/cKJ6wyeJR1xKitV9eBPEiyf0WLX43LOtkKpvK404gRGIo8lsxiRuqyU0g9GHcf9Svd3q2eI0IvSaNY3cpjpEAV5JngkUR5yyVLedisFN1rGofmWZInBP03Mv+KrrKHWidMKRbv8yJWB27y8I+IsM4XotT/NXwlLQ8McTE5+v3OZdyQ9sLSdM2GwOh4xfxeLsl/FWL8QAQukrFiKvH2EdNAK7E4+LIoS+iEwdG1I4nTzpKJnrtWcPplTd5EhkLdI7TMUgm+i9W3U0IPCwxkWdX6ineTRMJYslT7oF1R82JZRzE6Gv1IZ/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkCwtT2hLOQ/XRROZD2m3wPu4SMO/GcE3NyjPYnkFpk=;
 b=Hpycbd8pi/j5xo8DfKiFsA6KqwJsZyi6UyAK4PIRNz3FTNWTcrDHIFBWFk/qratW4aI8UqOsiLq0qOC4uoYzI9r5azJpyZWkL2amVoN8qPrNq6ikKBOJcbmr/TCUFNzUewGRbEdUSMC2SqnMB1G77J4ZpRMP5Fnb3jlbVHsjdJ3WCj5xd8VqKcTXuR3Tqisgvm430CXKXuedULT6RKnj61v1JoPD9rvr3P3NS4jZPcebYY1L5paQv25McXKEkc2/bLSStntgIpHV5qiAmlGvP+keP4guj/JbJ/Qs7Qbe4+hLUYxzO3+cc7DrkrJv2OBjuduyB0GvFBFBnTmZh/Hz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkCwtT2hLOQ/XRROZD2m3wPu4SMO/GcE3NyjPYnkFpk=;
 b=gd4QtSeKDjm/o6k48f71v0wzu5hMHZA8FqPjWfmlSbMxqsk4d0aHVRVetw12d0RqUYzij2c50Y/3Pf3MWHA+Uq5iDC5dkA9P89P29ueMATFmHIsdPjELUUBYt9YBU1Ag2H63IEpdBVeBjsLNQFHXvqux3wNJTSVKxB28riEz418uounfEW1S+3xKBPizstJAwSiremZIPAeoDC3KoZ+8S/bz0r7gDz/NUept80R0stnvvQOWKRdJ8y72x6JG6WAmXbTwV4iprXBa5YnQEBsFdAT26sdoVZ3MPRS8UXhD2A62c+f1yodNv9dD6QCwSMTaq6GUN+H1udEIliGduicQfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:37:11 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 08:37:11 +0000
Date: Thu, 20 Feb 2025 10:37:03 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, yangbo.lu@nxp.com, michal.swiatkowski@linux.intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 3/9] net: enetc: correct the xdp_tx statistics
Message-ID: <mux6k4afv4htairial4ssmoku436rvddlkhqqmczcrra57enj3@3x4ab4prgeix>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-4-wei.fang@nxp.com>
X-ClientProxiedBy: AS4PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::8) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6754e869-f4d0-472b-2af4-08dd5189c4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMlZlraREsBtQBpP+N/Xf9Fo/dwseHgInB5cABnP8hOt1fbqQddvdTKYiX00?=
 =?us-ascii?Q?rPUfUb2E6BI51mwYxKMKUSY0F8QBNyqpEQCfpYxzvkQw/7cUu2WTVKeqp2IC?=
 =?us-ascii?Q?bC4pyz6aOovZltVx6LzsSMLl9oDnS4upPbnWyzNsYZRHgsIzGIY2kZilndpb?=
 =?us-ascii?Q?I9165Xhz1lMqLF3ciba/Q1YESok1VXQ8vRl3l/oBrDWwbBGIs2U1yNSrZRH4?=
 =?us-ascii?Q?l96nrun81rmzTE37tU30NLHbdHO8quyq/q7o0Krgnn4Npdvgu8mhxmoMzyns?=
 =?us-ascii?Q?sHzZGclV406sjJnxzl5LvAcdh77ADMQDvEqEdLGuVkLCxfdJyTdN++aiQd8s?=
 =?us-ascii?Q?m4R9pN6VQusvQ5sAClQCfqV2TAQv8Gv8ZOUfUDcwhCjvQcrpEkxeGkAO9dns?=
 =?us-ascii?Q?DkjCTeqLpPMOGYP/D7hJAdPblj/fwuZ9UbPQGk9Z5kpPbmt8J5jagrlHFO6O?=
 =?us-ascii?Q?JnE94qQ1hvC/qNUC8B2vO5D9HURnUBUXtcq77r1ZZUn7s4o0DZ++3OHCmTp1?=
 =?us-ascii?Q?Wpn10whb+qS+xr3grCI0AfQ8z9LPYOi1LElYkKLSSiI0QLekkqcB4SOaPVK0?=
 =?us-ascii?Q?Gfn60c6MoclmsPTKHG/Qff/AOcfleOPBCkIwE90RMdwK/r1LB0ReaIo4pD8y?=
 =?us-ascii?Q?cIUqVv+CQbW+CZQCLjvKQqxBo6vCOuCm/4ItqY2N2zDb/ozD75Nn+nNLCrMT?=
 =?us-ascii?Q?CGpbrlnbFFltxunuZk80AJi29HktzdMdJcs65/WKacdtr372RXLMv7QA770C?=
 =?us-ascii?Q?UxXt0rKQM7x/i8i7IvvS2V4Xe7ULLVyUI0Y7RFfVDQm2W4wp4a/RCFt5EPd1?=
 =?us-ascii?Q?lcwUi7oUdkEXqNmOzRZ4woSW/nZl7N5oEP5qFRVV4sAG8ZE9Mel2ATLDeTMX?=
 =?us-ascii?Q?rE130SSZ0/CiGCJDEeCh5iEF/uVNm0GwTxxh4tTmUPbR17EG96t3bpDpgBa5?=
 =?us-ascii?Q?QA0MK5NrpJ/szk77WK8dZ82z0wppIcuol21+EEvgIwyULANovbSGZ+4ib4eq?=
 =?us-ascii?Q?3W9Lvz9v+D6sBN3h98n17ESW/Tc4MAcDYTN6VF4thKehSpY6XGOrLS8sx+0k?=
 =?us-ascii?Q?ApLwSZGdkiMabBSy2vOJDIFyrygFquoqvvJv/UGTcYNKqXPyA47D7VaXA3dj?=
 =?us-ascii?Q?0XdE4mYO7LTYKnLm4ZYhcsAs32XP7WvZXCFkdTGArCJrmnzPUdSfn5ix2Y2n?=
 =?us-ascii?Q?3mrJIuG2o/T8MCZdATZf/uQmP9mGG8IMBBRxOkNwCEcj8fizW3HOq46nucfa?=
 =?us-ascii?Q?AFRNvoEi3AphagZGiNIqchY+o5OEtkdIhvlBVPDk3u6dvPUMREIRwKOi/qON?=
 =?us-ascii?Q?8yiXpCVkFSHESJvMCmhFcUBNA/24Zd1vw2R4cBmIKlNO0r2iu0tc/ORiuWUU?=
 =?us-ascii?Q?Mq6EaqpsRev3OO1OZBeFmWdfp4qk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mK2JkVwc/yC/0D6GiITi4yjXXtot43WSi8FFtkqXjlualFpTp3ORR/jW8kTu?=
 =?us-ascii?Q?gdOW3KH2B5JHvsXeopndTSiRGEWYN2zkSy2N7RheBn9GqWlzEonqi+35eRwM?=
 =?us-ascii?Q?9AUKO66Cy7VYeb0eLHTGsDaGci8ohDxfB31NLzqM3q4B1/x2kqsPpfC+4ZMz?=
 =?us-ascii?Q?EDmoqRsbjtGIJjXirMV3PINBVnEnS9u3PFCXv5zw8WBZ3NPgh4xAs5bmARA7?=
 =?us-ascii?Q?ok91bwchdQT3pCbqtI06qr6xNuh/WuUbzeZ0rH+anULi9YZMhq8GPnh4rumr?=
 =?us-ascii?Q?am4e4g+6LW1spU1t6p1ATJe7+EGtBXRH3OdzLRDU14rPUBG8Q6xNKIFRYX6k?=
 =?us-ascii?Q?UI1TxC1cfjqwJUYtAlvD1taCfwG08IhKQhjF1S6MrNEIAMrl0IjQyu115oLJ?=
 =?us-ascii?Q?J8Nbefz6cuV9nEWGrLnGyJeWxGl2ZnG7DDvgtfENptv/EA53JKqtYP0pHrUJ?=
 =?us-ascii?Q?jWeGpRMUF9Y9y9D4M5CRMjw+mZx0z6QmCl5iQHDgE28jDyOXvL2yJGQmdfkn?=
 =?us-ascii?Q?Mon/rA4jDJ+mHSCCrbETZnz3ebqXCMoSaqUe5tbiNP+LRSIRajHvw1sAZ4/U?=
 =?us-ascii?Q?3z6imbZ7OrypFryogVkKZ2P0rNracukSjKy7BIIeJQJhexL/rjSdAjEXlMd6?=
 =?us-ascii?Q?Zbxerm4QUhlrlCS0e9PSOBJ5852d43G4ds4lfp6qo6gz5kGLqqrmkWPEN26V?=
 =?us-ascii?Q?TYtmaiX/7WhWGcBKxFR1r7yC8BttXhj2XgGn8jmGuS5xqaNQmjABBF+f9mec?=
 =?us-ascii?Q?UOIDXwz/aoP29dHYO6YVRmaQnHXDnEAMX4fBH6XbnRcoVIEskZWSw5y9G5Iz?=
 =?us-ascii?Q?VPPqO538tiz83N7dIptFz7GT/rhpk23Dsv7VsJKRF2MHCXQ5fjFGSrdTRulR?=
 =?us-ascii?Q?y53ZG1T2lUvEZnZwVpJznEMd/i+YWJJwwr870JJLkrGPFg/+3e43v5i0lnNl?=
 =?us-ascii?Q?f+/+urCM1GTqiek0V7gESv6zWcwLQAFUsvksC4K++9O3G1e1PFe1fdBvGVgC?=
 =?us-ascii?Q?IwzDWOfbo5avtQrysWGM5IQ6tQzRTKUdJbcQfNratKvJPXF1MzzX9BFQk3U8?=
 =?us-ascii?Q?jAiZ0paqrihXNT0RXpoD2zfmtHG49TbuVnPrnOJu8DM1f0VjWC/kdB9RqoJR?=
 =?us-ascii?Q?E9i4Wb3bAHTtitcv2dpMtEDiyamzf0ThdHIqK++r7nZ1Whpxyz4Jc9vYZLfI?=
 =?us-ascii?Q?r3RraiIjrfDfJE9Pv8Zq3FiD4fWm1ynAvMq3OSgm4iwFuD93TWwv9bQgQxYw?=
 =?us-ascii?Q?wjZxe/9A8ZT/KZM2dRK9waaxe6lXGYeDL1aV97FuFT5NYoUxGxAdFFHDYHDt?=
 =?us-ascii?Q?nzMA9X7J4kUwpWG6FBQ9uWfdUh1eNo/30uSEdCIDcLjbhJnu31UqNzMRVf7c?=
 =?us-ascii?Q?T+d/6ru2KwMubWEqBAh+bqyVOPZxDuutR3O1+M3mzXAuHvr2UlN5TaGybeGp?=
 =?us-ascii?Q?oW3SiqgVv43IWxfCZOKyo84ET/0eHZ6BvPbe5jLEygJ9yWAtp5QkTkNC+7Mk?=
 =?us-ascii?Q?lk8+YQuwVly/REcf7Vbvn7H0wYdXmS4w2ny5ARrzXwwZsYL53kK36UD+zfzK?=
 =?us-ascii?Q?bCA68Db1mPU+BwlCFWwYEHSz7Nd7iEZB+MKh6KLj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6754e869-f4d0-472b-2af4-08dd5189c4d2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:37:11.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glhkeq1LbeIVpzcF4mJWtVQlJ8t6yXfaDSwvOMo2L70diLyas1r+FKwBufQOYQr6xOs7xMpYRWimWx4Bsu+n8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718

On Wed, Feb 19, 2025 at 01:42:41PM +0800, Wei Fang wrote:
> The 'xdp_tx' is used to count the number of XDP_TX frames sent, not the
> number of Tx BDs.
> 
> Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>


