Return-Path: <stable+bounces-165147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920AB154A9
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835B83BCC24
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E223BCED;
	Tue, 29 Jul 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us/kykH4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5F1465A5
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824589; cv=fail; b=tNkG1i1hJyOOckIs5QLuGrwi9ETcWDUi5C7mllPeVu9VHllgxdbMvdFZJGe1FqYe6K2s76Hk4Z6Mrlss2citNP1KNe6Ed5kAc7v5Cp5inEXJ819K2TSMAsw7L/5E8y6P+mjyE5QCihjBa/0vKMWy8AD+s0Vn+QPx80Ofljw/JIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824589; c=relaxed/simple;
	bh=vXd6ON+dN4eoZkVbHeOp+cP08a81V3jgAII8CNQVyzc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcTwRvtFqsxQSg+vcfBbyT8Sr3L7QVn+yOzws5EN63+viHWPPT7LJDIs36MrSJ1zR33ZnXkD+JQeNuD07fU9ZT+Q8vqdwIaJpXPTRaSvbvR6sTGwkdTyMA20o3U+Wn5qTmthnQxmpz/+zI5K42mokbCqIWUxTCGTCKmzW6QwpPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Us/kykH4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753824588; x=1785360588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vXd6ON+dN4eoZkVbHeOp+cP08a81V3jgAII8CNQVyzc=;
  b=Us/kykH49rtDHNNau2+xPmWV83/E435N5DGC/lAr3CMy01Se+hU0OLZ5
   dXhVNOeEPX3H7N3zQ2mzVNRZHmRFt2qhehhcgwgXsj4LUyLMDUCaOLBDz
   7ZLde3xuf2D5aJovC3iXah5CCst3pupDT/y+gmd+B1NR9vSnGcsEaR2gy
   0ohWInRdONjMo5idrwtLMA+ewJ2YAi6evDOaBeAWYZGp4EsFlgUB0z6B1
   jeu5YEbXjI7y0vICE5oM96PeLFUAcERypV/I12FAuRmhjdeTRJHy4o6/B
   v5/WUZRTpYIykOMfeWSTPZhGTyi52F5dcq4BOuzYiRwIdoN5dv00BW8L8
   g==;
X-CSE-ConnectionGUID: zC/9izsESOaKyzdln8k8rA==
X-CSE-MsgGUID: mloI94ElSIiR5AVCFQYMyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73702155"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73702155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 14:29:47 -0700
X-CSE-ConnectionGUID: ijBv+oRlQy6/NMcEzPmPPA==
X-CSE-MsgGUID: dN3LkymeTV29sir/bk1t3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168106454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 14:29:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 14:29:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 14:29:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 29 Jul 2025 14:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htb83/FlM69Ztnr49a6GtgkhkMd/2AQgU8aNYdpz/WYHMKV99r5cLDJb5IGUQoDfKOK9k12Oj6gAoPyoS831jtDzLfN+jFN754vyTnC2WEfYdky/Uz/ub22dsyFjVXnGeMDRH7IV5SQUNeDVDpfhNi/NdYGvV2IaBySCzQHZ6Cd6sd+DaCE7SbVV5kjFnLBrlcR3cwya0INLByaIyOZRH9BLTEkxN0fofZeiWokalPUq+P2evuUSY6EJ4irsEuv5D2sCCdEkzGYRA5Q/tJ11bD96xmjytDMFLG8MD6YAyWkwcyz9+Aex4xekhvB3D/43fP3JZWjPPyuPA/zQgZyyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWyDyu4nJ53wrWSR6xNR/mIOmetz/mwsc68Nr9HUJm0=;
 b=LIvwq6peR47+FKdEe86x6y0imik3WMTiB64ripDpQfqdioIGtVL1Z5gNpRdso9zR3l9oTiqGjzXGJGaCiq/dUg7mmbyGQ1iEzQCFQeiId9msH0cLC8m3B63YCMTneMy9RPuLKQ/lfOYFleB07sipy0iMHYhRoyNGVvFoogmhp8lWhuceWIlKJ6lZV9Pb9n0XuDHyAuCIuthi3pVvsAUNwYQOOkp28IaTUAg3Sriy6WpWJkh/xqd0nEGLW2qu8qo5kqcJ7XVWexKlJLTucUTZElvSfINNSRyuxbdxamZLgKk7ilPPcpHRxmezAQsPwZFnLvX3mqA8Sv0A76vgLhrgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 21:29:43 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 21:29:43 +0000
