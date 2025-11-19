Return-Path: <stable+bounces-195148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA809C6CA44
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 04:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378294ED6D3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AE248176;
	Wed, 19 Nov 2025 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD7wkrzd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628792D949E
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523654; cv=fail; b=ikGF7RBKtbVSDd/+yogZwN/12NTHKwBar4JXz5yuWqSOSi+MitaVoUh5TjKioavsfJlr/D6S6KMb1b9NMZ0FTGSzDMjyw7hMQv3tGPaJX60g8gWAtUcFh5ash1vvH3eXOtB4Yj8SXfOxwhKqUckBt8B8hvGYhTKHVvkug58oUI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523654; c=relaxed/simple;
	bh=EFVouSDn1Ro/QHE/G0DdxWFrLvVRHDWcEvTcaZwOocI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4Yjpb18WYfEtfomauILG4uKk6XPSEN8iumsBf7ggJQKQ7dHxRm8h46Uu40t/7fZ18any5ehN6Wi6ZG4rh7m3JwUHZ8JS82VuNTuK6Kobibn0BkXaVzqStZ+h+vF4Mz/OrpeRzhRcIP/IhS4NSm+7QkMIybSRpCptNL0fQsZbhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD7wkrzd; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763523651; x=1795059651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFVouSDn1Ro/QHE/G0DdxWFrLvVRHDWcEvTcaZwOocI=;
  b=HD7wkrzdLNIx7lU61yU3j1d7ZHSkyIM5X1nXL9zfct8UMEJyBy0ZwkNp
   v+GQ4Fo3W94wOYSRHmFvReWCbXyQyxRXA1Nwk/FSmgLGDgfNn7eCvusoz
   m+GXoZldp/VRydvthKbBZ5RzgsqKHOO+t0h0QRiKDUkyK4P6cRM/FszJ4
   6G0dVWa7OxBhuYDkF493UCkQyTm1ESl8/62x7N1WCgcMyMfhMWMORjiCx
   knoBEV7Urw2UWIdd7CWQGNPJEtGMONhfl2j/IF4jAZcwi0kfTE8FlUJTa
   /XhrWQzxPlqAMtvwI5p86mjW6PubiMoPyhZeFffkzHbVagFw9+9vpPVPE
   Q==;
