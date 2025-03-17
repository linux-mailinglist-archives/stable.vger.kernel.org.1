Return-Path: <stable+bounces-124637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B4A650C7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 14:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83567A4104
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B6523E33B;
	Mon, 17 Mar 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccLX3lXE"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24823C8CE;
	Mon, 17 Mar 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218040; cv=fail; b=eiTG8q4wmiOsSPS7TGfW/iz6W2EBzds+q4SIsjvV5LOxbSlQsXVBOh0V89FIFTKZsz67gFgKH+yudJBTQcwLplFl65gngccfii0bz2H88nVSTIevH7ixvDeB/x2FNxZH8QKq3XeVcPYAZU/4zVO7HyCAdmmoYXbLCPGdWwig1pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218040; c=relaxed/simple;
	bh=vk8MILHps0s3gDixmdmAYxcKM285ArMYv78faGmHecM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZOyQWAACw2I3Tt+EaWNLc3pMX0BR81txlFcwYt4j3T2v3QgKIBCun//gROYYoXdG6rfvzMavTBtUX1w+AJ8K4yCwaMioUBqjO87AOJa7Bko4GYH0ObgT1IvcbjcRuTb0CvfRZMTbJzePsYMnZldho4BpLi1txAV4p80kwz59zrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ccLX3lXE; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibOH27DEhwQPkCsmTetYAC3cwfg4EX2v1ZaJg2qB+51zUKVpJ1w7wHGgb6otKaMzVABJ7yXQnnLTO54obyXLpaYMNSXpgSzcDGiVqUbs2+5IirE+hSF+t51fOwNJ6Wgj7moHNVVoOz4ir9eu2KWmf7wYPmdtB7q/QTlVC8cII5DaAQHfHZruDPh7UXF1i0NGaWYN5qguDx6XIbs69iQaEpaTQwj47HghTeROVx1Xa97KPWR88s3qWI5JpIz4eSOntFH5eYg45OrJJOVUG+ipt2rtvY/4bB1L+oUaOmYnKjB9v74vG8taoDo6KhF/1Vng2MA+Wx1D1+zw814etWRu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5iVWxb6NgaoVqjXEAK3O4GspUy4p6+XQQC3KdfS+tc=;
 b=rCpByyVjUReC7wCT6XdexveB6Ns1nNazlcq6+bCP/ooLv2OwJVsobTqxDloOZ0lq/OGuPpkfYU+nCZmsXHiwgBz7t+fIsVxmqCZT2hPUUPfCOXZrC0Pf+dEAmxrUeS2RUU2axd+NrRZeANhP0e3Wq4d/x6lXdGZbEYcBN34MIO0VgLoP2+h5/RbqxFAMNhF4Q6IbLZsKUOd0xcrJRZZpBeDLK3MxXwQdHhbS7smNVlNovGf7HijRY37az7OxR5kWqbSqbKCSTKn/uanDfk9qkoltUvIQEOub8L7+NciXHlPOWJEoUcLyq0S5a4CemUKteJUVhmqPvYAEfj7PVH7SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5iVWxb6NgaoVqjXEAK3O4GspUy4p6+XQQC3KdfS+tc=;
 b=ccLX3lXE7bQBSygQdWgZmUjMCqa6SiN8xWvNi4wJ6XbLr4LHG5cEHgS79d4JzDc/Guigl/IrBgpYLo4DwhgobnaCcaWX7E8/CV58QKtjAVgrLVXxVoK0DydNyM8SDiMuj7CpE9YsaP8/vqeeUpkOZDNS5pkvw2i3uvxrF8X/zWOK/78JirWcWYOVOvUi0E6nhrFgNOQla9+gFWYJ28nD7AL139IrzSBFxcN8ZQEtSev+Wq8zdm3KZiTAakcgkAylzg2VldiW4aRM2g1ep0yAZ7vRxO6mUcZkwTgNzS9E7t7CMWTEGoGsd8FZloLz+Hw3eHc6qo8gn8q6jNuv4cz//Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10854.eurprd04.prod.outlook.com (2603:10a6:800:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:27:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:27:12 +0000
Date: Mon, 17 Mar 2025 09:26:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Message-ID: <Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
 <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10854:EE_
