Return-Path: <stable+bounces-192527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13885C36D1F
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F7018C77FE
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587583370F9;
	Wed,  5 Nov 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hQJyjfv8"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6828322520;
	Wed,  5 Nov 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361266; cv=fail; b=IRC1nfWv/qI/nKZ7Mi3K3Kik7zO3ZrMce6EhgPCtif8rhx/OmMFCg38PA73H36/qLsnrx4DW/qfZ+llTloHiuN1A8U6OnzCrrrcVq4n9odfAXMsgBxfV0qxjEVQrOxsJMZ5krsnBAMLvScW6WKFEl66cggmgFg2RuAgTzH4lXi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361266; c=relaxed/simple;
	bh=XvVc2Z04d4GtCor++1TQj+O8aQYBAg1NLc7diRRkUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H8fwXk9A4pYEW6GOtC/zaYK7Ai2+tJU95D5l5nW5W58YdEn2qNZYpztp4tDDpt2cZFQAEjN5f8Dw6NgdaFEKKmdzwGiwfjC7TwrKOPyVwMADA/6NMyMoeLgX8FXtJQOl9g7KwXm5PdU3E9LK1xvyd5dtSFC8dq1dXCtJyTVfk+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hQJyjfv8; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXOdbjNXtLlAjoEYsNog3tfWfSeru5LNeyGTBlWizOvSCAvBolW8VemUkES31OwB7FGfjqhHmkAYl/d7Qw2r5kViEGSWETnOpieY3y1a885++J7R60m1sQA9QWvAaLfh5ybjryH841hinDo5407VjdpAUX1PX6pV/oe3858NjFpDqLnZ06y41Kdn2lFE+x2EHyqh3SgyWK5DxJpTqD5wUmerqX+muDd5khn3nd8iormpawTFhpRWNUoI49tXBlFlpnMbC1VHq9kAO0TxB487Wf4NfmdCNxAuHLWfGphtQpA+AGh0wK/VKEFJTJj60u99cQxvZd5/skD/PvU/4EB5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yru0XVMu/9JgVXC1Fe4UQ12H4UfttcSBLb4c1hDa7sA=;
 b=WobGfkrhgHaGnL/XOoGl3sYtXiege9V+5Ckq8139nLY/NqVkntmJcD0YqM/3y/KeLuFXJs5xZI+lQLnU7MPeTGcXCxS5/E7hUgMTQ1jq/WCz1/4dQNhhI+XAq30g2DtgppKtaZnk6ziurkppBf0XG9CoEUVElokQ7JlAwGZQb0cc5+mZjlKST/ryt8uD5wGfL4Org+CG8yqB3lbX85xRK6WDx5i9O8zm/5VsFz/dyHFbN1tni1ecowfhKRUcSyg5NzD1IEaHp7wGKfSOH0/YZc5j0OKbdx/4NWTQgi+PlY196pfnvKR7328xloBcQuR6itQce7W6cCDRJZAnAE5JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yru0XVMu/9JgVXC1Fe4UQ12H4UfttcSBLb4c1hDa7sA=;
 b=hQJyjfv8SrDx/17azi1opES+W2+LTpDRLwjqdvGL+ESqr9v1pesn07MK8UGawqMojR+r8rDjsEeRPE1yOTR4jdOXF+/YEsUfFUpSjaOmkkQRVJTkVAThtWZH/cdACFd5qryZGXus3yk3QdoqDe6BpFqRCtyvOgG2NG1zTHMBJuzOaeLf0MwYYHsh+R+9t9PClZiWwX1nng5AIerFtPHnznCJDJbW1RFL+FUp2X2LyG8dos7dqyDjE/uU//vz54G4fEsnGRG2dYGshZQKuJKUwqEAZ9+QixcCSZwHn2h3PZLj72AeiTql1xY3ecJTxkQZDba19mM564ZUtUWxLQ3zkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:47:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:47:40 +0000
