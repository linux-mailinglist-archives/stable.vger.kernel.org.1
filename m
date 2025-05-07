Return-Path: <stable+bounces-142065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF968AAE25E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857B8524E44
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12B28BA86;
	Wed,  7 May 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgAV6QxF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BF28A40D
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626327; cv=fail; b=nJSKUvMGnGovfgejg+dWmjDdY1RnCYbn4P5n1FUvgLyDwJC5Bf0nYfRmdIXn988NgtSJ9OaPhg1/GkexU81CJeYqGqwiAnDqs5ksxLbQvZqlWv9E3VZMXbW0DSKLwQ5B6ZmGGa1dnfFx7EZpkW1puH2ry8rKS8LyL3rfzOzCy1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626327; c=relaxed/simple;
	bh=ZO4k/PF6uDQaXo3sCkVLeOKQOc7nblHIete12zdwZsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGLdbAx1urte2em4LtyJcgnF0B8DgaeZWjPgx6+32eT/cM2BqLFB25kx5ooEVo8idN2v5nWpdx2joN6qAYD1w4MFqPK6QWz/YOfQcJtSRcNR96+eHNheX/x1mFOZRYxwaaLMLAcX7fhiflL/Z+lQorg2Fy/7Sith5lRQUGET4nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgAV6QxF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746626322; x=1778162322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZO4k/PF6uDQaXo3sCkVLeOKQOc7nblHIete12zdwZsI=;
  b=NgAV6QxF04oohCdA9iTKKAXrVlH5kdkZfza/bZRGee17iu68LFZtAInK
   7rqBdsImZcOvwWWCwN7ig1cjWPoFPDb0zF8M7dWiQbxw1NaSDsBL0sqhW
   IrQV/cdUT3PzX487uKMWW4cb5UJCI/ae8zHkxGwGIBSTGEtji1nykEYtH
   idW/9bWN00EEU/1kyWRpvYNK4Jj/kWSbfOS59crI+W+Wa2RdJr9edE+OX
   iQuqrWduhAeA47NW0CFR++FljYl1aTMFj+4mOusry4kdafYQj841y2//B
   7+JutVOnSNq+vdAD/YxfNNk62g7tH3ud4Dk5+n3V8vthmocI0OrIeNKhc
   Q==;
X-CSE-ConnectionGUID: 6rPeG6VkQleY4/PBbtc9xw==
X-CSE-MsgGUID: k1zzS2CvSjqmuDiTwXEimQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47613094"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="47613094"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:58:41 -0700
X-CSE-ConnectionGUID: HH8TKVHmS1iq3v45KcksfQ==
X-CSE-MsgGUID: 3wNYAaAOTQeKp3Ix9T83bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135936948"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:58:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 06:58:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 06:58:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 06:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giSnFg1CBcBWPS7zxCMwK2/qRlSU8h01Q0td809VI0VFOlDWXvZUUEyGkXXwaXUVohJLGLhQk3EG9oOKV6msOiVCL14nD2570080PxBg4zRMvLijoBI5xvdoBadOPTahzpceAVBadnk1rSuJF7/AqtHVwAjPiPe72l64ZuA4gbMzPbN/M+LMn3dHa+1NEZK/2wvQ65xyzx4Gqd4hoRXcs/v5QQFThiqriMJ/jqzBUZRqHvg4iaa1p13fquqYyURPXKIti0dplj9ZI/cGzLUeRyIc8rjvgBsHwzu03b8Cvpyx9J8A8xBpdBTDIWYFgYpV3nZRu8vlVTvoCE5PudpR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVH5B93CalALKb/URsm+hXuWgAuyQ+nNwqD8fh13cl0=;
 b=eVY2XkE0/e6qynYlnGUmpig8Ix1zghGKVo3thu4yZ1juEMUI2BLj671Q3wuOBxMdI4ijngW7C/DtFyF1XDfdRgewqGbr/jUi9IT3nOxYcAXAXeGoKCT3P6MtXi/KNgUFzqOLhM9G+PNR47k1foJaNIvoXGSYxCOcobNe4pWAxFpsp5YDhAFF4EBpm1d8puiwlpcZfg15AKel4GN88Gie2/Ox3+MZh0nDm7du1FOHQB9rFolFzS+HyPSaJgMaVGZqcbOZaoo8gmeIKqvXwLil3uoFxkg6okb5c+zQKS4cSmZa23/mwTqg2mTPsCNGTWjF5R38vDlDhRsXX/pdIqpVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5264.namprd11.prod.outlook.com (2603:10b6:5:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 13:58:31 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.8678.027; Wed, 7 May 2025
 13:58:31 +0000
Date: Wed, 7 May 2025 08:58:27 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Niranjana Vishwanathapura
	<niranjana.vishwanathapura@intel.com>, Matt Roper
	<matthew.d.roper@intel.com>, Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH 6.12.y] drm/xe: Ensure fixed_slice_mode gets set after
 ccs_mode change
