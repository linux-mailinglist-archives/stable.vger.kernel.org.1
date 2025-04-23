Return-Path: <stable+bounces-136481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A1A99982
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 22:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38565462B91
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C226B953;
	Wed, 23 Apr 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do9Ul/Dz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD612268C50;
	Wed, 23 Apr 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440636; cv=fail; b=CuSuo16uhEV17cwBr9y4tOqSG92ylKX7LFhixBQyUGf1lhluEGTR2YbDsJcdOVppGp3iOsOtLTghTVuIfkcT/9q5FhEpOZKGzDKopJrgGXpBzv1eaY2FThZSXhNyhZvD2zyhg32ykbi94WCBUikvLsj8XkMoF9PaF36N/uBfXdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440636; c=relaxed/simple;
	bh=izKcU2VxjMPYiqGhZUXwlZHZVyuFPa4GnFno7NUzSX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qafo5Uu3CSm7tRQkcT/zoJo7QepVY0G3Rg0h3Mwkjy0EllsvqJxmhY7812A2g9HsNGqMMVqAS5A0iktKzJYRKN+YrRH4b7IWhI9JneHSPQB0fySbQP6Hx0wpa/MTQd46mPwDisWPzA8NmEZemUXfVt7LJdOrhrizEC1THUeqQ/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do9Ul/Dz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745440634; x=1776976634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=izKcU2VxjMPYiqGhZUXwlZHZVyuFPa4GnFno7NUzSX0=;
  b=Do9Ul/Dza57fcZ96Ls9G0XiJguZCMwZLpJtbuXxy6AW0ZRHMJQXq/Uh0
   9YdhArUJwXhuD+1hZwfT1PSlTyIvV+D0tjWwMmx3F0hHjTfLnpVd+XCs4
   zjXuA+qiZC5YSBUIkr8QuK4Tbwft6JeogdmYsO+rqkRhGxR/ZH8kR16aK
   l0JlNzx0K0xlfhJtjkQfxFeq1d3vTiDySbucHpSwweD2ubLs68h5YOLFq
   kCLqyRVC2zuf4EBAyr/eGogoUot/4JghIPcysaO3tiluT99KBSiWT9tSB
   QKuGXdp948vPaBvJ0IaCWXsCZuEbSWdOmiDol+Xye0F5bhN8DqDJ142sK
   Q==;
X-CSE-ConnectionGUID: 63uvUvqlSvC82zn2cRKOCA==
X-CSE-MsgGUID: Oiqj3n3lSoCfIXWD8vmr2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46934172"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46934172"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:37:13 -0700
X-CSE-ConnectionGUID: ZHLTqiTVSb2W+jJ53HkPnQ==
X-CSE-MsgGUID: N+YESpDNTOi4pnRXemj2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132303005"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:37:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 13:37:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 13:37:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 13:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It0KSw+gsOPW2e+a6w8U83MMyEsPx0PZhWA2xJfIrGzmXYKYklAcSdQEsfcPLoKsYcbQ1l2lUu4Hp8ozibg1pu5RJm91WXEhZIzvBFyVU1o69hU9bO8+xmplP/LvTS57JPeQoQ0ts7fcMOfVHUAhWxf2/DIYmCkbHbmY2u80Dc4KoDCCnUkgDrHwXBBAtxueniF42qPlvYP5Vi0T8904eVMWN7IvZY1qXp1czgP8KSjWQl2ujRiZIsBu8emn7YeWXMkUsNh1vi8HMEI+mMXUdQIXVIDLHiZoOhRRkxx93MYzUdRvQgpCkbQCGud9UvHFnbAG/7F19wGcA5JRa5wz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPTx3U4e9IwGDwkcPBDNpWX1LVJPufp403lbQlsreXI=;
 b=HDmoYtY9GwKCIqwZRxhgt+mW6sZ50ZBzakhi7sJFL+rmEriIj8Re7+aDav5T0cDFwWj7Pa4j8srAMX7v5VtgcCFiFYS26A6UZufSj2Pp7aZIBI6sCoteMZ4/517TSdTcNkvIEdlHeM1YCS/H3WYHc1AOgBZcM74wUQ2yHG6I2Vs61v8dYtmMq6IhpEEXBzOSUgvufuZsVdc6YkoNQqFMTvwe/AUaeBAQ//amREPOEVHFBTUCeMJCpDbGK1JSWHKmo54Dgu9eg0bnKexWKu3LtJqWKqPyQsJ/2sxqH2fXVepKyyhwQRNrOyG/NLF438CgrcSNQ4XrdVZ4z6lo+T/EQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 20:36:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 20:36:37 +0000
