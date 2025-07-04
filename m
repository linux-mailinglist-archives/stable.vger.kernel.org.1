Return-Path: <stable+bounces-160199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534DAF945A
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EE0170D7D
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B832F85FC;
	Fri,  4 Jul 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbcggNc8"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB002D63E8;
	Fri,  4 Jul 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636298; cv=fail; b=o8XYQkRwoP3wBa2Bn9rGseelmkImqvHL2RGc5yzdEhqe/aHk8nCa1In0pjQ0dv29f4KEswHM9n7o3lb0trNfEngpzTvlBpKuEgYcbdAN7pEN0nA38UVR82pZr0lzV+NZYjsDIgfOlvRYYExQOeSdBpwMM7VWqRxCBe5FrakJPes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636298; c=relaxed/simple;
	bh=ac7Ew2mkqYcvAQfAENx9sBtw9bM/aHsgMCEq7tKpCas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fLFbnkYE90J9a8RoGDx+ifEMZZ101DVfxgUFa8tg/utpvHonSdea9WQYf45/4kodblb9lodJ++Fv7L0GjUB1ZP5QS+dXbIXFhw3uB0RqqIbF9uK09vSS3EOF4poOl2uR7/05qUiaB5rX8dWqV8pwVxrUi3wJ9S0vuqSTJMFrFlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbcggNc8; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMUPEsaGNUANKytUJhaOVfdk2kQ8yF2ywWWqpY9GFoFVE1TWByfEwdA0Suo4FcG4GOb3hu5uXS0HB1ypkClQ0JQg8mt03lFVsuiwgFyHhH3Anl9F13OLQYB8sUn9Rvf8/w5Gb8GABCVNmnSoI/q4q3apjRG0Vtbd2lKNnprWQv92SDD6y5ZiXH42IrxrON/Ni2XHXQ9WAs/l+PzLkTCKDSogLjKTZ1jYXkjtmZO1wb2VkPxy51EPPDKYI8RPDryKEl5se6ndrsMhg86BZfTNTVuFaQSX1l5ekWZTR5fvugNXQnjdbs9FZgt71yYmpsahmD3A5w56FY+YGwekLZYDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMFE8/aFqu8GaI4lDVcXDT68gc6aLnUVco605gajUlg=;
 b=OUnnvpaivJbRytHkNzhg6Hx8h1P/XdbmympARGOOSh1/yQMnhzp9leKkJeu3EE4I0ZVnCWW47PQyxDLKnNieZqfgsUkQvbzrFOmVdX8E1WlekZsm/SWiFyQeIV9/MGToyuB9xqrqQrQCTXvLalXSD0h3OyHxxPWdbSU/dQptz6ru6CduHpj9t/13gJMVDZLiT5OQVBY2+q1UoD8xUp9V9orVNHqLRdVo7lz6ze6Gzf0QpEsXl/o+u9Ts+xSZX7oPQ4cu6xQcKEdse/+DbPcNJXWB5KNUwZ0suLqM/jie9AiEMpCL1HFJtAAKPz+9dlihJsCuqr5Gp3IX3/00wxSRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMFE8/aFqu8GaI4lDVcXDT68gc6aLnUVco605gajUlg=;
 b=fbcggNc8cjeMX+fPlEso2YflM6xYKtSdikiXxz1MtBj2UaGNcni0ssCe3qT8x+aMb16FufBEUY8ch7BUZL0RNvBFHX4SURxYg/ZsAHxILAFUht5ymx/UumzOhVUftCq7deXhFri+xGN0TUvzeabxmY4WAk4pbs73TZHxza/N13imTn5s8+MavZlpRlcNFhdFphDi8+TJCt5vHoQsd7qKALdgd0Vv/cx4cLnb1gR5u0Za7mhJcixZFno7w85Y7StaSXn9i1UKcPuJJldyYL6bHj95EW0M0C+eb77oxC4NO/17lFE+Fi/NqC7BQ3Z06BXjA4qAsd7ASD8E7g2E1LRdgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 4 Jul
 2025 13:38:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 13:38:10 +0000
