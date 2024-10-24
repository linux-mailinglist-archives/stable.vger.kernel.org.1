Return-Path: <stable+bounces-88104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CF9AEC2B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB321F23C26
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74816F910;
	Thu, 24 Oct 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPjRY9gs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454621DD0F9;
	Thu, 24 Oct 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787557; cv=fail; b=JoQbhgmEd7lrDnKkhK3JQ37uEnydGkRiARnz+CpYxu2ItYiW5s6s5SufI99NhE78MciVsSDSHmIXEa3fwbLOVdH8A8hJ8PrrtAxPh4VclFZj0EfCAgyiSYAzay3Bqt0j4Td505n8YtgT45faHWSpk2yVMLzglbQ5VFsAo9NlJgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787557; c=relaxed/simple;
	bh=ZN+umrzfU6a2stpzri6UZAxARcglNx682wNotMeyAJQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ouBaSWBNSJI8lI4RjMTvq2k7Sizf3gMxVLHTs1ByO7ZSqunCmf+3YpMsUPFhV3RRW1KlB+EK8NPvNR5G4OYDHOH0GhYUA5MR7hK7tgGnDP4k+bxudqzRmqRD+iv32rhD2h/KgLkbd5Xu5rw1D/654dcIQ1EJhmjsKG+kIRgrJiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPjRY9gs; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729787555; x=1761323555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZN+umrzfU6a2stpzri6UZAxARcglNx682wNotMeyAJQ=;
  b=RPjRY9gsRmyImuhY5Gco2I81EPQu8YJFSYdn7V/FI5DXlAZDyotFaw7o
   A4C/uPvFBNnjrSR2e3zw98vM67rjKd4iFpsYeO+SsijKSBhb3lXlGCFjE
   BGzRThIHWvOjK56b3QXm3D48NMinYZUzXOECi3mRp/XJvQjPuaHBFTYfr
   vc+2alUYhYZh4OqZO+mPua3r90jJ+QKDJVD/wB5ci+f3ab/I3SwnZkSFr
   j+RoRq7OYDj9r0DbQvLRw40MhZRunvdxm7x9TYTbZSVREXjRWIN19j5eD
   bKcXqsJxStcubHkeafJPjtPIv56aJ1MgeqXydUDd//9u2WaPbur6q6wUW
   Q==;
X-CSE-ConnectionGUID: BYjB95VjTG6vLVpNIMLDEw==
X-CSE-MsgGUID: /42PANC+TwOhglE9CDIh+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29360982"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29360982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:32:34 -0700
X-CSE-ConnectionGUID: mY5vFk0tRmaF2EaezoES8w==
X-CSE-MsgGUID: MweFTTXKSamNIQ3AWzMCeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85752275"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:32:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:32:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:32:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvh9fDNi/B0qjK5SrF+hZmEtSrDYzvnw5XIUVYAtAThv6IFWKdK1pl8v4RZuW7cqg/VaheDc6OJnzrhT98RfBkv27FXirPKJjbMSGsc8d0Be+TT7hiVJZkS8piZxDq9YNyE6LhbKVGyVgejT2AYd68c6hsZkCvD7cm3107X5QWLMO/vUU38YwKhgmzZo7RulP2/pf2UqapZuaN793wxe4YiREgBu5YsyyK7q1OmtVBWAUW3g3t9G+i4ntHlGz41voqjEKRrWqKR5EPsUR8e07Xt2EsybZLpcq+RcqxffRFfeELAkTQeakTy4V24vRBN/wxRKeqeHUpg7wnZkeUWYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL7Oa5AmKLuv+5ePwcIraHBuN+9cEclcOFgef1AKikU=;
 b=dA6R8AZD84cQzn9z+EOtpPCs+1bHEBxVmbWYzeL9HmHnZfjK5nJjx0sKhUd6oMtpcoRrtrAi19QdaLPsFAHJ/6S+x6YcA4GWTNg9ypRWmr8JQIxDL8/L7y2wF4xn+h+oa0LmGs0hGu6B5qEJU9057M7uGrIhnsIhDokgSxbBI1PIhpNrTcUV3ViHNGK8Sjqd7ZBwa/VgEzi4CDdy5KoomkBw6w2CPPs3ZbeEQYYTc2xSGM5wj6jjtikAupMJrrYVRHLQ4MypuVkEsLyMiDBDeH74vmfSJMqSQeTDCsWWSGrYcjTFo8icZho+HXWFkISXFire5n7Y53ZFnFo8LqyUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 16:32:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:32:31 +0000
