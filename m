Return-Path: <stable+bounces-28624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA68870BB
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF21EB233A5
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C625789E;
	Fri, 22 Mar 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBQRdhgN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DA57876
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124193; cv=fail; b=L/gnXr7C9vYxkC5vHOoeLG/9WHkEiTNIYvTYGoUZZqSli93SGe7OfUF+p6Yc4YjNXtRmcfB3+qhUWMapg3G72+hjEBC08Bg/dfZ2ISfcvskfVQQSBAqDbzl1+3pycMVAs9HVLxUYbnYOGSrWOmaGh3nlpDExVCel+Rb/OUn+5kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124193; c=relaxed/simple;
	bh=6rtIn8tKOCPb/OvQrHvTQeXokNej8VH6cZz/NI0dqb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8ElxFy7EzpZYKzliED6E2xiufp4MBt982j+OKlqy1SrsIsO4H442giK61/H/VT0DGRI4RYm/3142D3mkh/97LrGDt57bqkpJC4LcgUdbud+Awpux8ZBnSrkbYOeCZN/tznP0sCXU1s2vXC0JNRFU1H8LdoSuhElt26QpP8eKrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBQRdhgN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711124191; x=1742660191;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6rtIn8tKOCPb/OvQrHvTQeXokNej8VH6cZz/NI0dqb4=;
  b=cBQRdhgNYfXckYSFrCnNMRvTomF+Zq8IkTiN+Phn3PO6DC63H1mhHN+k
   RbQXMPI7+AB+nQFgY3hf+XGgO6A71IimRA8eBbrCd/3MT39dNjPRRwrrU
   A49lphcka62ZUkze1E52I8M1attynutUZYXKeNSgDPMRgxT3rjx4NhzQ4
   DoL+sBYgliPX6Pr4PHVzMZxXWgJDhbBHHsDWTLVjxMonUDMuvFaxnuz6Y
   +LhPIA7GYJdAu0sEpSA43LoHHTmbo/8AkhAxFaeHgeBe1btDZlHG7hU0R
   jjtWRcMyzxeSAejDT5tDRlHEKewc6ENmhrmVEljC0qYvn0GYKURJFFKQm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17612953"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="17612953"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14930740"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 09:16:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 09:16:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 09:16:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 09:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYNoFlgqE46GfaW2WcfS2LRkjQxpI2mCxhXK1nCIKzGtConVxS+cMz4+LrZROFrlPigoNKnbCZSZXofrDSNOaNunfVKBy7POPcnX/A0EzSD3nvyr/GOHCKgS20eloV8YoKS3ddc5+cio4HOaHLa4Xzu5gn6oM8GwKZ4nTkEj0CzJ7nc9BhrNKrMln/1oEQSY6MbutkQmhW/lSyue3J5anCOKjivEomeA9UZU+5geLQDcV80/AY/rVZOqS4lrPWQJw9J2hGmd+rgSi+Qqni4yZblnE+7euT2MNrawKa9HzOs5VDRtvG0KlqdaCL/Mjvu52SOX0kohMr+pCLMnLnDtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGo1RG+qj3i6SdVK/3iH5QjQ3qBOdTQrRjyYuhyfN5U=;
 b=coYe41GUE0Px0BQ+iBPmAwHemPEBeLc6+Vus112NpqPTauqfSs16uWCFgyibQJFzeALCnI7B1whpwfhdoz8GrRmdlmnsEzwaAQVGjoI5du9Wf7+rTXYgkzXJlTNMS6/UJFZHGNtZRSn29TN289okKGkTCkZZ0BlXHnOVt0vBlSYH8UZy2trem0FaiDjynTo5bp9HpZEzwaJc987mhHqsf6kljR8aK+14N40jIWbQVNOIw0T1gvGshG2PMsiRFVGdB6o2Kh3Sc94vIhWLEjLJELbeFZlg1kHNT7amgIjmG0RtiKjNzRIWska7egCqU+pgAkIHd2kt81CH2cqYUaG2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 16:16:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 16:16:27 +0000
