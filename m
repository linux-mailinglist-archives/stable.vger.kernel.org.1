Return-Path: <stable+bounces-87960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7F9AD864
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA11C21DF3
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D651FF7B5;
	Wed, 23 Oct 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWFdoUEN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5F200111
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725866; cv=fail; b=f+brx5MSfZyb/LY0V1Qqk0MtMo28szipbRDGDNP+RgX0b2R5x2uXdBLPjlJ3sh67gcHl8s545SfpR4z0Zj8oJ7OufSRN5AGwxUoFSybEKb1bPd2ynawpkbsEb2KslqzO0C4L27x2Ch4cCXLxywo51gxMng/UcpwtM6bmumzSsMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725866; c=relaxed/simple;
	bh=8+4+w06oZsj/ZQUasf0uapixohGtFhV34/vkcJaQ8GI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rhYcTTg4st71o+srBWRfZBd5PRzSaxJUcGIGZDxVvkQamMwpGk5y7cktoHx7qCwyoicYPywGoGcf2FffEfngCd7CmnZ/yBu+Frv8nM/JvVj/5Y9bw1oA/97O/YOrWe0cMFkBfB4qPZz8DcErW4UsI/zUeH4z/NoNNWv2soiU/XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWFdoUEN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729725864; x=1761261864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8+4+w06oZsj/ZQUasf0uapixohGtFhV34/vkcJaQ8GI=;
  b=DWFdoUENeUvAHFR3TVtsVda4zkIQpDpWoj9SP1PAA1C86XRHCZujCCUx
   IPTcdDRqnPvyVTikYH9TxOTfwAAL/SDkbgVAK4EB2t8SZZ/gFXqzyqkwg
   Fn3zI56G62WqbrhrkMcWfjkUWtCUubJKJuP0OBu8joykehXbxYVBVMIO+
   rCKDMBnzsJh/NSOMJ+waLGrwbaLRZ2Ddrh0WffQayg8WJV0tTLrJo778E
   e1wPoOIrsVfr2nsi+3MDbP5cZ7KsZFnvwaWZIP6AFO22U5T0/ku3ybMmd
   u0B12sLKUUpXSA2V0HSKBZHcpfqQAe/+OEhi0tVnNmPU+mZn7HH7UC9C6
   w==;
X-CSE-ConnectionGUID: nu1+XeEBT/mgxvkCDFgWug==
X-CSE-MsgGUID: z8jpJ4TEQLW1E9PZ5XiVVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39883859"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39883859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:24:23 -0700
X-CSE-ConnectionGUID: 8sjAS8O9R1uEr44zxohc9A==
X-CSE-MsgGUID: 3En+W3TKS2ekoOIDXoTaLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="103739563"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 16:24:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 16:24:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 16:24:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 16:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keZX6jIsiRxRhfj19B+p2QDzDHSuCgHlgI5qf/odlw/kUbH7M3H/rYtPr6fvclU3fJx8iVYGSQZt/3bvyMBx7vmARf6UDa7b5tw0YlWwvb3rycz3U4XG8x7tUZ9Fmyg3EUJM8P9abLYL6WFMCx5RT8f3tD6/0TT1eGHpvb5aK99qExfU/9FLl/WNVYpYv2gArAx5c6hozB57K+zV2s8yk2TZxDNrNNfLbOBU4/yRIgXF2Rn9ik9BThj2Ko7yqBY6GCAOObZhxaw7XUSedK6SGtyQaEsINagf3Yig/iEWd+S6w6g64NiQDY42/0lbTejrH69rP5o42ad7xyUFmTUUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDUIA1UsZAOKMoMy/5DCY37deTHBOsqJ/1bZzraRr+g=;
 b=jIZB8ysn4KhTbbTEvbEUe82ft8DGtyIQShrGEpLbEzZDjhAiD7QZ6nUykgKuTlAPjy7XrLUW0B0M3to7/V7aL2ClWwdizGLnbJcOEAIOjW8pf0iG+JwSHCwZtvDb424Lb20PcMaK2R3DCYtTXv7vsePdVlgbmX4XiPccR7mX9Ms3OoQaij/f73WD0ySJXzvlE8f9z6Xih11iZpGy+HgSUqU/nUebjd86QjqqURVyO2GQA7yPKPGc3ahvqZeU7tajAz54dN3kAlENqlXZlFqlOMQ2f++TjKnv7M0K1tdabKiF0008yjaaDZZP0ARUC4fp6KS2FAtcjcF+U8OKwxCy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 23 Oct
 2024 23:24:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8069.031; Wed, 23 Oct 2024
 23:24:07 +0000
