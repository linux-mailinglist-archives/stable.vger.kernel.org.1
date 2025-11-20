Return-Path: <stable+bounces-195277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1187C74DB1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D14D1362EFB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846F34EEF6;
	Thu, 20 Nov 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIJ81bvN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291634CFDE
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651230; cv=fail; b=QqwgOoC9Z/9zxsFdhigv6y/+LwcrABVQWwGSJk2ug7WvaW9ZT8RJc8ft6wNEQKukv1CDdhYAVkxA2K43VMV1ivaKU4ggjdeFbsA3+u/axoQywN8vRMDPFBCGOxxDxfIpPp6sTpzq+5aW2jF6o9To44ePmKRrF/yUtOzCn5I8s6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651230; c=relaxed/simple;
	bh=5B12H1Ujk7jGv0CtJhxAC+lv3pJfaqiqdJiOzGTWdt8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mnrYjrOk9i6SVd7FoQA4pWQU/fvjn4FHuBAy+MvTm8Dz5Ur8GyoS/WDEW6NpLyhUp5SI6fKcCWwM4/TpSEKZ6g++/oV18WVKUnk62Suy1jczutqjLesgd/OArzwL0WlJ5Tb64zERtNsAn+DoPaM4r2IZ2XS7Sfj8FeQkhh2Vbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIJ81bvN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763651228; x=1795187228;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5B12H1Ujk7jGv0CtJhxAC+lv3pJfaqiqdJiOzGTWdt8=;
  b=HIJ81bvNXlzvvmroRgXDgK/4RWCSF6z90UqnLpKua205tDdGOtrcKo+f
   X1DEEVsR38RA3eQ2aobrl1A81zSHAA6wVpTCU0XWFNvXHqMbRrsccHFis
   T8hfvMXzkirGAPb4orlHqP7et3Xi563YetCqY/ZaOPtRkVPQeTpmBL6GE
   j/0R+bmbnaZhdVRFYJNJKCctyT1muhJnwo6F04mHe/T1/rnno/vRqObm4
   VzAq0Aq+lY/wPNr4b46GCYMCTcQRvJurOKx5KSMW+sTjxO+T41iR63rnb
   f8SkKtzBcEDR/3662MdfjpZ+zjVw/fRwmttfhmqbtcRp10cvmpwc+Mc5t
   g==;
X-CSE-ConnectionGUID: Cae51PEwRbSXyS6GDTPtag==
X-CSE-MsgGUID: uOIQ9uqvQxedR6oqpxXhvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76333203"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="76333203"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:07:06 -0800
X-CSE-ConnectionGUID: grG4OzUzQcq9DmCDxTA7HA==
X-CSE-MsgGUID: mdPbaxt9SwyJP2C2w2nttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191640202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:07:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:07:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 07:07:03 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:06:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ+WshDNnF54Y7AqZLKUIx+QGw0cPWnY4e2Pce2IC26hGNlttGYYchN3IY3x+CPy6KHl5ihwuD2kVim3QZ75hYZbahJdDfTKlPh0oqoiNowVKKY94EjS5xEwS8aJXTfXbEaoh7aYXyyOZ1mcZPDc5JzjHY6aVUq6h/xNzbf2WMZcIqQJ/r0a5DjXLYQVVhhMgrU5WoFqn5K+zpl+5rzUEMSkvnN2AmkU17hLCsuwf5C+2455gSdmDAXEora1clr0fOw6j5UJdeE+TJN8L0DuS9TU/gqQMa6G7QC+GnPdtw3r4YRLlGO6UTBA6CXx37wjDAhruIA9reTKIzEDcMyO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuqAgwLTI7jHO7wnz1NwDNsQEw0h10e6mRKJtIEw3Ws=;
 b=oJAhBESNORWQ7Io8AdwxkeubKk4Mrse9VU7mndkrrly6G8KGr5L7PMdJWY1/le7G6lesU0Fk//ZlZqg2SOqjZtguPHBlA+yT20/h3MOarRY31JGq7gaDccaJoknztEsEVpmOXFtxYspUdzCVyvRffcbZcv4YhAKidUw40Fr3X+1Fy+HuJUkK/EeFytfRTU5ZwUkKQJoUqkhp46biOSfBOE4lHMk3Yvun+P15l8VqflcJuXwULjgN/sXYml9968GQziWDhw0CnqEZdby4CU81YefA0KLK4d0J5JF2SgTvKNW0+dUNcqy6OBs+9T7Q3JbTWIrZ87bhSsEc6m3wb/jjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 15:06:07 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:06:07 +0000
