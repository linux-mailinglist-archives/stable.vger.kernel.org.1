Return-Path: <stable+bounces-154701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3CADF691
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A583A78C2
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD472606;
	Wed, 18 Jun 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpA72NRa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EC19E96D
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273254; cv=fail; b=LBaX/zzbDjmMoOjwRFnlf/uRh6jzEsYMnojvPZXMB1qUkTrHgOni0fn3iTjgCDPtSDUqk0IRsuR7pGQlsFR1tVWS1UJPwXza6vRcuN04vtS+WIGcwzHkIkardS0CE8f36p204x+DDf+Ui4u8glYG3EZwdNYaoE9ZC6eBCw3CqCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273254; c=relaxed/simple;
	bh=Up3THfUKoB8Dd9dMDNJQwwJL44rHJzrm0oeL7eTWtGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mzw2876G0GWINnY6G7oh89WlS85LgdvM+Ho+RLSPqIoN/pqoxQclY3Q/R/w8s4llsCdi18epgifnViYV2M7gufNHIzjAZK2JXz31DGUm1ap84CP130I1Nj60ZXAB2+87wf2fMrXmWEZ3hWpA1rYjcv32nK+QIOEXOlwZFytkYPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpA72NRa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750273232; x=1781809232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Up3THfUKoB8Dd9dMDNJQwwJL44rHJzrm0oeL7eTWtGY=;
  b=DpA72NRaG0n5Labp2SNyoxD1+PA5+4L19lwSgSQa2OT4UXTtXXg51PFY
   Ew4EsOoOgbiu5z+S7jhHTa6JgEPvwEqOBzjEGNXLsNOWZVSUEK5+uQFSx
   mxFDNmdGTZSpT+5QU5RdzvqziAhzaBs6MI5cTOpI2loZ8UWBM4JnjSXjf
   Vz1SOmpm0AEBdOsDC3MtJb5bm0IHyrGmlno0lj0KxN46tWXlJlgdtU9Pi
   wCrbF4PpFXPyQIAVNOTiaLG1H9GfR4KpbgxBbE/qVSadjJTiDjcYDXF6D
   Rzs7c9Tntcu69AfJDu2WcUou4W6sDLa2p1EnfaF5G26UOQbBRdiXWGtqK
   Q==;
X-CSE-ConnectionGUID: 4EP2uplXS3OL7EKN0kgtjA==
X-CSE-MsgGUID: dagYzh6rQUy1gRKx+dswyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52603137"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52603137"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 11:59:09 -0700
X-CSE-ConnectionGUID: LMMW9SCERvGsUvjjBKweVg==
X-CSE-MsgGUID: 1M7uH0C2QSi2MmtiiRTDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150726730"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 11:59:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 11:59:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 11:59:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 11:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEwHnRUWF8E5IMHtJCc8SYLOJiYfZBRn9G03rDCVM4e+5VfT0QpMlOsOh4P/Uxe2q/GdUgTRliMk4JI6Z/MKaNw914KOQAKqQXtfAXXFaBb30sZeXFlWU1k9mRpR4OENNRPBXiVLMEd9EEuU8c0mG4sXayXRvTh2ACghWuBDbOT+UdkTF3rfuBg0Tt+5QmZNbNgJ/DqsL9mMuq4kplBGPnY84hPjT5PdXgOsbTVrLmP0lYwrOXiuQLsIfuDxkvwQIQun5XnwYXKdqCebV/0jlF8ySgMgacIR3R7mwJ8K9nnIYvs9wsvQN9US8SZepT5ArklX2qcY8q3cuu3FaPRfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVLuzDMz2na9GcbK2GkF03QchkZx/PZAtzZt2WHIbRc=;
 b=hQ5mOZvhzpuaQUdZWMz72V+/vt/RP2RCluqKCWVJxtTQ+05J/oW5n8z4Vt885Mc4S51HvB78WM0bgcHcUCCxWKdAb+pw1W1TqOuFDyg8XEcDPS1zgrg8UpKkex5KFm+G/cjqlbblKLVN2Uy43I7gM6FY+WguT/n4NeR0bqJiRkU873XNydx95pbLy9c49EtcSlHfJBeq/hLGRzRnNIpRkWkY/h1YBM384eW76WtCgO+ZmX/gjb095DHiW003IPK+9aG4uEjm0J/zsc08PIjDzZm1rNoNnB7FCTtT0bAyV9N4poLxzbLW4PjetFtYBKcZ7tR4BN98IOLs+9ldyAAAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 18:59:05 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 18:59:05 +0000
