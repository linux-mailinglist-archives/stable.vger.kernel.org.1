Return-Path: <stable+bounces-83601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A399B734
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E511C20E2D
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092D14A099;
	Sat, 12 Oct 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVPEpp5Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF72564;
	Sat, 12 Oct 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770289; cv=fail; b=Tmh8JBHzFmt9a/AAuZn+pn/C7Wv7yXC+m0Ay6N/aQR2s9yUrOPg7i11R8VrSkQTT8rTd0u3b9e11eEUfKGskrcAUFitkZOe+PBnPOsvfs14PnpCkouhdN5kmGvu12C95uddRa9nvo6c18oQonWNIdtCTruQERuWzEagbQHPgxW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770289; c=relaxed/simple;
	bh=5hasu5FFRzOAlcL8+cYWDI0NZBGfYN7sZ4ByLgRrUdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mBdBpHRc9BdMyKVJ8YICCdKats0xxLTBYt92H1juBh26b9WU1kMgAMNytN/GU9ymkqH9TBdN2U9Hp+fcX+nA5Kb/pdgJvVMmMVvSfH3MXzw459YNx5w/dy1M6iG2rub8p0IkO2peucAvpXWnZi55JsZcph/FJYvLL95KxvI+UHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVPEpp5Z; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728770287; x=1760306287;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5hasu5FFRzOAlcL8+cYWDI0NZBGfYN7sZ4ByLgRrUdg=;
  b=JVPEpp5Z+UAyWVFix+a00UvjiZicyUcqJ6Se7ldGnOwatzHL8wuvh+G0
   HrZCr4sNeLE/PzKNMBJRWm7PlH3owAoPN3Y1il9Kl5e9D2nq4sPoH0Fd/
   0f5y1QycrIqMhhoJt2jOQf5g6xNn+9JgTODzlmhZdPsVUoryvJGupeRbr
   xIkXGU2M5TUrMhnbdGR8wEDAbtYo2cmoHvwgdSyjZdaaR9uYSvU9pULK2
   LEwpCEkV+nUDXxPc+roun6SX4t5LJLNsRB5tCIfp0/hqmLFoWsvgWmiMx
   rdhsl415rI6h+QktHbXplj4etp+gcIWlF5eKIfqS3MuGqukK9PhrdJEyU
   Q==;
X-CSE-ConnectionGUID: ERc2S/LvQJiRIJItzoGddQ==
X-CSE-MsgGUID: K5JYmFhzR5a2hPQ31dGF7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28325555"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28325555"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 14:58:06 -0700
X-CSE-ConnectionGUID: +c4tRtBuSZywIQoyMJwT0A==
X-CSE-MsgGUID: C4g5cmMaSnmfHc/WAMvD+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82019460"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2024 14:58:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 14:58:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 14:58:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 14:58:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 14:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMc2r5hcLr+nOUpGjR6utZcFiS427zy6YnzkgfGkGb6WOwHNOhwT4n7LOCC2zk1f6Y0yCrr499pNwXNM/mI0VvUd4W10JsBYL7iBdM427rC5vC2pRdwsmb7T6sDiRZrKpUiU2oh97wQ+TxwTSitpVNvCcn4ImhV434IJpgC/1QqPmzgnrerzlB9ZQAsZkaA8qj+5Fdh3HE1AVZpwD3OZQYuTTUmkDselpwqOYsgHboQ4G5hiJkaVwB8O/nkE5UgU3Z6vAWY12CfVhJz2s+ALxaRTLMuz+lWhtXlDtBHMTp+jDJN2m1PkNX2x472gFoAtKcb7seWwDJlIDYoYr7NGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TFBf7Iztnec24yd/pnxmxPs6P0Zgor/mX0Nx9OFU5k=;
 b=dF4QUR96jydi3C+kK3ByhagNeh8XaRUk43zfwde7v6r/dEsmEYBhm3tC/icT9Sk4XKzBrHAgx4UK0JOsD9i0Ai9qgTA02vYA1EKEdtFgRml1D0/MtAfbz5zPp6xxwLK/5SQG4TuHvWf+cZ3cJNkBqZcu/et8i2C/SUSBzH+WFuYtu1zicvQ27Rv3hlWueCvRX1yPNu6i+VUKQMyUIrVZpwA+3YNZjxHFV6ANABpQfmiN7icNWu3fNJjDn1u4SASWHIvqvOkFoDJ8vo94/RTMZlum6aellU4zFTQY66pJ5c+81i1vkgWyhARBJggkqnXt2Aiq6QmkUwoPXK2BZlwqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 21:58:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 21:58:01 +0000
