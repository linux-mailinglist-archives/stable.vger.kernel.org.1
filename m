Return-Path: <stable+bounces-224728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBsKEWyhsWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D859E267C5D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33A89302E54A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5F3E316B;
	Wed, 11 Mar 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVdCB+9t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB336C0A8
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248819; cv=none; b=C34XV3Jh8/ORL66qvTp2UIGsMGTs1hU9q1DNFqjFjobBkCErYF5xpP9L7G4EMVIgc6PMs4K5Vt7916EveAFgEMYNwZuZmx13QfAGfFhYKjd7YYUH/ePfn/TFQu6WcgpJBFw2GhdeJimwpLzU9pO9OoMKYplbxIdrbPekN51YMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248819; c=relaxed/simple;
	bh=q2G4qOwMbGrxcu1z75cOleAftU3mTeKhBsiqQjVGRqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aauK0ZC7OSVH02y4spu3LMsa7gpYzq0ctiTlIcPxcfK7Ho6OTdhkaPcoR9rtKgW0d6HPBspKcY5+BoxeGsqYTIVIQzsAyS+5UF0TwOtGOMVyC1SAV8Vs+/yLNRPZOvvUF4wnnFvPYC0KXlg6uY3F5BbHGHbNDyHXtxBjF09ZMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVdCB+9t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773248817; x=1804784817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2G4qOwMbGrxcu1z75cOleAftU3mTeKhBsiqQjVGRqQ=;
  b=fVdCB+9tbNjQ0xqutsXf5hiFvIH2RM6fXppL/yi/J6ZnyoyVnnkBAb0H
   GKLWXTfikCr/WMpXIFwRQdP98G/YjakQh3K7KZsKm+Py1D/u1nSwm8Zcm
   NHLFeZNP4RptA49+mAzI8kHpN5HEmEcMA1etn1lfhIerWw06LFRxjcYB+
   DK+O9mb4ZIeoyhYvJYdNpx1K1cdJ+7DaRq93aEzE7I2OP+K+S9YzLyEPr
   QOvsy92DE2x7v9kc92E552bJzyyoyAD9VQGpiNAYpyozEClwSWWgTbKHg
   eZ8D5YWnD5qeTxtewDc/Ni6KQGEI1oSEW4kWdlgjGIMiYuVR0k62Au6sh
   w==;
X-CSE-ConnectionGUID: CyRTyhdjT8+G+kaIVPg8rg==
X-CSE-MsgGUID: AE4d5rkrRIaXwoXXOOyBnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73518910"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73518910"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:06:55 -0700
X-CSE-ConnectionGUID: bWucIU35ROqbAXg9/tOZPA==
X-CSE-MsgGUID: H8CIXHWPSCKSUApBbbPM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219672083"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.238]) ([10.245.244.238])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:06:53 -0700
Message-ID: <deacdeab-051a-419b-ad95-24e70d9531e3@intel.com>
Date: Wed, 11 Mar 2026 17:06:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix missing runtime PM reference in
 ccs_mode_store
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260311165242.2355683-2-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224728-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D859E267C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11/03/2026 16:52, Sanjay Yadav wrote:
> ccs_mode_store() calls xe_gt_reset() which internally invokes
> xe_pm_runtime_get_noresume(). That function requires the caller
> to already hold an outer runtime PM reference and warns if none
> is held:
> 
>    [46.891177] xe 0000:03:00.0: [drm] Missing outer runtime PM protection
>    [46.891178] WARNING: drivers/gpu/drm/xe/xe_pm.c:885 at
>    xe_pm_runtime_get_noresume+0x8b/0xc0
> 
> Fix this by wrapping xe_gt_reset() with xe_pm_runtime_get/put().
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7593
> Fixes: 480b358e7d8e ("drm/xe: Do not wake device during a GT reset")
> Cc: <stable@vger.kernel.org> # v6.19+
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

Assuming CI is happy,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_gt_ccs_mode.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
> index b35be36b0eaa..f3b834a09a6d 100644
> --- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
> +++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
> @@ -12,6 +12,7 @@
>   #include "xe_gt_printk.h"
>   #include "xe_gt_sysfs.h"
>   #include "xe_mmio.h"
> +#include "xe_pm.h"
>   #include "xe_sriov.h"
>   #include "xe_sriov_pf.h"
>   
> @@ -163,7 +164,9 @@ ccs_mode_store(struct device *kdev, struct device_attribute *attr,
>   	xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
>   	gt->ccs_mode = num_engines;
>   	xe_gt_record_user_engines(gt);
> +	xe_pm_runtime_get(xe);
>   	xe_gt_reset(gt);
> +	xe_pm_runtime_put(xe);
>   
>   	/* We may end PF lockdown once CCS mode is default again */
>   	if (gt_ccs_mode_default(gt) && IS_SRIOV_PF(xe))


