Return-Path: <stable+bounces-121449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01505A57357
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA74176F6E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A0241665;
	Fri,  7 Mar 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mR0DEB+U"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728D187346
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381703; cv=fail; b=XREccFlllEXjKS6QPwyKTsSxh2/SnP+vCyRljz53EGWer8Cnb0ZSdmTxG1X1OYEqVYmWUoJjwSWc2oCJ9TvB+/qinVeu7JY0SrmnuLBB51iV13MIvIY/cL6kEmydEfrMH2TxAYZHrRpbRcnN/d9HL8aMOx+phun+niWfdqeWP44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381703; c=relaxed/simple;
	bh=z1Ou2jeYLZe9KWIk3UhvPLFvotXE3zHshJVX5rVT75c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CZjMVv8ZTZgB7ib3ToH9DUMF9NNXP/FEMuTQTXAvjDwWq1SzCzsM+R3UKvl0/OOrSMJ3qeFHkOXohu0ZuIgRn4Ye9h/HXW/0W9oFLN3kym5Ytc06i8faS3hQC1WKKYveGPVLWCF2drfd/en2szZRgkgOcqRRmDc4ZBT6Rt7Hq+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mR0DEB+U; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZGoqrQas+jxdsfTPb3aNfivJQ1mKGjS7ky1VFeB2dxDvZpPwWIheo8Qgtrlj12Sd7lPWehzcxVoBJtxPa4ugbPaR5tBTLRZHTqPntEYiJevibQDSlfDv2SZr8yqR7DlAQ3rSHaeLkuR/MdEDL7rQpsQLVVORJn0IZYJ1bscnH/Q46BDR+YtOxnLNbW0MdoSnBIZ6nisY1RTbh7jUpD4Jt1S1cqIj39q8i+B2ZApqTu6nYIRhCUbX69aM6mPQv+jNhuqyXqqjL0y7Ua6Z639pQQdtkPoTxnTM9Om/qtAFB5HyrnRsp5MI63N0b+E3qjdXvOSl5OTBzl792GI/Z0gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWf1tOB7OW4L3PMyukMFnAto9dpMuflPytAoJbNxCR0=;
 b=VlDm78nuGAExX/8BbySSTiQixnEi6k5wAsr9d9LT2jtp2/UY1Bx6DHUNbckhRfdVizinb8OQATAd2xJ44p1N/PaLTXUDxQDjnHLMVkq/HzlETnleukH5kgCKVTp2QI5wa5bB5xYzewe1lB1octjsny/5u+GFzm0UkyThlbyN+Br59MRwnsPkZ89elRD9MXDSqx5GHlLF2c5I8blLziXfDCS/tzK3bQPcB/6Vl14q8asgzJWcRiuc3+zSzLbSSm3HjCdsKjEo4FjRElo+usGJC+jd0r9/XLPrDL5hvvZFwIdtVCf+QiFckX85MnbiHjDQOqXgG3L6D7/l+nHp3Yhv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWf1tOB7OW4L3PMyukMFnAto9dpMuflPytAoJbNxCR0=;
 b=mR0DEB+UgqZpd7FEfMb2P4B+YWQt3eHxz8m9Nm7/q7YsGoBE3L5kRaxcjceeX+raZ8GSP/hBTPPvZq/WHQw6aFiYxU/xpw/30CAPYfOgkDuonrTU0S9iriEMUHkW2WQ9FEYqnW/Js1a1KDakKfdjluIt5ps5Ue0o0YKYhV/gynCZsHNP+/tmD5IfZjUqBQH7FbghJVu9TsS+fvNr/DnEjZyXlg5Yvl6LUEAt5bc1x6QSRdI152TWbzdJhp/G5wNz/dMrPneyJWiH3dBbIM7e2xwbvUdFLBANk/LYAAKqPrgx+ErFdzE1rGj8TSYR5L2QIyzvpjuXXAy6JF8HnCqwgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Fri, 7 Mar
 2025 21:08:17 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:08:17 +0000
Date: Fri, 7 Mar 2025 17:08:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev, nicolinc@nvidia.com,
	joro@8bytes.org, baolu.lu@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: Fail replace if device has not been attached
