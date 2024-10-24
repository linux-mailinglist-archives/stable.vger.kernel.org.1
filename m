Return-Path: <stable+bounces-88093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB569AEB28
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F51C23F85
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457B1EF08D;
	Thu, 24 Oct 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii3hXZwj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DF1B0F26;
	Thu, 24 Oct 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785348; cv=fail; b=AKGOhOi8xV1Q4bg3X6aZCKlwGmBs02GkDXYqx3qsjB219XnEHXKSCBKHzdNuoB9A4Ql3JAPoKBkJwKjPZP4HwGYzhz3bCAN5jiN364Mb4w2bYg4CTOirge+A5+Xm7IRs2z01jgdmI6WscGwvxF322xZQYzpqZzj2SSgGGEyJYpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785348; c=relaxed/simple;
	bh=6gS5h8Zp2Ca0RDR89THFsVZXDP2g7mVa8SyZB9EZG4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OoCuHwVUUYoSmDcdd/SwmSmn5DykGyYfR9BekeBZqtzbyfvxPbMGgmSGe5bW3BsqvJcgqFoucEek1hY7a4oStm22APy74MdDk+dS0oDjn9JQ4hPivfy89Li2S17mipfzgVA4JnLp+K1/eqLlEbONsg1ORKSs1Yj8Z3qVDrCRrjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii3hXZwj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729785346; x=1761321346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6gS5h8Zp2Ca0RDR89THFsVZXDP2g7mVa8SyZB9EZG4A=;
  b=ii3hXZwjxvsKRzyqriIvSX+ORadRdujLrNUcCGg7o1B8s0dVPGc0Rnit
   zPssefDsMTIBihz6Pkqt9rc/GhsUNgQG2FJ+ct4qWR5U2aM8AdISKBI1f
   vYHGWhRstwWXlTU7QpgnJoSE5WiYZpZcmTbzFo97au3YaK7YqkUwofLsu
   Go7i7HS9ekJjvGpf0lq609owuVkcrtB22dj/vgS1ZB/1cmrnK1wF2AhgI
   mCnfCTg5AXAFzMZp4pwpZL11N1C0FLKIOqaaHCkXJi2RL1/elKJi6tz93
   LF8ZFCOvmDx/Oa4sTCRv2EOZhZY1pWO+la2fQxQX7qLafBCmUbBiQ3MKZ
   Q==;
X-CSE-ConnectionGUID: Hkav2NVkR5enFgxjDvUv4Q==
X-CSE-MsgGUID: cQdMuXLsQ52veveJKgskLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29328931"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29328931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:55:45 -0700
X-CSE-ConnectionGUID: UX31HOOsSrOliZHDMkJFGg==
X-CSE-MsgGUID: UOsLsY/FQX6l2Yx5v8kbxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85414184"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 08:55:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 08:55:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 08:55:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 08:55:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm/R7h3ESlAwGx/AXEQc1oJU7mEwgA7BQIMMLESyyyIkrS4Q9460b5IJzSCPwEKeq5EpU6P+Gc3KAfAMuV565tqa+7IeiwyTj7dVJHDgJbDCVMtNgAHhYtlTsIlc22dPnKBH1WKzJP5o+nylC77y2c4pTXGAhEvmQixIsEwuMZ1rYg4FLNRrn1lMt+Nn0nWzz+mQ7sM252np5+QuYBvCAv9CavbHhr0j/awpyJI5m/v6TENLOJ0+vU5wSqtWCB7dqJUfA+GNl2XchikTM25crmKB5gJ2yhQvUSbH/b5k2bRVEC2+w6xDkDZuk5ACEPgBHkGE6YyX/GHH3ecZwFx83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDnCE00g7dKYRcL2Mr6LPE0oDp6T+fCUPHyuzTmAUW8=;
 b=TjcsPnDzvua6FbzVSO2TlaOqBCd32kbU4QxTzoiktQmuN/MqNuBIz2RUUdqkG4P3phb0eFjtfoiHRFJb6ta9V7bdd1hmJVBaMp4ZnsKc4LY4YuJfhWS5gJiDQRJfwQLxFuBOU5+kvked9T0E0fi5xYY77eXtmmVhZxtGegLVjCSe2hX3GpIsF4Z6r9xXV3hLw6Fv05TpOdHX6NpIpcAFkqUMmbMYH0/Ipk5ZibKdqTxo6BSnVueSxtdU7HtOC4F2NurMTU7J1+joMTzO/MYjEqZWv6Nk4oFAodL3TSVOM/6EZDEuQngaG/leOFqVJq6VDPPu2jdrTuI5bXsBAftxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 15:55:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 15:55:38 +0000
