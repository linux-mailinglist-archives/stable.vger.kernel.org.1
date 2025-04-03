Return-Path: <stable+bounces-128151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D82A7B09E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FB7188CB7C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417651DC99C;
	Thu,  3 Apr 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hS1Ai4eL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF581DC98B
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714741; cv=fail; b=HbAepYLjhPIrHQFrM4mp6CqFAhJv/O6CqrKNDnNELZu7Wvz+G267oMd3sOPE8IOa0JgwozESC0evAA+y+5d0t4pUSlNaL1gZoetCDF8XLxJvXcLgXz2Tx5NZFGzD+1GN2dzHr8UTeO4dLhL8EDRnmyq6gFuEzj24qJtE+iFy6mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714741; c=relaxed/simple;
	bh=5Lef+sESicV9FbUQva2M7xYENAPD8j6OHuhBxEiMnMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hsGMv4I+vpWenMturYgf8HnzCJbiwDB+FkqPx9z5RAkH2f5kBDQh+6ysig1JtX7s9r9/gVRUoyEns0T4Tbhhk5jNfKW/tRtEMBGrM0N3Qi1HcZSdr2wFc8B6ZLBkEMGAhf+Zds1O8cgTo/ywbQjYAKDNDBe2EvFGWxQIq5Q/5wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hS1Ai4eL; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743714739; x=1775250739;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5Lef+sESicV9FbUQva2M7xYENAPD8j6OHuhBxEiMnMA=;
  b=hS1Ai4eL5YYjniGdqyv0nNu4Z3AcDLKvcPhOlnqpHtNuvcAww85NEUso
   e+VNkuUtxtvbU0QYKOt9bAHE5sx85VeHWNNFgLbf7yn5T9XAQG5WqAe4Y
   XVPgO9MAr5F/QsBkoTUpesNrY7K8OoU7mheKKE1FZsGTYrPi2B16V+5SM
   nUfYGn4DjazSchsCIBMqbIfN5Oaruj0JbLlwwV8rPnrb64foJRe9aPgiE
   seLe6VkEaIIeZZ/Nr6QifDOAfmsEA+gfLsJNOhNpgr1IeXYXce7/q1acU
   dy1RnpAmLbXPYqhbVW1uVA3zw2q1koS7K5oytK3utd64RaZGSV1MA1PSg
   A==;
X-CSE-ConnectionGUID: rvGIexVaRcmvqX5dsHnlMA==
X-CSE-MsgGUID: omHj9TZXTsq6UXWZSHRtcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45324297"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="45324297"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 14:12:18 -0700
X-CSE-ConnectionGUID: eRRlbyfCTx+EVCB3xizh+A==
X-CSE-MsgGUID: 2gNoTJZCTVOVIjUtraBmQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="128055824"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 14:12:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Apr 2025 14:12:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 14:12:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 14:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQzrcqT49HNqzQQAq26ce6SgkOabqn4GucjVSMYmRnnF4Bd8KkvrIq3DgGze+Gj+GXMC/D7E3IHp7Ik0JulQKPi9ozTaBpdB3ufu2bq5I/PGcQPQl66aZC25tA93FOSnCC05lO7rV8XpQdBsnk3pQ5LpMBerhcYEMe3sd4eUxXtfXWhp1Jf7rVQ9wA5xddzKHMSE5z9wojcpNz1sUquKbUoJ+tMYZWTQtxetEAWfDLQTeL/OBkJXWZph7j8ySUv4vHsMGfLr+8JltyoVoXX9WO52OuOR7sO4sK4wlA1yt8DUSB45ofFJ4irTsjS+sZqGKyEEegFGFUBPF2ZtxrsaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxiIIrjPs7dBR37qvegPPtkF+dAWlYkFHUa8kuSUrDs=;
 b=lJyrLe6NIhYbIurusFCSYiPlrzf9DeCQk/C2h8trdaJHkfXZlGHI2zsSvF5xcR3h1c6btnxn7/COHAVSYzk9NBOBJcAjpo3x3//U2tLhE3vG7aqPI5qVoIcZhFhPaSeJ2XKwiizJLl0qkPiasUjy5KT2M/dAXC0arnBOWyO3/QbZbqUpn3+lD9kK066ZUa21GREuf7PC4L7KxSpofObQShk06JwFZAL+D3yNq1ifQWVSA2+gxQPSSRdvEZYyAnev1e7TSIDQboWdCzZOjg+x5Zv6jV57IPFY1NtTpfY5473JYpQUSHxjGjO/gC6mdwRGT7XkjPfWxifmj6p4c4ivWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 21:12:14 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8534.052; Thu, 3 Apr 2025
 21:12:13 +0000
