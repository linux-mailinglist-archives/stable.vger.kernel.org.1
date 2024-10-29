Return-Path: <stable+bounces-89234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D39B510B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720961C203D5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE1F206E61;
	Tue, 29 Oct 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9h6iJ2v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011319AA5A
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223266; cv=fail; b=CK0VO+WDw7fzBzYkl1S5I4ITsF5J72l6Q01NaAHCPlaaCsABWDoLITQ3buQJS6KarA7wL/ODFcDm7DpeSTC80H+8FAfvEO4JylPEYgpwV6wDxPpeABtvpvfQQD1W6Dp9e1JI6RlxumTPLU+bTGNOjFSv9/G/2bhnHjIw/RMMjmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223266; c=relaxed/simple;
	bh=m9ROTvpUW4JZv7IHsTUkk7Gb503vC1d+XTK9RP5mc1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJW7weZfE3B9Dqj3zqN9lCkRsKaZLhXvQ34Q6DY2w+hfczyu6pU041rqBxCsIAzwLux/6pQHExNYw3pyRh6VM2S0Pmq+u60g7mwn6xzaftdxKJqLex1DkL2eayG0iBdrzdlIwFXqdNHM9RAqFt1LYyICtbFaNRyehhdmPgWeMDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9h6iJ2v; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730223264; x=1761759264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m9ROTvpUW4JZv7IHsTUkk7Gb503vC1d+XTK9RP5mc1I=;
  b=Z9h6iJ2vdTOAUqltQYVA4Ld0+5XksQkdrVu3beQzsNEi1p9QMnDXl2Af
   VTxl+qsJo+u1cj7k2oZ+gpaT8HC7DegSc4/ssuemLB0HZGYGJcTd6cHp5
   hEQdV3KyAeV8Zb7Mq6cme6SqFKcna8ogkWGlhpId+KgFtPHTkr4mJNbpg
   7x/7zjwY8kjJBGJ3RVCzn7/gUBADplM7xg2SACZ8WUhCobge9xfHFCdkr
   ZPuqWL7623pmdHlwgJIQFzexfZmITkk3m2gsleAbMCFrB7uP/pQ53/uAI
   7/ugO+aEyksBYmtQHYKmAxhLPoiXn/b11SsS4BAZQp+lP1PluX6ke1IsG
   A==;
X-CSE-ConnectionGUID: Pps8QJ+mSK+zAUUwIUOHNA==
X-CSE-MsgGUID: UfKsW25QSHy8QfQfD8C6nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47366106"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47366106"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:34:23 -0700
X-CSE-ConnectionGUID: /HPXgAGaRgC+pLC4vzcnIw==
X-CSE-MsgGUID: 0een8/TQSnWV/i4JP01Q3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86587266"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 10:33:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 10:33:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 10:33:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 10:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVoHERDc3CQYOsdgGsUI7Bkf9uMeokRkLVk/wz94l11TtpITPlO6VOfDNfKpnUzyJg5bQGNs6DnCP5Btm+Cq6VfLL1YE6F9KiCRasoTs1OVx/xUMO1lEsK7TVD3Si/xAxx6EeupggdnE/T37rJ/K5DgXsbkuDLkuMzVWeXcmDRzUPtjGr9Uasm/4fyeMsV1/qi9MN4jNXquygj2byWhYWzjkgWWvQ6r2Cc7qqHKF42OlW7AhlZ4JRruLqOYASCN6eXV4Sk9HXmrcVlJmFIXVzxb/0H0Kq19lQLHBdOktjSFh+j683m+hYdXU42VM7ZjR09o7U+apSEUGeP0jAzsUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEazYqMVnBhDxoHpYNGWTiKYAhqIHyr9AptnKOEbGY4=;
 b=g49e+DeT/JfFOH81H53oM+w3EVYNiePLeSGoYiD8cQcwV1VkiI3lbpjvSeIVZPDJIfVSHddmCi0qo7sgPqUe1aBjTuGJddhNIuwnqmrSukmj3GPkzUqPPpLBU/gaMGCQIeeB1R4yL+kWJzp2SLDzYJMazWcVaijo9jEle2g1NQ89y4b8ARLnk9qhKCz2oJrikkDXb+4fvPDqh/+PzYVCCzmKdR+zA7FeRT4Rmf08XwZAysgpNJDbsaA4AjurWcIGIr2H/gmaeoy+RXu67ohEDX5K9n6nMLMlV8kyBNJGvd31ihh+5aD9vyo8pfoQOW2MktCwKn2Av2+ZJmXaBtTM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:33:01 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 17:33:01 +0000
