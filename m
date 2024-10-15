Return-Path: <stable+bounces-85078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D999DA8C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87108282FBA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB9A29;
	Tue, 15 Oct 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0zf5YuP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241B28EC;
	Tue, 15 Oct 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951061; cv=fail; b=koYmzfGFL9wl8+vokmuoXCl2F847FqJ2lmjXjaZtgjxYr3SZKZjTXMRtnQGthzf5yF87Dq2UG7Tt/kZcMym1VG2aEjynE7ReNBwMYHho05Tkq5nKCUypdSUEOyg+tO24TSBCXl3WsdFNXKilvLqUs/TYTCOklH1KDTg9ogja/lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951061; c=relaxed/simple;
	bh=8dij2pUbcQNAYrIbS2Tv2Vmytu30wocvWZWpjdHG7AM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MlXthTu3ecoTu/alU58XXBoyLA8gOHfKdkMlSHNYpl54gYTjDJjBKFv4pPA5TKksjE2PbyLSLHdIrgfxce0KlqYqyHxmIqRFLzN2/jQoBOH/9hzCqpuLWqxacWCGAYUGNiLWbLWPlvi6TDvLhisdeJwkyt3F5WAkhUgodxCYRvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0zf5YuP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728951059; x=1760487059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8dij2pUbcQNAYrIbS2Tv2Vmytu30wocvWZWpjdHG7AM=;
  b=W0zf5YuPT1BWN9mlnSBtDVrSgSvtPPHTrm61eXmB3pbQ+VW7GLCoVUfR
   caTJ5tNXWAR0HFPaczdhJakj5J1zI8RKM0BlfT0ecKES4DZ/rKQc+9wwT
   cPJSuQl10XKeV5e7+dXvB1muAzxl8i4l7zrkalruLygobh6AlWW0ILCQN
   UnNefIjSjIOya+/ufyKwMbD8CqiY5C0yBjuFpWXzp7MPG3oUIRmoglLGW
   kMCP8yiUrVcWZGED2Qp8Qe/9/jMrDl3/8SGLPA9ZUdiJA2ufkpUhmAx0Q
   xc67gY8H6By+UjzAxSSudkN0Qt5mgQSXlRV1FQRy6VD6J7zvwabEc+jXx
   g==;
X-CSE-ConnectionGUID: RzC9/f2KSmmKuk1fXMeVsw==
X-CSE-MsgGUID: HSu8cP8NSMuAT7wxZUgSfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32241499"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="32241499"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:10:58 -0700
X-CSE-ConnectionGUID: PE64+DR8Rr+9GLV7TSWViw==
X-CSE-MsgGUID: M0wGZNDtRIuz0SWazawXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77805836"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 17:10:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 17:10:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 17:10:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 17:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX2WE0Vli/WuEb7kg//9jDDuTAt2/dxmNxmzgzbwL+ZTqyPkBWtICAK57Pu30h6ZfhU27llz8v7WJcp0YgGHkhyPBqlYqyEj6rw1Z6Qw5AZl5kyX1yPmDZmq/Z+EnCasg15+rZzeTHdihmXvCpQ/e1rInmRaAEtvH7FJvBzXsd35nYHTeWtImJVh+5GrkzsP3eYUUWz2LtnDEtuq9nZ5w5y9AeoCvTbzWxapP769Db+AlCE8TJ+DqTqLvLVdtCBaxy3aeVTKfvcjHBuNBpWKsckrL/LbdDuZcINY/BvGH+djomfq9f/CfYPT/IJrjXuVLy5N4i0PZPuxM3SdtfwQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UQHc0pWjaPsfs0KHnjdvm5QEtqcbbbntTr1ZtGzXkE=;
 b=ILcTs5KPhyUAqhfVZ1dsNeqprKvVNGshsNLeHOq+GiokRbcK0kb4zwC+2dQwv8arVPB6sYu/Vuc3id5949XKQHNjVUFWU82j87WlYjD5vMrVtT9tDSMVk5cIPH6QoiWGkdvFaRdB5WuxgZ7K9PtmuV6Q/sn0BZGAV0p2+1tmkVvgvxLxHF6fIuuIFQr9XbMfBSy/OsFlkrnxyawIfFj1cEYgscsEvl50TTStdIaoEnO38sIMsyODTtKLcpqpgFmMQBuhLhBvKqcsVTqEWEDQLf+KM6XgvcV89KCIf0VMe0o259Ls4ZQUOr9wtF7VUmTbbog/6IDAjHICb6yEj7q+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 00:10:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 00:10:52 +0000