Date: Wed, 23 Oct 2024 18:24:01 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: Request to include xe and i915 patches for 6.11.y
Message-ID: <cvzltq3munvitr3laxcjehisesefairhqvbbbt67lq4ak6qjkw@igv4i5foft47>
References: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>
 <2024102344-savanna-skimming-4ee3@gregkh>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <2024102344-savanna-skimming-4ee3@gregkh>
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: e59efc93-d809-4b5a-f178-08dcf3b9ca4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gFc+KhRBqJTbtT0V0rg+s8qK1xm1sfS6P4PfiHy4EOet3X7V5c1vcfwi1JiR?=
 =?us-ascii?Q?BPXHePuiyrS2x9nuahfTZ6QW2sDXihrpUphYvsgXZCU9iCynjYIDChvbFfmR?=
 =?us-ascii?Q?/5VPF7z4zkHQBJi6+8925SWJ2o3AvxiZLuoX8BAHFS3ffHX8s01UKTi9/sdt?=
 =?us-ascii?Q?dhfuKunYckjqOzbF6ZAvwBzEIpLjedNlx6Pw2LeMZgK4bqLTuxJg/17M3szz?=
 =?us-ascii?Q?dsKzjJRplNg3Jpl07TYS+3rVlCx0xXpuEndoXWcwCOOH7oZq5onwx8g+jXZL?=
 =?us-ascii?Q?GukphOY34eL5FZnJ13T54QF7x0ZYiffUqFlpwysAw5nqQmzdFRTXRq+vyyxX?=
 =?us-ascii?Q?Fr9zzuOsoAe0tXzbfChwA8t6PMp/dZQwk1Lb0U4taLBBfMYmumqSoic2RrW/?=
 =?us-ascii?Q?Mm6k+WWzPgFpQPyKbMUItHorf3UoTy5bYT45XcmWpQGW81mmI7+y8/y/se1y?=
 =?us-ascii?Q?QBsE8RoPw76PCQz4FW3VglpvROZiOA27DpsRwDD6GWyLKN+j3ijwyO86KE4O?=
 =?us-ascii?Q?jFjbb3XKjR3w7BxYrg7rtrVrjkf322CORj1Z1yxHl8u2EXI7BK1gvbkAZWuy?=
 =?us-ascii?Q?bIwkhH5ixb4ZlO/urs5MvmiJq4CJgS4i1Cioqg8wic3asLt2W+2cRd6m6Ht0?=
 =?us-ascii?Q?5YnQKCVqo2QNDfEdWW8DRgUMNcuHzRreA/cEihZ9q0IYmDRqfkH/VCqO1HKY?=
 =?us-ascii?Q?DcX/NqADoDg22RV5iaeMvTh4FOCmQvNRsWxoBzFQ2RVj21JhCm2SpK65457i?=
 =?us-ascii?Q?eBqs4wS/dDwHOHJbDJ63azIrO1kM8xUnCLV8Y2fTceVY4vqHt0/XYtZPGbBl?=
 =?us-ascii?Q?ziXf588+q6Wk0qEcoiFQ16zihD3i+qcy17Qk53Nb1RQwN/yYHdRNalolWSwi?=
 =?us-ascii?Q?Ws50VarEu0xgTgZJzZ5bK7b2RS+ezcWBhWK/kwP8+vJMiI/hWg5eH7JbPT2g?=
 =?us-ascii?Q?kUXQB8naTffi2HdnEjOVrtPAgexqqCxBG1ZW+1+N5xJ1TVFbZ807RcagYyYk?=
 =?us-ascii?Q?lnwcA4vannYwHwAkdVs0qYVkhCKrQfMerf8EzSc5foCi/Zn7tVbyeJnrkUjP?=
 =?us-ascii?Q?J9jpo1WR/eSLqbA9LT6BJgiu4DTXng83fARGwonAfDrr7fNmu8DINR4gxEFI?=
 =?us-ascii?Q?CsoCZ3EzKNc85ZOOxgSvY063AMRm43XUzvYtm6KHb55bgGhSrKtgB90+KGt3?=
 =?us-ascii?Q?hdX2plYxdxDHQRFg2qlXc01h8ExI2GLx8pKa85hbAGF+daXoNDXCMd1l84QE?=
 =?us-ascii?Q?IPb9pxBpjkyNjPARalSArqQ/EZgacEI1UJe6TyM7xG/abnQcwbXRNPcn5RK5?=
 =?us-ascii?Q?fTXeRlIOzPNDsxNUP1/m0MhW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyNGqTnkzhnE/3yko/4H+vaIgMagj2UFdyB01wvrjuiRbNO3KuvZf4C7ucte?=
 =?us-ascii?Q?wY4zbNu3f/nOPpZ55n3Pdse3O9uNTE6xGpGPgyjp1PH0dVb9NwKNjwmK+x9N?=
 =?us-ascii?Q?mvrKafktgd3sYGh3B0M9tBit9H00HXmuSnf3xOV+C27SvO9LYW8pyx+K7Fmm?=
 =?us-ascii?Q?qILip++lC5nCxRegnhiDbSahdh/8fBlrnHUIrTkM7NIDaJvyPI9xY4gpx/zG?=
 =?us-ascii?Q?Wbg2CnKwNXgU6sizonfi4922svbhf+GlzLyQesSx0bUEZCjU/aLVPmOg5jYj?=
 =?us-ascii?Q?/PAuLeXmg7Yfg4RGTAqIixA5o148KL8V8gTVZvrQczDgsFYTm54Wu95YuXh7?=
 =?us-ascii?Q?T3KyxpQxbgDaE4hIg4zGYzKNVLFvIdfk7pOe2hgijGvXQu7IMb6LDqT8aOq+?=
 =?us-ascii?Q?vCPramt0d8zOcMpCtaOT1FHOP3D8Sd8aklQzw4A+hczOchLUt7N13kYZRa1k?=
 =?us-ascii?Q?ISlMClqdKK08uHofRTaQ9QFoz7+aZLZ2kYv1nR5Lds+IszM5IoQ09EKC8z0B?=
 =?us-ascii?Q?uNEFAm4YIsiKBELnqeBnLdsYOT1T6bqsERftMc6JVTl3v4woyxySpFTwEqI8?=
 =?us-ascii?Q?eKHL2GPZj5D2omI2PNZCGRadx+AZlysNwFphIUk0Mf9bQGGATmnInqtMMzsy?=
 =?us-ascii?Q?Dl6bIs+AfnEt59Fkt8mYnagA2VcKLqSB530zZccxMfSlCwzEdyMZdaiBynyV?=
 =?us-ascii?Q?OMa4Xl5H3xPCNAGPOJyJCl8ZfsspYUfeU6aGzVYtn9ISOG6bRnezTPClw3QY?=
 =?us-ascii?Q?xF8gdb7b822VkYeFcrb5F7h2f4Z3p4656Np3ni+byE7Aa7YV65OOI0+LWorC?=
 =?us-ascii?Q?Ve9uPPb49WICEHpTQ/gKqBGlgR6qGGrrxiqvK8zova/OHTt0NCiTDjm6uzGv?=
 =?us-ascii?Q?d2ARq2jIl8zzL+zDDTqKx4tinHl1XhApRjGVQlMRfZGpW1GNI643FdwQmVop?=
 =?us-ascii?Q?Sn9C+A5SByCVqOrTjgYx9OsF2CMuOH7FuwhP++W9KGSlJ4fYHHqm1ij7X2Wa?=
 =?us-ascii?Q?VtZq1DIihC6XzGPf/XQDHAP8+8CL0MjfM6ZpU9b1IrFl5721ahpdnPk00y12?=
 =?us-ascii?Q?PNn3RA1AHjP9Y1wZRLZ9d9pmTPwII7hbj0BtL59Koh04GfM3FFDawDx5PQok?=
 =?us-ascii?Q?s8HnTbPjIonLyK6V7gN8CY1Ae9690qodqHMLhZ95uJ6fMnz9Cp2Yz/oxmz/g?=
 =?us-ascii?Q?+VkXI1yiydSzvwun6fFIH5IKlOWFH3+yNtl+S2eGwOjCV5GqYss5PKmRHlyS?=
 =?us-ascii?Q?eaEwaVj8CuazCYFoimLqhmg7CdBjkVPgpGpBZqI/QrNjfNRviZq1998cYJoC?=
 =?us-ascii?Q?COhyn88G4q6d7gbu26PQQc/5tum5c6HSZtXRr/VTVrqggmxhkMaG+bzvgm2k?=
 =?us-ascii?Q?8XPCGrvTue51BtZoSEIo84Xqj5BECm1R3hgAs/lJlVhix7tzF1h5Rdb4rYtE?=
 =?us-ascii?Q?FPYQU7J7LdNKkLTy2iQ0CzS6g3Rt8dyzb+pabv1xNAsMe6TaO+j76kRMGGU1?=
 =?us-ascii?Q?bThkdx2Ry/BMyHWp7HKZskLhq60qCRjxgxykxUQfViNzXAdv/UFIVAymxjBk?=
 =?us-ascii?Q?7kX9UwLHvhtWsDIA85r+nDpJJEkPuNKL3thMUa+z9BtkxpXU0aLC2EWSi9lH?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59efc93-d809-4b5a-f178-08dcf3b9ca4e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 23:24:07.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMSgC9yGFLH4JUeXDtFMO4TDC6biQycqbakFshglxeAMwICtVE2iB44vtTe31bEF6QhJ6CuBL2lQ8l0aQ1nNXFR3oDsmJQAIEanibtrzW2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