Message-ID: <20250307210815.GW354511@nvidia.com>
References: <20250306034842.5950-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306034842.5950-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:208:2be::7) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b829ca-bfba-404e-e67c-08dd5dbc2e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wX/N4j4cdWJcF0UVUW4Fy4UfuFq5/sHhQE411uXbHNRLbhOpRcYUWPrIs3HZ?=
 =?us-ascii?Q?+hGld7SA/YpyqEI95fZhyYfZxdwG2lOX+XdEPNIwFAYxdKYC/MV9ujbXNTb9?=
 =?us-ascii?Q?AmHn+ddLUjdTdG+9ha98NH/hRi950YPpsUZ5gpDpmv7ua2ismOzJeKU2YGol?=
 =?us-ascii?Q?7guWWxpNfXTMsXNFqdU3ueiPnT+sF4c+mOM93Xg0iEKUDQ2eaQc6FAgNaBvc?=
 =?us-ascii?Q?VMIgkwjj4KPykjc9c1RLyB/OseCJ0XQJsSGlqyrYHBcrj036O+RTXK4ECZ29?=
 =?us-ascii?Q?yB2QC0G0txFgX9GmjmCFurfbfltFzbpz7AUG0JrjVrO8s4PKMR+HcyfSU+6s?=
 =?us-ascii?Q?5yuu4+BPW0ryvv1kaaKzMqellOE3KIhMailnv7gxZedbTt3mhnbucDJiLj51?=
 =?us-ascii?Q?wXc53M1HZqlrKQJlJyWQE1622fkc8Kw32vBUNpjaLeGdBb8ezB0LxCHqRflb?=
 =?us-ascii?Q?xHdubejQ5OVBHJiowUrZFSdMA7w3aAuKZOv8asMGvNIGpCkkJ+Ed+JNE8sYk?=
 =?us-ascii?Q?uGBGC7t41GOrwLvV2oWy2wsj9qvAkN7DuNJGNafYasK0NVTlW61O+VY5ikAy?=
 =?us-ascii?Q?oTgxZdb3nHLeg6RI7r4vtvNWdxtx6HbagC6bWaFoeBXyRG0qAOlHSuDv3PZf?=
 =?us-ascii?Q?rMcyC7aaLfKArBYw/uceYDcmlsCFzEnAvjboo8HtqGQn++kD3BdRfrYv99GI?=
 =?us-ascii?Q?B/gxUHiDFCbqLvbutdz/uuChAInfRVAUDZCZn7sLdzhSgrbQSyWy3jlnp0QJ?=
 =?us-ascii?Q?J9JyEAuDzhwpcu4/8L4H0O2DSh8GnZcXmCNxnf4rsC5gnyuopFIJk2COxr5T?=
 =?us-ascii?Q?SaiEiVBF2KzoLCPcBrdCiST1m5An+2vIl3r77GZoylx8GjXfgODPqu/TNBiV?=
 =?us-ascii?Q?zapv6Uf5YtjFtxZqzDXpjoVYNx7roXDabf4HWxRKTNPPebnWlyvHeSIE0q8s?=
 =?us-ascii?Q?wbZ9T7n0xn07m48db+1d3N/3yjiTkvNC9Q44M0qBa56PH3IC/CyzcIVxPIpW?=
 =?us-ascii?Q?69yUeRrSrzeV8ZmowFlr7xFd0hvCzy19LIz2jOLdYqdTPrDYPUIR2dr9+y4H?=
 =?us-ascii?Q?L/dZtLww1z8LOXxdx7gcyhx/digSGxongETlP6q7lxeDQBEtiZ7AojLSOUwY?=
 =?us-ascii?Q?bxBhOBJpXjFQBWUNjuRzPYnsRKX91Jj1Rlseastv+kAiSoXJxOp+oBV9nctK?=
 =?us-ascii?Q?m9IdluzjMGgAtnNqUjvXHRduRh4ur7DCveBVlqzO/9P6FilmsM+L8A8esQ8P?=
 =?us-ascii?Q?3H/71MJvS4EC4YbAxxM4VAT1NkAyokD/0EPY6N4QzzuJxettplkHnuIGjNCa?=
 =?us-ascii?Q?RY+jQ22ujDB09lo4v+y/bapPKVGD2ZQ3FHfHKYWE8SPvW18SY0giuKMiisaH?=
 =?us-ascii?Q?wlz13s/i6Yf+aEhSnt/I+XboxH1t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VWh6h+fasMAEPwb6+3f8ilaXmLy2DzHdA+PO5qY4S7nVkmpFq6bV2e/LA9lY?=
 =?us-ascii?Q?Q9Zzio609IzdUC5Q6R/duivGF1SpKGkY9g8Q96ppgpZvc8P/Wv+2rNAjkz7Y?=
 =?us-ascii?Q?Cnn7buO/cV8YWspJ6i78kv95hEL5fjNuubixaVNV0J8hEhIAAsV2kZgwTuyP?=
 =?us-ascii?Q?Hkzn2haiIvxihpnC46r3FQcz4X2BMfCVLWYKr6PbMTs6o80t9jL+PIbb+lb6?=
 =?us-ascii?Q?ZR12HpaCszF4s1ka1GA8GdLtq8v2bIziahOGSSMqTEWAzqMnTmAi1DpwD8Xi?=
 =?us-ascii?Q?wB877HaxCkbbNfmn+HNw1xRMJO8YMJcFm2DfLqHP3ZPy/meyfFB5mR7T128I?=
 =?us-ascii?Q?H9QlQ87gFAPgx+novoehc2TVU3U3RwElJ2TPMv/MunavRo1Qp0xgK1xU2/EW?=
 =?us-ascii?Q?c0jrtb4E1ki6AL6xWgDzldNmOQ4JK74WKESPIraVam/KDQ4OaA2a2rr7FmAs?=
 =?us-ascii?Q?Bl0Qs35jtXNBSmhUHIAZmbOkc7N6F1i6NK10z4PNgTW8Tjioij7math8KLpA?=
 =?us-ascii?Q?sjdiR1YIsRhUha6bbt5qElHW1vjVcBemjrORfm6Gs5NaXq+5fH+3cO/3bykf?=
 =?us-ascii?Q?ETImyAf/aE/eNSPT9SYPjDcijVT6lJGr6NvEq5dUGqwHotVJDVt9l2a5j94L?=
 =?us-ascii?Q?BEmY5inx/Om9y8J3STicYUv9ec1vf8Og43l0rKbmKIfdYQeP3xLD0SRn3rTX?=
 =?us-ascii?Q?r53dZgkgNMuMTvHzu7TYwy4HIhToKEuQ5hskxWuFnDQZgJNhRbPJJ9gQ5DHw?=
 =?us-ascii?Q?eYuO4D40C0x3SzaFXVYN/4Rd9hkAvyn9MTaojeVyi5nwYq+qsuIAl7+IphpO?=
 =?us-ascii?Q?nJPxaXZq96YcIMx0H69IzDJjHzQo8dWZPxuHzewkiOFabq0eeW5f2mOA6de6?=
 =?us-ascii?Q?I5QVJ8SEg8au2WjS6c+s07pH5yg9Dc9Mm77DyEFfpe4qY3xdKZEkhPUA2GAI?=
 =?us-ascii?Q?FKZSzgOSYjQ74WvlgOG+j3F7+r1FpCRQMSR1H9e6owda4SdPPkavBARUtuY+?=
 =?us-ascii?Q?OYl5RxGG6DoZjBOe6AyVRiFAGJLdXaB41Gd8BBTi7c85Fl5Sl4V+qm+7IROn?=
 =?us-ascii?Q?SoGbKB3XDt0aSVzX4Lm9nIe+jGea2MAgJ8gaZ4iWpnmvvCZcJ+wZHTfl82st?=
 =?us-ascii?Q?T2JRs/sv5ZNFyHZcLhL13owNIYk5OaQpA81BYUksKJySwQc2rXLq0Zp8lmmT?=
 =?us-ascii?Q?KocwfNJOcH1ZTajlbpVNTIehJyqRnVDJgE+hfDqQnT7cjlvm0DKSOwV+PiZI?=
 =?us-ascii?Q?W0UovR635FE30I2jhke0z86wOXJiA1zj67W5N+uVt+oh6UabLXMb5wRBcVfq?=
 =?us-ascii?Q?XmNYyI6yQaYrRkgxBC8EbNdoHDTZOa4FeydGP7Lsoc0/OQ9gAinh9ILQT8DW?=
 =?us-ascii?Q?dvwy9CYlknQ50LcgNLWi7iymucjeCaE4RqIklYyz0QWRwbBm3J9Etk5t3LbJ?=
 =?us-ascii?Q?l5f3fYEosV5sMrI3ERbQ8NtNiuGL1zjTlseWSlwdG5hIhKyEizZstB1GKdeG?=
 =?us-ascii?Q?xcKq75sNViTdaHq55wjlgpW1BTREEbtuuUGUEjvf3DT8mNpahvXc+Eg9/iDZ?=
 =?us-ascii?Q?AhffxGOzS7VPYWiHd8Es0hycsq9eztIe3Rr2MSMP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b829ca-bfba-404e-e67c-08dd5dbc2e76
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:08:17.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgw5MagcfZscDk6Du3ut6to73qBP6GZ4w23JvcP6IexrvR+k5i81EGC+RNFI1p6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