Date: Fri, 22 Mar 2024 11:16:24 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init
Message-ID: <wf6xtwuxp4euq22f6buymaluptrpyihi5cclsawo2mq4upavei@chggosngqs66>
References: <20240321145644.33091-1-maarten.lankhorst@linux.intel.com>
 <ZfyQ56P0DtQCNsIW@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfyQ56P0DtQCNsIW@intel.com>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA0PR11MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a847bab-22b7-4067-fbd5-08dc4a8b6d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3M0hDaqHFhfg0a5TMEPsrkUkw2KDbAwWSqso3xniVRatsFNmtri0k2/ZUH0jsLAK0p764jDgmqTYG1mBM+7UfBgnO7lKEgwmcsFRh3ou/c1+/dp3PQux6NWligehlGnxXGmdAKhxNWThY6Xn0fHsr0gcCmW0+WI8PPCZ5aEXnOTkGdcNH/nvqfZFvjubMGLquIgOZ2LTh2+W6L/3Y5rYp1VAy9/1mjYsgCgkPZOKzC+AYen5glK2HkJyqGnJVajjnk920aTV3+tI2YwWc2PKvh9l97L+pqt+HlWdvNNK5XxwH44Zn178GbDRNDSoMYTsn6SNFDtXZ9NBjGEiRXz3bCeNOpM379TcsklkGygpN5JQh4vHCHHJvzQr3LthNZhnffhcLH4LRm3uK0I+flGHJi757TZ2lBvyu0taQoe9w0QYuMOd/TZFqEkkiXgGlgk0a3mButXRuYorocFDmUVljuFpmXo3bc0wYUgi6hE4XNwgZcU3FaJYhyS9YscknPqNk54llHRIx2DlEk1cNEmZ4voSqc/2rxFvIu25OlERB+vuG6LKaZIcxFnSpfEMmV8NAAPdsBq04mWaMCONBrfJ0hAWLKG5KJ2qING50xUGQcNAKzP68QiBm2aAKA7qxFaY8T3Z+eTctNTe4fegVoOqPPo2+UmYJ+JEyy0dENWlY60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+C62jf6U/2rpTNPOVW/Q309e1HtjOskI7SvmCfaDhuh4zk24dHkWMDUsh0BQ?=
 =?us-ascii?Q?1YcaKcB8Vqg2JzBiwjATL4r2ZDUkLCZ5q9XexWwqqCBeuNsxZEQLdeSd3mUE?=
 =?us-ascii?Q?eDSYYGMDWDyfHJfGohcPMUoLdCVxD2GW0CN3pWBWcjGx8wWDi4i8f4GFL0jP?=
 =?us-ascii?Q?CamZpd6rjF8eOxRZdGug39MSFdiqyOT6EaACpBtvKP7okampO9Tj53BYISlE?=
 =?us-ascii?Q?XT2srFbEvltQY9OjsAlSDH0iVo/tKLaRRpBQ2zO6HHLVSJDKRJGhrrQELP8/?=
 =?us-ascii?Q?+7lRdoE7im+6HCTPxV+TZUfCaiGwSi9046yT7sqmCXbwgtQturkbBzw3EBYa?=
 =?us-ascii?Q?4PWfAowTUqM5iGKDgOC4mvQ3YaukNGTjvCOvt1p79AQBgMk8PoMANVKCTfke?=
 =?us-ascii?Q?YnhoAIRV+eC+xzya8l95e5AWIytt0+8xbZ9z7FtL143zVX4zXJG7HDcSP/J1?=
 =?us-ascii?Q?ChOL8TmdxTYQmhhBXJ+/rBm4om5PQqTCmMYwd7boRcXZj35Y1h+M+N8mrafG?=
 =?us-ascii?Q?LSsCuDEWKeSoy+EkmtCnFmRpQBtedPYp8PliPAZBYNQnoh9Ic+DIpI3qDQBc?=
 =?us-ascii?Q?L7GBoWfh+rdYpfDiSUBelukcvUsVBbaeLvXopf2jHnwdmlY31VXEyKuAxyrr?=
 =?us-ascii?Q?LNyo1ccpIMGbHLvldUpBk2yt9DsQExcRrZXrfj3cFmbvxpHZK5GyOhbaqJal?=
 =?us-ascii?Q?6VYAdVVYY+vj79xYuTpBBDWFSbI4fv99PIEl3nxB4npkiLHmEVzFnsaE1lh+?=
 =?us-ascii?Q?UIvSxNE32TnXgwAOzw8RPvZJ0qYDXlsTRBk0ESt4lE/JV+QEAHhUJXqsE7WU?=
 =?us-ascii?Q?XPAlZlt6OnmfoORLJ5jst+fbkb9SdgS+k5BsWdmChmeQF++wbZsJJqC1StSD?=
 =?us-ascii?Q?vBMvtHj2LNdmO0ZzlX84Tbigr2EPR7EzwdBkYNKOz/RppqMxP2jQW/5T8OFw?=
 =?us-ascii?Q?QDIfzkAlxVr0/0QgxmiELRY8TAk46hPgQOhNwsDgWjGLhKUcX0Q9eetXfX3d?=
 =?us-ascii?Q?u+/SS383b60PF2JWs9YyHNd6ZvG/Fytfbo7N5DbX58Dz+oO57l6eYpQxJi0u?=
 =?us-ascii?Q?4DrmmjTpn46pTOWi+SYoGihLuxTCPVoB/bW5oUMzclqjjJ/ApZkrOtM3W6pt?=
 =?us-ascii?Q?xnvqTCP7hu4l1LtZ3+QekGkzcjTzCUDwgqQK3pfCRQcryzGDt0eUII3C+zVu?=
 =?us-ascii?Q?6eRbQBWtu9ETzlrV7PbwfNSte/LP97Jl6u9EHGYbg0hsxV7x8DQGhFUfulbT?=
 =?us-ascii?Q?zZybxHH/vi5ClK/Ym3Pjctcdr1P1i0vT3FZohwE/oDVuaASdYwhTgQ5da/gR?=
 =?us-ascii?Q?fQji+TCtX5NpY/Giy9g7Q1+rf6WFOxHjOOD1fLYUJuO5GwItEEt4oKpoy0HE?=
 =?us-ascii?Q?V1dxBYdJYypztakSq6WYEE1N+c0pYfsFdwrPpcqIGZMrGijE1Stmg0irwsn0?=
 =?us-ascii?Q?FEAWyD00jkayE2PIhDhIhW3Zh3XKGClMwYQDls4XvHmu2B2TFM2jFWCTgj0i?=
 =?us-ascii?Q?Y8kukgnHJc7//jCIr7465h6mXGlwHfef21uSAoWj5YPCgjWpRW5hGStiAZHZ?=
 =?us-ascii?Q?mKQVK79Au/TBp8yJXygpBia6hgdTGps6rc6OQqr4K3c32cJPsM1FwmSRanKt?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a847bab-22b7-4067-fbd5-08dc4a8b6d53
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 16:16:27.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs60RnfxOmbZOrGPDnAMb+ZRt5b48sq6lIPhQZA2uWEFoFsymf4QBS6dCmAQh681oJMjO338a/B/NJfKtzjkQpkM4kmYpBxGh7uY2VnbGhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com

