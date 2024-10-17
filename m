Return-Path: <stable+bounces-86714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BA9A2F10
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519BC1C20A8A
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057A1DF26C;
	Thu, 17 Oct 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqnohMkl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C874168BD;
	Thu, 17 Oct 2024 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198375; cv=fail; b=f94K0beFb5r+TLeXa5vXA+Tlsh9x0qN8nNYrPFBNJUp5nI5k0a2d89+ZoAu47IeJR13Dk73dCPW/ZVbH1msATsFx0pNPGVB3PZbPhNorIYVRNDb87HL7DEW5VbRC1ftiqEkMmTh/eJLXVuPr/VaHUjw5lwp6qfxe9ldH+a13s8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198375; c=relaxed/simple;
	bh=sJnu3exnmH7QWjKT0fbOkxklApiYhVANXAs196O2K4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPTx25CL3Zx520Bwf3KWM0ElUAdCen0JEzHi6jxykhv2XGc1zrVkS6wOSq+aUSDK1opD5zZ4Tj7qTrStUn7LB5wANuE3izo5tbc6mWROx86NjuV7mHsXwr1Ygla8smgOx1CN9r4blU6gEMjpuQnnFrkeF/kmqCZFs9pk7eJ1dP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqnohMkl; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729198370; x=1760734370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sJnu3exnmH7QWjKT0fbOkxklApiYhVANXAs196O2K4Q=;
  b=EqnohMklqURGPgymxQsg/6eAI7rDxnMx6W5UsYF+nTTZm2sziDA6gTys
   JqElwd9tMKChTSsv7PyVmapkYcpg3qWF9enT7ZsjpkY9cqQkxbJPdw8U+
   9mX0B/RNmLHefCo6OvWLzZXHz4d2G4a9yWUEjbQ8sSGkGGnSofal97gBp
   7ycz3Pn7FSauaniI6NSpigZ/2z5YsrkRb6wrF4VBvBe/wf/rLWyekLFpR
   ZGFNCzwje9jcq2E4/JSa8ApKdbDEXKgQRn/F/oqZZiqJ2kE8rZeArp145
   yaeMoNQKHnrfgU+urxZfWhWTq+vCnSbgk/+tipjJ8N2ykMV2R78Xa6Vu/
   A==;
X-CSE-ConnectionGUID: f0rMmAvJQQqAYprUze7m/Q==
X-CSE-MsgGUID: aRSm1Q3zTWe0C2UAJ4FwUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28672101"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28672101"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 13:52:50 -0700
X-CSE-ConnectionGUID: klg4nc66QNuMSODD1VSsOw==
X-CSE-MsgGUID: +nQUmPNbQYedAkitkqYosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116110182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 13:52:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 13:52:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 13:52:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 13:52:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 13:52:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoTqrFkUezSAmZf/LBRSuir2sJT1yLAs1jtwHRZYLIhDsOwoxb5bRjNiN7RaScXBmzGuWVONVK7zis2UjG5kPSt0AbWArPE8f0ZL1zrDOJF38LUFYJFW058nOLQl46umFCosMi9zTrhYU732mMxhMKSkWcv8+tR4bC248df4qmXQO6OhhNv0ibPCU8X/MYNTrSLDPXhvMH3OPCKvx9r3BgBg7cByClA/0Ld1znVKZFKAc3QM/XfA78Tso4D0TIys+7bTQ8kXvxmb9GZvpVDQV+UxHph10HdM4zjPc2/V61csHBT/xDrAanPING0RFHdqzhoqoUHISPYzMh3mqLZRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlYwU17+Xi/2p4hLg2HNXSm/qpLxxxdQDTwHFheBDhE=;
 b=VBd25Js0ckE3p5aSsocPrcE2x5fKkVOIjtYnikSlPI+1qOKqXy/pV8RbDuxiFxL/KqYKdvsMn4WHhH7LNdQ4tVF+0fPcv23qfJuUSaauCuwcm/tfXwOr4bTJ4Iz88aRiOXv7ynh06Tnujq4S4LAaAtMXh6o6mj7Zu12lilyBfmyCgnIrPhO8Mac9vYPgyHOv9gzwlQL56YhBQ2ag0FsLP0/L8WJBFQ6llrQjWbwjOdKjHjWQVKBkJr1LVpl5H90t35v5v9Km03OKmYvLf6ajRiWVemFxmVkBPsHkHIgzq0vdTi6pO6aGFLxFeyZ3DVXvu8WBzFCzHXXJG9igEIYrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 20:52:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 20:52:43 +0000