Date: Thu, 24 Oct 2024 09:32:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: Gregory Price <gourry@gourry.net>, <stable@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <671a769c8adcf_10e59294c5@dwillia2-xfh.jf.intel.com.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
 <00e03abe-1781-b2e3-62f5-97897093eb5b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <00e03abe-1781-b2e3-62f5-97897093eb5b@amd.com>
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e4d5ce-23d7-4c2a-9352-08dcf44974e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xcUbsibqI+DOWX4Oz+YnUQoyTTO9aPKlaeyjNKdhmrsJqtXLCfC2OqzsUVvD?=
 =?us-ascii?Q?ros8ARqi1jLCtfMtaun3PlaEv7pkLblS84rjamKFgSItcwjLwcBCA/zGf5vc?=
 =?us-ascii?Q?17TF2q8irpqzrNMWYu9InvKJgGgHU4epfaEUsYedGxlmasyqjk6NZ4a4iBiC?=
 =?us-ascii?Q?i6b7f6CVzvLba2y4z+vWw7lwBT/n7hrKtduNM0N9VJzgIMGgCbvgOTcpkeCU?=
 =?us-ascii?Q?iTRzvnFNqIcb4PoIqSwXwGvmAfA3HmCcf7r84wfwUiG6rqJ1FI2FBLQjkZ+V?=
 =?us-ascii?Q?O0mWIXxGpO9Zt0al1cWr171FMMVckZp/4HCH/AHO3SXZR3fMeNnPByytMEDj?=
 =?us-ascii?Q?cDD7rBCwEO1dTn6nQYREHMR/2Mxf0wo+Nd1eiodhz8vUjHm3cV0jlvbROsJU?=
 =?us-ascii?Q?Nou9um5UlXxPkd7I1zsOs2xBk20KM2d18R8wjr5HpBHk6pQvtGpgGBTUOlj9?=
 =?us-ascii?Q?kb9g3ZAfS8EQ679vBw4KvKi33617UVzAbR5ooIAawmyUO1zyFz9KMioZ0uBs?=
 =?us-ascii?Q?uBveXVYQcILlgUy7LJd0TbUSkfHt6tdl6C8ZkIwpQ9NlGRPf46NEt/0t4g1Z?=
 =?us-ascii?Q?4WQ86ZsZ3Yc4VIPAW2a1ed7Xf4eioUmhRuJlbm8Ln7yRga1xdl76dq9cFek7?=
 =?us-ascii?Q?5z6fcZnA9d8vOGr4EXefUeRljdpbSEmcAhNru2g03IaudncMGiKfZCBVaiIn?=
 =?us-ascii?Q?bdcqsziwYdz/xh+KHRUl6mvOabucd7YNkzt/m74/amq4XZ9529yXmDyjpqw5?=
 =?us-ascii?Q?22erMKC7Q2GK0XOg9YcI3yFICA0y+zH4PCZciSekrQl3xUvNLm8dmD3zPtz+?=
 =?us-ascii?Q?P4A1EjWp28CKXnN3lw6srkTYKl6WonLZawWiCEDR9FdkHLSg+FwYvhkwPJUr?=
 =?us-ascii?Q?qtf/pSQJHh4xygvIzJ3qb4Fzy4rAnen2p2YDu3RPAYjS2BIuQgzxSVudmmN3?=
 =?us-ascii?Q?4hKfbC2XzgicT37bP+22c0SFUha2wxyIbkaPvbAcmYpr/zacR4RzUUntoXsE?=
 =?us-ascii?Q?fw7XxZj7cb/X/xWL8X1BVZpJ1F3eAFN1382rk0IJoyqlRPGAhKyAnQAeWWQR?=
 =?us-ascii?Q?18Wbi0ifUNE475fn7gBeFpGgrhiZOkdKLLjVS45bxYJkqlvffeCg9xyK1nZI?=
 =?us-ascii?Q?gdoDisRIgbIvBwc6DCY/1V30TwMJlddES+JbCuYcKz0UB4b/K2cF7LUuMObe?=
 =?us-ascii?Q?V23b1js2yjQJf/8hdiWRM6NIoMzTvp74gOYvld1hSp33UcuPA2Uq41he3wWH?=
 =?us-ascii?Q?Gfyc1ryi7thhPSLKJIWtaisk5cpxG6+wyma8vKTfZEfQNwZ7F29jfxic8o36?=
 =?us-ascii?Q?VONpe7tXakZjotu7Fcy6r37U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tkgs/DzAZ5qizZ0nZ5RLErDuTE2jkh3MVzgqEu0k38XaKM0UyRuLvZY/xeKs?=
 =?us-ascii?Q?/egqA+CTLFcU1chNfiB+TCaQB5ancTYX/VQG+cyv4YpYw7l90e8zDGUHAjmp?=
 =?us-ascii?Q?3bq03ig7kI6+ALsCqgFxUzgrYIY37OAeBcy5UzDTTkuYQ6VQSS+r/hzNgdHq?=
 =?us-ascii?Q?ojoWQLRvifqyXMQsO9BS/TiS8NYgtC9a1y54n5XkjrKiGeoLa3jBlH1f1QP3?=
 =?us-ascii?Q?Tud62Sns7G9oO0EZyCotnCQls8R60eprnyaAMRaNRKJjBuZdidIN8P3KoCLw?=
 =?us-ascii?Q?vtyA/ShRJhxHy8mRmRe/z2gdIbaHcE2JFPqRg65+hEE/DPN1JA1dJ6XrUMj1?=
 =?us-ascii?Q?rT2yowtYJK4ZDttQOdwbUZ1/ZC6dM2nz8v5QEL5b/WdIh0++R80hfpoBSusq?=
 =?us-ascii?Q?zyhd+jehMao/DmRi3p6ZknE5B3F/wQC0nG8r3iN4i2sfo2hKutRo6ngbiWCs?=
 =?us-ascii?Q?zpGAlKCMe6depQ+Qylug1dr+LZPFxGCX8sz/KRj4w/DVPXLgn2uP2MVD5fU5?=
 =?us-ascii?Q?kJOxbuDZHB6Tca3huprrN0YgGxVz+4ZmDBdASV60saEuGcQEmvvFzLsiAvjC?=
 =?us-ascii?Q?y20NdLxtqxKa2HQNUTA4+0JBCBwVLJjSexz3oX8j1tRBLVCydpiN9zy8EWMj?=
 =?us-ascii?Q?hv8HBWxX2lIJ56PVcxFgbqKYw0JUiIpupRVgS2JhmTpw21wGiuyYXNVNd1TC?=
 =?us-ascii?Q?qC3Rj038KgXbvDhRnVYwgZSizTHSnwYZORgaUvknl+n5NV65CbhUuUjp5Slf?=
 =?us-ascii?Q?xTFS/BWrkhn0nEMDiqo4N9Ab8Ebv5aA7a+1BfABbkQwH/eEJ7r5Q2sReTZ6B?=
 =?us-ascii?Q?//l8zcdrzdE6L+pUx2oTPYCckqBw0ba3x5dEyhC3Rx2sOm+5o/alg25pScRH?=
 =?us-ascii?Q?lGgjWWlvzGAdd6rXXCkQP4P8v97Babpc0J4a4VgkpTcEBKEDv8KP+ECcfYIP?=
 =?us-ascii?Q?ZZEWu1zeFO8MHyJLh6eYSJZ+g5LjQjHJDCEtfE2Db6q7OaoSM/6W/f1x5/Dc?=
 =?us-ascii?Q?iXUzLCQlDFg4/xtJNUFhugqPH8QotvpBacf0pWBPrf9k+7l7WnDHJc1aTz8C?=
 =?us-ascii?Q?ZdFRLkWgjFXS3xkW2XiuzrMlYPIbMsrGetAzrPvUkFynJHf82gL97RqQddtN?=
 =?us-ascii?Q?nm8RBQrQ7lzK8fLuVnQpFqHUkChDAUqFwN4bHOIXNff0t8N3UdK9msTmIO5m?=
 =?us-ascii?Q?7x6FV3VmaefywWrNA/tm1bzeUe68Xwp+y6xbNTzqXexjjiZpycFWBl15su4l?=
 =?us-ascii?Q?H7Wj4MnA+HRLmTKat+i3hjcz3AczDwA38jEq+IqvzeijxRqlf9Y5dO/iG9TO?=
 =?us-ascii?Q?+Wsl9Cm8M3l/fkTjLpyNIoiFjeW2tKfFY1q2DpGRkLGaoesgeSPDpfJ4tosh?=
 =?us-ascii?Q?bufA4uEXdXh/hHWz0BeMFBEEfMJxcEuFdD/PKIiKvw6dfGEawlSXuqePMUNF?=
 =?us-ascii?Q?h+En+4UKUxXfjyitGk5LSk08MYZfzGFE+2DjFJ+XVW1BhO/UlUbxp7P2VSp8?=
 =?us-ascii?Q?OJXxcwa4+SUQnt0K23G9tc22eV00GsV3l0PeQ+gUHa32VRg+Qr4JZkKlfYkR?=
 =?us-ascii?Q?awMqTq7u4e5H4AtOIz3+4xMMwMbyX1e5goO9vlhOmj3AQpia67HALwBkn8kW?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e4d5ce-23d7-4c2a-9352-08dcf44974e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:32:31.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJLxxoQZlvmHaQtsPYDq4mXY3Ta2k2WPNVC0k1BCJ8AobBi2T7IKTm4rwdXPIUsMCHLNUAy1JZIDsnUH1TU3deHTKhQD/P/5RyFcLFodjjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 10/23/24 02:43, Dan Williams wrote:
