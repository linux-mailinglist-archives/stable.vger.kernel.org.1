Return-Path: <stable+bounces-40117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E38A8B94
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 20:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7376F288C3F
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF7BE55;
	Wed, 17 Apr 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeTgWwef"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB092C69A
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379768; cv=fail; b=NO1kXJkHH6yYarx0shpZLJU8JhY0za4LNsjoWI0hyaBBQFn4QvN6zQ+pYizXmNSNri11DE/RCdutFDVpHL5QzbyaRBKCwUXdfm8V7DW+v5XO1BuC3hg6lLyBnA5Im1Cx6Y/iCyBnEDmmYcRgzt2KNdtMeGn6r0dA1C/7vbkWbwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379768; c=relaxed/simple;
	bh=VPAKCmIJuHtNi2QvLfTwTU1mVOo1MN3Oi1fVyZefBPs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bmaWMWf/JqPAlI07qYPbpjf+FyrIB2ZroATNk+fp6qPUPBm4L5NdIJYeGFNfH/O62D8LPdZdVMfrlQo4ujYrE0qZEWnQz/uTmpe+hrm13coJRxA6d8SfJQMIV2o3jDJrZxyzXyI7WTz93PdRy0KR6ql3X9zpqlmfBlccmCa63BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeTgWwef; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713379765; x=1744915765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VPAKCmIJuHtNi2QvLfTwTU1mVOo1MN3Oi1fVyZefBPs=;
  b=LeTgWwef63Lx7zOpBs+vrLPYfzKxUD8gv8jzgh3797FFS5TW9Izgikmq
   W60GXRKEikfF210xGHY7pq4EgxDp6U16fCzcaN6Wbd+2hWBzkfSRiITQA
   +JkAg2WCJsiv6wbOD9C6tHXUikv/1NJu6RbCR70Yi+GMJN+JRJzBBHR07
   zGcXV4899ExoW9qT6i5ysmWSlDMgzFFvnve1ezY+qfJSNzzEegA8yIg7b
   3cgYiqhpYkaAYwi3BWaxSycudJ6a19bjthNDQG/hjfHor6nQIhW+YiDLl
   JeDDgq6gcMsBmPdLb2ftsqFAqwynNLCrxQ3QwHNjatk4wYN7hLRWr3R0H
   w==;
X-CSE-ConnectionGUID: oEwig0cfRl6k/zPSN0dScg==
X-CSE-MsgGUID: Yn/QGE+nQiK+pFzz9CwvYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11832753"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="11832753"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:49:23 -0700
X-CSE-ConnectionGUID: BcMvq/2fRjCjbZ5ZhvzAow==
X-CSE-MsgGUID: +FELcmYeSTyW1LUAZZ6izg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="53662584"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 11:49:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:49:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 11:49:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 11:49:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmtfmLfnRP+dOl+vzGkvSuaH3dLX1dfkUx68Iqyce35fizewQifangAyWobpBZrasDByjlm6MTFC1W58dv6eZ14fP2ObK3m6g+jYygcaRh9SOe97PCPJzHYlKr0xx50iX4gooY69zJqAVkhb0fq8b5toJd4eAkciPlYspgsYlJ2fBZnx5F3GUy2jUpeG51aVh3RNyp0VaEunIp5Q8iRI90fvtDh4m7TUjWKWEzJw0VnzdDwipsExCeIDlVPSmnssKiUkv9nmyodBqQLPKnMIna2dqUnudyfbyfs+uYwfDHkTJ1mJJLUn1Xg70oYj4aNgwAsAzsfIdeELe9mUR6ASTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuinbCG0l3XbZcfPH+MaZ7eeZn0ONrXjcrU9i9PKKBE=;
 b=kIZ27ELn6AcWz6gi+W13qnq7PZ2E71IxdumoBmHrUWucPk/IuuKNLaso7e9MFVlLNLEuX8VwNtO4N9X0Gjhwdp4J1pyUJoX0abhBNcoX60g9cP1NdGDio42kMwvE/tXKWkTyKY2YBvG8jwyV3JDr8HRpGU+CvXIozT4E4LGa7A3dNTG4mdNG2/b5oQjlMek94ag/JR/nNgISZvn4Z6zxKxC1X9lNm12XZwpA5m57C2Hd42n4XW5819Ei1/x+A0VXA0RSr3qW7BbnbH60/qznYZl78RNNMdiArh+bv8Md4lRe/BicpQBynImbW8nM5y3H7d9IASCc3ouuQkRXTt1otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Wed, 17 Apr
 2024 18:49:20 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 18:49:20 +0000
