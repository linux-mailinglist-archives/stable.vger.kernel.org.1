Return-Path: <stable+bounces-118467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF9A3DFCB
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D6418927C0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E9204859;
	Thu, 20 Feb 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h6BRf7Vs"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD920C034;
	Thu, 20 Feb 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067424; cv=fail; b=OYSDQ1NPBl/h4L5bQ7/3TrfzUiAwiiwz2lm+eEy+nXKqgi+2e7zc3wYB1CbietiWcx8WHzfAQ3SqlyfJjJ5QQ8277+nodloIP4/sVcfhc5IwwBVJFr7Lvp3Ne4mh6zguteoGu8ZwzR0EKYLVkhVJJZeDjF0fTEue8xi45ppKKMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067424; c=relaxed/simple;
	bh=0A2EU8+/NZuHtwoa9MKezDMkYFj2OYjtI/IMwbfJIIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DABXCcSthpL/Ag3TsZtwQQzGjsolsKk73Ve6lJI8XBtMKhmEsWMRFzsB22dtonygUFlP9CO0BgrMh3zOKpBprNPX5stkUSX2FocChzvUuHCTi4XdfW1gtX+27ezPrJWU5vm9A77Z+0onlXcTyOQDUOQf8AL84Pf7TnrmLRP4+ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h6BRf7Vs; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIwPOIz13VAp+5xD5fR9f86h4oOL/MCHl/RAznRM0J0HFWLsrISYdNz5mJw+euVELzvXt4Ee63hPSDgku3N3q8c6CVr42XHr42yunXYMbAU7OymITzz727DWXNCoF4/bdb+5itQn7wewo0tipcIX8+U2qoV0uBOwYEcmcHH0m0Slw2GJAch0GgnDZQmHoBY5dSbSkbped9lKOtr/9t681gsy+q8Gcf4mylA5oq+T7Z45XdASVCk0xTezz7pD6sT9MkrCx1nXodTa5pjbDZshMxkdum94LEUuuwmFVMxNgiY5SRKYDrFd9W5YB9Nlsbj1XBTgIBw4JqA08jUid8eB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfNAZ4udD2jw0eILiGopLvIvjnUd2I7m2aU7fxVazdo=;
 b=J0iIDM09C1yL3+ic6TsxWty9qg6YXb8T4VKMJdgw4CfzbsH13yKp05jHBoB/CXoyvnkSu7e6i3tort0rd437iZLl3wUwPOG0eSIxy4NquIDLw7bdMmmP2dSr2YLsiclya4nn/ekvMOznElWimjIZLQ5e8sMia2jUJjnpj8RPoHWxbQHlBNMTWFVgrYTygc7nXZTYW4eu81h6euify1H2qEir0HgplnEQX8m2MoLxBfBQ2B/jDKOKbxW+cXdNn/VPUqGA+ZUXdmvsprslQnQsQfzmrRyTF/9A9R8m+CwKcU6fXjr+HH+mXH4Tr4m2/1rtGuMO05S5SlTGxQgtM3JWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfNAZ4udD2jw0eILiGopLvIvjnUd2I7m2aU7fxVazdo=;
 b=h6BRf7Vsg7+RX6eNgcCYUXQDj4ngAJGFasiHmV8PsSCftGhBuw1jd+reIewSCx+lF4OUmAX4NJeazFGqahFQd7zMIXeasN27ZcD0SrX+GgbyWs6aGgACURcE1WxkAX/mxlggDkGxDewl3tTBi71d4Jy1rCaHCNGKHUMxGZK6RLWkeb56pCLi0lAqSUpT3T5ouyHhV3m/uEwj2MDplSbPuIpbklrqt9VerDuRGSNDYlYgQ8ys1GLIx2lB85TfIi69E4Wnq+6mQG84Bru13kiA7Dm8hg7fI8qvjR814MS8qRhmD7pFJzScVEPfVIfqLGM3nk18mWDlvxVwaQTyHkjFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:03:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 16:03:38 +0000
Date: Thu, 20 Feb 2025 18:03:34 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 7/9] net: enetc: remove the mm_lock from the ENETC
 v4 driver
