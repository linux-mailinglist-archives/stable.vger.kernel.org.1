Return-Path: <stable+bounces-28588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EC886536
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 03:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B471C234DF
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 02:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD1C3FEF;
	Fri, 22 Mar 2024 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn9r0XuD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108DD138C
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075084; cv=fail; b=nuQvExHqwusDqIbZKDzlQzgRA340lbgecNvCM1gyhRNS8Vp21TO68Kdbtk5QaHcIj8Sa0bpMHr7+jcz21miUEp3uDfsTcNd7e5ilg4xmevj+GFWcIJ4DI+aOjsT4Ov8CkIsqRfEofvf7ZAMBAX9yGU0kvnXOJPYgn+dQrNp5I0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075084; c=relaxed/simple;
	bh=TV/C1VJ4jCNoX9ijJWYj2SE98fU3rLF6tsyMm5QYsjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=exXV+L9mSWZXHkTyYTCHN8JjwPH3xHep1kDuADHIXhyLm4rVg6WOnHnwQpW0hGkmj2+f4zsgRvasigs+Evo+hXeHNsNDfM70iZmgw0Eu2NceMziq2SESNJyyNd8NfDryujlADb+nMdCasOE3MuzCu1O/qEayY/8Rzhnro3B3hjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dn9r0XuD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711075081; x=1742611081;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TV/C1VJ4jCNoX9ijJWYj2SE98fU3rLF6tsyMm5QYsjU=;
  b=dn9r0XuDf6IgyRerTEOciFTAs+oxFelboHEQc0KWIPGqLuqUBs0/9aZY
   4EhNA14JbXNgtdax86IETq1Aj7nTWWowiipH56EFWwBF4Mw4E3KC3TFds
   TXuukC7KD5ASXfezu1ryWQAn5Dfj8319Ge5tuA9DIUn2K66mwvkmZD5iM
   2skTOfpNjeV0mknxo/iGzVSlKV7juWSIhF0tcryiq4bFppK0TZVLLIbrN
   HtSLLax8ngJFcsy6bctcVqB+UR9jLLwAvBnTrx7VPBW9nj99K0eFbxjdL
   oFvCB++Iqv7R5AfDxAdmmvNimCVyJNCZhAMJ4cvhvrKLirIE3wGvwTTaf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17503034"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="17503034"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="37865559"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 19:38:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 19:37:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 19:37:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 19:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNNPBwHOfYCujyy4PpsVPCNn+8Bja4Yw/+A1a7Z83SDTYsZn09Iy9UR+qMz2piJ4rKOO0t8hB8aRrTNZMzogD6rxuM/w1LREKkSWMR8AnvR2gdKTZL78g14Vy46yEubwE9BPxa6KFhwR78pCLu8tMyADOQwhSA2a/YArpNAAL9tNJvHCksSvr1yBgOE5hhEw0dLoYZc/tELnooKAcnRN+MpA7MgOBBuy26FEEmpnz/ZmP5fTQoD1CoVpcBSVSfSJz4+9JIUziNuvZn4X8VN3MCt+4fSvaRi2JbgzRBEY9j7y6FGD8U6ILaKB+xmVFfYjkyRSjykPo6lQcpd//plWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkSRP8nu2junfefZvGDbxoXLUmgq3W6lJS6b0W/oBwQ=;
 b=XdhrD2XejIXenSzPZteJYhCU7+nIUFP0nHuugPwcxCpMhB6Tu5hfJ4gZD9gf066y17J3DxjqaOoRWJ0c4yF9/d6LYA3axMuzKM3JeqbpzhTFsxlr3KLKd0ynvkfOqNLZEbrWqB2kHFme4LYTONOKBfFZ2N5SgK0JkP7xUuxXcIloYZaNq1ObRCGwn32XqS9hmMi7K16R8DoL/QZJY10XDJl/U2j0D6ZV3qPA+jMvq5JLu7u40kJanwbkxjDmBXpMthaLTsnqfIuV2dgY07z3/Cqwsh5xgwvhgrnX8j4tZIwjoU2XZ02zAxPwKiekaqRXRY2936ow9XdmYp04EaktCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 02:37:58 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 02:37:58 +0000