Date: Fri, 4 Jul 2025 10:38:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250704133807.GB1410929@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8064a397-f5ff-4cd7-09ee-08ddbb000402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZS/ao90tmFl0KH/oC3CgHAu0urBvfJ7KckjREF2jZetJ7opld27udJxIbEeL?=
 =?us-ascii?Q?4YLedYi5jPJDtb1MFla9IWTHlrhq2IXCooMYGpteE9Ew/PHaSVPzx2TjITp6?=
 =?us-ascii?Q?kwElgN47O9m9sgJ2GLxhvqgmuSTkZCXK0ljmGn6K9Q88Fo89Swfv+9h/qKAz?=
 =?us-ascii?Q?0JhQgUOxObQti4BKwNybrEPQE29kSVq9+vnHL1+aLS/TCfmV+cYP8oUlUu74?=
 =?us-ascii?Q?gNqKKiGKZG6V+GrbhXIUw1N1d6DkO/PRxHirF0vEG6hGZiHwQQspcqYLeH2s?=
 =?us-ascii?Q?cI/CJALzyIgzEgyhfp7TpMYgYUHdHW4WFOv52IMCvz1v5eu19GRwhpGwZ7IT?=
 =?us-ascii?Q?bXPy1jvqYKT36uw63w313Pwc+0UtVOoiamoMKWIfk064F5meK/sJ+w45qkfe?=
 =?us-ascii?Q?GBiKRPcElBTLK+GwRrV+LvAA3NdU7xjpV4pl5nx68MpKlmNCKgra2GCsR+b1?=
 =?us-ascii?Q?PECAAntKpOcbX5SrLOFBFz9LAkYNq+jDABhiPvaH9jAvVBI9OTK39fz+F+BF?=
 =?us-ascii?Q?Yxz3UyUbAi6hbxieN0c62iMiOsds0adOmfmYECw+Vm/koxZUwC53Ea8Hg+aw?=
 =?us-ascii?Q?7t9ymMMyDUsICkTVB4byboQ12gfXvXGnp0+/cpl5QEert/w2+FEG4cfSj0BP?=
 =?us-ascii?Q?xwQQnrN/FiQYkXajMLucizkoQ06WAemZXWFKlY6c3FlZ0TQWGy3VMJc3f+jD?=
 =?us-ascii?Q?b7/Mk1Z82UauEs5hXda4MhWPLZCUZjwbdG3Z8BW0G7WDm7PR5vF1y3tKqvni?=
 =?us-ascii?Q?EjRLF5d+Lj4bCGdsM++Eo7L0IHlZJHVcDsVBQFQkeLAt7adt1IKTfXjKhxCN?=
 =?us-ascii?Q?NUhFlAA8q+4ZjelfQ/lrOMlt6p5jia8xEpb8SBMzrEcFLzO+MqtpD8jFI2A6?=
 =?us-ascii?Q?GNGxZXgkwkXFIJcO0aEaRavQM4bqn91/qsfKVgmth9AaAga5WAE2fdPGU8ki?=
 =?us-ascii?Q?zPI++z3Qq9ZdM5eFAi/h6mUizF4B1Q44IERwg+F6I6FCW+neFovSaoKPa8j4?=
 =?us-ascii?Q?v690+mGbU4kc6sr99oYttDKvWBb6gvmGZr9jCms0movLTdejq0CvKFAYBnGp?=
 =?us-ascii?Q?4Ncgx7QED3Nl2JDgoWys8JeWmeoq3lBgvp6l13UWnWuK9dhYqOLQFpiTRRow?=
 =?us-ascii?Q?IA+v2Me+P9Qb02857q+m8YZhZPAY7Hx0GsVcjIAOXU85zAOzVrnqnvLhvjwn?=
 =?us-ascii?Q?sDSD8X9Q0SNWyJOSM2fBPTs2Iu3ycmfhcfNMSJJfZNCV/CbGmt+zcvyMmvG1?=
 =?us-ascii?Q?nQYluRUFE1zMJzKvxGmFeD4kF0X6XjyYDXltW4fdtuoiKktnVJaO/bb+4UWt?=
 =?us-ascii?Q?4SaV+uCtPEDdW4O2TvLu7w/P+FDqI3/4/Di9T/bs69TFtzVAE/Xeq6aq/euD?=
 =?us-ascii?Q?RXPI3n4ykWVQak33eLwN0Tdlz79UZkZXSALAVn3Kt1E5Dd4hHLd17V0yGXXB?=
 =?us-ascii?Q?Bsz/CQKgJPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fw4Ea1tpPP684jgut0o7VkkizvUTxHEtlS654auajd3frFh3TxPaN/S/+gI?=
 =?us-ascii?Q?Jgm7cXlOe1vUzTXmEiWj0Xcl+Wj4kcs1NX2sh2sBe/WRyUz3vzEqNz+rkMwI?=
 =?us-ascii?Q?14gh3lvsT5g4whJnokwureflCXmKpM4JZbroa4iXRzbD9aMR2neoUN+/fVQj?=
 =?us-ascii?Q?NUHJTD6u6otMTrl+O75Hfy1XG0wjQ7t2YT9mBypG/vNJJgFma8MeNLD1BXg/?=
 =?us-ascii?Q?PsCFc8pj2T7UvzYfVvvQN5sMjr+x8jyguPHAmPc11Vra8wZifMxdaSJOkL6O?=
 =?us-ascii?Q?sajRXs2yzf6tevltUc3IZIjioePyzNxd07dz+kN6zQBjVD5VyLgb3nP/U7eF?=
 =?us-ascii?Q?JCY500qNfjSgAEXjqAB0t+05iS0HkRSjhQC09hC4xVCdXeDRwRuXdAEo1Rtj?=
 =?us-ascii?Q?ZvcbxlJgg83b2Ex+SGCGWRCVp7wRvEz+I7AwLaiqoQgFitEoV2ZrJcnWmsMH?=
 =?us-ascii?Q?OVAHD8PPzT7iNfdinLLiQB0DOV8SRtm8156tn0fEYRB2bTk4tif3UPV8OkFQ?=
 =?us-ascii?Q?o1Txk823NWs8HS0s4ufTB1bA992WoZ4J7lzW22mWiw9aodqHTDSIi9KUKtRo?=
 =?us-ascii?Q?5wk1dol27UEqs6CbLxL1eIuZwvR/XUzXFHv5ScklzI0DYoCtl4pWMEx5pEn/?=
 =?us-ascii?Q?7OdfMrkduWYrOKOqR1FLT55Q/7yJBG0pAJnmr16sawU2vTIrpscLQdUOH0w8?=
 =?us-ascii?Q?df3kJlsaJESHWGLWZKaGp5BvQ2YvVlPV7nu86x15gIkpDiITkUCQg8Ischl3?=
 =?us-ascii?Q?hx8bv93iC64sSnSMc3Z2+UtZdLENUBl7yo6TGouyh4rPCw0n0hwrwFfqw+kR?=
 =?us-ascii?Q?ilvzukPrKLIzxTvxwpX0yxIBpYCHeQgp2jOtTFUjK4Py7x0iW9nQuFE+JZpA?=
 =?us-ascii?Q?WBT6awNoUqduxoFDi3WEzSIiRVKTkboCQkMoVlvxK4tgKxQ3uyNw0pVkOcjD?=
 =?us-ascii?Q?EW9nERA/IMgW87AxjfIGfZFumae5i3/IqioDKkb+qwLe10p4a44YZaa/nbE6?=
 =?us-ascii?Q?ncGxirif+vT2yPA56a4BZ3X7kWfSRpkwbdA1Oc4djXDFpyAlU2zux5TxBtcM?=
 =?us-ascii?Q?UY1VNCqAL8W/t/boYffJYyjX+HbqcbN9Rp3gHyTNF0MXrbWeEEVtRq345jdj?=
 =?us-ascii?Q?di58BNdNOkgfEljP6xTAlyffiYLSdA8lYZUaQ4UbP2DuQsUmrL2TqSMaUH64?=
 =?us-ascii?Q?V7uhRLcJ/B11SQ3nzYKrcsMlFcy9hjtw6f+bp4GfsEofL2CaST252L2HOLu4?=
 =?us-ascii?Q?QZ3IQUVDLwaQc30GT2/eFKf3dulUWoZx1Vmgw731Gwze6KClMTGoSQFkEf3h?=
 =?us-ascii?Q?O4wmlOoYqBo5xld13PjMFvaJi1wx5On+9+9OZyVq/WK/7AfJAkjzFlBl6ph1?=
 =?us-ascii?Q?NsLHEfenwkbnixteHtf+Y5s5fIYZb0/bub3L8wVtX/yC0ehKMdBkctG16X57?=
 =?us-ascii?Q?qgHzH+rqJVXZuSqlxq+rZA4uCvTGpZ/pfwn9hrFC32C7Tre74FJJ21ihCJYV?=
 =?us-ascii?Q?WzBfw1OVD9unerI7PpB8skELA6//VN4mzVfefXwrXZJcC1GF5kGzCY7PuDHT?=
 =?us-ascii?Q?1zaC4TQblsSUYcvCRsxGfa3HUgSpuPlgTyXnfiB8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064a397-f5ff-4cd7-09ee-08ddbb000402
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:38:10.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyNyYWzT8sMQs2RwZgCJSZwi2QXy6e8IA4myb2o6jvJIhP1llHizt4N/Vhc01Akf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