Date: Tue, 29 Jul 2025 17:29:38 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Tomita Moeko <tomitamoeko@gmail.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH 6.12 4/4] Revert "drm/xe/forcewake: Add a helper
 xe_force_wake_ref_has_domain()"
Message-ID: <aIk9Qh6sZdEks-9I@intel.com>
References: <20250729110525.49838-1-tomitamoeko@gmail.com>
 <20250729110525.49838-5-tomitamoeko@gmail.com>
 <2025072932-unjustly-thirty-b125@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025072932-unjustly-thirty-b125@gregkh>
X-ClientProxiedBy: BYAPR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:a03:100::41) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dfc933-fa3f-4374-449f-08ddcee7087d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Np7rkXxjhXPrrkFDNij/liX9QcTnv8wnJmF+d2ghaIt/s/ff0c9qyN3ehiUW?=
 =?us-ascii?Q?HSE4MSYR8A678qHcShk5D/crHH/WVzyB2oAyRistYOhGaqfyVdTrumEHcHm8?=
 =?us-ascii?Q?gK8atW56AJbdy6PIrz/ZPAormV+rpmIRg4sM1fWcV5TU2npgcS4CJiWu9yvu?=
 =?us-ascii?Q?5OQPKoMTtyBfjCdanmxJJJokFs1ob16mP9DvY/XbSfMZHl7nua3HSVbH+syO?=
 =?us-ascii?Q?FFlHrssPO3zVvkL+NrB4cxF+gwFoyw5KxxOQbpcaJ5Ft+kB4HN71D6PVHN3s?=
 =?us-ascii?Q?R6JzjVo7CGb6yt0bQ7zVMcpsJzkfGZs7Dj0+GOE47bR8EHIP+G2JoXtzc/U7?=
 =?us-ascii?Q?ztE0a3i2LiYGVP0+rRnWsHcXj1pV1NvOcvlQ31t7/GuK8oFSQkUAESU7w6js?=
 =?us-ascii?Q?R6tdWqcta2D0NAtNiHmIoPRRY+Cxa2WK8I8UL3HYAymbYiaHjwfWRm4IvUiK?=
 =?us-ascii?Q?sFY25vNS425AM3lCCGtsSEGVK7Hwd93nCjYo0o3HCFPsr4IFn7Ga7A5IN7WI?=
 =?us-ascii?Q?LaFevwZXBwaPggYO0cBOvQhZ49ReixtxPIf/q+XvgP9fNx3QPcDMrqDZot/V?=
 =?us-ascii?Q?l9Ju+WO8skaccE4LpgQV+rYEEdXoQIuOUTZhaRekowsOsPBDbhw4a9k0kzFm?=
 =?us-ascii?Q?+Ze+m55s3g+2g27OTCLiT95a1c9GrjhK5UGWLeMh+lrJvQ7IkmUcnMdfO+ks?=
 =?us-ascii?Q?WAMXFphLiyY0MWKmzMq5iZFWtUQ4NuRN2Dy9v35JC7Za+df5d4izljVCY/08?=
 =?us-ascii?Q?cRGH3MtEZYb4nWy63A/X35L0bPvo/JqmvQvHkSIV8K7n84/e1RESS0jGx6wd?=
 =?us-ascii?Q?7reNxoidzKUJFGdbBckIBdT1sC5a48aRPgJIlgezr3R1o4shaokfHgTV5Y9o?=
 =?us-ascii?Q?ExRH0YvFcsjowo+EaPPlX2mWYWgsg8CgG53WDL64Cn9pNkxlFY0w8RwFuKL4?=
 =?us-ascii?Q?S6yj4T/8crWLrjagmjh28FDa9mfJ9K37l10dZtnB7rO9osnLQHfnwPbUjfzq?=
 =?us-ascii?Q?tIKw+PjV6G93Sw4/gefcJnoUMpcXEFBrJ+xlIxXjDIKR3/n9rR2rp16+cHUz?=
 =?us-ascii?Q?UKYhxgf2beGTIO6vdyC/JmAyXaHhPaNdtFFfJDDebrAxru1I/Y9r7dFP+4XB?=
 =?us-ascii?Q?qkI9i+dL1s43GUWl70sthVe7fSxAsJNmIeFnwy+11F6pA04HKA6hlJsWnVNM?=
 =?us-ascii?Q?hiKJcu92Y6U7p7AomuW81Sopcln0fB4PWTPquXA51ykoYN29vMhPnVjLwl9o?=
 =?us-ascii?Q?2UvCNOXHbGJ1uUxzaS8j7O/Cw+i1Vi2+pLTMSpIDBZ5oqWtP/fNnVs2xpmFA?=
 =?us-ascii?Q?a7gwMXvmqJYJO9EEQHliiAgeYJ/ubtiAYr/SXqAuBP7ITCp1Erzg6K6j5E8I?=
 =?us-ascii?Q?Xi+V5irFRrMedwobZYJeDdO5umWZuF8/KmTeJgVlReKuGZhcDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzPJZvsD49p5cnaKQHqHAXHmmPSP1ZmBQS3FlK0mnfCWANuz7+Vdv2aqJ3W1?=
 =?us-ascii?Q?cUMRn97W9/5wOp2r6yibByvUwVFkUELGMpH08k0BBXiDQ9RvKAYZlpoFKu0c?=
 =?us-ascii?Q?VfmsK7knrQFDoQmAPT4blSLSN5vx1RZCz4uhX9Sysx59qAGSS88I4qROce0i?=
 =?us-ascii?Q?6Lh5XJC5LNO2GYCPthfDnWJ+64nopVwPo92/zdUlNPqCL86Z+M4oNF54MBS/?=
 =?us-ascii?Q?hztuKYQNyf/Xv3DBZb6W7Wjf3IvMeSIIuxx75vTElgxlKiWSZuAaUXm7lr0K?=
 =?us-ascii?Q?nGZXuXOaSEc9xxaF+vjWOLSGEvTpvB3NgrCsIaKtADHeGnqU9rYPaxRD//Fb?=
 =?us-ascii?Q?LN3Ra9CHHZhcdEDb+ZI0N6xnObW1cFN9L6JkI+VuepV5p4VpFYFTo+Ly1qqn?=
 =?us-ascii?Q?epBU7YqXLgRumJfq1Gsw7yB8jf8aL3I0Ojnzts+TXzhOVdnCkSfvhMWm0CJ3?=
 =?us-ascii?Q?GUZDqKvkZ4tioeh+xpih5QVtYiCihZT6a/TDaXKHxaJrtIktUPRZQ/8JI/zU?=
 =?us-ascii?Q?cG/wAMkCUo5gT/eM9ohXduFZUGePDaofq0WzLMIWZ//iPsldV1sg/rDeBE/i?=
 =?us-ascii?Q?9t2k1L1QZO12Vu0kSQK8gkIufjlO6BfXwUGGXZ9ide83wFxvNP7OMHePniiG?=
 =?us-ascii?Q?6vTEG7D29JeO/RzZI6BcwOlIiVMN+s4vpF8928cYSRsGNsGlTF4rAa2sxK1w?=
 =?us-ascii?Q?0hZfvq6uCVTJMGJuDlLDusyafpsNEJMynFp64MjqJIkBwq0tDL113VwPjcNo?=
 =?us-ascii?Q?ZsrcAeh/4pLCNbHKfGvkpNzuiHBfKBsTro7JMypNwwgkc3KCgvRNikZZhPy4?=
 =?us-ascii?Q?gkCjyDcrehenIzMZjNcTKsxSYY0Bsz7y6ELkhe+iZwwgBVGv18FwXg0O/NyS?=
 =?us-ascii?Q?qjLl/mtwrbeNMDJfWXHQ6f45bP2SvSBRSGztpmSh4vqxVbcPR4utPT17p0+L?=
 =?us-ascii?Q?cwJ8w0gPNqLL3rJubpHu1fdwTnXBo/NmoH4/9Tmv50F41wtVhxSFr+DLqD4y?=
 =?us-ascii?Q?aeSLwIBC9WCGHKiCtvavHHaBFghvnSrvXDFS/8eYKnKGbFEp7MSNMMM0gnAi?=
 =?us-ascii?Q?rK6n9V5HwnJrDzw/6jgMbMlqI/ZiVZ5TOa1MJpZmtyfKu5s3mkCq1fwxjApl?=
 =?us-ascii?Q?SWEPGq14LO9SzT4MsLFcOhXEKjYhOgFEaBkN4FnHqB+KSMA+GFDGRpyREoat?=
 =?us-ascii?Q?BoRHs/uCe5mLmLigy4VKpc+WF22iyR2UYZsJUK8uPuQ9Vw6yoWwo0Tkmrl+R?=
 =?us-ascii?Q?ZsZz+Wf8dLD5mg4YAazJtFh/zgSKIDgZ7VhTLn02J/vZBDqeqdevjkUZSJ8k?=
 =?us-ascii?Q?xOp0m2HrrskLKYQJ4KMEe1dKt6/nVBpUMgi/MGP7R2Nu/nCnM86DlDU/+2jK?=
 =?us-ascii?Q?o5ezkxrYlME3Ac1FdZGdHuLhyFP3AOUS4mIVmLD1COGwvXZ8b8o/3yQk6FmT?=
 =?us-ascii?Q?LQ2LurtBboGpv+cd7L9MxfvvLgSiHpN+i0JfOo6Mun65kYWuxsPqRDjM5aQQ?=
 =?us-ascii?Q?DW6wVQwyUxL6BU7H+mM85QGP60aZB/vlY/r5k/uM2NoNHkpsWSdJyqNij9HB?=
 =?us-ascii?Q?WaRgWUhuv2cwqbK1dE7WUCYK+0ey6PDWLmH6nUbk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dfc933-fa3f-4374-449f-08ddcee7087d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 21:29:43.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lewIYQ7ggeEC7ID+nuCNTH39sCtABmdlSmCAuVIz1yhCmCgTZ5LkN5j0oLHCvY/BNnfEvI9lLl99D4IkqKlsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com

