Return-Path: <stable+bounces-127438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23675A7970F
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625411893AF6
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124F1F1936;
	Wed,  2 Apr 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN38kldg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856591EF0A5
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627895; cv=fail; b=RK88bbJv/PScWFxdmkRwl8F4+3UtbMPCoMrzOdXE83JQ3dFaTrdR+RoLIOEOLMm0S8aUpp1p+HibFM6uilr/mwUgkAE0y9bH0UU98DFUHa+1VdwTTdN2lUdyaCN3OPB8eEOCcuHgy4Wz1uxUK7C3Sq9XcXtSMNMM8M0db6rRcLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627895; c=relaxed/simple;
	bh=vcQf4ZLR7pTX5QYJRhE+XgegUNWxHgWEE1Txa07FKS0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVqr9LvJIFKOKXLAl9GeaiKFVvBKaQLwo6PcElQp+cppm7Ryl3b46dt4FqnjEpGw3Ajh5fdb5UoLuSwoq9zT2fTD+lRNJ3Rpo/aJSAETIRx25eXTJD80Ojf8FHY2sPIyAKdNaWJVg97ON/HECEOyXHHxOg6ASy0tyo2oCBG3opo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN38kldg; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743627894; x=1775163894;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vcQf4ZLR7pTX5QYJRhE+XgegUNWxHgWEE1Txa07FKS0=;
  b=AN38kldgvdZPK++gywjSn+lVYf4OIKP/Tv6bt8sVKnMjz7tfqjjnpvAS
   AhZbnCUTX4+VLXvcFpUj4SzJ+UgpUOmBd1fHWtY/RRmpgD159nFrQgVvQ
   WDGPMWQd62rZ0WtsARhEy4WSZ3r6xWtgDaTGw1m0oI+jCzJ2dVH8EblmK
   7SA395Pi0A/wWGsoKiprN/iYr/Yuf8Y8SAplWFsMT13NfWIX4jhqKy23G
   c+yn6+euZRYOxNmTYEhfe8Bc/Z3s0QHCPxClaxP7ckkYG2Tx1dZbsuGH1
   NAbE2/rr+Hh0FzHZr2zeJf2cgkm/fQBpFdJChXdh0P/35m3oJ6zcB5KxO
   w==;
X-CSE-ConnectionGUID: RQmhp3wnQXGuvak71ywbcQ==
X-CSE-MsgGUID: OsVLaDQSTnyDmr5UckHgTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44922162"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44922162"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:04:53 -0700
X-CSE-ConnectionGUID: UIh8iH7oRS62NuGqCPsC3w==
X-CSE-MsgGUID: NLldF99OQjGeZjmqSQM1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="131671894"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 14:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 14:04:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 14:04:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 14:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t78Ic4NWUURuALXGAR8FBob6Lur9dRSx3v9arhwFgf2kfqoaiL6rfJkfHgeEVgsjKcchPpPrrSq5vQbZ9WMmq0En6frLTxakGNwyD64XXRKwdiSP6Ek/hO+nxhWu80X/yMkil3ksVmxV7cZh8d6x0pb0DJmHc0Tjnvl3Hg5qVtKQUiJah2ina6WIY2wtGb+M1qiOuWX+PzwWf8MNn2Mwp9Td7QyjCZPjkHRjNx8JAQ+fsUp/Bal2TR/bwyKMpPYnaTfHoofoM0qmFEv7OhJ3tQeCvYcyXbXkeqOTcTp286n2CD8NnoaaKFAqRderemD4+4B0wrUH4CsZd8nvDGQVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBUVWz3wZxhdSFAmxsAsLpdaFhhW20TgMNnHn/EDmhE=;
 b=PPKoCV3LrIu3hUtu3c+J8HSP33u8NLFkgLLNUX7pYqd0Nur8A+iv4r8JU6Vwd3DP6o/5PeJghwb38IIVEXhYLu94+QpWqhHyzvK7Wjqv4to8clwhRO3rkHQFdJrudX5FOv+6H7Pmmy5ooigBGoFbdSB7NSPVIHM6Q908IyJbPEqySxgpTAGb/9Dwi7Tl/2bEl3vLvyox3ds7IJfHVioXYPoZU8HRUywGcmlBTTifwPeSfxcMTDkHvy7grfAO637xVwm3aRMlW5CBrNfMcN5l/RgdddF3RXgYbNRlv1pHXOpp1PHK2Zd0OFdcu/UcamcbjvQYSdtWuopr1Q74iTm2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 21:03:36 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 21:03:35 +0000