Date: Wed, 23 Apr 2025 13:36:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Naveen N Rao <naveen@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: <dave.hansen@linux.intel.com>, <x86@kernel.org>, Kees Cook
	<kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <68094f51a7b01_71fe294c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
 <174500659632.1583227.11220240508166521765.stgit@dwillia2-xfh.jf.intel.com>
 <y3c6mpt3w4pdx7xzaqdlsr3ci33cseuaxwdno4uh3jfb2ddvxp@kicc5stwtcto>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <y3c6mpt3w4pdx7xzaqdlsr3ci33cseuaxwdno4uh3jfb2ddvxp@kicc5stwtcto>
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 540ddb7d-38fc-4291-9aea-08dd82a68b6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pN700NZa28pmx0GwXhLBukQEp9duE71K2Wz7cGoSEQRiYTSwywuBFfZ63J12?=
 =?us-ascii?Q?x917o1wSIgqRL8SmS+EFk2c1r1i8dfHJnD6CmmEc9Y7fx6+b1j8FHVzAvSEQ?=
 =?us-ascii?Q?pSyqOzYUu8BHSDdOmDtjqvrEzgWWf5iB1PdHn289aDsSkWPVkN1cQx/L9YDM?=
 =?us-ascii?Q?NsKgY/eGgEDHx9rSDA9eatRjCUAaL5B11wakZsEc6tCBeA3MGeVqYuy/UJ1B?=
 =?us-ascii?Q?STWLJA5JxyqMt8aRh90roXDbTU+DZgMIXhw8LNPV2CNZw+Zt3fQ3MSlsz0kk?=
 =?us-ascii?Q?XJRuOlM/litFcnUHXQqPMogPgnvpirFo9p4hcOkVCELYCaySbnj5/MDBImrW?=
 =?us-ascii?Q?MIYEmPf4cD2OVUtGb4z23Cg8E7hDj04zkcSz0LKvCBftSDTMV6/l0HVMg+IV?=
 =?us-ascii?Q?rORv667e0V1P9SInmz1lR9HZKVRDXYcgdo2fMj/yHZYAUwYcxooA0F9SYVEl?=
 =?us-ascii?Q?byXzRaud/d9w1e0y908K0WUfKS7ncF7vmpVYt74atf1N9jNXWYRP9xHm+CR7?=
 =?us-ascii?Q?sT1eibEQ075vbiEHn5jWy1p13boR5Ar60zwRYthgztNcMTix6txWraLOPlGY?=
 =?us-ascii?Q?OeGyvfGj6M0beFQXrlGxsXjnu4vx2JddLTfLjSHukgwLBzswWOcv5kU4WrFa?=
 =?us-ascii?Q?SDtFqu+2Zw4Nhn418tSc6LbhATfmjxN/rpk695NjkTHoKAVZYLHMYZ259Gtg?=
 =?us-ascii?Q?pG7x+tQQpMTgVj4W6BI9q47QifM7jRG6qXDCYN5yJ+4vMElbpxXtDRW056m7?=
 =?us-ascii?Q?q8t8KCnZHLcyVvL7pgfqJcwaT95P3/LXUeriqA68KJggzmMNrnwEiemkOOCD?=
 =?us-ascii?Q?GoYvmpaSizBhYCuqWVeXRUtLq8Pdx+kQQPfZrXCMwwa9U64WO8rGp8gbbOU2?=
 =?us-ascii?Q?Ab92hjfpIgTnmwNLN1H3hOtbIKCYW9ezBnFJZHSqyOR6ORb3VJsWDEM8C9Y0?=
 =?us-ascii?Q?yCWo+XnMz7qsoYdds0Lny495F32QnxcQk5OCgkA3MTUb6e0YYgDT34v5XaYr?=
 =?us-ascii?Q?d71bJliPBSjaqTDKSOvnRMS6pwaM97qJRvS7wd5dQcwEGBflJOa97EvoR2HS?=
 =?us-ascii?Q?W0HPu9ulK9dAXgtRBpnZBCXepDcNo67bfruWYWsfxxYyZLwe82KYhLtQHvWG?=
 =?us-ascii?Q?0rVJF6wYkAyex2UuzeENnYuxUEKp/1hKYs7qyJnI1gzqcjW3gQ/3NZGgN2FP?=
 =?us-ascii?Q?onEWvA/D+ZZ5dH7x3k6W4HPutnpeqSwRmSKvCaCjz1nIedn9LE04UHZr52l7?=
 =?us-ascii?Q?5p/f28lVy2rK7UADf4k8bplvq2iY7WrqSPpdFPrFdMb97gLyTy2F2hl0Ll9y?=
 =?us-ascii?Q?EGGAPpwi4gzakCR8E9e+Ege77pVKH+FY35fRFLUwfh7/YnZzfzDab6rvmB10?=
 =?us-ascii?Q?UdRlBMv/zKeD5Wn+L8Usz+nrSdt6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xjslUIWESxKAu5ojVQnwWTFhhbiWuDGnEaxpGeZ0l/rJo4qnY3AwNsXdw5K?=
 =?us-ascii?Q?Mb0Uxe4OFFKXP4Mz0TqU56UE2dCsq/k5E1vMQUce608nHUVpTstXjeZpBrcK?=
 =?us-ascii?Q?DiQK6LoXEluOLFv++GfucI0PZtpI8ewqGq4oSXi7zorKvw6KnPA00atX35iu?=
 =?us-ascii?Q?nWs2wk6vnH0DS79SASR/ZnGtD03dEGaz2kLCJLaoPct+KpPqIMMGdGH1x7tX?=
 =?us-ascii?Q?GAUVitShvaXgStzADskS8yc2DO4g7XUv07mq9IxmDHbYRYnvpG5UHq43Rqt5?=
 =?us-ascii?Q?0Dr68hqOHDQJRFM4+3SsI4KsfwwXPD3Wu0zEHII3q2AYkOnee1MA3yRTvpwe?=
 =?us-ascii?Q?K68kh+QY8GNSWdFMErMfsu0vPdxUaK/wta1gATVazBKEYPqSKzcBJYDbp8lH?=
 =?us-ascii?Q?2KQT5/KmXIODCcCK6Jbj7kKcnVgn8r/KAp/SF+JFz7aiy/DIUBbwOZ9curS9?=
 =?us-ascii?Q?zdgSrazrIS/aLXIKzfFsZinDmETQ4oGhx7cn94xK8lm5jB0fkqBXTi7eFEFy?=
 =?us-ascii?Q?XpptMU2a+7iD14KAFi7hp0jkqvHW8pXrbeiV55Od4xSvhBQrZM5mAZh4tp8T?=
 =?us-ascii?Q?wtztSAX3yACIngFskIMklWu2W9CByAEKi1xgr54RDz2+nt7+vL+LLnoKqErc?=
 =?us-ascii?Q?u2BHqZlGRxylNED78RhikW7jeHFjBEecVOucuilNgOmWS2jiLNwmoytSL36Q?=
 =?us-ascii?Q?ZBJUCGpA08YKSQyEFPvAzoS89sDNMyByZLBpkQn71H6AB2/pA39BSyE/hKbo?=
 =?us-ascii?Q?ip63/+YAR0EYqcHBbXQ6N1jeFSzLCNXnINnG3e+Xce8SA6duhIb2V4FHLwuU?=
 =?us-ascii?Q?UHTQXebO8y+CUHbwme5AofAUkX0cgkKGjFXhRMS3O/+PQi38LXAqc9SZkV5U?=
 =?us-ascii?Q?Eej2PhR065gpbajlRO9tbdhgOh3dfsDBR8O6f8U8DPWWM30Nj2pdcLIqxLM9?=
 =?us-ascii?Q?zoGVLi4Twn9m4nOCiG6ozeNWxa00vkQ6nS6Lafm3DTQtVkSPCzJVt4ol7McE?=
 =?us-ascii?Q?k2NYumwcW/u4Fy7OmMkGU63YyWpVbU5pBygw9Zf9C7YXHixoCwGGbEF5ycGj?=
 =?us-ascii?Q?ktFwOMlDKpRP39xIE7R12vwj57968fqte2/ifpkVrBeZAgQ1gkFGIcXwkjSs?=
 =?us-ascii?Q?MQmSARLh91VaG4EIYqyWPf7230fzvpJSV6crGp+mGMENiYWmpkCtMEHTkYEx?=
 =?us-ascii?Q?9CB4UIGd/FsmSD19rqmDMylaUMzLDs7VfT9esvGqSZhFqN+8RmAaWemNMCy1?=
 =?us-ascii?Q?/LG94KAn1Zyq8KUuIjHFIRuGKCZp+rYvwwjHLut4zQ3ROzsO1CUYBMdz0PYq?=
 =?us-ascii?Q?6GC1fIDSlhXdlv79ca9yS8aGEIH23l6syJvgtkeFLy+CtKVvHmFvdaEHeNIF?=
 =?us-ascii?Q?9f7UDze3x1qWenn9U7MWU6mf5IqKwrmJ38wVx3YB09zxjcdzODOZ6bHBO/MP?=
 =?us-ascii?Q?hN6DeNwBPFh4oOGW6oxN66ksd3Sog8EriSAnw/S84CFJV2w3qR6056oL6kQm?=
 =?us-ascii?Q?JZWZzxP9Rv61EtMpyYJNSRZyroXg8uCfZDNSiaDKYWP7aJ7pMwaAUwSQ86MO?=
 =?us-ascii?Q?YdIQHAk4U0HpNqcCeKPg+VPmBwLVjtyZ6cWdx8a+K419OABedf0+SImw+mHU?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ddb7d-38fc-4291-9aea-08dd82a68b6b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:36:37.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J4/hX6ssfnKAKapedk7ThchLJOC6FI9wxXZcIdNdWnCQcqrtn46D6Z5DuNwCPRAFjRbYMGumSCArPKXBbwUMCd+wVj/RfVP1T2bQQYeO+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-OriginatorOrg: intel.com

