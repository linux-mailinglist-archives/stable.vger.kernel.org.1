Return-Path: <stable+bounces-28635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3262C887221
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5246A1C20B82
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F578604B8;
	Fri, 22 Mar 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwjFJETy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13054604A6
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129727; cv=fail; b=aARANqBgl690PIMaVI5opdKgGLUdD/wUXcE8h6ku1b2D4CNRLIxZzvwXV++zYSXwCbJkMkNMxnerBj7PLScCQg3AZEkRBvKapwzV9vMrYOwOzy+PhJK/XQC+JvJODaRp2SPpkHATAnd/Ow88ptPKlbacBMpiga9Zqh/wNVJk0qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129727; c=relaxed/simple;
	bh=FiKz3yT2E86/mZsgrZoAb+vYSQMKzPKvzvvm5YvEKGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4Q5SLcN7bpYtQ/yuASaUC9rME/sie9OGpbczELqgxc67DJU+eUU3hV3C/kdesvSjKCNfTYXDbwvVoPOk8p2eWYxt4JqU5xSqaiUKiaGu31zUqqadzM3UsIWqVPt+yPOujQldiq+7k004zredN5DY5p1McA1h42xB05QV/a92vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwjFJETy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711129726; x=1742665726;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FiKz3yT2E86/mZsgrZoAb+vYSQMKzPKvzvvm5YvEKGc=;
  b=NwjFJETyssei7L9iiFA8YIs+Rcpf/7nh1pfXL+eKQLTGbhVJsppdIdXA
   1j7tq5ZriufMY6sGJ752mPTLmBWVXQS8skBxjmt+8Db+p4D/gV8JD1t+e
   M8hLtkZ1xJ75Hzda76GYApeYUNcunzXQcrKtNlf0RXBH7q8WDmaPuFPoj
   S5j0Mic9eohF/ggs52/0/yuYM6s9pxtCTuwMEO39MEY1IU+9uFVdFVjDk
   8wbw8KxFYQZ6nfKKIqt0edWwSYx6SN6TIsFCxT7E3bwE+FS74JtM8dG89
   vXxRYzckHV7QKEEA6pgRHIw1mGpIFLNNIwAZE7X7D53gnPCNMrTQVH0e2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28668382"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28668382"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19679222"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 10:48:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:48:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:48:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 10:48:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 10:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Memmgy6q5veqVoI6iNADhNXXIivp2RQBd6O0B4lkjNINl3cZQVBGw6hKgm+B3M96FKy1X3oEHa1bhYPzULeGhP81oS8d1+qTnyEzs3XHKF9XPBHbjviWXfj2CPkm1A4tSlrDkEZ+Snt4mf++VcOnf6YUyZIpSNAYOncSKVIgEmZEsMJ4cXAEDRdRXz1Ksigimy67ymY25jZ8erz89VFgNHWr2O62oQ5vzrj7p7NseRiNaF9qMs61gQIS0Vc4T8gckyJa2T+y7jZ3p2p848sB5Tu/y8fLHNKpZ80EPyaZ5LtRQ7QXDgFqNas7Vn2dzMtlHZaGqJPYj900Nzzg7XpIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1ueyQiJya8UJZU1XwpvwfDqPYWKMV8DatoSXACGSyM=;
 b=FDMaXmaUD+FhYnaCfl7vk+g1dUYYpesXJ217bbXjPwSn6sxQ7lcYXVVXrm7C9UD8HVvHufmZ/84FE+qmnMFIZuLLCpBE5ZqMSm11MgRbvyw+SaizbgxfNKinRR7NR3CmnjTJV6HZ52vXfeHx/BzVrLYo6I+/NZpn3gKm1meKtE/6J+MIu6/PEWea2i8niUMh7gcEwIP618kaYmpGdx8JM+UK6t92X1FXsRVId83bchVu4w6Ll4ZIpGAHmRzB0Yl1lz0FlClljQjgf3+tJK2CAXWUM08k54rEttiyECdxuueuVr21HBsC28mkHwl3VNohIV0tpFsim/DIVI17OdImbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 17:48:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 17:48:21 +0000