Date: Mon, 14 Oct 2024 17:10:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <670db30a1ea6f_3ee2294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
 <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
 <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
 <670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch>
 <695d1a26-255f-464b-884b-47a5b7421128@icloud.com>
 <670d71b354c30_3ee2294c4@dwillia2-xfh.jf.intel.com.notmuch>
 <4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb07626-8e61-4563-c970-08dcecadd4e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hvTTmHnX2uhTqK+xt35SHM5HkxRAbafkNYuwe5PJncLcTKOyLI+EdFBDtuAr?=
 =?us-ascii?Q?TakmBPQaOexQGHooB+9Ju+7w4Jw8RUOT2QEgwpMqNRkUVVa2JQhMeyU5FWDE?=
 =?us-ascii?Q?JBA9YEyeQAZjdczyJ5SYfuRmkVkG+Qh9qREBWT66ViX4gl/xSAiU/cxNlXsm?=
 =?us-ascii?Q?WWY2PLROM0Kfc0hBuGMromB3R/V85P754+HemK7WhbqL8jc8GiE5fAPVFKc3?=
 =?us-ascii?Q?aAvCyDew7t9CBZdCgCUhxGmVHNUp4gEjB3cd+35o98BES7OCAbfoMdEA41ZB?=
 =?us-ascii?Q?85B5QYrdUPcq+9E0XatNoZJxkmzlP1C+Th/OHs64u2k60RTXLUECfrOYNZfp?=
 =?us-ascii?Q?IY6Bn90N3pKDoLo9VY3CLdJEihjMEwBtmCxnc9B87ZCoLBSZJFnAs6G958jM?=
 =?us-ascii?Q?Gre2T3hNUS6KHoae5kfhlCPetAgHPIulz/LuMNfWWHJO89RYE40bUadgT4tn?=
 =?us-ascii?Q?PE4i04+xhvilAnAqCp1+IkgixhNk7aNSC263Tfh4CMe5Fmg/ppH0JF+ig2LP?=
 =?us-ascii?Q?26MW5T4gStlt9mRkaY3XtOix+GS93ceJS54f8crFV/rWLEW4JgA1lNj03mkD?=
 =?us-ascii?Q?3H24LER9NTyPUZPYZShFGmRTf72+5SZTNGukcQhjEUnjt/Jhv8DdaiVsaAQT?=
 =?us-ascii?Q?9xSB2ZSovzDfk+dZuUNwWlQRgGqB747rM/8DxEaWSyxxUS9q7XTK4xuXA6+T?=
 =?us-ascii?Q?bV5YPB/RbYR69lqQtS5iZvpFuTEunJbi8k4vxAxRUZtcpEAmqMD7o05ONeeG?=
 =?us-ascii?Q?KidqcYRX2wSG3Yu0da4BCuwpzfMGHYIbQccmy9C6+O1MMELmxQ+64LaonhYy?=
 =?us-ascii?Q?iITb0tcuS8xrGy1PcdgoyOvobdqS0c++eoydAzrbatuxiItLJjxSoD3pYvGh?=
 =?us-ascii?Q?YXLN0afjYzSqA3/oE1iPo5Tnf6FRKMoraR595TDQiyIbBfmi+c7oNSUOX0QQ?=
 =?us-ascii?Q?z/vHTt6MSNnyWWrjGBpDwjL69y5fegBGM+3R1EBUS+nKjdvL+5pKanwfEXvw?=
 =?us-ascii?Q?gKLdLRPM0KZFO2lzoCEJae+w6zBGvU/CFYeosPhri8fdToUskQsP+tUSxonF?=
 =?us-ascii?Q?+O6MsiTOjwbKIxufLaQWTvFX/JqJ90Mkx7sTUODTZMUQ6ciQIeJUt9ehsUBD?=
 =?us-ascii?Q?4eYdsFwm2eqhS8/EUzuA6YLOQkmFgbV/m3cp2X0ZTuh/VYlK9QqulEEzJC2M?=
 =?us-ascii?Q?xV9NtZEZL9DguGpwmqt7oQdFp/G/2MWcvaLBOR2iekB5tbdbdLWBt21bQGYX?=
 =?us-ascii?Q?T+mg8G/+stu33S5z+gorvDLozxsahou3qEflp7/zog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGwQK+gaa9LqIgLq44B6tJwxoiZnGnN7lIR3I9czPKoPN3fwf/gTblPyvV8C?=
 =?us-ascii?Q?eoH5bry+5XqJCHdOKL2L3+XOk4OHPF4AsLtQto2Am639llhkNP4qGN0M3GVP?=
 =?us-ascii?Q?MJu3FNmgcUyXLDnPapOpXlxwQlEzi4+unUJqLZBpzwtIpavhkcGyjmrXJJVf?=
 =?us-ascii?Q?37B+HVfuOmoaHv6H2S7Y1U30LV/ozohpg4yR1E4eQNuibI0o5fNonuI49lsZ?=
 =?us-ascii?Q?Lo1LMB2l/yINtkqX1unWfGu7eapQA0VWRw7+ERpNTkMCplmtNOIc9fS1cEXU?=
 =?us-ascii?Q?c8BFB+rwTXwYHeMHjemekSxFCDKzUaPOAwe7lV7tBkJ71SLeRJQazPfhb2qq?=
 =?us-ascii?Q?3T2ha1crsv30qrPiNWdwValfd9mBR4n1RsmCyU5Zk4BX330der1hgMofcfIE?=
 =?us-ascii?Q?YSi442RH5RXRTehcDK2TtTCa++khilhR1rgioMFfZlGggpOwntvl1Q5mWy70?=
 =?us-ascii?Q?vyKb/CHwzp4lpzY3ow3IMTKxz+FWZ4+UDUUFp925JvmMhjWo4kAQ3tRcc5kq?=
 =?us-ascii?Q?hDgRPJt7yqecPvQvoJaMOBgJKrAh2zmrLeKSwOSxNuAsAp/nPYZ9z8mR48Ph?=
 =?us-ascii?Q?UVe4UOaNm+08SfDi6q61kY8/3FET5CneFEg5tjZuCJSmJ3Cy+IepKpbwcBu+?=
 =?us-ascii?Q?MMNcwstW5i5vYLJ1Kdsfn+D8X5WfAZBazWc+7AIany6IL2EhTCc9HSnFljZe?=
 =?us-ascii?Q?fmNei/4x0CiQhXuzENaoFILfNSbXsPWW8C9LwvXdqkq6PovU4CmTjnPw4tX/?=
 =?us-ascii?Q?bNB8hyBFRUioOM4pB0wVfwuMkoEhKu0PeYWrv+wPWwu4v2zdxCRpXznSyii8?=
 =?us-ascii?Q?RcuZzdkgTOsPfU7OtcWqvopEOFuJGcVCfV01mk51czJq2w2EQKS0kqA3iES2?=
 =?us-ascii?Q?MJOPf9WoyqEHrXdsbnX7Q32XDkSRWkH+UxUPW3wA/Omqny/s5MJTM3zkyrAh?=
 =?us-ascii?Q?f44KnqPRgC5Mu6hr6poZPLwaPxc80JRLTTD5yxBOnCFIkrfOA9UXU94vF7I+?=
 =?us-ascii?Q?YjjIQ8yAW452mDPQowx/nWxmwDnXGruBfwLMSC0HBXDIVpy6D5owzvcq0S5w?=
 =?us-ascii?Q?4g6xM0Yj/bWkr//L8OQS2xU73rCW/4m3RU5f49HGoFuG1kBr8IA7xMG/PPn0?=
 =?us-ascii?Q?SLaYMqIhtqLq3e0ND86VG1ZJaLQAVZrALHP9yNleANXLx8nfV74FeFr3KijM?=
 =?us-ascii?Q?J401bVlAro5NU3hHAQEXRJPDaHczYZNelVQLFKAC/Iu3RCAMUsUmnap657er?=
 =?us-ascii?Q?NMrBNCd9S2uAc++V3XGh7WmPrCfx4BuTsu5vArgwEClIQm3YbklvCYI91ydS?=
 =?us-ascii?Q?vAp2ZB24PwaBm0aZPVHagYmaNSUXyMS5qsrX1RPcCOSdu5gWqoKO5wUiYy57?=
 =?us-ascii?Q?MdbUK4cp58Lp4rOq01J1IXrPsakp4bLCA5L1LZ7Omm5Xw9/lnkEdHDpSmTLu?=
 =?us-ascii?Q?nH9/eVcVH1bMTe7rqrwKlWI8+e0FJpHnGDmNN8H25m6G3QLPLX58llWbT8E+?=
 =?us-ascii?Q?KIzyjqcUwbZXyRNHOSI3pvFnKxcWshNjPHvS+HQqq4/zDvsrirJXNiRXKuJe?=
 =?us-ascii?Q?TNFc+1tvnL6/bEDwmqyQ7XPj86qYJFWd2JeykWwyQZ4vnxUNk2xgEGybERnM?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb07626-8e61-4563-c970-08dcecadd4e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 00:10:52.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kPP6OWqRN9pyBHoxRkr76YVrqfyXQvz0AzM6LGmDDMcyPxbGIzYYy2JSKgG1rTtDU9yADikfbXsjBdYD63UepVIrx7hPZSKznqLd3K4rt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/10/15 03:32, Dan Williams wrote:
> > Zijun Hu wrote:
> >> On 2024/10/13 06:16, Dan Williams wrote:
> >>> Zijun Hu wrote:
> >>> [..]
> >>>>>> it does NOT deserve, also does NOT need to introduce a new core driver
> >>>>>> API device_for_each_child_reverse_from(). existing
> >>>>>> device_for_each_child_reverse() can do what the _from() wants to do.
> >>>>>>
> 
> [snip]
> 
> >>> Introduce new superset calls with the additional parameter and then
> >>> rewrite the old routines to just have a simple wrapper that passes a
> >>> NULL @start parameter.
> >>>
> >>> Now, if Greg has the appetite to go touch all ~370 existing callers, so
> >>> be it, but introducing a superset-iterator-helper and a compat-wrapper
> >>> for legacy is the path I would take.
> >>>
> >>
> >> current kernel tree ONLY has 15 usages of
> >> device_for_each_child_reverse(), i would like to
> >> add an extra parameter @start as existing
> >> (class|driver)_for_each_device() and bus_for_each_(dev|drv)() do
> >> if it is required.
> > 
> > A new parameter to a new wrapper symbol sounds fine to me. Otherwise,
> > please do not go thrash all the call sites to pass an unused NULL @start
> > parameter. Just accept that device_for_each_* did not follow the
> > {class,driver,bus}_for_each_* example and instead introduce a new symbol
> > to wrap the new functionality that so far only has the single CXL user.
> > 
> 
> you maybe regard my idea as a alternative proposal if Greg dislike
> introducing a new core driver API. (^^)

If the proposal is to add an unwanted parameter to existing call sites
then yes, I would NAK that.

> > [..]
> >>> If I understand your question correctly you are asking how does
> >>> device_for_each_child_reverse_from() get used in
> >>> cxl_region_find_decoder() to enforce in-order allocation?
> >>>
> >>
> >> yes. your recommendation may help me understand it.
> >>
> 
> below simple solution should have same effect as your recommendation.
> also have below optimizations:
> 
> 1) it don't need new core API.
> 2) it is more efficient since it has minimal iterating.
> 
> i will submit it if you like it. (^^)

See the patch I just submitted, it does not handle the case of competing
allocations. The cxld->region check is not sufficient for determining
that the decoder is committed.