Date: Thu, 24 Oct 2024 10:55:32 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: <stable@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <671a6df43087f_f5b20294ed@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964782781.81806.17902885593105284330.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964782781.81806.17902885593105284330.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:303:8c::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c70b807-bef3-4f20-27c6-08dcf4444ddb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o8abOuZ+tXqXtE9l9J+O5OBV73uWTJl6gB/xHvip2PEol2KfHrxE9oG6p6aR?=
 =?us-ascii?Q?oaZPKqyZSZxgGAm/U2XLyDb6uHhW0MwXJdzDOWR3UF7OIW/Ycj2Ku5BGr8ax?=
 =?us-ascii?Q?xfn1TrFAGi2LzDAgdyvLFH2zVjA1UdX+py5toORg0OCyRH5CUJKBmbJmmUyE?=
 =?us-ascii?Q?juf7l88LNM39KyUGlLsFm5OTNq5dGsutefoHUOWOV6sgA0RJ4/BXG0mT6yL4?=
 =?us-ascii?Q?hX4bXAX3npUVqV3T357wt3KpFC2QZ96H9ZivBF/HMUDvfABdQSO8XLV1CuRv?=
 =?us-ascii?Q?phs5+Ul5WRhPZC2PVEb4EU13/+9rCgxNV6taMqboqWDSZ9SgrWuDzCXyqxlF?=
 =?us-ascii?Q?eWSfs9iRhubehyp66Mz6C7nnGFsccJrXQRVVxLvOCDc9/Wcz7fkMCgp0MODF?=
 =?us-ascii?Q?bT97aPpOqpaN2PVvUhycEIOZPzuECYjq08IEdZ/SqMpGXAxyx1Ld26XwnQH6?=
 =?us-ascii?Q?u5fsPmRpRGd94Y/lqrbbnfQS9nuHlzRnpyc/XZc66po8E2INDIJmsprDcVUl?=
 =?us-ascii?Q?ItM/rGQ88nMX/nG9iVVEqZbSuiCNdL+jgbv7padvQk7S7Xe1oM0DkdFWpxf7?=
 =?us-ascii?Q?8IPOTdDJF2QLVN5pJ2lyL4HJUAXuMZyZznpxgM4rlb3Y15vmLii/rEnkBxxt?=
 =?us-ascii?Q?dQNy3MOPqdteenSm0JVRilLub5v5wEmmxD7y9q0QlFbop9RswNfFkER2uIiS?=
 =?us-ascii?Q?yFVhhTxKAWe/2dp5w4BtaOc2CGh8XPGPKcvXs9AiaShpN543GPvP0SWL8E0W?=
 =?us-ascii?Q?O6gPrWQNkx4MO/5kS0TYrudidpbacbDnhzkduVaUs+JekGRbJOF2AGFyocAe?=
 =?us-ascii?Q?rRixH+3KV8gkxw6u3tifw1k3KeH6NhyWlXpMSmDSNAZx7S/P3H/CfsFvpT5e?=
 =?us-ascii?Q?YKr/i3NMzo52C6IOjfOxSw/3MoDkn7visWYjtiE+S4+DMbAb5Pz/HIcCbC4U?=
 =?us-ascii?Q?pXzMTwVhZtnuLg8Z7xxYQeuwFnMMHV7lzpcyUZVUWHD7SvW7dKihgiTcS1am?=
 =?us-ascii?Q?mWk4nQkW/Vqfw0dnzRJMsM/5funlBfuC9uUNwYbvakvaCz2BWncgPu4X6jJl?=
 =?us-ascii?Q?nFrFJeQdlZw5aswAsBGtYuw244EY8+wdRRV9kSuOK/NBQ6EfoUzeeaBsT0n0?=
 =?us-ascii?Q?64c8dPGO8m68XFmNqCqOC4LrnJThEZWOoz/HlFqfLVJsvC0DDXyNZYrqwkOP?=
 =?us-ascii?Q?yLyBB9Hm88Xwkb78duP8eYB64zq33Q8fHBSTxBq2Dv+Z3mKBhdGkww7SS+UP?=
 =?us-ascii?Q?ud1YuBaO4C2xOmfTMKiV9U8qf15nsvmPLNdqkI69ciMrWR8hvmE1j+PwhjEg?=
 =?us-ascii?Q?rGrXcMia6E79vfSQ9wStIShW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBM9h1Ir5a5VUZMe3y7kFUwQ3MUDzL5bUGfm+cVgGzMf6TOGBAN2YjV1xJop?=
 =?us-ascii?Q?UzYhC6IoBytSbiB6/aHC2UemTOn0/rHzhS5GhH/lwlNUQ5NIemV9s4x2xK6I?=
 =?us-ascii?Q?dkE/89QNR+Ge6G9URoGnp22rKIndyhroTwqwwD+wgEmJdeyG2oS512jwOE8v?=
 =?us-ascii?Q?pj+8yTSlKSwEqN4RlWQkLCZKcNFSctaJMIYKCTAKLKWIEcernLqX6y5aIIkr?=
 =?us-ascii?Q?uu0c6FLOasvdywDEFop57YjeeVYa3eiAootJopr9VIRVcZgPdBWjAQ+2Hdoi?=
 =?us-ascii?Q?izSUi3lP6+ywt+9TjbhGZFTukE+53w/lGGKT00i2xf/ZcbSp7BsxDSB7LqnW?=
 =?us-ascii?Q?Qas5P8xEj3sBNw2ZENlIPe7aonRloTewMenNzlL4hhW4ufWDZx4B5YyTMbA8?=
 =?us-ascii?Q?/ljSewbc8KurznNCcPHKMjXd8fp1aTXg8+AwLPClqV5jnTgWbd0W8tTbe+Lt?=
 =?us-ascii?Q?WD7piAcnX1Ivzlb3BbKjJQiruHEFuG7ZlKPRXKoSmVvIM6udM3FSC9C8S+9s?=
 =?us-ascii?Q?1CXQ2P7QC9TghFLogdyXF3hoU8EPhH59h8c2CmwFBOyEe1gnEYJWgbDCXp6m?=
 =?us-ascii?Q?z+3SJj7aNBIPQRx2Y+7aQJIWxr47XdCDNOh8o5aFmsV3LNCm/KIHcBWpQ+78?=
 =?us-ascii?Q?3Ry6tOPxuhlRciMO2lnJRyMtB2OuVI31Hh7o6NwD218STVj/zk+wk9MnUNWI?=
 =?us-ascii?Q?xyjHEiBp/xWri65F7Ic7vRj5WlK9VbUT7iO7WqcJf5aZGQfrVLM4HjYnY6vC?=
 =?us-ascii?Q?c8dx/7Ag3lfLWCnh0PxvKLd7JlFXeuCtxCywzfOUyduaqcdOIoavSh0s47Gw?=
 =?us-ascii?Q?DUZypTBHFtaFr7b84N3mqxPl/ZQP+aldZlYmtkhaayD9irr0CbrhfRLtshNr?=
 =?us-ascii?Q?pfR4GH4zVTm4ZvCSilusUWNdhf/hv6/3KFcrejUmAgfPkJa9QLzr7XVuo3it?=
 =?us-ascii?Q?BeyJRInxGRNyc2U0yKHgzryBwhloOJw3YyDQ0BkW86/Twl7+ZybjV4sTqgXM?=
 =?us-ascii?Q?VA5sTyKfCDG11BJG6nHKHlGn6XQ2/AYw0oFN/xqBd4HomUDHOig5RcABeior?=
 =?us-ascii?Q?DO0fvFKEyCvh7CpTEUCHVF4M1nYbAwG9NfH6wnPyvIs3BAqF/yjH4MYfDSkX?=
 =?us-ascii?Q?Dts5/7Xa/lMl6gHnWVII7MZDPC06idKf/quDBejPNut2m79dH5fh9GeQfWbN?=
 =?us-ascii?Q?jFKvKEV0bOstQQRDztSHfhGMkxfezXhXaBCR/korex87G46cvjC5aFXIbl68?=
 =?us-ascii?Q?fRmOwmXIGW5pCalfCQ1slv5jnFCp5rr5r5FnflTKs+9wpmz7UD2TR3OOsr/t?=
 =?us-ascii?Q?JwJou5PzvVswDSmj75qekhPjSXS/XAYSdYtA5qaLERR0qkB9HiioKhUKiYPz?=
 =?us-ascii?Q?NHcdRrYu09229lWGqQlejXGLGo/Gp9i4y35IXn4H8KXdp+v7j4N5+kXc73Cr?=
 =?us-ascii?Q?TwNqdfGvrqbok0H8OIKIpl5tY5GDMvpSEKjQgCD1jg0NRYXGUuLdns92+J7c?=
 =?us-ascii?Q?GoDwSGD/hhiE1g3ZgK8IsgSoVcnZR41MYVIUUaYQu14BGATkihaNUbBZh6RI?=
 =?us-ascii?Q?LninJ+UBweKXhOZaIhanI2EgYmM82n0SCk6DFdG6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c70b807-bef3-4f20-27c6-08dcf4444ddb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:55:38.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1giPwQfsIZmlGluyBlqc6HiVW7eSDcFyWa25cw+P/zUCL4l9aW0hgj11bNZ308ZDq2/wcvePpcNkugBT0yXww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com