On Wed, Oct 23, 2024 at 07:15:27AM +0200, Greg KH wrote:
>On Tue, Oct 22, 2024 at 04:39:29PM -0500, Lucas De Marchi wrote:
>> Hi,
>>
>> I have tested 6.11.4 with these additional fixes for the xe and i915
>> drivers:
>>
>> 	f0ffa657e9f3913c7921cbd4d876343401f15f52
>> 	4551d60299b5ddc2655b6b365a4b92634e14e04f
>> 	ecabb5e6ce54711c28706fc794d77adb3ecd0605
>> 	2009e808bc3e0df6d4d83e2271bc25ae63a4ac05
>> 	e4ac526c440af8aa94d2bdfe6066339dd93b4db2
>> 	ab0d6ef864c5fa820e894ee1a07f861e63851664
>> 	7929ffce0f8b9c76cb5c2a67d1966beaed20ab61
>> 	da9a73b7b25eab574cb9c984fcce0b5e240bdd2c
>> 	014125c64d09e58e90dde49fbb57d802a13e2559
>> 	4cce34b3835b6f7dc52ee2da95c96b6364bb72e5
>> 	a8efd8ce280996fe29f2564f705e96e18da3fa62
>> 	f15e5587448989a55cf8b4feaad0df72ca3aa6a0
>> 	a9556637a23311dea96f27fa3c3e5bfba0b38ae4
>> 	c7085d08c7e53d9aef0cdd4b20798356f6f5d469
>> 	eb53e5b933b9ff315087305b3dc931af3067d19c
>> 	3e307d6c28e7bc7d94b5699d0ed7fe07df6db094
>> 	d34f4f058edf1235c103ca9c921dc54820d14d40
>> 	31b42af516afa1e184d1a9f9dd4096c54044269a
>> 	7fbad577c82c5dd6db7217855c26f51554e53d85
>> 	b2013783c4458a1fe8b25c0b249d2e878bcf6999
>> 	c55f79f317ab428ae6d005965bc07e37496f209f
>> 	9fc97277eb2d17492de636b68cf7d2f5c4f15c1b
>>
>> I have them applied locally and could submit that if preferred, but
>> there were no conflicts (since it also brings some additional patches as
>> required for fixes to apply), so it should be trivial.
>>
>> All of these patches are already in upstream.  Some of them are brought
>> as dependency. The ones mentioning "performance changes" are knobs to
>> follow the hw spec and could be considered as fixes too.  These patches
>> are also enabled downstream in Ubuntu 24.10 in order to allow the new
>> Lunar Lake and Battlemage to work correctly. They have more patches not
>> included here, but I may follow up with more depending on the acceptance
>> of these patches.
>
>As this is a long series, can you just send this as a patch series so
>that we know the proper order of them, and it will get your
>signed-off-by on as proof you tested these?

yeah, better that way. While I was generating it in the correct format
I noticed I do have one conflict that had been auto-resolved by
git-rerere in patch "drm/i915: disable fbc due to Wa_16023588340".

I added a note in the commit message about the conflict and I'm going to
submit as a patch series.

thanks
Lucas De Marchi

>
>thanks,
>
>greg k-h