Date: Sat, 12 Oct 2024 14:57:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <stable@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Message-ID: <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcd3ffc-c1e8-417d-a576-08dceb08f110
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZhLI0vWugLCetmJfomfSyIgZZ6TcT4sLmNEzs6/to7BdfIKXhGXiinN3viH?=
 =?us-ascii?Q?Km5B+ncSUgOj5XZX4AlHOhIQTvBlieFfHN74uv7kQw9k0ZSqFJaObhCn6Cz8?=
 =?us-ascii?Q?FwEVOyyVshjIMMMsEE4myob5vSfzAebTECydVzljoZRyeEsZyTEXDj8/+WKP?=
 =?us-ascii?Q?VimUOYu02gi2L0aJJFPyQuShk49tCWVpWuUe8dQAunLEb+iWeL1lhpdzSol2?=
 =?us-ascii?Q?v0CO6Kg9diHiecLyc606aDZuLhuM3ZwOtj/iRa7VjpMLo+rpQtt5+gA2ADoy?=
 =?us-ascii?Q?8ZHNchnMwRSHtZnJ0VMbvX7XeJnZ6AElYPy67Fp9opdJh195RVJ2Vb44v46L?=
 =?us-ascii?Q?t+MybSYLVHm5ESUMxmYePRFO96sTDR4XVB9skhyElmPKy1bK33opYcgtVCp9?=
 =?us-ascii?Q?G1RKTSJXK9nVUHT6lR8HOu+7hhua/FdUw32fjp8RhB903qRUFmJUipofWueR?=
 =?us-ascii?Q?vUKTlkN9hceF8dwmr4ojbMB98y69B93VtOSc2KfT2PiXaKBtxPuKHV0CiBZ5?=
 =?us-ascii?Q?1JGiutggLZIX95LyKmekN0X3vTO3Pw0wT3yov6O6cl/5FkWRMBAwMikz5+5a?=
 =?us-ascii?Q?N90V1sl+gVI7+7VUrMUVdlJfGjtBOzwFJ0qxJr6WAgSyi+Q3bhxhG0oj0yyb?=
 =?us-ascii?Q?iFphgAx3xjBqRMd1+hfqklUjEtDKIfPgFIC2/I47pUHyXynwop7oH/ZZJRX3?=
 =?us-ascii?Q?w9cehB9LuOsJ6ld++lb96dnzzQb45fZJanU92gHJYMwZX6rvkwRnr4JzDNo3?=
 =?us-ascii?Q?U8pY/1iMoiKvvqxvpiMcV5NZGuzJmZ0FXw9mLRR6gaGKQOIBpWz4NKnIcLfV?=
 =?us-ascii?Q?r2bJGhnYl3JpKow93wW9HAIZscCVb8cXj0O4vPm8LsLDu/lMIQKCTEaqRcY2?=
 =?us-ascii?Q?QENd5g3cxEHgqXT9+i8Z2nYQLSyB7HqOcYDguBT6yWo1OML65NAN93S3NquM?=
 =?us-ascii?Q?Taug5Ryb1kg/4qN0l2FVb4ePoyR/kxu1DsJzgbvwD3bPGt9IvlAOdw+i3QFV?=
 =?us-ascii?Q?jxNLXVyNlZT093wVaICYqkNrKCPqumvfQ29AMOYQ7n78497urF2p3fjc5xWK?=
 =?us-ascii?Q?KKf3QsMD+jViwp4X5X6Abzm4WIetulqHe4P0nf/P3qjGK84XiGPYFhS2pLYK?=
 =?us-ascii?Q?Fqt/QvTK/qYnDH8YFuqlIcv/dSinQRDHChCvw1oIrjfYOoXC3zsEWhxgvgb9?=
 =?us-ascii?Q?L4U4WxH5Ux1cru5djafsgEVVxAOd2B5swS7XpEdautpaGZ2ttSI6vPAPRiZ7?=
 =?us-ascii?Q?WbN7EGtTOaQXLVDLnvieeVVjvqFnwzTxJ9BZ9mDkCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vrg5h0rsFYfxfkI2I+1fAV/V6FydhDxsTLjjnDfLrFVLzYogjWyIvVmjZ2/?=
 =?us-ascii?Q?nD4Y5X3wPai+W6o3Ht19+zfVb7QYC3eBcKhdsLf2PkFpA8JBV6I6LJkbgeI6?=
 =?us-ascii?Q?O8Asn44WaP3Ec6BYJIfQ5hQTXwI0JNSPNHOS8idR17Wee7syl7nqhoF67Bqu?=
 =?us-ascii?Q?W2ezDn8PG1lm6DkUn/xwfMehTH/DJ+w0xuagJhb80ow0px+M3wv+7Traoh28?=
 =?us-ascii?Q?gEfOqL6uUXDzyYGJAQXocP5jwUQ4QzlNB+h8FKfqCtXivaq1SSsTprcE0E79?=
 =?us-ascii?Q?racCXEkYADkcfCLFn+a5YrqSEdffzoz9CCDwSKv1fmCGgAQjgp+pTQ/gXzQw?=
 =?us-ascii?Q?CvzY1z5ivUDEoDb2ShFXtMaiwoWGfLVe9WifR2qMNicU9pQeE2GIZnN3f9t7?=
 =?us-ascii?Q?sOS0tT0OKm6yEI1QAPBrttd6+zMCeRFXuAUf12NiYG4AfwJtlyYbbHnMdOvd?=
 =?us-ascii?Q?/dfDwX++DAgB3gsW1CeuLvS23TPRGco4g3DnEzT40l1JXcHmvzFPcKEFtjJA?=
 =?us-ascii?Q?xwrHyojRRTA7eYkWznpfV/lSF3EwhW6fvIJG0JHcDS2QNK/s+ijqJIYL+ANm?=
 =?us-ascii?Q?7C8Pbyw5svRFnXlAeQdvQSkizt06DW+eYfUsB+K3vMihWmEJZLj8Lsu39Sti?=
 =?us-ascii?Q?0bhOUO4oNlUFXKhP90EEHGrwratGiBbTsvCDJlFyYyg+jtMAnczO/DzhbsqQ?=
 =?us-ascii?Q?SKfrL4FG+KU9gFuxDycqx/a7rOJ1dAzpPXZ/lGa8NfKoONV3ID0PDuni8bWY?=
 =?us-ascii?Q?YiHOlm7evmMsde02WBjis0/puWRP8kAdw2YKsyU/+4S/RgGr/QmLVkEVXZlc?=
 =?us-ascii?Q?sEI5m4klzJMhk5Ah2NC7jVjMl1+a65WWwTf0pqiHYmj/2/5KloCkoiOkxN78?=
 =?us-ascii?Q?XsXYHChsS//gtXkuUTl7cEREHMr+MibDUhLgfFsa/7qxuBz6CB7mezr4e22q?=
 =?us-ascii?Q?4hjl5m4vDPRKiM3E2j7QHz5qHiiKRMhU+rv2PMRL/tRDIm666wRrpzpiBCN+?=
 =?us-ascii?Q?oR5s+3me2qOU4S6Xf21th9UWf04l+ipnahOna1G1hoqVDjYrs9z2mKFWbNkL?=
 =?us-ascii?Q?bJoOf5NZFIGRKOYFPhvMsDqs4lrrpjakcPxXZBgJeNjw8fYHSU6EWCUn5Kf1?=
 =?us-ascii?Q?gVETs4ktKl27v77y3ljiuhsDsalzWaos+mUgaInLB04P1ayQrHaCZJIdYy6R?=
 =?us-ascii?Q?Un587IN465isClVdyWB5EUrYZ0jO4BbYfnV3zW7dpAMFlVWEVfWF2S70HgCe?=
 =?us-ascii?Q?oiynZ9ZcgofUrGbuPJqr1RFy4EF4QM9PUPuvXOo4LixOB0KKA4SNApX1jWD+?=
 =?us-ascii?Q?MdR5JcbKuX6NoHYpA/yLC7A19UquHThKeo5MJWDrkD0LnMb7qDTCBq9d2nDp?=
 =?us-ascii?Q?8PpF02CL8j1ZsL3U7+b/8G3aEBbssCgndGJVV4Ft97GuLDraP4BZcjXtT9au?=
 =?us-ascii?Q?VeX1jr90XHqbHKzunu2qfhJCUxMcfxInjdW5V9eIfLFvgnWEGi5+7ogRHuNL?=
 =?us-ascii?Q?qErD5qf5TRTQ7C2PZchag+hnakuHcDDzh83O4Q8uBMLE+hdTB1jJVSu3zeuR?=
 =?us-ascii?Q?QjTWl5n+uxnbqhXSCjRXuSYSfsuOI5Z3nbjwnQSXQwpoX/We7x7mjiSAZ1DG?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcd3ffc-c1e8-417d-a576-08dceb08f110
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 21:58:01.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTwcl+p7Vgw/wk5f06rTkW7uWS0Muzv0lu8y5Z+PxLhiM403NwjfhI5NxfUjU16bbDwYM6kARMVeYm1r3P0XQuXtTpXakiFBzihvzEu/3sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
> > device-readiness bug. Some other assumption is violated if that is
> > required.
> 
> 
> But that problem is not about device readiness but just how the device 
> model works. In this case the memdev creation is adding devices, no real 
> ones but those abstractions we use from the device model, and that 
> device creation is done asynchronously.

