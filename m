Return-Path: <stable+bounces-161608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4DCB00761
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8943B584B8D
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B25274FE3;
	Thu, 10 Jul 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvOeJC8s"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206E2741A0;
	Thu, 10 Jul 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161721; cv=fail; b=sSDYv3adXsCPE/WpkcaE8qAv1J1Vnm/yuSmhcAcXPus20RYW8x1ILdrm5QhhEmAU2vl9RnYEk4kSbS8GFlcPVdtKrMHBhfVi7V2Lb6fOGektFL2TJOp8ALrLqvAHczjwPc71L7lJkDtNoMDrO/fZz8qR6GZ+efkWdOgJhzSRUDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161721; c=relaxed/simple;
	bh=rE916B7/Qcz2idsy4/GNRmFREVEUkyWV0+2V0ZUC9NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwO/p6oWyls2MVf56ekXmAcTZxnvXVwBN5gEmWLJp6MEOYaaZ3bae4HoC2bc1PXS+f+SKUjl4VvGMhpmS9VYLzg7wejmzV4A6GrSm0oG095omuOkuy3dV5E4dwoeVN48WaKcKi76M1lMdl0reyM0veUEXKj8mmj+LMU3dpjagqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvOeJC8s; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idHWwfXd8unSN3ua8jOnYwlWZlH6uuk1317GvDm2SMqk0QNfUnaxSrbBJ3qnxaTKiKEe1WI+RqPBEwaoHNnH9gb9rmGXJDMyTa0eQvxMCmOLsfFR5ZIYtMKTWth/zzJmCLRA6jlBlTeyIkAl8gQYzYGsfS2hxVqiKJ/n2rN5uNd4W7JNTgK566NbgHHKhN+RNf+zA0nQ3w8G7RmD1HjPAMCrf43ZBFhwqR/gfbagklC0yJKVnpfj6ru1DcjshC3qPyAHg9n+tS0IB9hljh0Luf4TK8dlsLYQXOanw0mIFOlOW/DGclTaaHKg6uizp8ajgXTiIbV+tHQqjv0F2sur8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgdgHWsBJeV49uwOGRG8/nGYY3HbQfu2Y3m0DpHaIEw=;
 b=Z55Z2ySDKs32Ul72M9Q2yJI4e6Stmm0UyZc0LiJYFDMOOFNXxHYw3bsMEccCFbHqF75JAD4Lkx5BXisJOZpp5GUCcHZIDyj5ZgpTy/5XkZJ0SPeueUETWRPeXcP8WHGIuo9DGwMUJa9zJTgXOr7SiFO7qLWbCzDh8m6Lrym3r4yT0EtP4kdNPisfuGuruismrGqSIvRQ8inM82khg6EbM0JURWk8YkLy4eiGKiHkP/n36DFTNG3/w2cNvAPPskmey4jQFskYtDo/ZiHi9sI/NLRBLZybi+R5iqHVHhylo3JxwklfLTvBhTjhNl+kSEB7ubrV+Jqbj+ytk8515iQm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgdgHWsBJeV49uwOGRG8/nGYY3HbQfu2Y3m0DpHaIEw=;
 b=nvOeJC8sR/W1+qI05r2yeA8r5ZoNTyM6gHKfEd2AXGCxukWNFgXNPgrAswTpNa6hAG/w6GtYPOm1xhC6kbLMSM2IsVaz/TY0OKs260jivuAJfBxN/JKNIK4U8BhV8geTC6rQoKgADXq9VNKejNB8n+9HWDjS2/91ecMyJqE8IPAaaYBIelWYgxVs2b9mxwD72/Gbd4GLmZaFJsMSjSMOp2vxNwC2EtXeEE9ThqA1Q4hg2mKjBya4Kpe5HlMVRMv9VAbavA7e6nwJg9ST2O2N/nNsq9MjTTe6Jx0eqRszIWByBhcBvpyJnHEvGlghDBgiYCI3tANrSXV8W/gc3KwPaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 15:35:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:35:12 +0000
