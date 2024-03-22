Return-Path: <stable+bounces-28636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D6887255
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93F52870E3
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F160BA4;
	Fri, 22 Mar 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObcbpRpB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C860B90
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130204; cv=fail; b=tpFKDgJcm74guCS6RpUjkajdOmOX0f9+X1ifzS0A7hhcqlswXjqMHD27SFdBJE9aG1JXliQaRxSu6hOLbKlw4mpVPdRyMTzET+CqCHhTplZFFlc2kCaFirz9hmGzRi0jGEr46gcgrFVu3Fe/cTM+t6dQEF+voPkIR3A042HF0tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130204; c=relaxed/simple;
	bh=RKTt6mhk6prruT3MzBAMp5oBKzzF6iehiFsxK1bM2lE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXlBOXuRQ9CVRNL8LUuAH2u1kmWy4WPUXOi5e+6czpXw97RtvrcCw5qRzsxNzy8it+UHV/Mb+iX/yAEO+6Kku2wsb5g0/avu1sZpJHEOswAa4bjrNa53TC3Tsgy1Q+5ZvTfegk7WuKqJw8vV1RvLqz14nTx2EHIN0M9DlPbMcqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObcbpRpB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130203; x=1742666203;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RKTt6mhk6prruT3MzBAMp5oBKzzF6iehiFsxK1bM2lE=;
  b=ObcbpRpBCzkmKo6kaTjYrDizTfKS/Zi2v+QGuMAzWaBFNy1x5fUkXWNF
   64wi/8SYCi6b2+2LefqHC084DKykRyfZiWb5ZHNedd/uDe9o5poPhhs9S
   BV1V/Pl5EvI0Askq9+yhxpd0nmrXVutmpB6ex0P+TncXHXXLaTfbZ0xAv
   V2i4tiMUv0YbbWhfDSnbsFcX8FnoLetllJkoYWi0V7qHfO2cxKm0wlAb1
   rp+uZriIR6Wg39yrc8FxeRSMjrDH5DH1d8wIsUE+UkchTPrQpvqBpABEs
   zElnA96EiaJx+X1r80aFA8zlo3FdiikymJru8ULYEHf6MGAxgC6e+Z46u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669746"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669746"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425618"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 10:56:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:56:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 10:56:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 10:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmYKF/Md3r2A9OSU/eEenhJUglSfrPOPzpVwJlRvL4tphf81aZE3izTlwJzhbhkeBDZPFbE9qsYWsroN8L1IGKYpcsbhLHidyJadfOnBXtqiv87Kbyy0o2lWkkOHA7DxtJG8yJJeSiZP+B8UU9lsJap7MdtOdcu6Sl1pKo0Ak3GiAhKb5dR2NmYc814zMphtdSShiUiAA7WvNsid5NYplxaVlD7EliiTPUXwB5kN1czt0G8wFTa1jq98+snZ6e9nvnGHD94X2H5MqQ3NAtd2q3GrfHVBNFl78hkK+qPaTEs/o6ZERsU3Ivse9XQPzvUAfIfr54uWkF5bsncpTgsTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyWi8FWUIdQyiqV8gJ4HEeVVol85I0DVbHzk/eXdVU0=;
 b=lOxFmQBsB9G8zfCixU2AhEHW/hFVySuDOfUXSN2tvTsySQvVCFBlOzYpUfU75YRm0sAvf6/KekqHp+2CGJXGfK7Rh7AFy6HXjt3fuztWAxwnQ2WOcXQOnED2XDaMh0iZLHBvIEGLdVukF+6s7Fv/pz9C6rY58HD2FZyK8mDk/61CV38PSpjWZpxBRg8kjwHcmg3G7csW+S0qquXMYq0G3Aahh4LqRzfhnN0TzFgQcqXRJNf9tE2/SccWEQjqx8Rhdr0BUlAmOpzeuo2Ds7ED/gsKwloy6W7U1r3ZLx8aidjGaVpJGShfMTHtrOYG7o1WWuIBcBBDag7d69jpX82Zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 22 Mar
 2024 17:56:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 17:56:32 +0000