Naveen N Rao wrote:
> On Fri, Apr 18, 2025 at 01:04:02PM -0700, Dan Williams wrote:
> > Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > address space) via /dev/mem results in an SEPT violation.
> > 
> > The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> > unencrypted mapping where the kernel had established an encrypted
> > mapping previously.
> > 
> > Linux traps read(2) access to the BIOS data area, and returns zero.
> > However, it turns out the kernel fails to enforce the same via mmap(2).
> > This is a hole, and unfortunately userspace has learned to exploit it
> > [2].
> > 
> > This means the kernel either needs a mechanism to ensure consistent
> > "encrypted" mappings of this /dev/mem mmap() hole, close the hole by
> > mapping the zero page in the mmap(2) path, block only BIOS data access
> > and let typical STRICT_DEVMEM protect the rest, or disable /dev/mem
> > altogether.
> > 
> > The simplest option for now is arrange for /dev/mem to always behave as
> > if lockdown is enabled for confidential guests. Require confidential
> > guest userspace to jettison legacy dependencies on /dev/mem similar to
> > how other legacy mechanisms are jettisoned for confidential operation.
> > Recall that modern methods for BIOS data access are available like
> > /sys/firmware/dmi/tables.
> > 
> > Cc: <x86@kernel.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: "Naveen N Rao" <naveen@kernel.org>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
> > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> > Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> > Cc: <stable@vger.kernel.org>
> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v3
> > * Fix a 0day kbuild robot report about missing cc_platform.h include.
> > 
> >  arch/x86/Kconfig   |    4 ++++
> >  drivers/char/mem.c |   10 ++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 4b9f378e05f6..bf4528d9fd0a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
> >  	depends on X86_X2APIC
> >  	depends on EFI_STUB
> >  	depends on PARAVIRT
> > +	depends on STRICT_DEVMEM
> > +	depends on IO_STRICT_DEVMEM
> >  	select ARCH_HAS_CC_PLATFORM
> >  	select X86_MEM_ENCRYPT
> >  	select X86_MCE
> > @@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
> 
> As far as I know, AMD_MEM_ENCRYPT is for the host SME support. Since 
> this is for encrypted guests, should the below dependencies be added to 
> CONFIG_SEV_GUEST instead?
> 
> Tom?