Date: Thu, 20 Nov 2025 07:06:04 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, =?iso-8859-1?Q?Jos=E9?= Roberto de Souza
	<jose.souza@intel.com>, Michal Mrozek <michal.mrozek@intel.com>, Carl Zhang
	<carl.zhang@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Message-ID: <aR8uXCNK/jJx0Rsc@lstrano-desk.jf.intel.com>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120132727.575986-5-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: d1911c8f-59a5-42af-1082-08de284654e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ormovJbmJZ4Mfxe5hyTeM0QFuMztj7Nl+1yrpV8LyjHcu6tO2liALOaFVo?=
 =?iso-8859-1?Q?dRrcKucopw2E53GnflGMP6h0a2Lpv55q78VrFaPAp2tPGgeWjrU8SqOSlt?=
 =?iso-8859-1?Q?hf+v5/9vsotiFNnW2WZLhticYgjZTH/+ZjF7ybjADrPu23dsqWDV5yBXIG?=
 =?iso-8859-1?Q?IRExwaJdnIbUYdHoAHMO6ODi5pG5S8YAo+JPiDBKriZ/81ZLHQGPoxqnLV?=
 =?iso-8859-1?Q?kXyV40+i/3Rj+QtfpAv8XERws+GvJt17yilsj37FhBLmc4CyMUCCrZhSB5?=
 =?iso-8859-1?Q?zn9pOBenL6b6LGNs0uRVS9EpVv8nymDgP+CfwLB7TItKo/ZsvfhntrU6gI?=
 =?iso-8859-1?Q?DPvXcxe7p0MoFYTUNblpDmYh/rGuoa4uFwIdRorA5Aw66w4V2js53Q6diB?=
 =?iso-8859-1?Q?HZnvngwI1pZJdw2BBUQWOEbdowZKwgYC7rSi3yuNdH53WQMNTKatwh5EMi?=
 =?iso-8859-1?Q?/e1Kca06RSLQ0yCF3rkAjIcEgGAseK3hRuSUn6+rRd6+hCgILK40Xp52ko?=
 =?iso-8859-1?Q?/mNIUBhW69b1xK7Xm4JFjuclXYa49AFt/+Qv4Mp0faaUAELzPGQhT6/aTA?=
 =?iso-8859-1?Q?xV+uO1XaLTwg1JNaDfY09hQxD4YxP/AwFjR4bJqwNVBNu9eAaVCk7WuyDC?=
 =?iso-8859-1?Q?QkiwzNQ2/pYQ/bx1ElKqiQfEtwRBlGZKEMSvIb85jaeVi63qCVyYmKmRmx?=
 =?iso-8859-1?Q?gmNgd/2EYM8DNpxkuAnOs9nfsRu01pmqkSYMspo0wAeeFymfbQF7QeGYzY?=
 =?iso-8859-1?Q?JeFHVvgvc2dZag8yZGWOmKHbgWW4w1JSsbY4FuEyR68qWEYHSS6oo6Eea1?=
 =?iso-8859-1?Q?g5D4WeTxMXcfRyA4vfvw/toDW5vGInME+nLafLq+bdPbDycE8YFVyRwc9z?=
 =?iso-8859-1?Q?m13viiDMom+E5n83DOaR66ebNeNVEMtnIWzNTm6WUWlbthyfANDN0w3vJZ?=
 =?iso-8859-1?Q?dCqJFVEOxfA84NxBMPexsFWV7TiQeKzv5uVnWUGg/dEhtYnlHvvWakaUsH?=
 =?iso-8859-1?Q?r70ZjsZAqtbsCuj5kALUbC2pWfVhpbfwtCHjvOkultbyLWQ9gw8qYp3WTs?=
 =?iso-8859-1?Q?hUnMeGrTjhRfQIvfZ880HUDVAU44TnfNZcPayZv3MlpccTDbxkD1PYrNzV?=
 =?iso-8859-1?Q?Snc9voq/3u19DevU+Q85Lmro0me8HksHeIu5J3vW9X3At/RON1MFM/3O8b?=
 =?iso-8859-1?Q?MoHXcn8ahWWbr4Q+0TYZS0kW0zoJa7D0Z2CVH/45k+9n+TR2je74uSkm+z?=
 =?iso-8859-1?Q?QMFELx1f0ZIpnBzV8rNWx+Ao/IQ/Hd0x2swPaIha1mvU1e3uo0HH52efdO?=
 =?iso-8859-1?Q?lK7b56h24E14uUzXd9Q2z7ux8pRyQaISUfAt9lzGEhGJOIwNlvRlH+9nAm?=
 =?iso-8859-1?Q?o8sByB6H2s/VLNhwW5LuGItKdN0KMTMw4QrfhmGDx61ZyAfR4BHV+ZRODI?=
 =?iso-8859-1?Q?x8WqohnCylhvdq9ghP3Gxpc8kbptuCPI07GHSO2yqdpw7f0TqGGH5HOd9R?=
 =?iso-8859-1?Q?Mj+6szQEbUul/5gqbBnV9H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AeqQDeUQ3ofw5+BdJJMx1+yu9tZIMRe5ENTub+sjJhBYWyIUdsmTlKWwKx?=
 =?iso-8859-1?Q?T8a/lQ+AMwGiqI3HizyZvqYbFat6yA/K4K8s15WUrM0tYR7IdNSuAxOX3U?=
 =?iso-8859-1?Q?qzgcY1ukHLqFJVbas8alTNCKrmsyMzUSRyxICxv+DZz7aNumYChIsHGnhl?=
 =?iso-8859-1?Q?RLPBMdrfz5PIGzw3yBzVxAwaYbopqox6RWU40FsC4eLLxwZlOpiYvBhbg2?=
 =?iso-8859-1?Q?VflT1PAzhrIMRCarG47dxgzQZGOpaPYdOam/uwU3B1ukFjvFnRWNmt0wFY?=
 =?iso-8859-1?Q?fUqWvaM1T2W9Dlp8PwX7HK7f92J5sOG6lHlrcO5YrSmDvXtzieS0LIeThH?=
 =?iso-8859-1?Q?qPh6kAXCaI+eh2TbA+cBjX7VW5IFKC6lHkK2n7Hqvv7wVqowP+g9bBJ/Y3?=
 =?iso-8859-1?Q?b+ZVSJFVGEmJWfdX9qFnGjwTFMwfbS931LDedr/ESe/mD/CvbAyNC1LO2Z?=
 =?iso-8859-1?Q?0yUxDg+4UBvxt2WdGHT/APZzVvH2QWOetco/hiQJ+Z5iqEo02twySqRuXo?=
 =?iso-8859-1?Q?9XVSixg6vNEG599evBYStwgOEaGCbL7q5WSQc0JRcVCqHiZyK8TDj/5JTx?=
 =?iso-8859-1?Q?LslAcODIEpdK7yVOyqKCD/tinIRC47E5FC5aW1gJwdAwGhTPpgw9RYK1tK?=
 =?iso-8859-1?Q?T5/CTiN1PCxMfAGmnPYERZmzkXxqXOQbSDQNKu8VSLFmW4SPZtUR725fca?=
 =?iso-8859-1?Q?CXICpwBO85WSVfPNcfb7vS1MR7mKUhWZTi0a9AmtAPWoxFdsC1+MJ6wHKt?=
 =?iso-8859-1?Q?6gED1paE4MQ+qx2O4Qy46clh2cWZDbq3OfhqfBudoEzTRaoNJHekZGiMO0?=
 =?iso-8859-1?Q?eYGY4P3RUpnnQRW0VbZGtcAgPsWf2Nqo9eXHCp4HdYUwR6pER1JptDEWDK?=
 =?iso-8859-1?Q?SMoQAuJCjF/o7Bcmkg/J9ObPP/HyXVON5UbLFm0raUFfGrjWAu0bNUDi1S?=
 =?iso-8859-1?Q?+uZi56tue/h90UW0Q7HthoSa+CseKPr4327bfJAF7nNbPmFGrxA2hWoUQQ?=
 =?iso-8859-1?Q?CrXXFUxC2FLLeQAwlmNeGtbfL2mv1EaGU31xXpOBQOnDjk9uf2CGa11mIL?=
 =?iso-8859-1?Q?5x4ynCaQAjL459N1qnoC3wqhjl7ajsdpuV0A5Yl8gkMAMFbiH9IjdpGwr4?=
 =?iso-8859-1?Q?UeXokE11YvskauX5j5ats9zvUSzHrbbKICcVXpfLW5Sstpg8qjieg0cenK?=
 =?iso-8859-1?Q?XMWIJmAUgzYWaDWuLSBsvn+wHtnYnd1Cta2Rn9M8Mvw1/rJ+Nkaw/p6Rny?=
 =?iso-8859-1?Q?nKnXwc4eCk9Hn607kFHcCSSX1DHhazGfvyzX2JZoyaXs0MadzFQd/FQiVb?=
 =?iso-8859-1?Q?EkSxqfYYhQZcLq3Ne1FvwZQgXPSx/ZKCYOCdKqukxaC7YcAer4hq/FI4Wu?=
 =?iso-8859-1?Q?UCFOHDc3qvp4abPJ5LQY9ZWcJhPZUeMmbtPKL0fj7AjmiVNo3I7QyhU7gy?=
 =?iso-8859-1?Q?2iOSpyJVbglvNvtcDnJr4d/8lPAKk0I0V2Lvo9U3SD4c+CTDcerpfC2t9F?=
 =?iso-8859-1?Q?KDfg2YQAuqlOe9Xx42CYzQwtNezAFJk7q7AAEYmSGRpwqB+Tf7hW1a6bNr?=
 =?iso-8859-1?Q?JWNnaJWdKXCdoRG431cYyJ2VSLfGIhjXMo2/cm2FAv5KmTZXo4nM8KHsj1?=
 =?iso-8859-1?Q?2oTXQwMyqf37XYVqtmIWuOn4YWVQHSvffvR6+vkRRPBZKNA/Ty6TwMHg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1911c8f-59a5-42af-1082-08de284654e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:06:07.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf/gq6graOiEgKE9O9Yke9oq82EkIIqhoxZZNX5AXhOxcP52bk2myuh6bO7edqfhZ2fum3RJGMtwEfGGHq3w/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com