> > When the CXL subsystem is built-in the module init order is determined
> > by Makefile order. That order violates expectations. The expectation is
> > that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> > the race cxl_mem will find the enabled CXL root ports it needs and if
> > cxl_acpi loses the race it will retrigger cxl_mem to attach via
> > cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> > enabled immediately upon cxl_acpi_probe() return. That in turn can only
> > happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> > before the cxl_acpi object in the Makefile.
> 
> 
> I'm having problems with understanding this. The acpi module is 
> initialised following the initcall levels, as defined by the code with 
> the subsys_initcall(cxl_acpi_init), and the cxl_mem module is not, so 
> AFAIK, there should not be any race there with the acpi module always 
> being initialised first. It I'm right, the problem should be another one 
> we do not know yet ...

This is a valid point, and I do think that cxl_port should also move to
subsys_initcall() for completeness.

However, the reason this Makefile change works, even though cxl_acpi
finishes init before cxl_port when both are built-in, is due to device
discovery order.

With the old Makefile order it is possible for cxl_mem to race
cxl_acpi_probe() in a way that defeats the cxl_bus_rescan() that is
there to resolve device discovery races.

> > Fix up the order to prevent initialization failures, and make sure that
> > cxl_port is built-in if cxl_acpi is also built-in.
> 
> ... or forcing cxl_port to be built-in is enough. I wonder how, without 
> it, the cxl root ports can be there for cxl_mem ...

It does not need to be there for cxl_mem. It is ok for cxl_mem to load
and complete enumeration well before cxl_acpi ever arrives. As long as
cxl_bus_rescan() enables those devices after the fact then everything is
ok.

The problematic case being fixed is the opposite, i.e. that
cxl_bus_rescan() completes and never triggers again after cxl_mem has
failed to find the root ports.

