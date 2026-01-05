Return-Path: <stable+bounces-204892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737E0CF54B6
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4324C304D86F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3E1227EA8;
	Mon,  5 Jan 2026 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qpf7RgC2"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8022097
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640042; cv=fail; b=gzmx2Me/wRUYyL0h8YyX7CPzv4g6pVnranjvZCdIdJpWXS1isZ1toGF/DLW2pt0uPPHfXo7Tx8fbnRPkqi560rDUtJDF+cTdPJr3Cc7WsMmiB5Oj+bAP4KY+dOgXPIKfEJggXUqXLi0VHBQcwUgbSRUs2WQwT/ymIrzNig6PM+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640042; c=relaxed/simple;
	bh=TYTgPf5HiOCK9h2ZjH3d1JnMIkYK1CJMs8+0sARb6+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SL1ZjEcgnUca7m/lHLKIjnb+G3lJ3nVHS1mvkzpaCSzC52fUO8W427DlbXLO9NK3/LRTRjZyua8LDVpyzob7rdSt3IW1EWkja29lE4J92jdGWZ0Dsyk7wAuyCYr+eZEblHbaYiZWVEiEawqgasjXr597xD1RZY8g7wXXlzooiZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qpf7RgC2; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTFo6+XLD7UOnJkbTKmuvoyrh7SPq9N8+Y+DxaOn9BD092qL77pgPD8nQoQTPqLq4+nqMoEnrUYbpq7PH04Pnira0xkSQV0KpIWBevMZ9EkLMQSI2mKEcbikESWVcPcI46bfmRHBiRAuYnd1jvZTfuG4ZTTJ1tOnDqey1V0lvoKJJhOnSSPSNudqQ04mBZlSxAhfWtPbq/f816ruLeFKlW1SYyt6IbPTqUkpY7peR+BSWoVl2lALyPBrJTAfOMg414ndTDY7PpAcvwUIhGoRS4xHhNwIF8PjyULTtewHughYNS2pi8eioDDvGpehiuQVNn7vRBE4puw3a+efLtbneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTaeHhBh03fSXy/g7zMuEqF+1iHJfVmt2S4Pt3EiCFw=;
 b=YvWe3Hki59BeawjqQoFQdTaNQO76VK+pG528rV4+n04Lst2uLWhVcX3UbZnHSrMSCvL6ewyiHzb1pyYAQG3rTTLRprdgt+JZDG3duaLeN4wPH1rYzlOBey2/V5xGE58y7QFReS3HNqPxKqEnN9s1I6j0MMVs/3OtIdibNgaWXEIhZ53+KK3GkEjuhUiD7xYoTR4g00mceLZDaLnp78WiZ3EuLg9T48W04ZUoMDIxiVtxGKRapXSwsSRy6RbcI6QdLzF5aA6W6YpRXZaCbj2kw364p02pSZaougdeitLCWFAPBT0ztFlUdYXMOJh4IVYNB1GYXVvvvd4i9+5c5Z1RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTaeHhBh03fSXy/g7zMuEqF+1iHJfVmt2S4Pt3EiCFw=;
 b=Qpf7RgC2pVBaZX5rFnwvMfDCWGe1Yl6LvqAnhGTEo0dmbnlOukMZVfXTxqlDGAjJNZQglMSWiRuId1jbER/hXu/sEXQez/+aRl3UExwHHesUmtA4OpZ2FdpNIqONMM4PmTpwnzMLX4EsfkCWtda9IsiO7eOVmm2yfpbzhE3A3kYlTQvtEWVRoQvo6URg1Jy4tKbljJfgsoadyOp48PY+3zyzFgQ/W+QvZTHAd1NjoNaBTGJ+iBuROfM7SfAb5W0UqSjcs2iF7dYtJpofCuuavTTeFMDhKM62DQIyhetheMeEPfG+4vCtWJVkyjMU4ArKX2IkwOof2TZc+m+AEAMWnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 19:07:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 19:07:17 +0000
