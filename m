Return-Path: <stable+bounces-177773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B9B448CA
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 23:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D166E166BE3
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E2D28FFE7;
	Thu,  4 Sep 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kM8lRk80"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B1BA4A
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022505; cv=fail; b=t+H10YxWTAherncaQUmnVYgv6ynk+8IDve/7pcDeZQOB6Qui7h4BTS33saaAcWaXprEOahYBMfPtDAC4Myh6jehOqZ5/gQRnwOB/KXFRVcKhf5boit1ZQhCCRRoaptwmD2Y1rr8wwLVHVR5JTeN8Z+batATwqNkJTkmdUWCJHRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022505; c=relaxed/simple;
	bh=+CGDbe0dgZESqVyp8MO8EXHjG22CjsEmNaxN9oJO5/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qq6ayPkvKdjZCBgK10liDEvsxFyo4SUUs/G5EsYkj1AksgrUlNwnWR0PfoYMRHs4j2q/Uy/PG43sO8ltA25etiMxbJ6fnynGD9WsCqjltG5lVjfnCJbYpL/3jrdG6fBrHBxe+5Dg0tEa+A8NyvZu0o0Qm0eSQUkqAPhX360O99U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kM8lRk80; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757022504; x=1788558504;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=+CGDbe0dgZESqVyp8MO8EXHjG22CjsEmNaxN9oJO5/g=;
  b=kM8lRk80lqv1x5f5Iv178sBZovRHkKGOqFkIutAms+Wy0rSz9GxVejOt
   AiEUJq3EE3P1AyoUnEzT4JZyBC2vW22GSFpuhVNMTs9a6KEo2gC0e07e8
   sGvoTfrFc46ofwU0vcHgdOoQ/AC0z7iPfXccMuslMlmKsYDCtf3Tq5Wug
   t45uznFED/9ad0hwvMB/KKjc5sc1yMlzkDGHH1yEdy71MYQeiOxDTYl58
   eJ4Gyzvm3YxSTuvPHioWAf1g4ni77h/1heLNx270g18VLQjI1rJpOK6UX
   ipXtQfXh7Vvd+l770Mm3VnebOXcw4E2n20ty9AxjmJ5fmQwiZmhxLtj6E
   Q==;
X-CSE-ConnectionGUID: 4p4C9UcpT9eUU3bZOIBY6A==
X-CSE-MsgGUID: UodVu4phQ3yqL/aOgLzBrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59296432"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59296432"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:48:24 -0700
X-CSE-ConnectionGUID: Wc2FnocJRWmGxNcHMYvQGw==
X-CSE-MsgGUID: 6p1mn0cQTg+zpGUEZ3zAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176341332"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:48:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 14:48:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 14:48:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 14:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbF/0Vi0QIlR2ZFiT/SCTN5NQxn5CZlU4xo/yt0mUECtcnOOYfv+bb26994hazdppF1NcUxDZRBVFEKwOuSmXwYeK5sPm0dgBcjiqMEm1UU2vapJTeIJmwdMSGZd3khB15JY5EYPNb0hWQm4M6wpm+m6od4dR7HEN1UHb33lX7ONPxdgSZzHRji2UPOWkAAFpxQpIouKIP1J9ZdR9cGgOYoBTT39sf5YuMbnJ94pQzz1ESCPGJjRJTFE6Kg1NuoRTgzt7dkiRpPerPGDVdrSmq/d1udRoZNZEkK8bI0uoir++bC+4y0fzGwh33Rn5l7+ktu94EmaeWQpVIUgPhb2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBOU5GoPA8HnR5W9hJk+XE4+RTAI6l47skgqsmabmvU=;
 b=aypXk8fiFw/mtFYT9siRspuay+EDzrAJOva4/qKi71eOSRmIkTPCtXeorvoFoamULMMEZHHHOrZ33EKwkT2aJVGvaTnTWj2RoPt9md/YUF9VIlPB1x7WwPw4cPz4RnAfhHW+IWO894PfRP0OmCgFG7FMmIHbbpm+iYsH16rWEPCmJgkeKXOEGnmInJqPIFkF4O/xHCwrD/2k23urJuzASOVRHLmKCvzWUQSwoy3ixLqwmogBsixJagFkHtFMO7EK4KARBmkifI02Md1a5YuixdOCfDGTFDIASluC381O0RZhARsY6j8C9uos4sFZ9ibW4idX0mjY66lL2tNJX7jOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10)
 by IA4PR11MB9153.namprd11.prod.outlook.com (2603:10b6:208:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 21:48:17 +0000
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f]) by SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 21:48:17 +0000
Date: Fri, 5 Sep 2025 00:48:11 +0300
From: Imre Deak <imre.deak@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Sasha
 Levin" <sashal@kernel.org>