Message-ID: <20250220160334.klrmwnssrakaebc7@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219054247.733243-8-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: eae6d032-e8bb-410d-9d92-08dd51c822f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QFLm5mlPuNCAlFJDU0g+axdWme/zinAMr0ELUq1hkGIzwkA2nGE5diYwnrd?=
 =?us-ascii?Q?pS44Pm7jTmPflQcmRPwxGGm2xbEnCaJEeAd55T1FPo7NMJXZGtgcWdsUBXfc?=
 =?us-ascii?Q?Mwgh+2yzq9i/Cpeeqg5gPyzq/2Qx0WdkO/isr9pvn/hOkWDkftMM8fpKx4iU?=
 =?us-ascii?Q?hoTme7sAWbfCPfK9VaF5YkaMisw08j4u8ioVHEBztGfyoD8aVic0PIGhFGzf?=
 =?us-ascii?Q?1E5OSye+YBgix+/dMY41JZoOMK75Zbp3X6P9XCDEerV1F3KkMqwl5oQXSA7u?=
 =?us-ascii?Q?erYN6InwG/Ry6k/4R1DCRk4alDdb7kckuNho4oH+GQXEWKyWRz9m7vOv0py3?=
 =?us-ascii?Q?7DSYaRz0keBjT2OEduDnTn1LOaFqlqcWxPFjfO7l6PzXM6uajeG0fnL+UkPJ?=
 =?us-ascii?Q?d9gjiJ6qFXKA+0E47T0gynSDaL7djK5vCNsGDspmXHPTDLU7N8qEgt4duLh/?=
 =?us-ascii?Q?saCkN4YGzzNbeNEkfHDXBe/HPFI/JIzjtRPc15QgFWusNHsq0f/XiIAg9eWe?=
 =?us-ascii?Q?hsRu12c4sBRDtIu4P6JZJFqggPnZdX+L02zMW1SKxbTaIBT8l6IlQ3/GJ6fG?=
 =?us-ascii?Q?nA2/O38VkZE2nnBUA+MjE3HE/YTYCcdgzsslNPr1dEcqBUOqfG1U5ejSiQrL?=
 =?us-ascii?Q?gmUphwAQT0EKZrKEzhqljynetpzzCcEOuqvRQIXYA4aCOFQWmE6nw5kmE8sD?=
 =?us-ascii?Q?LSbjAqpC9J5+8wnnMVfuJ5QaX12TJfuV7NfzrWdqexWPOpEAOOdr0CMA5ynn?=
 =?us-ascii?Q?6U7wgrcClXxc8ZTIzQ/gyxiC5ej5q/fDab9gf/3xdumu+Pyb51FY+2+48+rN?=
 =?us-ascii?Q?sKsN3jmOPWr4VnCEO/xj7zlo6579xqYCIeYtGZNowN2Hd57X1VQtCFLBUuss?=
 =?us-ascii?Q?GFRqsvHsYuR0cHWrqkcVmWPWaWV8L9vr+fX/R6AjgBnXA3vse4ubHsXxRqjz?=
 =?us-ascii?Q?+KckC3V9oZ7ce18RLOnWUzcDWn7Y9UedqE2UceOVXl0rg1o4DQ94Fnofy4eC?=
 =?us-ascii?Q?ha5JPzg7JRWAad4rf8UW6NIlFW0eD5LUF1BYnrdG+6bDIHrx3onbUXVtwa+H?=
 =?us-ascii?Q?KaaHXJHLrd8MWNMstop/Vst6JoGuN71FZKkLja/AeUQJgQ5QvyXuBCKnF4Dh?=
 =?us-ascii?Q?vRx8yi2bR14GvxGs9+96vqMKbiaz3L0jAZDkg3feMyUZK3c/Lc8PebKPsYwy?=
 =?us-ascii?Q?stLHcoaG7v/LZz3nyIPfoAWxmx9kFYSSlH78cjr0Oukvlxq8v9jKOWRzx7zY?=
 =?us-ascii?Q?GpIlTYBSX71CsWEA9FefdkfeBbaOxtoRXdx1qwBarEUkL6AwfQtdnccoeuAo?=
 =?us-ascii?Q?/kDKTq5OEarxmDntwUuvWYAuvamWlkfNtBQiyhAOj7EpcmWpRjv4wUnEbb/7?=
 =?us-ascii?Q?qyGTr3kwrI956eURNBhCjueajeRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3E/dmGO/D4zFmT06T1eZTeCfM905FidvuzeiZyJEW15PFJwfmIo9++IO/JJ?=
 =?us-ascii?Q?br63uAnCJ35eFtJySufORZIDBKa3L9z0lH3LniQTS/P3FkOmded58+O6iJMr?=
 =?us-ascii?Q?O/ZLU1WVnZ25X4WSAB6UkjZCrcPCwKzbPKb3dU4eBd7juy2wC/5vzQ1vZFEI?=
 =?us-ascii?Q?u10l023kF13jZDTcpHZkLmiFJCvBOZi+keZ/2Zo3EUNLKkP9o3TMSJjhKFV3?=
 =?us-ascii?Q?JE5hIieBqlV9x/HLySoSo3hoxZbAzuGKkbWapNPhp6ldNnxAECXS7b2beX/V?=
 =?us-ascii?Q?kcVpgWSEZ9ejknlXGE2kswjjVljkEBTqqXHlnsP4nIBndlswrsssI4O7Ke9f?=
 =?us-ascii?Q?q7klNsVFvKHqffA4GLydidS352U/ZkI/nNmDFQ9R753nkDEPluKuMsO7X8q/?=
 =?us-ascii?Q?pM30raN4vF+rK/Ty+Bg/y1eSfJBaAut6Ga9Wh3ltbyiAinGjfhaUSeEWVA2e?=
 =?us-ascii?Q?x2tpgg2/12wwVKs2W+1QbDIYY042sprZECcdJtwf75Yv+X8gCmitc/sJ0CwC?=
 =?us-ascii?Q?9fiIjz6mQMD81X3qa3E9qdy2QsB178Rt/BAtC7mOYqFgk3rRYO8Sad0oTmjX?=
 =?us-ascii?Q?k//1aAAZlxCLtbPtueMmxhxhUAohHAsQA6KsnSWjWP4Rs2Y61ScgmU7JrHbZ?=
 =?us-ascii?Q?9uGSWyC3Yin8Iv0oHHQanYb2NOO3hcj99oN7TpTyyh6uekKsi2Y5RAo+0sLZ?=
 =?us-ascii?Q?x6iRQ9ZBmSdZvPEjOXvLRHeI7Z4s7W/BiFx3URvB1VYWx/rZSj7TZvSWMXGy?=
 =?us-ascii?Q?zzJpPOOU9qP4X2ybO2YyYrZ2tKJ/UPNG3DyDR7qYGolCa71wAChiEkEcTgFw?=
 =?us-ascii?Q?EuB8nsjHz2GcaB5+JdYGPBFjT309TRgJ7dGWE+AYlbUQzMmkWBur0xU0934v?=
 =?us-ascii?Q?wBch5zm9q2edEu5zNL+0goTyEFT5SpQdIub//01BEGqPMH/Mb2UAyefF9gnq?=
 =?us-ascii?Q?We9sAd6j8uOoi/8nDIJFAg8e2k7j8Cs8wXZaZrXc2nvQLA3hOqs8V96JCR5X?=
 =?us-ascii?Q?jS1FIvZ8vxe4lI9emm1wPe615n8Ph5m0b0wPobYIRy2HuyAxSOghWF7Ng+Vy?=
 =?us-ascii?Q?zc1/W2cvYXGxdvl1ns2CBQQ/Kgf8othOh2zrwmkMN/WqYGap5r5FY+UElhcx?=
 =?us-ascii?Q?1wAg14NlhEfVQCdN42gMJ4NUULehAX1NEg/dblNcwb29St/3kevE714hb9EV?=
 =?us-ascii?Q?lLRTxA+9JbpEM6+TZBgWuevNWEftEW5kxyxHBCrnM3Uh/X3nDKET75C3YPcd?=
 =?us-ascii?Q?E9RPd+xcBPw/8/1/cvOaWrFSF0/GKgbAb3J6yACOpdSPhDPbaowGsLCk2lCE?=
 =?us-ascii?Q?wwUdjcB6S1urJSwMONgu2ftfbiW92wjuWPspBU1dqA0mOqTdOxUcw2l7WABH?=
 =?us-ascii?Q?TVyV2eR59tQfas3DAWLog/g0dEm+G9hQeEyJVMH0Xjskm+tqH9igjMOu1Dsg?=
 =?us-ascii?Q?ogtBdDxFapsGlVbzGB4Q5wXDm4DTOxg8+E7E7BXr6d4hbiw3VeZx0evkwelZ?=
 =?us-ascii?Q?zwbHbqtG/V11D4qWx6rE05iuZH9ELeiLyvPKRcLwQ5r1yo8nrGmB1I3/BpIZ?=
 =?us-ascii?Q?Rd6MS4I+paUnczrKeZ+zUJiY9N12R/oGsNeWVcK5SeuSCk9S5bAt4UHC65UJ?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae6d032-e8bb-410d-9d92-08dd51c822f8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:03:38.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou+SvsOFzR7TSRR9DodN4QbOMZ9pxvsZfh6lNhpBMn2W8+ppACoiQwEXb8t6On/D5lr+a0nSXynWZ22cdEGCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306

On Wed, Feb 19, 2025 at 01:42:45PM +0800, Wei Fang wrote:
> Currently, the ENETC v4 driver has not added the MAC merge layer support
> in the upstream, so the mm_lock is not initialized and used, so remove
> the mm_lock from the driver.
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

