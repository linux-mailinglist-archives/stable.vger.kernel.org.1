Return-Path: <stable+bounces-41380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A68B1320
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5378D1C20F4E
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA31B7FD;
	Wed, 24 Apr 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBlIXb2J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627A22EE8
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985402; cv=fail; b=nromyEmHPjVkSuPNHdF8iC2P5y5qQLw1JbGQlhE7uf5tbaxKIj6vFmqj7AYVGWL6lTyl7tgJiceJNtiR+f7RUrK+djO/BUh6/fDPo0drx5IdNN8jM5HY3l/0aXGw/k1QzSLTHS+C5/U8cO78/pTGwV09+Vce7+MG6gj1dTDJa/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985402; c=relaxed/simple;
	bh=VkAVeeA6GoOp2dHAb2qHUBezgngSuQUAg/lAMmiGQlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UzLiQUop/3zzrQQQPyI5vAqfKAHdofKY3oL6/GBuc/eIepkeE6318pdut/TwVlVZjWRRNSNAqPKfAXCiei8Ceg47rXpZ3/8wgrOzmVQoIi9L7IPZDGe9kFNHAQXzEbu/81zbjLzyoGLLP1NQjr3p+x6H44a9XGz3ex9KsigKyU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBlIXb2J; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713985400; x=1745521400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VkAVeeA6GoOp2dHAb2qHUBezgngSuQUAg/lAMmiGQlk=;
  b=DBlIXb2JJsCH8W3nIEFzbmkgkNKxLMQx6LXDm1a4kVgdNaLUyElODgRk
   lfMRj3l6T1m5vtABH7JGFa0xRzOIGXRB9DWdHnUYnhm2Xio+j+ym/VBsO
   0arDF5hgiaBuE7cvyv4wAbJylSvxoXCAYN4qeKBFS0MGmXkiL7Z8qLWjs
   i89fDo/NWPvXjmMWX1L+wgR6Ir7VPIZtCa/irR4ce9ZTcK203U+nu62KQ
   x+jKLAx1pykQ9G//3MBtlwgqT1NzeknUD0l5L4QkiGLc5i6qKKE2SPnPR
   KT3Uaa+qKj6BkhchHufQDcAze6N+9ezOGf9OWLAMEsk0eCTwjUMXtNjKI
   w==;
X-CSE-ConnectionGUID: chCit6ayT42J41AU/J7oAA==
X-CSE-MsgGUID: 6zkbTKmgTYWCvD4tqkqGaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12573330"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="12573330"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:03:19 -0700
X-CSE-ConnectionGUID: 79QMDFaSTCeOUiK/+6SalQ==
X-CSE-MsgGUID: a6AuqWS7T/ynpNHbpfi96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24816048"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 12:03:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 12:03:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 12:03:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 12:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIJb+sBO3UmaPtliNAqHkwHUBojGRkC0IqYNnizOl5JCQnBjP9TKOe8m8KQOmiL//AwkcFTmUsetToMhW6sDPzJSCLsYmhK42A4O5mg+8B7YwXgcBiMAEQ/mvgqOPDj8+3hdjts2UWf9Lu2i70zqjvRTE1Grlx0Av8RoBURdIw/QdCqgZoAuMj9VrJ+g5SJ2ULCMfG1WLtUDf2rUnqi8OuQjg2hrYh0EDMcIixuf071INlXho1eE1FgvX+pIKhi+55w836H/r7MYI6iKZFOYim/rk+SAr7+O6qlkhEXDZo6Qz0v7Ptugi8Su5tnlxMt8hjxuD8tpQFxjACOmV5NGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33pwsmsqpe7fypKjjQLwPYND2BbTKY//NEIzZF9qSXQ=;
 b=h5+mSZ98CKAfGlKyj5v2eb8Af1X3Tm0Lk4WEAM7w+i1fcyh6tS1YXQ9yG76+ihG7ywpCMq+lXcIx8ANl/wwF+LDb7QEsF8TXE7UHBzbw/oIY0pTcGvFp4++nS/dlsZxiGrG9QfTiNJR9gCORaOuWATCuakbdxDGB+ce1Lrxaeizwllvyn7KLJ+kEujirmH8P+fdDsxy6eqSrIZbJuDbvOVl2ZTT4LaTCkiFWVVvg36/CqMBRtfhMkyqWSvsRJ25fMPIATJ4GXcYa+vxndpKC1d/+CDUfredBnVkrEfCIgW8aVWfPPL9FWpekzCurlyM1KkLE0C6dkmWYJZ3OI5HE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 19:03:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 19:03:15 +0000