On Thu, Mar 21, 2024 at 03:56:23PM -0400, Rodrigo Vivi wrote:
>On Thu, Mar 21, 2024 at 03:56:44PM +0100, Maarten Lankhorst wrote:
>> Add a reference to bo after all error paths, to prevent leaking a bo
>> ref.
>>
>> Return 0 to clarify that this is the success path.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
>> Cc: <stable@vger.kernel.org> # v6.8+
>> ---
>>  drivers/gpu/drm/xe/display/intel_fb_bo.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/display/intel_fb_bo.c b/drivers/gpu/drm/xe/display/intel_fb_bo.c
>> index b21da7b745a5..7262bbca9baf 100644
>> --- a/drivers/gpu/drm/xe/display/intel_fb_bo.c
>> +++ b/drivers/gpu/drm/xe/display/intel_fb_bo.c
>> @@ -27,8 +27,6 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>>  	struct drm_i915_private *i915 = to_i915(bo->ttm.base.dev);
>>  	int ret;
>>
>> -	xe_bo_get(bo);
>> -
>>  	ret = ttm_bo_reserve(&bo->ttm, true, false, NULL);
>>  	if (ret)
>>  		return ret;
>> @@ -48,7 +46,8 @@ int intel_fb_bo_framebuffer_init(struct intel_framebuffer *intel_fb,
>>  	}
>>  	ttm_bo_unreserve(&bo->ttm);
>>
>> -	return ret;
>> +	xe_bo_get(bo);
>
>wouldn't be safer to keep the get in the beginning of everything else
>and then if in an error path you xe_bo_put(bo); ?!

yes, I was thinking exactly that. Otherwise it's harder to reason about
the lifetime of the object and why the bo couldn't disappear after e.g.
ttm_bo_reserve() and cause use-after-free.

Lucas De Marchi

>
>> +	return 0;
>>  }
>>
>>  struct xe_bo *intel_fb_bo_lookup_valid_bo(struct drm_i915_private *i915,
>> --
>> 2.43.0
>>