Date: Thu, 10 Jul 2025 12:35:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20250710153509.GP1599700@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <2080aaea-0d6e-418e-8391-ddac9b39c109@linux.intel.com>
 <20250710082808.52399e31@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082808.52399e31@DESKTOP-0403QTC.>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: bb614d02-9690-4576-acd1-08ddbfc75bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeN/pgoC+Hj9Vs0U+Xv3IG6J/VqM9wrS3gqb1KZPH2N2mDIiI9OWVDRsTiXr?=
 =?us-ascii?Q?IeRUpZ5nV7yLHP9+LQcMucHla8r3HXZ7In7XeHOCFPYGHbBqk1wSQx1F72hA?=
 =?us-ascii?Q?TEeadDfLe3pzyXLs35LddGbAxOtbVK08GvbYIb3TeqN69VWV/LlpPPWJk99h?=
 =?us-ascii?Q?NdPbSBsgbFf6MT0bW7VZ/K0ixB3mYYp/Oe/XJv3nhmKQ3EA/SOu+vjewc1Ns?=
 =?us-ascii?Q?M/7K5Z8TjvXD8IjmyaKU6KALlrdXAPHBFfRHgUTxXblt3jUN886JKcz4JwGD?=
 =?us-ascii?Q?AeTsUzQbiUOkXcxU2ZvBEMrLof6HTo+TuZckVox81LxNTbZhHevdHV2/pJqH?=
 =?us-ascii?Q?GR4Ao4IaH1MWLFmbGfcHG+HEsk15RAwVrn4Gr9bjS482HXFtD7BBKkcU1exk?=
 =?us-ascii?Q?A1woke4jsUJnaMqjsxuAOp9C82CUWlbZqwmz2RzHU9fYLINg3TMoRjvj5tu0?=
 =?us-ascii?Q?rQQlKczdZajDTC5vRasfJkdKpJ0TO3XLAWO/tmGzC4y0TGjmB/6l/LNEGEm0?=
 =?us-ascii?Q?siaawFKVl0PNqvxULSf4/pkOLEtYHUeBRAERZoaZE1cipImqbdm75gbt2vrO?=
 =?us-ascii?Q?awCch71kKnYerGmtXdNTHz5/UnhIhPEVj4sE0LGmObK8dfHPbn+VnFMWtNdB?=
 =?us-ascii?Q?HH87cm5Z5puoeoBW/ZC+nR+/XgFzao7Z51uEvGt1n+4eENepTV1uvoGa/R/Y?=
 =?us-ascii?Q?yIxy9R29J16c89k4fYxbCJabaj6NWRULWJtsDN8DP+vynyPBJabht4ZMJSVo?=
 =?us-ascii?Q?wXtE6MMEZuAzcK78LFvKBdPMwzsJcjqxM9Koch3cb+ey2HZMDDJMNrJ5p2F6?=
 =?us-ascii?Q?yjOQVTvaFYwPGHWyYCVtAsOwcLiCY1+vejf5WxBQjah9fKEhi6+PKO3Ry0Id?=
 =?us-ascii?Q?ZchAiI8iqDGNAMcNnhQ+lv7Cm8a28F9tkRUHhfLp7nHu+xeWF5qvGKJFg+EN?=
 =?us-ascii?Q?/SiIgzpV3J7S63RWnV9AriOj6lZeoPZEYFhGeo5yK3oAgEzkMqcILo1r5Qnj?=
 =?us-ascii?Q?4WLM4oMOjEzENgJR39uHLmRKlCGGdAZgSIT5hkt6P0891evrWtq/7mYr3fOJ?=
 =?us-ascii?Q?Bo1RquTDdwv8V02HuVsdCsYHfoLDfEnTn19HtvbOTToo1U90lXhj+yDlraBj?=
 =?us-ascii?Q?4H5Ixi95oDbhqQLmhLc87OG3z/ivJfpiQ6EQH3odRxK3Au3p+bLA9aIq8Jga?=
 =?us-ascii?Q?N3rFZL0sfytyh2mkTISI3GqDpaZ3uB0iDVmjcUKX2kCYb7VjCi0vDLkJTsEe?=
 =?us-ascii?Q?/V6LnMOMqWK882jVAkr07fx75+xfRXYZPX0pYBXo4yNWAOhJLN1bU0Mr1NWF?=
 =?us-ascii?Q?JJZMlhL+xFrR+ZausNtuJpynPn8EreFwJhx2Uu4r/dGt4Aq6z6mW0XUV3Eh8?=
 =?us-ascii?Q?tZL1uuBWBejoCmp/Vu5+Lc1Vzr7H6x2lYck6eQTPhYdoG5y+zhHFeyGV3Kpd?=
 =?us-ascii?Q?rgCU0acwwHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YACLZuXvNKx3cU0D0j5BO6VVoklqFYvxuyCHaXxCzajfja9D+ZmDMX0iCiuf?=
 =?us-ascii?Q?1hSQdSU48xKGgKa/NjRWYEWbYBreRPXLfw3lYKcZGp753NDia3uwTRWbk66z?=
 =?us-ascii?Q?9AtW7HwkC++9ojj1fR38qjDd7rO7GkpR7IuEbbm6D4F9gamR+Z1bC4dy9NDC?=
 =?us-ascii?Q?4pf/fJmBsTcKptjdfCDeTNlzKjmlV7d2/FcHKw8AOvlYMtZ7wBILJ4M/R7bR?=
 =?us-ascii?Q?ppyOyM3TGLqso1u9du8/JB9xCsRJKSHCFAj/Szi68W8IhPSZppWfwGQzU3Tx?=
 =?us-ascii?Q?lr1DGGA5PKZh+5BsDx9HdfL76VPm+TyWq2oMazjz/Mq8iuWEPoEB4fk7Fonl?=
 =?us-ascii?Q?ASrXtn4pzYRulfN/xX3a1Esm4igBUj+ovKUey4uJ/RoUiZV9+bwknTL4L4Io?=
 =?us-ascii?Q?RFPSnKolSFJPbV42F0nhWBdOerbZ5ZhDeO/blFzKl3RaF5ZbwxpcQGFdi7b+?=
 =?us-ascii?Q?bF05cqRdWNLq1J3q+nJ6do0TAERgX1QNgGwBJBdxwCc4y/p8y5iCoauTyZZc?=
 =?us-ascii?Q?86/haifcgPwBxjZb0KmE9DACeExryJwHYQPP7Ck8p6ToWPa6J70u0dSMMelN?=
 =?us-ascii?Q?SS4oTcEeRDO2IvshX62qQNiKtpfHK/UnfrzlLFoOLg3m079KLr5AM73yekBi?=
 =?us-ascii?Q?DSP3xIv7ElOIWS83eCfwlEgW3fGuePI8/kI2lgbo0UBdRPhrKUppRpKsksrT?=
 =?us-ascii?Q?taQu4jhHtK3L6BxJ+ENw4vMJha6n0BgqHttdCWWzgGNFXGq903yOt/ORdY1l?=
 =?us-ascii?Q?nheTE7gSWDpu6LWVs7CuCfHqBwC9tKdOg3jyeoBwhRaCZkqO6rkrjP7Q5i7R?=
 =?us-ascii?Q?TJMYopP8v5NSUQl/1S0h67gSObb719bCS3nz48GhCvI3jw1pM8CJSBcCXc6N?=
 =?us-ascii?Q?gAfe8XXhmVlIPUTpd08ZxH0vozb8ujNLr4yfXZFTZaDWbKlnSWwObTAt3Kux?=
 =?us-ascii?Q?q70dYym8ItTFgZtXc0H1/hb8yCJDUvhcvczdILxf1CvXAk++OqcwGdKKe2e9?=
 =?us-ascii?Q?xC8frkj5AIpzMenZJg9P+dyMGE70QtabnY73MRPZtUWoc5+Ct474+QuJdT8v?=
 =?us-ascii?Q?IbtAJrnfEl2yJtJ6NmmW1HvRAOnpI2wy3EB0MsCMbphj4PO9FfYWKLFqHlJW?=
 =?us-ascii?Q?D9AyIwMdPPV0gZ+bgNmNe58IArlEiLELlXV/3suU93ed9jebc+v8oV53oP+3?=
 =?us-ascii?Q?Tu0Jbqfb0nI5DIvNdMegs6gyOCNfYgHUGNh8Uvw8Kho+ebAeqRQv0gS1lj1m?=
 =?us-ascii?Q?Wa3PnEDOANoEwg4otj9sQOjxjxzYs+b8/L+MO6bZXMHHzWTtPhXkIjlIBbSQ?=
 =?us-ascii?Q?UwG8w1B4njiF/GD56XooKDRehwqpzT6vNSaMyoxPtsSphj6Ag0o2Yffc2D39?=
 =?us-ascii?Q?ffdANcXxERlkBD2fvQD0THzQN4PvlzxyTGSvGzKhwDAk+Z+iA5c3uHwTOjAc?=
 =?us-ascii?Q?gj1F11lZDbKhGFnGSwbGKtfoBkjI+HGH70vmC4kYsCMLjfi/MLKGfh5041Na?=
 =?us-ascii?Q?2oTXKj10S7OSjL1qdcnS+vNt4v90pi9VKlPGK/0CcnwrKo0LB8+MOew4Qpux?=
 =?us-ascii?Q?SWPTSAwjZuuY27vxG5Cd33sYBAN+44j6Rc1BjRyp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb614d02-9690-4576-acd1-08ddbfc75bf5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:35:12.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYPtQAE9Joz57qTmVRVCia41oe0nZfsM3rORnpGhRHRanqTa9JN9uA4G6Cf3J7w9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

On Thu, Jul 10, 2025 at 08:28:08AM -0700, Jacob Pan wrote:

> why would IOMMU cache all the entries if the walk is not successful?

Sadly, because nothing in the architecture said not to..

> Also, per x86 vm map how could this example (UUUUS) happen to SVA? i.e.
> sharing intermediate levels.
> 
>  ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap
>  0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space

Because Linux only uses the leaf U/S bit, the interior bits are set to
not-override the leaf.

Jason