Date: Mon, 5 Jan 2026 15:07:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	robin.clark@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	kch@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: fix size_t signedness bug in unmap
 path
Message-ID: <20260105190716.GB193546@nvidia.com>
References: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
X-ClientProxiedBy: MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f218925-e649-444b-e714-08de4c8da4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38tuoND4CGp99uH61kkzdZM0Ta3wY6o6l2wrtqr7f/om7MaSKskc/1rDOa9x?=
 =?us-ascii?Q?oDLsrJx43uNl1z2T4QUCwa954HxH3a9wO2JWYrHa9EUt5fG5Dw3d6D8KfqAo?=
 =?us-ascii?Q?3kK5vgvpLNIxFqC/yvPaGaY55BebFkxcnckbg2cJcvnpbgPlD54IkfPf6T6O?=
 =?us-ascii?Q?QfooKvuMHMgm3SLR8cnwu8gX6yXkkzSPn0emjpN/mNX7x0seYJTAGOAtEIIm?=
 =?us-ascii?Q?F66ii7IQSuDzQp9c4syQ26iNzDVSU2maOq56hvXAYbut8kz5VRsOlLt6x3Fp?=
 =?us-ascii?Q?1j5QH0kv2lMk37xMwwQ9bLszfbUL39TpVWi2fit9MpWui185RNGO+KY9ryH7?=
 =?us-ascii?Q?Rxp//fee7c3Bx9VcKuDr+qxlirnSXeYZsG+c90VaYSVHluGnpD/199xOSqEo?=
 =?us-ascii?Q?tWbTvp5+ukHW7hjhqzhJzmP2yI2WFQrJJcJTXOGLBVO783ROaP06PYcp2nNr?=
 =?us-ascii?Q?U2ri1oGlFlEdF2/aWFW98Ud+FHJOEzy4W+wtUT6KL0ydo4xRdlLKFwgJq5AW?=
 =?us-ascii?Q?1J0Yz0Qx7myrpKwXMtbtkszg+wz1X0s01id1DV3omnMwG+drNnF368T/MgzE?=
 =?us-ascii?Q?FGPXY2Snkps5odP+NrWNYXlw3vcwKORGKHPzv4MJt2PA6Ux3xUF3JiwKzLZ1?=
 =?us-ascii?Q?E1iYuRZnGJpO+RlwOpELPtreQo5ClZtfM4XCeL7xNkjuQOR74jcckwLO0wuT?=
 =?us-ascii?Q?TyTW3eszSdbl6wznKejOzuIGqS0WZ+TreB4dIZ8MU9wTZ9iJR+ir+h5x7foA?=
 =?us-ascii?Q?X3OglZGTJGLSge8ZtY4mp00InrNIaCAMZ0kLtJcyTDqgRKVCbaxJmpTpsgSi?=
 =?us-ascii?Q?DPwv99WtGXLR2JHo9+zUIK0faAOZECPkOlaUr7LQUyIGMgd8ui5W6LVX9jB3?=
 =?us-ascii?Q?qk7tJ101HKnd2ju6k+Bi4azMO1x3mVrhCwAGUplVeEmaTZ1kkVUajdxkoed6?=
 =?us-ascii?Q?K4ojwXBnlQ44bxrzwooFVd2mzMaFUCA17OISHHeI+Rs1zMRRfCMC6J8tIW8j?=
 =?us-ascii?Q?qnoRXlpaNkevGzLv6Sfo8rX1NoPuMus1Fhd0k3zTmQaHJKkQ62E689U+e11Q?=
 =?us-ascii?Q?5kqAvP1KOkvkjqF4h9Ox+MwoZEJgXzvm/gdeMcQ/JGHoBUJavdFwQAaDZ86l?=
 =?us-ascii?Q?mTG7h1W6iQZkvDMLHnRlqD+e26+/aXe72gF6mrzeU1GVq/bkrn1yYu0Vb8Yi?=
 =?us-ascii?Q?Un7hCdpWZkHfytKisEiXhWGdHmII50S/1Xrhfi/ZvjFdEfsoZWnsCrLnTT0E?=
 =?us-ascii?Q?PlAdbI2WEtbD+D+ObJa9K+h+rIcHzPtsYl7IwZypsusv71V2fa7Pwf6IBwnA?=
 =?us-ascii?Q?qYk3OXfZj0f7tFmaprTtmVX7JyvSc6lng6IKixB7VehyhMFh4RjvxltMSTc1?=
 =?us-ascii?Q?GcwjtmIEvbioJCpIRhjq2HjYiTyBjFTAC4oaNAzeB+ABudc441s9qXaDM1io?=
 =?us-ascii?Q?8DZQfsdSRgG4IbCnOkCXGG/lIPNQRCLm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+68Wxm71D0cBzkW/c4JK5jQwD+S3zCd9BfN2NWlesK+Y6vhs+UKn6Ml86bAV?=
 =?us-ascii?Q?Tl8OMYJnPhg1uzEJnJkI6iuLZB6W0itFMgg0WeZCDlIKUVTGDaZUNNVvgYZH?=
 =?us-ascii?Q?/cNVmM7t0Hb45kQCFYzMwtoDg+qj/Z8Xn2wruAKW/REU9jb0+/uNtAJX+DYM?=
 =?us-ascii?Q?qNWPKloMZWKaEuDTzi5Ya7+ibukGW0Y3UcqdVMl9XHoi2sn/9e+/IaR2m3P9?=
 =?us-ascii?Q?ZwZCnCKAkN4pGySpCGh+PMfQqQvTqsllk8byaGr5TOMAep8FEMZ0SQLGgCtM?=
 =?us-ascii?Q?ZlR9JCE0U/YAPLKEpvYi7l5nHdWOnXwe/vLcPH9owaiYgDc4NoIpV+u3VJzK?=
 =?us-ascii?Q?l6vWYh3m6oonEmL8HEpwE5kkJgZCbW7jw1tw1VDbAlc6ceu9nlTpYG8VcXq8?=
 =?us-ascii?Q?X09BVXFNWumbmCn9CU8YBr5OcAlwq2qDsrxXzyjsmldess7ypsxSeNlabOd7?=
 =?us-ascii?Q?k9Mx8vWWlUZJQVPXMzazpAWfeggUG2IHGOS5uprOsC38O/WHUaGbBrTYvyUV?=
 =?us-ascii?Q?LVaRh0zdEuW71vqswO+0hkev0qjJ3B/InMI94Pr/GhJPt/yYUD5Di5YFG2yc?=
 =?us-ascii?Q?VOCfeDM+WIBcfOyjoSo0Hu0XlCmDsVhQyMUOwyDUQkEYiNzypDyETP/LnjU3?=
 =?us-ascii?Q?f2aRa4uYKXsawC8ZYDP93xJGknrAcYJijn6uHtzml+DUMGgXpTM6rmWyW9nF?=
 =?us-ascii?Q?PHacKuGjZJtQDsxlFhEr8EM08VxjArQjTfdjko4X+eCy3y71nG7YlKWBOFvv?=
 =?us-ascii?Q?iTzIBWvpwf+wLj4UCawkYQd+dK9eyqUuAsmPASIMlWx7y3PS22ImZvPZyDFQ?=
 =?us-ascii?Q?SucIn+2RIxMxGJVFDVHuQX/+GK+eiXjHlLMV5RARJ3ac2u+7WajymsgcXsO6?=
 =?us-ascii?Q?smbfUvQ8EGDtXFwVJbMGWOUs5WYEsP+1Yv9q84f8aqc/GyU3ir4m/yCjvlwU?=
 =?us-ascii?Q?0Bm2A5KtmwYcT2SzZb8Mj5eHUwhqdb3ukXQQhmPgKUPLQrhc9u8RxPrv2WB3?=
 =?us-ascii?Q?w8MLzhNF224h8lz2QxRflQGzDA2IBO6Eo0I+VrnktJPbYPK9EE5QmsRllzSi?=
 =?us-ascii?Q?BBTmHRA4mUrV92OkD9xBceOEQIqhVAJir+JGd3s5xMSSgYqRNbvzwDhbktMa?=
 =?us-ascii?Q?CImp/YicLWEMoomURcu9KZzoCWaL52TmUxsgZwPXQoNsCmNwxUwrm8D4+oZW?=
 =?us-ascii?Q?NkRKMPKBFTrcweE2pEsCYExXs18/u4lGog+FvAc5TgAvAuFg+nY/NNQ6Pynq?=
 =?us-ascii?Q?8ybNNmUjDs1ypMvzP9S/4Fn5cZ56+zu9dPjnQjyW02ZrCB4V/a8gTf6AlDBK?=
 =?us-ascii?Q?g3U9OvVRS9Dj+I+c7A8534iBx8s25zyB9k9ucQdg7BOU00vgPgu7DWB/ycZ5?=
 =?us-ascii?Q?a3zuguChBOjMumhJXapbEmT7VWmDbr8nhkKFbFcQ9MeGL4TS1Q124nhL2893?=
 =?us-ascii?Q?ZwXjOWVqQgOy602cjS8Tw7ICKOl9+Fqt82HiF3h9p0kpWvgY4wcb1dkdCpow?=
 =?us-ascii?Q?B30p4bAtZe0s9cNz6Uyc/wHg9qnnj6u6YzuYGmv9jWNhjW1p9PkNoREW3v+U?=
 =?us-ascii?Q?IgIi4ulYHavRlGlh5ivkjcyo9Ssfci5gM/vaiOslz6zDlOHxZLU/bILUysmT?=
 =?us-ascii?Q?4JAR12TMdKBIcXNTIQUM94PEkRPtfr+oZ/PnXuLRih4XTiGKnhk8yDRjGCl0?=
 =?us-ascii?Q?tgaPF5/1Z1w0Rt/mHARrl54ltFTsPX0/t8YxKuUOfUWfPJYja3ySsMjrKQLS?=
 =?us-ascii?Q?o48bmIpJTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f218925-e649-444b-e714-08de4c8da4b3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 19:07:17.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH1qo+6OpoO1IpDwT2VlDMqSVWt35IzVNzHt3s9vX8HqBdgtGTUs6pqMHL0wnwg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