Date: Wed, 24 Apr 2024 14:03:13 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <matthew.auld@intel.com>
CC: <matthew.brost@intel.com>, <stable@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: FAILED: patch "[PATCH] drm/xe/vm: prevent UAF with asid based
 lookup" failed to apply to 6.8-stable tree
Message-ID: <77xckfvuyzqksdfpbkxxegire3wipk77fylewqffs2bhkyyah2@nrcdumadjsfw>
References: <2024042358-esteemed-fastball-c2d8@gregkh>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <2024042358-esteemed-fastball-c2d8@gregkh>
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: f2899f3d-2754-44c9-ba17-08dc64913244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tCs9+FyTVcWC5JTMBntQuedrlM5Dc+hGYF3qREsl+ESrUzx9zgxq+wri95Om?=
 =?us-ascii?Q?ie+0VjBHgVt1UIJTEUxnUdPQM/2NrPVNKtkO5s1mkLVHleedg7a8Y5+O5ti4?=
 =?us-ascii?Q?7mVCNXOGyJssT9cXdfK4oGPR/DCDb2rHHluyvY/jEqvq4V4yr7MWEVLFZzgS?=
 =?us-ascii?Q?EFbDzbVxLgI9bzFTlQZETgdbGqqjwfm1RkjvaIjdPid7iCAwMzf42UNUisjX?=
 =?us-ascii?Q?2htMnne6njth5B6tl+/1O/ry8340iCSXBB1iCbQ0l7VS3/zS5r4T25po8XCy?=
 =?us-ascii?Q?8SbO3KX5fqs0Qdl8KQoXnQngHDssAEYtHAS/zPZpm/GeZI6+vBvL3r/UF4n9?=
 =?us-ascii?Q?2KIQqT/O6u/fexASmkid5yQccjN3TNqScC8qqff/bgrsMw5zsYiD1N9Mi4QI?=
 =?us-ascii?Q?UKoFNnBvWeLQ++gyl6+dMkxOyG3BvOm8+H6/B4JMB3DNM69/SQi72UfeIfQP?=
 =?us-ascii?Q?57Gjwln3q0lE2dGh4djVSmKUmx3FT6T30NTY7J0pSHKVXYJGk1oC0fR2PYdc?=
 =?us-ascii?Q?PGKkVq1DlXvgvGKCj/UPpRr+Zk6d0iSCywxBoGLe4OXRSdHRihRfv0L6y9A7?=
 =?us-ascii?Q?r94aWTo+qVyO7OQg7gBQfFG+iREVI26sWdBI9aTfbdo98L4Hr2sZMLMoGYS2?=
 =?us-ascii?Q?lGCpwBpYxZRaMwd0ocxavKeboGv038kTfpnXbW8B/zV1H7jgxSlp2P8MkqL5?=
 =?us-ascii?Q?IxYfyKR5YXYXWCQvajIVUnYmm+4xZOMpQT2gvDkP0P7S6D9nF8314yoebeFS?=
 =?us-ascii?Q?/X6UCjFmKasmryRY4AFkhom3qo30v0XwpcK/81JfvlqlpQUrHiNjZGv0EGKP?=
 =?us-ascii?Q?ymtT6/Ov2iUF42T3iXUlbS0uLTj0dsHdwOP6xfxIh8bLWnfMLcK48hmMY/+B?=
 =?us-ascii?Q?NG5S96XuW2m+esYjo3iwPObCNqGTbqHdJkrgF1zp1md6TF0l/oxXk6hLcZkO?=
 =?us-ascii?Q?v4iRDbkyIYmhm5i2GGOr3sbRkU9pKI+QAciPB1p5qRQ5dkhLTuVr74aTfLX8?=
 =?us-ascii?Q?FKAtr1jo58/LfS8F/80YC+kYx5uMUsUMupLlPIgQHfc81gTVAE7gVdmdOwxQ?=
 =?us-ascii?Q?Ri9frKc5EGXhR6+2OHT3TL2UX7nMopNDV9OHyfcW36lDj7rquKl1VPD38KDf?=
 =?us-ascii?Q?oSTVie/IBhMy49b5f155xqjn0xXZ13b7s0M3vUBKjzmCyGSy+k/exaXHOUsh?=
 =?us-ascii?Q?xI2hOhQUe9ITA/2zvN8JNrDGU6tKKThvExSOx5jc3/50QJQo5eS3r4uDcsc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwFcp+mE0J/7Sb8VXRUgbWS+jRyAfJ89ErScFF+k+6Mji83z96iFEUXR3sOR?=
 =?us-ascii?Q?034oz5SZ2X5j6Dskss6e+9CMUDiwYqpCp1OWwsdE5x7MPTlxEmqwMXTbljmi?=
 =?us-ascii?Q?ETwFUxTN18geRvCqVK+vqUnRJZctLgqXExrJGRHyia1w/lEgi1LgLTBfv3sz?=
 =?us-ascii?Q?1lnqG/BKjeRT0GUWVOuDMgDGhchyzTWQyjECXp9DeA8fOPVl0yjUCO7uIIsd?=
 =?us-ascii?Q?yHTX0ECmau4thFwlpNJfj2OnZxBfS0dFuWziyGvY1FG0CHuOEYqczBhgOBxX?=
 =?us-ascii?Q?ZiPtz0DO/+heFqe5HouVGdaLAc4kIickoFqGxAULnU4t8iuF1QCwUUZu4yr7?=
 =?us-ascii?Q?W9vIaHU7b11Y8p8u7Js5tayk8j10ha3EL27y9tAN8+sJZXZHCYhbpsxZSX9j?=
 =?us-ascii?Q?Qmf4YpIf/AaqsigGDbA+ViJzvF2SFCCIcjVy25I0GLuDHXg5CwMF8dR3DTWK?=
 =?us-ascii?Q?Ic2f9jY0RAgJ2RbtT+FExFrJKOo+oZisvDovzMHndy7oRlCtDsBkGeKfOlRf?=
 =?us-ascii?Q?lQ7V8TTwZ7yjNEduzyEIXzRseY9U6Be6/4KmR7uqOPxOWud8C6J5+Szs9f5H?=
 =?us-ascii?Q?jlPnba8xWuJnnECGNSO+Lh73GilmU14eilmWt05aMjWBIfwEE/7tmjynh4kn?=
 =?us-ascii?Q?Be6xNGVaHTU0kTwXnjZVK9F7PtPwK7JeVqun6VNBvobsK5md/SGOXX9EP74Y?=
 =?us-ascii?Q?UqdDxbJAb/6DweAJnZ6pueZnQtZpGhlFfd+vQQEq8B5lkgFX67bS1MC66XvR?=
 =?us-ascii?Q?HeVXpE5+8RybLm7IA9gBzmBmydDPZrh35l/sxnlzN9GVEMBYZBO/upRYYrHP?=
 =?us-ascii?Q?iLYIz4tkywkXvgASNzwHHQq7SuAxBpo2pq40YbBzYRr/5GXTMogDMMWhAFjK?=
 =?us-ascii?Q?bGf8xweTt4+1DYJmgWaHwnp01DLLHWXl/LnSthsVq7yq5dBn4PIAYN2GaUFg?=
 =?us-ascii?Q?1EDNeHK7vMrQr0iLEZ0Bgt4JV/17lNg54LaJkp7DWZR4zEboAzpwYxWI6ZIi?=
 =?us-ascii?Q?iOzmsUYa1va9RKmHHIRptMAD0qPE9Bb7g4eheg61TsNtSPTueXpQvkPuVXHU?=
 =?us-ascii?Q?gurFGWKpKMs3pS3LSPp589n5CoGCNI1jUQOsjumaprT7L++F3kCuiBCIS9S7?=
 =?us-ascii?Q?W5tcAtmFdq8IYtxdgfhWOUy1kyEPKaTYxHQwUJSiIrvAlPMr4XOvvNYXQWVE?=
 =?us-ascii?Q?tqr/T38KY65VRv+IPT716QuULwQz87IgbPxMr+eJ02ygk+joEO9xMF6MD9MM?=
 =?us-ascii?Q?yqUEpry6J4yw4Mea/EGygnWe32+/N9j88YCJqE5iosZiX+XmKg6Sn5d81vVS?=
 =?us-ascii?Q?OtULx/RM2tNGj6/XiaWZvP7QCN2O96NOGuit+gUaglhH3rPVRRyAw6+DhAl/?=
 =?us-ascii?Q?zR6BK67dONT9cUsZLEXMHbly/kwZpcwAqWqwh3kq4lE9zOV5AsFHijGqjNUy?=
 =?us-ascii?Q?Y4U27yPkTqc9p7KJs2gG27AKRYflPG1CyrB+3NnYk/nzxi/eGlwBst9tTxga?=
 =?us-ascii?Q?TGWIJZegHIFkXmdAnk1DLp6JgeIZaPuNGwHjiRBt7DDtXe+4sjaQh9QOSflW?=
 =?us-ascii?Q?Os3tlveL3+jo7lvoz1OQZY50AXilp3BaUsb6/Kssmj/PguQqmIV5GUI0MK0g?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2899f3d-2754-44c9-ba17-08dc64913244
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:03:15.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XADWTLis53bgXikR8/b/O3GuPrQjXdrAUWz1/rPVB+aVDojxLtqS1pu+csbJ6pRHaaxh2QvZwDXBPgWR3wyDVaZCK4/K9Qg9syFJIEih2mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com

