Return-Path: <stable+bounces-89246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15839B52CA
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E248283F96
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEDC207205;
	Tue, 29 Oct 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrwoeV19"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B69ED53F
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230405; cv=fail; b=iTt/mNv+SybcFjYDndLlUxu9IX4+VyviITF8wsNtJ1Ojbud/L1/nET8FEcvYFV2780Uwcbuqnos4ADZhsbP2exEqW9plGkCB0W7/DCWJt8oIQlK9FnucgL9HlTfrr2JO+lhqmh0G/WfQpBeL+85J8pnLyKrkagiSHeQaCVvesYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230405; c=relaxed/simple;
	bh=lXszE66C6kflIZKAKLfAZrf8Xwlldf4SCpY5iFcQsLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TmEW8xq/ueSfwEFDblHmZp92Ng6lyASvfqx5KidPeV8AYcru5QUHE1ICuzRuwLXe6DoVhlAwSJYY21QeBixwKkgiTz5LYFAf1KtYS7Hlqxjtc40A97nycSvVqYPSRNhGIJTHBUObGla+vFLUgkWyrFuiKX2Y7ePLK/z54yINZb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrwoeV19; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730230402; x=1761766402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lXszE66C6kflIZKAKLfAZrf8Xwlldf4SCpY5iFcQsLM=;
  b=SrwoeV19Plmzt9ItYM1S/8V9S5QrdPi4En3s7+NK4l7V68FIonjAJ5YY
   C4CUc2jdLfHT0oWjUI5X5Tr9BHhzQdZ275Zs+WfZkMB/1u85fuk28kpQS
   lpuTrqHNlIa6/v0aLw/wj+3oZOZP1UyyBUee2OKrzuSSeecc09ahe4ydb
   iVxnmwaCQG0tzdl6dihATQT/5MyvJnoCps/UzseyEka7t6/zYWGuagKYH
   I52nX6bvm3Co0D5AqHf4q3/islgMNaV+Q14f1qZYvQasJD42NY+NiUEHk
   5Welp3PA4x2hpgZSCg+0imizXggQMoAaJEOYdJIGsg/1yqhK3j6o9lHHM
   g==;
X-CSE-ConnectionGUID: 1XcbgbJgRuOv+KjPvrbUYg==
X-CSE-MsgGUID: k7kwRiAyRRCWo2Jd3gCXxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29797882"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29797882"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:33:21 -0700
X-CSE-ConnectionGUID: vDbQXYvbQ6i8opxO5es2eA==
X-CSE-MsgGUID: lSB6Xo/5TmiQoxWdr59hjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81696615"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 12:33:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:33:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 12:33:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 12:33:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4yy2zC2BBa1ZtdAbvQPJhbYsWG2dsr207BeUb3U2Ggl1Ez/pPENiinMNwDMMuWpYai7oaLyduxo3X1m8j6OyJ+lZWnFRrSmg9DMuk/EvjKanWH6Ih8U0w1/Lle58YNNfvvnl9/Y6Z3nQOWKjwUydSfsSW0Y8V6lEGzDfQCbxbZXRvEja3CjSClTAuSh2ZazQ9hEAAjIoBIOue1SemXuVspx5X+pvWvVb52V6fNzTDLEo4bQZ1Jt2IMBWaklji+Qu1T912Pc2OuynT8fyNQmMa9fbmw3KN1j/JPmEslv6Raii9fqywP/Apx0KeISzzzWK1RtQa4TDHZx6l4+FbDA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmFkKyJT/ozgqd4j1skb5b3vqeLh6rWd5hB3AorRwvs=;
 b=yvheayEqrbJ68eJ4zVk58GtB0VWWWY5ZO3Ga63upzjntNa8ZH9C3RdUJUGxxVuzImyJKMSLn0wYaRGfbFXSdvA7F21dKKQfjlmFKbG32qJei4v6/lPGHruCDPwbMeUd8d60DGy53q5f7+fkMe4EWlZH5axSu2nE/4XMJ6c1zZtNv3uhKhautKomWg3WD3f7Se2mEkhVJoCHxhPUa0UT3zxIwz3ml9kgbsfY0cF6ph9py0O9JDlR2a6uZk+sT+TGajDw2ccbYrGZGpfS9o5OUoJKUWvAkgxrwlX2GdFhVY+nnIMuxT04KvubeoxAAcAQ7HX3k/LTDZKOox9uOIrwg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 19:33:16 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::8dd1:f169:5266:e16e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::8dd1:f169:5266:e16e%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 19:33:16 +0000