On Fri, Jul 04, 2025 at 09:30:56PM +0800, Lu Baolu wrote:
> The vmalloc() and vfree() functions manage virtually contiguous, but not
> necessarily physically contiguous, kernel memory regions. When vfree()
> unmaps such a region, it tears down the associated kernel page table
> entries and frees the physical pages.
> 
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. Architectures like x86 share
> static kernel address mappings across all user page tables, allowing the
> IOMMU to access the kernel portion of these tables.
> 
> Modern IOMMUs often cache page table entries to optimize walk performance,
> even for intermediate page table levels. If kernel page table mappings are
> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
> entries, Use-After-Free (UAF) vulnerability condition arises. If these
> freed page table pages are reallocated for a different purpose, potentially
> by an attacker, the IOMMU could misinterpret the new data as valid page
> table entries. This allows the IOMMU to walk into attacker-controlled
> memory, leading to arbitrary physical memory DMA access or privilege
> escalation.
> 
> To mitigate this, introduce a new iommu interface to flush IOMMU caches
> and fence pending page table walks when kernel page mappings are updated.
> This interface should be invoked from architecture-specific code that
> manages combined user and kernel page tables.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/mm/tlb.c         |  2 ++
>  drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/iommu.h     |  4 ++++
>  3 files changed, 37 insertions(+), 1 deletion(-)

Reported-by: Jann Horn <jannh@google.com>

> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  		kernel_tlb_flush_range(info);
>  
>  	put_flush_tlb_info();
> +	iommu_sva_invalidate_kva_range(start, end);
>  }

This is much less call sites than I guessed!

> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> +{
> +	struct iommu_mm_data *iommu_mm;
> +
> +	might_sleep();
> +
> +	if (!static_branch_unlikely(&iommu_sva_present))
> +		return;
> +
> +	guard(mutex)(&iommu_sva_lock);
> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);

I don't think it needs to be exported it only arch code is calling it?

Looks Ok to me:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

