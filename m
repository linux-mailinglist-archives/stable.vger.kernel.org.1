Return-Path: <stable+bounces-241688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF9TKiXS8GnDYwEAu9opvQ
	(envelope-from <stable+bounces-241688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:28:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C4487D4D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425B430F0A6A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DB3B7B8C;
	Tue, 28 Apr 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd5rgNeY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384343148DA
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389487; cv=none; b=uRvVE58V+0ckNLtKga9fHFHjnXAesJEi3utyFNI6CkYR9Xfm2uuQ8l8qFEFuPjoNoZ5c48aaTGK8i6Qoj0JWKyfGTQWFb6S0SXD+NEe1FMhRO6jVSamZWtNa5ZsK+MLwp+8zJ7k4UR5VZMTglXyhzt45hN6zaVErFaeFMag0Sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389487; c=relaxed/simple;
	bh=G5jYe2Ro6yI72cEA7e8A3BYucfWE+49wWIUVMxyffVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptb14a2lxHz+4C1/gv74mNtehwYqO9SdWRDuD4lBH5NUQE25wtOQhgqaj6X4zSjvxsnbufBAc813P5O5wSCs+tqo7Kd+iu4lVAyMo10fZ2gitVNC4erxYaCsddH7KYtCpBV5NAdANyYUkvzMfVwv4h1O02/w0PNHbubBfn/IGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd5rgNeY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777389485; x=1808925485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G5jYe2Ro6yI72cEA7e8A3BYucfWE+49wWIUVMxyffVQ=;
  b=Pd5rgNeYTwuQHVQoycBLXQVO0iR4xR7C3JJfj5TkLSFeWq1vXlgmadQ3
   ifMqwgfdwtxUDmJonhs9M2rjCZGeJ74jy6tM1m63oCJrEAFAQJHF+DnyP
   aj2rhUPg3hz1AsdgnWxEeKJhye+z2NodmdUhtknjEQNGjEfOxfJvVZHGi
   j7iu5ft3y9yjl86j5R3YJ7r3+1PCI5DWRB7jqrmXL9x9C96/Cn8fsBOso
   rE9GOim+nQfZ+jx+nbsJWF2c9OkaXETRKYzm1MZaRutDDEr9Bmg9rlLAL
   tLQ/QmJg0RmYtF5MuQgc2vorFYPBPXj30IxiAuJCa1Yoj4nGG02C7hOi5
   g==;
X-CSE-ConnectionGUID: VkKiOB5dTEmUGOHLpmkd3Q==
X-CSE-MsgGUID: 62morNYWT7+b4uLj/60Wkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89761941"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89761941"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:18:04 -0700
X-CSE-ConnectionGUID: ELNJMs58Q4eN7enpR34rLw==
X-CSE-MsgGUID: 19SBxFJzRG6Q9sTks8Qczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257302027"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:18:02 -0700
Date: Tue, 28 Apr 2026 17:18:00 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Jia Yao <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maciej Plewka <maciej.plewka@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v3] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Message-ID: <afDPqHOR6FhmfROf@ashyti-mobl2.lan>
References: <20260417050956.1945481-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417050956.1945481-1-jia.yao@intel.com>
X-Rspamd-Queue-Id: 1C7C4487D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241688-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashyti-mobl2.lan:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

On Fri, Apr 17, 2026 at 05:09:56AM +0000, Jia Yao wrote:
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed for that context.
> 
> LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
> the correct value on every context switch via the indirect context
> batchbuffer to avoid leaking state between contexts. The old unconditional
> application of Wa22013059131 in intel_workarounds.c is removed.
> 
> v3:
> - Kernel-internal context will not change workaround settings

Do we have a link of the userspace using this API?

Joonas, do we need also a documentation update here?

Thanks,
Andi

> Bspec: 54833
> Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
> Cc: stable@vger.kernel.org
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Maciej Plewka <maciej.plewka@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