Device creation is not done asynchronously, the PCI driver is attaching
asynchrounously. When the PCI driver attaches it creates memdevs and
those are attached to cxl_mem synchronously.

> memdev, a Type2 driver in my case, is going to work with such a device 
> abstraction just after the memdev creation, it is not there yet.

Oh, is the concern that you always want to have the memdev attached to
cxl_mem immediately after it is registered?

I think that is another case where "MODULE_SOFTDEP("pre: cxl_mem")" is
needed. However, to fix this situation once and for all I think I would
rather just drop all this modularity and move both cxl_port and cxl_mem
to be drivers internal to cxl_core.ko similar to the cxl_region driver.


> It is true that clx_mem_probe will interact with the real device, but
> the fact is such a function is not invoked by the device model
> synchronously, so the code using such a device abstraction needs to
> wait until it is there. With this flag the waiting is implicit to
> device creation.  Without that flag other "nasty dancing" with delays
> and checks needs to be done as the code in v3 did.

It is invoked synchronously *if* the driver is loaded *and* the user has
not forced asynchronous attach on the command line in which case they
get to keep the pieces.

> > For the type-2 case I did have an EPROBE_DEFER in my initial RFC on the
> > assumption that an accelerator driver might want to wait until CXL is
> > initialized before the base accelerator proceeds. However, if
> > accelerator drivers behave the same as the cxl_pci driver and are ok
> > with asynchronus arrival of CXL functionality then no deferral is
> > needed.
> 
> 
> I think deferring the accel driver makes sense. In the sfc driver case, 
> it could work without CXL and then change to use it once the CXL kernel 
> support is fully initialised, but I guess other accel drivers will rely 
> on CXL with no other option, and even with the sfc driver, supporting 
> such a change will make the code far more complex.

Makes sense.

> > Otherwise, the only motivation for synchronous probing I can think of
> > would be to have more predictable naming of kernel objects. So yes, I
> > would be curious to understand what scenarios probe deferral is still
> > needed.
> 
> OK. I will keep that patch with the last change in the v4. Let's discuss 
> this further with that patch as a reference.

EPROBE_DEFER when CXL is not ready yet is fine in the sfc driver, just
comment that the driver does not have a PCIe-only operation mode and
requires that CXL initializes.