Date: Wed, 5 Nov 2025 11:47:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Michael Tretter <michael.tretter@pengutronix.de>
Subject: Re: [PATCH 1/2] media: staging: imx: request mbus_config in csi_start
Message-ID: <aQt/pE/7BMI95+Hl@lizhi-Precision-Tower-5810>
References: <20251105-media-imx-fixes-v1-0-99e48b4f5cbc@pengutronix.de>
 <20251105-media-imx-fixes-v1-1-99e48b4f5cbc@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-media-imx-fixes-v1-1-99e48b4f5cbc@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: d9316d0e-157f-482a-9ed2-08de1c8b08cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7h8SH7DGyYpcw8DBHC6aDv77XhsKFVgBCBAq4ZUEoCI6xNRdWu9R//FVXwmy?=
 =?us-ascii?Q?+ndjoCIs+y4L2XAvUeAHh2qvqum1T1lslGkLYxV6aiyDFFvAdqbCeq4Nn8S0?=
 =?us-ascii?Q?0jDNjYymyRtgaWU8QBU0k12NHom7h5G09owu6PsXAx0z+o+qrJeZd+PHrmKi?=
 =?us-ascii?Q?qgDK8LqYF+oZasrN+JKFkJYxe+Zr2Jrark2uWnfQwLhJ6tZmqZaDOYJnodhp?=
 =?us-ascii?Q?I595B/N8PxWiNmjujA6MW4vldcpjmOFoUv49llDpji8o8DXBiDEmhmu0mW61?=
 =?us-ascii?Q?Y+Gx0MpFDgBlrsiJL6xaNUwUBkQo3lWi+wjgJQA0UOgxjfRWXz8xxHb47eSa?=
 =?us-ascii?Q?GgNdyOYDOvBZjHsysO24qJkOa2sBsm0bu59+oXz3+/sON4s3JyrdYZduhC9K?=
 =?us-ascii?Q?cDkNiQ8lJ2jMglk/rbYJR5ldUxeoTz4huBp6KIl9pk3skNz9QT0CvblqvhyF?=
 =?us-ascii?Q?VNbOHOi8z+h0NgL1cV+vgPSbrOLca9Bph2+40TrAHZFmgyF2EAqiYUxoHzYB?=
 =?us-ascii?Q?+K0J+lnb0SqMEJ6KMdyEasnL5YfVxsjpR7wQ+787bJy8LsLRRX16XQSLUU+c?=
 =?us-ascii?Q?+X0g7H4mRGZmfV2CLn6aw+cvdDFRFVLONzjCrDxZDsLNfpWd3cWeuZrobjRf?=
 =?us-ascii?Q?GcP9KB+WKQHWchx2OrWp33q75BUhkQgk6Ktj51G9C4pqnR18qa96DN61sbYN?=
 =?us-ascii?Q?MBV/5Ww7NwOwZ9ARLKvD8SDDY7yHRmFtVl55BeWh9G+sb6txkppWppTUDKC+?=
 =?us-ascii?Q?bJ/W39gGwrb2yG890cA15bFcmh16E2tRZwAeLwBN1+24f2wjBsj4Q4yOmJNf?=
 =?us-ascii?Q?XGB9IhGTJfOaksn2k8wRxUO0QHZXaQ700EZ/bqIkst/3L/67UXf3/6j9Vxod?=
 =?us-ascii?Q?wVK8prVe9Qn+4kN55N/Gzu7n32JxdFY8nidTKP6oDugY4CmDn+S6ebZZco+n?=
 =?us-ascii?Q?Ts1D8bhrkMCsLrWW5gbL6BteEGGuDEWRJj/OiH7hlywN8TV+kg9NP5gdF8y6?=
 =?us-ascii?Q?UQq3bbVDAqP/fwS/zyK7T9b/ENgtANtAS51VAz9ico0FlAIEyfkzBMQL/gab?=
 =?us-ascii?Q?Jfa3+2ndQ+aqiVQIZGUvmWx0IJ5MDnv66osSv/L04YhVnC8zZUjrqH59/8ni?=
 =?us-ascii?Q?+A+WEzCzuHPXiZStl2EFVshadrMYcQXOS7XYIeETgwbXLFA5YzQNqEOSrBY1?=
 =?us-ascii?Q?hzEW+34Vyn0yRRib0GL1CzoMBemRl4PhKpQzmzzjkiiHOe2qxSQtaAnLOxNo?=
 =?us-ascii?Q?K22i6T7FftF8LjEnIYbdPuxgubQHteG4rzOSpX+vpVRGwl7+Ij1rFFC/QuE/?=
 =?us-ascii?Q?LqkXPDYDxdF5hnyMRGKMFo8y3aVlwMVpzim3gvnknZX1AVFKacW5gEZ51mV4?=
 =?us-ascii?Q?wSv34iN7r6VFIDTjccMancshH93gI31V/QLU3uHvjs+eVFZ+4ZadB7M13RWA?=
 =?us-ascii?Q?u35kDf3Y9lE4ItzfG1UYQ/AywJxn92rvng/BdwtufbO7m++Knq/d4F8qGGeV?=
 =?us-ascii?Q?AaLQiYMR72dRTo6YZytcGNBvw+vyJpmUPpCp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQMZhKREadD8cQVdpUF4WAsuQX9xV5a+cKxiOEKKr5qfqfhBKrLRCErzvPUG?=
 =?us-ascii?Q?3dypUOm5CkAkpgDo8XHJxuR0d3udjbEO9xhcq4Zd0JV9oJTNd9aKRVQ6+uAv?=
 =?us-ascii?Q?75wXIOFD1inQj92DLQXVb6AGQcqcwXLLHtv5aBWbR9GoPqQwtno+YNA1EBBQ?=
 =?us-ascii?Q?qaqZIvSU1GG+TmT+uzmKyrv+8amJy3fdAK+WlQZA99h9wTzBkuEJEDk9yUuO?=
 =?us-ascii?Q?tc8Rok7fPtH+oKkwzamLJpQ/4WQyUYhObo7qnJGJc7dXVeDaFVq9YQs5Vr3N?=
 =?us-ascii?Q?aBQYTwyzroKu5+RSs+P1U4Woh7tJ3j4FPXjeLV24Y9yTROcmERJfCc4AtOHB?=
 =?us-ascii?Q?TPfkVEgPf1LL02FycUkXbXD51UfP2Vxhza4lUhUGk224BoMC+YLDhurKkt9X?=
 =?us-ascii?Q?YOrzHcj9thUIzTY9j24s4lFLdv055y0OtqZVLEhOfBax+XXiZhJjxD+0YP7J?=
 =?us-ascii?Q?RI55Oh5abr8+uN5BVaar320BE7lbxpvy1bBmqPoZbdwRGUTNZbmFAcZg61s8?=
 =?us-ascii?Q?zZSKN/MrTtv7fek8luQCwdn1eg1sB4CGjgvdJ6X6zTlBiB/D5j00MENlgGjp?=
 =?us-ascii?Q?GBpgSeORFEQ3Yf9zQ8Z19KWeb5KhFx/AYXEGCgmap5RlRrM/AqLbjC9tpbgE?=
 =?us-ascii?Q?2IiSFgmTsVHSgicewkhaioNwe1qunZqaJVS2E7lRrYrFffzjkQytL1jzbqVU?=
 =?us-ascii?Q?FvkrxizhMtQ3nZwQzoHp17ydQsnLjcCXlU0gvQSnLRyBRs4RBUmwrccD6nP5?=
 =?us-ascii?Q?RdxmKYU4/RUCsEH4IV+VTkQvE5EeEOP3kO2IWc2nDNCVwgOwgDtk4HpCP8xe?=
 =?us-ascii?Q?9E5FUeB82hXbzqqI6BhuscenPubrdoRBTdDYlDLjxE8lnFv+mDAiWJ792SRo?=
 =?us-ascii?Q?IDrJpm2M6Cp0ms34svTyppU6TW8VnF6QI65wtRTtVChudpKrLQXXUetutJC2?=
 =?us-ascii?Q?uIawmZpBzozWorJDUCuI+WseQhULOEgEplhYy4DnHvIT+5nlcFRwLLD/ja2t?=
 =?us-ascii?Q?XyoJH7/miWvLU1NZgAPv497gREfIFMrUQxprE/uj0COdTU9S3ZzNCT08T1j3?=
 =?us-ascii?Q?cL68kPIs7D9zlni8rVgDHb6SBM93myQkiCdfutNpZL23aMDCOeLvBNXFNGcP?=
 =?us-ascii?Q?Pi48gEFpvsCruMg8w4+GXyZh4gZ84M7VrirnxtdNgHeSOObFxvsyxkDVxOgp?=
 =?us-ascii?Q?9dPXFx5GPuKh3GeN0wI6s6va6fLvhOB9931ajJYkg3z1v+nbAu+klf+rMsxz?=
 =?us-ascii?Q?5H+aOk5FCY8meCypQA2kTOAq8HoeIBw8aWb+NES+1QMPTocJmxmPjvwUw5+N?=
 =?us-ascii?Q?CgHdbxf2bv5Cg6WFaFyyaMbPpQ0qllV4nBCo/Ho5LL/LPZ9Y3mvPATcGH+VE?=
 =?us-ascii?Q?b1UQ2DGdMLjMu5optwkVLmmR268jE24IZcwrnCCT+DGgJ/iOUPiTRqIeGOZI?=
 =?us-ascii?Q?+So9Txzxv+odUUvPf06/d6XAO/qTzzDf13kjZOB9Xdb4dcKfk+4kuSZHUavI?=
 =?us-ascii?Q?DDMOO9e7+X+eioTYzM4EJvuFN3Xg8g0/F63ibe8WCnVdVXKZLxUwdi8JpOml?=
 =?us-ascii?Q?e0euwN/Flr4Yz/+AUzQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9316d0e-157f-482a-9ed2-08de1c8b08cd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:47:40.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngY/FHwn/mZnxHG+8kyYP/oTg2BioZH9SX/288BJfl9u+grZhL2F33ZwXWzPlLb462NcdkqoTZOa6MORyiMp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

