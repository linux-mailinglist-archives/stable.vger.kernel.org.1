Return-Path: <stable+bounces-67672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B541951E75
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6B1C20A87
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E11B3754;
	Wed, 14 Aug 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfRKG+3T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBB3D3B8
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648972; cv=fail; b=Q7aWun/ID/oxv69LtbhXkdXbYoAMceRjJM7lGshp7QklEMOVW/47dzwlqbxN3RvLl+AF+G2iJiU/8X3TZCpK0RhFWBEQCEXmsJvpAvajRt3n0krTB3ycrnlFOUt4XSJJKZHNFz9reuaDyHuOTGupdLKcgqbX1tuHOcNk9WU5iUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648972; c=relaxed/simple;
	bh=/3wNR9mM2PjRDm3F3Tahd61KmrCN0vA233wcU+i9Yyw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wqb1WFVGlTVBUobFAWEJLFfWA9FAJDsWa9429l0341pVExZapVGsX2v6gJ8oSEypuI8U40ibZuNXm0oLFKrOqIs8H8LHrychojT0lNL/5sq7asuxXzfVlvqgRqvCbNPNkHGVFRf1NYJnZ5NtLYUPgo6L3GtrvQkyTwHuZTYCDDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfRKG+3T; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723648970; x=1755184970;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/3wNR9mM2PjRDm3F3Tahd61KmrCN0vA233wcU+i9Yyw=;
  b=lfRKG+3TI2WAHcmov5BGUwfVcunmAIHo8SoUM/Klnct99m1YRtt3isux
   31PnxXnp+m6Cz2fbtXXIsXgNLdx+5w26P8w++Ct4zZZJPZlsHKq9u5VHA
   o6zkxy3wzeAdRub2kj5fx4kwwfWel0A3e3ChWYDLQ6f7xUlf7U1doB1V9
   KjjZO+gfivRzPICdWtRzH/biNYY7V6ZSqkuBIG2bNt0wDWakdTouX56S2
   vSYwEOVnqLpyEvwkvas0aWfnEmmJbvx8D9erKh3F+1o4g+9exo3FjpdX3
   3v5JEEKdNlKvtot8F1u6YjMogG7gGw6/tMjJ+9Y7c9X+xK6YnCWfClGXH
   Q==;
X-CSE-ConnectionGUID: q8K8TDhqRNuwUfNVF69H7Q==
X-CSE-MsgGUID: e2Z5EMRBQjSwCdPNxRKR6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22012646"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22012646"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:22:49 -0700
X-CSE-ConnectionGUID: TN8oj6ksSxWT3OV1t8E9gw==
X-CSE-MsgGUID: rcAWebVmTj+jt9mwrNLScQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="63896065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 08:22:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 08:22:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 08:22:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 08:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR4ApL91fZOejIUv359q3ZRD0MHYUDVGcjoL6vFy7e816i1cuqdcbNOeTC0EmnwB6ImHjqhMkamPzUXk6Ix7HojGCd7qVf5VGSdepInz8XBP3BZbgMI6zf/D0wuI6RsQATofCoVF3hMq2xezoT8v+eZKUXdKf3N6cuiGyuvsFpPKk46OGo1ZDLX+7R46JkKBmQljNAGYDkrK3IBjPtivxyuxW43ZoEZbtlbqTA4hPglaJJ7imK83XcICTOZBIvoTSjchCVpe2BbUYf5ZTr2Kuwniem1SYH7thSnPIvlYEcG8mgvvECVrrgm8DmfCfmHEmf/Ou80yLf1Ytcdy79v1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96za56GU52m1tLVmPYvOY7Tc2NEzNYsc6AnV1fIw7RM=;
 b=ZRAQtPpzpig6vdPRZKZj8dugZQgmZt/S7WAI9WCeuFM6zqzzLmmW4mL2IeUZdw5rEqhcSDEiGVzwyY8/ZKrjcja4/DiVEzSt8hVI3uncGyfvKcvnJGhOCPnw9ArDFmqymtBek/zPUkNqbyymapx61jftjjhh3LZ+wfxFuXlf0ggGdAS154/EX5Pei02+e6VmVT85NAOQ0mQ9fPpSOwm3jPXor/QoZNcBTwssVkmxQRtFvw5foIX7dJ0LM0BXw4UGXEo1MHj1pGShE0+jwRTgX8HlhSdoRjir9s+UHnMN4NGZyxevExhOaDrYWAqbH4kutmm7/4+6V/Cm4Aba2LfJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 14 Aug
 2024 15:22:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 15:22:45 +0000
