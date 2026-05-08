Return-Path: <stable+bounces-244749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDOFI9jZ/WnjjwAAu9opvQ
	(envelope-from <stable+bounces-244749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:40:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D14F6785
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 921E13014827
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA643DCD96;
	Fri,  8 May 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjS48Seo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCD3DDDCD
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244052; cv=none; b=U/jK8TOSiAlXBbBBTSt3nkFbpHjjViKHiaycOTE+DTm2uYnSbxWWiFZMrC8dbb8XYdXs7289NAl1w37pfJu24Xxeupmm4N/sCCajCi2uHgNwLTF1GDhxdzXmgIuAfe0r2pbN/3jSUfDhjP+qd2DV6MwQK7Py4bsEmxQwY6rgwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244052; c=relaxed/simple;
	bh=2sJkROZAh6Hff/DaVQBve9t+vJREpqTKtF9lHNA9KHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5S76QZemL/oz/qpZyuMDNaDrSxI+FmSsCjPGusz6Fr5ECqJ3bVZoaD4x2eI/D/sOyB8wuIXBhJvEHBpejef1w5gSEuWH9FmexXXBlgmtUyJIoIDCrB5eVQ7aFsqLY8fCs+9J97SsDBkc+OWSsn03f2Gn8toAfC3OHH9hkcpyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjS48Seo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778244050; x=1809780050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2sJkROZAh6Hff/DaVQBve9t+vJREpqTKtF9lHNA9KHE=;
  b=AjS48SeogkR7/IgOQ0ars9rsXjoJNup8gQbDWf9fwxaHfGXg5W740juG
   ax9CfHIojBfFpbXeH455E9mX57HDrMDfvJJQ28RU9Qt9BuQy5XKp81Na8
   gcoR9CSnD5aAHqLFmbzsdBQFOgvBLyx3IbwJ8dkjFTDWegyY6/Gq0PoxP
   7FyDlSl6BR+c41qOOoPE1tlPdURVYrTgJhsiw2WONJya1iqQN4z7ITX5H
   kwFUqKDUHMqHrH+k9VkmtJgUDQUs09PFWzl3Javsl6vSOAFwLLX2K9Tfx
   CISOaBo2RX9RNSywKfMkOKReUmhkkRn9XvQ6bKUtockoJKcCZ8zTvbeCW
   w==;
X-CSE-ConnectionGUID: p9lL8jArSeaMTgo92kt53w==
X-CSE-MsgGUID: pgCKLjDoSm+8Ylbv+3iyqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79317373"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79317373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:40:49 -0700
X-CSE-ConnectionGUID: atym7dInQ7ey/bmOeotN3w==
X-CSE-MsgGUID: r3K7ItInTs6RKGjTxwOUXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260201936"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:40:47 -0700
Date: Fri, 8 May 2026 14:40:45 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Cc: intel-gfx@lists.freedesktop.org, andi.shyti@linux.intel.com,
	krzysztof.karas@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: skip __i915_request_skip() for already
 signaled requests
Message-ID: <af3ZzUW3dobsTjmC@ashyti-mobl2.lan>
References: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
X-Rspamd-Queue-Id: 311D14F6785
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244749-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashyti-mobl2.lan:mid,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

Hi Sebastian,

On Thu, Apr 16, 2026 at 01:31:18PM +0200, Sebastian Brzezinka wrote:
> After a GPU reset the HWSP is zeroed, so previously completed
> requests appear incomplete. If such a request is picked up during
> reset_rewind() and marked guilty, i915_request_set_error_once()
> returns early (fence already signaled), leaving fence.error without
> a fatal error code. The subsequent __i915_request_skip() then hits:
> ```
> GEM_BUG_ON(!fatal_error(rq->fence.error))
> ```
> 
> Fixes a kernel BUG observed on Sandy Bridge (Gen6) during
> heartbeat-triggered engine resets.
> ```
> kernel BUG at drivers/gpu/drm/i915/i915_request.c:556!
> RIP: __i915_request_skip+0x15e/0x1d0 [i915]
> ...
> __i915_request_reset+0x212/0xa70 [i915]
> reset_rewind+0xe4/0x280 [i915]
> intel_gt_reset+0x30d/0x5b0 [i915]
> heartbeat+0x516/0x530 [i915]
> ```
> 
> Guard __i915_request_skip() with i915_request_signaled(), if the
> fence is already signaled, the ring content is committed and there
> is nothing left to skip.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13729
> Fixes: 36e191f0644b ("drm/i915: Apply i915_request_skip() on submission")
> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

Merged to drm-intel-gt-next.

Thanks,
Andi

