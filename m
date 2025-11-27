Return-Path: <stable+bounces-197078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F196C8DAFC
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB0464E038B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B62E0418;
	Thu, 27 Nov 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMA2aF3Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDDC13B
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764237970; cv=none; b=LPnqq6W4P+BQ1mD/1fqG35r/JUBE8iPGnZLzRIIQfpqgWz7UUhkKRUTEwPM/RURY7sM4jLrWwySoFXTMO7cL0BqYoCcpbomN1Hl2JufLI5rkBiLm7olxnV6CUnf3JZCduIpXgzonUW6K+JmQGvPqCuIilofZ+MjNGwszpmKBiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764237970; c=relaxed/simple;
	bh=dajGMcF5ciAeIRmfVpam5zQkcGfClTk8GVSC0Dv6WCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpXug/iNmP203b2EMEEjNXrY8O+zCRONv0dxhNk4BIF1mwaZVR9e1DR0DpiktBhlRNUyBct5G2i0OVNYKEcDWDFUQ2xWjM3LAgkR69+zbZB/LTze1D+YwEBpM/sggo2SFI2vTIgFiQj120cUQn/4498TXeFK3k+SQNnni0xUaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMA2aF3Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764237968; x=1795773968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dajGMcF5ciAeIRmfVpam5zQkcGfClTk8GVSC0Dv6WCA=;
  b=ZMA2aF3QNCFsMzQAZw6D4WBr+zy/OCzBzrgmV4VyhgKaWnyxNd2Mfy2T
   ylnnmW56ZUVEAmFoWn+TwnBLpc3uc4ks/Km2gN9WigLwcUm2Y6VzryefF
   9s9K3ss4C00B94/+Ah5CMgPafQFg/uE/XgV8WH2G2HQ3ZA+nVVFoUbFlr
   UYZtfZ2DABVCMcnnHTV+oKoPjEizIYDle6RO8Zhu3mP07bek60QSHcx3d
   UPugCLmaFwP9dX5fwKA7api4YPPt/afXdxoBmXTQP2FMiy1TAhV77XDh2
   E8J/yqFte0jFiXYVW9aRkm7ZMhkA39DmDn17KaQbIiOL10rrLo/07LHOZ
   g==;
X-CSE-ConnectionGUID: Yh8lAaYPSNSgP2vsquZLOA==
X-CSE-MsgGUID: 7IpzqzLyQMKOxeR+pWhKRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66358793"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66358793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:06:07 -0800
X-CSE-ConnectionGUID: Y85IV73DSIufn/YRPWnwQw==
X-CSE-MsgGUID: nDseewuzShyFvp9hgSzXCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="216545577"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.49])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:06:04 -0800
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject:
 Re: [PATCH] drm/i915/gem: NULL-initialize the eb->vma[].vma pointers in
 gem_do_execbuffer
Date: Thu, 27 Nov 2025 11:06:02 +0100
Message-ID: <1835827.4herOUoSWf@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <qylrctylmtj6qzibfpbapwpb77ut7gzckgg2wpc3gv56kl46m2@hyio7hcsj6vy>
References:
 <20251125133337.26483-2-krzysztof.niemiec@intel.com>
 <4423188.Fh7cpCN91P@jkrzyszt-mobl2.ger.corp.intel.com>
 <qylrctylmtj6qzibfpbapwpb77ut7gzckgg2wpc3gv56kl46m2@hyio7hcsj6vy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 26 November 2025 18:28:55 CET Krzysztof Niemiec wrote:
> On 2025-11-25 at 19:06:32 GMT, Janusz Krzysztofik wrote:
> > Re-sending because of my response unintentionally HTML formatted, with correct 
> > email address of Tvrtko by the way.
> > 
> > 
> > Hi Krzysztof,
> > 
> > On Tuesday, 25 November 2025 14:33:38 CET Krzysztof Niemiec wrote:
> > > Initialize eb->vma[].vma pointers to NULL when the eb structure is first
> > > set up.
> > > 
> > > During the execution of eb_lookup_vmas(), the eb->vma array is
> > > successively filled up with struct eb_vma objects. This process includes
> > > calling eb_add_vma(), which might fail; however, even in the event of
> > > failure, eb->vma[i].vma is set for the currently processed buffer.
> > > 
> > > If eb_add_vma() fails, eb_lookup_vmas() returns with an error, which
> > > prompts a call to eb_release_vmas() to clean up the mess. Since
> > > eb_lookup_vmas() might fail during processing any (possibly not first)
> > > buffer, eb_release_vmas() checks whether a buffer's vma is NULL to know
> > > at what point did the lookup function fail.
> > > 
> > > In eb_lookup_vmas(), eb->vma[i].vma is set to NULL if either the helper
> > > function eb_lookup_vma() or eb_validate_vma() fails. eb->vma[i+1].vma is
> > > set to NULL in case i915_gem_object_userptr_submit_init() fails; the
> > > current one needs to be cleaned up by eb_release_vmas() at this point,
> > > so the next one is set. If eb_add_vma() fails, neither the current nor
> > > the next vma is nullified, which is a source of a NULL deref bug
> > > described in [1].
> > > 
> > > When entering eb_lookup_vmas(), the vma pointers are set to the slab
> > > poison value, instead of NULL. 
> > 
> > 
> > Your commit description still doesn't answer my question why the whole memory 
> > area allocated to the table of VMAs is not initialized to 0 on allocation, 
> > only left populated with poison values.
> > 
> 
> Becuase kvmalloc_array() is used. [1]
> 
> I guess one could swap it to a call to kvcalloc() or something similar;
> the thing is that the call actually handles both allocations of
> exec_list2 and the eb_vma array, the former doesn't need to be
> zero-initialized, the latter technically also doesn't but it simplifies
> error paths (and fixes the linked bug). I'm not sure if a
> zero-initializing *alloc() would be more readable or not here.

To my taste, zeroing on allocation would be a more clean solution.

But, while being at it, please have a still closer look, especially at these 
two statements:

at drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:i915_gem_execbuffer2_ioctl():3588

	/* Allocate extra slots for use by the command parser */
	exec2_list = kvmalloc_array(count + 2, eb_element_size(),
			       __GFP_NOWARN | GFP_KERNEL);

at drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:i915_gem_do_execbuffer():3354

	eb.vma = (struct eb_vma *)(exec + args->buffer_count + 1);

Why do we allocate space for 2 tables of count size plus 2 extra pairs of 
their elements, but then place the second table at count + 1 offset, leaving 
space for only one extra element of the first type?

Looking at git history, there was a couple of excessively complex patches and 
reverts that apparently introduced that discrepancy.  Unfortunately, none of 
them, with exception of the one that introduced the above shown inline 
comment, provided a clear justification why we need to switch from 1 to 2 or 
vice versa.

Anyway, depending on how that extra space is actually used by the command 
parser, we may or may not get into troubles with that, so we should better fix 
it, I believe.

Thanks,
Janusz

> 
> Thanks
> Krzysztof
> 
> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c#L3586
> 
> > Thanks,
> > Janusz
> 





