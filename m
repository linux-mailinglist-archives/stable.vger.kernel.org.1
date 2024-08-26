Return-Path: <stable+bounces-70123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206195E644
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 03:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F031C208EC
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6F4A21;
	Mon, 26 Aug 2024 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRmd3H07"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44768184E;
	Mon, 26 Aug 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635576; cv=fail; b=byK6DUJ42Fs3RAJjHUs6Maz7JTBgKBJDqJ82CnEYCO+eHe7DfT2Sp1IQU1ptp62uvwjQLrJxJTVly7p/UZ/ipPU38ivCMcyoxwN+Nsm9WpO8q0QIKTDhwliiwuw6qEhaz3rEtAEGADkCVh8QXLiirHUwpKWBtk1jhTqbzfqPbG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635576; c=relaxed/simple;
	bh=ZKqOlQK36L3daRtvg0lUmiNnVc/4QJiOcp8z9tkXuV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZaFiFmGRvK57IQbX5gD8SYhwccLj5SgKAqyC4iKC2llQ5tGiEKkzXbumDNPO3uhOqOU7jRO3tXWXtKWZsC5uPU2ZIVe1AbgSW3BkyqFCowUF61zsxa7+dT/M93eiixiyFvJ0rE/RnyZ/tMdpOfQd4+i58En7wEdkThr5fNOLdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRmd3H07; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724635574; x=1756171574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZKqOlQK36L3daRtvg0lUmiNnVc/4QJiOcp8z9tkXuV0=;
  b=JRmd3H07MiPtMxdWGAlkYqqXGewh4mNlrI1Kjd8QcxeCZEluR+arHJJc
   Ho2mU8Ll4s66pspVuMlSbjg+7frRkf7x+jeQWCRzzfgeCl7ILbeOyYRjk
   2JLHOaa8D1Yhym1wF0b6LTnZZeqbjDoOEfgUOFdon1VKS7xFlOC9e68Pf
   u6MxY9uFqA+nGNCDW00GtRQ/tPRArTxhVQ3ZFRjm+dTIxPI7z59jQOfPs
   VVfbla0tN2XGBWro5FIgCwNFMx6jyuil1P8HtwnmGf6FhZxDcFwVoB1bm
   uBliEnBAMg1fP8jeX6HVkFWzH3S4AR0ACdIpr86LlmJsIjh0rHMk8iILu
   A==;
X-CSE-ConnectionGUID: n13ZPfJeRD++gaFZn+8a2w==
X-CSE-MsgGUID: Ag6FD3DCQR2IpDwMekxEtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34199115"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="34199115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 18:26:12 -0700
X-CSE-ConnectionGUID: Jwam6fJmTP6hdZdhOMe2BQ==
X-CSE-MsgGUID: yJioJGQYQ8inGIbBd+BSJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="62659897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 18:26:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 18:26:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 18:26:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 18:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/Sipe0WCotcZH+KjsikAxgbM1yTtF7yNM7Nk0pEvx3RFvKs8A/T82gvj9QlC3t5wRwv6tJ0MZqPRZ+mVSr6daHDunN6dqT/y4aXaydA7jo6EZ4a9+OD1QP+05XaGBzoVcUmWyYFSG2ZSVDB3bRCqQIt5yeW4WLRAQG5QJSBv2kPLov4BimbUH20UxR+3rFxkEsTbzeQzcpdeP885YnT4/9r0Ezbr1CleV3chpQRaRRvf1foiHDrKT5gB0uOhtPjYZGDCn59aON5Q/X7Im+xNpXmS457LrW9Hq5wH4VOWgtKjD0mbA1fSqOvbkGAoDIIDkq74VNa1jKc2QNsftkeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIX2ZSIqdx+AUbpAegTSCa3MfbHNkVmgdCo5zoei3nI=;
 b=qWmV/spBoRXy/S6L7LXQ2EpIO3i9oxYWxPLsSrZv0em6VijjIGhNWHZLw/4/h74qm0kko1O19gOgCpnuYAQvqdeQvcP4tGw5eqzQPDLq45IeTtAUNKgIKNw7faQHMcvXYWWB19WNVAPlJJKHNV0NbX/OKSQ6Cnn0C9kZblWj6A7ElQoZz/pNns5NkyiNzB7TtXdgQusSBmwdGwf5DZHoWRxtdObmGfrc5sqLyzK1L1kTLsXhDEHhvM3lXjgZ9dcU1CdL1Ly1foEpi6JaafiO1/pFlDGia4TVV0hkqZp780tbD+zoTo89TuSlCr7NTBxPayB5o6tQzYD7LdxKHSgUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 01:26:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 01:26:08 +0000