Message-ID: <pynmef4t3qofsx7tw6b4iymhaikb3kwt7svbha4wz3rd5ev4hj@5ta6hogd2i2a>
References: <2025042256-unshackle-unwashed-bd50@gregkh>
 <20250505161316.3451888-2-lucas.demarchi@intel.com>
 <2025050745-fifteen-shaky-2bca@gregkh>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <2025050745-fifteen-shaky-2bca@gregkh>
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2581a3-f17b-4bd0-d57d-08dd8d6f401f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvBjQ7hIXPXRgDs/x5+J1lPRTmt6Vm3aHfG7phqsWs2U0QNzdA6VVs173pMl?=
 =?us-ascii?Q?DK7T4Y3cIFGTQ1yGSLyg4auvZkzlqrcPy0mma8bF1vqbNDobK0erPJOzWalR?=
 =?us-ascii?Q?K6lJrD7ZVi/Pe+1R5unfEIYbjOC/S9UJhTAPF0IGpBMgZPOJp0pvLhESNceo?=
 =?us-ascii?Q?LKOxFxjBYbTmoMl91wdaN5PRfDSxhxUpITjZrSBZtykM5LVue/ACGiReR0Mg?=
 =?us-ascii?Q?pM5wKA2/c4YQW/I4XEFike7LiTvpjL7mJCU0A46nzLttYnvTv4kjtlY09TEy?=
 =?us-ascii?Q?lLkup7V4dJ5F1hfnWSZoRu3d3CaF9u5vSDKrKVPpFp61/iqyyZ09lbqRyyX5?=
 =?us-ascii?Q?EF7u4FBf1zkGuoFlojvXaM+pGypY4PYzUUhnKWqWEY7ciem3QSktTQrq4nJm?=
 =?us-ascii?Q?D8fgUNiC8slYfAoooeg0WddQJLLM+yQwApm5tY5tCjy9oDjg1LT71b1syNLZ?=
 =?us-ascii?Q?TPFpbHQ5mT7R5T/QEEuN9sWxPiUIhJhCOHBquGUKvkAhc4EG0grRuZEg+Uud?=
 =?us-ascii?Q?Dz+vOlK6Oki5htmbA9Dw4MDxvyATTzCFgaStTT6dUfm7H5Xt/s6Z/qbwdiPS?=
 =?us-ascii?Q?lCDaySJRqBFMOIuKGft2WAxCWdLyZI+XPeGg89t/IRdiGx5yH3vrTjABh7mY?=
 =?us-ascii?Q?G2YpmpIEhCKO+BlyF1mEccxX8ktC8wtXJwnh0uO8iowmpN+Ph/E6KRfqF1hc?=
 =?us-ascii?Q?GND0fvtkVLcxS16ET++f396sYIppKRj5ZtO56c+YZyV7M6YKT3YllcYN8Tyl?=
 =?us-ascii?Q?femPoSejP2M/hyG+F25dupjac3U1Mdot+I8Ee4hXf5SNcESscogdRBP6V3tU?=
 =?us-ascii?Q?JN4DIe1gOy0m6Z+bdkT2NWCR42SQPOVL99KaLpuvWb3HdSGftwVPOk+RSHo1?=
 =?us-ascii?Q?DJRwDyNxPHkY6pqZQY4q5mNJZV18wez58OKXybSyHGR6B1Kiz5Tm+ZZ2ZAUu?=
 =?us-ascii?Q?qj1qMcgucVBNIl0v3S40APuD44+lML75aj775lkqX3wjD7d+9KXKaAZWBjkg?=
 =?us-ascii?Q?saAlTUMMRa8fzMJSuTZ2aezROrPRCmMfVmSWqOMoSGWbIIgF9/UdkArAX53o?=
 =?us-ascii?Q?8QUufVkuddOixOyy7WnTOr+/K+7kcb7HIVSO8wVH8/B1uXLvv3o+6jGWeTR0?=
 =?us-ascii?Q?UqNvTrVKSleWCPKKCLHqNORGtKRF2OJUFRwjid3zUVoWZNcfv1qgdriSgbWI?=
 =?us-ascii?Q?MK32go+FbTEYgUtyxUAWwRqYUQhVY+oFFr4vR5vetRxDIO/meEJBQyW4XPQ7?=
 =?us-ascii?Q?DzinKwD5WhuufC+ofRIgnhP743nm3lRxu17Cep7ZxJvy4Uff+swGNIaWGcRv?=
 =?us-ascii?Q?VGA8NHx8DUb4sXfqrC7KSvHARaTWDOfmMDPlQzFmduzSuae5cYS1/CgDRYHY?=
 =?us-ascii?Q?9N0wjH0iC9wlkC7v0ZBhyPcKSxNIrZakpEt7OWblogo9nx8h9kksNE9tC8rw?=
 =?us-ascii?Q?0XNNsVAOW9Ch2mZZ9oGqbedlNcgP9v1D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TU6WnVjIApxEB9wzPg2zkMRKaBJF4RoqKSLTKO2jElRzn/1x536YLXcGii+C?=
 =?us-ascii?Q?RTavnftlP/PX4qYgMkl8W58fGKYeXiQMmA7HMuhr0CeRGV6JBiyJGW3+ZdG+?=
 =?us-ascii?Q?xCCrvQRQcC1/7zOVKaXlja6SXpt8nrEG3JOTyd8yQLNtQWyrBw72eJJhc6tq?=
 =?us-ascii?Q?wFfLouZwFyL7LPJlY/FIR9oyhVHBl3cJlvAfCoBUGbJOK/SaIgBkQa7M6jnp?=
 =?us-ascii?Q?pxAX08f/4bPOf4Is0AIW5Mq5giCgHxhYt9TozyiAkGt0GfhXj1qLe1HYbRFk?=
 =?us-ascii?Q?/72UyfzYlKCwkHi+9WBurPdIGpx4etAGVwIkhZh7O0cF7azeWuHf6CnlC0/r?=
 =?us-ascii?Q?IgjAd4Cs8aNHHGRBuD2o1V5QUswqMo93ThGk6HLv3jkDeEpi5u3P3+D5YIaQ?=
 =?us-ascii?Q?dqpMH04ZgCS4UmbNdfEQXYF1yBod+CxPP6IDXBZ+lxYbZLR6n029ix0dHTJo?=
 =?us-ascii?Q?8Ucz8rUgglGtAGKCbrJQP3UyabEjS8sLi6hJ2oyrNGcKU2t3/xrQqqoT96mY?=
 =?us-ascii?Q?gDcQ8oxHi7UKdxjFd0wH8zpqZxi84j7w/9FUr6vyTLbQ6zJG49S3TRPfaoDq?=
 =?us-ascii?Q?Yl2X5izGq11Uv1Q1Hmvu3TMifCreB4lbfnivVVQaMupqDKovAcUfqKRVZczi?=
 =?us-ascii?Q?2Pz92srpGIFx05IA5+zcGXKrkBPegNZzRxnDo0vPS6ELxHXk308q2SHFOOKh?=
 =?us-ascii?Q?6xZerLFnZPpSoFCck/+rWkkhzHV3M4t6Za+Clg/S+uRvKi+QQize9QHe6DlK?=
 =?us-ascii?Q?RdtG1XVd3GaINW/EXq9c8mOMZZ/epFhc7ZOPqasv3/M9/ORq90TfvROq+M+7?=
 =?us-ascii?Q?0vJhbR3UhXXFc1mNGdE3ON9uo0esfuT7klRPrSWFwT3LPYFnOE+gqQjKyKdD?=
 =?us-ascii?Q?xFRXXHVo94d5d6iFsLIBGJAaOww0JtDoBIbYtytTNbBUJzBUByhuqSuhvapu?=
 =?us-ascii?Q?ayCxvBYKDpYbKLu5Obb3/7+FYtmttPKT/UjNeidkVIDkL+Ki32tQuOeKE3CR?=
 =?us-ascii?Q?mk3swQs+DBJdon/TbDyjoLVAvWr2nqMxl0xT8fw7S0fj4zP826tl9VbF5cgP?=
 =?us-ascii?Q?OHN990+0w+YGstCDCdW1+o02Vevc1TvWdS3WcWKAXO4b6luPoNG3ziGMe/hq?=
 =?us-ascii?Q?Qgz2wwOpi8fkIrxppcmZymsLHBmDynKU9qi1SDEgqITT6hR0FBOBK+W8CMbF?=
 =?us-ascii?Q?Tkn642kC4KOlYSBrR9rhHkIypMjyuKzdY7JsKUHvCdh5C9CPDkqabCwLED8p?=
 =?us-ascii?Q?2Iv8b+NWAJMraT/hkJB5l/JI8ZmPPe0NPYXkID7Fxs8hOmS+IkCilHKybiJa?=
 =?us-ascii?Q?9uA2KPDUVcE5dLxvdgCgc/kgpiJ5E8VgvzzU57Z1Ey9v1qrHj/mi80VcA3Hq?=
 =?us-ascii?Q?5bmFUqgUqZskMqbkKk/p52IP8biolCsYPT0wnLc72CCDxx7dte+NQmvtsjIC?=
 =?us-ascii?Q?F9Cjuxh4gQ4ZLYO+h6GDliNRTg02mOZs92MTlBsh3Ob7RWKcppC2FvPNoaGo?=
 =?us-ascii?Q?5r1oI0qtTmlEmbLryIhdMsTdBGXmNbG+0kG5T9Gn5VTu41cKaxWWT/qXNJV3?=
 =?us-ascii?Q?1eAgI9hSunmVCB9ASHt/qs2K+PQb4VOvOit8xir1oNyauJanLadXqkBhZO65?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2581a3-f17b-4bd0-d57d-08dd8d6f401f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:58:31.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzHuqPqBZ6oNRHnDS2jNjzRR66DvrH2jjgvmKEvCfBrooxfbrEP8Pn31xDfpvt2kUewBEIPJ8ugu/qZLPNqrpFyjbSe40ueBngz56Kfh1eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5264
