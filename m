Return-Path: <stable+bounces-28576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F288615A
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 20:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD7281C24
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5C58AC0;
	Thu, 21 Mar 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHTa0EfC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2779F0
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050992; cv=fail; b=n8GZ1Diy8qSJWb9kHLDBLFNoAAtnNz4PJLKGYaLDTCyoCIUhihBJF7+Y72MH8F9VQ+cGjeohwbxMjEDiYGn/7mNJB7ToQfMWvr3q3mCTRmLqPD0VMfQLOnAXAnFjc0Yq+cafVDMQMQxMsmwRFSq1gA14gdmuI88Li8j2GR0hT/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050992; c=relaxed/simple;
	bh=/nPCQNfZxRY81/3ZzY3ynXtYxusUxPzgC6qvUkUjMEk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Td/wTNrhTZNKNkj7sbZk8ebaJZBgtvlL+LZMqy8tE0JUWnVPCzlP8RPLWeD4zV5UkaKMhZg3+uz9GDX/7eLhA6/iTUNpDCXHKy6eZwGG1+/7FqyKCeAA6sqbJA79FZ/szi/TNn9hvPimSiC8i803AEKPOVbDEJC39MjcJpBLyGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHTa0EfC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711050991; x=1742586991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/nPCQNfZxRY81/3ZzY3ynXtYxusUxPzgC6qvUkUjMEk=;
  b=oHTa0EfCay5VCw0DPRpYWMbE6peayEZeSxbU2hlacjmLr8LwR5N4nyMi
   4sijr5OeZ6DB0mPY7xjDgAXvi09rBD7iC9oO9Zn8kqeGfbkI01/gYBKXs
   aZpkAJJ58gs4Mey040JuC8b9z3zS6rEIUyPxNnpoSNV39+9q0v495pDMV
   XZ/yCWuWcvctCGKoMebq/idaS6AwpYWij11qagI4vUQZXST/11KgHs9Tc
   crAiGTov7SfH6ObecG/+TV1XXGldukNaYnQ/gE1h9z8hUrR4gN15A03vB
   oaaK+i+Q20B4+hgcAceeMXEOkzepTJpJ0KKuXNShsiLiOgP6HibGLoKtM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28542388"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="28542388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 12:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="37758493"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 12:56:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 12:56:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 12:56:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 12:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN3o7OQ+MxpQdKBR8/IP0tLLjqQ/g7DCFOAFASJJMU4Y44jPeSmTrcvMARDUu0hf27C7Rlv+Qu9exXLETCxHyjkVZsJHdcqAU8Gfl+gyg4/1Sab+RkU0YP+7ixeUkP/QkiA0LkJorihKg8swMF7VA3MdHmefibupH0UkR3I5YjKQLam6BabUnQP9M5mEvbUzY6EibXi7/uJsY6ASocWT52MGggN5RKPpjvO8hrYobK1p/jo1vIRVk6CbSqjOlLWuuIj/go+jzoZv3y2eHaT6ITuL4IIshZrOG4RVu8GQvQm9JzKV4sc0K5hoStU19kFU9nMP8WiYKrUsUJkHvfUUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZHj/j/DdI3mYHGa9qDzmf9Nwqlw2hNWiaMQj5Xbzdg=;
 b=QZJNydfUdFGva0c7Ofl2V6IW568Rmwe8JqtGQNuowZDJ0VnMKmHr5p98PkiNo0ziM+HqJRQ8M398wzHcO6lXcQrJ3pY3zwxpOnpqV5t501uJyHsXO7rvJTFaZIgT7CzmKiw8Agv0pgsF/uZgFJeiqBXLT1UXM8HJKHfERtC7DG66+PSc+DHYQSdZqFb0agV4IU6vbuvpuHSkhd5hOuvHMJsOlVXP7jFDl6lUvXk1GHxA2q6dJHSF0YzWnBH2lrR3e8hy7UNgGdGb+zt2A/G9ecUnHFid8IhIgLrT5ye89t8jZkcAlH9uzmLrvWgmGMzy4uyW3LP7HiukJ2Lmc+D7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 19:56:27 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189%4]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 19:56:27 +0000