Date: Thu, 3 Apr 2025 14:13:28 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/dma_buf: stop relying on placement in unmap
Message-ID: <Z+75+NkCaMMYGxc5@lstrano-desk.jf.intel.com>
References: <20250403140735.304928-2-matthew.auld@intel.com>
 <c60972cc-0927-44d1-b9a6-5c8c73ffbdaf@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c60972cc-0927-44d1-b9a6-5c8c73ffbdaf@intel.com>
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: e84d2ac0-b709-429e-7dab-08dd72f4345b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?OKl9yvkLFH80jhMAtsx8zdhV4tR6Lbg8GOOJaick9AgHQf+ZtxYTNJVZ3K?=
 =?iso-8859-1?Q?+C+i73MPKqrt7/8nyooOYGqwWf2I2kBxttLljYJOQ3I6M9W9Ozo2mBaptB?=
 =?iso-8859-1?Q?07D/u4ihh/WDlg1vQM7hNBiLoT1gpY7PidZoU9SgeL+7ncIZ+8zXn9yBoW?=
 =?iso-8859-1?Q?+0aHR3pvnv6um3npPSMXzFQBQWhd+5fc074FeWU32hoRD9n6mIXRhszPto?=
 =?iso-8859-1?Q?/HxjFLQrldpjNiMPiUNJ61LT1+l+KD7LdaO8C+bURYkbVY7GoGh6BTDHm7?=
 =?iso-8859-1?Q?VTcWTGeO0WFoXgqJl46C8gshDqyPl99oUsMMqRcnLIpPP756cmjRPjy+Ij?=
 =?iso-8859-1?Q?3sA7rXnKAyDkwgnt0LA3dgp2HNe3pjrMEvL5hsEc8tO1oMZCbNm8X1mdA6?=
 =?iso-8859-1?Q?fF6slxYUnwW06tNzsBOwbIVMRGS8YbpnBnND6QnLKz38LyrfE3ItQoXUUQ?=
 =?iso-8859-1?Q?bWJN6nnoX7U94FdKamLCGE4B/LRSRVF2IG2Hh7t3CMmenAloXDiVnmzTQk?=
 =?iso-8859-1?Q?N4W2sGAeAJeu3C0iIEugnMNVgKPYR5xfX18db20ALoBpce2o5nLqAYdky3?=
 =?iso-8859-1?Q?JWChSf9MrMjpom3iq7BDR0zw/t/IcmjUCSxJZjEZgSlsIYEEV+1KiGXLOD?=
 =?iso-8859-1?Q?6C+uk8NXZH626MSjF9/fpXXl27sjiZXeXx3noU7QJ6Ns4DDdiU382LDOSo?=
 =?iso-8859-1?Q?vb/um4qPSpO1/mPPwUnWwWM0z5hL5ZPSHgxEOMBgk91r/kXpDVC4uj0fL+?=
 =?iso-8859-1?Q?WwAHlcqWmiyqgHwTmSPYDp123NsgMZQV6/noTptGFg18zQeUy7zmnFX8GN?=
 =?iso-8859-1?Q?57quuTWxqec56KP/lap10n36DuDgDz+lQk+OoA7hiS5looroStQmWxRJjr?=
 =?iso-8859-1?Q?V6wsVPU2M4Toq+rk4/tNqx8LmYSQ6hgL9TsFpQsyaz+il/xPRFKZRJOP/T?=
 =?iso-8859-1?Q?Fkj2aD+Nyhxqil19gfUKBotEYNIEjFwCM5H8bvoZPxa8jqETop1noq3mRH?=
 =?iso-8859-1?Q?ffBu+cf/NMPKyNOEBI1x0xpQ5dUoKTK/jnFrnBp8PscnGXTpOuPRNIFyCw?=
 =?iso-8859-1?Q?JfjXHiXeWy+B/nKOCLf4gFPsT3VTmKcZWTt7nj8LRK/ZK04j/nTNSwQ59V?=
 =?iso-8859-1?Q?YRh7+twcczGkcK94I+oXesY4EaOyzi8oO/Yo+lFLo7+Mnf18hf/KgG4WZ0?=
 =?iso-8859-1?Q?NkQxUNx9/py8nudgL0lKDjDJPPkDoV3amWF7mP5qB4whGENdKgGqizUu4p?=
 =?iso-8859-1?Q?paNdW1LGLCKKQVSLUxUMAPwXm9G7tGQFf1V6LqehLOrFmpAU8jmOz55d8/?=
 =?iso-8859-1?Q?EB0kW/ECoo/Lul1YdbL8AgB1JQgO7ujm2gTScj2HVBPUvMMU8pmW+DMBYa?=
 =?iso-8859-1?Q?k3f17hUVyo4b5+8TVSND+OnoUqNbxbUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aW6CnJBHJmdr4MnCmOsxqqwc3+eN2uZdmfomdGPNvKGhuQ3cJhqhY3FT0D?=
 =?iso-8859-1?Q?ThXAcC5CZgka2BWwr1Uy8dMTMCz4C7UzdLmrt45E+0TDtLKReCieHaZRIN?=
 =?iso-8859-1?Q?YRabhlRTlVmL33Ubf/uefHgyOtMDwKMGRVckHXgur45lDbyLVUh3x3KkJu?=
 =?iso-8859-1?Q?FiYeHCDK024q8qmXGn+6M4mZ099BddTZIgoK/lrSYb34oq+9fJuBkPv6Mc?=
 =?iso-8859-1?Q?Xv6nfUMjPUXDbJdNpCP6yOlruYhQuTXy4Gz0B6n8Kkg7HsF64uQ8LkQ9Zl?=
 =?iso-8859-1?Q?rA2DKLRF3OGSJKa1ICPlz0yUT2SdBAeYUEL01DJgrind4dTOfbdQCG5erI?=
 =?iso-8859-1?Q?LHKaZ7H3/7Y+uGrXVWMVG2cyZXi3bwDqY54oc7WzxTS/I7RD5MNUif2lwc?=
 =?iso-8859-1?Q?M62BYibN2gMyQ+XoZDKxAF+6tsIMTaR6tutewSvFWwRlf+Ox7SgamF6rPa?=
 =?iso-8859-1?Q?eZUWdFxNmvoYbgjPee/9MntGGnujJyLGByVu5HW7KHpN03Lrabp4IkeDq8?=
 =?iso-8859-1?Q?rDIaVXbATCntYlevAqgihvEs52zBUxoxxE+cFABJ+IFrPwqcYiG4k6zht0?=
 =?iso-8859-1?Q?YHocYC1jA4KvlI1C1Di7cj5PReE/eFYONEPaA5kxEJSlx7LFiToK4kvJsI?=
 =?iso-8859-1?Q?fNYbl+ryY4MDbz7+HSoU1R+WiA9S5Q1cuOWh2U1dRKICEQr2DrOtmf9VfJ?=
 =?iso-8859-1?Q?Zgq3drS6sIgcw/pt+3XDztVBebKgyDsBXYF1QNbAbR/1cik7sX4FicjMcc?=
 =?iso-8859-1?Q?HZ/jMDgeQphNkL0kfTjnUZAXetf1/DjwXuEjjn2pDJUMpzQUiJ2lx1OmN+?=
 =?iso-8859-1?Q?mi/hUg2viVscIQKi69tnfTHOkLH3OK4eHoh8tjNmc3Xsw0wAxSxa9p3wB1?=
 =?iso-8859-1?Q?Gf/3u8nxZHcJYrvK6AWfiOsejsqwr4N/H2B4w2AIX13ERunCaAsvMxgefh?=
 =?iso-8859-1?Q?8Ice/JPQWri2e1Ce9Yt3pt9xM3RiGeNJWICd1JPUxueS90Y9z1/soGH2XC?=
 =?iso-8859-1?Q?+jXpQgptm03TTjAJLEEMi2hrNllLj8lNa84DVd8JSz7XiX7gXyTG7QAZiJ?=
 =?iso-8859-1?Q?hkr1WYzQ8TWR7NWDYpJWYgDgUlQ2HKXQuBuaXacYgOotkR6DztS9AyA9wg?=
 =?iso-8859-1?Q?dh7AB+AWNEwBWXNfpGHqQNzaFNdZoW9LoWzMigZEvF+1JoXJKb/VEBZMCO?=
 =?iso-8859-1?Q?6r2fOgkQ3ExBuNsfUcHX6lwv5SUzLr6ozDiBXhF8JcBwL0gbSmxH7Jyci3?=
 =?iso-8859-1?Q?EcZt2vbpQluaKijHgdNDmxfBV2rL6Rbm4eiJGv3dJvHxCncYI2AEiDQnTT?=
 =?iso-8859-1?Q?jSrqtq+VzNjFxcSgmUsVm3EdUkWdBtlqJN3rsMxKxGrouGhztGFU1PwJHl?=
 =?iso-8859-1?Q?I/IY7sGJJ/tzNMy9gTPoArTonHo35tW1ZgNKDu/RBD9ZoMAi/oZqu3yfWP?=
 =?iso-8859-1?Q?8Ij90Z3flLFE3UiK3MHXEHSfV4u2/sGCkzaO633dD+hORsA6Em2XdcwFTl?=
 =?iso-8859-1?Q?IQ5ZSKe7BbofYokvGx52LIpPiejYdRcQSk4ySwhM/KZ02mmhu38aqh6ZeQ?=
 =?iso-8859-1?Q?xuibipQynSG3TzGS4hDFknWG39ouUPKfd4yN9YDDB/96QkvuiI9fxhJqLZ?=
 =?iso-8859-1?Q?hdzEGh4xegGIwb11V9P+ObkPxH2XctcfIvIg4H5hD6MkTW0s7Hi8viPg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e84d2ac0-b709-429e-7dab-08dd72f4345b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:12:13.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJGIegyCQwbXTXLBmbi5AYJUNdLbnx33h+wGHildbFwOSwdhkGPRVIk+mvj1g0tQj/tVo0wMA5QhdtV1Hgx6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