Dan Williams wrote:
> In support of investigating an initialization failure report [1],
> cxl_test was updated to register mock memory-devices after the mock
> root-port/bus device had been registered. That led to cxl_test crashing
> with a use-after-free bug with the following signature:
> 
>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
>     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
>     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
> 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
>     [..]
>     cxld_unregister: cxl decoder14.0:
>     cxl_region_decode_reset: cxl_region region3:
>     mock_decoder_reset: cxl_port port3: decoder3.0 reset
> 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
>     cxl_endpoint_decoder_release: cxl decoder14.0:
>     [..]
>     cxld_unregister: cxl decoder7.0:
> 3)  cxl_region_decode_reset: cxl_region region3:
>     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
>     [..]
>     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
>     [..]
>     Call Trace:
>      <TASK>
>      cxl_region_decode_reset+0x69/0x190 [cxl_core]
>      cxl_region_detach+0xe8/0x210 [cxl_core]
>      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>      cxld_unregister+0x5d/0x60 [cxl_core]
> 
> At 1) a region has been established with 2 endpoint decoders (7.0 and
> 14.0). Those endpoints share a common switch-decoder in the topology
> (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
> the "out of order reset case" in the switch decoder. The effect though
> is that region3 cleanup is aborted leaving it in-tact and
> referencing decoder14.0. At 3) the second attempt to teardown region3
> trips over the stale decoder14.0 object which has long since been
> deleted.
> 
> The fix here is to recognize that the CXL specification places no
> mandate on in-order shutdown of switch-decoders, the driver enforces
> in-order allocation, and hardware enforces in-order commit. So, rather
> than fail and leave objects dangling, always remove them.
> 
> In support of making cxl_region_decode_reset() always succeed,
> cxl_region_invalidate_memregion() failures are turned into warnings.
> Crashing the kernel is ok there since system integrity is at risk if
> caches cannot be managed around physical address mutation events like
> CXL region destruction.
> 
> A new device_for_each_child_reverse_from() is added to cleanup
> port->commit_end after all dependent decoders have been disabled. In
> other words if decoders are allocated 0->1->2 and disabled 1->2->0 then
> port->commit_end only decrements from 2 after 2 has been disabled, and
> it decrements all the way to zero since 1 was disabled previously.
> 
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Cc: <stable@vger.kernel.org>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Zijun Hu <quic_zijuhu@quicinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>


[snip]

