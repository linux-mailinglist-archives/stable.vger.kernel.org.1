Return-Path: <stable+bounces-206381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7272D04C08
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B514331A6F6A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8A1E51E0;
	Thu,  8 Jan 2026 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QA/fylXF"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FD1D435F;
	Thu,  8 Jan 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888270; cv=fail; b=Rp6iEKprMSGfX3KqOynyo8SDNJhxXVrQuQu2rFp8PtikjWVV/t+kIBQAw6ACAO4V3CwpYq6hwnH/fqDs9/ox93+CepdFyhSzzLkLgJvlMk2H6YZMKPA+UZSX/EW5dodghR9er+sUWijww7k65GEsTaUvTw2bSCf/G+Ty1kQUTgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888270; c=relaxed/simple;
	bh=OGD85RyaMpmOhBIouihOgfJBs33ODeP3i10Hdw3Tqrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7xu2WoPieW4b+2zq67jIl5Xa66RlTpl9thilRI3NuHA2VxE8hKI36iDq0p+09WPV2N9B0KL503UfToqtHU5J1aGeXSZZNT2jHviKpm5eQgdC0wDbdCmPA5u7WJ+xTs7Bcmlzn7XHCwqv2nk1znODB70e3DkMuK+WGWy0oMrvAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QA/fylXF; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgxMD3yqW8ujn7RsqfAwV5C17y3i0f8XHS56LriZFhA7k4GsnADpDUCCLBkF41/n6+QuYAnrH1Df40sfR3EQDU720eU1XSh2pwE2sZrTPmukJl4FYMUdi1YoFyu+JljVOMmc5API7kwVkYAY35v1X4OxibSNSVx9qBCaWk2r/67pLT5aK5qdA4+9WiLceIgG4wcZWaoQSIFoZdCbybeshxFYBPrHn/gawCJENPFVLSAd63MXOS9yjTGRjEwvbHPfnVdzKLLNVdKYW45p5yWTxFZtxBegBwDV3cC4SdCSsK5vOL5JDszWTdIkR8R8YOjCl4bOrb/BnXyro7Xo8UcG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onGdmLkK4XMUAgQqhDCQFUnwWfggfvpVnndmrL420B0=;
 b=QV9XcRdG2LdkDWUAiNhEsd5h1VK4z/1SyQCp8ClRHv86a8zFv5b7pKHp+36YQUSF6G4ddNIPSkgSAl+aV6UOppQwSeRO4rCcfS2AyLv5sFkAYW4qHKYX4mQ5y4FgBmNHbwmpmcLnbI8Y+v13sXlENqJ7V7qqWTtzqQNW0gWKgfF4TPctSNlP+p2j0qDyjHRsj1A1XAHqEcS9Jt8I35chzSpSVbd4lrhYy7hub2UYOepBhpZIYw1RBWJrxFcnhsQjQLb1oZUz0r2ghEZMaVIVOgYUTdnj3QxYUIPGdSIyBcyyNskBS8ukoZrEyQd/2agwiVox/VLIvXQQRBQgGCkySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onGdmLkK4XMUAgQqhDCQFUnwWfggfvpVnndmrL420B0=;
 b=QA/fylXFRN+OYvTkjmXvMk+N7NIbbN1FFCeabxRj9JzzY+DGWssg+X6fm/c6eld6tZrEV7zuezXfCJOPhDmJmlwJTVQTr+JBjds0gZ+AnOMqgYWeBGujn6K69LcSt7B0nBD+g0FKBS1MLVgUtSxkGDBTYqKzqePQUQ+hgFRDyp91fhh3YBrO2tm0/HQ+diX2EdsjHKjhSJyqvwzg4BhtaPgYs9BRbtBPY7k4yB2/3ZdjPbppSo+oa9BvUZqfHE47lQ0x/L5K6Cz+ikq9fWOYKyN6JlfnVILSc+Bu7WF6ipcpKptgHCa17dV9UM+t2YHDdG09HYnhKVp4mAb4BtT7xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:04:26 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 16:04:26 +0000
Date: Thu, 8 Jan 2026 11:04:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>, jun.li@nxp.com,
	imx@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: gadget: uvc: fix interval_duration calculation