On Fri, Dec 19, 2025 at 03:28:58PM -0800, Chaitanya Kulkarni wrote:
> __arm_lpae_unmap() returns size_t but was returning -ENOENT (negative
> error code) when encountering an unmapped PTE. Since size_t is unsigned,
> -ENOENT (typically -2) becomes a huge positive value (0xFFFFFFFFFFFFFFFE
> on 64-bit systems).
> 
> This corrupted value propagates through the call chain:
>   __arm_lpae_unmap() returns -ENOENT as size_t
>   -> arm_lpae_unmap_pages() returns it
>   -> __iommu_unmap() adds it to iova address
>   -> iommu_pgsize() triggers BUG_ON due to corrupted iova
> 
> This can cause IOVA address overflow in __iommu_unmap() loop and
> trigger BUG_ON in iommu_pgsize() from invalid address alignment.
> 
> Fix by returning 0 instead of -ENOENT. The WARN_ON already signals
> the error condition, and returning 0 (meaning "nothing unmapped")
> is the correct semantic for size_t return type. This matches the
> behavior of other io-pgtable implementations (io-pgtable-arm-v7s,
> io-pgtable-dart) which return 0 on error conditions.
> 
> Fixes: 3318f7b5cefb ("iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

At least the iommu_pgsize() path runs with !IO_PGTABLE_QUIRK_NO_WARN
and we don't hit that WARN_ON() before the return, but the GPU folks
using this NO_WARN path might have an issue so it should be fixed..

Jason