Date: Wed, 2 Apr 2025 14:03:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Naveen N Rao <naveen.rao@amd.com>
CC: <dave.hansen@linux.intel.com>, <x86@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <67eda624cd1b4_1a6d9294ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <z7h6sepvvrqvmpiccqubganhshcbzzrbvda7dntzufqywei4gz@6clsg5lbvamd>
 <00931e12-4e6a-9ec4-309c-372aaee333b9@amd.com>
 <d440f49c-ab2f-4cb8-b822-362f757ae47d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d440f49c-ab2f-4cb8-b822-362f757ae47d@intel.com>
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: f53a5fcd-67be-40b4-ded6-08dd7229d55c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QrekyNSGPOjtw7ryqWCpG2X+Sx3Ly7D4u6UdJPTUoCQD6jQc8/ap5Ec01+FM?=
 =?us-ascii?Q?YBP0F/xLcco3M9h5HMiDB85xqpveTOUMEvCgdEtfaVEz2xQs9NXcisehuVu8?=
 =?us-ascii?Q?huaAp6Ku2clwEXCxh+tTzytJ0x+R/c8EdYDelYAovT55dcPHMyh48G4GF6Af?=
 =?us-ascii?Q?FPXiqGVCGl3037jMpMBZVhGuYbqnJaeI7L/57oYUY3ea25yF9YpM2tfiIAih?=
 =?us-ascii?Q?BenFPAN2s2U1t3kyX//jcxLBVXNmBnW8VS91Kv2UtUNUgFz0WcKyW4VYJKA0?=
 =?us-ascii?Q?dMiLRk4dkJNg0S1CByP+YBizvcneFwyJjHCspYPTNj0YXi+EFcffDgwn8q24?=
 =?us-ascii?Q?NIjEi3oj7Spp6TYu+NMjGAwhGRZP0kv1qC/FGD2d2S/B/iMCq3q2JLtBlCQp?=
 =?us-ascii?Q?8OWf36QF7aRh9TQv+hN8Kx5vEywRv8rBxNs9CGS3x9zS2DjFBIgQH0D9TSsv?=
 =?us-ascii?Q?04R8b7NlnCZDffEu1HasU7MW+aXTJIx2l+Wh802tZtInDAqo7c0WP9KaWARd?=
 =?us-ascii?Q?avC+sxHB4Emzq96liLI3zKUw+MdAkHyuUTLJTtguL8YexdwkmqbPBAZCG7sB?=
 =?us-ascii?Q?9866HQ9X03aa9+1MVLouGnGxHVc+Q4e8ILyiDbLzQNY7BKwFx+oxx8bjMBud?=
 =?us-ascii?Q?mcFOS7qMa8o7Zi9lDVNn5Eant3v82FbAPGM2euZ7wyW1dXaAPNxiC65uaKdJ?=
 =?us-ascii?Q?fqhaX0hz7GHm/SW8YYNq3ROuaGXcFVCpg16V5cc3lAKvHuoZrqVHPBWHDA20?=
 =?us-ascii?Q?uhrJcufii1KGHRMVIEWI9RGUKvY3usu9v4lSLxpRq7jydnl/YFn19bhX4ykz?=
 =?us-ascii?Q?BTLiWmHVnaZZUqsUsSzH0NX8OzBhZ6fNOesmZ/hJrqLfRZYZPWY0EwZYLkDz?=
 =?us-ascii?Q?8gMlK9ymBR81IvgXy/ZIfdGMAz61zEMTxXyNBQuKfNtA5Egvlt6di1+k4DIt?=
 =?us-ascii?Q?gDwI7FasxgzK4oHenmZhTSHKfZHturbQ+SmTiEJBR5c9bpFnvi3DUM562m4X?=
 =?us-ascii?Q?FFDcSttSmj07T1gx2SoGlcBzxPFzS4ZqM73gghK/dQ5b5EIXfvc7aN1NrnOG?=
 =?us-ascii?Q?G4ow39XgPW2moOdZnpok1/klQNhEHsN/oC7PvglAA263kw+ZBjn+VvWsS9H0?=
 =?us-ascii?Q?pxaJQxD77pimD4l71FbF8rkwy+ZR/3UVZ81zyA0dccoBuJV5oDZ8ggo0Vdjr?=
 =?us-ascii?Q?psAoPMjuzr7HCgLVprfpDQwBdAG8znfydQR/7NqWt9iNGkNB1XIdqkQexnZE?=
 =?us-ascii?Q?oNTwmayfVGnVjefEkreCsF95nLUhIaA52eC4Ydbbb5pMH8L4H0ubdKGqn+mK?=
 =?us-ascii?Q?t7j9NMooa5MFUWwxKPZQl/KEdzN5pqACLTkJM9WDKTcFtfi6MAHU65nutlUB?=
 =?us-ascii?Q?MoEvL4bdwPCO793xDzzP1HJjEbiA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U9LvD0N0GDb+S7Q2I7ZuvJBCHu5TiVVsBNmdvZbbYDhPcGjtEbTjdpBRULsD?=
 =?us-ascii?Q?1hlny2NQZVFwojGdWfMSs9ZyAsg/CWqlloDTY/Q/7CM4LuSFHuQyrmv5PQp2?=
 =?us-ascii?Q?v70MrcTAmkd/Shx4HvAMjQxGOjVs17KHJZqocR6SkIa6QOOpK7QVpOzc/5WS?=
 =?us-ascii?Q?8/hA7nwtvg+R/4QB3RVEKwx+1OJ7WELE1qhJyOWWyvNdRu83riFE0YPVS/Is?=
 =?us-ascii?Q?Kdzg2znLErmYxoqv2fvnHoeM3VIVKvJwcy198grVYKuvAXuvl7ZjjcVm3THG?=
 =?us-ascii?Q?o7KWJIRf0nHr6risr3j58TOBCjWg2m1eqjqljsnsTnE2hItaVI7SpP7hVl1R?=
 =?us-ascii?Q?POjgB5Po1w3mp72EC/09syxDB6lmdpiV5zd8D1qBVvrFsESA8z+8mPpBWPYG?=
 =?us-ascii?Q?qwh/mcYfQzjRJEPhqmFpufQD6KsnGxlPW1dmmol44JwE9YFgWQzex1FV0Tg4?=
 =?us-ascii?Q?3n0+cDm53HeP0uMyPZqZnXZnzeslsEHDzA5I8r1x8CGcfmaz0OvJzzh0/b3C?=
 =?us-ascii?Q?YOfG242fc9gOes95w0ainxcPjljB7xgiF+B4G+qDtF9p8qNI/XDpxmxxX127?=
 =?us-ascii?Q?6Qb352aqqbnyoDDoGl22/3LHEXNj5yC5PlcBj5t98nW9FmdTh0lWFdKx2lgX?=
 =?us-ascii?Q?KOjCSM9Oz4EACqgJaX9HlSVgNZuf8e1xjJJ5nZjEiFRdvvqS2KLMjiF84sO0?=
 =?us-ascii?Q?SrIpSgwIUpKKF1SHYxtukhjQ+hkhgtJQcJnNIJw4EPa5JNHwdQ5De55VS2B/?=
 =?us-ascii?Q?4q1w18LDNQtozjXxFK6qY4oa/Fyh4+T9dzV9f6eT6H/zenB3BlGDqrS8rpGk?=
 =?us-ascii?Q?0Ljkb0WMenBM10KbjfEeXwIJ+JrfhDhZCLWANoChNqPpOYuREHDvy7QlLiLZ?=
 =?us-ascii?Q?//SCVLbtjvq7NGHRgbOXYD/1P9XiHhjtW+pooxAG0yY+NpUyf0/haqU6TUJp?=
 =?us-ascii?Q?A5I5eQllUhsb6idKV5DU/0fdVkc8Ezs6Zo0ij/y3FSxQoWGYn8oHaBqQsb1U?=
 =?us-ascii?Q?151xfrOxxTW87Kw1bKz4Hrho5vsxVn0rQbo7DOuzHAZ6LEMKm+BnP0AbGFvY?=
 =?us-ascii?Q?tm64SEd4IKuywaf8hle34lBNQyGrZnFXboiRKWRJuGAkqx8OBwlACe9xhYHd?=
 =?us-ascii?Q?NVFIYLnavea2cSM18tPnTSgbzJq/R6ebSvY9z3SbBP1/UALNFJ4GxwtvKmqv?=
 =?us-ascii?Q?BtJNglkfA3yqiaOI+R9EmaNlvS7MqMaR+yke8rqxBKOXe/qq2DvjmQpawZMC?=
 =?us-ascii?Q?1fPS2X5V/it85Wd7lOuEWaJp7QpdhvjIC0vf8FkT7luP25pj8AkNptn1QFy4?=
 =?us-ascii?Q?9qrsmAr0c/A/S8P+AW7rQ7LmMm7XVNQ8ABkmt2Cp5GgsD01Bqbq1jIGEyV93?=
 =?us-ascii?Q?uqoYefye10eCkByJz58tB6Xg/g0mqUVaUbQnK4rcZFFvjIqAbu+ib5eHOqlq?=
 =?us-ascii?Q?5SePgpevbv96bOYEbdWrBrVJpDsNUyCnm8/+fyH4y3Rg3Hpd3NUVAt4avec4?=
 =?us-ascii?Q?TJDkLocEBLBihZX4/aE5W5fmUJQIlgDS9qTDyVdGgLWSPttBC+P1/xeBnD9T?=
 =?us-ascii?Q?DhfOcyKZu1gcPl3oYlMZjQBUM7XciHL11VUQwVcIqdOa1O2Bwuhji3yp4ALx?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f53a5fcd-67be-40b4-ded6-08dd7229d55c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 21:03:35.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtG8xQKt3zwiyd1M8OYXgWmpcwtoKJo5HbxBvzEMsd9+cPQjO8uO2uDePDZ186yvHZzZ8BpeUc2J/YDdqTht0+cjkAiowABhz/vzN5mIzdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> On 4/1/25 08:07, Tom Lendacky wrote:
> > I haven't tested this, yet, but with SME the BIOS is not encrypted, so
> > that would need an unencrypted mapping.
> > 
> > Could you qualify your mapping with a TDX check? Or can you do something
> > in the /dev/mem support to map appropriately?
> > 
> > I'm adding @Naveen since he is preparing a patch to prevent /dev/mem
> > from accessing ROM areas under SNP as those can trigger #VC for a page
> > that is mapped encrypted but has not been validated. He's looking at
> > possibly adding something to x86_platform_ops that can be overridden.
> > The application would get a bad return code vs an exception.
> 
> How many more /dev/mem band-aids will we need for TDX and SEV before we
> just throw up our hands and turn it off?

I think the problem is bigger than this, we have no data structure
besides the iomem resource tree for maintaining mapping consistency and
this problem gets worse with the impending TEE I/O work where devices
are going to be dynamically transitioning from shared-to-private and
back for their MMIO.

> Maybe the x86_platform_ops call should just be "Do we allow /dev/mem at
> all?"

At least x86_platform_ops is the answer if TDX and SEV-SNP have
different answers to the question of whether the first 1MB of address
should always be mapped encrypted or unencrypted.

