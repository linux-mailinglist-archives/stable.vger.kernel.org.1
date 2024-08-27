Return-Path: <stable+bounces-70322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958A960823
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE01C22715
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44519E7FF;
	Tue, 27 Aug 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/6WZ0Wt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CC19D889;
	Tue, 27 Aug 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756774; cv=fail; b=SfhbD+1rP9zbWycI55RP+RbddIZRdALKu6FzLDV0780FU0yqfmp4NWdKklAACksuPW2Gkh6In/UfyYOZrqXCdXxItcvDiYN8Qqj0+uo9E4a9LzKGis4+ZAorQvRfxoALE+MT26ISHtK4HC0JGhKNRjEqbb+tebU+WIUN2ZZpZyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756774; c=relaxed/simple;
	bh=UA+lip7UJ9l0/ZrwtAf44FfNRWcYA8gvn+9464JVV9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUwYlyFQCEphGhzcljQTjgaws9yIzQqFoezYO8zfzyN652kbhhtvB08JlsNDeDuo+mpAzb9BwsVu4+IBOJQ8SsheqxZsJ/cgTeyQ5JzQdiXpVkOIzqnjdMGVYQWkxDOpsbTglvYkx5IeOvPvSDLKTF3+s9S1uj1zeYQnv21Vjto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/6WZ0Wt; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724756773; x=1756292773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UA+lip7UJ9l0/ZrwtAf44FfNRWcYA8gvn+9464JVV9k=;
  b=M/6WZ0Wt10vMn42ivVpqr5/QqxuS+EZ9fQYihqxYfwsrWM8/YP5/UwKb
   fppQ7DN+/xy711zVgY+q+FGI4breTsPHP33hyq4SW4ctDds+bbTw/8PVY
   e7LweU3ePEf8ZN47LFg0/fq1byw2/S9yRUQxvW3P3AsapAGcnkCy/oSiW
   b4tC5wKhYoEMDHJGt/1N+j/aaA43mmzCbhRhzsn1qd9RFvmNx4M+Vd949
   7B0iFk+syEiD041OtchVhvHugXYbc2muu9Mbe9NUn9/Va4MjQIQ3YnCy2
   NDjK02svHjppjFD9acAe3+aCLupLzGXmoPRBvhOwH3htVoP7sk9mq++9t
   A==;
X-CSE-ConnectionGUID: QJ8Tbc0xQrSww3wch2ZcZg==
X-CSE-MsgGUID: C1A0e+RUStiTjxBim7F/TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22747268"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="22747268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:06:12 -0700
X-CSE-ConnectionGUID: u3gg7XXcQkOjosR2yjrcjA==
X-CSE-MsgGUID: y6X9VcJNT525dPcJ0fVV+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="86015170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:06:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:06:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:06:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p919diwiBIxfwOZNUhItwOdxNgnMCZw1YNnd0POxUEagw6CCnsNjlOvAMdd4pK0NDP/dOK9u+G8cz0TkhMw5TfKG/t+Iun6gth02nZugYRJjAw0krtR4fcyBz9YJ2lDSonzc2dcPNjKITnbUgisGV1XuWFmE6TPsEhmyYgpzeoajoMgy1odWy6e2LiNXxn7vo5Yo51KMhLKGY0CJL9Y+LG2YdFGtSt58HY4fDOyGWQY/p0nvW5bhpchL8u3ZV7L09nFtUBiciWTANriTXXdmj0UknsSQdN1VZ6akTXEXWdwd225Vtw03dGaRzjr4uY0mscWFaelQZWd5eIqjMvz3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJa6B0xo9Y5o6t7HK7ivwl/VK2L/hbtRRAYrBjeGG7Y=;
 b=kT4YVswNd0PYQKD0ZtPlR91WAu/duLkobCAX/jWmgOgbz4Rcq1jOrp8ITEqNFRwXQ+OVpCyPlVN44QoyiXgtrVmdxtZypJ0om25hkA14Xidj0WveETbC92We5FxeqHxF6Xidq7Dbfzn7uPLbk0vFr2f6gmAIChCf9lFkx6a9bLX2N90AKwgvmZDoSNTtJmrqDnMxxmIxogftLeHCLtERuKubsfNiEf2btj35g3Vv9HL4/vAisSTaZ1eIxiJp/beAX90/NqyuoAolaGJmdr1uV/oVAHnQgehhItkvlNRNMxbA0FGVmL9y+Q7BxqV8Nnvq9ELQtZoq/8XH49al/OmxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:06:09 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:06:09 +0000