Date: Wed, 17 Apr 2024 18:49:08 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/vm: prevent UAF in rebind_work_func()
Message-ID: <ZiAZpCdM5LCnTpKk@DUT025-TGLU.fm.intel.com>
References: <20240417163107.270053-2-matthew.auld@intel.com>
 <ZiAOYD0vqe64HWkk@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZiAOYD0vqe64HWkk@DUT025-TGLU.fm.intel.com>
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc7f60-edc6-46f4-acc5-08dc5f0f173a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8F9F+eATB+NMP0F0JxoI3PrSBXMsap95TwdmkLsWJzKP8+zi2D44K9eqV6rrryh2YtHG16p7swxiZqAgpNoWYsPqMNiai63BhWsa0wazPLw0+bM8xn2kZPWPbuAbu6n5YCkPP71Udqh28FD/YdjCyoff+hWX+dQx1mGCpFoGiVp6mCfotw5qRqcW2jhOISIHIL5/CprwO5nPF/f2v8ugKoL5U8vYpuDyBxzRXVo9SvEyFj0iiHRnbg2B/UtMp3fnnghCtj5N9n0+aCwG64CMwtv7s1sJhD8ixwMYVcEGDsdoIf0p7MVvbFiUykd9yQi9saLbiaZ+gbcWGWakKAucFiVgGBrke1F1YKXBOCha8ArZPbFvBqe+Nk8G/A6V0TsGZqK/e8JKR+ZzA7zygdWCMeZeT/iGloRJTobyk1wcbxuSlcAmOO1jtM/O5jECIDrKQEYGURP+MoudbYVs7Z3WMUBDWAZD3lo/WxpFIDyyDWXB7osMXm4wEhdhy7q/zY65nY06TgKm6u8gE632JoDVWnlAjPv1nAbXJ6Idf0VFRyJZwllyWnBaD0j2QXbwpDU+JFgSm0/7NNnOqBJ01uv8AQMS+pyq/DSNz2jlE0ksVz226F4r++7adsD8l6hotTW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2wsEerVVWZK5UEOC6jDWJ9GAN0vy2McF8QyXXptp4bbpbiOErMu3ld3zD4k?=
 =?us-ascii?Q?0/Wq38yB9T7jUNzkce9KfA6KlI7yYP63Cs7+P/ZInP6TjP9658lDwQgR9y1S?=
 =?us-ascii?Q?wOhkK+vaa3Z0mNXq4OM9qR/3N6Q55juVs2Y8grdkyRJsos+PuFmb8oaBk3B1?=
 =?us-ascii?Q?850ehaJ11TGWHNKJCjmimNeniaJgomur2b3NFi4QSuZ5cGSb3q6AdLg8H9mx?=
 =?us-ascii?Q?+1sQvjc9YXS9+KSJeBAWK9NlgbEoU3NucVEeKu3IjTbJd6tMmtHdk25VD+RG?=
 =?us-ascii?Q?1qMt+I5Gk2lJHRb+bb8og0EsWowQjt9TKmChLsDsh/S4PcQ7sXup7ifZs9XW?=
 =?us-ascii?Q?5EBxjyN2Gl6qRUdnTRUQ6r4yeJCzflYJYgue/eMQuppI78g8+VZvQYudB/e4?=
 =?us-ascii?Q?Fd/IcifjgBTgK7ob1wtbH1BXt+QBKCNpKg9g3K+JqxPaL7xxPD/D8gM+kIGp?=
 =?us-ascii?Q?14UhTxsn0Xh837wcT75/Vxau7YD+QotsLjynDagQozt3XOg1/2NHbgskHZH1?=
 =?us-ascii?Q?XC706/z6rUNonP8WHidqcXN2sWG81FbsHKd1dE7Slc0WJ7s5LKtK5HvzT2x3?=
 =?us-ascii?Q?7+wy8l8/Rh4PGkkhj//+oxPw9cIEsFTgKDH7MlvKYKMeCVOxQvCHbaVdkk6d?=
 =?us-ascii?Q?MjrjZJxvmm/U5A0904FoUj+u3UIw8hOLBvrh9BLhiYBB+2IS9qwCHPJHTXnB?=
 =?us-ascii?Q?tb/dquEofF4q1NGmEgp0N2obnMg2udpIrFzxOTqZIghgI+tKEx64jKMJykX3?=
 =?us-ascii?Q?XXl5VZR0DkOCexFAKP0B9vOoLKpodCyEJBvWDGxTXLcznqBi+j6HnETzXZW1?=
 =?us-ascii?Q?WW8eUqdkCOg4iolfQVsWHH7QCJPHCApYh487Dfcv0V39kFEdKXSj0gCydZPt?=
 =?us-ascii?Q?LUlAEV8GR5KUd4WSrs7x6Tb1kvjbmeXL0Vr3FycyWeHDiMaxglRq7Zq2xISg?=
 =?us-ascii?Q?RdnpDITTk9DdW8HEUcc1qvHefgNMD2mtIwmyAPcTZe5ZSXDNKpsgMXniBmQh?=
 =?us-ascii?Q?3cuN5+RTHor0pSV9YmMtGEaeXymB9SX9CcETbQ58+Eyzw0TlPBngT2KikqA5?=
 =?us-ascii?Q?6/dQ1i+JIFHRvX+kGtZ6vVy3GTyDSyz/n1P+t38kM2OSmauQwETKD3MVejeI?=
 =?us-ascii?Q?V32LP6KQkuJGqQC0VwJkanNvdjvc9d2GSwsNvBi9mz9SoUixM/BPPiRvYdLr?=
 =?us-ascii?Q?CiPHXZYcaRGQ22dLSqjmBwAC4HpTzlnuOo+zBJ+cgUiYcar0eZA5NjZ6pnwb?=
 =?us-ascii?Q?YuYd0Panywcf1jDt7PDVWoWU3sVhdPt2Tp3ssbitQ2NKN+lnPP8VPUT61gVA?=
 =?us-ascii?Q?fS/ObkfPVhWkTjYvCI1rm7Sh31BLKREcBn1j5jQw5i5lYdEeT80YLIaVecRo?=
 =?us-ascii?Q?z+jagNbgIZaBxfpcreQyA2xXM5qPsuYteWUsFXjke45UtyV/UKtd21RmhSaj?=
 =?us-ascii?Q?4bztGFtRkOU7lxqKlMbpxHHL84dr9wbCBZVRbtpmBYL+8OSaW3qDjqjFFJ75?=
 =?us-ascii?Q?RcuCSmcfWVLOykvNrHQy9tGOvRufeAOlMOniGr90ZfxsLPsLWtQbsvNSeQFe?=
 =?us-ascii?Q?qQ2nUUubxQVvgI35Oi4QvRw+Q3WuNFjMlDTjJVVzqSy5xda6mh01YsyeHIf8?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc7f60-edc6-46f4-acc5-08dc5f0f173a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:49:20.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdOZgkT8NQPssLCVk6VWsJqG/PA213EPAwtavMpIVM4u2kXc4INOo9nCea8WMEceOuX8WlCcW6P1lwvqI2ZjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

