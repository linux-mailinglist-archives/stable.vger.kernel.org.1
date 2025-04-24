Return-Path: <stable+bounces-136513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD1A9A159
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7BB447CA1
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FD1A23A6;
	Thu, 24 Apr 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="RRpb0REB"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04B2701B8;
	Thu, 24 Apr 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475387; cv=fail; b=l76QyrH010p3TKU42wRceJemaECLkBE8Bv9XUpvSkcmxRVfuqcFH92DS9mrvfQTzmO7jIFWk2iwznJXAEglVGrYN6s/oKngfgnqdp8yqu9eOoEo1/2p7HzW06xYZtiMwSANRLR6YV/6Th3KNhVLCP+As7JsZXZTJRzFHTPhbi/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475387; c=relaxed/simple;
	bh=PDZYHzl320JyG6SXQyIpRMMX48e0YyJTDy84g/yLgmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJj4nUBpgXcXSg3BDxt5+d6cqRFumHlRQuhRY6eWsctTaErSCgVd514qg8yIMz9DO62Iu15uz2/z7rHOpzcqR1quebI9kOQ3Yl4EtySH8UpH/DqQUK7MPxr1ToHYcIHPlsHkc0F0+1L0UynN34pwh41h9YPItO8v4AJlx2xkx5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=RRpb0REB; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNdAzoyMX0aNsrB6CzA+kLTngYU+FqTIItOJqO0r61fTb9gsm6YR6XiBIDi/iI2GTmgNRy4ZU6u0APlzwcwhuTE/GcLjRBWcXzC/rA+PvCkzzxMTjeQRui+loQVtxXFQaIZFaNPHl0jXURnL2z61PI9K1h+ig3g2+T/LlYW7bfRJQE13CbfRXiWL8o8tzK+jprMqhC1vbR5/RvVdVYh1h6c0qUYhaME/2cGefWlIO0rhKfL5fsdNdlKLwWe2J6mNm5hK6GXdsl/8u9z98ggP92am94o7EIho/+oSETckuNApnJymJcjSpnYitLKc1hrMJ665ywfDGgTVyeJCWLMRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klj8mxS4l2I6l9KVTxd0YIp5f8NRu+DgZUjtDztw6rY=;
 b=Vu8Gor+r0ht4aEpfK8GOdT7JTB9+G7eUE0yfIUtfdltFl/netfGzCCBvNeGiLt/wM6KA5vuUXCNIsTncSSg/e44IhrYEi/BYPCo0H6qB8YdyhSOdeNAuHUiSUbFdPBBW5vI8a5lEKC+D70a/7yy4twPHodU08RGOS/Hj/6VCRVo3/E3QsEjesidcO+9MSRESxMn7zwqj2/JpJ1bg1lNYK8nl64zp8t5cmqWjqJ1UF78w+iLGTFVQBMFF+a6EppGlQWED7OAcOucjFo6EvpeWG+YUmnyGP00qPgD0mhQnx2KJ/ozcFgCameL+wbNu9eoWLThF7rP+kjKLYWJcTOTqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klj8mxS4l2I6l9KVTxd0YIp5f8NRu+DgZUjtDztw6rY=;
 b=RRpb0REB3fsQJSKrYqENyuxk90zQKjmYMISYRLH+ZGTeQIcjNWLVi1BiHssqn/ijQVuf+uc7s01d0DzwnZnckWRkdUjx5H0dj/OHYrcquZ8g47XrGtOSqKUfEd+xlaj0QROUIq4JK1aJdpQ2DEW4MFlyLK2nCqeFIOlysNzXy2jjIN2rpZc1p+TucaWdVaw6yxn+K4hDguo+2La9afRfS/LOu8XinrOZNZ/AM6jYb5sckmDWofuDPsD1Hkcr3wELimLLn3KOy6Ovp1cc/SqaXadPRWQtEJOHTs+iCXpfkQHlpqOJGCHPOxOmpMvIgugc2uB9qhZ/9R/hRmo/LW7WJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com (2603:10a6:5:6::24) by
 DU0PR03MB8440.eurprd03.prod.outlook.com (2603:10a6:10:3b4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Thu, 24 Apr 2025 06:16:21 +0000
Received: from DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068]) by DB7PR03MB3723.eurprd03.prod.outlook.com
 ([fe80::c4b9:3d44:256f:b068%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:16:21 +0000
Date: Thu, 24 Apr 2025 08:16:11 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Philippe Schenker <philippe.schenker@impulsing.ch>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Message-ID: <aAnXK0sAXqfTNaXg@mt.com>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
 <20250423095309.GA93156@francesco-nb>
 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
X-ClientProxiedBy: ZR2P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::6) To DB7PR03MB3723.eurprd03.prod.outlook.com
 (2603:10a6:5:6::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB3723:EE_|DU0PR03MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a04b9a4-f297-4e5e-1594-08dd82f7888b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lZ0RsDZ1Eb2G9aGKSTIZYKuh1voaBq01cLJ46VvRHQKFtV1QW4SpdxzjnSDv?=
 =?us-ascii?Q?Bu1znYkUHINPiz7o1Y2t457m/J7kZzO2nSGj1kaq7eyS0+vGanNn0yCIiZbO?=
 =?us-ascii?Q?5TZBE4PsePefy1o/iNish/A41TNVTNrC+nlhM5ahyW/40YvrQx1DcLiCvHsB?=
 =?us-ascii?Q?bJtrttDcZzvD2wOtup4SC8bzfWIugEDVLJX4DDuD3N6uGZ4CwfVElsUvoLSu?=
 =?us-ascii?Q?y1vzLR0poC0QXWSD183C8iSTe1OeHzgZCF2noPlUz4brSIlsTmGuEn4fPk4g?=
 =?us-ascii?Q?nipAAzccSqKRt7ZA5ZG8mHTlrdtU+vvhTpbH1ZUzlSFi5N/sOh7MeU4xu627?=
 =?us-ascii?Q?jOv297gy3Z2Qnz5O75JfAZnivrIJPCGCpxSPTqB2blK1lg3U+CPaqi2NgCdX?=
 =?us-ascii?Q?dUo4Lo3rpRMeu6z8X/5vOt7hdXvKog94SPw0S4l48WvHFuxPOcbBSVh+uus9?=
 =?us-ascii?Q?p3hwjNPC5ywUW4gGdVzfjlois36dCK7jVUePyOw5bnNNeks0FV566n+tU6XS?=
 =?us-ascii?Q?N8ZvSSBEyPXWUa9MIR8wevfCJn7PcknMoBFZWwC1NrhAu0HKbx2vl0xH/5Cm?=
 =?us-ascii?Q?ApSMQEyWP0k71B+CKUAjuuAOOb7xv2jwaaLKk/prhFpP3EHtfq1hAj+3BzHY?=
 =?us-ascii?Q?0LZJaQ0mR2GRiyzXPKF2ex7hpjfLaJ5t11cqVCN6KVLsPk92B4pamvuqwPPt?=
 =?us-ascii?Q?ivl8eU7bH3z9s6rKkcewLLB5SvNkBLYbhFbOVymshQR9x6CpLP7So8UUENlH?=
 =?us-ascii?Q?TWmgChek9AbjI+HU+SEcFZmczmcJbSC7tSfDY5p8rGScUTplIQ/aj3QNrxzw?=
 =?us-ascii?Q?kAtlenVqk5WAZ7dnyAdkcZxyjJGAEtSZJRlrBmZO/vfGg5i98FO5cs49BDDz?=
 =?us-ascii?Q?DgdQvrANlBOENt7clgoRulgh8Q+3eEynFcg9nxtpl0+f0/bdg4w+VQnm0Ks0?=
 =?us-ascii?Q?/8+yZQMPu6zaCBwbz9zDfn0/RQt7cBWLt1W2nkvoSI+m6mQUrz9DzLodlbKR?=
 =?us-ascii?Q?OEhz+kCzs7AUyykdd4xbMVkxBNg70UGS3Qh6WLdNahHR0P5kl4azyCjYbizw?=
 =?us-ascii?Q?PAgf4IR8UAi38so3LmxnT6MBJ07ioFD0YAXyNXI9NPPVEcxLEmdcXEN/f7GM?=
 =?us-ascii?Q?kYwl6IJ9RIFThaM0HJGho979SxBQ0iJvXX8Efnu+Zpa67Hr2gOqyrpnAc3nR?=
 =?us-ascii?Q?ZdKRDg6cATL+Bf5LaeLn1Ugqt8VhrF575OLOOIEPbEmdmVDuWEKBFY/mC+Zc?=
 =?us-ascii?Q?0GlJlNLx/1GhN/A+trQeQ5oKNCLer15J3nXS/Y9neMMDaQ1is+W0oLJC5ybM?=
 =?us-ascii?Q?i23kt1LxN75TE6oBCSe07UW0FFOO2VK/McBUxcG2HNm+lZWlqjlyThYmEsig?=
 =?us-ascii?Q?Mi685QXKZM9GtIYLcvNRchA+nj1Vm2SaUbP+sLH5BB+8JzGUSIB22ab57Jfd?=
 =?us-ascii?Q?ihYibkF/mgOW3OmLJsNl+LOn44zOV0NpBt5DayWnz7Vy3/MdCJ6nnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB3723.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TgoxNHCdtIjhod9ZtENgKbvytUuXvyOOSVM5MO12vbeLJNQA/jQLdV+5Q768?=
 =?us-ascii?Q?XbTShjdPygDv4OuEbHD72HDeL/UXFyR7kEpUCilznuVYwa6WmX8nt8iKd0pA?=
 =?us-ascii?Q?GQuiEP5auRZAL5bPF4NzdYkz7hepLlJsRVs/37CoQadauDMIUEfSV0N62GMT?=
 =?us-ascii?Q?IMP68OfOxCGsyGdBcuGAZo9ZHsahOSVnza4ZJk6RjGBUSfzGKJnrjMkonNH6?=
 =?us-ascii?Q?miyyEfGbUHgRftJFYnO1rTRwxCnYUm6Bpui+38be6sNYv8/v1uuJzIE/b2YT?=
 =?us-ascii?Q?SCLLPvf0iy2t/WMC3QpVYeRXWeM5LhlWHGjeuPC1Bpd0kxynXYU3LtKzgcsd?=
 =?us-ascii?Q?8NAMLOnZhDB2zm2KG9bAqUYRvP00E8a2Ogprepk8yTkgUX6W8scxDzDR08dK?=
 =?us-ascii?Q?PGZxQUOR6aOx4H6718rSgBRQdDX5Kbj/x6jjbs5na2nz87BPDR+SPVCrTtcm?=
 =?us-ascii?Q?+67srUb10YgWWs2Y/bcDjVgzlHs5pYs9GnvE2/ngCO0bSDF9RMLxiTTN025k?=
 =?us-ascii?Q?QfcFMK3AnFFAbvKyRaeCsvO1iBHr6r/Uvjqb63KmtugsJCPpfuH7+W0biviV?=
 =?us-ascii?Q?Q3oeMb20hYsssq7RExji1Y8DMt8k4/lNAbroJEfYBbl62dFct4bM3fV6AHt1?=
 =?us-ascii?Q?G4wnMvFSniTKRmSmhrw3knyYVepWat62+DLu4kpnMs3FEB3f162T8ML0ZKoS?=
 =?us-ascii?Q?2EzweuRcJ93i6EMikIXacKYzPakQkc4qIhbDlblnFiL2ZIQx7gFXOZ9SM7OS?=
 =?us-ascii?Q?4PTxr5jJj/lSWkGN9is0Fa01ytvN190NQCdz+h8ngrRjHL3V5tEjRuMa2vOE?=
 =?us-ascii?Q?jRrKWDJVYvERhwbx3NtwFIYLLTCa81z+YgfO6zj5L6T5quMKxAdWlCNqf5YS?=
 =?us-ascii?Q?HQXG8swf9uVq8DB49SpkXQ61qCXrgpiuklbOUCP6FKWELT7iJzyz6LakfDfQ?=
 =?us-ascii?Q?wyAlALgL+wc+MZgsqwFJkcWG4NOLXxWX7B4897wQGQG+t1xxVKwmC9bNaz/A?=
 =?us-ascii?Q?JYHpc2bIjeEV/XI0kPe0Wt89kgpg/wItLZ10OqMGvIgpNLkrnGGIZgb8hWrN?=
 =?us-ascii?Q?XVI7H+uHJCPmVrKgpP4890d5LIZBRL+QRnuNvaIqMV0jaLxdJWvkhF77+DRv?=
 =?us-ascii?Q?bZIpvBL84bcYXFdxEoRtE9p6tIrz+iuMA6Fgis0USaksOlbCvwxLzDXv3YqJ?=
 =?us-ascii?Q?AVCZ5tfjpXr72dntQVTixqZubaU1/ZjcytEZcnf4/6INRW/nGEh6VJstdPIU?=
 =?us-ascii?Q?zjw1ALzS1MmMZUoMB18j9V+nS7UpVzJjQ4xitpWsYFzfehG937FL20LkkNNy?=
 =?us-ascii?Q?0FMTEUEjE4TiDHg18k9jxDNtZpExgY4alQFOxFcdjcdwWSjMvXyMsu8HYkJl?=
 =?us-ascii?Q?ECxpWOJS/DwLL8TSC0/X3Z+r0fS7U1J52gPo4GmxXzLNA6nn7WRiyxkxGVdb?=
 =?us-ascii?Q?GEyQOZLOrSEfg8RDZ99CXsU8MehzHyOx9TOnK1tzcScOA/IkgRkau1Fop1Wg?=
 =?us-ascii?Q?szR7YO9PHNPr40E/yuv1P9ODhsBW8Vq5iU3YQrrBKHA3oiCatDEPoTdgKphr?=
 =?us-ascii?Q?4gM/ycoYegKiDC4V2tnQrj+mwVJeGf8q+ZbbBpAb?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a04b9a4-f297-4e5e-1594-08dd82f7888b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB3723.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:16:21.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xqd5CbHSuyNt6DNYtt0eQTkdialpa6olfMLAEzKX9cgDZb2jS5vuBKJTe5a/U1rGKmi6osjYqBu+vb+AB8mzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8440

On Wed, Apr 23, 2025 at 11:23:09AM +0000, Philippe Schenker wrote:
> On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > > > 
> > > > I would backport this to also older kernel, so to me
> > > > 
> > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > > > for
> > > > verdin imx8m mini")
> > > 
> > > NACK for the proposed Fixes, this introduces a new Kconfig which
> > > could
> > > have side-effects in users of current stable kernels.
> > 
> > The driver for "regulator-gpio" compatible? I do not agree with your
> > argument,
> > sorry. 
> > 
> > The previous description was not correct. There was an unused
> > regulator in the DT that was not switched off just by chance.
> > 
> > Francesco
> > 
> My previous reasoning about the driver is one point. The other is that
> the initial implementation in 6a57f224f734 ("arm64: dts: freescale: add
> initial support for verdin imx8m mini") was not wrong at all it was
> just different.
> 
> My concern is for existing users of stable kernels that you change the
> underlying implementation of how the SD voltage gets switched. And
> adding the tag
> 
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for
> verdin imx8m mini")
> 
> to this patch would get this new implementation also to stable kernels
> not affected by the issue introduced in f5aab0438ef1 ("regulator:
> pca9450: Fix enable register for LDO5")

I will wait a day and send V4 with what I beleive was result of this
discussion.

Wojtek

> 
> Philippe



