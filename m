Return-Path: <stable+bounces-206377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C1D043C0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198CE33E1226
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727B28C00D;
	Thu,  8 Jan 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hD3Gyp4/"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40517264A86;
	Thu,  8 Jan 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887708; cv=fail; b=IyIw0Qy4ri/fDt/NBTHCCJUFKXNhsGzBHbtnQksZjnAF56+Bka88AlQIUDhoLjIE7RkekZ12Vf3UibmEpkGdHI9Pf5ctsUc1rjWMRe6CLN4ukDGLe+1n/LgZrvmRperEduutE/Ys/wHIFJu8OzXD+hWo/Q3vMdh6NpjOXu8AWDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887708; c=relaxed/simple;
	bh=bpUKPjkLTYvzrkeQjosHX5c+2l9WxoNck6jRNeu2oQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ecXxcxQz9J51FBbcFFF0JKwj/lcgzCb55fTmgsvI/yNEbJPREM21MnGeX86qnj1lji+qa2Thr6hrvEtOk2ueVd8t3aaeZ54nPmXxRZ5R+kcc7rYGllUTg6qTi/7annElpEAE+1WfW7gYgMDS44Ec9dX2qLmdBR82nqhZrGjIWN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hD3Gyp4/; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jodybilyoGUIzL6K+CwE4EFJaRkVZEIJ6DU3Zf8UO0YaNTMwWmex+DdRq1/vEnNKfhtDni0QiAMU2+ztYnaOCRMKZ+Is0L9DdvLGKdCmY4s/EHdUMDAG6Ab0iQ8pTieF2X0rN4ZaznIdSIQ+CaLQjOxzB7CmT3vO4z87ETD370vjaXm3wBvAIFqHyJeuTjCWRW2phDTJvPLfTJbLh8jgb2tow+zJu4062V6CFA4+YD2zweyeh7PumgI3ZWiA6sHNZAUc6D8ewMyuOY7gIpyfRM/jzsw9loikz61xxYghaT+lBJpwVPWkdZ8+xmj4vY5nc5GH8G6O4aTH+fiS0SlppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/Rq9XIdTwv3JoCk44ybSFXqALkXkuO5/yKWuUQabjY=;
 b=kT3ApcJnQaxUtlOgN+BbcivJfGA+aL9r9nv1/Y3ObYww0WOcH08i4POVuwCsMwJf4X7wW9tiIhs6s9HFLIlYcuxhfVfIwdK/BQyg/WL+KsqcDyVd7neMeDi4vEJ0TL/aGV+2wqUSPv5x3BQWV6UfEaYFDJ7XntysZW/Yxp1PIf2NEKrvOnE6EdI08rYzxP9BX0VVtPWSsVhKG4gc6HV/IkV/NQm6OXCvxK9yVzewJJlBPee/r33zvGJK49AwQEqYmv+FkSjAZF/Hvu93Fwdm/NRGzwyI/k2+ZtCddjZi0TgRXlaHzwjHjD+9W3HcdBVV0sZope0a/cEBEbuBjw4vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/Rq9XIdTwv3JoCk44ybSFXqALkXkuO5/yKWuUQabjY=;
 b=hD3Gyp4/U1TqpMIm07pZbIhnF7oxYr3u5pMnrt1b9rU1HDdOqfMuUQlxZiA+wzFiDYUzkMOJHwwmFPPn98VYWtg0RmeXLjgg1jYWvlpPIhKBYBKI9xrZL2OwnOYiDDixP18nqvxsy3PcnUY1a5dWsg1AmwXMiiSUHSoMJD60frIeccn7rfXFCEZmEp9i5BW+95v+NrFhPglV8+sUSuyZjAzwZeo60HpkLfCKkC2VeBU88mTgD3hLd6niVeNuYXYipkP36har12U8Xx/0BXWp0koNyOCQf5rwhZ1SstpJ8E4GVETIZy0j2ZQPZJSRh2DeHRybpIfXoBdID7bLvtXNSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA1PR04MB10226.eurprd04.prod.outlook.com (2603:10a6:102:464::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 15:55:03 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 15:55:03 +0000
Date: Thu, 8 Jan 2026 10:54:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>, jun.li@nxp.com,
	imx@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: gadget: uvc: fix req_payload_size calculation
Message-ID: <aV/TUFLMcT2lng5m@lizhi-Precision-Tower-5810>
References: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
 <20260108-uvc-gadget-fix-patch-v1-1-8b571e5033cc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-uvc-gadget-fix-patch-v1-1-8b571e5033cc@nxp.com>
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA1PR04MB10226:EE_
X-MS-Office365-Filtering-Correlation-Id: 0586b1f8-e2ef-4aec-32cd-08de4ece48f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EeZd3Xy3Wde1Ftvg67ooe3cAM/zW25ACPxxhTLpnGsxg1OI5uLDYCjoovaGV?=
 =?us-ascii?Q?Sr57QgDua0H+y+0NX0m+7fHWiv14Ljs8X2HzYJlL+3GQ4PewGLM/jNScRK9C?=
 =?us-ascii?Q?S5Y4L9DxzHOgc0FeeeDZJ90Z4p1W9jPBVByI5LLHun/79yCVBPID3MYjAA/W?=
 =?us-ascii?Q?SQRzr5UDx/7pX1NndIR2EJAHIARChYiWBhr6AkpeXxPQ4X6LScdqcusVgThf?=
 =?us-ascii?Q?gMCXwRnVPwdkl1tVgkD+cJApeE9OEpsGsrijI9neE2QMWUh85o/cOkzSq5AH?=
 =?us-ascii?Q?2l/SlpmXAlZSErBeqG5SLPYRys+g1eHEDCT5oxWiqjllX/InwG9silUnrPfa?=
 =?us-ascii?Q?kNmRLI3itY/9w258YZ9an897lft77sK4macO667AifvX7vGQXZkcwrpN8TZI?=
 =?us-ascii?Q?QtDoCAa++TfsmbBeT0MK5xrhkAJ71+4aGwAI2jIoA/qnNwhHOw2G4iApej28?=
 =?us-ascii?Q?pT6QX0h8Mnt7EwvTzx15U0HXNdbB8JPYxpRjk+TaG0U7qajmcWUdBVfiDU+p?=
 =?us-ascii?Q?oiebXizQK/Bd/VtcpLPfSeSPPjKDqXK1+x1/QbknvJ1jYn7TMQicDOBELmWI?=
 =?us-ascii?Q?yDBlUrx3ZTe0VHm84bFo8VMM+EEiG4jrF/Pk6bc89vmudB1rSmypfd/yPiuT?=
 =?us-ascii?Q?OFbpBYwWRHFhKgNzr4VwZ9r5wecdz9d6kIfyQrH6MgUw1DzXSfYFA0WIDOzo?=
 =?us-ascii?Q?dzA/iUMFC03uAgWCStGm0sIY3YEDLKKeo86fXjQxAnL1WbpPScfRI5+8LrbT?=
 =?us-ascii?Q?ItU5bF9Qn96VtGJZxWTKqTuaZjD6BjA7MvSN7PV7h/7wlRmugt77TrMdhWdO?=
 =?us-ascii?Q?Gs5klINdGqJCKsukcMVLFXK3YSOu23m4k7InAR0A8KC1auF7eIjEN/0UmaX5?=
 =?us-ascii?Q?cDmYPDe78pPAz2S0tkSE8kbyclKFDS22L9Dlqiv54Mv9/M7mG7vnjXNyt+Am?=
 =?us-ascii?Q?nzkHKF7oI5hHgipBjqRcoBgoegw1zkig4p2spoEVjf4R26g1cZO47fjkmM6E?=
 =?us-ascii?Q?yfk+T/w6ce1krpcISG/HfPjPsv3QqpoLlu5nc80pcM87DgMGPAJLhC2RGVcg?=
 =?us-ascii?Q?rAC8OITXHiCZtL6dGClShVLCO6gwkMV3nrwfXp5gj3HPQ6Xr6aifSSwNIpiB?=
 =?us-ascii?Q?pUhSHXMw6sAGpCTumE5HMXRs34cMF6hUx0/Ubur++E9GfbzTkSXaS32AAq5C?=
 =?us-ascii?Q?XRdL3Q1ixsaN1KEMMIG2vxs1ETuHpeeaooKfS8QqKcjy3mcntwWjnTFAizx1?=
 =?us-ascii?Q?XFCdJ+cNnN5/SU7pPt7YYxw/ouwLRq4SXEI1G3/UwJ6yw12RFdwp7IABozuC?=
 =?us-ascii?Q?Z2UeIy26yqWjt4vk/nVGmM6eGjWf5sgz2mlNuUZj/BdvohRa/5vQ62k7lRqF?=
 =?us-ascii?Q?/SUWiiWmkiC9SY+bhnQ+7+HwAu1lGgTZomdbE1j3H614RppO3vtNYRJkF5Rz?=
 =?us-ascii?Q?qBhqLt8k3Vclb4fuqxDr9Ghl3wR+VKSacFWmgH4/j7ATUBUj90Ql4qBzv7Ca?=
 =?us-ascii?Q?/rVIzC7ijdAg35yrpeeV0t10M3diuWn6VlsU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AaAF4W/1N9YbrqJXd1MXDujBd2hqRYZDjycgDYfJnSsSRRTMvG/JP3jYm6aS?=
 =?us-ascii?Q?3v5tUtoa+UMeuUKrRvl4nH5s1xgzP4GzX/D8/iv8VCcDK8avcv94ws/Gf+lV?=
 =?us-ascii?Q?SdGJ4RSOwgasJBH55wQ1F88MKDfM+17+YqGx/CGEInJ9rMAF9ReOkyCDW/lh?=
 =?us-ascii?Q?rAMI9lbYmzU97KU5QLsoLTidYPq1t5Jj4uEbOmlQnsDPHh1mN4lFR4F+1/4w?=
 =?us-ascii?Q?VLy6gUM5e7KjNNPy6urGZRZ0dJ9wB0Yd8H6g9FDBRS5e1SnPedyHxmg4PMIP?=
 =?us-ascii?Q?NY2G0RhvNTEILmSwHiNAvsRwfexbVYGOptF7bS4CkWZdm8EWtrQsnpk9G/dY?=
 =?us-ascii?Q?4rEFA7co6pVCGr27ty6Sf5TeecjRdvT2a52SRZCSjosepJQ+EE3pcz3DLd24?=
 =?us-ascii?Q?h2ksa/XjkmVKlgvkUsO8nsgKBpe2+24S+rwdkr0CmIPmOQvcJLyWmmUpFUnm?=
 =?us-ascii?Q?kIplXhD/0Z3a1Z1n8lqcM0lvlUx9SeEHxEmQVqXl1eHC4Szcj8btuCGPSsi1?=
 =?us-ascii?Q?Z8q6NxT1ytG35ZTQid86hqS1xpUJCIXo8PQs+4yvPIo0jKJ3Mmwgb2Hcnnga?=
 =?us-ascii?Q?PV53P3sNl2oRxyYw8aMKVQyFadXT0fubtIa78BAfsfcBt1+o+txCLTIvssYx?=
 =?us-ascii?Q?kqItPAC4gDNfaCmktnF1cIOcmAMPxfzGBSdnxCmBCCPhcgPDkR+A2gtaAGSB?=
 =?us-ascii?Q?yoI6wW4g5VuQwmIvYzNnXiekphSPqldoVqAxNd/PXjEOB0zLZKTxM8N0o7xX?=
 =?us-ascii?Q?42jUZsZ7rGRBsOa1F5+NtAd7ZAHMHW9tXfEy/wkVHn26FkFI6wHvRwza84VN?=
 =?us-ascii?Q?yftckC1yHuVdg4AG3zhW35mHUI+N2jfgYqvQUXjct0MqE9ufd2RrhJUb6/M9?=
 =?us-ascii?Q?RJmHZmgo+cXKMrgjU7P7ZHjIrPohK2S3N0Iceqo36+lp8GrDKjdOi6nWxxpp?=
 =?us-ascii?Q?vCz1GlxsTe53t8+jiS3r8EkPOBcQglVFrVhY4lJSYRFoVN6v+ChmnLFevjhd?=
 =?us-ascii?Q?dEsFUlk53k7sZSs/qPgtgAECXdjGz1NWkqC65SylPglB8XFN5wYBQCLpbQ0P?=
 =?us-ascii?Q?uW+U5UAOwTQaitZh6PRdcoZ9LrmpCwZ68ot9xDV8kwPy2sxqDMI7ZGnceK5j?=
 =?us-ascii?Q?3QzzOkELrhTL6zuC9PKaEn4xeKD5FXyzfqvpC22a3vnPznloxM0qPr6Fxu0e?=
 =?us-ascii?Q?LqSMmJPoM5y0pr/vhPSo9I9kQiHpLjWdUqtni/ua/tk3UZjK/IdrO8swetaX?=
 =?us-ascii?Q?z1zMn4ZzTbQwVdkvJQAbBqh3evGAetp9T803PBr3WPNyDV4zIFL+bRmezmqX?=
 =?us-ascii?Q?6j9LsrfpgF67vbsBPJpYWMsTLHniJyz24966Glckmo8qdqQzH8zmYaUxW5Yo?=
 =?us-ascii?Q?lEn+bx/FlcIdKZF5b0lp5WK9XizxZ6s4GfHFsJGXEmeGrrgEoS3C8QH/sTxx?=
 =?us-ascii?Q?ANvWFNxPz1H4pos4mpB8stfNEPylCa12A7e5ji4jNHKcE+12v1zbRUYjzPlS?=
 =?us-ascii?Q?cwJPSRhSFdEnv3eydRNWtaoPtEz/eehAFMbhGomiZFuZEmNssI/kCv/FIJAF?=
 =?us-ascii?Q?FHtq5OkR6Y67RMGS6usUiX0o45FexrRFXNnEPzeuzAqcCd/I+2Iyu/NuTzfH?=
 =?us-ascii?Q?b/EJSpT9YYv5RCQph3jkF3l7reZBosXWe9Ebg/IBOe+Rjy8K0gC3BpCcwmSr?=
 =?us-ascii?Q?mQkSHKFZWnQgwfUxMYjhXoLRRBURC4eKirN/DzCge0Ka8PW6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0586b1f8-e2ef-4aec-32cd-08de4ece48f9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:55:03.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRqK+SQiS2lR/uhz5Z6UkfC1n9AXegV0ZKVFb6emLBEelZjGysZU1JiZ0CDCGyKaLPhLWeRdQTSQFlUE0V5X6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10226

On Thu, Jan 08, 2026 at 03:43:02PM +0800, Xu Yang wrote:
> Current req_payload_size calculation has 2 issue:
>
> (1) When the first time calculate req_payload_size for all the buffers,
>     reqs_per_frame = 0 will be the divisor of DIV_ROUND_UP(). So
>     the result is undefined.
>     This happens because VIDIOC_STREAMON is always executed after
>     VIDIOC_QBUF. So video->reqs_per_frame will be 0 until VIDIOC_STREAMON
>     is run.
>
> (2) The buf->req_payload_size may be bigger than max_req_size.
>
>     Take YUYV pixel format as example:
>     If bInterval = 1, video->interval = 666666, high-speed:
>     video->reqs_per_frame = 666666 / 1250 = 534
>      720p: buf->req_payload_size = 1843200 / 534 = 3452
>     1080p: buf->req_payload_size = 4147200 / 534 = 7766
>
>     Based on such req_payload_size, the controller can't run normally.
>
> To fix above issue, assign max_req_size to buf->req_payload_size when
> video->reqs_per_frame = 0. And limit buf->req_payload_size to
> video->req_size if it's large than video->req_size. Since max_req_size
> is used at many place, add it to struct uvc_video and set the value once
> endpoint is enabled.
>
> Fixes: 98ad03291560 ("usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/usb/gadget/function/f_uvc.c     |  4 ++++
>  drivers/usb/gadget/function/uvc.h       |  1 +
>  drivers/usb/gadget/function/uvc_queue.c | 15 +++++++++++----
>  drivers/usb/gadget/function/uvc_video.c |  4 +---
>  4 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index aa6ab666741a9518690995ccdc04e742b4359a0e..a96476507d2fdf4eb0817f3aac09b7ee08df593a 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -362,6 +362,10 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
>  			return ret;
>  		usb_ep_enable(uvc->video.ep);
>
> +		uvc->video.max_req_size = uvc->video.ep->maxpacket
> +			* max_t(unsigned int, uvc->video.ep->maxburst, 1)
> +			* (uvc->video.ep->mult);
> +
>  		memset(&v4l2_event, 0, sizeof(v4l2_event));
>  		v4l2_event.type = UVC_EVENT_STREAMON;
>  		v4l2_event_queue(&uvc->vdev, &v4l2_event);
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 9e79cbe50715791a7f7ddd3bc20e9a28d221db61..b3f88670bff801a43d084646974602e5995bb192 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -117,6 +117,7 @@ struct uvc_video {
>  	/* Requests */
>  	bool is_enabled; /* tracks whether video stream is enabled */
>  	unsigned int req_size;
> +	unsigned int max_req_size;
>  	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
>
>  	/* USB requests that the video pump thread can encode into */
> diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
> index 9a1bbd79ff5af945bdd5dcf0c1cb1b6dbdc12a9c..21d80322cb6148ed87eb77f453a1f1644e4923ae 100644
> --- a/drivers/usb/gadget/function/uvc_queue.c
> +++ b/drivers/usb/gadget/function/uvc_queue.c
> @@ -86,10 +86,17 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
>  		buf->bytesused = 0;
>  	} else {
>  		buf->bytesused = vb2_get_plane_payload(vb, 0);
> -		buf->req_payload_size =
> -			  DIV_ROUND_UP(buf->bytesused +
> -				       (video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
> -				       video->reqs_per_frame);
> +
> +		if (video->reqs_per_frame != 0)	{
> +			buf->req_payload_size =
> +				DIV_ROUND_UP(buf->bytesused +
> +					(video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
> +					video->reqs_per_frame);
> +			if (buf->req_payload_size > video->req_size)
> +				buf->req_payload_size = video->req_size;
> +		} else {
> +			buf->req_payload_size = video->max_req_size;
> +		}
>  	}
>
>  	return 0;
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index fb77b0b21790178751d36a23f07d5b1efff5c25f..1c0672f707e4e5f29c937a1868f0400aad62e5cb 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -503,9 +503,7 @@ uvc_video_prep_requests(struct uvc_video *video)
>  	unsigned int max_req_size, req_size, header_size;
>  	unsigned int nreq;
>
> -	max_req_size = video->ep->maxpacket
> -		 * max_t(unsigned int, video->ep->maxburst, 1)
> -		 * (video->ep->mult);
> +	max_req_size = video->max_req_size;
>
>  	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
>  		video->req_size = max_req_size;
>
> --
> 2.34.1
>