On Wed, Mar 05, 2025 at 07:48:42PM -0800, Yi Liu wrote:
> The current implementation of iommufd_device_do_replace() implicitly
> assumes that the input device has already been attached. However, there
> is no explicit check to verify this assumption. If another device within
> the same group has been attached, the replace operation might succeed,
> but the input device itself may not have been attached yet.
> 
> As a result, the input device might not be tracked in the
> igroup->device_list, and its reserved IOVA might not be added. Despite
> this, the caller might incorrectly assume that the device has been
> successfully replaced, which could lead to unexpected behavior or errors.
> 
> To address this issue, add a check to ensure that the input device has
> been attached before proceeding with the replace operation. This check
> will help maintain the integrity of the device tracking system and prevent
> potential issues arising from incorrect assumptions about the device's
> attachment status.
> 
> Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> Change log:
> v2:
>   - Add r-b tag (Kevin)
>   - Minor tweaks. I swarpped the order of is_attach check with the
>     if (igroup->hwpt == NULL) check, hence no need to add WARN_ON.
> 
> v1: https://lore.kernel.org/linux-iommu/20250304120754.12450-1-yi.l.liu@intel.com/
> ---
>  drivers/iommu/iommufd/device.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, I don't think I will do a -rc pull this cycle just for this
one patch, it does not seem critical but if you think otherwise let
me know

Jason