Message-ID: <aV/Vg4BBAa+kl+0k@lizhi-Precision-Tower-5810>
References: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
 <20260108-uvc-gadget-fix-patch-v1-2-8b571e5033cc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-uvc-gadget-fix-patch-v1-2-8b571e5033cc@nxp.com>
X-ClientProxiedBy: PH1PEPF000132EB.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2f) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: 141e2d47-ef31-4a60-a746-08de4ecf989f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eFnQOGWtky+QH3xjvXi95kvDnjyAXZYEq4y3tZTTKAXD6p9pkvBxhBzr77vE?=
 =?us-ascii?Q?OUa44oL6ArE/3fD2zx4e6N8EBbtZnDwGifEbC2fUOlKa21XvJ9R+OvRCfyI7?=
 =?us-ascii?Q?7JONF3PtrIzZ5ODKH457HDZAY32yUlJ7F7DugGN8VWOgTZ1LpVRAbi6Y1/GV?=
 =?us-ascii?Q?wNdcpwz3ZVVdeBoAOyohXKTgJH7SC1nnxeXY0XEOKqzgYiaXDE033iC0CMSh?=
 =?us-ascii?Q?MziCb146u6qhoPqZYOPGh2yl09Qu4cxJThFCcJRmdF8WJPeWZoD9PKV7xs8c?=
 =?us-ascii?Q?e4EbGF0wmZsHeGfYcD+GYGr0O2BIfdY/k7scSPozI99m57MxhSGxLHGilrqn?=
 =?us-ascii?Q?RM1KzwNCdOGwLGJBm57w9aa0D7odTGW3nV/NF+C1c6feMioDFOPuRwqUJk/v?=
 =?us-ascii?Q?Rp74jAx5dm/9uN7B210uhj/unbxQ4Z+kipTXTQTIs9lWRBR3B0uOCxfHAxZz?=
 =?us-ascii?Q?pVa5P15ByQVaZYRrv67FCe5t4rF14+WeB4vcPZUFN8yZ1HtNj2crzUAq+1Wt?=
 =?us-ascii?Q?qOJHeK4UXKMkbjg6myH1eQI1Hl2GrqpqmpUL1/bnsLoMRXRaTGSxt+MBcHU+?=
 =?us-ascii?Q?twKDDT8x7xdh8wDSWcFdgxFAHAOrS/V7eqz4KbWoTzck0j8QMj2GY9G+bfaP?=
 =?us-ascii?Q?HCFVRyNuOP5/jtb9ybPOq8EHrH9KSIb+49ihEwEb6xxIqzcHQkT3JVycd6Ms?=
 =?us-ascii?Q?T1AG4nBiku9Q7eSbzRzkb8qDjWZtdXNNFfTlvyDEt911qCpW8t8HHN94rLju?=
 =?us-ascii?Q?q3v1Oe0/v/TXtXlESittDVLd5Qn9VZRdXYW1VGkOjTZW0DXE4O+Oxum7ymFJ?=
 =?us-ascii?Q?Fp13qXftNm7kagVMtHYUqz9MxXcAGZrXKqnSf8iW64tkRwmcpFzqQhW8EPit?=
 =?us-ascii?Q?n1AbfCdyTfMaphXm/DD06eaHst6Qo+HFtDH4jnTy3K9IjQ822zWbDGdEHH/0?=
 =?us-ascii?Q?wLJDdJztnTOaTy7PT3HKiA7XTmd0Qh/R4ExT+MZ1IYYSTMGhSR8VE/gZ0my9?=
 =?us-ascii?Q?O2Z0Sa4PEzhLlFVMagJAYIT4wqtEtpiTB7oJm66U4pJLssMo+zj/1tU8Swjn?=
 =?us-ascii?Q?VqrjFSsypA1bQUmBO11Aykx+48Cex2ACjfJjDv0GHKOpSFmwLiP2UE67A82y?=
 =?us-ascii?Q?tlms1mIlZzO4iWz/MlgjGcpSSjjA4pzLCrOXpvy3o8+rO7C2KfqxJZhmBkhh?=
 =?us-ascii?Q?aIX3wZWAj03rxz6rtauCc9U4iPOIiuOGagvZGxsRVCS6bbCaAq4MjG+SELHH?=
 =?us-ascii?Q?rRLum3sJ/c/GMTC80vxvxjoVseykB7NWlvVtrK9uAzHEnDEhhqZeXU/sntph?=
 =?us-ascii?Q?ciMC2RnSouizePSnbguhzSJlFvohhJJ4p6+tvsEQHBywwKqz7tkFlgAViAaV?=
 =?us-ascii?Q?0j8WYudf800uyOKkbOzhoLFDtHDH+bSZxT9Vu89kV1jLZGvYIBMrBpEVZ0wp?=
 =?us-ascii?Q?nc2yvHzEv9x08ZjQZDrAX8+YE2HJlYiQjJjBBToxQL/NadRECfFMFlzxO8NO?=
 =?us-ascii?Q?7uj61JepWMvrFEPqQVKJNBwSHNLp5KftXIn6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kMgBdu1oERGLFu3HfUrs5OenogENF2nvDivT8QeSy46zglgPjhwXjGsW8yWN?=
 =?us-ascii?Q?c5X8IetvzuX0ajIjZIBwAfCq+aiiG0BcvMO/M/piBfqa+SFVvjUCsoOP2TDO?=
 =?us-ascii?Q?0eSx3d269XZ97hMwBhUcUE816hnDY9A+ayrVy21HKH5QMdQsuv207sLbfZ11?=
 =?us-ascii?Q?l889AXPES6+pENLLVd/Vw2lOHJDGqkYHa5S9PHJPygRRryittz3jwGLzuv16?=
 =?us-ascii?Q?asc6ekB64mq3JO8yMQsJhBfnXFGtL3qqfVu2st3mvtx747QkPWW5mLnl3/gW?=
 =?us-ascii?Q?AZht7VSeelMB5GHRuMsdHnghdLgrgMHklZGqsDYRh+nE86NKvOBMNyds8Nlg?=
 =?us-ascii?Q?SPL4r0eYVG32QZYO3zED7nK4SJFFAyBtX6yg64x3/bm0Lhs9LY6LF4cVAxxm?=
 =?us-ascii?Q?93PcHxtd86jaSO1BCMHVqYqtIhqNYUYT+HeX2Ji6HFewrQkq0319u0yailRV?=
 =?us-ascii?Q?TLxzJs6pu5PriuDBB+nbHEetuQLmlBhvcQiWnqhnk4pd7BvMTI7vBfChQn/F?=
 =?us-ascii?Q?NmP+TvRcTG7XPX1E8rexn0MktqXpQ3qJVzbDPhSS3Kt+GKPuzMipyBrLIgXH?=
 =?us-ascii?Q?Q6rGNCpNTbBrXPbOAXz+8O3+QuA7FLFPdjj0XpPI4fzv9ZzF640nhIfye9oo?=
 =?us-ascii?Q?ekmetghHX8ziHj6VmRTPxmfMtvh0Pq1CQQus0LZkl8ZLnVCE5IuAgR7QFEzY?=
 =?us-ascii?Q?uaGOWfodyvrIThpXFHIL4lhvMyPoDsvbsF8AtMhPy/HwleHRXWhUrLZGV4cw?=
 =?us-ascii?Q?V7pOdkim9YVJlVSNxbvDLdiUKvQS+IbLai5JOaORN5UvAZNJbifEE4oPT/wj?=
 =?us-ascii?Q?kHnzF/5xlDmKV+IrxmTgkS/DG2tb9JLdDDkWK0QAaNfCL5XsNr+4NHk7nX39?=
 =?us-ascii?Q?cHnQEKr245r1spziHrL+l3lR9GRMq24V7n++SUuwOY0WOYqMjfuTSOYaNFZ/?=
 =?us-ascii?Q?nsjqqmUalQrlCYyQo5lAOMgDKRtoPw+DlLg6rppcY8MfCHiUjvnrl1hTgcrM?=
 =?us-ascii?Q?TwlolHgWNPUsjamNM/ALlNTtLBfn4Go3wqp8T212JlPIXlJTDMDyKghkbLAa?=
 =?us-ascii?Q?mW04gjGW/uKJeU9SzsbxqruiWz1brwmwTmIL6uZ5/IRMyE15TVKZWJ+lJys2?=
 =?us-ascii?Q?s+/KCP6eSFYPk7X9ZDB6fbzgk+uzP5OOQWBdFchZ/mOSm+8dHpOE2kdlVMVi?=
 =?us-ascii?Q?FhWrAv6iEn9ebhxj3FBNM+JAgeqK4it9aC54KvVmEVSk/DrN+wKK1EL7e+Ig?=
 =?us-ascii?Q?1kk/1Vefhu4o9h3+D/RuFPKxg7v0ppl7wK4bHu+qGW1P+0uKMZdTkqezQyNw?=
 =?us-ascii?Q?JqaW5yiOtbjpasA63Q71PywwlXsQBxWiyxyab29Q5A4+UaTm60mdiwH+8ai4?=
 =?us-ascii?Q?WwEL17tuRHPjZ81LgzVcdtvW6QjcsrqU2YgZKhOfbDIc5vFxIuZ2RYQOCRMr?=
 =?us-ascii?Q?COXIeiMOoRbq4/TAbXGGLQPhJgs/DLpd8ax2xIkM8eYR9yo9iWHcPuCwZ6Wc?=
 =?us-ascii?Q?pNLrDWUeaj0aZRa+dty6yuzznOjDWAFfbG8isgYTGXstyPKGM2LZw/C35T6O?=
 =?us-ascii?Q?hogdA1S5HegueCQCa+uutNEU7K6ifORetBZweWTUDWg1l/7ZFkLcmUVJO013?=
 =?us-ascii?Q?HMDD/1L/UYsA51GvAKWoJNmTWGb3ej6BbPc/D820XJoraHLQ7cluyWYS3osS?=
 =?us-ascii?Q?V6Bp43HT+mO9opPmkNNuP3awmq2tG2L2R9gKhwhfuT9nR8+lb6QN+DwsOfiV?=
 =?us-ascii?Q?UjuZ8y8M2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e2d47-ef31-4a60-a746-08de4ecf989f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:04:26.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHS7+Umktx+RAqaBEaHHnFTMaHJpzScOCo9qK3g2qij7YWlT+iMesyG8zMl7PJ2quHbSGtq//ZbmwYG4d5W+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