Date: Thu, 21 Mar 2024 15:56:23 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Message-ID: <ZfyQ56P0DtQCNsIW@intel.com>
References: <20240321145644.33091-1-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321145644.33091-1-maarten.lankhorst@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SA0PR11MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: 328f1283-1c08-42ab-5df7-08dc49e0fe66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7hyW7yFodwccOwR6T666WuEy4cQ06+1qCmnrceNTtrssyh49j+BlFJGVHiJKQaAcxP+NF6siFxIdKt0WJVJoNtdlDsxiovNKWkJa3RLKdwtTZ7X7590wPse2LTL4Pkj5rozbOsIwgwwuaXNFbT7ORcVuquAOFxGgFvHlaJ7K5AghEmxiVTY3AVf69QqU6GL31hjESwcM1yBoybD78NggV7kk9mfT0y+60WX97j6HyzplzJQxxa3LpnAFebEL/nBF5wcemw3StZX3aVx41PRl+NbFXfBY/LfRXxt1l4PDSwsezzX1rs3bulUbzfUSq6Akm+6pJUJeVSu8SBiszrYXmbeNVLpwJ1G1oEg0KiAYZ7IO5ixiRT8sFJdlLm5hZY22wpTFFqb8xEcWtyC4AzAlS//KPeq/EAmdY8pyIZe7CicCX+MuXMS/1pao4i34aTFBRACBsO69lYjCfqks+G9ONbC3nVqE7HLHPeMFYiflxzbGVh5MRTvJcuunXQpKKMEt6FgHdsOmASBroLCK08BpKvGedpr8iJPmJOrBFbIbL/c57qmR5dGzWMgc0WIu0ErWaNUGBCAWK4sPQ8aVtSw8i7CEkr5g5juYfJcd1Z+wYhNmHX9742RB3Us5/TYWg6PWp9uSKzCX/Loo9XnvVGuxvR0fSpZd9d6X30uVbkkzzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5kb9PKliJuRyF/WAM0vZcGvKFaWQdSEVAEcPk0XrJ8o3Q0zJpCbaNfe6zo9?=
 =?us-ascii?Q?/a2fBLRXTljBqhe/gdTxOy9bsZowsZ4E+/qntkXkd1seyR7poDt/Ksm6bMLz?=
 =?us-ascii?Q?8X0zaHV9aQsxUZKellQUb/L7hbXBZMoVshbhfgpX2OODgzkAqYy8MxyVZ5bG?=
 =?us-ascii?Q?zbmcFKZJBYUV5WQck5j+nbeYPczgiRAvWG1dcTuzaVcSwueCTYVwOwcyU77h?=
 =?us-ascii?Q?SPJjT2JmMnnYYIiKDrX2MhspFTLzdx1msrVtThNSz3ubMkIu1OVX6CW0yaxd?=
 =?us-ascii?Q?bheTU63SIjzK6AoVbO9gzI2F8fHwp6aPzgv6HYaWCra3pKjjAGWAsl2+ldYB?=
 =?us-ascii?Q?q5OA2RO+3Xwe+de+PVClJt9cnJSlbhUDtz4YpT2oLvljLrSHLLOiYn/uGW64?=
 =?us-ascii?Q?IKW/VKmZJJKDIm0SoAQTKaqCZz1/ZHJ0Q2k7D22SUbTqtxJt9OJdi4+bfHeb?=
 =?us-ascii?Q?rqPhwmS/q7FSurmT2lDQdqWeU8NasAXy4fluYjQkiOCk7NRq+Urbezth+5T/?=
 =?us-ascii?Q?DtQQYLwJ8Ttsryoh1Wp5L/ZYarGl6B/Xo6UHiHIVyR7Hv4zi6ipq/sFc4t93?=
 =?us-ascii?Q?FFwdkG17rlHBtWlshw1g3qt4SB2N3H3bDEqW7mkg1CqeNdvDtxAi862H7zrb?=
 =?us-ascii?Q?V8s0lFilGS3745YDa07728iQMiAnKOLoRGOfMiRleSAr9qrqJXTVcDk9Y3no?=
 =?us-ascii?Q?ZQvCQ4w86NaZ1eXn0yLad4c7pqCtmMUi9OOY+fb7sYqeC/LMlfFtmn6K9LJr?=
 =?us-ascii?Q?ySQAyuSF0zw2HYr0VRtR+qNBbZ/jXOoFIJePC8NBIUTo5FpDOtN8u70TYaif?=
 =?us-ascii?Q?9LcdTMjzQonCJ9O4kWDe61PHwYsUwX1A4YnjdmpVPIF8bbiOGjnhjMGchhYz?=
 =?us-ascii?Q?6BeaHUidVTNApPYYmJkQYqLnZGFWL1C7OrLLEe2lLReoW9RF3BY9nKb4ZHhp?=
 =?us-ascii?Q?q/yIzCSVI0HQw49V/Tx44fZAj1KRmS7RjgCKUcXgoiLO+zEuIZsn339dzeA7?=
 =?us-ascii?Q?sIGyNvNS4PMRqSDi+L+Hdnp+b259VAQh5cEyE9FFfHxs5URAAT6E6Xejlrgt?=
 =?us-ascii?Q?AsNmpGQA/bRckWkA1XDx49DEKWgdo8I3Yl+BZLSSBMDezDKJNvEQXlOxJXmJ?=
 =?us-ascii?Q?1T1kwBn8D6yv/J0bloz8+F3Ayb2MQo1wHriB2ldwa0nlmTK0ZoSR5+7inag8?=
 =?us-ascii?Q?vwcNs9fyxQwn0uac+iTT9SdNnPvSLsMDVtS/fufdiY9lMXivNefAOQ4K38I4?=
 =?us-ascii?Q?SwEk4g0/yk0qcpe4mQniA+J8LvwFqRiEtzs5ZkPQ6F/hJzObMFLo1lEaDR5x?=
 =?us-ascii?Q?w/XxqE0lW9wq13PZkqk3S+LdMex/t4Md9qKcmLG6nTfq6Gk1xIVFKV+4kCc7?=
 =?us-ascii?Q?KtW9rSMe0N6u2LPT59XZaFl3J8PBGHco4/HoALNoXWoHyJTRKojlxDVCxNut?=
 =?us-ascii?Q?4VUhg7Y+5nOgJytjlqlB7aISVZHLSvzXmmnSz6siCTrpiNiKGlsuJqXRXsDv?=
 =?us-ascii?Q?FTKE/X1PDh86lR9ArzUGEfShWTC/WCG+TIdB8/rn5k2XPOMCAG6K83tR42lP?=
 =?us-ascii?Q?DHb63XKf+4IMS4OVLxq576JdxOsYFrNJuUQC19dklmM8QvH/Gr2kBahBzrwZ?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 328f1283-1c08-42ab-5df7-08dc49e0fe66
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 19:56:27.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDkd95V1xy0OvlrJssKziwMqW0xScnbGoeJHeyCPM4DSBbBT3rW537r8QpI2sNSZ2P9f6DNTDIjSm7shlPhLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 03:56:44PM +0100, Maarten Lankhorst wrote:
> Add a reference to bo after all error paths, to prevent leaking a bo
> ref.
> 
> Return 0 to clarify that this is the success path.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/display/intel_fb_bo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/intel_fb_bo.c b/drivers/gpu/drm/xe/display/intel_fb_bo.c
> index b21da7b745a5..7262bbca9baf 100644
> --- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
> +++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
> @@ -27,8 +27,6 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>  	struct drm_i915_private *i915 = to_i915(bo->ttm.base.dev);
>  	int ret;
>  
> -	xe_bo_get(bo);
> -
>  	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
>  	if (ret)
>  		return ret;
> @@ -48,7 +46,8 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>  	}
>  	ttm_bo_unreserve(&bo->ttm);
>  
> -	return ret;
> +	xe_bo_get(bo);

wouldn't be safer to keep the get in the beginning of everything else
and then if in an error path you xe_bo_put(bo); ?!

> +	return 0;
>  }
>  
>  struct xe_bo *intel_fb_bo_lookup_valid_bo(struct drm_i915_private *i915,
> -- 
> 2.43.0
> 