Date: Wed, 14 Aug 2024 15:21:44 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: prevent UAF around preempt fence
Message-ID: <ZrzLiMSn059qlu7P@DUT025-TGLU.fm.intel.com>
References: <20240814110129.825847-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814110129.825847-2-matthew.auld@intel.com>
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a71d03c-f6ac-4481-a33d-08dcbc74f2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: rrEDupHZJo3tPcWdpgWeMnEADvjC3+DwD+JsFK+xcNWfr5K0IQMak53hTUPW99xJvvtduB4DEjsNkwlj8uMUCdwKlOTB1Ec7JXn0eq8qKMG+6YGVXmhM1nJlrvfU/CsLurNxuy/h+OoBtbXc5Naksr5xXm+FPySufHBKv0PPfhcGbcCf7tgyEVd8aQT9rU+7W03dUKpkwOPtecKWUF5sjT9lW5CNW4uzQvNdEhh/SYEAmBMkZOdCjwL/KHxyV1f7OU0abaDlgTYo0qIjwIfyw1LPCLxmX5eSv9odVf2MTugWvoxiKNyLbgIxfg3FtEGo3ycIBxuRg802xF9qSVDpw+8K0gdQjT3tS1yo+2FMYU04g514X71ydjMwN0ZcFKqPmtfrLLTvAnasxR9et3na1EZdzTvMdzcuL5wUq4mIN1yXd3BLtAmA6rDS/UV5O44Bb/4JAKWotijjGO9iuHCaGZmx+LnSvQ8j+3kZZc5FlTAQQP36MGnLSnMpjkygv2+HcYbUxFTXEofX5mZRLSat7gL78UASqRBZSopUhQwgKihIwt8nthlEYgiqwaHFjP1wL9QiXY38VyxkRkU5VY88DqZ572pIl+wvFtFf11lC0gRA2x27c5UveZfzx/qC/TJS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkEFmrLPyj+NIdw/ZHdUxuu/cVF02CX7Pt9LJEvvH4LSN0Y83XdeV3PGiBzA?=
 =?us-ascii?Q?cfH76h5NNhvKoGTT4iozh/bCKl4fNLUQNhBZoxE0hl6Hwk1V7g/y8til+acN?=
 =?us-ascii?Q?sovRdfzajtjv7Qt47YrKQHazpG/fK1LgPXL6nRf1MJp0E+mNm71OpXYK6nQA?=
 =?us-ascii?Q?gTELkHGLGFDBuN2JkUqpa21HG04j9qm1emo3OcGgW6Tj5T+6SiY4KGoXh0FL?=
 =?us-ascii?Q?t6/DvXzJRK6FhREM4OKivJLStRtW86yBYipCJPcf981cbiNIWjRO2NfA6ogH?=
 =?us-ascii?Q?1F5t619FvOiDmfDuijA+x58rkXhYoCISbYu7qysQRgyXOWZX6FXaEapmTYoz?=
 =?us-ascii?Q?WJDnbzGS20Jf6iNVzQbpISv8H1b65VP5g2vixsDCpDoOZbzTFrnSMrnyZQzO?=
 =?us-ascii?Q?figkMXiW1CRq8LpCPYERv15owv2Jny0jUv0bwspe56gHEbSy4D+lNokDqeGv?=
 =?us-ascii?Q?Xw2GmrMcZP8B76mKAJ+0b2U168Dzne/w+QQcuhyuBXnF8sat+XQRtpIqn5Cl?=
 =?us-ascii?Q?Gh/Jwfuw8Lt4o5hSY5mCq8SvEBZYAan67kbFiY6u0LU+0nMF7X7Ll2UpOLaQ?=
 =?us-ascii?Q?LRk1j092DzHVkpW0CcZJ/dbQ8snqQy8QIURhU4a3zp1Sg5Kx/nAX2q5vmb8I?=
 =?us-ascii?Q?lacAPcnzQIATN7fVN4R7caCl9QrOsEypqZZRUptnCjfKcMp/9pRQ8Tjw51XK?=
 =?us-ascii?Q?ztPAXQ+STv7WCPBDRaouLnE7mfKfcQy4TcQO0XQICiTDUrJtzZnmzml27PMl?=
 =?us-ascii?Q?9nPoyogD7l546qlFGlxrocuwnqArRnUb5aFC8A4D6q3S5OG3l2WPB1RdTpGb?=
 =?us-ascii?Q?O7HsUqYeZDC5FJkRXpzrJjm6k88KIU1Imrd5cmo/KykreWOdVlhAWRl0HMhM?=
 =?us-ascii?Q?N1GuTz1P8qpLYQbPV0JJKW7XmokgKbdR9KC0lJRKRQLeIgDJdNEfuRQwm9TS?=
 =?us-ascii?Q?FxiRI01efLcqz9YWUvrIIuR0EtSw3WmJM6wsaT2APRHA0jpzyWF2sVd0PQZO?=
 =?us-ascii?Q?bpcQkQ1pulMIPVhAst3aw37EzAjEBeZDixLYe3U3xbdvLX2/Jhj7U0A+Jv0n?=
 =?us-ascii?Q?3RzKeN7UmLvlc36MJynCUdaOlhD2z603vXW9SKDfS6Tt7nmwsslNiZ3puap6?=
 =?us-ascii?Q?C2kz1Xiv/B09/Ubg6DH9JQ0VqI3u9DVM9hPsFHXl51nbcV78vbpWuzQTAdQO?=
 =?us-ascii?Q?HlUUsKH4HeUf8pC3M4nubFFdFbahwkOn4uXS7Lb91vIuz1+T1bE0USq+lCdH?=
 =?us-ascii?Q?N2p4w4eZWD7IZCsFFiQEZ3INdMq0kvT+w3Nyc8B8+eLi2PNDINQoIPn2RldZ?=
 =?us-ascii?Q?jDwKgwwxtlCszxpy0YYZ8u+A7fK2krx5RjW1j1gOIxS4RvZ2vEOVZmRDrw0b?=
 =?us-ascii?Q?qCyI52yAxUfl+lV6+GG+c92WOMPl1PxbqYjH3T5o8OjEyQwCEJUAE5KRcvcM?=
 =?us-ascii?Q?OFWvoGBx4bkC3DqmLfzWGYKUoOf6Qcii9BJOzZSEAvu4idjT1eeKWdC4aYms?=
 =?us-ascii?Q?VKPz7rZAMZ85bCQtym9/p7LXmiJcngYvhq/4YeSOgxwjvNOjVKZ1t8gNXPa+?=
 =?us-ascii?Q?OrZYPT8vYVg311B2BM0FGzm6d+Lt038aZ43Yk/482EZh/+zb+7UDEVjsuHlJ?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a71d03c-f6ac-4481-a33d-08dcbc74f2e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 15:22:45.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3A/TJ9XQhNE2KxlJxVS8UyxtppfhVYwd/CBGfMpIRmrr6TU6Nt77MfHU5DwylQhrsWZbSR7GsNdAPmAiR8fEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