On Thu, Jan 08, 2026 at 03:43:03PM +0800, Xu Yang wrote:
> According to USB specification:
>
>   For full-/high-speed isochronous endpoints, the bInterval value is
>   used as the exponent for a 2^(bInterval-1) value.
>
> To correctly convert bInterval as interval_duration:
>   interval_duration = 2^(bInterval-1) * frame_interval
>
> Because the unit of video->interval is 100ns, add a comment info to
> make it clear.
>
> Fixes: 48dbe731171e ("usb: gadget: uvc: set req_size and n_requests based on the frame interval")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/usb/gadget/function/uvc.h       | 2 +-
>  drivers/usb/gadget/function/uvc_video.c | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index b3f88670bff801a43d084646974602e5995bb192..676419a049762f9eb59e1ac68b19fa34f153b793 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -107,7 +107,7 @@ struct uvc_video {
>  	unsigned int width;
>  	unsigned int height;
>  	unsigned int imagesize;
> -	unsigned int interval;
> +	unsigned int interval;	/* in 100ns units */
>  	struct mutex mutex;	/* protects frame parameters */
>
>  	unsigned int uvc_num_requests;
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 1c0672f707e4e5f29c937a1868f0400aad62e5cb..b1c5c1d3e9390c82cc84e736a7f288626ee69d51 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -499,7 +499,7 @@ uvc_video_prep_requests(struct uvc_video *video)
>  {
>  	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
>  	struct usb_composite_dev *cdev = uvc->func.config->cdev;
> -	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
> +	unsigned int interval_duration;
>  	unsigned int max_req_size, req_size, header_size;
>  	unsigned int nreq;
>
> @@ -513,8 +513,11 @@ uvc_video_prep_requests(struct uvc_video *video)
>  		return;
>  	}
>
> +	interval_duration = int_pow(2, video->ep->desc->bInterval - 1);

2 << (video->ep->desc->bInterval - 1) or BIT(video->ep->desc->bInterval - 1);

int_pow() use while loop. slice better.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank

>  	if (cdev->gadget->speed < USB_SPEED_HIGH)
> -		interval_duration = video->ep->desc->bInterval * 10000;
> +		interval_duration *= 10000;
> +	else
> +		interval_duration *= 1250;
>
>  	nreq = DIV_ROUND_UP(video->interval, interval_duration);
>
>
> --
> 2.34.1
>

