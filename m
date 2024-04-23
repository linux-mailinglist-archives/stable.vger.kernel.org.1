Return-Path: <stable+bounces-40743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12498AF58F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2C71C22A11
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D713E038;
	Tue, 23 Apr 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEZ05Dud"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38113DDA6;
	Tue, 23 Apr 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893727; cv=fail; b=fkBQ28Ye6ZzXmPtvoS3Y1iSWEZxI/t6AQcXiHLIaNky98/IB7NeFkQoSRVTo/MK6YbDbDzX03mFb4YrUN4Qu90+WM+fZVwLXGGM9oRFG9vMWz4aTETavoC/oA3t1GBS8IJ6JMKAIkDVKXx5lhvRpO4og/R0ia0a0hY3PeIwBido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893727; c=relaxed/simple;
	bh=BMTZ99o4N5xnfpCSa4gNpBFqIl+Ehf9Zj28W9lRI1As=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0h70HbBRXLiylWeoEuBxa02aEJF4PUdx9rMDo81RW70THx0VwZZpxPRmRkae+MT3omKL/L8gnGFIq+co8b+L1qd1TqX8Krumqjf0lb9iKkG3HgbISOdSmHwSxAd4buL40IKP7OH/4yQizR8UmHZQFfQWu+9+EpMoiyh+2PbVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEZ05Dud; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893725; x=1745429725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BMTZ99o4N5xnfpCSa4gNpBFqIl+Ehf9Zj28W9lRI1As=;
  b=CEZ05Dud0UNP9vST1xAK4bRHkPnXbcba0/56BwA6MkkEyMpNPjUJY0Vb
   y2Rv3HJjJXhOOyO5J4kiDEqz/WV7Zi+vwesAn+9YRfyPKaMKJ7WWmeL+M
   3DKrLCyvAwAHf21rctjOpCxvGwhTaevRnlwqJFvtn6E3hUS5QmMzVq1Qy
   ZQtyHZG0IJH5Qz7OE1dRNkk6dE46Mg3H4V29RmFeynRZf1csIAknWo9Fj
   +Mz54TTO8NMoYzH9t4CSTgVlNz4LjjzCPDifdikxfdml2+y52WizhfgKn
   uXCr8EqyOsEPXgDfdSutgkdmeMzBHxcLXA63VrceITh1SPDN60EDlA/Pr
   Q==;
X-CSE-ConnectionGUID: EdOh2uG1ROma9PI6g7VWww==
X-CSE-MsgGUID: N4Pbh8opTMSGuZivwTNmuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9712138"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9712138"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:35:24 -0700
X-CSE-ConnectionGUID: mTyQ/0hgTcu0C2lCl89LzQ==
X-CSE-MsgGUID: PJk5134DQ6O2ZJrVKtgscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29096759"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 10:35:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:35:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 10:35:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk7g7iavDx3AFSZieDD7U0PY4T7DnFULQQohtCdyRVGtwpirNLotvxhQLZQFIJHlmq0O9VvroKJMTxNkrFlj8U2ZGdUVMp8krOYYwz/+Ay+BTPOe+zu91izumOXd8hV9e7JukqnXM1BMMeX1zGJt5eLnIbA8A/rcFRMU7Ij3EO96mHRneMJt01Em+r5pi+E6hOMbK+FYzz3ogYuuZLP9gpujO9B8uSvIaJq9+R895S9hozYB8uDibFl8K7r+NHQdjMfh5YyPd0FKUeJUCpfd5bj7WUDMB8xXp7P0h6Yg3HGG9wEt5ipR0FHYoN3mCM58gv4M/LhIZl/M/WI9+h3vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBtPykkE4Tlk7wV7VwG2EykluVTDIxe8vbGmo56puvA=;
 b=S7puGjPC5A+tJ22DEuEJByZs7EfZabjSscAM1utSUWCOxUHUV/Xpx/tdWAyfJeBMqOI+2pLbeSve/YqT3ePE7lK+qZXwwJgFjdUP+7jThu1tzjBhI8u+kJH1KcXkrdBc3j0sDZkipUxGiBd3fgRZ0ahAaov50ashQbrnZdH/MJFeHd0NapeOnpe0ht0S2xAKkAlespggzeQY2vS5/w3mfoKTiMN1qQ5EZls+9afsyxbKl49huFarCM7EJME5wHUhySDxTkqIZWT7p19lKK39dZKE0H4CE0EEEOGS5rSXVqc4VsXvF/1FL5Sizwt4GLWnc8EGcQv3M3mhHntxaFXgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 17:35:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 17:35:19 +0000
