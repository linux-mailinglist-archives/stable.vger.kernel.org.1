Return-Path: <stable+bounces-89518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55959B9842
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A6F1F223D8
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655921CEEAC;
	Fri,  1 Nov 2024 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6G/aJN7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67045149E09
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488556; cv=fail; b=qJqbUY2PFFxqxh1gt00rqlVsVFE22Rrqi4oZprmAvIAZ6VwAyNA1rXG2KXier0BwHWSq7BxWanP6kgQuC8h1xopGWfqxKawjqVvELVwSWpiBN3YkwnET23/ltmXUZNVe2d/+c5Vn3RlRjUHy3Dx3IoaPsLQRm6AXwOTo6LExqFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488556; c=relaxed/simple;
	bh=wvUFdIq0eeHUXiJQfw6DryWkheeFA+d7s0pPX9n4NIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U98rA0/D3ZKpufW2Dn0dBYJuuZuRUL0P5LuyeDavmS2LrlEhrHnK6uZqgBf0bE8+4m93Gga/HR+Tu66mIexP4OznXQGYg2ve1A7nUQ/gwibdCDiNQ8NUgkJZEMVMM3hGaUMe1aqqBEYrNPLhuEXIaffOHwORe0Mx0GQD3+by1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6G/aJN7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730488553; x=1762024553;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wvUFdIq0eeHUXiJQfw6DryWkheeFA+d7s0pPX9n4NIU=;
  b=E6G/aJN7+ORbaODkU7JFWgBQRo15xfeaXe/PyqmsTKxqrEL2xZgnAnIe
   5B2vAJL7smd/fkIk+tAFEuCKGFDEUtBFDniTLK4ygW3i2AAPe0EsVh5xg
   9i2jzagFz0skRkES9a7A8eiKugBM3Caf6KvOgv0MBBoxJfPDCtlSlfSwU
   eYiYf7nRfXnDPjMGBnLw5eA5H+DrXc+y+dV102nDjNS5qiTsUzxLYIF/j
   Fcg9Eg+XlJqn/qKtbV5DPWMkQAcM+URKF+VuPmv3FNp/KKgmR0tbuSj8m
   tWbavVPZAWmTf66C3J2a8/Hx1imFXxcDPb22mpqFuzT8T8ToKIo9U0oid
   Q==;
X-CSE-ConnectionGUID: bmrxmWEJQT2gxWnIczvbNQ==
X-CSE-MsgGUID: 7wf8VJ4vQpK78/9W6K4gdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="41658797"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="41658797"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 12:15:53 -0700
X-CSE-ConnectionGUID: RmSXyFccS7uk2Tg5nQd+lw==
X-CSE-MsgGUID: OiIAu8+0SmGma+pILaBvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83498229"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 12:15:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 12:15:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 12:15:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 12:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL5W40nwxNHVqodwb2bb7vIhOVdxN6pWfFE4RStNIIPyvgGueA7dQheBDkb/pIGogKqjNYr+j7KWlcI28IlO27xvLyhPACLStLbmsPRreUKlqhaMtO16LD6PqtQuIVKVTozgEUCOk/zkUM7cQOpIt/I3eiyi8AINYausDSb65IcUzlLUnfpP/kygGSamPwVPphKSQV6UKK+xEuDtOogINC/shlGMQ6nvpWlwoOSYRywNluIFOaKGk0KFwa5r0RA3sJ1fnHtxD72h05qf2Hhwr/q64pmQamUIn8apltSNSpyl3achclW7VKZ9O7BvRGEbVonp5INli1rloGgHU8v0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRbgUw0nbCMrBmch/ztlu7+V2egxbszpWFe91rkB10Y=;
 b=wUnKR2C3pt+S2HLuzmpU3Gc9Ed0P+1DUAnvOs3D5f/A1sPASvXbnW2ah6ZNRP1yAZCdy08MHGn77TWFWyOov+fFbVCM68BNTcxwd+8imMthqNJrsFE1INQAuWGk2aSWqySe7WEwVrjYagG9SRFGvwfMh3R+j4aqygiMFqSHLWz+WQan4XBrDcIi58mzlhFPpwVd7jRuka6D2j0YNyUkZhIUH9N5AQemmtEWlFVBrQoW/rhNfVtsmSZ0Bt3LxjXSx+x/BW9P0U/+Fx6uX/rGQTvBExmNLP0wxYLN7hmHHsbVd8I8jS/Zl/nufT3/HFkzicXWmDtJtzjF3mqZkliWz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 19:15:49 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 19:15:49 +0000
