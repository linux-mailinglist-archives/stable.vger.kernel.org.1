Return-Path: <stable+bounces-268131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /u2bBXCqO2oYbAgAu9opvQ
	(envelope-from <stable+bounces-268131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B966BD1F4
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="ST/gydrL";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268131-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268131-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF359302D508
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE53ACF10;
	Wed, 24 Jun 2026 09:54:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF583ABD83
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:54:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294883; cv=none; b=EGSea0Xc6ALACd/XGtswXCgwzqYcp8AmoCfPUNQdPXgnkJVRD2ewO6FT54EA4r1Oto0nVKHmXEX76UIeFDEpYBuYBL4wcelsSpxW/aB33DNsBG5zfvO/TD37z3XwjdtQjUR8ZD5u5l6oEwwFCve8nP5/QP7bnBsiT9MCQFrUC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294883; c=relaxed/simple;
	bh=rDvpvaYZcP47kiFIWItv6ICZQ3SJPZjZ/WRORCigBfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6fwWtrjLDKtN/wtKOrbknDyG0lKjVM6mva0nKZGxzO1YfWVWxONYHccCTeFcVNL7o3rYf2p4nz3ATWM7bbpYvHXtU5/fxsUp0Qg5tiimvBpMiBglhCxL6cYpZzWE4fpHto58VRuAKjSMs8tRDFI9jJOG0byr/nszPfetjEJAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ST/gydrL; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782294882; x=1813830882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rDvpvaYZcP47kiFIWItv6ICZQ3SJPZjZ/WRORCigBfA=;
  b=ST/gydrLxdrx3C2byUiujmRq77cHFuc1RJ1cVLS6HCVc6DmW32BQr3cC
   HxRKGA+vaZ9AjTDkidoT0IyOZjJOEU6hxM71BLISq72yJsQAMOLHNMrY7
   7GwYaWeTf+A0IrDx8fbDDRsc/8LvyNbX/R8xmT+Mm2gjO5JRFXkaItr0a
   yhr1WzKMaBvzf0VWHmydaDzNAQ3PPsc22zSWTwDH9z1osGQnnAWJcjkW+
   xoi9SIxk94PWXBZi6LLxbM3Nr06omp3zsM38VWSx51O/kNuuvBVXaHtpS
   PWnhmQerA4g8QFXjvs246e8Kqwtu4BfLVHojJiECzp8cRu5tKGKAidQPd
   Q==;
X-CSE-ConnectionGUID: S3J87+oFQUK+WqhLOoXV3Q==
X-CSE-MsgGUID: BIgOWsJ5RcK45SzHuyS00w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85608364"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="85608364"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:54:41 -0700
X-CSE-ConnectionGUID: Z+/zq73MREiA+JrOowrYvw==
X-CSE-MsgGUID: qbxhvP49TpawkKoCHjA9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="246887632"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.189]) ([10.245.244.189])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:54:39 -0700
Message-ID: <58985183-67ad-4583-940b-3f96b7ba80a8@linux.intel.com>
Date: Wed, 24 Jun 2026 11:54:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Martin Hodo <martin.hodo@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joonas.lahtinen@linux.intel.com,m:intel-gfx@lists.freedesktop.org,m:martin.hodo@intel.com,m:thomas.hellstrom@linux.intel.com,m:simona.vetter@ffwll.ch,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268131-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40B966BD1F4

Hi,

On 6/24/26 11:09, Joonas Lahtinen wrote:
> Avoid returning &node->base when node is NULL due to OOM
> during GFP_ATOMIC allocation.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: bfaae47db3c0 ("drm/i915: make lockdep slightly happier about execbuf.")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: <stable@vger.kernel.org> # v5.13+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

>  drivers/gpu/drm/i915/i915_active.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index 5cb7a72774a0..aa77def0bc0d 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -318,7 +318,7 @@ active_instance(struct i915_active *ref, u64 idx)
>  	 */
>  	node = kmem_cache_alloc(slab_cache, GFP_ATOMIC);
>  	if (!node)
> -		goto out;
> +		goto err;
>  
>  	__i915_active_fence_init(&node->base, NULL, node_retire);
>  	node->ref = ref;
> @@ -332,6 +332,11 @@ active_instance(struct i915_active *ref, u64 idx)
>  	spin_unlock_irq(&ref->tree_lock);
>  
>  	return &node->base;
> +
> +err:
> +	spin_unlock_irq(&ref->tree_lock);
> +
> +	return NULL;
>  }
>  
>  void __i915_active_init(struct i915_active *ref,