The placement rationale here was to have the DEVMEM restrictions next to
the ARCH_HAS_CC_PLATFORM 'select' statement which is INTEL_TDX_GUEST
and AMD_MEM_ENCRYPT with SEV_GUEST depending on AMD_MEM_ENCRYPT.

> >  	bool "AMD Secure Memory Encryption (SME) support"
> >  	depends on X86_64 && CPU_SUP_AMD
> >  	depends on EFI_STUB
> > +	depends on STRICT_DEVMEM
> > +	depends on IO_STRICT_DEVMEM
> 
> Can we use 'select' for the dependency on IO_STRICT_DEVMEM, if not both 
> the above?
> 
> IO_STRICT_DEVMEM in particular is not enabled by default, so applying 
> this patch and doing a 'make olddefconfig' disabled AMD_MEM_ENCRYPT, 
> which is not so good. Given that IO_STRICT_DEVMEM only depends on 
> STRICT_DEVMEM, I think a 'select' is ok.

Agree, that makes sense, and I do not think it will lead to any select
dependency problems given STRICT_DEVMEM is "default y" for x86.

> 
> >  	select DMA_COHERENT_POOL
> >  	select ARCH_USE_MEMREMAP_PROT
> >  	select INSTRUCTION_DECODER
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 48839958b0b1..47729606b817 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/security.h>
> > +#include <linux/cc_platform.h>
> >  
> >  #define DEVMEM_MINOR	1
> >  #define DEVPORT_MINOR	4
> > @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
> >  	if (rc)
> >  		return rc;
> >  
> > +	/*
> > +	 * Enforce encrypted mapping consistency and avoid unaccepted
> > +	 * memory conflicts, "lockdown" /dev/mem for confidential
> > +	 * guests.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> > +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +		return -EPERM;
> > +
> >  	if (iminor(inode) != DEVMEM_MINOR)
> >  		return 0;
> >  
> > 
> 
> Otherwise, this looks good to me.

Thanks Naveen, can I take that as an Acked-by?