Date: Tue, 29 Oct 2024 12:33:13 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, Jonathan Cavitt
	<jonathan.cavitt@intel.com>, <intel-xe@lists.freedesktop.org>,
	<saurabhg.gupta@intel.com>, <alex.zuo@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <john.c.harrison@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
 <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
 <854j4uzv79.wl-ashutosh.dixit@intel.com>
 <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
X-ClientProxiedBy: BY3PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::12) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 247cb535-4e9c-4290-594d-08dcf85088e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kiq9Sa36bEhzsgwYWZsZ7zqNWEJ7qOEHSaiEjvDQ9ONX5bsAMvXXl7fYQMJ?=
 =?us-ascii?Q?1rLd86RSZRLRBwVSCkVDFnSqKFHt772Xev/9uLFYnpNxLUGc5tUiMAWBmC+l?=
 =?us-ascii?Q?jAHK64FkQtzDaNeqrZo9rZVKyitH3xoK+wwxefUnvZ9jYUZwnmfYjrQYNEgn?=
 =?us-ascii?Q?mgIyFOpsASPm/BNqKwktB8lcda2V2cE045dIjkKsrfqdoYm2NrJiGO5vwbs2?=
 =?us-ascii?Q?Feggz+3ZOZMjCVZz5697LmH8R/5hxQ4+sd8S62sEvopi9vqjbwZRBfcqjbhH?=
 =?us-ascii?Q?Ktn88f/Re4151zHOv34JZs/8nLmLLbOkSaRE6xUj6fNzrzz/HiYHY8QitMEU?=
 =?us-ascii?Q?Xnel40ycwmJ1ZSjyBm0KKhoPWMVz3UbhDBuQ6IFBbVOQmhKVmNMypP4fzVEp?=
 =?us-ascii?Q?x956keIrX0C1Wj3Vgdyxa2hbfV6GUFRtE9efUSkCvCA6eyIqGXGAZArxPwkT?=
 =?us-ascii?Q?pmbm9bppSR7i1+F2ukFCSUEURJUy+aCzoVzrnmmeoV25UdeYmUo59gC1RX6j?=
 =?us-ascii?Q?GlR7JZGvQqV6KHo9uax4yG3+Knm+/KUkqU6KxJRhhCYgKk3OgQDdCaO+uKwp?=
 =?us-ascii?Q?D0L5YEFG5EwH/YnOj1cksjS8NRKwALSvdng33PfLkG2/+IKpJt0hQnS5P6fY?=
 =?us-ascii?Q?iLLusjFbrMCFp3oWQyDZtZzctcJ41DqaQDcQg53nXTYGW+ecbSMli5vpGFMA?=
 =?us-ascii?Q?cJxSQ1VYq7bm1v3Zc2WBdzCz7NADHfDnG4CRulFhTu2OwwgAxBxmNO0bSxF1?=
 =?us-ascii?Q?xoDxqI+f7QS4j7HKYtiZrpxrh6ML3an3cDGy2zJhwng0LP8EFlhknDgmd7Mx?=
 =?us-ascii?Q?tb8z4BhoSLL9rJyU6hqq1Kd8bTWJKQgc132a+32ZrGRxdJa3ICV0u9mFIeWB?=
 =?us-ascii?Q?dIJT5oUhT/esV2iHLw5pbdmkGtQEhn9bmCDk6BEEw/DSbw67msS14MQd8nPJ?=
 =?us-ascii?Q?g/Ea28pUwNkUUPUbEmVnB0USv6Ys6NRcpYzO0r/alIrtIkiwRTLIZoOOqF0c?=
 =?us-ascii?Q?7tVFcA22k8+1V10Kn0hcDblwqzK5NpB5qZloXJ2x9o6EdsQ+YR0pPaNGORl9?=
 =?us-ascii?Q?gZsv2z11RziH6IlITitcccP6/YWasRaCFD2L2Z/k1x4spZk1r3FGJFz79bjF?=
 =?us-ascii?Q?WR/0HY3Zo5tDU69NuiejyaJ73WNtM8nxIPxAvE2xU2YEgoQAlOxCQ2XH4+NC?=
 =?us-ascii?Q?iJ80/5AggcIxeZM/xTNGO+FccNvlFt8rcoH32LhQcagUn5rpzDMdnmdJ4qKI?=
 =?us-ascii?Q?dvGNbjnoIL9o4+fQVcaAEdhbBgd84m6QsTPY41T4hg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1inK/zVWSa13K0LGKYPNUozWKsIOdBocIhD7XsO5qYavAuZ1fIgnwbsrcja?=
 =?us-ascii?Q?2zm0ZEJn6A7hwsYXOQZCB6L1m2+0m+SsXrKT2aIefzNPilXvwRLP6PXCu9h0?=
 =?us-ascii?Q?1ImBu4FBelnYUDNBQTF2RwcPL7Jf5tBGxkbzXE0YpiDJ/FrrBNulRGTpDw2U?=
 =?us-ascii?Q?XiCSIKqXi7QIGxqOWzoEHmLD1c5AWW1t6bW6OdJQMHzIdyJEKGRVLZ+xjjj3?=
 =?us-ascii?Q?SWOdmWG7geEw/dj+xge/y6xYkzFadzbkzovnenF0UTzl9RaHoC/bgZDqEAmJ?=
 =?us-ascii?Q?Gmw9SQb6kPazh+kXYXXRrsSnC8hze66ehLvuatHFl3bJhObiSmLEn6UuaxYn?=
 =?us-ascii?Q?ZYXZNCtjeTKyIuCwC4K6fp1YnZraHlb9LtmTRMwrxb8f5ofW7KllzGQkJo2Y?=
 =?us-ascii?Q?7DYhQtIusbOULzv3bSgyjUHRY56CscSUE2X4Bee4Txgm+OO7uYEpu7nGGd1p?=
 =?us-ascii?Q?mIJeEP41ZEqBLLcST8S0l3mZK02zO1fJqqDSrqwR1x32WDTfgW126VcYWugZ?=
 =?us-ascii?Q?+kElr4cTjvWbKWvWPw3+oeQQXOU/VxatddK1jvaUtw+YNseDTL8vElqldzbP?=
 =?us-ascii?Q?tPrbTs4k3QN08ZgBVQpQq7iMjS9oD6CfypiZZzkkx8HzKX4XcHBf9BMtbC2Z?=
 =?us-ascii?Q?RylKlb2wkW1JPy18YAF21qbE21JLCqecqatjtwgn903xLYVSn0LY35cXLT4Q?=
 =?us-ascii?Q?AFd38NoWVNWrrm3W+FJs69dOIBLFu7vcNFo3pF7SQnwPU0tVNMrzTPi1CCZz?=
 =?us-ascii?Q?CABJV0UCtXXqQVQLSMC3Crk2cJua4dkaZh9Xq+GRXt3/dRA/GdCg2ZRQvo0S?=
 =?us-ascii?Q?r476YjKbaNFdg+U0ef8tI35XzYIKrss9mNJUWzGgxhRvBBlY5IqbKBbsmMfc?=
 =?us-ascii?Q?ihMZDcdxJR2M73EdHLretopdiEktF2ZH141Cu384OLzHdq9iwggU/dOqNwAb?=
 =?us-ascii?Q?wfplpcauiy2qBMOf9FWjJymfQlTe7adFUth7FOT9DtGvszSHz5NnfujRqoZa?=
 =?us-ascii?Q?xHxJZrmNXEyUn8cyU1XJEVTjKfaBtsJcr3nAIWr74dDI1Y/ncgf4uw1TY4Ip?=
 =?us-ascii?Q?IbktDyUOvMiVBcnxyPYiQJEU4B1kMYKXPa3TnSEusLlajCeAcv+BvYfzjHct?=
 =?us-ascii?Q?prrwgZ/nuDUmc5ZSjlLxAzJ4zIXWR73jwkyFfvFWLcNFkW8dZc4wBVXBxtH+?=
 =?us-ascii?Q?PxUuxvAcUVWu+pm5hHkQPOtLjfO0qrPWPuom7KxqEM2Ego/GbhMNkJdxoj6g?=
 =?us-ascii?Q?Z8JqbfwJ8aXX97KKralRFWrt9QaXKyEGF7lbXEsMm21QmmNM5yFZmzf9y6hA?=
 =?us-ascii?Q?cFEO/8cs98vyoaXb3XgGSuiI2gUHCRHFdwkVAc+mGC7LqmQvh3uLHDpDat0K?=
 =?us-ascii?Q?O5Rh6Zi2er93jszQzIipX2BurlUaS1akMo9NEzm/owDvmKC0iBYOj6kpmlCM?=
 =?us-ascii?Q?BE6UH/zzeTm7IMt/FWPWVGcAHAGfQUS+2VAE/fr1C5lX177IoXe8901/ZAaw?=
 =?us-ascii?Q?g87+OsPeMvibAnsVnXuQf2V9StW1ITJ9vnSICqrEn8+bpNuBt9ahLBVx+zg9?=
 =?us-ascii?Q?LnCHZEjJV1WFteAG/RZPesPmFDCHW0xMKUWSmfhDQ77IEMLGysjbyyAiSuTQ?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 247cb535-4e9c-4290-594d-08dcf85088e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 19:33:16.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkA5my/Q0cl4gSDmVA+d4QuySEvmmWtpk3qlNtdaU7AnV78iLGdyQuIov4IUWsxemGK46y5rsyCYJZd+0CWi5BbuKcvP/A1YkwCHpW2Cjqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

