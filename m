Return-Path: <stable+bounces-116470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB6A36AD1
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181243B11A3
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 01:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C542AA3;
	Sat, 15 Feb 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blhbP2Pw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751C10F2
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582597; cv=fail; b=r4/yrYzJgPDQ8qQiQLLmWDw4frqb6ENcCyTIqcUroTJDZFEagYc6MnxxOlp2aY0RXjE5T6UON1C1rgERQlBbo783/1GhVNrELxY1TY03bzOniDl7biiWnAc7nGwnUCToazpha0g7SQ0b3IjTPJYmb6GAVg6GRXiLlRgpJInLYAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582597; c=relaxed/simple;
	bh=+L3AeEZVOIJ1rQi/QJC3ORPhgqpbfBC6WSeFxa9tqu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Udm9kN5TxAlf3CKnKKdIPTFxoLL+niMXNQ7pLZHHbQ9/S07VEUizX0wDuKpY5NIbfU7J0W9RXPJhyRvHOSbpZz7jssqt0g8s1tmpdyKUIiwn9CdFyA/fMUxQ4grKwQgi2jmCKmH1XX2JBmwIzgk6ooy5SF1/C6XLmAASNBzmID0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blhbP2Pw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739582593; x=1771118593;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+L3AeEZVOIJ1rQi/QJC3ORPhgqpbfBC6WSeFxa9tqu0=;
  b=blhbP2PwUn8QEic0CW9UFhrLVGNoB7BYTI5C/X2MtmIUMc9ULolhaBrI
   xFRLGB7bMtaJoSTEHWJ/X1h7YGKuNy+lGSHXh82+/E8dfWS0EMZ1my3EE
   0mr6g7xip5X3g0RB9FG6teymwGbj9vjvVsWXmgrmf9eEtXqaqH57KY7Cb
   tdcOpWjHB4TWu/mux8P6ywSzfJ1PHNUXs9KziYbFLgHLmZq91f/Vzo6E4
   PQmmKiEA2BMFeJgkMgScWoVMjoRf7kp1UwC0s3eR/x2e9kAPLLyCovI9g
   QGi63+6+dALtS8KxcParYH93C5koBgTM8/SftNkV9noSs5BwtLMgy1024
   w==;
X-CSE-ConnectionGUID: x5WupI3sSK+XbfuRsBIyKQ==
X-CSE-MsgGUID: 47MxqTq8QWeTejz9r+pskA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="44274538"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="44274538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 17:23:12 -0800
X-CSE-ConnectionGUID: Hi/l+S0VQc2UxCp1smctbA==
X-CSE-MsgGUID: 2LEu7l/VRbOcAMss5W1cRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="114116800"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 17:23:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 17:23:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 17:23:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 17:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqbupSzImmJyTJCJFmUD8wEpuM19SK3fPNh1DZUCEsTpot/MXHTubOhlVDjEW5sg0N+vpnxpJFQzNCo6LSb41NqTbmvpUyxkzlFb6Aa2YHW1IfqJDUgo2+otxy9K2gvoDdtWcFXhXJeoRJbjiieZZNvEwKzUcTxPS07opOLC49ET1nmgNc5XIdaJyguTBRKYAzklpJNwa8MF/75YgIT6/z2sboW9q8e1N3c/WDyQmVPQg3fhWD9odRMSaf8nOI+oLFcC31W5xKl/VpdgGX9cwF9Y8TZQySP5zqnI+oRk5pCpvdQp+lwZiR6vLtxs9JHy30xoBN1RichwTiJzBhan1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7ZxuX3xM/IcRyFFd/9S0LTnqwZ8GVBH1b7hOX18hAY=;
 b=y6fdGf1NuVUpfKfE3S4aeFjLswi3bScJmnPgm9ijk26nOJfgW/IZPtqj7rCXaUnjrXT5xmUzExSvQwvhkun0IE43PJlI3CoXgy4+Vqpn3vZcB5nwQBKrce/l8O6UIt8dxMvIZ+27X3OOCYgXu7FiN+7SsuRfkqK5sjdlkcImwYsT7PwfRtkmk/qx20Q+bVudlj1WjnOothKFoKmMk78um0qJIpVApr2UPkbMK+ZPvn5r7DdyqOent/ATTMDk8w6Szs6XhoTnKc0V3f8OA2/b/HHK4Bn09sYtGCq5JCJpHgu/0cEXimdanSBH0/MznUaF0vf+pKCeXsRujCWuKRtYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sat, 15 Feb
 2025 01:22:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8445.015; Sat, 15 Feb 2025
 01:22:29 +0000