On Wed, Nov 05, 2025 at 04:18:49PM +0100, Michael Tretter wrote:
> Request the upstream mbus_config in csi_start, which starts the stream,
> instead of caching it in link_validate.
>
> This allows to get rid of the mbus_cfg field in the struct csi_priv and
> avoids state in the driver.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/staging/media/imx/imx-media-csi.c | 40 ++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index fd7e37d803e7..55a7d8f38465 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -97,9 +97,6 @@ struct csi_priv {
>  	/* the mipi virtual channel number at link validate */
>  	int vc_num;
>
> -	/* media bus config of the upstream subdevice CSI is receiving from */
> -	struct v4l2_mbus_config mbus_cfg;
> -
>  	spinlock_t irqlock; /* protect eof_irq handler */
>  	struct timer_list eof_timeout_timer;
>  	int eof_irq;
> @@ -403,7 +400,8 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
>  }
>
>  /* init the SMFC IDMAC channel */
> -static int csi_idmac_setup_channel(struct csi_priv *priv)
> +static int csi_idmac_setup_channel(struct csi_priv *priv,
> +				   struct v4l2_mbus_config *mbus_cfg)
>  {
>  	struct imx_media_video_dev *vdev = priv->vdev;
>  	const struct imx_media_pixfmt *incc;
> @@ -432,7 +430,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
>  	image.phys0 = phys[0];
>  	image.phys1 = phys[1];
>
> -	passthrough = requires_passthrough(&priv->mbus_cfg, infmt, incc);
> +	passthrough = requires_passthrough(mbus_cfg, infmt, incc);
>  	passthrough_cycles = 1;
>
>  	/*
> @@ -572,11 +570,12 @@ static void csi_idmac_unsetup(struct csi_priv *priv,
>  	csi_idmac_unsetup_vb2_buf(priv, state);
>  }
>
> -static int csi_idmac_setup(struct csi_priv *priv)
> +static int csi_idmac_setup(struct csi_priv *priv,
> +			   struct v4l2_mbus_config *mbus_cfg)
>  {
>  	int ret;
>
> -	ret = csi_idmac_setup_channel(priv);
> +	ret = csi_idmac_setup_channel(priv, mbus_cfg);
>  	if (ret)
>  		return ret;
>
> @@ -595,7 +594,8 @@ static int csi_idmac_setup(struct csi_priv *priv)
>  	return 0;
>  }
>
> -static int csi_idmac_start(struct csi_priv *priv)
> +static int csi_idmac_start(struct csi_priv *priv,
> +			   struct v4l2_mbus_config *mbus_cfg)
>  {
>  	struct imx_media_video_dev *vdev = priv->vdev;
>  	int ret;
> @@ -619,7 +619,7 @@ static int csi_idmac_start(struct csi_priv *priv)
>  	priv->last_eof = false;
>  	priv->nfb4eof = false;
>
> -	ret = csi_idmac_setup(priv);
> +	ret = csi_idmac_setup(priv, mbus_cfg);
>  	if (ret) {
>  		v4l2_err(&priv->sd, "csi_idmac_setup failed: %d\n", ret);
>  		goto out_free_dma_buf;
> @@ -701,7 +701,8 @@ static void csi_idmac_stop(struct csi_priv *priv)
>  }
>
>  /* Update the CSI whole sensor and active windows */
> -static int csi_setup(struct csi_priv *priv)
> +static int csi_setup(struct csi_priv *priv,
> +		     struct v4l2_mbus_config *mbus_cfg)
>  {
>  	struct v4l2_mbus_framefmt *infmt, *outfmt;
>  	const struct imx_media_pixfmt *incc;
> @@ -719,7 +720,7 @@ static int csi_setup(struct csi_priv *priv)
>  	 * if cycles is set, we need to handle this over multiple cycles as
>  	 * generic/bayer data
>  	 */
> -	if (is_parallel_bus(&priv->mbus_cfg) && incc->cycles) {
> +	if (is_parallel_bus(mbus_cfg) && incc->cycles) {
>  		if_fmt.width *= incc->cycles;
>  		crop.width *= incc->cycles;
>  	}
> @@ -730,7 +731,7 @@ static int csi_setup(struct csi_priv *priv)
>  			     priv->crop.width == 2 * priv->compose.width,
>  			     priv->crop.height == 2 * priv->compose.height);
>
> -	ipu_csi_init_interface(priv->csi, &priv->mbus_cfg, &if_fmt, outfmt);
> +	ipu_csi_init_interface(priv->csi, mbus_cfg, &if_fmt, outfmt);
>
>  	ipu_csi_set_dest(priv->csi, priv->dest);
>
> @@ -745,9 +746,17 @@ static int csi_setup(struct csi_priv *priv)
>
>  static int csi_start(struct csi_priv *priv)
>  {
> +	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
>  	struct v4l2_fract *input_fi, *output_fi;
>  	int ret;
>
> +	ret = csi_get_upstream_mbus_config(priv, &mbus_cfg);
> +	if (ret) {
> +		v4l2_err(&priv->sd,
> +			 "failed to get upstream media bus configuration\n");
> +		return ret;
> +	}
> +
>  	input_fi = &priv->frame_interval[CSI_SINK_PAD];
>  	output_fi = &priv->frame_interval[priv->active_output_pad];
>
> @@ -758,7 +767,7 @@ static int csi_start(struct csi_priv *priv)
>  		return ret;
>
>  	/* Skip first few frames from a BT.656 source */
> -	if (priv->mbus_cfg.type == V4L2_MBUS_BT656) {
> +	if (mbus_cfg.type == V4L2_MBUS_BT656) {
>  		u32 delay_usec, bad_frames = 20;
>
>  		delay_usec = DIV_ROUND_UP_ULL((u64)USEC_PER_SEC *
> @@ -769,12 +778,12 @@ static int csi_start(struct csi_priv *priv)
>  	}
>
>  	if (priv->dest == IPU_CSI_DEST_IDMAC) {
> -		ret = csi_idmac_start(priv);
> +		ret = csi_idmac_start(priv, &mbus_cfg);
>  		if (ret)
>  			goto stop_upstream;
>  	}
>
> -	ret = csi_setup(priv);
> +	ret = csi_setup(priv, &mbus_cfg);
>  	if (ret)
>  		goto idmac_stop;
>
> @@ -1138,7 +1147,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
>
>  	mutex_lock(&priv->lock);
>
> -	priv->mbus_cfg = mbus_cfg;
>  	is_csi2 = !is_parallel_bus(&mbus_cfg);
>  	if (is_csi2) {
>  		/*
>
> --
> 2.47.3
>

