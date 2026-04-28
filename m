Return-Path: <stable+bounces-241687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ9aCYLR8GnDYwEAu9opvQ
	(envelope-from <stable+bounces-241687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443AE487C8D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F44930FB50B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416E2580F2;
	Tue, 28 Apr 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ig/ckKhq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F628F935
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389041; cv=none; b=oIg33akWvUy+STimAO4nPonB1ZhBeWyfrmPuLGTRkdCdBdkFB3uSJh7tn4OS6QNJZltUNEYV8H55wq+tZR4IV+m4cAzQLumZlKpNSEDT3Xiw2CgvxudwU9OKWl/TlETCqpCEHnF3+/2XavP7EHgcMjgk9W+cdD/fnCpGXRJ7qbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389041; c=relaxed/simple;
	bh=e5Aia3lapZCgq06YmkguDvKlMUCzM00XkmsLRADP1b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrjhv+fjAuSDHNNSfGLKpm1cqoj200tWRQN6L19cuEyqJjgMpzai62ZQ83wFz+FrjDibCesX0tY0GLqWlTNAagabtDclADizIhbCsCyM6dF0l7EDJdnOzuqL5MDY2J9OKou6cmANp+3KfPdTFD8YKAYAf2HymAEtzn8o/KHjIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ig/ckKhq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777389040; x=1808925040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e5Aia3lapZCgq06YmkguDvKlMUCzM00XkmsLRADP1b4=;
  b=Ig/ckKhq5V3Mn0P2c5UIyPuNcyhRgr58IJFyPWEaGiGEB8nFEyUWHuss
   TvvXDEUYlhAZX8vabzIYE4vCEn+0pxCXIxMv/j3Unz3E3irQKXk08dpGK
   KseUKyC641wnW5LFoHRAt5MJzzVUiLjkZf3XVxH/zbcm4ZDvjrmzma70+
   YLBB3x3/Mh1B2fV1AL0QWqg00+7xvc6s3DgQ1AMcseto8w5aTsYTGQ+yb
   Ll3Kf7lCegAE77KAzDsF8wJ8aawGLmqJi2fA14DITvdCg6hev+ZXVTK+q
   T8ApjoTzaEWufB9yGrLAPBgELjWRkjHTVuft5T9cN+jjqCedWnK5dH5TH
   Q==;
X-CSE-ConnectionGUID: TsxMvhiHSvGU5RKD/xd/QQ==
X-CSE-MsgGUID: 7MVYYsNoR7O85jfN/GY7eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="100956938"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="100956938"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:10:39 -0700
X-CSE-ConnectionGUID: 7PjhBtMuTKOXhlbiVK1IvA==
X-CSE-MsgGUID: o6TJOrI2RcyL8j2rfIAfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="235737806"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:10:37 -0700
Date: Tue, 28 Apr 2026 17:10:35 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	intel-gfx@lists.freedesktop.org, andi.shyti@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: skip __i915_request_skip() for already
 signaled requests
Message-ID: <afDN6xd-WoqNXQU-@ashyti-mobl2.lan>
References: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
 <yoap6axokl3wt2cirb76uugga76ligklznoubcq7p4tgr3gkh7@4tpiryb7u7y4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yoap6axokl3wt2cirb76uugga76ligklznoubcq7p4tgr3gkh7@4tpiryb7u7y4>
X-Rspamd-Queue-Id: 443AE487C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashyti-mobl2.lan:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

Hi Sebastian,

On Mon, Apr 20, 2026 at 09:18:03AM +0000, Krzysztof Karas wrote:
> On 2026-04-16 at 13:31:18 +0200, Sebastian Brzezinka wrote:
> > After a GPU reset the HWSP is zeroed, so previously completed
> > requests appear incomplete. If such a request is picked up during
> > reset_rewind() and marked guilty, i915_request_set_error_once()
> > returns early (fence already signaled), leaving fence.error without
> > a fatal error code. The subsequent __i915_request_skip() then hits:
> > ```
> > GEM_BUG_ON(!fatal_error(rq->fence.error))
> > ```
> > 
> > Fixes a kernel BUG observed on Sandy Bridge (Gen6) during
> By "Fixes" do you mean this patch? Or are you referring to the
> tag "Fixes:" below? If former would be the case, then imperative
> form might be better: Fix.

Pour parler: the imperative is used in the last paragraph:
"Guard" :-)

> 
> In any case the patch looks sane:
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> 
> > heartbeat-triggered engine resets.
> > ```
> > kernel BUG at drivers/gpu/drm/i915/i915_request.c:556!
> > RIP: __i915_request_skip+0x15e/0x1d0 [i915]
> > ...
> > __i915_request_reset+0x212/0xa70 [i915]
> > reset_rewind+0xe4/0x280 [i915]
> > intel_gt_reset+0x30d/0x5b0 [i915]
> > heartbeat+0x516/0x530 [i915]
> > ```
> > 
> > Guard __i915_request_skip() with i915_request_signaled(), if the
> > fence is already signaled, the ring content is committed and there
> > is nothing left to skip.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13729
> > Fixes: 36e191f0644b ("drm/i915: Apply i915_request_skip() on submission")
> > Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