Date: Fri, 22 Mar 2024 17:47:21 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] drm/xe: Use ring ops TLB invalidation for rebinds
Message-ID: <Zf3EKYZ8eRc2Jhnv@DUT025-TGLU.fm.intel.com>
References: <20240322090213.6091-1-thomas.hellstrom@linux.intel.com>
 <20240322090213.6091-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322090213.6091-2-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a84aed-cce5-4d96-a2b0-08dc4a98440c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evwjfsXP0mfNBtJpIQYZxnFBX+s/Z+ttcOB6w5xkh8zh6sZmm9A+vMqDXq3WvXfnsthjLXMLtfe97ocH+PAXt4wg7BX7ljVUDqZnDsn8+Fkw/AoGt6GbbYWF9mv7Nexh9wF1vgVdGNBm3CtbE2nyZFS1ioVVFD69SaMkhcIUM7w8yWnNd/JCZJsEuxlYawgxZcQaOvvGgabCcGIjY6xHFAhrCewhP3PJuH1D3FASarL6mYOoN+vNILy1f1yFdq3x3dLYYRVDLPNETYO4IjNXBWx6XnLsjAShhO0UMuX6uxhSmkh7sXLKwrs1sjPsbU/kvSRpRFpsjsix46+8gQZZKdL2aJsQ2dRLhWNMqBsplyBQ4bv30uR7fXKI+FcdU2ZqyksMO1oOrK20sWzCcD1RixDs8tR5ZjyXw54zudFEvRv1Z4batH2hJLbGqnFHKQw4z7jSG6ekxotwP5ADIVz2dPI+jzSIdiCaoo5Aa7c1kni/rd5pXX+vByySFdsdrN3kYSHcxZ8ztBeSPiFBrXBx1jjh/JHMQyEGf28rOy1jIMcUeYAGyTlDWgklyBqiqeuY4q36szKA+jBdaAb+M49tRaC+afWybSvhubHmBcxdB3YdEduq+MUEOk3Pfk+aaHpSs63Y/kVrLmM7rvkU57sr8KDk7StVo0feMdzrGMCcIOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eLrvP/jqatfDLRLIk9u08doejKLUgMBo+e6TLfptFORHy0b9eob0qKzR1J?=
 =?iso-8859-1?Q?mjiC6o6zFMCSvgajOyaaHhwEe7vg30Hj6LCSBIWbi7NtdcPXKUDPP59n92?=
 =?iso-8859-1?Q?3ioVlyNQiNPhrJrQCSOWkIW1k+Gi35b1EGstGdpnRrL9e+B5ubalYnDF/Q?=
 =?iso-8859-1?Q?4dzF11BmqCGPo5wKiyhJ91t1ESTFulywy2eoQST3ywna3tIhgmYarPShU6?=
 =?iso-8859-1?Q?y5QGPZMBhIq+c+huYgHPhhaNYNREHfZFerWLcVCZX62le+xONwiNpg1VDv?=
 =?iso-8859-1?Q?KbZavjjRlM6BzU3F2X9Cth+vEdZusyOxJeW5SNfnv/1nQXW9TNzzrumoMA?=
 =?iso-8859-1?Q?SQu6S5/Ii3odHwwGQ0BOxYCTYGhttEYrD0wYKfarie+PHGeQAtZ63fHQUd?=
 =?iso-8859-1?Q?qAXxAtd9TzqVA40q1Lv4VzQjZ5aukHafs2Ael2W5+zlJ3f014kYG5ab+JV?=
 =?iso-8859-1?Q?HKNgPBTELGv6aHpu69B83qE3bPnY66FmkkjV9sGHg2PE/WYGm9V7AdKd0I?=
 =?iso-8859-1?Q?b+GhR5CISVL2tgU4NeH6oz/4P7slmTJAamFbbzBfVm3iP+ydVDN4snQDKW?=
 =?iso-8859-1?Q?PVPk/ABBeCn+CGe2VQRpqs0aduMobAPY7qs3gCOBhodgz+tCpBOYQoIX72?=
 =?iso-8859-1?Q?LN1Ltmj6luiMo4x3z6CXF4mLBLURoj+DZ6cLKnTO86J6V7HVhHCtqpdoYz?=
 =?iso-8859-1?Q?bvuMBkFk9Z25HDB/N2IXUp1KLppoP6oB1MlidEMCgpeRUKm6YLWk9bKl8s?=
 =?iso-8859-1?Q?pFVzseLRht8juxbm5bQ611DSEidp79tGcjJboEXeScA2KNjoXpfW0i9baN?=
 =?iso-8859-1?Q?kI8iR3ZvAB/KgVw+brfLwJNEkN575idQ7fKtaHoI8rWK+kM3RNyZLgg77c?=
 =?iso-8859-1?Q?gNhZiQHWA+LRukVJOSXzMpZRmWwBBQc7p+suNlD7g9TnqESZBhAM/M7L8L?=
 =?iso-8859-1?Q?sBOj1EThOEHDgvKf9HW61XBet0yHXEzTvxQXhbyWtNRVwhMzwpxUGYXtHi?=
 =?iso-8859-1?Q?qWMS/SVgcukbzvxjtTdR9OMclltXO2mi5jguAePbefhBr5JgjjfPCaFlkA?=
 =?iso-8859-1?Q?DG5TQ+9kTAs1YRTqRNAAhOP0jP8aQRoekauRCpuKfR7YIq8sLggCQgAz2t?=
 =?iso-8859-1?Q?3GOsvzZHvFvRCaZec7ce5G9ccaUHB35pG45xzdKECMwV02kXGFHhiQuH+r?=
 =?iso-8859-1?Q?gqGk19DMeT2Cj/ML4bpph31NloGqheYtmCylhjtUexjAuEZNQaHa9fA5jJ?=
 =?iso-8859-1?Q?EjGTGzk41Lkrq8k5FwPgPZZ3pjZmS/z3hjX3nODLFh38tNAVhDOe8CuIP2?=
 =?iso-8859-1?Q?eOOQbaS0gJsi8Po4P8Co2IoiYZ7Y9GhRsbaDEklYst8T9g/W9PnN/Jc9zt?=
 =?iso-8859-1?Q?of8yCYmul/jHDBbn5kNdP3FAuKzWtRL2ixAz9bhS6q2id6EgV9CvKEsAYo?=
 =?iso-8859-1?Q?FGAX3V8kNePWxX3jD6UnIDsIWi8QVBVRsAJQTcf3lPDVFzm7hKgOd3v147?=
 =?iso-8859-1?Q?3nFzVHcKQ5eVsNMgTWSR5AZfFW3cIw51iMlEHzbQL9LU9TieAmokzCFXLk?=
 =?iso-8859-1?Q?TrZeRXILTsKRiZT/Ru+ZlvNZdLl4Iui5xkqzbIV3obDECtPr/nQ7Bc9MRn?=
 =?iso-8859-1?Q?d5dSR9m9LzI07hCVG3d/zJLE6yQ+Qo2LZW0txRc+C0dqr71lEoUhvmxw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a84aed-cce5-4d96-a2b0-08dc4a98440c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:48:21.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Llg7pHprqQOIls7D8wbMFFv0oPRdXqMPfoDwLHFIssrymymqkJRUtV8iqoeqn1IgtoQxjvqB/wpvVhtg/xOFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On Fri, Mar 22, 2024 at 10:02:07AM +0100, Thomas Hellström wrote:
> For each rebind we insert a GuC TLB invalidation and add a
> corresponding unordered TLB invalidation fence. This might
> add a huge number of TLB invalidation fences to wait for so
> rather than doing that, defer the TLB invalidation to the
> next ring ops for each affected exec queue. Since the TLB
> is invalidated on exec_queue switch, we need to invalidate
> once for each affected exec_queue.
> 
> v2:
> - Simplify if-statements around the tlb_flush_seqno.
>   (Matthew Brost)
> - Add some comments and asserts.
> 
> Fixes: 5387e865d90e ("drm/xe: Add TLB invalidation fence after rebinds issued from execs")
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec_queue_types.h |  5 +++++
>  drivers/gpu/drm/xe/xe_pt.c               |  6 ++++--
>  drivers/gpu/drm/xe/xe_ring_ops.c         | 11 ++++-------
>  drivers/gpu/drm/xe/xe_sched_job.c        | 10 ++++++++++
>  drivers/gpu/drm/xe/xe_sched_job_types.h  |  2 ++
>  drivers/gpu/drm/xe/xe_vm_types.h         |  5 +++++
>  6 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> index 62b3d9d1d7cd..462b33195032 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> @@ -148,6 +148,11 @@ struct xe_exec_queue {
>  	const struct xe_ring_ops *ring_ops;
>  	/** @entity: DRM sched entity for this exec queue (1 to 1 relationship) */
>  	struct drm_sched_entity *entity;
> +	/**
> +	 * @tlb_flush_seqno: The seqno of the last rebind tlb flush performed
> +	 * Protected by @vm's resv. Unused if @vm == NULL.
> +	 */
> +	u64 tlb_flush_seqno;
>  	/** @lrc: logical ring context for this exec queue */
>  	struct xe_lrc lrc[];
>  };
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 8d3922d2206e..37117752cfc9 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1254,11 +1254,13 @@ __xe_pt_bind_vma(struct xe_tile *tile, struct xe_vma *vma, struct xe_exec_queue
>  	 * non-faulting LR, in particular on user-space batch buffer chaining,
>  	 * it needs to be done here.
>  	 */
> -	if ((rebind && !xe_vm_in_lr_mode(vm) && !vm->batch_invalidate_tlb) ||
> -	    (!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
> +	if ((!rebind && xe_vm_has_scratch(vm) && xe_vm_in_preempt_fence_mode(vm))) {
>  		ifence = kzalloc(sizeof(*ifence), GFP_KERNEL);
>  		if (!ifence)
>  			return ERR_PTR(-ENOMEM);
> +	} else if (rebind && !xe_vm_in_lr_mode(vm)) {
> +		/* We bump also if batch_invalidate_tlb is true */
> +		vm->tlb_flush_seqno++;
>  	}
>  
>  	rfence = kzalloc(sizeof(*rfence), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
> index c4edffcd4a32..5b2b37b59813 100644
> --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> @@ -219,10 +219,9 @@ static void __emit_job_gen12_simple(struct xe_sched_job *job, struct xe_lrc *lrc
>  {
>  	u32 dw[MAX_JOB_SIZE_DW], i = 0;
>  	u32 ppgtt_flag = get_ppgtt_flag(job);
> -	struct xe_vm *vm = job->q->vm;
>  	struct xe_gt *gt = job->q->gt;
>  
> -	if (vm && vm->batch_invalidate_tlb) {
> +	if (job->ring_ops_flush_tlb) {
>  		dw[i++] = preparser_disable(true);
>  		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, true, dw, i);
> @@ -270,7 +269,6 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
>  	struct xe_gt *gt = job->q->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  	bool decode = job->q->class == XE_ENGINE_CLASS_VIDEO_DECODE;
> -	struct xe_vm *vm = job->q->vm;
>  
>  	dw[i++] = preparser_disable(true);
>  
> @@ -282,13 +280,13 @@ static void __emit_job_gen12_video(struct xe_sched_job *job, struct xe_lrc *lrc,
>  			i = emit_aux_table_inv(gt, VE0_AUX_INV, dw, i);
>  	}
>  
> -	if (vm && vm->batch_invalidate_tlb)
> +	if (job->ring_ops_flush_tlb)
>  		i = emit_flush_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, true, dw, i);
>  
>  	dw[i++] = preparser_disable(false);
>  
> -	if (!vm || !vm->batch_invalidate_tlb)
> +	if (!job->ring_ops_flush_tlb)
>  		i = emit_store_imm_ggtt(xe_lrc_start_seqno_ggtt_addr(lrc),
>  					seqno, dw, i);
>  
> @@ -317,7 +315,6 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
>  	struct xe_gt *gt = job->q->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
> -	struct xe_vm *vm = job->q->vm;
>  	u32 mask_flags = 0;
>  
>  	dw[i++] = preparser_disable(true);
> @@ -327,7 +324,7 @@ static void __emit_job_gen12_render_compute(struct xe_sched_job *job,
>  		mask_flags = PIPE_CONTROL_3D_ENGINE_FLAGS;
>  
>  	/* See __xe_pt_bind_vma() for a discussion on TLB invalidations. */
> -	i = emit_pipe_invalidate(mask_flags, vm && vm->batch_invalidate_tlb, dw, i);
> +	i = emit_pipe_invalidate(mask_flags, job->ring_ops_flush_tlb, dw, i);
>  
>  	/* hsdes: 1809175790 */
>  	if (has_aux_ccs(xe))
> diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
> index 8151ddafb940..b0c7fa4693cf 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job.c
> +++ b/drivers/gpu/drm/xe/xe_sched_job.c
> @@ -250,6 +250,16 @@ bool xe_sched_job_completed(struct xe_sched_job *job)
>  
>  void xe_sched_job_arm(struct xe_sched_job *job)
>  {
> +	struct xe_exec_queue *q = job->q;
> +	struct xe_vm *vm = q->vm;
> +
> +	if (vm && !xe_sched_job_is_migration(q) && !xe_vm_in_lr_mode(vm) &&
> +	    (vm->batch_invalidate_tlb || vm->tlb_flush_seqno != q->tlb_flush_seqno)) {
> +		xe_vm_assert_held(vm);
> +		q->tlb_flush_seqno = vm->tlb_flush_seqno;
> +		job->ring_ops_flush_tlb = true;
> +	}
> +
>  	drm_sched_job_arm(&job->drm);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
> index b1d83da50a53..5e12724219fd 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job_types.h
> +++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
> @@ -39,6 +39,8 @@ struct xe_sched_job {
>  	} user_fence;
>  	/** @migrate_flush_flags: Additional flush flags for migration jobs */
>  	u32 migrate_flush_flags;
> +	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
> +	bool ring_ops_flush_tlb;
>  	/** @batch_addr: batch buffer address of job */
>  	u64 batch_addr[];
>  };
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index ae5fb565f6bf..5747f136d24d 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -264,6 +264,11 @@ struct xe_vm {
>  		bool capture_once;
>  	} error_capture;
>  
> +	/**
> +	 * @tlb_flush_seqno: Required TLB flush seqno for the next exec.
> +	 * protected by the vm resv.
> +	 */
> +	u64 tlb_flush_seqno;
>  	/** @batch_invalidate_tlb: Always invalidate TLB before batch start */
>  	bool batch_invalidate_tlb;
>  	/** @xef: XE file handle for tracking this VM's drm client */
> -- 
> 2.44.0
> 