Date: Mon, 26 Aug 2024 09:27:06 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-tip-commits@vger.kernel.org>, Yang Jihong <yangjihong1@huawei.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, <x86@kernel.org>,
	<pengfei.xu@intel.com>, <syzkaller-bugs@googlegroups.com>,
	<stable@vger.kernel.org>
Subject: Re: [tip: perf/core] perf/core: Fix hardlockup failure caused by
 perf throttle
Message-ID: <ZsvZ6rbIIDiQNNuk@xpf.sh.intel.com>
References: <20230227023508.102230-1-yangjihong1@huawei.com>
 <168172838267.404.2145343215039139861.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168172838267.404.2145343215039139861.tip-bot2@tip-bot2>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 46992243-3038-41b6-7575-08dcc56e0fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1r+bzfKrppnbI3Nvgn9P2itTUXR6W8i3Uz22HwRuO3eW0ykMvdJmQV8Hl9bx?=
 =?us-ascii?Q?0YsQYfZ6EeVCvT7uvu8fOXwzWHRbWX8Db1pUTTZ3TSfvJl0WXdIC6axEopKU?=
 =?us-ascii?Q?4X0UdiDVrAHviL94/UG2gmTtrwptkqLC3pcwEf4BdM/Bw0qDWErvA1776zsa?=
 =?us-ascii?Q?H3Kwm0hECb7fZNcndj6IOrYLsdHB2xWgE1tROfFI79pPtFbxvx/9m+JvXmZZ?=
 =?us-ascii?Q?aVjlzxbLY8CY3pJFcwxe1d53U8uVHK82oNkAGQya4vfNn4KVNPU5kqGnDXTL?=
 =?us-ascii?Q?EQuYM+mVS0f60OzCAcFNwG/sKMnUKpmlLi/7w7jrkxRDns2CoRLqa/bSQ4zd?=
 =?us-ascii?Q?OXnhvOwNkZCBMRmeePIhXHwPLhc6Y603ESVMYI0tz469+bjRZ0YWuOp8odG8?=
 =?us-ascii?Q?MFcotygRe1JOM473ERBp8rI080jJPnZ/m7mlyulqwgNHJoQBnNYEsxZVDYPN?=
 =?us-ascii?Q?dpZ9ewLwdIVpC5esBdJN+Ryt1v3WET3xmnCybuLOfwp2RGMEvIpR22DFF9i/?=
 =?us-ascii?Q?yO+megcPctFd3TXbRCigbgYbpNL+lmQUKCw91Ox6hDyuMiLhytbFryyPrxVm?=
 =?us-ascii?Q?7WLiKwSFl4CCINLBbeN6ASyIzWj7YJ6jL1QQxWzl0vOMcuIXtBOf2F8QNCNe?=
 =?us-ascii?Q?ivSAz905nf34luvc3IktpGF1tEoYPnN+Gx8nEcPK6xkifa9N536LBN8OxytU?=
 =?us-ascii?Q?6Bk/i1/cvcIDltoqk6FStvf98u2yLIVNo+ED9fZYDrnj9vpwkctASSvK5FPu?=
 =?us-ascii?Q?U1WDs9JJZqi97mlGWEWnkMqGoDWaOZkW9COoOrTn+WcsHoLwRVygEJHqur5l?=
 =?us-ascii?Q?FTAIsbYxUwt2wHZLFtQ7H4jnd5OKT0iLU1fHB8Pb2jT+vHxZhQw/KXU2F27M?=
 =?us-ascii?Q?C7TfVOla4xwGPSZvMGU85uWAGlW2ghr+LexozASXWrlZH6Z0nf86Z2hVdZOp?=
 =?us-ascii?Q?xzBowsCGB8T+S2U38n/8LqjFbBZUCobqqaA9Ge+Lf72uPVcGtr4jwu/H0vW+?=
 =?us-ascii?Q?+HfNECT4QHpZrxU2bMxa1qPzaVH9KIVLoy7E+uEcwddthH/R3fBq0hLiMygW?=
 =?us-ascii?Q?fJEdlouDw/CD8KNhzjioPbwOEiOMgtjZfE2u6akg1wLXLeYI7A8z9jjd9+VF?=
 =?us-ascii?Q?8bmTjTLawex3zeEEF6704+3n5TGnmkpUhNWlWMjcETYNzA5rn9f6iRNukblc?=
 =?us-ascii?Q?JpPvpWReepLE/RQp2Iy8UUuJOW5iuoptnZ3CYykuEJIpQImTWoe4RG29k8lF?=
 =?us-ascii?Q?yfXrzO0g7VBSt02jZmk+GzkooZXchh0JG0/NfXN5l0PVYkyM/OyoozqSR1px?=
 =?us-ascii?Q?5LM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+/5gOpXgubnf34k4KNzdrvxrZU9KIqCMCi/MCqK2qE5CffaNKKwdDtJy81L?=
 =?us-ascii?Q?YYpm+FkbsFE+O/kSlxsL7UkaC1o9DCZW4jVa7L6rQuFzZC6dFdZBO/EmbhCV?=
 =?us-ascii?Q?3qxk+qCBmA9MzgPGcP6Sa8A7ybZSGPNmKimB5jGxWmoS1HMUVvytq0sj/vhL?=
 =?us-ascii?Q?XDA2oT/hx9wBRcBnouc0jYizREJdbqJS5Y5M/2Ne7HKmaxF12UKR4sf1WaLN?=
 =?us-ascii?Q?7N64GkcIN0TycaKR4TIq+yy8yXHZo5gCDvDf2YzU4mCBb7dny8WGpjtBv5ik?=
 =?us-ascii?Q?OvNFtyMZMHRnaALDT+rFkBNsoA8KQtfZdp04CQmeETZr6R1fUOFDiBDrT+AU?=
 =?us-ascii?Q?fVlqje6WHJQV7D4lrfqSNiVZk22ldbufAGeSs72NFJpHh0DsvWiiICQ6hx/5?=
 =?us-ascii?Q?DWBHRwbaSLR0a5Wk00edNi3/dS1DxultUuwWCetimxoVvepE3CTFhwMKbZe9?=
 =?us-ascii?Q?ZmJhA+GBvO59cmaLHX6T8Rm7TIviXN+6Mwhh21I7CBIS6/+enYyeVPbfUN6o?=
 =?us-ascii?Q?ps9VLR7EkdxWvico8qpeeAWf2hNo+Ox0CnauK6ti4hzr8hGrwLJKBjX+L3xE?=
 =?us-ascii?Q?3NBovuniD669eEQOHvDmIQsdS+MK0IkUzHEIEEhXXApR/HSZ5pWbaixJKuYC?=
 =?us-ascii?Q?rBgZzEWfy4QaDshKlcENqit54uwx82bfXCTpe3RNiwj/xohphfLPhB0+1me/?=
 =?us-ascii?Q?adx5DLhG9WjGqhjvrIZSrNOyyfugIFeUXli7Z7y8YyL5FDQPKv1kTy4o18jZ?=
 =?us-ascii?Q?d8p88qP48N7SwDujg0Qr7ingLd50EMfc4ww/V1nub/0aT1H/3Z1yQscGOHVt?=
 =?us-ascii?Q?qnDB87mrROquR4uhZSD/Gqw8nHuzLs+BkrwS95z1fD/t2htHJtgZRzuBTGy5?=
 =?us-ascii?Q?dDWwpIkzgxq7iKgIZ+vMRP2kfB3OHygCZGDETOWL1STTy59AgqvdQSbQn2VB?=
 =?us-ascii?Q?imj+lR1WDZNDgTWNSgN6VpdhRAW22z1Qj6L+0Z7VD6mgNeIHPAmGrPFF1EXj?=
 =?us-ascii?Q?PuC98ydVfFklg4jvQtioxmP2navDpORBia7U4trSpYO6FJS8blfMksZz6Rb/?=
 =?us-ascii?Q?Wjo8kwFj7IX81LAvLGX1/lqF66YORIPTgeAU9FfqkAoes6T1VcdWgM8DALNW?=
 =?us-ascii?Q?dvvB82YjGU4ZLa/SEjzcO9TBOtrIayrxAZGzZC2RddlcuCRZKZ4VJhF9yr5r?=
 =?us-ascii?Q?HOoO+aIrxf2MrWGg6RbK4QXdD7XkHcwSleMNYfMo7DE0Bapik9ee7fuF+czy?=
 =?us-ascii?Q?T6/EMvQsT21QNpIn9V8KM254xYIIev6JxrHUgc7C4toLNCgDSFjDex9UxuRY?=
 =?us-ascii?Q?L2cUE7/pGlYfjwFTUO1E4yANLKK3T1srFtxZEXEuONL+c53bx0b6eoRx0/tQ?=
 =?us-ascii?Q?tpIS/p3sxAVG3bP6eG6tFGNlwy/7OEzCrV32iPQnwA8SOVW1KElJuIgsKtXZ?=
 =?us-ascii?Q?BkTEddOr335kWN2z4QDZrNnWFRjrYS3fsgPCXS77DGFbkEilcJsCASSTZUN1?=
 =?us-ascii?Q?QUKmzI6XeZ/CdGYIDySBd7YvTjE6jVGxAJJpwNK9sL1Pop2NcjMKdXckQYE/?=
 =?us-ascii?Q?PF4MEiSURsrpTPP/5PTs5jQaSfeZkZlXYMZVQV90?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46992243-3038-41b6-7575-08dcc56e0fc2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 01:26:08.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUm+G0eVLO43jth0fUP/5TJ6IKUcqJQJ3y6fI8v9v+coDM7lg3EjdC3z24WTQUyCRcZ4LAywyrn4uUYgBcgobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com