On Tue, Jul 29, 2025 at 04:51:02PM +0200, Greg KH wrote:
> On Tue, Jul 29, 2025 at 07:05:25PM +0800, Tomita Moeko wrote:
> > This reverts commit deb05f8431f31e08fd6ab99a56069fc98014dbec.
> > 
> > The helper function introduced in the reverted commit is for handling
> > the "refcounted domain mask" introduced in commit a7ddcea1f5ac
> > ("drm/xe: Error handling in xe_force_wake_get()"). Since that API change
> > only exists in 6.13 and later, this helper is unnecessary in 6.12 stable
> > kernel.
> > 
> > Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> > Cc: Badal Nilawar <badal.nilawar@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> > ---
> >  drivers/gpu/drm/xe/xe_force_wake.h | 16 ----------------
> >  1 file changed, 16 deletions(-)
> 
> We need acks from the maintainers/developers for all of these before we
> can take the series.  Please work on getting that.

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Looking to the history here it looks these patches were ported as
dependency of a fix:

Stable-dep-of: 5dce85fecb87 ("drm/xe: Move the coredump registration to the
worker thread")

However it is definitely not needed and these reverts here end-up with
the right conflict resolution that should had been done in this
commit 5dce85fecb87 ("drm/xe: Move the coredump registration to the
worker thread").

Thanks for the clean-up,
Rodrigo.

> 
> thanks,
> 
> greg k-h