On Thu, Nov 20, 2025 at 01:27:29PM +0000, Matthew Auld wrote:
> Currently this is very broken if someone attempts to create a bind
> queue and share it across multiple VMs. For example currently we assume
> it is safe to acquire the user VM lock to protect some of the bind queue
> state, but if allow sharing the bind queue with multiple VMs then this
> quickly breaks down.
> 
> To fix this reject using a bind queue with any VM that is not the same
> VM that was originally passed when creating the bind queue. This a uAPI
> change, however this was more of an oversight on kernel side that we
> didn't reject this, and expectation is that userspace shouldn't be using
> bind queues in this way, so in theory this change should go unnoticed.
> 
> Based on a patch from Matt Brost.
> 
> v2 (Matt B):
>   - Hold the vm lock over queue create, to ensure it can't be closed as
>     we attach the user_vm to the queue.
>   - Make sure we actually check for NULL user_vm in destruction path.
> v3:
>   - Fix error path handling.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Carl Zhang <carl.zhang@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Acked-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec_queue.c       | 32 +++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_exec_queue.h       |  1 +
>  drivers/gpu/drm/xe/xe_exec_queue_types.h |  6 +++++
>  drivers/gpu/drm/xe/xe_sriov_vf_ccs.c     |  2 +-
>  drivers/gpu/drm/xe/xe_vm.c               |  7 +++++-
>  5 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 8724f8de67e2..779d7e7e2d2e 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -328,6 +328,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>   * @xe: Xe device.
>   * @tile: tile which bind exec queue belongs to.
>   * @flags: exec queue creation flags
> + * @user_vm: The user VM which this exec queue belongs to
>   * @extensions: exec queue creation extensions
>   *
>   * Normalize bind exec queue creation. Bind exec queue is tied to migration VM
> @@ -341,6 +342,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>   */
>  struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  						struct xe_tile *tile,
> +						struct xe_vm *user_vm,
>  						u32 flags, u64 extensions)
>  {
>  	struct xe_gt *gt = tile->primary_gt;
> @@ -377,6 +379,9 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  			xe_exec_queue_put(q);
>  			return ERR_PTR(err);
>  		}
> +
> +		if (user_vm)
> +			q->user_vm = xe_vm_get(user_vm);
>  	}
>  
>  	return q;
> @@ -407,6 +412,11 @@ void xe_exec_queue_destroy(struct kref *ref)
>  			xe_exec_queue_put(eq);
>  	}
>  
> +	if (q->user_vm) {
> +		xe_vm_put(q->user_vm);
> +		q->user_vm = NULL;
> +	}
> +
>  	q->ops->destroy(q);
>  }
>  
> @@ -742,6 +752,22 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  		    XE_IOCTL_DBG(xe, eci[0].engine_instance != 0))
>  			return -EINVAL;
>  
> +		vm = xe_vm_lookup(xef, args->vm_id);
> +		if (XE_IOCTL_DBG(xe, !vm))
> +			return -ENOENT;
> +
> +		err = down_read_interruptible(&vm->lock);
> +		if (err) {
> +			xe_vm_put(vm);
> +			return err;
> +		}
> +
> +		if (XE_IOCTL_DBG(xe, xe_vm_is_closed_or_banned(vm))) {
> +			up_read(&vm->lock);
> +			xe_vm_put(vm);
> +			return -ENOENT;
> +		}
> +
>  		for_each_tile(tile, xe, id) {
>  			struct xe_exec_queue *new;
>  
> @@ -749,9 +775,11 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  			if (id)
>  				flags |= EXEC_QUEUE_FLAG_BIND_ENGINE_CHILD;
>  
> -			new = xe_exec_queue_create_bind(xe, tile, flags,
> +			new = xe_exec_queue_create_bind(xe, tile, vm, flags,
>  							args->extensions);
>  			if (IS_ERR(new)) {
> +				up_read(&vm->lock);
> +				xe_vm_put(vm);
>  				err = PTR_ERR(new);
>  				if (q)
>  					goto put_exec_queue;
> @@ -763,6 +791,8 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  				list_add_tail(&new->multi_gt_list,
>  					      &q->multi_gt_link);
>  		}
> +		up_read(&vm->lock);
> +		xe_vm_put(vm);
>  	} else {
>  		logical_mask = calc_validate_logical_mask(xe, eci,
>  							  args->width,
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
> index fda4d4f9bda8..37a9da22f420 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.h
> @@ -28,6 +28,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>  						 u32 flags, u64 extensions);
>  struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  						struct xe_tile *tile,
> +						struct xe_vm *user_vm,
>  						u32 flags, u64 extensions);
>  
>  void xe_exec_queue_fini(struct xe_exec_queue *q);
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> index 771ffe35cd0c..3a4263c92b3d 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> @@ -54,6 +54,12 @@ struct xe_exec_queue {
>  	struct kref refcount;
>  	/** @vm: VM (address space) for this exec queue */
>  	struct xe_vm *vm;
> +	/**
> +	 * @user_vm: User VM (address space) for this exec queue (bind queues
> +	 * only)
> +	 */
> +	struct xe_vm *user_vm;
> +
>  	/** @class: class of this exec queue */
>  	enum xe_engine_class class;
>  	/**
> diff --git a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> index 052a5071e69f..db023fb66a27 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> @@ -350,7 +350,7 @@ int xe_sriov_vf_ccs_init(struct xe_device *xe)
>  		flags = EXEC_QUEUE_FLAG_KERNEL |
>  			EXEC_QUEUE_FLAG_PERMANENT |
>  			EXEC_QUEUE_FLAG_MIGRATE;
> -		q = xe_exec_queue_create_bind(xe, tile, flags, 0);
> +		q = xe_exec_queue_create_bind(xe, tile, NULL, flags, 0);
>  		if (IS_ERR(q)) {
>  			err = PTR_ERR(q);
>  			goto err_ret;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index f9989a7a710c..7973d654540a 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1614,7 +1614,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
>  			if (!vm->pt_root[id])
>  				continue;
>  
> -			q = xe_exec_queue_create_bind(xe, tile, create_flags, 0);
> +			q = xe_exec_queue_create_bind(xe, tile, vm, create_flags, 0);
>  			if (IS_ERR(q)) {
>  				err = PTR_ERR(q);
>  				goto err_close;
> @@ -3571,6 +3571,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  		}
>  	}
>  
> +	if (XE_IOCTL_DBG(xe, q && vm != q->user_vm)) {
> +		err = -EINVAL;
> +		goto put_exec_queue;
> +	}
> +
>  	/* Ensure all UNMAPs visible */
>  	xe_svm_flush(vm);
>  
> -- 
> 2.51.1
> 