On Tue, Oct 29, 2024 at 12:32:54PM -0500, Lucas De Marchi wrote:
> On Tue, Oct 29, 2024 at 10:15:54AM -0700, Ashutosh Dixit wrote:
> > On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
> > > 
> > > On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
> > > > Several OA registers and allowlist registers were missing from the
> > > > save/restore list for GuC and could be lost during an engine reset.  Add
> > > > them to the list.
> > > >
> > > > v2:
> > > > - Fix commit message (Umesh)
> > > > - Add missing closes (Ashutosh)
> > > >
> > > > v3:
> > > > - Add missing fixes (Ashutosh)
> > > >
> > > > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > > > Suggested-by: John Harrison <john.c.harrison@intel.com>
> > > > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > > > CC: stable@vger.kernel.org # v6.11+
> > > > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> > > > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> > > > ---
> > > > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
> > > > 1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > index 4e746ae98888..a196c4fb90fc 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > @@ -15,6 +15,7 @@
> > > > #include "regs/xe_engine_regs.h"
> > > > #include "regs/xe_gt_regs.h"
> > > > #include "regs/xe_guc_regs.h"
> > > > +#include "regs/xe_oa_regs.h"
> > > > #include "xe_bo.h"
> > > > #include "xe_gt.h"
> > > > #include "xe_gt_ccs_mode.h"
> > > > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> > > >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
> > > >	}
> > > >
> > > > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
> > > > +		guc_mmio_regset_write_one(ads, regset_map,
> > > > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
> > > > +					  count++);
> > > 
> > > this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.
> > 
> > Yikes, this got merged yesterday.
> > 
> > > 
> > > The loop just before these added lines should be sufficient to go over
> > > all engine save/restore register and give them to guc.
> > 
> > You probably mean this one?
> > 
> > 	xa_for_each(&hwe->reg_sr.xa, idx, entry)
> > 		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);
> > 
> > But then how come this patch fixed GL #2249?
> 
> it fixes, it just doesn't put it in the right place according to the
> driver arch. Whitelists should be in that other file so it shows up in
> debugfs, (/sys/kernel/debug/dri/*/*/register-save-restore), detect
> clashes when we try to add the same register, etc.

Also, this patch failed pre-merge BAT since it added new regset entries
that we never actually allocated storage space for.  Now that it's been
applied, we're seeing CI failures on lots of tests from this:

https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3295


Matt

> 
> 
> Lucas De Marchi
> 
> > 
> > Ashutosh

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