Date: Wed, 18 Jun 2025 13:59:02 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/xe: move DPT l2 flush to a more sensible place
Message-ID: <3vkprsbfukxqmjkusizkh2wfnjo2jemajp5c4c6gfethtx7ruc@3r7oecdbcjp5>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
 <20250606104546.1996818-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250606104546.1996818-4-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2244c9-c9d2-4cf9-3b7b-08ddae9a3282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rl+emTiuukOvRUHp6HheOASjh8BEjObNtaubTBHWNW3jjW7RKm7n1LsYNYZ2?=
 =?us-ascii?Q?q84a0UrQEKzCqCr1PCtkxKci+jbloKLBVEYayb2nDnlY5n/icvrKoRg9fhyr?=
 =?us-ascii?Q?kksQJgZX3n5Jf3qXzROoz768o9qcODQZuulSl1ZWaZaXthvFAuZ8klls0QbM?=
 =?us-ascii?Q?vpGZERKy/l5ikCLnvHeiur940OwD4/QJrB16E53qOEk26PjnqtyytSmwB3T1?=
 =?us-ascii?Q?K5r8wepQk6sf+1F+1dUHoapRr9n5EoWVWgUpjA4WU4sPYiJQMbbyps2a3bHO?=
 =?us-ascii?Q?40dE+9rQodADqFso3usb9qFvWAL/g3lEaz77DSGMNGLdyYzU8L2WtKC7niiH?=
 =?us-ascii?Q?ie3F+nTsnIh2qbMOMvF7BZgAJoBLY2uGZ3nb0/rmHCo3yqfWuicAFhWxPSgw?=
 =?us-ascii?Q?A5WZ2JzhufRJnda8rR0a7W/7u6g5MHQ2q3c/9qUVs0WCoEGIQAdgLCWZT1RC?=
 =?us-ascii?Q?wSZ68h4/zzqN4kzu84L+Olu2DZPqnXLc2qei+xSib3W7PJSe3VXi7f0hTAyE?=
 =?us-ascii?Q?mzTRjtF4ZYpxWXCKFMzA4TeWUgpgiVOQOe/rWgJ69zqMQCkEk3HHlIS77hby?=
 =?us-ascii?Q?JoNe6dSIaQuUKO7b5npOg7MoIT/EHSZi6cZrN2kQuxgvCR+ZjWnIRpM7yo4K?=
 =?us-ascii?Q?Ex9vxeFmVOefeg5He4qqUvDPWOjuQYlh7DrAU6SGyjhGyfzRWXmoWAqkaXun?=
 =?us-ascii?Q?9iudhLS0PjTOiqrKkXY9TO5wTpCEeXJ5bI+6z1Tw9mbkeeP4cGMu7ocjmQ2M?=
 =?us-ascii?Q?KFSATDzP4nwBnyhlP02MCKY4TsKIiiyrrPGEBYBX+PJt47VTTOhcspmyUeLb?=
 =?us-ascii?Q?DF1J69/xb9GBAABhLxwEiLNtdDgBXS6n2pbr6BRBR3+pE797wHCUmhFif3Qu?=
 =?us-ascii?Q?hD73xooRN+AIIyd5IxTIDUrRyP5x1DEjB8ZOBwjts3kEQokOvIcJbYCXKMQv?=
 =?us-ascii?Q?7JV7t7E28+YnWNUdo4x3juOGmruQJUqaQnkie0bZ1CpxmD+fymE0DMySMdmJ?=
 =?us-ascii?Q?R0p47N61GXDeQcD9lL6GO/sMugPWqvSJioJgxLv4C+h2GKYz+aVg80D+OaJK?=
 =?us-ascii?Q?Xd65ivIcLcZy6l6uJURDps+oezg8wmbPb5ie/xG6oZnXr+B8p2oxvGWHT7dX?=
 =?us-ascii?Q?BvFjSmPWl0uoowpku1n1uUPcrIFEIdqY6E/E7BCZmQ5QRM5Il1IqmI3oKdDl?=
 =?us-ascii?Q?MMskSLwZRZDPsKFiXoK85AksaNecJqztBNSpOi+8RN2ANrqWOzpDp2aOJOTo?=
 =?us-ascii?Q?48BUc7Wb9AnbbEM4Mae/Jj3xZ2y/QiiePZe5iuowfkd7p7TA4pb0KXLPq7bh?=
 =?us-ascii?Q?B/2orhRhLShUjlADfx/k3OLiMAKQeo6Di/oqTjZEAKcORUvE8ttqbqxNSooJ?=
 =?us-ascii?Q?XzUimKB+1ewpn2dj2IaT+1UZJxyE2+dh+MTnh6UjjBqupQWRtgHzybvEDoo6?=
 =?us-ascii?Q?6v7y5ABC9W8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5Afzn7xn9gm9CoaAlVjhVY8eJVlDL3ltoYx3W7b5tnZ0ndws0zPNvKhEwIP?=
 =?us-ascii?Q?MEWmKuBrLOUFbkmpQNjqI1nZyRdDPwxF7AWJ+bgINPrndjOnBFCquXiHx3So?=
 =?us-ascii?Q?RsX0ylddBcSDSP9OQFIRO4u4S5SCGV54pQ2GBjeI601sQQKY1zrGl76Uolo8?=
 =?us-ascii?Q?GczEy+aqiHn/KbRA5Z7l0eiV5jADzkq/Eq01jdZFC3uUZMFCrLQpYDYgkxOb?=
 =?us-ascii?Q?qu1n7atesYoMuUhki4kBHami4S5ecO5M8jw35VWY8JFnVaB4RfY52PdW2vaO?=
 =?us-ascii?Q?ouP9g3zi/B6sYronfLGMwM/PmAMtEgoz81J9KAG2l9yJFijU54R5GNMKOf92?=
 =?us-ascii?Q?CXnWiJvBPM8Id1E6mBNXD8i6WKzagJoXS1ijdawngYXsKmaZCoF6lfqnv3hE?=
 =?us-ascii?Q?zfeB6J27V396Vaz/2PjjzVvB9ZOmjy94fWZ9YIzHjAG9qKtMMvI9ggwHmJD1?=
 =?us-ascii?Q?oHOzRr3fjVfAOst1rv0yVNf5gMXfDKmoQB/KQ14Gfj3F4bM90qIB2VYgixZF?=
 =?us-ascii?Q?IdGkwlg1kamp4ed8R3kvy26dRoMRhCXcPNHimtwk13JXvqsMol2w95aMu6K9?=
 =?us-ascii?Q?ZhWA5k/+CBcs5KFmSu3DRa99QN/kuplTCLWaY5liYLJbKWA0z68oKUOSk7iB?=
 =?us-ascii?Q?InVxOe+LIpH1VPyo9UNlTwqtXeIp5HC7jpNGrA6w9SaRA1gRZ/721tWJdgvT?=
 =?us-ascii?Q?JkebOMC6F2midURXwzVy5Klqxl2+gj1LgjejC4g+zozDJeCVcYT2AMzirXMg?=
 =?us-ascii?Q?2m5Tj3pp0IImnpc0srRoBj2PRAHnZlKAnERTA9iNQUb+vGbBfOpV2Z1F8jdm?=
 =?us-ascii?Q?+C8a4XidIOkFQpHc2kYYSis301rnmD+kyeBPTql0HoVcCZhn5vT8eWtegT3K?=
 =?us-ascii?Q?jBtnI2Y/a6n6Sx86gydkf7onlb4mI75ysGTDyPzdzcSsyzwP0hDQE2VPTBGz?=
 =?us-ascii?Q?+SJY9XGVv65f8aHYT1herYdeus0MGsf493A9yFIgpeoqFyQXx+uJq+aBWku+?=
 =?us-ascii?Q?av2q4ERwJDXuinAArqRwGMVWhbjFqSx8jhZ3PV5y0jPbMqcv3mC3MVTukhbO?=
 =?us-ascii?Q?HsltNvQXhhYrKAMmOQ6g0avrXAKz8HqieEgzjehAG/AKMcivgmvjt2xv2RUO?=
 =?us-ascii?Q?bR1VwIQ4v8nb3aGqCSGiNfdiDAUhJKxH1gNJu3GrXplAPHAMLJRj54vVHkU/?=
 =?us-ascii?Q?W2/vB9dUtmYloJs7r5PNhBxR/HVPgLrEBZWSTENFAZfE1nlT8ENfp5peeTdt?=
 =?us-ascii?Q?CadLRBvAZCoENn3CWUOh1Vi+H86fMBq+JiUPF5L+Xq7DiPPX3tGRry86NAHf?=
 =?us-ascii?Q?b44aJIkKZJt0vBOvWfrBac752xzm4JZ0U1xcarjK53eLH9yLphF/QqEaap3r?=
 =?us-ascii?Q?OOY8Wu2GZfFlk9wcexdTsWm8lVdus6DF5Nko/Y3BZRbkdiQ0EfLG5sSYxeGg?=
 =?us-ascii?Q?HQ38w2OkcRj5D2660Zq8rfI5y9q0ouhhwHXX0ayeqd4IqEFT3RnAmT2BRFyp?=
 =?us-ascii?Q?4VlDkHcKc/3/MrzR0DbYQwf3c9XHcRJiPsucjWErDnH5dmMPfrrdIp4F6P68?=
 =?us-ascii?Q?fIaE33+Soo820/ZaU+HwORFuaCgfXnCh7gdLjFxqPqFZsKph1kxtk2byuzbP?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2244c9-c9d2-4cf9-3b7b-08ddae9a3282
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:59:05.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLk57yt386FmTpK1iKmD3QHrYabwvUUsfHKfAvF8Sztx58xolnd1JI8/wENlL2q+3quygL8ReGDI11LeCULvZGiBLmvAu7YGaEKYBaHNYr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

On Fri, Jun 06, 2025 at 11:45:48AM +0100, Matthew Auld wrote:
>Only need the flush for DPT host updates here. Normal GGTT updates don't
>need special flush.
>
>Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: <stable@vger.kernel.org> # v6.12+


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>index 461ecdfdb742..b16a6e3ff4b4 100644
>--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
>+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>@@ -165,6 +165,9 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
>
> 	vma->dpt = dpt;
> 	vma->node = dpt->ggtt_node[tile0->id];
>+
>+	/* Ensure DPT writes are flushed */
>+	xe_device_l2_flush(xe);
> 	return 0;
> }
>
>@@ -334,8 +337,6 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
> 	if (ret)
> 		goto err_unpin;
>
>-	/* Ensure DPT writes are flushed */
>-	xe_device_l2_flush(xe);
> 	return vma;
>
> err_unpin:
>-- 
>2.49.0
>

