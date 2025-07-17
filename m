Return-Path: <stable+bounces-163266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F94B08DEF
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA437A4967
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A322E499C;
	Thu, 17 Jul 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XC9oE1b5"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012038.outbound.protection.outlook.com [52.101.71.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873A279DB7;
	Thu, 17 Jul 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758159; cv=fail; b=Jf/vOo8oOVr3ZAkB8wsV/7i1ZT/gKq6UoMZsjIFhaG9KerAU+fleDtQI7vS9aoYZ8Mnpa0dLz7NBBJlwKu+Q46fnI9MhTra/jW+vIq7wxlK6INdjKq5y9pTEiBeVOlp2NGPedWx8HUshnzthEWwYCszEGOKqJbvAlsLh1bM2Qgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758159; c=relaxed/simple;
	bh=1VAxg5CnVxThReMyZQW8VB/g2bFudtyPQRwhQIRKrEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYoldIfy45mKnitj0wO/bhuE9rN54thJvKk7C9CNt6ZPH2bFfXv4TYmcX/R5oaW65WMu5nCIgnRjPEY6SWawRWEnusnZEbc2EcdwTzuMdxZFiHVMZzMbfOQEDdKzcIdCcfVuMHIVG/AkPMG7aAv9nXxqHzgZnjBKrmXaLEuRoSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XC9oE1b5; arc=fail smtp.client-ip=52.101.71.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMAFlBivtNwYpaX5srgfchmwAXmRG8KvZMyy+pj9ec6VGapeiGdfd8clSotRbpMgVq1Uas1gmRWzFhQ9QzpHK8ZSEec4mFyiGau0txbfE9/j4n/kgEdTBh4Sm4XBC7jgb/eTnMmKQJep7yDkR5WBqIoA0hd63sHgTrFnqbe5g2y+dr/E4tAIwP25lxAVbcBeKtSmbChvyLIzNPfdwFPtr9YFwNU8dIYJMh/DCcR8H+nUDIFgYuFz25EBi6a847LqwL7wRtRnGIOiPbZkau69XdlplQmKYNPLj/uk9UhH//QtkalycX+/BUDa2J3NrnddtEs98ejDlQBWyMNftmK6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxrw5LV4VPOTj6tnN+83D9SvwoCpunZbp7PvMFtAHfs=;
 b=HH4LXyhE/osvqk48+RvPhoqcpVgAo5n3p+oN5ib/bOf/WMMEsqzMrD6xEwwJW6ALIeekdy3FZ3NfOg9cTuFXWGmU2PeD7xmNxZa19Dtl+TM2xBCtaOH3MXpDXKVNlyS73pQIKn2E6UrhNNpNF7YtWrjpyQrXhMyQztNPV7w8BtCE/sP4lqNboS3TXvUXgU6Xulfl2nyeu+xscBZThhSp0jfmun2nl/kZuq9FCjNvZGUCqKYVh7+kRy4LhkakI0TQmpPDN+hDVHVz2cBE0dWZ7Z+YFOo9GvTZPMOhF89peHNU8LlxoWefY8FbMKCkwwyudQ0+ZENIZsw6YxREQLhw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxrw5LV4VPOTj6tnN+83D9SvwoCpunZbp7PvMFtAHfs=;
 b=XC9oE1b5vLPsYKTP9DKNSlhRsGf/ALn3bwqAPDr2CNI91/R+jy83sTs2Ek+b7nk+huHOLSVriuACbVPTeacG/nQv5d9bVEJA9EyesmM7pGHH5chGOZR2DH/AILqMaEQs3/Wc50etzQI0W8vBEb97nZjwgqYG3hdDatd/h3dNdQFruGdq4B8lKN/Ctk5+TRAcCpkyex2sdU9pfGNZHAlTqX0Vv2Qytcy3bdZUd2Qfx7ncM0U0dLJW6P3q0H1gKc8RKUvPhaqMv5cj7bDsLXjArly0H5k7+Su0Etd3Nc0ksXLeZjFb8V7SqYkYmRp8YmDuCCrqI+8NaSIcsW49URcG6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 13:15:53 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8880.030; Thu, 17 Jul 2025
 13:15:53 +0000
Date: Thu, 17 Jul 2025 16:15:49 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] bus: fsl-mc: Fix potential double device
 reference in fsl_mc_get_endpoint()