On Tue, Apr 23, 2024 at 06:07:58AM GMT, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.8-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>
>To reproduce the conflict and resubmit, you may use the following commands:
>
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
>git checkout FETCH_HEAD
>git cherry-pick -x ca7c52ac7ad384bcf299d89482c45fec7cd00da9
># <resolve conflicts, build, test, etc.>
>git commit -s
>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042358-esteemed-fastball-c2d8@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
>
>Possible dependencies:
>
>ca7c52ac7ad3 ("drm/xe/vm: prevent UAF with asid based lookup")
>0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
>be7d51c5b468 ("drm/xe: Add batch buffer addresses to devcoredump")
>4376cee62092 ("drm/xe: Print more device information in devcoredump")
>98fefec8c381 ("drm/xe: Change devcoredump functions parameters to xe_sched_job")

Matt Auld, were we too aggressive saying this should be ported back to
6.8?  There's no platform in 6.8 with usm, so maybe we don't really need
it there.  I don't think we want to bring any of the commits mentioned
above back to 6.8 really.  If we need this change here, can you prepare
a modified version with the conflicts resolved for 6.8?

thanks
Lucas De Marchi

>
>thanks,
>
>greg k-h
>
>------------------ original commit in Linus's tree ------------------
>
>From ca7c52ac7ad384bcf299d89482c45fec7cd00da9 Mon Sep 17 00:00:00 2001
>From: Matthew Auld <matthew.auld@intel.com>
>Date: Fri, 12 Apr 2024 12:31:45 +0100
>Subject: [PATCH] drm/xe/vm: prevent UAF with asid based lookup
>
>The asid is only erased from the xarray when the vm refcount reaches
>zero, however this leads to potential UAF since the xe_vm_get() only
>works on a vm with refcount != 0. Since the asid is allocated in the vm
>create ioctl, rather erase it when closing the vm, prior to dropping the
>potential last ref. This should also work when user closes driver fd
>without explicit vm destroy.
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1594
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+
>Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>Link: https://patchwork.freedesktop.org/patch/msgid/20240412113144.259426-4-matthew.auld@intel.com
>(cherry picked from commit 83967c57320d0d01ae512f10e79213f81e4bf594)
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
>diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>index 62d1ef8867a8..3d4c8f342e21 100644
>--- a/drivers/gpu/drm/xe/xe_vm.c
>+++ b/drivers/gpu/drm/xe/xe_vm.c
>@@ -1577,6 +1577,16 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> 		xe->usm.num_vm_in_fault_mode--;
> 	else if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> 		xe->usm.num_vm_in_non_fault_mode--;
>+
>+	if (vm->usm.asid) {
>+		void *lookup;
>+
>+		xe_assert(xe, xe->info.has_asid);
>+		xe_assert(xe, !(vm->flags & XE_VM_FLAG_MIGRATION));
>+
>+		lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>+		xe_assert(xe, lookup == vm);
>+	}
> 	mutex_unlock(&xe->usm.lock);
>
> 	for_each_tile(tile, xe, id)
>@@ -1592,24 +1602,15 @@ static void vm_destroy_work_func(struct work_struct *w)
> 	struct xe_device *xe = vm->xe;
> 	struct xe_tile *tile;
> 	u8 id;
>-	void *lookup;
>
> 	/* xe_vm_close_and_put was not called? */
> 	xe_assert(xe, !vm->size);
>
> 	mutex_destroy(&vm->snap_mutex);
>
>-	if (!(vm->flags & XE_VM_FLAG_MIGRATION)) {
>+	if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> 		xe_device_mem_access_put(xe);
>
>-		if (xe->info.has_asid && vm->usm.asid) {
>-			mutex_lock(&xe->usm.lock);
>-			lookup = xa_erase(&xe->usm.asid_to_vm, vm->usm.asid);
>-			xe_assert(xe, lookup == vm);
>-			mutex_unlock(&xe->usm.lock);
>-		}
>-	}
>-
> 	for_each_tile(tile, xe, id)
> 		XE_WARN_ON(vm->pt_root[id]);
>
>