Date: Fri, 22 Mar 2024 17:55:42 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/7] drm/xe: Make TLB invalidation fences unordered
Message-ID: <Zf3GHprV1p2b7geG@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
 <20240321113720.120865-6-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321113720.120865-6-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 459d2bf5-9bd2-4bca-1e16-08dc4a996885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrkG48d+Ip2l58Vi5phcflRkAf4hvSZmuYb0u5baI5Dfu/H/1X+pkoWUg2d+yU1mRfVkia9QZukK/A9q3FsuuR1tlZYif86SdgKfV8kBxRM2B//Hyn7wIiS3vjNOhmx2RrbX32p9wgONy7sAZYXZN77gRno7bPkdP+Og5KmgYTf3E9BtDRzXeJU/0cq2QRomqgXt02uwqBxcoWCDoDoVNDIYts78M8BpGYuMSo5wJ8xmjuec1Nb9YQL7kfcGRoOCH7tYmiO45NiUrqEBDsxmhO9uYcexLWaJGfFL71RwgDrA9DuFyz5tfoBkjMbBygOJ1XIhLHDZ6P5lqEgNmtBeqB4tLOEY0o197lBw/I7saXhRsmW3euQV2gY93Njcv+xdYYErxjP2XmEhS2Tlw3HdE4jky0o2bpXNhKaG5+OhDb53S+rJkeNnMqHIwhdWPLbwGt+BtQUc3/IGY3w0goTAbHLkVfPbeJMvLm+KLPbURPwhiMs3cEI8D1D2GsONWpDpbvkdwbAnCB/5HM9G7jz+lNpNl2hk+puvAGRnApLpZrxHMtUkWgLYxjXRKFeJ4GZjhbOvjuOonOgFwJbNFNpCnUvJmJhWHOXhN+yY0RrE5Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WTW9fytYYYf5EDssVzAHbb3++1ZhZYVh8xTpIJ020I+4JgFKQ2Du2ifcE/?=
 =?iso-8859-1?Q?Iydm6lLQSQ39L9+ePdVaA7mYIUxlLEuxKuaUU5osQhYy5PJ/UIBmj0KfMC?=
 =?iso-8859-1?Q?hCYisoH9ngFvjw72iPA1SjiVfEUB5vTw4s9qVytWprTA/URGap9cW1vpwa?=
 =?iso-8859-1?Q?vmZJxo5VLOlI2VlJu0vSyBelXLf2ioQR3bDo4B9JfMAxziDOOTt7wgdWzt?=
 =?iso-8859-1?Q?TKRNdxBTzraya5Cey754BTU/5GRDC8mkZt7cIoYxDvL9r5I9FKPvLEJ3Sp?=
 =?iso-8859-1?Q?e3uyHiVabLQZuZgrsoWqlhg2K4gzH6bY3ISHY1NGI2RsrTpEApoW4pQtEh?=
 =?iso-8859-1?Q?LFplMjiHzzeBZQygq8VkcMARI3fzeCIP4T1Bg+CxxpUvdnqeuKG0GOs1yt?=
 =?iso-8859-1?Q?dXGa7WVDNzS77J1dwGhWRiVGM6vrYBnBmGLZioaACORz2uJ5MipCnSKL/F?=
 =?iso-8859-1?Q?/61TnC2GLm3YptKVzSopfBMOv5WTn//bPn+ZuEsvLnnlzuwCZTSbcHRK4V?=
 =?iso-8859-1?Q?T7ErRw6no74M82p+eAvDXBUo9+BarzhxSQEedqbjWWm0SdP1ZFyvz/TUzH?=
 =?iso-8859-1?Q?10bY/3b+Mec1tVMeaEvJYnO8h3TNsSEgg0Rethm3YGQyBX6loia4lcL7FV?=
 =?iso-8859-1?Q?NMsCfkfm3gSir+WwGOG3MNMogOdDtSboEQszzZfQ9vtwY02zxHaUBV6ml4?=
 =?iso-8859-1?Q?LsOpsR6ujb7M3Y77CaTa2+VfayqvRQwiwl3TIjRkDQun/uUIZUL5/57oou?=
 =?iso-8859-1?Q?Y3Nm4N0oSjpFmrTMHdbTppIxrIFV+Tt2qESJMAWnMX6a7436msrc47u0di?=
 =?iso-8859-1?Q?Ig3MJ0I6PTLDWJss+pnt4znL+rct5fm/CsHP9PzZkbPy+Y0BDleHs7W8Xu?=
 =?iso-8859-1?Q?+Ry1Fs0S0HMqFeG4RyPfI0QN1lNyXBqbcgDSppeFzzNMzpyMcHNFThSq20?=
 =?iso-8859-1?Q?zHNKNPrWXhfic8yTmrO8gb/9w8HhbLS3nZv3YVNcBf74INv/dL5PjBZXcw?=
 =?iso-8859-1?Q?tpHVYFFnuWyUqB7B0iB/4esCzSjmvbkg8LOCQ+NLnzX7gUrgI3tnnp++ao?=
 =?iso-8859-1?Q?LlG2B0yB5j8tiUp50pbxx5+B81av2svxGh4ebjUeapdM7jBEJiWC2YYq10?=
 =?iso-8859-1?Q?48ma8UqnsTUhOSgqGUbMBTcbWaed8OcZYCkdG9KxilA+usKoOrYz9dFSfa?=
 =?iso-8859-1?Q?ZpddRHxPO2cuZwN0aMNyqlVby4ul7PYpDfMjGf2WZX2cOtkEaeU8BRfn6L?=
 =?iso-8859-1?Q?uSf4+glYvtcTWMj2Fl9nVrs9v3QxeBtcCnZQfCSXPA78cFDNTCzrp+zS3g?=
 =?iso-8859-1?Q?aTxP+g6k0fscYKSF0FleacuR0rNOjDnLgzfTWQ1g97eR3zdJq5Kr9X9LNb?=
 =?iso-8859-1?Q?NpCKdAt2mKDUBJe9gykCn33q9nNOf9MIY5Diq27b0R8P56rnd5AiejS6rr?=
 =?iso-8859-1?Q?Nwd92vBr8aa02EjApioM83180q36a0PLNfCuRPYwlyx872vO4rIVAsEYNb?=
 =?iso-8859-1?Q?vRA9ngj8+DgRO95NSzmM30NCZc12Rn1FUmif2do7TwucuYYpSExf7PjK81?=
 =?iso-8859-1?Q?P6GVh4Ju5mWevr+fkvxuGtLj1p1Ru57RWb5PDCe+6Ecu/cdlqwaBSD7hS6?=
 =?iso-8859-1?Q?0FzfHvbh1G3VSmEHrcOJrbBLlgUqexH/ReUqvINWZ3z0GdoK1wvemj7Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 459d2bf5-9bd2-4bca-1e16-08dc4a996885
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:56:32.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4v8WDKTMCVQCFy6urUJoFCbHLGL73hxhz2Ntyz2gIiAM4gYBf8WTN+RYrhkc3ZInrejkL1ZYqImD0azanKB2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 12:37:14PM +0100, Thomas Hellström wrote:
> They can actually complete out-of-order, so allocate a unique
> fence context for each fence.
> 