Date: Fri, 14 Feb 2025 17:23:30 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] drm/xe/userptr: fix EFAULT handling
Message-ID: <Z6/skmsP0lw0+GUi@lstrano-desk.jf.intel.com>
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <20250214170527.272182-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214170527.272182-5-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c837ad2-17de-4c0f-e889-08dd4d5f36c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GMrMDBd+NPxYbpCYGU3n/Ptu5cu28AkqhBPwLHYtE4UtUO8cGDbLCyKAau?=
 =?iso-8859-1?Q?+Dwmc8h8deA3HtjA7fqEfxO0KihJNUxIiFZJliuaCH8fb0SGI5L0IhfEes?=
 =?iso-8859-1?Q?B7/PccpR1/XY2H1QZgHmxESH3PUvR+vCfUt5ntuTVA2a5pwgeccr4Igmyd?=
 =?iso-8859-1?Q?CrEQrEdDdVXruDK0KBBzS2J3qq52alYV4uGPDwEUVqe6GdRaCC5RJkHKVb?=
 =?iso-8859-1?Q?ejMGu5Pf20FQKttmaGg7xlIeVpHPpKn5kzs1U7VAH5SbjDlQ2a9pCmNoJQ?=
 =?iso-8859-1?Q?7g8TXbiJRi0ewMuxgjshzMzMgzhjjkn9grKzCunCZz8T6vsDPo1/NfZWhQ?=
 =?iso-8859-1?Q?W88IHMnVUF2TvzAzC2CfD6VbHC1SmBRLlQ2JyEQo1ZVbjtSTa4z3wJFV4J?=
 =?iso-8859-1?Q?dPZQrxAzOSYzzmsf/hCj3Xco0rZ7pt/V3Vsmxu5lPtsphtY81112uqV78t?=
 =?iso-8859-1?Q?D5D5enOKFmg3+WU4MuTsFnVtm2wYIz1WXOpJ5czUsysKNJnY5FjFs7jO3z?=
 =?iso-8859-1?Q?qRRh43ExqUiSDQqByj+SNwZSxDalvZYevJy5cDd5y/HgD+VgoSKil1S1wF?=
 =?iso-8859-1?Q?AOKNhxPgoUhwcsMy/7siIbG8dvVOwLMWePdsZoh9ufq5qeQrqXQGUJn664?=
 =?iso-8859-1?Q?Ik3GrDaW9/98Hk0roZxXdJpZOr5jbLYdnPWuYTPenZXvxINmqefRKINmJT?=
 =?iso-8859-1?Q?iLacO5GqQgrrIrMYhGH/bJJr8QNwfPJc3z38SIpb8vpWdcx0JagNeRyce8?=
 =?iso-8859-1?Q?bBKQOpnF1UHxn9AzVCXcGDSaYKpwTJICaNq/jsgx14TrDtl9uSmdvxELFl?=
 =?iso-8859-1?Q?B6Au/Y+S7FzaxVyiCOPg0tuqOOKmGk5pOYjuxcPlunsGyjlvl9mc1r3r2g?=
 =?iso-8859-1?Q?jbajlS/hFec6hBeDZHAnZ2H6vAlAxUZdD30K7/mjGfnpCnBRgIxuhzidIk?=
 =?iso-8859-1?Q?4doyJWuv38mGUTGNwTl6VBmJnps4cv9Lnt8+k6PCdwor8PJ4fYZKAufJQW?=
 =?iso-8859-1?Q?jXDpTQZfYP7xjwoS2qP9FXiveaSRQVGQJ4YSFb3qDoQuo4q4eyayIDzzA+?=
 =?iso-8859-1?Q?aQa5GtpIsPaccdO9qcSdnX3ZjzOCBSSjEQoFIulbwveuDPyfKCJqMNF5X6?=
 =?iso-8859-1?Q?nj0sp6q793da6V76SG3P4GAa0xhqEfxZoJE/abN0WqBaU5TaJvievxI6uw?=
 =?iso-8859-1?Q?SKm//Fx0zO6IhaTLVu7t1BmJ93bIluuJ2/gwclknU4S1pEKEiop8OdSaqB?=
 =?iso-8859-1?Q?yzD/ug5XT8w/wAdEbsP5oTFv5qh9ICBV4K4tKSFF9HkgqQD2sPcU6dVh3B?=
 =?iso-8859-1?Q?K7eYSY8FMYjk21Y72WWsZlWlQ8B6PNPbijgO7Dts4KILTHEadsyVfybwPh?=
 =?iso-8859-1?Q?TQ/MMCODurul6GgqHbcz13Gl0krwyzq26LSn8On93z6uZSeUKUon4sVl6y?=
 =?iso-8859-1?Q?dKG8rfUstI3ZFQKP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+XiyQw4mGmScAUSYTF+t/i+oT+QHYDcZzwDiV/A6QHLSATw9tp4xlDd+hs?=
 =?iso-8859-1?Q?0dSncj/3c2FT/ZxH13pNr0ypQj9hwskSQGR0mLvFg+YX37ByhnhqcOO24+?=
 =?iso-8859-1?Q?J+zLQIp2AKBmbENEELz6Ak6T9mXC03ydlv5EH84nYKEMFS9UGBE9DfBIuy?=
 =?iso-8859-1?Q?IKr0nhhKq8DNP4NUiIlaV2NfW9SzNKy16lM7Nyt+A1vniIWUJCYn3Yxx6R?=
 =?iso-8859-1?Q?SlNcCr3qzzbZZ0+oQ2SEDo20RqkOgFUrUcrgtOe03BY/gCwHms9AKWc452?=
 =?iso-8859-1?Q?YWCKDL9Y7ZeRM6bQZ3DBrLw7lTmbvPGVUbvZrauoNiSXuA9889MeG9jWTS?=
 =?iso-8859-1?Q?E/eyuNXGG9DhU0k3YpUmGPmuYQPkiCjwTLsln5fvxpqZ926pD/keJtpFcv?=
 =?iso-8859-1?Q?mBF2nMtf/Qy96mJ8gXpQSl02OeK1khSqMgyHpcmSdrATZCfKT3xnbuBxUy?=
 =?iso-8859-1?Q?HllyrQ/CAnhIm3Vsv89rohCRpmo2pSN1MuQWlaiDMPsPwuOkkTZNsT7tJw?=
 =?iso-8859-1?Q?V/4l9elH/TnYQd7bjk/E5AD/kehvFYToN63D52OSblFXQ/7Rq0vedKy2Se?=
 =?iso-8859-1?Q?f35lYhywca3nuhSfZR4VGt/eBAPjor1LpnAX+Iq0a2AtgNBJz1ILEpccwB?=
 =?iso-8859-1?Q?DA76OlcVlbk4KxD5GSn7g60duqWT0Nq2lo4DvTHy30w5GQiVhLRg9zuLW/?=
 =?iso-8859-1?Q?IexPdmQr8+Jk0h7fNIQf3hVptd3IpjNCBmmCfGttOH8Co86ukqCTUc8hqN?=
 =?iso-8859-1?Q?yV0qUOqoW3xX/zLVtydFO5jb9LFHtqkI98RycvWlaStA0EJX9U9C6ia/bi?=
 =?iso-8859-1?Q?ax6wkHBWPGDhftUJ45G8gRwfMyzVU5cNYJRUz66bk1gQgiVICqLBvEx6sH?=
 =?iso-8859-1?Q?8QOFZSz/Nl4gYiOTNGo+TZNy8W4nywO/sEAMQE5mjVLFwC/OKQKED0p5Sb?=
 =?iso-8859-1?Q?2PyknLbEJiYzFdOR3/imlGPQtgnD3h4/7baYdWotDGbM88bu5Cn/Ye8VCm?=
 =?iso-8859-1?Q?F9zrzRALXqVJBHeGSbv2hpObxLMAB/NHy7kj9BSafat5fXKOwNPmO2NDyh?=
 =?iso-8859-1?Q?Fr7zHR6kyc+YTODpFmYe3DQpqiiPltTM+hKj4ZTu/qiFkNTDGFF0lkE4jx?=
 =?iso-8859-1?Q?Hg5EECNI05WUSa9AHOyq3Pbj6wp/gfFCdG3VNU0tZsvlka5J901LMRdEN6?=
 =?iso-8859-1?Q?UWAY73lPxbywja7rQwXXhjtN/NAgBqhhk7/QCkSsQZkNyQujuxdKJ1BZMG?=
 =?iso-8859-1?Q?uS8B2nzihRkV3luE6FKT4EF8jZp3UBE3gBK8HpVBlWfama3P0CXCeD0S8D?=
 =?iso-8859-1?Q?j33VfcG2D+GddWbHPvYXkQgLl7NHlIWCOyPgw+NEhMg75Gpr2n/47/8wa4?=
 =?iso-8859-1?Q?HfPrctANVMHuLmQSOZeyKsnbbsY4B5ZSSHwf1mqm/TIu/WB3q0Js1UtGcJ?=
 =?iso-8859-1?Q?fnQyKfLP095GIzlfI7MSnS3Xbehx5oUrSqRmZdszC3GYC2h7Bj6Esg8paz?=
 =?iso-8859-1?Q?SWpLU/1lnOZoisAZg7zdk94ySMQAM+mRnZnbixYEfrwqk8X2jSuN/bPwyY?=
 =?iso-8859-1?Q?bN5c7jwrktdArvOfnSMjYnnnU3rsyn1oDi82H8ZV60/A8omOkDeiTFofIH?=
 =?iso-8859-1?Q?kEY5jR4WgF5tyze1sLBXOBtqLwHfz8C1sFAuL4yHmMpV0vSlVe6NAs5w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c837ad2-17de-4c0f-e889-08dd4d5f36c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 01:22:29.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz7hCt6Vw6Xruk79e6yTK/Yz8A7MpWQ4UpjMwIFp308/BMskMARnmxPP6j0rSkdUcMBWtfTRekLn4iVTFhj6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