X-MS-Office365-Filtering-Correlation-Id: b678fdc5-7c48-4cc0-df96-08dd65576d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5bA55X2lT2Egt5Bhr8cNKu5YFNH0e1Lv6YBIiBBeyBBh0clbZYfZIcS5ie5?=
 =?us-ascii?Q?YkNbsjo9G1S7yvUS4F9SSw4Okt7BK3bdr5g861esexg4APDYhnrrYksHw4zx?=
 =?us-ascii?Q?4pJHCE9j8qYI+kiZu9hgLkKps1Fpkxva2p57pdWmhzFeQvSOpqjcEFLTJxa8?=
 =?us-ascii?Q?2wtHaf3Pg2UPWBF0pNaV52E+lAvk6InKf9odRv+DgxgJH1cfZCutQLXiz9Ty?=
 =?us-ascii?Q?2f/zzRkuT/clMnnD8u15OGtvMzRuLKvPWUOwcB5ef418Gan7YiSrGnYMEQ4m?=
 =?us-ascii?Q?gN2sADKJUTnTpkPZlo7+cNU1mLcH1FYfiGH6yuJvKX5XQ0wzYu/UPTfU5+Sz?=
 =?us-ascii?Q?s9nVRE0wKD3o+IPvBqCwrCu7viIYE9q6MFPVMY10rYGThVdiO/ze9hqQ44K8?=
 =?us-ascii?Q?DsWDG0cjF6neMSQlitwQPnik5b3/Zpemq1JXTvFGlq7Tlcv/p6UAm+rxxmK9?=
 =?us-ascii?Q?/QrpQxBq/bWDHUY9w/m3GU/Z3jIUKzX5Qzy2F7i78GOBJZHBiMcFVB76lFlN?=
 =?us-ascii?Q?Mv5Xg9Vlz4+1r9QotXk6QCE3Aa+iznEy0O4XcdwFP0d4ZK4fIbz7UYcuZsag?=
 =?us-ascii?Q?+WwHN9knU9YKswNbu48LfwLkODUQc316w3OCEdZo+J22q0VxKmiy676EoghL?=
 =?us-ascii?Q?N7ac5IqXL0n6z7Eobksbtts3I8gpcoDHE62b53g4giyOca6pu+huGFcvsoxs?=
 =?us-ascii?Q?ABRhkfAwSz+0vQSw1Gq0bg2TLv7v5sag1bdIjy3spcBnf8wxSjou+LGwgh8w?=
 =?us-ascii?Q?RU3yVh40w7DnWSgeoXvdgQafyppCwWhpP7oHKkHoLa6qjT+jmzeNSaXCU41p?=
 =?us-ascii?Q?DMGkERLdUFQmC0NqW4FqFJSLwEqbzG5UeWDL68H7PwCAlbg8PnLISoJSZqcQ?=
 =?us-ascii?Q?JoW+675C9mr0ge0QMsAC4NeHV1pucGR2K2+jh+rNeaPn0iMnLxQWcXL1/KG/?=
 =?us-ascii?Q?AAREnt24UP39XdY5Jvtagn3MoMMgkf0r0k95Wd1zp4sIoSell9Y1P+AAC6YH?=
 =?us-ascii?Q?tvelDHchnJcGXzhM18ql0xb4tUkJnktggxsFFey8L6SCo2zj0Q97kLnTFpBv?=
 =?us-ascii?Q?Se8+C90d+Oe4RbqUGWsoWX86vazMMW/4muAmcsc+96rIO0ijEo/Y55MFPdOo?=
 =?us-ascii?Q?eYvjABSY2spahDCuLnfBUErMZ/6Ul/Bm+OhwY7/lPQTAguDzXaIMxRMsOKLd?=
 =?us-ascii?Q?wtqX7iK/KNGDmxzlnMPJ5Bu38L7okHc5gwXMR/Qo6MLH2fwSe5z5Tvvjrjq2?=
 =?us-ascii?Q?bDaud9qIpdO+g+R8gORztPXhNUSNnreuuHrDj4iBbX9SD1zjudziXz1OCLrq?=
 =?us-ascii?Q?t0JbSdF6WNwIPLFoMNsMgSwHCEzIdVItXDDaUY2L9rDkPiaz4bi/15WhNEyd?=
 =?us-ascii?Q?YfTTbVzK0WghACSV6WrFGkVeIN7wT3uRriw13N1ej0Mp7wFbWoZmnc3xTIkx?=
 =?us-ascii?Q?J5QnPiUMBEhCqO4bFLdcS1NMym/PzaJxi75xvnqZtUZxbuq5zT6j0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uCu2CUG4a39KKdfr8vqdksUoKS+zdJqA6XDMTcMwFRojAPT4nmjrmjUeLiER?=
 =?us-ascii?Q?fJDUDlXSCgQll0mpPGjxGniFHvxwG/PVUO5iOzhM5VGMfsKqk5G6JaonfBc/?=
 =?us-ascii?Q?U+M5AIvH+ib1I2lrC5bc52nezUWUeS8T3lMMmjLruhlHTuO+oiyM7Bz4H5V8?=
 =?us-ascii?Q?LVOd63cqUzkD6koNw5S4fI4OuGsynkT1iFxunhlXOObwZBr0PSlsJKwlO1Mm?=
 =?us-ascii?Q?jVXxkYG0BEbpasnWXfT01m+s5o8WiREmvsAAb48oF8FxWdFTbzUAsNhZ85tP?=
 =?us-ascii?Q?i91AnG2o85T2obaSHqhFnGznRWdgv8hN+RXHnnYSc1aRw9hFLaDf1+5YKyIA?=
 =?us-ascii?Q?7UKVfMMk94XkBYyaeMdRpzQqvO7F6rU8gaV+lAa3/NddBX1Jelfv18xd0LCq?=
 =?us-ascii?Q?zUtw3zvOAQRmMyYnP3xEjvQiuhbgbJfPrVZYT9/aFh6YVZlNAUyUbjCHVkMR?=
 =?us-ascii?Q?p8MIfyZwcEK5OxCLD91U+WxUVRtBz6R46PzqUXN/YI8xkLyXX+UmhKw4Zve5?=
 =?us-ascii?Q?fKmAf0fe3f/vOckNE288YftfhP5FdKMPF18VNSomzG3rhLLY3OhfrE43BTk7?=
 =?us-ascii?Q?tukMjwq8+plKRI9D0XT7p28+Zv++8HtioLgZZ8eFfiIUw0qr4gY5jdQWGEPn?=
 =?us-ascii?Q?aYCj9UaCWXVBZds7zJBKhcygsHQvbws6oUpwMy+34OnGyeSi2mmEk89Oemcz?=
 =?us-ascii?Q?mCIWakqh6Z784MUZqF8J1/KBF8upzSxfeOuIHev+VpGNpiRRuMogDVxhyKCc?=
 =?us-ascii?Q?rnR8N4jh36tObN0eg+uY0YTG0qw0WDktD0M3twt9Xn/uPlZGZj4JvLB7f1DA?=
 =?us-ascii?Q?V9d7OcjiVZCzQhQ0N4ojAAI2wtehe8t3EZ3bc8L8irwDX16Sp3af0qmAz/PY?=
 =?us-ascii?Q?1swsA4T3Z8nu1LnSjtmk/UX4TTseCWRjQNsSfd6Bldhz6v5UV9kBLJXL7OnH?=
 =?us-ascii?Q?hrvkO7dXLoWx9TcvMPWBnpZ00UCTOKWJgziG6P1tp/szGq/byxZid9HFhwL6?=
 =?us-ascii?Q?LYV6eO+86i7S3yE8V8K3DVdynZIC33iOSEY4PrZQmeBzya9CBZdpje3XMuO2?=
 =?us-ascii?Q?hs7RLbjHfpr281Su4hy+ZbG+StD0cn5Dr84DLMkHBK01Ld+ls1rQNq1s1Y2G?=
 =?us-ascii?Q?Jh7hoFzJzm+GZglFhaR4jEYxF/hK6BSG+BGqv3Dh4gKBpmxKdDswYDO2uGb3?=
 =?us-ascii?Q?lOt3OnhXhHsXug+8ZrsEhJnLmqC4nyh1Yq3Eq1ufEJV3tIfm4VKC7zyuU22h?=
 =?us-ascii?Q?Bqwu7dpI+iCphR3Rl81M4KNUVmIp2eq09uuR8bv4jLFXkjxxmNEsSIgrTZaQ?=
 =?us-ascii?Q?S/F/zpN2a6soWgCj6+8YqPwIYng+YyE6CGYMsW5XQ9/a8URustPqJkCxUimt?=
 =?us-ascii?Q?XOaswioMVMoevEiOwxgNONGI+zgjhWbJnMYA6PvA2pv5psopaony8hnK7raT?=
 =?us-ascii?Q?0I/0XHQzF0qgttOtsfoSn4uq0iZO5g7VLp8aC+/UOEMSZcG9tPiET5magsyf?=
 =?us-ascii?Q?HF3PzlUX+0ospoGoTP2bpv55yu+Ez3dTaS8/YQH5VZFxr5zdsXf32bDLZtfU?=
 =?us-ascii?Q?qNGJZL/MdGDN29Jpeo0dV5xRsuvfnEAqEnZZk0iH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b678fdc5-7c48-4cc0-df96-08dd65576d0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:27:12.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaiDjNO1YF3oBJpGJKl4RZNzHvnZzVuTsNmf/+ZXwa4WNhZt6yVg11X/wgS8t+900y60WPX4M80SzhODWICn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10854