Date: Fri, 1 Nov 2024 12:16:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: fc19d3f6-c865-41e2-b9c2-08dcfaa99856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bhIGsRT9EnYhs4pURanGQYYx39DeUiunpM3KUcQ9j1xws680IexDkpxtiinf?=
 =?us-ascii?Q?uPg7Y6TO/A52GT0/4hE0TVB8Oa1HOpLcGRKWk9oHvkOEQzozDh5rvUTVjiUC?=
 =?us-ascii?Q?cirnsAHHa900GO3o3QoRWkhuij4n4BxhoekkRf9LqfRSCW8tw/f1AHE/Boto?=
 =?us-ascii?Q?AiUDhlt9XAkLt4WiYckeDzaiud3LYjFvZtYCKUTDJSwvVVSVGngbOqT2aWW5?=
 =?us-ascii?Q?heuV8bmM/WRzMhxbCv29BJBD72TS5oBubMvgSLM9hJW3GlrQuWQnXFV0AbFD?=
 =?us-ascii?Q?H4d6x3Hl6YYuKmc10VS9eAZwO6FZYGI7NfLh1b+8bB5EokFS/kECz43ruOIF?=
 =?us-ascii?Q?RWHm2OQF137uHqHb7n3viHHIrY8Eu4jDmar9rv+jpmC9P2y1kIGYxm7US7iy?=
 =?us-ascii?Q?4KIg0Q2y09aU7xQ1uGnfldVwDgV6o7IkWVaN1kdfh609Gav12ATmv4Cb7Oei?=
 =?us-ascii?Q?daJlgNz3ULglJGiuv7/f0tf4cJXtJSVEOZPmc7yHrA/s4jm/di3rAKVwBADa?=
 =?us-ascii?Q?I7bJxjXk9Qn21hnUo9adk8cDlsi2Je0erFhh7MdxAn5ohewAi1Nd0nftV3pP?=
 =?us-ascii?Q?D/LFk+gZKdcmJDD6LB3PdLvc6Na59z0xe5ywLa5bJJkKJ624J5MvXJ4XCeoE?=
 =?us-ascii?Q?3Pa4mK8mjvxkVrK0S5+Ovz0WfjrzCEILuvkWFyeqo4oVO/U7fUshHt+aGyFv?=
 =?us-ascii?Q?SIeUH2j2X72DuS7JquE5pj62EJhw5w047IndQQF6UO6AZ6pHEaVO+M2bo8HS?=
 =?us-ascii?Q?5k4yWqGYcZ0xCZGPMWWv2r+rghjNhE5AW8YekMYiSp9Pap/e91BthMtb7zh6?=
 =?us-ascii?Q?m2rzS60+kNlEFn7ziN8+BpH5H6+1phDt2pvtIDs0+ik3XV5eMym/ML/9ytMn?=
 =?us-ascii?Q?bBNjI4E9UXWvC/fZ+A3/kb63KH8b+AN6ZKQQs0dQPc1ckBO6uc2I18ihnmEU?=
 =?us-ascii?Q?a3HhIpahyj+VoBiHMPwqHhncXbMmZKxVi+BXdr7K9lMgz89JZ3jWS+NanOT7?=
 =?us-ascii?Q?YbWhtC3N9fyoNvb+j1CbPMx3eYYcToMAB0GiEW2WcDxSjxBzfSgmTqlnMYOF?=
 =?us-ascii?Q?Ew61NUAr48PzCQqDrQVSEsJdJcuLuiSeN86/ylYYyx05IPivX+gCyqwAZYot?=
 =?us-ascii?Q?pZcDdIjJlw8HBjxTnUzhYuBeDIAWoFMQn47ztY5p4mFnVcf++oPzNzFY2icz?=
 =?us-ascii?Q?6C9s4JOXZy29KiTbpFlTnkYYF6T843ZkzBlStX2EapPSvX41rqssruE5Z+bX?=
 =?us-ascii?Q?+yXE9+OYnvcQLVWZPCkW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjJSZtU8HqBgQxouYKwTc9dq6HN25fxShjhKiMQSDy9lHizkbnnIsikDuDlp?=
 =?us-ascii?Q?eaOoQhLOVdOUcDODM3PuUABD9i4t/NocAjnSmVXvxGIYqUPo+9XDRMJZ77d6?=
 =?us-ascii?Q?kPblvXpXT8jJD0bb0mOnEipV2/6r2MB2+DPHETDpCrQdckocum/I7t6ScNzd?=
 =?us-ascii?Q?xoa2mu/ezNtsJpT7ZCeAeiZJhZaY6HdQ7/u0iFmPKTZQXiXGLhs/NBag13z6?=
 =?us-ascii?Q?uUaSx7eUNPUJEXy/v9/cbqRBZEuCi/ZlbN3kFddheJGD5dJIU2Swp37/rSus?=
 =?us-ascii?Q?whoZrQZA7b/u7VXfGgn/6GmrKpt9DhaSoCycPxtWzsy+GajdYwwM2WEaETqx?=
 =?us-ascii?Q?pDgOudKC7aX6bpi8Q4G1jBYWyUwzplk6E1pbKwsFX4L+MXWBoaefuBsjVXEN?=
 =?us-ascii?Q?jn4+mr68LPu7nUvIneNyuWlTSa8aj90qd2fh+kz2UTq+DGQJRigSsWoaQcD5?=
 =?us-ascii?Q?ytPA09fbbN1Owjx4e0wjFVWBy6YekzFHq4bw9kOZb3WxtAsAdSLw/fzzpFAQ?=
 =?us-ascii?Q?A9g4kXRoLeN7Kk7H072jPMawzkdQ4zrA3ou03wMwjhLn4HL1MMHwJ5GeuZ8T?=
 =?us-ascii?Q?5HgkkSfzQLykU5pobDGwsV/mrryXZztdNm0fds4uyZc5ujTTsM7U9kBxFUJb?=
 =?us-ascii?Q?uEorcoPLrPsHKwQXo/WJFrT9OqRehKmIOhINh8YJy0QsacMecAD2k73ml8G9?=
 =?us-ascii?Q?ExyYGZlu50U3Bsktb0J+xwdATVYyLYfxMX6BxvmZGKNdbrPeCf0/z+LOD1Dp?=
 =?us-ascii?Q?/3Yu+v4rU6qNKjgBlPDqd1o0ETyK7Ow35hyM4uMRIpzy/WBSVcZrrp1a/zlk?=
 =?us-ascii?Q?A3jLmx57cjXTt1H+bRI2aJi05fI8nqrbyQCg1zq189pwnh5hcb61vtSn81+8?=
 =?us-ascii?Q?r4hGBqvhkABH0sUZV08JNbR6YEBCl1UgGrtPjPRDCEmzFd6WAT/0QZf8r07s?=
 =?us-ascii?Q?G6HdWwAq7s8fW6t0FJof6vKSdwQN4XpTkZSLVrXyK9hFBXvGhJ2/IZvVKn1A?=
 =?us-ascii?Q?4nRR90h2AORHUpiTAAR+tmVo2BpXdbPvtC/K5ddk+Xpdifh8rrwOWL6zTKCI?=
 =?us-ascii?Q?uarjHm+0XFBHG69sRaOyGay/D0C4EOtm7Vauh8AruJ9JMXS3eYOnR0FvAu1y?=
 =?us-ascii?Q?x80bpQmvdaQUSrp3QkpQRDRzZEDF6tsEXL2zR4Q7xyvNh0JhUBb20hSJU4X6?=
 =?us-ascii?Q?GE28R4fD9QfVsksyjojC+GHoFFvY9cZuMGrq7fZ/nkGiAZOGfkppXn2jPtyJ?=
 =?us-ascii?Q?YPfB9kZlEhMaMNXHDA/zW99zgWVrVcGEWL+DesvtcXqoj1+q3IXGDoqr9Wbe?=
 =?us-ascii?Q?C7hNd1gVAA2CpngYCBuat0Dih+SD5ZNuyacLC/oiVvz26bIqNIHSCuWM0vbx?=
 =?us-ascii?Q?Qtx/e9G0buw4A75iauo+slMKo0TRVT8hxIUeglF+7X0PTuxFyi3idvv/JktG?=
 =?us-ascii?Q?vI66Jh5dUgg16J4aeeEnuD8CSdOz3ZebevHXlLTU2t9W+nN5q+fP37iKRb9O?=
 =?us-ascii?Q?fptLYOxSFEBeVaDeJE9FA6SMTDpru5ycxqYO8Y8H+5nhaRuMr0wYNFHS63G/?=
 =?us-ascii?Q?385QNCS5mvx+BZTK5zie62oGMzxlX+4fILOrrshN5Ni4TPKGT4+Tvfz0cZ2o?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc19d3f6-c865-41e2-b9c2-08dcfaa99856
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 19:15:49.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puazDSyPeV6howqcCyt/V/YyOa618tlCNGt9nBQQMXuku4M7XFmuSq6KG581rphfrB5BRfNYxi74+VQJWjq+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
> On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
> > The GGTT looks to be stored inside stolen memory on igpu which is not
> > treated as normal RAM.  The core kernel skips this memory range when
> > creating the hibernation image, therefore when coming back from
> 
> can you add the log for e820 mapping to confirm?
> 
> > hibernation the GGTT programming is lost. This seems to cause issues
> > with broken resume where GuC FW fails to load:
> > 
> > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> > [drm] *ERROR* GT0: firmware signature verification failed
> > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> 
> it seems the message above is cut short. Just above these lines don't
> you have a log with __xe_guc_upload? Which means: we actually upload the
> firmware again to stolen and it doesn't matter that we lost it when
> hibernating.
> 