Date: Fri, 22 Mar 2024 02:36:54 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
Message-ID: <ZfzuxrRvBnnCJuUs@DUT025-TGLU.fm.intel.com>
References: <20240321113720.120865-1-thomas.hellstrom@linux.intel.com>
 <20240321113720.120865-3-thomas.hellstrom@linux.intel.com>
 <ZfyF7kfCE+xcMFa7@DUT025-TGLU.fm.intel.com>
 <f06fb3dcf8e377e064a30e0a62324f952f93cfe5.camel@linux.intel.com>
 <4edbc1b5f4aa01f590c28109567dc5d97eeef71f.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4edbc1b5f4aa01f590c28109567dc5d97eeef71f.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: f3794fd7-e7f8-414a-7d96-08dc4a1915e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CZAhHOM3+QAmB4tIloP5sxWnGY+Ahxi5HLPb1pIrThCxEEJi01DAHhK3qR3C36v/SkHsKuKvy1oJs0Cb33y2Oj1u3FufNQ3c3xKYuQJ7qJcTPnsJhG2NLqZ3RkImmXc2A/+YOQTQwYYo0k5LtvbS0oTQM+ankhHDQPIcZ3RwXSdzk/Rfd8GzSNdvkUdE0pKHtst02bF+rXR5Jn8DBhp3ltXsoNM3hcwEHeL4aKC/EcCkVomgUrTD3xs7WBifh3LuSdXORbrUoo6jaXvRRzwOc5tRZyOhDxjkSpoDqZzlHB1VyPK0xR3t0vYu3fk/r8MhBysK2l8yeqxlzznn30Qo72/0LCMpmFexVI76pljM1u0wqetBYdccd3IF9KenFCeghd1yBCHRcwRctX942eIhq5LraGkYJ4oWP6pLNfTFCU1eUIAJcewlgZJXGQoarSZEKAlOEcIxgmIASlCxeBm1DsGauXu/XO0OWinqEGEPr7Ja+KY9IN0jjfbTuRWalHCNf46/xb4aAb7dMiWkti+52G2gs9zdGoXRNYi2ddubxylGfgMWJi5wxK8/YCchM6efiBoIs7b6pmfNBAJhabFRwkcZajTSHOITMnV7e8kPKhIa+VqZyv1MmnRFRgJU2NfWbaAapHCOe6e/234yef4OT4YsvPn0KE2SJeGs3jg2/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zp5e3gqY7BaLhO+OSg8ydY0PI6P1S7uecTXS8B2JRGYrc5jwFDuRIZoxVk?=
 =?iso-8859-1?Q?1F13D+FxLrD6SfgIqylj1zl8WAF6qxPAt4ZS1gY0occwb6WioAEyXH3/vn?=
 =?iso-8859-1?Q?anC+MRA5rTpkwHcm0bgtzdNkb624O9y3zOc0N1xA4Llc/yOn3bZtiXHE2l?=
 =?iso-8859-1?Q?wnkF1q57Tui3yYaQcwLiShZcJHETtLaucLhXm332lHCBxgmScvKeKTzZPY?=
 =?iso-8859-1?Q?rQkN/p05A8eKg0KsEqWTguI7K7/O1IFI1fisfHtVvhn9MhakweixYSa3yk?=
 =?iso-8859-1?Q?R5zJnzWYsNulZh+FRrhs7hfwYJ9e3Ou7Cui3ihN5UsKibot6qpmgrOf/vq?=
 =?iso-8859-1?Q?00SR3uxiPwPznYQcXTWBSKunCRYOEQOSSq9HfuYDcvOWmydZ8hRL56PBbL?=
 =?iso-8859-1?Q?bIYxvY7LeMTYxqqB6WZZvATaMO3fXM/OqpP/hfQGBEP8yCsxHr4qi4ai4C?=
 =?iso-8859-1?Q?JrnM3kBJrrm2lgEtXCwzrZECFoLTPgzee5Z1b7rCapSdEYwcBB4/KWZFeb?=
 =?iso-8859-1?Q?E9l9IcjWb18Fc/GWW3DxmK4UHckWv4Zidyik3Pvot8wNsJQrVJGDPe2eP2?=
 =?iso-8859-1?Q?LjZ/9ZtqYB+4Qr9L0Q8ZLNBRIiWGlcM+nG0Khql4Sgxu0mqp5IMR2Qi3LL?=
 =?iso-8859-1?Q?5z0jVr4sqR85rEJh7crZSuXFwtarvEWNQhMokQKykTTng7zhl6R/sc1M1v?=
 =?iso-8859-1?Q?xwayhmWe1MgP7+Uz8HdyO44Cly/5WP6pjxqrjrjnSNV9zUv2AP9FIHELA1?=
 =?iso-8859-1?Q?6Frsa8XNykUAIbXnAdPODfJMEDRCVf/qkCtuoSwiQh7y7or+UMbSbCW9T+?=
 =?iso-8859-1?Q?vmYu/Quc9res96FHxozEIMRMd6wIJNcaEDzCRao3p6WsKXhIxgu9f5pUC8?=
 =?iso-8859-1?Q?Lh3pQlixEsPFy1RioRNEpsFFB/LuMLCfM7r/zWGPP4SnVQUO0Y7pxIAbSo?=
 =?iso-8859-1?Q?sKfTYSjdTm6HQgZZBeS3DsyDYiMOyyzytLGoq6eSuX64qy4nbljnTz9Jvp?=
 =?iso-8859-1?Q?jLkrfUTlZpdx3OE2QqdW19yU91O5aCT0mObe78PrdG6vxNeNcCV4Xy94xh?=
 =?iso-8859-1?Q?2gvd+5akbyQjI+xduonjpIol9xS2VGv+38D0w343Ya/qKn/z+XDA37eRnJ?=
 =?iso-8859-1?Q?d9R75ZrJVF9ECwjb5lHVaw7gPOIkOHskql4H8qPstBI69HaVJ2RKHKJcVs?=
 =?iso-8859-1?Q?5MudnhG2MgVOIlM9MOFCUMXT4xwIlpWCD23FqGCRKDBxPxkq8CykIMLBHZ?=
 =?iso-8859-1?Q?BeTpw0v8RMjVWXr+eXAncjoTyqNH7sVGmo4NCxHuwULpdSdLfBQ0+BG/Lk?=
 =?iso-8859-1?Q?msRWhLvRIUOFCmNbNGGrkZ5p0MY17fDqdWpnnUuwOpgIFF+6UvB865txUW?=
 =?iso-8859-1?Q?8Y9ezO0CCrVSjtninlaWrZHCiXEoQoFV7OqYUroZT5005Hr6wRaHfF113y?=
 =?iso-8859-1?Q?trYfcK6oc8I2k3ihTVLj4xWiPhDmzhM0bK/xp3kSzSZmK5uux3Yf45g297?=
 =?iso-8859-1?Q?p0/TTmou8f/30D9pJCVOJf+hpYVNSFt8AVtR1EJkV3FsZ6FWWaKoX9kRw5?=
 =?iso-8859-1?Q?qH4S4Qy+ZNi2bgwc1JzMQYUGtfUaDal43eX1VswXCLRfGmnH4jHyYPibr3?=
 =?iso-8859-1?Q?G7dxMzUGVKGUaf9aQEKO9LpklF7qnul+b+9yOQiLEszks470UQs1bunQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3794fd7-e7f8-414a-7d96-08dc4a1915e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:37:58.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoySDMMo3p9ZglW3hBz7VbVEqY8pepC1dbTedsTdH4/8GCoZfyqfGSYJ2qJUjZiv30TW0JdRwhe8jn2ER+zkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 10:21:07PM +0100, Thomas Hellström wrote:
> On Thu, 2024-03-21 at 22:14 +0100, Thomas Hellström wrote:
> > Hi, Matthew,
> > 
> > Thanks for reviewing, please see inline.
> > 
> > On Thu, 2024-03-21 at 19:09 +0000, Matthew Brost wrote:
> > > On Thu, Mar 21, 2024 at 12:37:11PM +0100, Thomas Hellström wrote:
> > > > For each rebind we insert a GuC TLB invalidation and add a
> > > > corresponding unordered TLB invalidation fence. This might
> > > > add a huge number of TLB invalidation fences to wait for so
> > > > rather than doing that, defer the TLB invalidation to the
> > > > next ring ops for each affected exec queue. Since the TLB
> > > > is invalidated on exec_queue switch, we need to invalidate
> > > > once for each affected exec_queue.
> > > > 
> > > > Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after
> > > > rebinds issued from execs")
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > Signed-off-by: Thomas Hellström
> > > > <thomas.hellstrom@linux.intel.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_exec_queue_types.h |  2 ++
> > > >  drivers/gpu/drm/xe/xe_pt.c               |  5 +++--
> > > >  drivers/gpu/drm/xe/xe_ring_ops.c         | 11 ++++-------
> > > >  drivers/gpu/drm/xe/xe_sched_job.c        | 11 +++++++++++
> > > >  drivers/gpu/drm/xe/xe_sched_job_types.h  |  2 ++
> > > >  drivers/gpu/drm/xe/xe_vm_types.h         |  5 +++++
> > > >  6 files changed, 27 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > > b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > > index 62b3d9d1d7cd..891ad30e906f 100644
> > > > --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > > +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> > > > @@ -148,6 +148,8 @@ struct xe_exec_queue {
> > > >  	const struct xe_ring_ops *ring_ops;
> > > >  	/** @entity: DRM sched entity for this exec queue (1 to
> > > > 1
> > > > relationship) */
> > > >  	struct drm_sched_entity *entity;
> > > > +	/** @tlb_flush_seqno: The seqno of the last rebind tlb
> > > > flush performed */
> > > > +	u64 tlb_flush_seqno;
> > > >  	/** @lrc: logical ring context for this exec queue */
> > > >  	struct xe_lrc lrc[];
> > > >  };
> > > > diff --git a/drivers/gpu/drm/xe/xe_pt.c
> > > > b/drivers/gpu/drm/xe/xe_pt.c
> > > > index 8d3922d2206e..21bc0d13fccf 100644
> > > > --- a/drivers/gpu/drm/xe/xe_pt.c
> > > > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > > > @@ -1254,11 +1254,12 @@ __xe_pt_bind_vma(struct xe_tile *tile,
> > > > struct xe_vma *vma, struct xe_exec_queue
> > > >  	 * non-faulting LR, in particular on user-space batch
> > > > buffer chaining,
> > > >  	 * it needs to be done here.
> > > >  	 */
> > > > -	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm-
> 
> While I remember it. When looking at your series I noticed that this
> line got incorrectly moved there. Looks like you used
> xe_vm_in_lr_mode() rather than !xe_vm_in_lr_mode()..
> 

Thanks, indeed I did invert that logic. Will fix in my next rev which
I'll rebase after this is merged.

Matt

> Thomas
> 