Subject: Re: [PATCH 6.16 139/142] Revert "drm/dp: Change AUX DPCD probe
 address from DPCD_REV to LANE0_1_STATUS"
Message-ID: <aLoJG4Tq4nNwFLu6@ideak-desk>
Reply-To: <imre.deak@intel.com>
References: <20250902131948.154194162@linuxfoundation.org>
 <20250902131953.603872091@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902131953.603872091@linuxfoundation.org>
X-ClientProxiedBy: DB9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::6) To SJ0PR11MB4845.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4845:EE_|IA4PR11MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2168bd48-8eaa-4f8d-429a-08ddebfcc193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6clFN1RimHSsq74LyR9NMWK5y6wMtDK0YV+nayJ+jh3hSKJV3xNgd04RS/6B?=
 =?us-ascii?Q?ML/V34AD6Kq7jG3X1iC5KUSytqOcQRWnHRzUrzXP8w3KM5oqsOTrqOSCZxyf?=
 =?us-ascii?Q?IY/reNhj1apd4p8A0B0fu6/dz19htOWkdfWFgU1IV6ZzDmnGqZ9/HdNeeX+a?=
 =?us-ascii?Q?lINbVcnCWODUTaN9K02xZeOzt1/ZsFHNtRWwgC1kTt1nnTtoR/9aUJdB8zOq?=
 =?us-ascii?Q?Bz8IM+8s44FmVc7uYT4JpqrVye6pt0I49EtK/Via2bba3b8x4gMs5Y+FypUp?=
 =?us-ascii?Q?OphwozOYSRQSda6NDfTHt7DEsFS1nqZgZnUvfxV2CziY23wfJDuS/p6Rtnkh?=
 =?us-ascii?Q?7qevZeGtT9XomIIfARxVmWmpye7FloPkaxDek4H5tbMvC4zpHPyqsyLsVw3Q?=
 =?us-ascii?Q?KVPyUVlfSRuPkMHY8t6eB5Fb5/lwR+xiz9hzag1RU+v4Mu6a/7W3o8EDozha?=
 =?us-ascii?Q?sH7Gi5vAU47S/fwwumM9oYzzdq+lE0ygCTgCFxwEC81Q8qOLiUbAwlknazuN?=
 =?us-ascii?Q?NnJ6eEdsQ3URUuCfAhucIDnwJo7MQDlDQnhVYbgL0aploHaoZ3c5B8x0AyQ+?=
 =?us-ascii?Q?oVq7UfP3tP0zqGYzxVfF5/9MnUBQPd4E3gBbX+0osfU/LFy/MdoBTja7N8eH?=
 =?us-ascii?Q?j3UYJdB/vIw1RMrWCdJUI9VLVI0I8Nk1QT43qXtqopaAAgCP7rlL2x9TBrmY?=
 =?us-ascii?Q?Ot5rZiRTkTD3HLu9TTmmzUeVzBfJjwax96zZWr6LMgjhu0ZNXoXnf5jCFa6k?=
 =?us-ascii?Q?SZs3sro+DdWEvby4n4oRE2RcQFj7D2HYgqgBS+enEbfGnKQs8OSWFOZQm+W1?=
 =?us-ascii?Q?bLhl4ZsIpxEHe+1A2FsgtkP0CoP2W8wFiuayoRIuNLTX+I02DfjYay/z3kaa?=
 =?us-ascii?Q?CKhfEs25J9m2Y81B8I1IYzt9AeqNTGH2/xYMy+B1gX2oPV3X1en7Xr0LYL+T?=
 =?us-ascii?Q?1Pz9/lgk3cWJQe+pKMUpAjRullOiKCDqq+1UpNC0yO2y4XZaBj6Ha7WLgTBQ?=
 =?us-ascii?Q?bi0Obq2A8DgwWC1cV5Xy8KO8jeRByBaCc1vC10XO50O1eS4JEajd1dIaVwRO?=
 =?us-ascii?Q?peo4WyuvK7FbdWcKNkslrLDJKcgSioYsZB3Za2t/+2QhFYeD9kCJyb7jL2/U?=
 =?us-ascii?Q?VEeuCh2EqmBjeZ9ApN0/aHX83puLpt3AQf+OHiF4LiDZQLfd0Z6eTYI+VCwL?=
 =?us-ascii?Q?1znoRgjWK4RlqPB/YfvuhvxKHkhtwrjAVJW5sUSvhshw9oi/OV9Hq3zCqZOr?=
 =?us-ascii?Q?nHyEC8keP6jXwTVnvt9Ph0QdiVb25e+Y0EEm9xmOQbnxy01HDMDFQKz+732Z?=
 =?us-ascii?Q?blE+VhiAj1uyfh6dmiEB3Jp48rvEjCg7xQzyoJbiB6kxDtzWCFVbkmRR+PpH?=
 =?us-ascii?Q?jxxFgfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4845.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3PVI/JmPs4dNXHj2rDuDQ98vmj7KFFo3B0AgZvWP38Nll9rKwABdvzMkzP6?=
 =?us-ascii?Q?Qj0jQvjKznbMerD+W+di2BEyQuRbFF3HkmzrSbQ/7Zc9Xg7fKK3CM0v6Kwa5?=
 =?us-ascii?Q?7wiQbrFUZq2E046Zswvc2x/ue6R9bQsg5OmUahdylDVw+6TokCUcLBoTo/xN?=
 =?us-ascii?Q?BWPD8b4M0HdF88mityEosyijT0i62WsgHRxPQ6edrAN2K6J5DsvzVa1NTXWY?=
 =?us-ascii?Q?LEJXLJxmwy33uEgUVpV6Z8QU/Jz2fyZl0PdpRg105LDAshIZnneRVqUF2STr?=
 =?us-ascii?Q?o3MsNfWEFDkq4uHqby2ezg1whvwk7qVBr9nV10ZiLQHe+ozTLo3Sxql//K6e?=
 =?us-ascii?Q?+rbRK7oDjqhzta4Q7AyPHeqH6L05pK0/DXMOZxNh6sgevPzUEiFs2zoawEvd?=
 =?us-ascii?Q?TjynbOkFUP3rDUhmFItNIdx5RkpiqQSxGOM6WtyAF2Ec0OjOmWitheudYqNF?=
 =?us-ascii?Q?w/CL0Yml+JOvsfbbHCLlBkZRaHUb1PYdfC05Hz9GeCJGT864cyd2hs3r3GKC?=
 =?us-ascii?Q?vGz8AJLL3Usn6RH9jt0B1twc97Zgysbd6dBdQBuL0EmDvJW0qlbHZxxtdlw1?=
 =?us-ascii?Q?9kzw3787UDP+na1vPNiWLlM1qxcTrFVaZckQIZldTEqkjG88Tbclyjj/hRgy?=
 =?us-ascii?Q?hEgV4BWWWgQAXSqHEb3xfLxysrCRuVEiqr5sj2mUU3V/TCJTyERv5PeTeUyP?=
 =?us-ascii?Q?MRpzaXs3Mfts9xpmwivdQrW5F2i1miXnZPzJFI6FTIs3hL/NDTYwogmLM5Ka?=
 =?us-ascii?Q?iEFDffQKKVuTiME0qcr503WHzFXCKby3dZfgPdpEEei9xCBigaitz6PSAyjP?=
 =?us-ascii?Q?+Q0hveTa8y8CulKHD1317p+0BsjlkfwXZT+CKKKaRv4/kYmomUJeXTv1+q+V?=
 =?us-ascii?Q?TNi86EKNsfRdtQzDrMCrFLVfnVMcUexwmFNOfuqD9NopKGxmRgkeSM4djNI4?=
 =?us-ascii?Q?IHuNBtY+KVr3mdlASjoqTJzVtpMkuQ2gActQmtO4OWFyvaZcbgvMSn/qdqN5?=
 =?us-ascii?Q?zE+Ve9sW2onlZdEBBXMZbpJinho0Xy2P+BHKgT0VY67woo2s/bnbuy9+XEKT?=
 =?us-ascii?Q?4FOqoBU86Tcoxtx/55P6X+ggUxAGpDurfM95Tc68HfoHjX6bWtQsX6etWxDZ?=
 =?us-ascii?Q?dWkU50QVyN6VhXbF/bDhyUiWag1eHrydmmke4qxgvzjj02Fj0gskh927+yNw?=
 =?us-ascii?Q?iWvs3ND4B1ecq49aZm0Zv5Ihniovu1bqlkoMWhenPBGukM3BU3Big9P8HpOU?=
 =?us-ascii?Q?WqEUaMombWz2BjKQgbB63Tl8A8wpVHd1sF+Mvb04Fbr2IQNviLgnCt38UfN+?=
 =?us-ascii?Q?M6tyP9MKqMAtGVpxoZwRccENULCWD8gHEyKMwjZLmfHUAUjt2lYLkqbNOiS4?=
 =?us-ascii?Q?GoqIE9XhPuiKNDGYPKHO+q6xdqmYJLS8TgHIeL8Lw2E4ynvf3b/tMjNrZPDV?=
 =?us-ascii?Q?M4jG/Mbz7iEvwFLnr2Azt4aScUSXh5X0xLyP8Bqkga7ThpM4BtAXyfPIa9U0?=
 =?us-ascii?Q?uBZTPUqvX9/07Yj8NGo004WxY46vVyf6twGQcyjEHRMDzIrGG05qQfd1Ehgn?=
 =?us-ascii?Q?EOgi5o06gQMXR+MPgp4ySHXjO9bVadT/APzFXp5WnXL3KXbFmT3eZmHM5PBk?=
 =?us-ascii?Q?X7g7VjgNEwThAAfHV65jvfdS7HfAmGnKFIhGkopVm+Om?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2168bd48-8eaa-4f8d-429a-08ddebfcc193
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:48:17.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GszleeVQcOm/o6ZeAzoG7TWA1rX3+J6HrVOMxo9dJF7Cv+kmxCEirdrokWnH9DFORDFAmxq7VG3h6rW6yuQCMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9153
X-OriginatorOrg: intel.com