The image is always uploaded. The upload logic uses a GGTT address to
find firmware image in SRAM...

See snippet from uc_fw_xfer:

821         /* Set the source address for the uCode */
822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);

If the GGTT mappings are in stolen and not restored we will not be
uploading the correct data for the image.

See the gitlab issue, this has been confirmed to fix a real problem from
a customer.

Matt

> It'd be good to know the size of the rsa key in the failing scenarios.
> 
> Also it seems this is also reproduced in DG2 and I wonder if it's the
> same issue or something different:
> 
> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
> 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
> 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
> 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> 	[drm] *ERROR* GT0: firmware signature verification failed
> 
> Cc Ulisses.
> 
> > 
> > Current GGTT users are kernel internal and tracked as pinned, so it
> > should be possible to hook into the existing save/restore logic that we
> > use for dgpu, where the actual evict is skipped but on restore we
> > importantly restore the GGTT programming.  This has been confirmed to
> > fix hibernation on at least ADL and MTL, though likely all igpu
> > platforms are affected.
> > 
> > This also means we have a hole in our testing, where the existing s4
> > tests only really test the driver hooks, and don't go as far as actually
> > rebooting and restoring from the hibernation image and in turn powering
> > down RAM (and therefore losing the contents of stolen).
> 
> yeah, the problem is that enabling it to go through the entire sequence
> we reproduce all kind of issues in other parts of the kernel and userspace
> env leading to flaky tests that are usually red in CI. The most annoying
> one is the network not coming back so we mark the test as failure
> (actually abort. since we stop running everything).
> 
> 
> > 
> > v2 (Brost)
> > - Remove extra newline and drop unnecessary parentheses.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
> > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
> > 2 files changed, 16 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 8286cbc23721..549866da5cd1 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
> > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
> > 		return -EINVAL;
> > 
> > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> > +	if (WARN_ON(xe_bo_is_vram(bo)))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
> > 		return -EINVAL;
> > 
> > 	if (!mem_type_is_vram(place->mem_type))
> > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
> > 
> > int xe_bo_pin(struct xe_bo *bo)
> > {
> > +	struct ttm_place *place = &bo->placements[0];
> > 	struct xe_device *xe = xe_bo_device(bo);
> > 	int err;
> > 
> > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
> > 	 */
> > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > -		struct ttm_place *place = &(bo->placements[0]);
> > -
> > 		if (mem_type_is_vram(place->mem_type)) {
> > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
> > 
> > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
> > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
> > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
> > 		}
> > +	}
> > 
> > -		if (mem_type_is_vram(place->mem_type) ||
> > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > -			spin_lock(&xe->pinned.lock);
> > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > -			spin_unlock(&xe->pinned.lock);
> > -		}
> > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> 
> should this test for devmem so we restore everything rather than just
> ggtt?
> 
> Lucas De Marchi
> 
> > +		spin_lock(&xe->pinned.lock);
> > +		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> > +		spin_unlock(&xe->pinned.lock);
> > 	}
> > 
> > 	ttm_bo_pin(&bo->ttm);
> > @@ -1867,24 +1868,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
> > 
> > void xe_bo_unpin(struct xe_bo *bo)
> > {
> > +	struct ttm_place *place = &bo->placements[0];
> > 	struct xe_device *xe = xe_bo_device(bo);
> > 
> > 	xe_assert(xe, !bo->ttm.base.import_attach);
> > 	xe_assert(xe, xe_bo_is_pinned(bo));
> > 
> > -	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> > -	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> > -		struct ttm_place *place = &(bo->placements[0]);
> > -
> > -		if (mem_type_is_vram(place->mem_type) ||
> > -		    bo->flags & XE_BO_FLAG_GGTT) {
> > -			spin_lock(&xe->pinned.lock);
> > -			xe_assert(xe, !list_empty(&bo->pinned_link));
> > -			list_del_init(&bo->pinned_link);
> > -			spin_unlock(&xe->pinned.lock);
> > -		}
> > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> > +		spin_lock(&xe->pinned.lock);
> > +		xe_assert(xe, !list_empty(&bo->pinned_link));
> > +		list_del_init(&bo->pinned_link);
> > +		spin_unlock(&xe->pinned.lock);
> > 	}
> > -
> > 	ttm_bo_unpin(&bo->ttm);
> > }
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> > index 32043e1e5a86..b01bc20eb90b 100644
> > --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> > +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> > @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
> > 	u8 id;
> > 	int ret;
> > 
> > -	if (!IS_DGFX(xe))
> > -		return 0;
> > -
> > 	/* User memory */
> > 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
> > 		struct ttm_resource_manager *man =
> > @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
> > 	struct xe_bo *bo;
> > 	int ret;
> > 
> > -	if (!IS_DGFX(xe))
> > -		return 0;
> > -
> > 	spin_lock(&xe->pinned.lock);
> > 	for (;;) {
> > 		bo = list_first_entry_or_null(&xe->pinned.evicted,
> > -- 
> > 2.47.0
> > 