Message-ID: <e644p7jtovgm5leuzdw55byf6qzfwbjkjpo4xx3ardhbjkualp@2xbq37yn4mfk>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-1-make24@iscas.ac.cn>
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PA4PR04MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 884f753d-ce50-4d58-d4ea-08ddc5340e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9L+IbxhYvtcZB3ltT+znni+MWvJvY9v0Ryc1wSl22t+XZ9EGdAZkvF5Rj5co?=
 =?us-ascii?Q?lJDzw/jIENQ0eC9CaS7vITely2ObzJ4GwojDyPbcpKB+dDQmyHmmt7WWjIah?=
 =?us-ascii?Q?/siviN5dacAy1BCrcX15gocezY3ZLrYgDJCGNP6130TmmCBt9jismzZrgvWi?=
 =?us-ascii?Q?NHXfru2CzntTSPmB0RU7hqVF/hQKXX/BTlRCYqIiMIeqTKoy28yfEtf1FN6M?=
 =?us-ascii?Q?ohxD9serO6aaFvFxOUQEhQAMqAnmrbvqE55mqLNH3qk8GysOjJVeJH1NOYpj?=
 =?us-ascii?Q?GMZ6w1oTkZYLhG3Bw4CUZyP31+rmDYfoC22K5eOGavHL0hAlWR4GMPG3yUTp?=
 =?us-ascii?Q?7Pz2cPKnmqp0C3dwLKI9Nfo+3tNMIrQHbBElrRjbp7whxYrbQ6vhV0A2P6wa?=
 =?us-ascii?Q?twnS6W5MbPx3uXjQeOykMX0hS39NCeUYsCmm8f/2W2r9RJ/pi5SFVW4skoVg?=
 =?us-ascii?Q?+Ka3k3ZCnC8Bn8NksK1awi+hcIW6dxx1hVVV/J5+lMMX6S8PEqWCebmhdbBa?=
 =?us-ascii?Q?GCRuJZPrmC2EyTd/SFJ8N30e8aYojO1bnKEPq5q2OOmPDN9hGgTGfit3IQJo?=
 =?us-ascii?Q?44GMQ7BfagtvqNiN/QFxyyobRXlT7uEXHkt+fPkUn9xLeHAdqsL5iPgMEkz3?=
 =?us-ascii?Q?/cpcKNe+QgEwmzxpVPK419WX56fjfGqYEt8qWlQlI07OqaoXxg+gSUpa6CA0?=
 =?us-ascii?Q?x75mC/e7USXMVl+bYWSzcH62G93gtodATuplbFgG/YhzlBUqPYKaUIHFoOO2?=
 =?us-ascii?Q?5AG//tnTqU5yKM8dScQhlWwJNSEh2sq+AV/YPINd+vyYJvbgog7s5nA/2tAU?=
 =?us-ascii?Q?jJE5fmu+6HStCc/O975nNtZqOXsbQkKZgd7bMn657LpnRFqCFNuTMhfLVuEB?=
 =?us-ascii?Q?AZ0P3jr1nPfR8UIXq638RDD/5mUKOOWz7r+6E2G9TAIKuQk5bXIFaI9zyJF/?=
 =?us-ascii?Q?vIdZA8Y4zy/pxVNDsBKsIp8RTfyBUttRg6t81pWeAXbwO+Cbt/k2x5lJ7vSu?=
 =?us-ascii?Q?xJFT/DXm74XZCWgvmAkPVI4Fg1oZ0G2DUN2VXNKsjP+OBrksxpqVYEmalavb?=
 =?us-ascii?Q?pDXNSHJtMwx5oeTI9EzRf14sj80N07Ms2MYpD+e+VkqBgQGkB61lv8cRLPDG?=
 =?us-ascii?Q?fYp4VZ8/Cv6fmofAZC/pWfkaF1BbN+pEP/zP/SAW7iDIURuTuGPSDCVlNeR4?=
 =?us-ascii?Q?0rmR2eK0fvrWZN/QhhJ2xOJVaZIO+LM7L54/5fuS+KFSXvFTGXX8rBb3mIvp?=
 =?us-ascii?Q?0oCbazu0yIFaAh83b0qEsQetITp+5x7UMwVm0s9TVDZMohXiompMQ5gOw0ne?=
 =?us-ascii?Q?9OiCIrqws4k6AkPZUReUTW3J0glESfYBww5jVGd/eUZ13sN049s2KgA9Ca47?=
 =?us-ascii?Q?gghra3c6YoTKM2kE9POhdKMVqKSq1RCT5Fc4GhvNSrjLoEtHJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LNsvTFv0mGLaKAkIuKVcQIMEHzRux0DDW+tqFIxbo2riOLtbkc1yo+I6hKvc?=
 =?us-ascii?Q?wQhkVOChQdHn2wtSJVB5fwbmEs/RW+yYv5a4NQ/C3h1ytc3/kFWdKtdVJYEG?=
 =?us-ascii?Q?VBs9iK431YL3KIOcQ2+xN151aU5UvRz428upxUEnFgzWWqnNMCCGOSSHVSs7?=
 =?us-ascii?Q?zvYqzYf1flvu64UGwLZ+p0+RtIVQQcIOQS9BQc6A1qDG6a/JXqTylThh9U9c?=
 =?us-ascii?Q?zumGNki62MiFU4mldFrcUy4EDR9z/d00OXPD6J2gHRcRl0EvFIk1gI4JLI+F?=
 =?us-ascii?Q?P6LfE/eWMIFxVpWTdJNFoqlOYsvs68Esrybnb0pX4ydme9fwVMfJ2XOkb5Ur?=
 =?us-ascii?Q?FCEv1dbWpUb9thtJmk/oq+0NNtFU2UgJuuxfMeYQjZOretfENmlb99FDqJ6B?=
 =?us-ascii?Q?Pi/v/QRoQWZN3SlskV7BVhAeLhviQvydSQPzjoh+bRZQbjaBm0gp5Va5Te+K?=
 =?us-ascii?Q?X0Ztri361/4N3YrmzpfVcwM1wA0XFj4fv8ncS6Fyz3JxINkpZZhtgIB7QagH?=
 =?us-ascii?Q?IjenZlHvKqJeVJ9eBf4zoPHhdVmGkgTWsqBYCzoDRo/BdZbPf8OIOHOi87gY?=
 =?us-ascii?Q?rcNOppgUgy15jsavoZFUnnGU395aCNh2lE9jByNFZ7nf46rG0I7mdUKPzKAr?=
 =?us-ascii?Q?mKxXCbY4qazGIOZxSWCNXPdPrmnXdaD8G1qLds8+CTbChgLphcruEoYxo67Z?=
 =?us-ascii?Q?FaswHD5oniBlvV3il3TUAsXXGGWJQLxIHGe32geR3q52p6cydOxXiqDojDw/?=
 =?us-ascii?Q?sPGETfT6Co8bxJq5MwyQ5AIzeEeaJnQzrY7/lppmFDDdiY/A2y8lzgIregIH?=
 =?us-ascii?Q?CvXhmtZxFvFDXcrhB/OasixVMfZQAY9fYvH7xL/btw0osK3n7ghvWZ0bVl+s?=
 =?us-ascii?Q?ms/kHz9KJcfhfrtEu7vXMzD54bie5AbMQ/thX42gcQcPgQcApe39oiLhxn48?=
 =?us-ascii?Q?4PXyFGtYGEMes3cAPL8SQ9x4CT+t3kcfON8NKNeqRvLVpK8D53n2/qpHGXCJ?=
 =?us-ascii?Q?kwE2AdF34whpQsuPe26vjyGR4oCoeRXniQ329z6NmRybY7Cv2VFa2ZNb0pv1?=
 =?us-ascii?Q?VQmBQd4AmIEdvOo+jGYMYqriWWcr5e1dnyWTI+4uTeHXWfdS387DtrubRQLm?=
 =?us-ascii?Q?+nhMiP5jshMpa1UK1DUDsuMdz8KXGWQDiEKMGHWkfPChj4pm7cyFLuFF4x8q?=
 =?us-ascii?Q?voAVKo/9mc1feKHXPud7ALGt/T5ylopotmpLDzrnKpOdczYGg1qcYJuy/pXm?=
 =?us-ascii?Q?5C6wIzkQX/2YftMr3la6gU1mQsqF8/C9dxPXVy52qJb8c7T0sSHgcgLCfw75?=
 =?us-ascii?Q?2A7tqVZBO6Usy5f5n+YdMAL+JKoYrvlu0dIWv9nhQwYFiRSElPEqRVedQMj/?=
 =?us-ascii?Q?5wVJ5ENJQvo1vOHGb1e6sZUqLceMBan3/yuC6ZI6oLsM9P9DrxcESIqSBdXT?=
 =?us-ascii?Q?J/PTHdZQrp91Mw2SRo5GYha3ueEQc87XD6NJrjJB6IIu+7pQyHWI+swH2hr8?=
 =?us-ascii?Q?aDYlLbwBUu6lO4YusdZCo3/iWsxZpOJmJUDPjcqXjRcJ32v2UXdGzxyty2zs?=
 =?us-ascii?Q?5dcNlsJcqfTwUyHewIJnaLPNZ0SU8L/7IHlhgS7P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f753d-ce50-4d58-d4ea-08ddc5340e94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:15:53.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJtMK9y46fGl6foqmZ8s4fYRtZ7uYNsAYfWq5VTDb/Hc2nWVlPQzSEt64YBdZTMybCx2lozUHWiqtoJT0fgL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7679

On Thu, Jul 17, 2025 at 10:23:07AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function may call fsl_mc_device_lookup() 
> twice, which would increment the device's reference count twice if 
> both lookups find a device. This could lead to a reference count leak.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1ac210d128ef ("bus: fsl-mc: add the fsl_mc_get_endpoint function")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>