Hi Greg,

On Tue, Sep 02, 2025 at 03:20:41PM +0200, Greg Kroah-Hartman wrote:
> 6.16-stable review patch.  If anyone has any objections, please let me know.

Thanks for queuing this and the corresponding reverts for the other
stable trees. This one patch doesn't match what I sent, the address
should be changed to DP_TRAINING_PATTERN_SET not to DP_DPCD_REV, see
[1]. I still think that's the correct thing to do here conforming to the
DP Standard and matching what the upstream kernel does, also solving a
link training issue for a DP2.0 docking station.

The reverts queued for the other stable trees are correct, since for
now I do not want to change the behavior in those (i.e. those trees
should continue to use the DP_DPCD_REV register matching what's been the
case since the DPCD probing was introduced).

Thanks,
Imre

[1] https://lore.kernel.org/all/20250828174932.414566-7-imre.deak@intel.com

> ------------------
> 
> From: Imre Deak <imre.deak@intel.com>
> 
> This reverts commit 944e732be9c3a33e64e9fb0f5451a37fc252ddfc which is
> commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f upstream.
> 
> The upstream commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f ("drm/dp:
> Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS") the
> reverted commit backported causes a regression, on one eDP panel at
> least resulting in display flickering, described in detail at the Link:
> below. The issue fixed by the upstream commit will need a different
> solution, revert the backport for now.
> 
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Sasha Levin <sashal@kernel.org>
> Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14558
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -725,7 +725,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_a
>  	 * monitor doesn't power down exactly after the throw away read.
>  	 */
>  	if (!aux->is_remote) {
> -		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
> +		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
>  		if (ret < 0)
>  			return ret;
>  	}
> 
> 

