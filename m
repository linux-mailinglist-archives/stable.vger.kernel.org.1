Return-Path: <stable+bounces-121715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A64A59821
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996633A6A6B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2122B594;
	Mon, 10 Mar 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fi44SCb0"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8D185935;
	Mon, 10 Mar 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618255; cv=fail; b=IHhUQYrFSEyhlGGAiY6JPDeGzAUStCf64uQIG+0Df3O/4JQWUtKF1sMx0WjlPFmMljP8CEt8BbWPvyFZ6hQoODrEvsiAa3aCaBZo+jE0t58AeaW9VjZHirOGGh6UIPpT1NXZMrGGWSztC4f4pCixxXuYLplSB9rYErSWhjVGJU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618255; c=relaxed/simple;
	bh=+efUwZZrFXVQ7CKzz4hR0e8SwpoFFaVHqJBN1HDDJf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjtH8CRBBQcoQBxYfnEr7cC6g4U6rnBSuoAwXilQwvmyGkjPGAAW6/mVSPr4IkLN+kzlIasTHYRFDjw776J5b3uIx9s7vrHd0U6PaEDzcNt/pBBm4XZf+4BeXwLXbf0K2BlHYLkj5RVFzbUBc0hhBstVm4OTZwvgbgGlrtWibDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fi44SCb0; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPOJMx9CAw/bp69HhJr4T7ua3j8BfnzfnBorG/ye7W3e2QmBiazJm+7+jvLTo2Tx+8yj8wo+QuBZ+JUsNcowcUuZm8A5ZMad6QmVBpRex1OwErwu6Eovd5zgxvVM7GaiVNFmBDXorZwwN57/gg+4cQZN9Yudm5oQHN0RDEd1JsOkM9ZBvh9FlMMRDtmaAkc3fqawK3WgI904Aju2AOEnZ4DDcASgllPQqLnVwImeGWFkE8FXOTH2FxAtACVoPcNaRiIekIZ3n4ttWxXy//SQ1nqfY5HiVxuET9kVyY+tCwMPV3nD6l0kN+XYd/8thsSACEJizHqn4BAVjVpTgaT6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHmo65FQcou/O/bFc9HNnzMiOIqYMUqzok9XaGbdzw0=;
 b=SbHeM8gKWXlnY0vhZVm+X8Qvpwcq0/9Lsx33idor3zEAXusLe5ui3GjD82jbd7dBYhY2FuG+apkUhqG3qSia8MF/hplColYyYHGGYFS7HTQrs5VUWScGGgutGGtzXajDWggNoFsFvUe35OWOV4nlDA7V1lRcBdFsk4+L3CRBuMN4Pj8vG4eeDneankmXAU0UnTUpE95fjfbwe9tvaPfWBGPtMBpih7VtaeRaPkSgLeFuoFizrISBwvDxI84yY3+fjGi7cxH10I1FgB9Qos0gfesLt1JbT9GtYNjGDbrGHR5Y5MZadTBT5Gcz7jqemPPepqtgpMyed9GQry+U+uB5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHmo65FQcou/O/bFc9HNnzMiOIqYMUqzok9XaGbdzw0=;
 b=fi44SCb0HrFqn4rSO3DQ+ZRXoOWKt6IB8xRsv64ACUPYv1+ZotYYZ2Se6lL6QrzhFNjkgbGU+7/xNY2MsujCXfzqgyYQIsuD1/esiynZ/9tu4zRYnRr7piXyLFMUrVh0gEkpLafZHGoP6E/MzZoB6NjErQ17JH0qtWEQrwyp/iGytzGX3ZGbojJkxbLCVptwPSwBLtA+8xy+6yoLOd1ivP0y64aW57m5eLoJfZHZwWoS3ZHUhAly4dVEkAglyDD3mk7Nc8AuA+4WFpSDNC72QWV34KwkijLIxWfTJNpw2Aa9th2Oj8iJ7pms0MyLFRr9eAmXACS+SVRIyXJGMwsDng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10935.eurprd04.prod.outlook.com (2603:10a6:10:590::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:50:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:50:48 +0000
Date: Mon, 10 Mar 2025 10:50:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: chipidea: ci_hdrc_imx: fix usbmisc handling
Message-ID: <Z878PqYbtep0mOrx@lizhi-Precision-Tower-5810>
References: <20250309175805.661684-1-pchelkin@ispras.ru>
 <20250309175805.661684-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309175805.661684-2-pchelkin@ispras.ru>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10935:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b6e215-b494-42c1-4faf-08dd5fe2f134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0LuCIcsfWyC36MUxihs1E0h9E0l65CPuq9YQXcvHtwgQzvnzZ6F0tk/GoeP?=
 =?us-ascii?Q?qhAIF2yR/6xyppdnocHgB+u9ck9t0cGIeg6T3Q5EGttTo6v9qc54xzSuVuVi?=
 =?us-ascii?Q?vXDgkQZ9q9pXXi78/p+8URKL2azSsWSkrDFpeI4IiKOQQMFELVgcA1mrGkMP?=
 =?us-ascii?Q?g2txSJsVidtNFqQg/guqe/zERyfUbq2orwjdGXINnxvk9dZ6AP1zWd91m8cA?=
 =?us-ascii?Q?Y7m8PiMz6OLy1vrMU+4Ux3GX0n89vdqSeXOpdxPlu+2+c7P3TN7QTMUa/ZyR?=
 =?us-ascii?Q?qvkE+jMMQlca6fiLBidFwQ6tXhwVM6/F9Qw61Y8lhxcqUSY4ZbjuMC49Zg14?=
 =?us-ascii?Q?WqsK6HoaZ4ER2K73HiGhmM/I2dAINc2RIYncF36XFJBbtJ1r7kfp10biMgYT?=
 =?us-ascii?Q?8hzbw9OqzhtS8vH0dlLNNlrwOMP4mgBw03yaD8fd1c2LQ2EF659wHkYw6lp6?=
 =?us-ascii?Q?oWPQOYgbt3Chs8t3rx7JvXGhK6UbZ0Ike0rjA8xvNx1R0yZcCe7yRXD7q3Nv?=
 =?us-ascii?Q?8EMHwHHeanfoOU+SOkvVZtg43Rdwch0m1950uuzk4PtJv3PlCJzYEtWaHIhU?=
 =?us-ascii?Q?V5Ds5J6JEwHyrxXDClfn3E7oe/gRQZFP/Y+XrpVe7GPBur2DB8mflvyd3i7V?=
 =?us-ascii?Q?3vzbyJHLRNJDcFwmNsyFXrxm9fy6RvCgVy4x7+1BQvZkspl9OUsiJOQRzq04?=
 =?us-ascii?Q?LRzqkA9xPIyxhWbfNctT7HsMwCHeVNWV/Zhm64vMczgD+gpkKD4qc2hg/33O?=
 =?us-ascii?Q?GsGcP5MuKctzWQR5oKoMWDNP0KGD2B+SBjC9XJILNaoFnM2NzReFWbgQuNlB?=
 =?us-ascii?Q?dYTFuCeQasuzVYSLdc3tUBiny11r5lxLNWrRhJioX3Xn9zSGD08+QmjZvkzI?=
 =?us-ascii?Q?kcMGDx1R3YIZ9YGtHBrfXcjuQNl/qGMJBGTOy49aV7vv2T0QKyG5E9k0Hr/a?=
 =?us-ascii?Q?hth3WmHrp4Sdy+H+aWRDxDOSzku6sKowPZVM+5cykA2FHloe9hcrfN5rJrFy?=
 =?us-ascii?Q?YxCE2mr9W7Rs5V7/f1buXYruR0Dmfe6d+Ar/7Lu+U6YJOG1xGV6hlC6bUARX?=
 =?us-ascii?Q?IJSzxbK7JXXXQHbDAslqj/wo4IeEINBJC5z2peJOXLHkXcIOHTAHkATvKE9b?=
 =?us-ascii?Q?zMLZCcDY2RmTAeKHcM73LajLOds40moXvNsBQ+PL97EjIWvUzgoqcEQlLKpW?=
 =?us-ascii?Q?ptEVl9QryaEs7gD4xgXM5Aak3Yh0YKq1FuZFAY+6hJkXb0CnGpxC+K9e1sfu?=
 =?us-ascii?Q?WMaME4WrCSR8+QU0OyxbsFyym7F37WGtiiYNDho2Uo/2dfBrNs+khZKsbwHl?=
 =?us-ascii?Q?AKyLkW8tEqwOipzekvZJdFPYn/rLvmWKcWv5GPiv2LziV0hi8MOtkMDxuAkn?=
 =?us-ascii?Q?LGnQAnntiPDlWTiIem+hi6zP+BF//pBl1rnQi2oneYQVY/QmcnR51Z0Mgye6?=
 =?us-ascii?Q?Gezf6MKHqnWtWw/2EQYg/jxhRB24uL4A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bRrCgpTabFnv4XGBEDnNd4wVd10atnX8z154sbXiJyi6so3anU/DwQnqlyyf?=
 =?us-ascii?Q?MbD7758zgu6bt/I8jPihqcR+1VC1WZyuuvlTTGwrOaI87/w9h2AOCVvlP3LG?=
 =?us-ascii?Q?qiYHExhEKKfyzh2yvvi09Lwc5iupf6Ge5dSddkGNssFXGyYsoa6OkXAWoA/X?=
 =?us-ascii?Q?Os3HpY4RztTCG1KHwcHosOMTl1qQwDt/HR6OXL6DyRLq3Jz8YcBO86sRRS5v?=
 =?us-ascii?Q?0D+7YeAN50qkd0Mtw6aYcp0hgeFJngBBsWbjRj5sGWQUCMimcbRFyTGf8IsH?=
 =?us-ascii?Q?zfXE2eNFEpzByGqKAuiJWNMXIf1DXiPiBZ6pmUthkiRejg52Fw+tR+cbxsgc?=
 =?us-ascii?Q?6h0v5ovXfuuLHTXOVgTkOM5y2KtB4T+2+DABRmGx8aZZDu9SM+i2en38+7uI?=
 =?us-ascii?Q?Kos1LqQK8beQU8wl4ICLRjpJU/4KpIEyC5QafWpXXfYW+GybK3EQFU+pQ4r1?=
 =?us-ascii?Q?9DQ1GnyLk/psEgOGax2BpWKir7/k+W0YASM04ekArhzgjKD5BcwmH5bkevk7?=
 =?us-ascii?Q?KiKhwG3hABXhJ+C1PF4zUjP2QH4ZrWQ5mj0ifye7OXn2ZmIWYla1Afe+w24x?=
 =?us-ascii?Q?bQeyv3Mn+YI1mBZVU9Up0pMblaq/h8c0lk2R6fAmtn2SO5hoFEJ7XNmBjwv5?=
 =?us-ascii?Q?aR3KRL4cFLg1kw9AXPR+QIeVs1Ahpit/AsrIqS5/nxNaURfurgAUO6OEAg+j?=
 =?us-ascii?Q?0BCZ2e6inF5uPtjtOXKjyx4MEdnSUR/0peHBTiQXaLSVv4zBa5oAi+iAkDfm?=
 =?us-ascii?Q?1n93AUJpdcUB/7XppN8PGOzYH0D/CVTQGkaBxN0Y5wgxR5pWYhvxbZB30mFj?=
 =?us-ascii?Q?Br0ezYKyldUjzUpwpxV2tNISRVxrThkf0iTSPemX5qqbr0KEU2RWa0vGX0W7?=
 =?us-ascii?Q?Q+ApUv8oPZNyXq0MqV4Dyijkt1uKGyouXIIdHKUOZNczEd4Pw7GtVBhnit4m?=
 =?us-ascii?Q?RCz+By3P8Gzo+YWZVCLaRRasJBBiP3/BBPlLctHD7AO5XCh3u8OVAPT+UAM5?=
 =?us-ascii?Q?Y6aqOHiQvGUCDS2GcXWsVmnVltnT92T1jjs4zjOAz10gA/BUGKdBNFTQ/5Ii?=
 =?us-ascii?Q?1JhwYpRkfXVU8bXfZqXmTCz0hih7Z6tw5n7vJ5zY3LnSI00HHMJs7T60cpI8?=
 =?us-ascii?Q?G8yC9nE3StlXAuqFCuUWJd4AYPoVvhVviP5Q0nzqt3UkFJLoG8XELEcQgASI?=
 =?us-ascii?Q?y5zia2VDAKp0bg9qQZs5tsiG2GB8vzvC2YgYHGiimbZS/BvKAkLqC23XR6K6?=
 =?us-ascii?Q?uWwRZR+75oebkj6p8Zu+woVDjbJ4MpY/7nks63OwjCQVz+Nze4cWANv63hym?=
 =?us-ascii?Q?uASipeM40GFdm1RVb0jvBvDlvwzumZbHlmxlDiUOHiFYyICkmIIn/0Jlmfcn?=
 =?us-ascii?Q?/t6QM1G+T3RtRUk/4pP9XGvW6/mi1P4z29maE3KOyOQ605Z+S0TqgKYJt3vH?=
 =?us-ascii?Q?ELk0jVJjE+/Ui0FAe0U0DELuGEegopOzr1CmfdFkXA7edBK7wSUZ/rQmeDbg?=
 =?us-ascii?Q?eTsFNCFGN7UWAJEDOCwsiei1D4DQ7lO/lQw+3jz0mdznwEhNQV7euUMC2Y8n?=
 =?us-ascii?Q?S+U8nEp7INikOiynjCQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b6e215-b494-42c1-4faf-08dd5fe2f134
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:50:48.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw4QznST9o9x30oYL4OoRTAt++LwmQ22AjIuwhjcUNav9KGN4zQe/799Bd3IlGn52rCepmkx13/TKqwthXaUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10935

On Sun, Mar 09, 2025 at 08:57:57PM +0300, Fedor Pchelkin wrote:
> usbmisc is an optional device property so it is totally valid for the
> corresponding data->usbmisc_data to have a NULL value.
>
> Check that before dereferencing the pointer.
>
> Found by Linux Verification Center (linuxtesting.org) with Svace static
> analysis tool.

I have not seen any words "linuxtesting.org" in linux source tree. I am
not sure if it reproducable for other people. So this sense have not
provide much useful information.

Fixes itself is good.

Frank

>
> Fixes: 74adad500346 ("usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 1a7fc638213e..619779eef333 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -534,7 +534,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev = NULL;
>  err_put:
> -	put_device(data->usbmisc_data->dev);
> +	if (data->usbmisc_data)
> +		put_device(data->usbmisc_data->dev);
>  	return ret;
>  }
>
> @@ -559,7 +560,8 @@ static void ci_hdrc_imx_remove(struct platform_device *pdev)
>  		if (data->hsic_pad_regulator)
>  			regulator_disable(data->hsic_pad_regulator);
>  	}
> -	put_device(data->usbmisc_data->dev);
> +	if (data->usbmisc_data)
> +		put_device(data->usbmisc_data->dev);
>  }
>
>  static void ci_hdrc_imx_shutdown(struct platform_device *pdev)
> --
> 2.48.1
>