Date: Tue, 29 Oct 2024 12:32:54 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: Jonathan Cavitt <jonathan.cavitt@intel.com>,
	<intel-xe@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
	<alex.zuo@intel.com>, <umesh.nerlige.ramappa@intel.com>,
	<john.c.harrison@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
 <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
 <854j4uzv79.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <854j4uzv79.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c66c1b-1640-4939-1968-08dcf83fbc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dqwlMKj9XGXQX4aop4hIkL+qqzE8AXEao8te+cjhvM63V7cXWxJuZupCkrpu?=
 =?us-ascii?Q?gZIQgFTyTkktxjtUYI68gXv/aUPIwGGtpC9msOu+zyKCPdf7Wn4Ne9Um5GdZ?=
 =?us-ascii?Q?Lzdchx6P1qpglHs1BezJ4dM9lrR/zA0tW5HUtMvf9zQUHAkZvfmdRAO1mavZ?=
 =?us-ascii?Q?JM1HW+3qYUTnzAKq/CPrm6npG0bmfmDBkBI+Wlv5UQnjg0VDYDeLqeXuToKc?=
 =?us-ascii?Q?xsMbM1ZlylU3W0JT5BDCHZCxuNq8P8YosZRpFCqaqctsug47jPDLi/mZZJvN?=
 =?us-ascii?Q?huNNIs0I5vCHSgSqihaX3t77V41x4jGmEuXW7w3mfNzH/BCzDXOPd7yE2Dbo?=
 =?us-ascii?Q?H7c3om7PPsX8v3aJ0IhAjm6iAb2hYkM0kWNZC0I7TeATdVAx18BP9gwONXAJ?=
 =?us-ascii?Q?Ua4hKQ/44bCL7su+SiSKNHWE8OaRywx0iM+kIkfqLuAX5v+LJSX8GhWu593Q?=
 =?us-ascii?Q?QE31MeGEXOsNmlNMefz3mKMQhF5ZfWHOVa/20C9Mf0bvBMQ/EU6tuBxhbX1k?=
 =?us-ascii?Q?SYr6mVxrbSou20Nfe2hK/BKT793ugGGxn7dZdMmh31xvLCLAd7EuDfYhkutf?=
 =?us-ascii?Q?+EyksSDBIhk+/dS0ojCqjuTNjWQDvpPQM3bJbEptRwKaZtppoNzlBsx/wU9t?=
 =?us-ascii?Q?JUVGZ1wDdeMMLedx35GPGsoozoF9SBJI0JfyPiY7Igpya36uz+p4H2kjNBng?=
 =?us-ascii?Q?OSLH/rwI/nyoQrbhvlkQDqIMNrUjQ3kgxu/woFQIlwedEh9p1MBVIIHpqhJM?=
 =?us-ascii?Q?owrpZo43zE3TJn3LrGV/79+ZWW4/HgcSQVnqCTNScxlo0/2nFwp7tP7Dn008?=
 =?us-ascii?Q?OMBL6AjfJAoS8NEcclQCMYK0hWV4EHb+kR69F7/2u3A4d2/pzyJT8DDSXzCO?=
 =?us-ascii?Q?KlV/2dlnn4jzkOEWZ2v5Y1RKM2NasYLmOujGyhykDHBBRIXuyyAdoj47/CKh?=
 =?us-ascii?Q?joT2UAAjDGH1NQ/wWvXDn4o6mvuPkR91uqSbuIkB16rMtmEZ4CnrmFmKmNaM?=
 =?us-ascii?Q?xSr/+VIK/5N2GU0G4ysPcbRNq4hFiQDm2RlhjasMLdd2E8nO8z9W6MVKfUNW?=
 =?us-ascii?Q?ueaIRF2kmd4uBYkqhcvnr5ldOJ4a/tKaz0MABcDex/tWSW77p+zkUTDEoDOi?=
 =?us-ascii?Q?+cv/kKMneRSCQeu53QQY6djJq/MWu/jFRLt9gdEgkdsElBYzNOeCHHBfTU79?=
 =?us-ascii?Q?7cq6owuShpzcjF1MwCCM1h5Cvp8yjFd5NIBjXnKlgCLlq8HuwMx1DC4viBGf?=
 =?us-ascii?Q?GysvxVlhI43vla21kT5b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qasfXG6X5139hBvP7J+eqULiXNNpbZwdVynMGEAbGpEfGulhh2Mw/iqlpayh?=
 =?us-ascii?Q?53IwuXjllvhlkyCrHytg5jS/sZz7cZrmsMMCuN2iSvl9dOEgx7gxMv4RbXZ1?=
 =?us-ascii?Q?p6+lNnadSH85SDPZqjCFGuwN4RnlSvfuXeAAAZ0S0i4CBvdDWpl4bNDWZ637?=
 =?us-ascii?Q?Mm74g0itiOwA+4QUtpgtzSJIwu9x64dmIPIuj3ujW/b9ogmlOzH3GyqynLRv?=
 =?us-ascii?Q?s4YSNSyP+9Xkg/YiIBYhzTwlgGsjT/xALzMuMKcuNbqaiiJLXXQi8kQPjBVY?=
 =?us-ascii?Q?oZhr1cWWVhowyJhXgQg7oPydhdvUYHAYP+5AFB4//H7m8cb5LWqSyt5YBkp6?=
 =?us-ascii?Q?DEkvOScB6yDpYdPzuNeq9khNMKn7oj/ndqzICtNIYYvSVfXwxYo3YcdPGpy9?=
 =?us-ascii?Q?lBQvJl1Lpe7K48r0ebp9wvAPhNODf6GH7FFIiYrjy+cFnvCz5kGT2K02I+RK?=
 =?us-ascii?Q?FXhOAWH5xJMFc1nNLPWDqSBLx4j3EM++HJLVWnPH+/sbDacsUt7hoKEEP6iT?=
 =?us-ascii?Q?uuSF44Rp+Y81IHFZFUOqpHMogDyhT5VdLV6XqK/Nnr9/qOniUwVlj/dVuO4f?=
 =?us-ascii?Q?cIqypIyQIoreC995uJdfLXB1B+RHBjbzDWzJZAvffb4rmU6kb9MlO+maWdvI?=
 =?us-ascii?Q?48+k/iCYTRqxf5hLA7w4y8tgFDPVZLZsGD2GaT+/58TBsGAyJJya5HM62leL?=
 =?us-ascii?Q?CIZ/Jl3rJyW17nXGTXrFcneQiBXhFLCCwZLcwv7ksw61jg7oSujSA1lcEr63?=
 =?us-ascii?Q?q7wMEQR392G8rZpUO2y97Zwyn7kestvRTu+dJiHkkRbcGsojrj7JeCkwnUHL?=
 =?us-ascii?Q?d9lPmpT6zE57yeC8TtbjVrWkcxqyGGpQpeu7RQLiaFDI8H4WpVsVeqzQFhCB?=
 =?us-ascii?Q?hDUIW8J+ZS5QOqE3cZP9Gc/DtXp4jBqYFho6/97NfOHzFqgf4wQZsaWUchdX?=
 =?us-ascii?Q?OvOe4P4cF285fAXgnuODvCSW8Vtb5L2MfKvcinW/2/F57kVmevT2Ek6dZybo?=
 =?us-ascii?Q?8YmzQvnB/FwcVOrjNA6lq8Jdc8/1o0c3xDb+jWUSCkdwCz46da8XbQpWbJs0?=
 =?us-ascii?Q?f5xPF1haGNlHOyORjIe/p/gQ39tyLOYgTtutVgmw82m8b6pBp64ZYNQRowvc?=
 =?us-ascii?Q?+BtyljfI832FSvupb2iZvMP9Qh5Cqt2UPdOLL/PAzgV9w3PcNn6cik9PbJRp?=
 =?us-ascii?Q?K4iCFO6x84GmQ8bCF4kZvlQuT0P46hwDgXa5zhQ+ehExzuSFMTgyoojt5CRE?=
 =?us-ascii?Q?MUGUrNSor5s8NaZgDvgapgpHhCbhI0uipkJqJt9yJDEhqkY3Ifjmga3iF5uB?=
 =?us-ascii?Q?fqYx3iaCRpcdV/m+kpPz0CgaW14sCEwJ3mKVdI0Ufz1Rtzikz0XcGHAAgefd?=
 =?us-ascii?Q?VQetAg+vVi8N/HGPpugKYMHecNBlGDi94wzIKlABXqstesVanSP/m+aNZgOf?=
 =?us-ascii?Q?eYpF9fsoPPkRTzhMpQCrlQPi/lN+iUiBWD/e1/ZVSwrZLGnDbqhkCS2scjjT?=
 =?us-ascii?Q?iaqX+wNW3cV3LOYyn4A/A9zJL0VEHANtpeFnXaTbsIAdt86EtwRsWIulAPsG?=
 =?us-ascii?Q?SAskZpLDyFMXCGrSzPvf7SqsKIlU2gZkJW+7KUk3AYKeo5MQLV0tOrzCAVp+?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c66c1b-1640-4939-1968-08dcf83fbc7f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:33:01.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAFO0FFXX4QTHl3ROmZHM8aGcg3OFa+bDOpxsFNOJ0vJSCOCGhRH1nj94tl9CyvA+sBRuY379cz8skPLhEhW8C369vrpBSU3MUWooVNXb9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