On Wed, Aug 14, 2024 at 12:01:30PM +0100, Matthew Auld wrote:
> The fence lock is part of the queue, therefore in the current design
> anything locking the fence should then also hold a ref to the queue to
> prevent the queue from being freed.
> 
> However, currently it looks like we signal the fence and then drop the
> queue ref, but if something is waiting on the fence, the waiter is
> kicked to wake up at some later point, where upon waking up it first
> grabs the lock before checking the fence state. But if we have already
> dropped the queue ref, then the lock might already be freed as part of
> the queue, leading to uaf.
> 
> To prevent this, move the fence lock into the fence itself so we don't
> run into lifetime issues. Alternative might be to have device level
> lock, or only release the queue in the fence release callback, however
> that might require pushing to another worker to avoid locking issues.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2454
> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2342
> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2020
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Good catch. This is indeed a problem, and you have it coded probably in
the safest way possible.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_exec_queue.c          | 1 -
>  drivers/gpu/drm/xe/xe_exec_queue_types.h    | 2 --
>  drivers/gpu/drm/xe/xe_preempt_fence.c       | 3 ++-
>  drivers/gpu/drm/xe/xe_preempt_fence_types.h | 2 ++
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 971e1234b8ea..0f610d273fb6 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -614,7 +614,6 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  
>  		if (xe_vm_in_preempt_fence_mode(vm)) {
>  			q->lr.context = dma_fence_context_alloc(1);
> -			spin_lock_init(&q->lr.lock);
>  
>  			err = xe_vm_add_compute_exec_queue(vm, q);
>  			if (XE_IOCTL_DBG(xe, err))
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> index 1408b02eea53..fc2a1a20b7e4 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> @@ -126,8 +126,6 @@ struct xe_exec_queue {
>  		u32 seqno;
>  		/** @lr.link: link into VM's list of exec queues */
>  		struct list_head link;
> -		/** @lr.lock: preemption fences lock */
> -		spinlock_t lock;
>  	} lr;
>  
>  	/** @ops: submission backend exec queue operations */
> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
> index 56e709d2fb30..83fbeea5aa20 100644
> --- a/drivers/gpu/drm/xe/xe_preempt_fence.c
> +++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
> @@ -134,8 +134,9 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
>  {
>  	list_del_init(&pfence->link);
>  	pfence->q = xe_exec_queue_get(q);
> +	spin_lock_init(&pfence->lock);
>  	dma_fence_init(&pfence->base, &preempt_fence_ops,
> -		      &q->lr.lock, context, seqno);
> +		      &pfence->lock, context, seqno);
>  
>  	return &pfence->base;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence_types.h b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
> index b54b5c29b533..312c3372a49f 100644
> --- a/drivers/gpu/drm/xe/xe_preempt_fence_types.h
> +++ b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
> @@ -25,6 +25,8 @@ struct xe_preempt_fence {
>  	struct xe_exec_queue *q;
>  	/** @preempt_work: work struct which issues preemption */
>  	struct work_struct preempt_work;
> +	/** @lock: dma-fence fence lock */
> +	spinlock_t lock;
>  	/** @error: preempt fence is in error state */
>  	int error;
>  };
> -- 
> 2.46.0
> 