X-CSE-ConnectionGUID: FCnEvEGnRg6jrln39VOXbg==
X-CSE-MsgGUID: JiD+nehZS9qsnoVHANBgHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64755627"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64755627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:40:50 -0800
X-CSE-ConnectionGUID: iNBpz6iYQmuydyi84RNMkg==
X-CSE-MsgGUID: W+RlkPnrSw6gCsZtUCMT5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190726760"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:40:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:40:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:40:49 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+4boEkeX69PZEVPHraOVAm6Q0XOJb55gLYmDbxWdylZByJwC5irKdK4tjrFNVucuvbMWgJLZxiwHR9+lhhok/zcuU7/0WO0poX7XhDfNQ4wRT2M3fHj22XAdVlYdgrRDWgTNB029cWorGqlBfM81qUwxq0r1NT5BwQatO+7t4XjWuK5LKhATmOOF/E0PzOXmQS+BdeYbBlDvzRtBf52IsGse8AuNh9jGIiYXc81Mj6JvPaepcStRNHBhej10ZKvtG/pD3yrKqM9UBZqqNkoerQRGeoIKTvLNAK9w7bBLSZAfNnVclfDhEaPAzVlUei7oir4Lbiwi92JXgUL+vq66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWvvowHqLVZK3+t9EEeKZXvrOtyXQBLiCWD7Bz8HoJY=;
 b=SRfQncEnRqvHl0t1dRyGtHmGN5k6ge3tcNLh4RuTZaeXovVYMEbzAWNY7GgwrJOy85IrBPSSa7Zz8xGyCR9RK7l8+9n1Ip/5FU3G6sH6gqXI6KyFLF1pTJWr0sUW+p/hpq1t+WwujOTpsk0/XOjmPsEYrO3H7m7YO5LFfXsmL24QxoANAmv0APmtg18ikzYrh2fXVExY2InCjSDOnDfXR9T2AuIPYqcxPUH92ICKMvGWVsH10lKzSmlJDgipyuGaDw8WsA8fkPwnTWV3HkwPTbNy+troDvsw8jIQchCCoc0m4BeObeTmjo2H6uUAe877K8jodY+X+jCEWp57vqTQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY8PR11MB6961.namprd11.prod.outlook.com (2603:10b6:930:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:40:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:40:47 +0000
Date: Tue, 18 Nov 2025 19:40:44 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/exec: Validate num_syncs to prevent oversized
 allocations
Message-ID: <aR08PJU7lNlwGaij@lstrano-desk.jf.intel.com>
References: <20251119024253.91942-2-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251119024253.91942-2-shuicheng.lin@intel.com>
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY8PR11MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2acab9-e312-4f46-35bf-08de271d6ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJ2bB0DbA55uwuX6AEfTOC4AGhUFbO1dgfHNeU9c856nQ+gGEKXqvPAizAfE?=
 =?us-ascii?Q?vz8D7+IK4m73ll8M35tXk2WtmRFaEcNaMAQzkkCieIRZANIEI82/X9rylAgO?=
 =?us-ascii?Q?bZGmbP7iCW9CnDIeFpndD6Sv9wcSCe4JVTe7DiwP31PpvcklIx0Lrwo3BtD6?=
 =?us-ascii?Q?ioEbb/Za7pyqliUQ/NPYxumFX2HgkteYk1SYDnIwjRes7TSVEhE0HJ7dlQvu?=
 =?us-ascii?Q?InNY3rPA09WZvkRzE+oNCYQxpQyJBdRI+eFH/4sKH/rBQhji9dN+XhyuaS9s?=
 =?us-ascii?Q?VllKy9YALggGOMNsoPNSJSXjS0YVPt695UHhPr8IHxntU0nfts9K6JTFz/Zs?=
 =?us-ascii?Q?rr/j6GkUdEtzfUvP2SfQMR6SSut1mPX2kJbKl+Eq1xj+B7Sr/UFW7wBLJ65i?=
 =?us-ascii?Q?yZKysu3dsBXAcYY0hS4zPmD/qGBMyeE8qKxO8XFX5yRDXDE/KxEAPvrYKuXS?=
 =?us-ascii?Q?2kRoL24OH+kuntyYVynFAW0B4k+q9mfA5OA1h48pshH1Q6ekQfYQw9NIqJSt?=
 =?us-ascii?Q?KrJtaXl9Jw0h1kXG6TRRqw2EbKyVZRF9nW+qk/N5emxUmkI7330wsQfeOCth?=
 =?us-ascii?Q?gY29fzU89YCaFPRUhl3fukGVWY+S2cWGGd8Kby244bqF3D8AjnmUgyEFGjIb?=
 =?us-ascii?Q?8iCBhVxR5cZdxV8ndIY7lw7Bzap28sOeE/0tHrzVO97l5lQhvWciWBxjG+3u?=
 =?us-ascii?Q?XifTs65M9v0wxhct4sGdrJmc92IEDQonYS6sQxi8BHcABTNRUYgZ3F/3AWCu?=
 =?us-ascii?Q?r4nVaRLK6guzE1DhRYinWpXStV28g6d3n1d6Js7a9m05rFT9vbBrFqCj9MxJ?=
 =?us-ascii?Q?EpgQKb8bueYLFz58Mc7NL52yZZuQqBpETCLyrG8Wc6cnrLQuGw+sxU3eKB2/?=
 =?us-ascii?Q?2YCHzT+LV8g1/pg7dV3R25xZlywnJPetTG0qSzBrNwxol26PnwS3J3YNYxJF?=
 =?us-ascii?Q?UMO3A3CTk6jqecAVxwv/BbPcmvjwi3OzGtBmFO2E2H8UWOE4K7ca4L9k5S7M?=
 =?us-ascii?Q?7h35xALzzvjB4BMaHhMjltjK+stDiuKdlyXX2LiNzZWl7LthiCicAm0PNptY?=
 =?us-ascii?Q?W1JCz9UH1AsJMC6oZbUt9lSQD6QPvKsE+w0bXLPvgQXLuVOndR+ap85Jmxmh?=
 =?us-ascii?Q?QRxsxfWGBz9HmpXYtNtqcVOLH14FVeD/GDGTf4dRTJiR4XoexyEII5ZpUhmv?=
 =?us-ascii?Q?50EkznaMEkEKV/HbC5XYPIsF40DVnYtTscPxVlcw0N5v0V4sMWEy9AmHTo4x?=
 =?us-ascii?Q?RpdWVnE6ZTiqjdk4okPQTSnT+bVpyxWozlE8rDihQ4qCScO4KOUuagOv0vMH?=
 =?us-ascii?Q?xhSrLZptLg3R7jaM3EiqRGI3oqmF3Pc0OgU0FCco+JncUHwGu2skTvV7tboA?=
 =?us-ascii?Q?5iX1uKP4SDU7r37sGYeGzMKcFSxZIxY3baf/DRXaJGOy3qArFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IU8grSciOivseBb0UmochVUY629b3zvK7u4WthjjV2SwN6OJ9lpFKjfsvqw+?=
 =?us-ascii?Q?/WHmWTkz2D8H1GJcFjQHYRXJfJaGjHP0xUfe6B+dMzzB6OD5KDwExYYYcmeU?=
 =?us-ascii?Q?zGNw2yKho5lwT5Mj+BNxcsVco+GA93HVSbdC9AnQzID4Gfok4E6MlxwehtgG?=
 =?us-ascii?Q?cynozsSLflQalDq9pv/z1rcL2dH3pdjHFxj5BWsItTvwn83s/e0PcwXBBefX?=
 =?us-ascii?Q?5N+IGs/jvKfymgpgC7ocfI1wxpAzxe+L01FbTzW4QHTp+/O56T3wlKYtcSPV?=
 =?us-ascii?Q?WJBWVlPunJF51Ep2nQy1TAnmvIiUlA36hN0oD4lRUNg6CYsT0iXXdSrK3ssh?=
 =?us-ascii?Q?XV2zLeSgWc9cO+vf/cXRfdbgDnYSB+DxsgYYr9Wn7YiUXYjKfdJ7Q9GacUFM?=
 =?us-ascii?Q?SPjlNQ1efTR8vsC4xCZ2NYPd3G3qEVRXFJHBBGapPHj2m1rhu0lgia3LcuQG?=
 =?us-ascii?Q?qb4And8ceBJCHDnHLuH6O0xCkFJWM5RjBpb3ejyKrk/S7l4RXLmDaCCf3Hda?=
 =?us-ascii?Q?W7YDGLYodC0AD1+rJwpg60F3n5ydnb6+gdu9RISdB/4BqGqRYkFJI5n0O9sE?=
 =?us-ascii?Q?Hi+KK8nzgIOdg4X/RqPdiHljHYDxtA+y68qQOFFoRgozs/9XhCbeqUZl5H+7?=
 =?us-ascii?Q?M6o7w/OVq84Leako5NmlJ4jukIGpYpaljbznxc7yE7/4SiZ06VshdNEv9dDn?=
 =?us-ascii?Q?hScvdy77+fOjitWQYx5hT63+HmX+RhuTPuzNcZ2kXHs8mWNwzGYF3LiTodCA?=
 =?us-ascii?Q?zTH0qU6Z7F1nY16Dl9o2lfulBzNjAvF2AWYhSIUGm2RicpFbyUQ9jKf+ud9H?=
 =?us-ascii?Q?PYw7WyL++GFqc3mTnxJHs0Ury8lyR8dDNhMolM0/z29qaM5P7Y4BAkh9HMY1?=
 =?us-ascii?Q?0HMFhPcSIUsjMlzj6nSSEdBULj+tNhzL9xMfrOs4WXPtpYJePz3XcNVIU7g/?=
 =?us-ascii?Q?Q98DpffYfre7E4zLjk59EfgDsaHZZ4qdo+wrNlwQqoD2Pp6e024Y7xO72XIp?=
 =?us-ascii?Q?R6GQ/zHsvIeRW/fqjo9eyQwptqLBSFJeNZBwM7axeyH8aI7pnZo/rPMHYQHX?=
 =?us-ascii?Q?qb9v0EF8UFHK8spYJddnKrM/e/mGNDBubTpeZuamsKpKUIurzwsuxYvCNjoW?=
 =?us-ascii?Q?cyby7I2hMpd93tvRMfW2bHX0SLIUSw5e1f+jfHpe01n2D74/oAwRoECixoUL?=
 =?us-ascii?Q?stoJqG4XdlEyfnpQccKFV3pOIFvHN9afjiNJBXY6mRNn0LRx0Feyut1cw6Dy?=
 =?us-ascii?Q?xNIBeihmG4Ps5f8b2IiFPrQfV9V3WAi+URlmVoJKs2Tu+KL7y0Atl/CTkF26?=
 =?us-ascii?Q?zWLPJtn7oXAwjOz1xXjMPgQa7YBOpfGLtruuRmz+9oYFfx/hJqtKik5l7SQJ?=
 =?us-ascii?Q?Vb2ggFCNjqFr0Ka7imOSLBOUiNmvlyMQ1dbce4QqMFGBvgJZDe3gAHIH6lq9?=
 =?us-ascii?Q?2chbgq3DoQrcnFNH/NmVv1aVHi1hUz2qC8+QEV0czJnGZVyqhy5A6JwMkLAS?=
 =?us-ascii?Q?BOI1BkhE7y+7G9sVNLsK06lbUAij9oxli9dt0wk7/D1r7E3z3nGjHUVeJsPD?=
 =?us-ascii?Q?779yI2ErS9CZ85HcAd+fWxjGYpGmeEZ3sOSzjvS9Zsr7Ne8zPX7Ptxh/d3xj?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2acab9-e312-4f46-35bf-08de271d6ce9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:40:47.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRj/9qS8GOGq1tJZvLjqphMDvCtVHrUzTsFOmKvmUHffPnu8+dykSlQW4zkn575tFOItnchCU+FVnL1TK+Ix8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6961
X-OriginatorOrg: intel.com

On Wed, Nov 19, 2025 at 02:42:54AM +0000, Shuicheng Lin wrote:
> The exec ioctl allows userspace to specify an arbitrary num_syncs
> value. Without bounds checking, a very large num_syncs can force
> an excessively large allocation, leading to kernel warnings from
> the page allocator as below.
> 
> Introduce XE_EXEC_MAX_SYNCS (set to 64) and reject any request
> exceeding this limit.
> 

This seems reasonable, I don't think any existing UMDs or even IGTs
likely use more than 64 but I think we check if VK user facing
interfaces allow more. If so, we might need something higher than 64
even though it is very unlikely use case.

> "
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
> ...
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
>  ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
>  drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
>  drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
>  xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl fs/ioctl.c:584 [inline]
>  __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
> "
> 
> v2: Add "Reported-by" and Cc stable kernels.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Koen Koning <koen.koning@intel.com>
> Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec.c | 5 +++++
>  include/uapi/drm/xe_drm.h    | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 4d81210e41f5..01c56fd95d5b 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	}
>  
>  	if (args->num_syncs) {
> +		if (XE_IOCTL_DBG(xe, args->num_syncs > XE_EXEC_MAX_SYNCS)) {
> +			err = -EINVAL;
> +			goto err_exec_queue;
> +		}
> +

I think OA, VM bind, and exec IOCTL should enforce the same limit if we
need one.

>  		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);

Another option is kvcalloc which allows large memory allocations in the
kernel. I'd lean towards some reasonable limit though.

Matt

>  		if (!syncs) {
>  			err = -ENOMEM;
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 47853659a705..1901ca26621a 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1463,6 +1463,7 @@ struct drm_xe_exec {
>  	/** @exec_queue_id: Exec queue ID for the batch buffer */
>  	__u32 exec_queue_id;
>  
> +#define XE_EXEC_MAX_SYNCS 64
>  	/** @num_syncs: Amount of struct drm_xe_sync in array. */
>  	__u32 num_syncs;
>  
> -- 
> 2.49.0
> 