On Fri, Feb 14, 2025 at 05:05:29PM +0000, Matthew Auld wrote:
> Currently we treat EFAULT from hmm_range_fault() as a non-fatal error
> when called from xe_vm_userptr_pin() with the idea that we want to avoid
> killing the entire vm and chucking an error, under the assumption that
> the user just did an unmap or something, and has no intention of
> actually touching that memory from the GPU.  At this point we have
> already zapped the PTEs so any access should generate a page fault, and
> if the pin fails there also it will then become fatal.
> 
> However it looks like it's possible for the userptr vma to still be on
> the rebind list in preempt_rebind_work_func(), if we had to retry the
> pin again due to something happening in the caller before we did the
> rebind step, but in the meantime needing to re-validate the userptr and
> this time hitting the EFAULT.
> 
> This might explain an internal user report of hitting:
> 
> [  191.738349] WARNING: CPU: 1 PID: 157 at drivers/gpu/drm/xe/xe_res_cursor.h:158 xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738551] Workqueue: xe-ordered-wq preempt_rebind_work_func [xe]
> [  191.738616] RIP: 0010:xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738690] Call Trace:
> [  191.738692]  <TASK>
> [  191.738694]  ? show_regs+0x69/0x80
> [  191.738698]  ? __warn+0x93/0x1a0
> [  191.738703]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738759]  ? report_bug+0x18f/0x1a0
> [  191.738764]  ? handle_bug+0x63/0xa0
> [  191.738767]  ? exc_invalid_op+0x19/0x70
> [  191.738770]  ? asm_exc_invalid_op+0x1b/0x20
> [  191.738777]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
> [  191.738834]  ? ret_from_fork_asm+0x1a/0x30
> [  191.738849]  bind_op_prepare+0x105/0x7b0 [xe]
> [  191.738906]  ? dma_resv_reserve_fences+0x301/0x380
> [  191.738912]  xe_pt_update_ops_prepare+0x28c/0x4b0 [xe]
> [  191.738966]  ? kmemleak_alloc+0x4b/0x80
> [  191.738973]  ops_execute+0x188/0x9d0 [xe]
> [  191.739036]  xe_vm_rebind+0x4ce/0x5a0 [xe]
> [  191.739098]  ? trace_hardirqs_on+0x4d/0x60
> [  191.739112]  preempt_rebind_work_func+0x76f/0xd00 [xe]
> 
> Followed by NPD, when running some workload, since the sg was never
> actually populated but the vma is still marked for rebind when it should
> be skipped for this special EFAULT case. And from the logs it does seem
> like we hit this special EFAULT case before the explosions.
> 

It would be nice to verify if this fixes the bug report.

> v2 (MattB):
>  - Move earlier
> 
> Fixes: 521db22a1d70 ("drm/xe: Invalidate userptr VMA on page pin fault")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Anyways, LGTM:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 668b0bde7822..f36e2cc1d155 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -681,6 +681,18 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
>  		err = xe_vma_userptr_pin_pages(uvma);
>  		if (err == -EFAULT) {
>  			list_del_init(&uvma->userptr.repin_link);
> +			/*
> +			 * We might have already done the pin once already, but
> +			 * then had to retry before the re-bind happened, due
> +			 * some other condition in the caller, but in the
> +			 * meantime the userptr got dinged by the notifier such
> +			 * that we need to revalidate here, but this time we hit
> +			 * the EFAULT. In such a case make sure we remove
> +			 * ourselves from the rebind list to avoid going down in
> +			 * flames.
> +			 */
> +			if (!list_empty(&uvma->vma.combined_links.rebind))
> +				list_del_init(&uvma->vma.combined_links.rebind);
>  
>  			/* Wait for pending binds */
>  			xe_vm_lock(vm, false);
> -- 
> 2.48.1
> 