Yes indeed these can complete out ordered on different xe_exec_queue but
should be ordered within an xe_exec_queue.

In addition to this patch I think we will need [1] too.

This patch does LGTM though, with that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

[1] https://patchwork.freedesktop.org/patch/582006/?series=125608&rev=5

> Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 1 -
>  drivers/gpu/drm/xe/xe_gt_types.h            | 7 -------
>  drivers/gpu/drm/xe/xe_pt.c                  | 3 +--
>  3 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> index a3c4ffba679d..787cba5e49a1 100644
> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> @@ -63,7 +63,6 @@ int xe_gt_tlb_invalidation_init(struct xe_gt *gt)
>  	INIT_LIST_HEAD(&gt->tlb_invalidation.pending_fences);
>  	spin_lock_init(&gt->tlb_invalidation.pending_lock);
>  	spin_lock_init(&gt->tlb_invalidation.lock);
> -	gt->tlb_invalidation.fence_context = dma_fence_context_alloc(1);
>  	INIT_DELAYED_WORK(&gt->tlb_invalidation.fence_tdr,
>  			  xe_gt_tlb_fence_timeout);
>  
> diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> index f6da2ad9719f..2143dffcaf11 100644
> --- a/drivers/gpu/drm/xe/xe_gt_types.h
> +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> @@ -179,13 +179,6 @@ struct xe_gt {
>  		 * xe_gt_tlb_fence_timeout after the timeut interval is over.
>  		 */
>  		struct delayed_work fence_tdr;
> -		/** @tlb_invalidation.fence_context: context for TLB invalidation fences */
> -		u64 fence_context;
> -		/**
> -		 * @tlb_invalidation.fence_seqno: seqno to TLB invalidation fences, protected by
> -		 * tlb_invalidation.lock
> -		 */
> -		u32 fence_seqno;
>  		/** @tlb_invalidation.lock: protects TLB invalidation fences */
>  		spinlock_t lock;
>  	} tlb_invalidation;
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 0484ed5b495f..045a8c0845ba 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1135,8 +1135,7 @@ static int invalidation_fence_init(struct xe_gt *gt,
>  	spin_lock_irq(&gt->tlb_invalidation.lock);
>  	dma_fence_init(&ifence->base.base, &invalidation_fence_ops,
>  		       &gt->tlb_invalidation.lock,
> -		       gt->tlb_invalidation.fence_context,
> -		       ++gt->tlb_invalidation.fence_seqno);
> +		       dma_fence_context_alloc(1), 1);
>  	spin_unlock_irq(&gt->tlb_invalidation.lock);
>  
>  	INIT_LIST_HEAD(&ifence->base.link);
> -- 
> 2.44.0
> 