On Thu, Mar 13, 2025 at 05:15:42AM +0000, Manjunatha Venkatesh wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Wednesday, March 12, 2025 11:59 PM
> > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> > Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
> > svc_i3c_master_ibi_work()
> >
> > On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh wrote:
> > > As part of I3C driver probing sequence for particular device instance,
> > > While adding to queue it is trying to access ibi variable of dev which
> > > is not yet initialized causing "Unable to handle kernel read from
> > > unreadable memory" resulting in kernel panic.
> > >
> > > Below is the sequence where this issue happened.
> > > 1. During boot up sequence IBI is received at host  from the slave device
> > >    before requesting for IBI, Usually will request IBI by calling
> > >    i3c_device_request_ibi() during probe of slave driver.
> > > 2. Since master code trying to access IBI Variable for the particular
> > >    device instance before actually it initialized by slave driver,
> > >    due to this randomly accessing the address and causing kernel panic.
> > > 3. i3c_device_request_ibi() function invoked by the slave driver where
> > >    dev->ibi = ibi; assigned as part of function call
> > >    i3c_dev_request_ibi_locked().
> > > 4. But when IBI request sent by slave device, master code  trying to access
> > >    this variable before its initialized due to this race condition
> > >    situation kernel panic happened.
> > >
> > > Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C master
> > > driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > ---
> > > Changes since v3:
> > >   - Description  updated typo "Fixes:"
> > >
> > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > b/drivers/i3c/master/svc-i3c-master.c
> > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > work_struct *work)
> > >  	switch (ibitype) {
> > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > >  		if (dev) {
> > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > -			master->ibi.tbq_slot = NULL;
> > > +			data = i3c_dev_get_master_data(dev);
> > > +			if (master->ibi.slots[data->ibi]) {
> > > +				i3c_master_queue_ibi(dev, master-
> > >ibi.tbq_slot);
> > > +				master->ibi.tbq_slot = NULL;
> > > +			}
> >
> > You still not reply previous discussion:
> >
> > https://lore.kernel.org/linux-i3c/Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-
> > 5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417
> >
> [Manjunatha Venkatesh] : In the last mail answered to this question.
>
> > This is not issue only at svc driver, which should be common problem for
> > other master controller drivers
> >
> [Manjunatha Venkatesh] :Yes, you are right.
> One of my project I3C interface is required, where we have used IMX board as reference platform.
> As part of boot sequence we come across this issue and tried to fix that particular controller driver.
>
> What is your conclusion on this? Is it not ok to take patch for SVC alone?

I perfer fix at common framwork to avoid every driver copy the similar
logic code.

Frank

>
> > Frank
> >
> > >  		}
> > >  		svc_i3c_master_emit_stop(master);
> > >  		break;
> > > --
> > > 2.46.1
> > >
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