X-OriginatorOrg: intel.com

On Tue, Oct 29, 2024 at 10:15:54AM -0700, Ashutosh Dixit wrote:
>On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
>>
>> On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
>> > Several OA registers and allowlist registers were missing from the
>> > save/restore list for GuC and could be lost during an engine reset.  Add
>> > them to the list.
>> >
>> > v2:
>> > - Fix commit message (Umesh)
>> > - Add missing closes (Ashutosh)
>> >
>> > v3:
>> > - Add missing fixes (Ashutosh)
>> >
>> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
>> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>> > Suggested-by: John Harrison <john.c.harrison@intel.com>
>> > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>> > CC: stable@vger.kernel.org # v6.11+
>> > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>> > ---
>> > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
>> > 1 file changed, 14 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
>> > index 4e746ae98888..a196c4fb90fc 100644
>> > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
>> > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>> > @@ -15,6 +15,7 @@
>> > #include "regs/xe_engine_regs.h"
>> > #include "regs/xe_gt_regs.h"
>> > #include "regs/xe_guc_regs.h"
>> > +#include "regs/xe_oa_regs.h"
>> > #include "xe_bo.h"
>> > #include "xe_gt.h"
>> > #include "xe_gt_ccs_mode.h"
>> > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
>> >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
>> >	}
>> >
>> > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
>> > +		guc_mmio_regset_write_one(ads, regset_map,
>> > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
>> > +					  count++);
>>
>> this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.
>
>Yikes, this got merged yesterday.
>
>>
>> The loop just before these added lines should be sufficient to go over
>> all engine save/restore register and give them to guc.
>
>You probably mean this one?
>
>	xa_for_each(&hwe->reg_sr.xa, idx, entry)
>		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);
>
>But then how come this patch fixed GL #2249?

it fixes, it just doesn't put it in the right place according to the
driver arch. Whitelists should be in that other file so it shows up in
debugfs, (/sys/kernel/debug/dri/*/*/register-save-restore), detect
clashes when we try to add the same register, etc.


Lucas De Marchi

>
>Ashutosh