X-OriginatorOrg: intel.com

On Wed, May 07, 2025 at 11:25:20AM +0200, Greg KH wrote:
>On Mon, May 05, 2025 at 09:13:17AM -0700, Lucas De Marchi wrote:
>> From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>>
>> The RCU_MODE_FIXED_SLICE_CCS_MODE setting is not getting invoked
>> in the gt reset path after the ccs_mode setting by the user.
>> Add it to engine register update list (in hw_engine_setup_default_state())
>> which ensures it gets set in the gt reset and engine reset paths.
>>
>> v2: Add register update to engine list to ensure it gets updated
>> after engine reset also.
>>
>> Fixes: 0d97ecce16bd ("drm/xe: Enable Fixed CCS mode setting")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>> Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> Link: https://lore.kernel.org/r/20250327185604.18230-1-niranjana.vishwanathapura@intel.com
>> (cherry picked from commit 12468e519f98e4d93370712e3607fab61df9dae9)
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> (cherry picked from commit 262de94a3a7ef23c326534b3d9483602b7af841e)
>
>Wrong git id, please use the git id that the original commit is in
>Linus's tree, NOT the stable branch only.  Please fix and resend a v2.

It's the same old issue "it's a cherry-pick of a cherry-pick".
262de94a3a7ef23c326534b3d9483602b7af841e is exactly what reached Linus's
tree:

	$ git tag --contains 262de94a3a7ef23c326534b3d9483602b7af841e 'v6.*'
	v6.15-rc2
	v6.15-rc3
	v6.15-rc4
	v6.15-rc5

and what was in your instructions in
2025042256-unshackle-unwashed-bd50@gregkh :

	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
	git checkout FETCH_HEAD
	git cherry-pick -x 262de94a3a7ef23c326534b3d9483602b7af841e
	# <resolve conflicts, build, test, etc.>
	git commit -s
	git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042256-unshackle-unwashed-bd50@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Looking at linux-6.12.y for other cases:
a43e53e310a4bba252a3f8d1500f123a23e9a009 for example. I thought about
going ahead and doing the "commit XXXXX upstream.", but then it could
break on your side because the last "cherry picked from"  doesn't match.


Lucas De Marchi


>
>thanks,
>
>greg k-h