Hi Jihong and perf experts,

Greetings!

There was "BUG: soft lockup in asm_sysvec_apic_timer_interrupt" in v6.11-rc4
mainline kernel by local syzkaller Intel internal kernel testing.

Bisected and found first bad commit:
"
15def34e2635 perf/core: Fix hardlockup failure caused by perf throttle
"
After reverted above commit on top of v6.11-rc4 mainline kernel, this
issue was gone.

And this issue could be reproduced in 1200s.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240823_212601_asm_sysvec_apic_timer_interrupt
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/bisect_info.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240823_212601_asm_sysvec_apic_timer_interrupt/bzImage_47ac09b91befbb6a235ab620c32af719f8208399.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240823_212601_asm_sysvec_apic_timer_interrupt/47ac09b91befbb6a235ab620c32af719f8208399_dmesg.log

"
[   22.518698] hrtimer: interrupt took 13103 ns
[   30.382700] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 2079936720 wd_nsec: 2079936828
[  378.038693] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 7719948786 wd_nsec: 7719948793
[  736.508865] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [repro:193160]
[  736.509218] Modules linked in:
[  736.509369] irq event stamp: 15405229
[  736.509539] hardirqs last  enabled at (15405228): [<ffffffff8579c9de>] irqentry_exit+0x3e/0xa0
[  736.509947] hardirqs last disabled at (15405229): [<ffffffff8579ae14>] sysvec_apic_timer_interrupt+0x14/0xc0
[  736.510383] softirqs last  enabled at (9218742): [<ffffffff81289fb9>] __irq_exit_rcu+0xa9/0x120
[  736.510776] softirqs last disabled at (9218745): [<ffffffff81289fb9>] __irq_exit_rcu+0xa9/0x120
[  736.511167] CPU: 0 UID: 0 PID: 193160 Comm: repro Not tainted 6.11.0-rc4-47ac09b91bef+ #1
[  736.511529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  736.512039] RIP: 0010:__rcu_read_unlock+0x284/0x560
[  736.512272] Code: 8f 00 00 00 84 d2 0f 84 87 00 00 00 bf 09 00 00 00 e8 d0 0b dc ff 4d 85 f6 0f 84 68 fe ff ff e8 f2 83 26 00 fb 0f 1f 44 00 00 <e9> 58 fe ff ff 0f 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3
[  736.513091] RSP: 0018:ffff88806c609938 EFLAGS: 00000212
[  736.513330] RAX: 0000000000e956e0 RBX: ffff88806c649600 RCX: 1ffffffff14ae71b
[  736.513648] RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000000
[  736.513974] RBP: ffff88806c609968 R08: 0000000000000001 R09: fffffbfff14a92b5
[  736.514289] R10: ffffffff8a5495af R11: 0000000000000001 R12: ffff88801379ca00
[  736.514606] R13: ffff88801379ca00 R14: 0000000000000200 R15: ffffffff86e619c0
[  736.514935] FS:  00007f095e148740(0000) GS:ffff88806c600000(0000) knlGS:0000000000000000
[  736.515293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  736.515555] CR2: 0000000020000000 CR3: 0000000021944006 CR4: 0000000000770ef0
[  736.515888] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  736.516215] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  736.516539] PKRU: 55555554
[  736.516672] Call Trace:
[  736.516798]  <IRQ>
[  736.516907]  ? show_regs+0xa8/0xc0
[  736.517080]  ? watchdog_timer_fn+0x52f/0x6b0
[  736.517284]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  736.517503]  ? __hrtimer_run_queues+0x5d6/0xb10
[  736.517733]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  736.517975]  ? hrtimer_interrupt+0x324/0x7a0
[  736.518193]  ? __sysvec_apic_timer_interrupt+0x10b/0x410
[  736.518443]  ? debug_smp_processor_id+0x20/0x30
[  736.518663]  ? sysvec_apic_timer_interrupt+0x4b/0xc0
[  736.518901]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  736.519162]  ? __rcu_read_unlock+0x284/0x560
[  736.519370]  ? __rcu_read_unlock+0x27e/0x560
[  736.519579]  __is_insn_slot_addr+0x14c/0x2a0
[  736.519791]  kernel_text_address+0x64/0xe0
[  736.519991]  __kernel_text_address+0x16/0x50
[  736.520199]  unwind_get_return_address+0x8c/0x100
[  736.520424]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  736.520671]  arch_stack_walk+0xa7/0x170
[  736.520878]  stack_trace_save+0x97/0xd0
[  736.521064]  ? __pfx_stack_trace_save+0x10/0x10
[  736.521276]  ? __pfx_mark_lock.part.0+0x10/0x10
[  736.521499]  kasan_save_stack+0x2c/0x60
[  736.521681]  ? kasan_save_stack+0x2c/0x60
[  736.521870]  ? kasan_save_track+0x18/0x40
[  736.522057]  ? kasan_save_free_info+0x3f/0x60
[  736.522267]  ? __kasan_slab_free+0x115/0x1a0
[  736.522467]  ? kfree+0xfe/0x330
[  736.522622]  ? free_ctx+0x22/0x30
[  736.522788]  ? rcu_core+0x877/0x18f0
[  736.522967]  ? rcu_core_si+0x12/0x20
[  736.523142]  ? handle_softirqs+0x1c7/0x870
[  736.523334]  ? __irq_exit_rcu+0xa9/0x120
[  736.523519]  ? irq_exit_rcu+0x12/0x30
[  736.523693]  ? sysvec_apic_timer_interrupt+0xa5/0xc0
[  736.523922]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  736.524165]  ? lock_acquire+0x1ff/0x580
[  736.524352]  ? _raw_spin_lock+0x38/0x50
[  736.524534]  ? do_fcntl+0xa95/0x1400
[  736.524709]  ? __x64_sys_fcntl+0x179/0x210
[  736.524906]  ? x64_sys_call+0x5b9/0x20d0
[  736.525094]  ? do_syscall_64+0x6d/0x140
[  736.525276]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  736.525529]  ? __pfx___lock_acquire+0x10/0x10
[  736.525736]  ? do_raw_spin_trylock+0xbf/0x190
[  736.525949]  ? free_unref_page_commit+0x3c0/0xfb0
[  736.526176]  ? __this_cpu_preempt_check+0x21/0x30
[  736.526399]  ? lock_acquire+0x1de/0x580
[  736.526587]  ? free_ctx+0x22/0x30
[  736.526753]  kasan_save_track+0x18/0x40
[  736.526944]  kasan_save_free_info+0x3f/0x60
[  736.527146]  __kasan_slab_free+0x115/0x1a0
[  736.527341]  ? free_ctx+0x22/0x30
[  736.527503]  kfree+0xfe/0x330
[  736.527655]  ? rcu_core+0x875/0x18f0
[  736.527833]  free_ctx+0x22/0x30
[  736.527991]  rcu_core+0x877/0x18f0
[  736.528165]  ? __pfx_rcu_core+0x10/0x10
[  736.528365]  rcu_core_si+0x12/0x20
[  736.528535]  handle_softirqs+0x1c7/0x870
[  736.528734]  __irq_exit_rcu+0xa9/0x120
[  736.528915]  irq_exit_rcu+0x12/0x30
[  736.529085]  sysvec_apic_timer_interrupt+0xa5/0xc0
[  736.529309]  </IRQ>
[  736.529414]  <TASK>
[  736.529522]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[  736.529762] RIP: 0010:lock_acquire+0x1ff/0x580
[  736.529974] Code: 48 83 c4 28 e8 72 73 37 04 b8 ff ff ff ff 65 0f c1 05 fd b6 c0 7e 83 f8 01 0f 85 d9 02 00 00 4d 85 ff 74 06 fb 0f 1f 44 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
[  736.530786] RSP: 0018:ffff88801aa0fcd0 EFLAGS: 00000206
[  736.531031] RAX: 0000000000000001 RBX: 1ffff11003541f9e RCX: 1ffff11003541f82
[  736.531348] RDX: 1ffff110026f3b07 RSI: 0000000000000001 RDI: 0000000000000000
[  736.531668] RBP: ffff88801aa0fdb8 R08: 0000000000000000 R09: fffffbfff14a92b5
[  736.531994] R10: ffffffff8a5495af R11: 0000000000000001 R12: 0000000000000001
[  736.532318] R13: 0000000000000000 R14: ffff88800f65a028 R15: 0000000000000200
[  736.532660]  ? __pfx_lock_acquire+0x10/0x10
[  736.532860]  ? _raw_spin_unlock+0x31/0x60
[  736.533063]  ? up_write+0x1c0/0x550
[  736.533234]  ? fasync_helper+0x77/0xc0
[  736.533420]  _raw_spin_lock+0x38/0x50
[  736.533595]  ? do_fcntl+0xa95/0x1400
[  736.533775]  do_fcntl+0xa95/0x1400
[  736.533948]  ? __pfx_do_fcntl+0x10/0x10
[  736.534137]  ? trace_hardirqs_on+0x51/0x60
[  736.534336]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[  736.534619]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  736.534853]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  736.535104]  ? security_file_fcntl+0x9d/0xd0
[  736.535315]  __x64_sys_fcntl+0x179/0x210
[  736.535508]  x64_sys_call+0x5b9/0x20d0
[  736.535687]  do_syscall_64+0x6d/0x140
[  736.535866]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  736.536099] RIP: 0033:0x7f095de3ee5d
[  736.536273] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[  736.537075] RSP: 002b:00007ffea8175048 EFLAGS: 00000217 ORIG_RAX: 0000000000000048
[  736.537411] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f095de3ee5d
[  736.537736] RDX: 0000000000002400 RSI: 0000000000000004 RDI: 0000000000000003
[  736.538053] RBP: 00007ffea8175060 R08: 00007ffea8175060 R09: 00007ffea8175060
[  736.538371] R10: 00007ffea8175060 R11: 0000000000000217 R12: 00007ffea81751d8
[  736.538689] R13: 000000000040547a R14: 0000000000407df8 R15: 00007f095e193000
[  736.539023]  </TASK>
[  736.539132] Kernel panic - not syncing: softlockup: hung tasks
"

Hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


On 2023-04-17 at 10:46:22 -0000, tip-bot2 for Yang Jihong wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     15def34e2635ab7e0e96f1bc32e1b69609f14942
> Gitweb:        https://git.kernel.org/tip/15def34e2635ab7e0e96f1bc32e1b69609f14942
> Author:        Yang Jihong <yangjihong1@huawei.com>
> AuthorDate:    Mon, 27 Feb 2023 10:35:08 +08:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 14 Apr 2023 16:08:22 +02:00
> 
> perf/core: Fix hardlockup failure caused by perf throttle
> 
> commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
> introduces a change in throttling threshold judgment. Before this,
> compare hwc->interrupts and max_samples_per_tick, then increase
> hwc->interrupts by 1, but this commit reverses order of these two
> behaviors, causing the semantics of max_samples_per_tick to change.
> In literal sense of "max_samples_per_tick", if hwc->interrupts ==
> max_samples_per_tick, it should not be throttled, therefore, the judgment
> condition should be changed to "hwc->interrupts > max_samples_per_tick".
> 
> In fact, this may cause the hardlockup to fail, The minimum value of
> max_samples_per_tick may be 1, in this case, the return value of
> __perf_event_account_interrupt function is 1.
> As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
> architecture as an example, see x86_pmu_handle_irq).
> 
> Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20230227023508.102230-1-yangjihong1@huawei.com
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fb3e436..82b95b8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9433,8 +9433,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  		hwc->interrupts = 1;
>  	} else {
>  		hwc->interrupts++;
> -		if (unlikely(throttle
> -			     && hwc->interrupts >= max_samples_per_tick)) {
> +		if (unlikely(throttle &&
> +			     hwc->interrupts > max_samples_per_tick)) {
>  			__this_cpu_inc(perf_throttled_count);
>  			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>  			hwc->interrupts = MAX_INTERRUPTS;