Date: Thu, 17 Oct 2024 13:52:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <kexec@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<bhelgaas@google.com>, <andriy.shevchenko@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<ying.huang@intel.com>, <bhe@redhat.com>, <gourry@gourry.net>,
	<tglx@linutronix.de>, <takahiro.akashi@linaro.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <67117918aa217_10a0a294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241017190347.5578-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017190347.5578-1-gourry@gourry.net>
X-ClientProxiedBy: MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 543929d8-2eef-41fb-ea6b-08dceeeda5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6P+KMxHvyA4glfVrAN50S7zmoOMVJ5To33Qqmb3tCezAdXHCKHBq404M5a4?=
 =?us-ascii?Q?vG+C/fnVXmRGfFTNljcCFSq+yOlTs221ceuuTs85L3D3EicAwyjzjbZ9DAAp?=
 =?us-ascii?Q?tzkviw78nk0OfzZylBMZ/HqoeajHR9JkQIJzZFjQhMsHxFtOCeyJ1i5I5EDY?=
 =?us-ascii?Q?0mktgOwLPH5nyG5rZE9YDNTB13h7TCEbFFxb5VoduszzcINXuKL5c5NpiHWl?=
 =?us-ascii?Q?6agyHAuKbX1JCXEZwGMzihRGWgMOX73EWI2TVkHXnOX6yPpmL2BBO6ckwAic?=
 =?us-ascii?Q?Zxhn2N1jU6Kln7aqlSDOsJRQh7kePrY/udRZFUqsVk6IW4I7ZkR8XvmMOWvP?=
 =?us-ascii?Q?JlOdGn5Sxd9xTtu3QQnHgFnk5k3+hjd+VbfWI1dyEiZW/JeR+MtVyDlq5+fF?=
 =?us-ascii?Q?pWCTI2RI4CwOfE7HeuhnHxWbxbCd3jZ6r9k+hvirb3LBTb5UdFa6UiTvvrwf?=
 =?us-ascii?Q?0CQNLVvT0V4G1NoKxRPWdDu9AlRSgRE8/pt5yscYfVVXHoC9U17PwI6wNOt+?=
 =?us-ascii?Q?9H7kLf7FzHDvHyGruazwgXv2A02V//4QJfvbN/W7ld9M/ZZdPJ8XuO0vjq5X?=
 =?us-ascii?Q?Bsy+g5Nnv1YxWlqwGOgYJYJKq5tqV0jxrrMwdTtSQQi9YbJVCCSBGQr6hZ51?=
 =?us-ascii?Q?3qKNcKoLskl/smWvVNNX0SVLCDO2kbYNHuJmPpyluYgfrEjv1wcWJxxr/pvY?=
 =?us-ascii?Q?jdnQQuYxBT+CQndsZzWSyV/SERvwXKelOAcKDwPfX5kA1KH2giN3GRTI05TV?=
 =?us-ascii?Q?6serQ+EuyIpYcgKDtnx/isFGmgp5vebuZ1MhNWTzMUsXiVfyqngVs1dJT/Fl?=
 =?us-ascii?Q?CR6iBmEhTds4IXOLnzv9RUj/374bBC5XSQqPxXsAFMtix4nvhb8w4KJhDg3X?=
 =?us-ascii?Q?rD0bMICZLAgSQ/3hlKLJXx6JYoDoZq2sjg0RYO3xT53Sby8icd989D1HLjvR?=
 =?us-ascii?Q?1dDAlSmz5NcO44a1oGdHzVvmlSnawWp6kUDdmOwEPq/85qEeqWCriAvRJw8F?=
 =?us-ascii?Q?S9eWr+yCCx89aO4C9jjQcpUTBS007cadhkQdcSZjuOuQlN92Xmi5EQnz1hBA?=
 =?us-ascii?Q?Rugm1LVgFBGLhPY1D+D/pxH2DjD8A86mg7dIY3i0zf22UCD/uLbIaWIZOKuM?=
 =?us-ascii?Q?yf8Ag23cftmFJ6779kSI9FuMiBHXdIRRpm7EoXvhZo8Hwjdt9T52fqS1KzLx?=
 =?us-ascii?Q?qiQj4oTPg1VlwaFATKW+9j2vLLEOdcUaMfdVbqTs1k0FaCH1CIsuiRbY+Nep?=
 =?us-ascii?Q?bYiurVVmGnQJzdeoR5EBy9wBYlUn1/KWrNHLgu/nqJMXs40E5mfEloSmtFhz?=
 =?us-ascii?Q?wDzv2QBu2xe0wB5pxJRn20Io?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dudLHSBVd7whYlqkvWcO5hXb6jBVuRwFdcNau9fyKCI9etYDCBlDCgUBUBru?=
 =?us-ascii?Q?nO1cBBFM4rDCK1srgpvdzPAop1r23X60v8IaMzZL52WWj5pSGVjf3qVtObxl?=
 =?us-ascii?Q?pRGCOaMPtujRkpG7XclvtySeOiTfHJBX7dHZju2NycT2fMT2Ex2rc26as2xg?=
 =?us-ascii?Q?cjLerWyS1OgNzQRmpfpI3YgVrAVnNwQjXA7rrXGKFaXzHS31eJXLljNRgSUl?=
 =?us-ascii?Q?GWu1Plr6Qa2anYwumx0Y23cHFF9IFBxyaGpMwpkM4FE9XfeU93zqTMZA4mKu?=
 =?us-ascii?Q?tXBfgoZ95cX1ZIUltLhFXjsvDn3jF51WSe1MaejyOLaDKXLhY521kXJETx8w?=
 =?us-ascii?Q?MseQDauyjQ4Z4S9fqXswkj4+OsHbnewCZ7EeOBo7SKvNIgdFiCsM8uM/85F5?=
 =?us-ascii?Q?YQQ3waWV2S75gcHM4Wnyri5XKBd3qoeEvUjaG/2W87buxy/m+KgZ60qpqVGb?=
 =?us-ascii?Q?bK/S0AL/UxxQDLZiFiXjQ3go+1qCut6/gPvQV2Fvirz6zy9h5jeQUM4sA2rE?=
 =?us-ascii?Q?jgSY9hyEoKTJj13lSDmw60uv1KKNmMuK3KSHeCk0v+YtBEMy9JeTEiMlcl7L?=
 =?us-ascii?Q?LcsZmCyn1yq9z+83o8tAT8K+Jc0unCm7dawO8pmMNqCaZoaf/5AAGy7r2Qss?=
 =?us-ascii?Q?uLwed52uwU18OwBVkJVS2h65i4Im+36Gz+vv70ugbJ3WUkGJhxbbHGxECcj5?=
 =?us-ascii?Q?3Wc8bLfxVSv6LdCsjoJxWoaxeUXRrHkoPoyhKMjjb88Fu1G6OlMvGItf83aD?=
 =?us-ascii?Q?9ZnNyck2B/l4O1j9sSZ/H5nUkLHaq6nzbiyaJGavhPSZYj3FIixxZBH36vOU?=
 =?us-ascii?Q?v9Z1vj+ewJallC5XawLJ+vzFMHe1Vl9ZoP8XEtTlo+sr9z9wzHQoc5u5M01F?=
 =?us-ascii?Q?PvDmp4asL7z1TLeee2tByYK3yUdcOmDDxDXuUbC45b2P8wBX+P51joBJ7T3J?=
 =?us-ascii?Q?K5SwXI4sEmye3LG+ZA524hCi+/QcFxRuqffY0+861k8cosslkkVMDGlVs94b?=
 =?us-ascii?Q?Akw662IzSP6FtnTVeQIvAS7kZrrqRFJ76wByDkhR+Xod3oi21ZlZ+YItrbaR?=
 =?us-ascii?Q?At+xUxrxZRIaKHGptVFS2w9F4oMrB0IIIiQIAJk4KXd0GQ+ocOcrWQGHiQMn?=
 =?us-ascii?Q?B+z1lU6RcNtU+44JX+ubPjxblxgQCr8O5wpVNMZmg+rD1lxit+Z/KQ9vA0HE?=
 =?us-ascii?Q?vTiKLEF/YJo+rCiJNY28yoLSZg28HebyHDkGFS+woTuP3uKghzOQ7qR0ggfW?=
 =?us-ascii?Q?IP2gx9IxiFQTPfyYjjcenwtrbTG20Awr4TmDLnF33FZCsHSsMQ3Fosp8IGxQ?=
 =?us-ascii?Q?kj/IUA6wNE80utsA1cbFFj2eTu5InR35Rhb57HsWjXW3in2VytV07HfxOsKp?=
 =?us-ascii?Q?or7tohS5HTmv3MdZdJxRRJGEpiMK+ilx9kkJc0FbrVcUyTJtZwwK36ez7GQ1?=
 =?us-ascii?Q?f/xnGOzeH8zX4+LiXzg/f5V+K6+uERItVhIuyVUMHQfLWDwK6Vju95pnjLtb?=
 =?us-ascii?Q?scrDGcXT4VkYZebbPA5TRNU3mM0k1UZLh3m6nHI9Nz1Fitx6vnto35ryrAB7?=
 =?us-ascii?Q?TT1ATD60aPC7DeZ2FlEV4ilT35iEOnfT0nFgN5SqE4F/KsoR30fnfz07CRWl?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 543929d8-2eef-41fb-ea6b-08dceeeda5ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:52:43.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJMDk5ZSlip+5TtmKzRyQrUwUrqhVWzyBrzNUSu+39iF1FlG7/5Z8h89sMyf/7l1SlsZIuSOBU6iJcPlkz1MzIUWVOsEED8aIPiXp61BoEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com