Date: Tue, 27 Aug 2024 13:06:00 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>
CC: <jk@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: mctp-serial: Fix missing escapes on transmit
Message-ID: <Zs2zGPZsTIaOO6tD@lzaremba-mobl.ger.corp.intel.com>
References: <20240827020803.957250-1-matt@codeconstruct.com.au>
 <20240827020803.957250-3-matt@codeconstruct.com.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827020803.957250-3-matt@codeconstruct.com.au>
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA0PR11MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c7e266-fed6-4f06-6b90-08dcc688413e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y2nD94Y2Y+FFe3+mihiMt5IpwIrr4bf+0SMV7/9c7X3r7XFaL9EkwdEfy0mw?=
 =?us-ascii?Q?VhsehxHbzpZK8br0Ar1Q2dCpjt8IQr4uirIN0eoKjbr3E4fVGntDv1ivnF5d?=
 =?us-ascii?Q?6k8cFdY7DVul02rcbzLoWZcExN0eDHD+iF9PC4nIQ4Xg5tkrjH+nWsRD46Zu?=
 =?us-ascii?Q?xoidTpP0RvoRj4pxrS8c6ESnNxcDssmRdzXA7n/1u3VXmaweTN+3FasTGzLa?=
 =?us-ascii?Q?wCOAZVDWGC9JDyQ5Ej6AqmtwSeRtNPnHa0XTXIHWsFBBZuHjQoEVDt5Bwx0b?=
 =?us-ascii?Q?jQDq9HqbDUzBGu0ch5hmwzNXeTzGqnRvalgLldMqJ2pbgLEDwubpPBNDNbKb?=
 =?us-ascii?Q?ogW6duTaljSwK2kaBJVY2TIZ00QOompn2ZKPDaq3CiYh3vlMRzH0t5r0XoK6?=
 =?us-ascii?Q?ppZuZxmgAyVNa4T3+e87rrFerl9MQQXzunxEEIMoWMYwumIAHAdosZhj1g6W?=
 =?us-ascii?Q?rN7G6PrGCIgMJq82k91rf+WR7mCc4WmeNWldv1qsAcnE3ogJPg65cU4Ub9ZD?=
 =?us-ascii?Q?G877od93xW0wENexgUkk6p08eoZLR1+BAYSfPQhX0gV+mQad0AfOPWZS0l2c?=
 =?us-ascii?Q?OlFWWf1SDmS3K2+qy/wh0oUtmS5pNEo3qB/j8iSkfW5bZGFxSULcIw5uKCWU?=
 =?us-ascii?Q?ZpIA9QeY1/6nXG6Evk/q7ZlDQIe/4QuzqUEsQkwuahRxlVjwaRg1K8Kj7o5S?=
 =?us-ascii?Q?kCOL9s8ng+puRI1BMFjE6OrPFNEbmxh68FK+xvtSrCdI/1GCJdjv9pimY9Ne?=
 =?us-ascii?Q?aNerYnkflSw+uiIByREC3Q1c7HUpMvnoMVz9p2peNAblqmRVJR4I338DtpP4?=
 =?us-ascii?Q?daZ9gR9oHlnmzSDWwidPxo5EWvxHaCQbYJOTsXOWrKOEM5382p2/4nZvkdRm?=
 =?us-ascii?Q?7Vdaf5j6YDMOnxXL8jrVcxj1pOvLwxXGFfIlUELpaL7nKLBGpQmFWPf1WZw4?=
 =?us-ascii?Q?e3YFD5BcMPbVfCkuvT6z/Y39mENq+3QPgbiy6P+QOGdURvLmf3x2nU2k2YMA?=
 =?us-ascii?Q?XHhWnNU36pdFjgvuSVU0UxN/nkytuVmsFiBANZJ9vyvUBKhSkMrGdSLvmBHo?=
 =?us-ascii?Q?rRpmAStllOyjcx/yMbrzGe14nkkaPNObyHw1P5lrDQuhbICO8ql7R/FlWpMp?=
 =?us-ascii?Q?ctmdIqXF8zGdL2kON15vKFs6Yz4h+HkAVnn1NIUG547G2y1nmlZ8LMw+oWf8?=
 =?us-ascii?Q?y8xFnmghg34maknYABwRzpVhSvepYyHeCTZt0ml9ZL2g4YDmAKT6qjHbOz3w?=
 =?us-ascii?Q?283tb+u0RGt3J3fQiSztzZIXdR/u27plWW13SCaYN7QR00FHppTwvJOqIQc/?=
 =?us-ascii?Q?at8dkKbgDHDJCw78ncmonyowyZEu/EYBUYxcSUpYnVQXWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9PLImsgyQLBxmgZkpDPy1KDUS0ZlEwmtLaAI/Qll07nhMS1ghzEEc+6cu6S?=
 =?us-ascii?Q?lPTneBPiUL2WJPGFn3naC2LyAO1YvEQxU+NKFqfDtJWxsKzbB3UhbXKEkwDC?=
 =?us-ascii?Q?P32DTG90EL8KDqmWv3NlbNT5mYo2aK9+VKWWHw7r2EZEarVaJ9G64qVVcVZX?=
 =?us-ascii?Q?npRhjAw65/8Jyf+8fRHZYE+SGeKeNyZuJGfSB/I8QCZ1ilF72BekHa/gP6fX?=
 =?us-ascii?Q?jFVJ1wR22A1c1SzZsqg23MSRGcv50Oeu/oRSEXcKeqSyvrhQdALieagrs2nN?=
 =?us-ascii?Q?/TrQVfPZJGypUbFtjKWRs9VJWWdIsnRpqJPWLgAJcy1XtbrxDydIuzq2CoP5?=
 =?us-ascii?Q?eTVM49vKlWoZS/vjwzXUUZY7ibANyy5fFOv6qolnIivYauEeXndtEpnNSckw?=
 =?us-ascii?Q?qTZMfJsX9RPSAtCXpsGlnJermDKadwLuLDy/D9G9YL7n/KvNHq60UqU1KzWg?=
 =?us-ascii?Q?MRj4S28x9GCOVP7IYBvT8a8dAF3615J1RpGqXqcBilqkfttJznPF1liHIim2?=
 =?us-ascii?Q?lBpVGr61/43o2yql1eXxE2qFbGpNnJC5TvHjC2HLKbPca2YgYYVx9NE8+7XV?=
 =?us-ascii?Q?EOl0o/6gSuc7KUHzo7dy9fCmrAA+AnL71tYqWFLtKWAz9Cf7h1cIgoiJQy6H?=
 =?us-ascii?Q?qJ+aQUGfFFyIakWhNdbnO4lQTo9VLTXi+Mtf58nk9yxcFpt3NcYyc7WiJ0Uh?=
 =?us-ascii?Q?dWMrOP92zLydiPQXLL4JwO4OjCHKhhnA0rh4veejo1aUhV9ZpUMzKwB542RO?=
 =?us-ascii?Q?pV6s5j8qmVf+zVdiffkiE0WKF4Sr1T+lbfFG81fzy2oaw7TRFlLdSK5TC28u?=
 =?us-ascii?Q?ikkL1DpKwAdT9EBLZAE7ZFLgmT2MXWbljtirUo54kbpoiNkY4QQsjAaaRqLt?=
 =?us-ascii?Q?5fNLzgRM8zIwmrmdfXb/+nEv9P8ZsYNd4zBWFT++It12o40Ujyj8NttBtX98?=
 =?us-ascii?Q?ArcYqGMrUOt423YLvnDed0aYr9LG8jVg1Q/n5eobQUli/BMweiTKrHjRAZcP?=
 =?us-ascii?Q?mZvSrrLPBwf0EBRbsUKQRU044hHO0B6Ku60TstOZu7dC0HcDObxH3Kqpd11B?=
 =?us-ascii?Q?K3ZilXwoIgGiPEbf6Iv+u4pf8GHhOeAgrVEWRRPQ9hzh7gEqs/SCa3S02YN0?=
 =?us-ascii?Q?SGWoIAk4xraOnRSL071yyGFIKOlj+Y+jzK3tkFRayhLX3jqQZR4kCnyv0hV6?=
 =?us-ascii?Q?MQzRPjmdJhILqrQl0pX5mNbrDsipuQGlDSvaO3BQnU7jLutDf9nW6qf15uwb?=
 =?us-ascii?Q?GF6qNypHcYiX+GqXA9dVYMYKvA8u3wJDKgzXz5Z0TwBBZqe79Z8t8wQMy86Z?=
 =?us-ascii?Q?HO4Ep/tXiNNvkyJM2MP2rGrds/dO1SdDSE3zDLU5VIOrl5E0AbPOHue6AMnR?=
 =?us-ascii?Q?VtBwrjE8Cex6ae4zpq7LxfEjKnA1g3MSm/F1imdESi6UgvplyaCsEX8ozAWS?=
 =?us-ascii?Q?uy4HeQrwEH8/Om5I9SBFbikkRSJyuq7lUh6mUFskBQugIRUk1pWcDnShRo3N?=
 =?us-ascii?Q?epMqgSuYr1orvMtQG6G9mhGn8Ym7x31jVqIB9UyO1k75kzrGigoZc4JjCmCU?=
 =?us-ascii?Q?9yguWnq5Bt4PSdusQgCbAqtsDVMVWICZYQIZE1M+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c7e266-fed6-4f06-6b90-08dcc688413e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:06:09.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwI9vePut/eHaNaoMP+kHpTY1XJHaUg7Z8YJ45Dm58gRUYI714g7nVfUexOHnyqGhAmTT8M42JknNO9yswv6FeMmG+TkuTRmqW/ON31UbjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 10:07:59AM +0800, Matt Johnston wrote:
> 0x7d and 0x7e bytes are meant to be escaped in the data portion of
> frames, but this didn't occur since next_chunk_len() had an off-by-one
> error. That also resulted in the final byte of a payload being written
> as a separate tty write op.
> 
> The chunk prior to an escaped byte would be one byte short, and the
> next call would never test the txpos+1 case, which is where the escaped
> byte was located. That meant it never hit the escaping case in
> mctp_serial_tx_work().
> 
> Example Input: 01 00 08 c8 7e 80 02
> 
> Previous incorrect chunks from next_chunk_len():
> 
> 01 00 08
> c8 7e 80
> 02
> 
> With this fix:
> 
> 01 00 08 c8
> 7e
> 80 02
> 
> Cc: stable@vger.kernel.org
> Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  drivers/net/mctp/mctp-serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
> index d7db11355909..82890e983847 100644
> --- a/drivers/net/mctp/mctp-serial.c
> +++ b/drivers/net/mctp/mctp-serial.c
> @@ -91,8 +91,8 @@ static int next_chunk_len(struct mctp_serial *dev)
>  	 * will be those non-escaped bytes, and does not include the escaped
>  	 * byte.
>  	 */
> -	for (i = 1; i + dev->txpos + 1 < dev->txlen; i++) {
> -		if (needs_escape(dev->txbuf[dev->txpos + i + 1]))
> +	for (i = 1; i + dev->txpos < dev->txlen; i++) {
> +		if (needs_escape(dev->txbuf[dev->txpos + i]))
>  			break;
>  	}
>  
> 