On Thu, Apr 03, 2025 at 03:56:38PM +0100, Matthew Auld wrote:
> On 03/04/2025 15:07, Matthew Auld wrote:
> > The is_vram() is checking the current placement, however if we consider
> > exported VRAM with dynamic dma-buf, it looks possible for the xe driver
> > to async evict the memory, notifying the importer, however importer does
> > not have to call unmap_attachment() immediately, but rather just as
> > "soon as possible", like when the dma-resv idles. Following from this we
> > would then pipeline the move, attaching the fence to the manager, and
> > then update the current placement. But when the unmap_attachment() runs
> > at some later point we might see that is_vram() is now false, and take
> > the complete wrong path when dma-unmapping the sg, leading to
> > explosions.
> > 
> > To fix this rather make a note in the attachment if the sg was
> > originally mapping vram or tt pages.
> > 
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4563
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > ---
> >   drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++++++++++++++---
> >   1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> > index f67803e15a0e..b71058e26820 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -22,6 +22,22 @@
> >   MODULE_IMPORT_NS("DMA_BUF");
> > +/**
> > + * struct xe_sg_info - Track the exported sg info
> > + */
> > +struct xe_sg_info {
> > +	/** @is_vram: True if this sg is mapping VRAM. */
> > +	bool is_vram;
> > +};
> > +
> > +static struct xe_sg_info tt_sg_info = {
> > +	.is_vram = false,
> > +};
> > +
> > +static struct xe_sg_info vram_sg_info = {
> > +	.is_vram = true,
> > +};
> > +
> >   static int xe_dma_buf_attach(struct dma_buf *dmabuf,
> >   			     struct dma_buf_attachment *attach)
> >   {
> > @@ -118,6 +134,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
> >   		if (dma_map_sgtable(attach->dev, sgt, dir,
> >   				    DMA_ATTR_SKIP_CPU_SYNC))
> >   			goto error_free;
> > +		attach->priv = &tt_sg_info;
> >   		break;
> >   	case XE_PL_VRAM0:
> > @@ -128,6 +145,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
> >   					      dir, &sgt);
> >   		if (r)
> >   			return ERR_PTR(r);
> > +		attach->priv = &vram_sg_info;
> 
> Maybe we need to subclass the sg itself? It looks possible to call map
> again, before the unmap, and you might get different memory if you had mixed
> placement bo...
> 

I think that would be a better idea but drm_prime_pages_to_sg allocates
the table so I think we'd a bit DRM rework to decouple the allocation
from the implementation. Likewise xe_ttm_vram_mgr_alloc_sgt for too.

Matt

> >   		break;
> >   	default:
> >   		return ERR_PTR(-EINVAL);
> > @@ -145,10 +163,9 @@ static void xe_dma_buf_unmap(struct dma_buf_attachment *attach,
> >   			     struct sg_table *sgt,
> >   			     enum dma_data_direction dir)
> >   {
> > -	struct dma_buf *dma_buf = attach->dmabuf;
> > -	struct xe_bo *bo = gem_to_xe_bo(dma_buf->priv);
> > +	struct xe_sg_info *sg_info = attach->priv;
> > -	if (!xe_bo_is_vram(bo)) {
> > +	if (!sg_info->is_vram) {
> >   		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
> >   		sg_free_table(sgt);
> >   		kfree(sgt);
> 