Date: Tue, 23 Apr 2024 10:35:16 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <alison.schofield@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <6627f1544e5ab_cd8e02944e@iweiny-mobl.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: BYAPR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1174435b-e93b-4e2f-0c95-08dc63bbbe9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDTl58sJNVJO/bwbJhoGJHapoPciEwWwFFXd5gKCihMOppKQBwafh1SNtCkY?=
 =?us-ascii?Q?93dzxe872PW0Sv2SrVUQqYZ9OzIMHl2UdZbomfK3NoaTG/kuZjExTCIMSVjk?=
 =?us-ascii?Q?HXPVto2iKXQyzN3obNytBhH6yRYlR4JSj0A1Gfy+DEU39azg1u7f0JKgRO5T?=
 =?us-ascii?Q?vgL56CKZ9Ayzd2BPGJA3cwPqId8a8/cSwqZfU773tVoM0KJamWEs0T3ulv64?=
 =?us-ascii?Q?FC/lS3reWEFDH3oES5/aniJPGCmJFkxAZdiYM7bBhXYumVx1LNhX4puSLNKP?=
 =?us-ascii?Q?rfG+gupji0eF6ZNapRcRbyGeca+/L/p73bQrTD06CFAxKQ4telwZSHXLZk3u?=
 =?us-ascii?Q?DexLc5ZAMck/4WZpSyXBRUKTkMcuM5XPjbmn0APPyh1RcQv145K6H1tROQa8?=
 =?us-ascii?Q?Jq600LFXoHa55XjlTl+iv9RuEMLip+FkxcKxZe/2PmKC4PlYi6+FjMKnHqkw?=
 =?us-ascii?Q?BYMTNvcgYLq04lxmkqvL4gvVd9HNiE9+bP7fZADPydasiOCxA4td4+9SMuQ7?=
 =?us-ascii?Q?m3TdBoLedaGftpO/mFwme+Wr4uzTaYid8HtCHACFtnVxJkx2DcJ2o7uioHoC?=
 =?us-ascii?Q?MIRCQgiU0JPPQQOUqAX7UvolPv0GO3N6G1outFqakMamQr10/ko/Aw/rMAJ/?=
 =?us-ascii?Q?7Aq98BWFzCxUM2MZ8rIwUqyEu5eR2YS3E2XaNn7a89I7NuO66Q868LT2IG4f?=
 =?us-ascii?Q?jFonl8QuhVKc6h0WRzgke8vhvJ0GcFDzF2M9M7gwzaDXOggOKUW6o/sa8W/d?=
 =?us-ascii?Q?E2asEhWy0KHW5Q8paeta40j2d9BKDnoljDwpPXP3/rnmWY8rQRCv5ElTU2iL?=
 =?us-ascii?Q?j2M9OwW2nwT6D00T+8uThW8u1YwWfh3mYZqoH6324RR4v/RxWo73lhaOf7tY?=
 =?us-ascii?Q?IL2iyDfDVrqc5QTxMzr4NPMlGEKrQIPLZRorABo/Ag5zTO4t11G2XkXWTj7m?=
 =?us-ascii?Q?uTJfljlV/jDGVM5CXheEMJBHVMl+MOXf/0OG0uqFh9U5Dueebg1BfhwhLiFk?=
 =?us-ascii?Q?Gi+/dcqDJapugXYvM3V+c/Vyiqj9qXnjn+/m4U6V89aIJ+thA/+lu2elUXEJ?=
 =?us-ascii?Q?UNpLSo30AvaiHVOpLmsDEwDtzCvkPhL5uxzAhY9+etrtYyOJDzr4S/uohzER?=
 =?us-ascii?Q?8KevU+AFLuD7DH0McTDuAnw4gUiGOv1GaxZCZI/6TG03EWW0IP6meR9Ql+z3?=
 =?us-ascii?Q?A9V2XlhAm+2zA9G7V/pBMTK24chD1AV6xw6WumR/ycnYQdQTIiUBgmy3x9tS?=
 =?us-ascii?Q?Bh+eXsrWIJZD8q1g1C6BUtnEeHY5TLKPBU0ZUjEUZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKCb6XR8QkJDUpCWl2Ul61nfLGyjqG3RVYzz1DnHlkHD8tR0zZZJN8sFvW1I?=
 =?us-ascii?Q?y2+tAgmTNCMeKyFGZTEfkp6DlRxkaxejTyYJHOXcZU8NKOOPDfE2ZLDosK/B?=
 =?us-ascii?Q?hf81VbGVOHW31Qjjq4evtOWEBJGovn8DJNEnzGkK6XhUE0I2FcR9/EgEcGR5?=
 =?us-ascii?Q?Mj/3O8BVJgvFIhw8kMu/VTC6VWtW6akP7+R5SDXJF/Yq1CHZDuHGS2aNNDSO?=
 =?us-ascii?Q?qJuovgXafAYWZSKwNa/eSt8OJxK8IGTY44jKqK6JDoSj4ELb6Jzmhj60M1jA?=
 =?us-ascii?Q?Me7S4HqI6w9OLQT9EFWt7mxw0/Ciwe8uvAQMl6x01C+86G+EqJvz6UVAvvw2?=
 =?us-ascii?Q?XlCgOoA4mt5yWAOGdO4Y9MEQwoWS6zHLeGFaFoIVJyJkpPvMJQDTU40qZXkN?=
 =?us-ascii?Q?fhVASvlmpW9ZNsFHSXqkS4LvYZokHoULunptRENf4TrAiMGsIAqFs2HjHTga?=
 =?us-ascii?Q?DEIAETUd369clNc3PX6aIrZv8dwa23K9r4z+92MEorph/QkCNn8+wl6kzRK5?=
 =?us-ascii?Q?x+p0STw5kixWnCSvg1Axzjs6XQMDZj0mTQgLSg8m3TGSz7fYZ68J/IkdfgDG?=
 =?us-ascii?Q?ify4l0rinnzlSCs8vcEDXS/+OHN5qrG+qawmpopWNQRwJV06g3ieusevwpEe?=
 =?us-ascii?Q?JscilhuXyDxe2lniNMFawaxjTQacL2sFVEbi+PrshXMhi158RINjxz7FpI9v?=
 =?us-ascii?Q?WUBgH4CnYpt4CikKBVs6F9qnzzLSIXNBo3Req2/9WT0U173ZYjJdt3BEPkCy?=
 =?us-ascii?Q?h4QMIOc2imw+TM4mDhCgLg5rOXCnOQ+GypigvEjBqHJtI2BzLlk94wilLmSW?=
 =?us-ascii?Q?77LthY2wmwRiyxfpNj51W+kaZ/SCqPsR/qOpdrpCX5F1sTUAmrBatWd4Vhru?=
 =?us-ascii?Q?n8x1GD7VtMF6IclDcyjc6qpsuph+7j0QxKh2Q/0PBUOszHieCKQql5BKejjo?=
 =?us-ascii?Q?1vdSu3dUV9qq3zmhprkQZlrLWzkxg7R46hKVyOXTIUkmhPZoEs/zN+twa/JU?=
 =?us-ascii?Q?gm/KcUgBuD7eyCpPege9PGnqDmmZTn+pGff3goi6ggMACLfOKAsnmL7bcsQ5?=
 =?us-ascii?Q?DPR28kHZfjuzYcjG6AzRdSEaayt3Xegbz0HavsLvFKJ97Af6w3y8UbN6/AJU?=
 =?us-ascii?Q?rF5Ucikbm5YBzdb/OrRngrRUaIi4yfIYuhlDi0b32FS9ZOrkBXxSzefjF/NA?=
 =?us-ascii?Q?BHiXas41Q+Pp3Mb0EV4ec7DHjFgfSko6yLK/OdrT11Y2A7V5WsayKSrjzzfR?=
 =?us-ascii?Q?uYldY4ovKVj0JZoHouOIw4UCCtB7GdFKr3d1gruUk5BpgHNuqsxoq9uheawl?=
 =?us-ascii?Q?W7EBKfvIbq9pGvmkMM8MGREHzcp8vVH3LdN95yABcooHCPT94p3preTqOtGv?=
 =?us-ascii?Q?joCDYkENcLMKQu3BwhBpjhLRalxhOpfc7gH/0F5QcjHs9q8out+BCr7T8lIB?=
 =?us-ascii?Q?r73F7AJotAUZZfbc5K711pRsdHJR5KO1dbpzECGI/iodbQ3yapKiGpeNGd5b?=
 =?us-ascii?Q?Nd+6+uTHGLiXUyKq0UpTYdLAjMSrzgeEadqfi+ilRg/Lzlder064QvmxHGX1?=
 =?us-ascii?Q?4CNaRq9qznWV9ZlSi5y4T55bXeD877So51J6B1a0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1174435b-e93b-4e2f-0c95-08dc63bbbe9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:35:18.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsn8oxD35ozFuQCv5ZYVTmUhY3kk+/qKAKg0SVgA4waVIoG2el/rr8CpyR0P6tWlsuLAAny0dgEuKhJkCfPH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 
> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Apologies I thought I saw this go in before.  But perhaps it was a
different mask.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..cdfce932d5b1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)
> -- 
> 2.34.1
> 