On Wed, Apr 17, 2024 at 06:01:04PM +0000, Matthew Brost wrote:
> On Wed, Apr 17, 2024 at 05:31:08PM +0100, Matthew Auld wrote:
> > We flush the rebind worker during the vm close phase, however in places
> > like preempt_fence_work_func() we seem to queue the rebind worker
> > without first checking if the vm has already been closed.  The concern
> > here is the vm being closed with the worker flushed, but then being
> > rearmed later, which looks like potential uaf, since there is no actual
> > refcounting to track the queued worker. To ensure this can't happen
> > prevent queueing the rebind worker once the vm has been closed.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1591
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1304
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1249
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > ---
> >  drivers/gpu/drm/xe/xe_pt.c |  2 +-
> >  drivers/gpu/drm/xe/xe_vm.h | 17 ++++++++++++++---
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> > index 5b7930f46cf3..e21461be904f 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -1327,7 +1327,7 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
> >  		}
> >  		if (!rebind && last_munmap_rebind &&
> >  		    xe_vm_in_preempt_fence_mode(vm))
> > -			xe_vm_queue_rebind_worker(vm);
> > +			xe_vm_queue_rebind_worker_locked(vm);
> >  	} else {
> >  		kfree(rfence);
> >  		kfree(ifence);
> > diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> > index 306cd0934a19..8420fbf19f6d 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.h
> > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > @@ -211,10 +211,20 @@ int xe_vm_rebind(struct xe_vm *vm, bool rebind_worker);
> >  
> >  int xe_vm_invalidate_vma(struct xe_vma *vma);
> >  
> > -static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
> > +static inline void xe_vm_queue_rebind_worker_locked(struct xe_vm *vm)
> >  {
> >  	xe_assert(vm->xe, xe_vm_in_preempt_fence_mode(vm));
> > -	queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
> > +	lockdep_assert_held(&vm->lock);
> > +
> > +	if (!xe_vm_is_closed(vm))
> 
> xe_vm_is_closed_or_banned
> 
> Otherwise LGTM. With the above changed:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Revoking RB, should have looked at CI first.

This doesn't work as it deadlocks [1].

- VMA invalidate notifier waits on VM dma-resv (preempt fences)
- Preempt fences signaled via worker which queues rebind worked (VM read lock), order WQ too so serially
- Preempt rebind worker waits on VMA invalidate under VM write lock

Going to have to rethink this and aside from this new bug in actually
rather dangerous too as taking the VM lock any path that block a
signaling of a fence seemly can deadlock. Wondering if we can use
lockdep to catch bugs like this?

In the middle of few other things right now so haven't thought a ton
about this but open to ideas.

Matt

[1] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-132571v1/bat-atsm-2/igt@xe_exec_threads@threads-mixed-userptr-invalidate.html

> 
> > +		queue_work(vm->xe->ordered_wq, &vm->preempt.rebind_work);
> > +}
> > +
> > +static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
> > +{
> > +	down_read(&vm->lock);
> > +	xe_vm_queue_rebind_worker_locked(vm);
> > +	up_read(&vm->lock);
> >  }
> >  
> >  /**
> > @@ -225,12 +235,13 @@ static inline void xe_vm_queue_rebind_worker(struct xe_vm *vm)
> >   * If the rebind functionality on a compute vm was disabled due
> >   * to nothing to execute. Reactivate it and run the rebind worker.
> >   * This function should be called after submitting a batch to a compute vm.
> > + *
> >   */
> >  static inline void xe_vm_reactivate_rebind(struct xe_vm *vm)
> >  {
> >  	if (xe_vm_in_preempt_fence_mode(vm) && vm->preempt.rebind_deactivated) {
> >  		vm->preempt.rebind_deactivated = false;
> > -		xe_vm_queue_rebind_worker(vm);
> > +		xe_vm_queue_rebind_worker_locked(vm);
> >  	}
> >  }
> >  
> > -- 
> > 2.44.0
> > 