Gregory Price wrote:
> walk_system_ram_res_rev() erroneously discards resource flags when
> passing the information to the callback.
> 
> This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> have these resources selected during kexec to store kexec buffers
> if that memory happens to be at placed above normal system ram.
> 
> This leads to undefined behavior after reboot. If the kexec buffer
> is never touched, nothing happens. If the kexec buffer is touched,
> it could lead to a crash (like below) or undefined behavior.
> 
> Tested on a system with CXL memory expanders with driver managed
> memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> showed the flags were being discarded and as a result the check
> for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> 
> find_next_iomem_res: name(System RAM (kmem))
> 		     start(10000000000)
> 		     end(1034fffffff)
> 		     flags(83000200)
> 
> locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> 
[..]
> Link: https://lore.kernel.org/all/20231114091658.228030-1-bhe@redhat.com/
> Fixes: 7acf164b259d ("resource: add walk_system_ram_res_rev()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  kernel/resource.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b730bd28b422..4101016e8b20 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -459,9 +459,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
>  			rams_size += 16;
>  		}
>  
> -		rams[i].start = res.start;
> -		rams[i++].end = res.end;
> -
> +		rams[i++] = res;
>  		start = res.end + 1;

Looks good to me, makes it obvious that everything that
find_next_iomem_res() would return for walk_system_ram_range() users is
the same as what walk_system_ram_res_rev() returns.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

