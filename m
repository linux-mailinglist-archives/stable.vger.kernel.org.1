Return-Path: <stable+bounces-203452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA5CE577B
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 22:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256F530022DE
	for <lists+stable@lfdr.de>; Sun, 28 Dec 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD926281370;
	Sun, 28 Dec 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/bwDrBr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E423370F
	for <stable@vger.kernel.org>; Sun, 28 Dec 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766956105; cv=none; b=Q7AtD6HAO0ln1Hb0tnctmCamsdP4dkyaoGD9wISkEZ9xc7AcnzWUu5njI+NJ9ZIpQxjeUNHPgx4GuRvQa1k9bZtQ9obWRi5yakp9W0HjgKyxAKmfu+EghfSLpRNVmMW65lekz5EQAoBS+BwykrvguxE3toyONrXKzzfn+gTfPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766956105; c=relaxed/simple;
	bh=dLf/6gRGuEo/mfU4OiTF5teRzBnCSCVYi0WyxgJqHEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZT+vQ9egZIlPyTjfwIuaHyNtUV09ohls6GnfSSDnayDATZq4QWWtB6MVkQ0m1ewZBsO7cdEvOsisqUdxLmitPYRqFzYKXnlKKEuTUqvS7UzXck2jV+NV187NazAalNOOsfSius4a2IEoohTeGmPwAwiBajtuMdi5M6u3bGcR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/bwDrBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7414DC4CEFB;
	Sun, 28 Dec 2025 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766956104;
	bh=dLf/6gRGuEo/mfU4OiTF5teRzBnCSCVYi0WyxgJqHEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/bwDrBrZM0OB6QZ54KAMFIEXcvsB4IxvGE9xmMSC1lU2Nlgfkb/lpxb/yjpqFSVB
	 QzNGTElYPx229yLFx6/OWBIw5AkL3V9gjORap3jj+jjEFnpieP/QVQudk2OA+SC743
	 iNvE33KSK0fm+OGWRaqLHjldIuYCA37TbrgQ8f3OhGWX4ejuXFudtDLSDO4XyRjxlM
	 vLl6NtHYPlhtp2vtNLyFpzRBbMndOpPWLKY7QyKQc8fhtJ/xKT536hvTGLt0e5+Y/F
	 CJH9BJehdNsmALjU1GlMTdmxMixnC7H7SVv5cjCkFDOT/mkubkZrwilAgdS4tFTDfe
	 +hVE7UCwr7A5w==
Date: Sun, 28 Dec 2025 22:08:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org, =?utf-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Chris Wilson <chris.p.wilson@linux.intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Krzysztof Karas <krzysztof.karas@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v5] drm/i915/gem: Zero-initialize the eb.vma array in
 i915_gem_do_execbuffer
Message-ID: <5qxmnuycar2xi4vdsamffd7xanaow7c7tajdd4jndm4me4xdbw@nkjpl4zfoegv>
References: <20251216180900.54294-2-krzysztof.niemiec@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216180900.54294-2-krzysztof.niemiec@intel.com>

Hi Krzysztof,

On Tue, Dec 16, 2025 at 07:09:01PM +0100, Krzysztof Niemiec wrote:
> Initialize the eb.vma array with values of 0 when the eb structure is
> first set up. In particular, this sets the eb->vma[i].vma pointers to
> NULL, simplifying cleanup and getting rid of the bug described below.
> 
> During the execution of eb_lookup_vmas(), the eb->vma array is
> successively filled up with struct eb_vma objects. This process includes
> calling eb_add_vma(), which might fail; however, even in the event of
> failure, eb->vma[i].vma is set for the currently processed buffer.
> 
> If eb_add_vma() fails, eb_lookup_vmas() returns with an error, which
> prompts a call to eb_release_vmas() to clean up the mess. Since
> eb_lookup_vmas() might fail during processing any (possibly not first)
> buffer, eb_release_vmas() checks whether a buffer's vma is NULL to know
> at what point did the lookup function fail.
> 
> In eb_lookup_vmas(), eb->vma[i].vma is set to NULL if either the helper
> function eb_lookup_vma() or eb_validate_vma() fails. eb->vma[i+1].vma is
> set to NULL in case i915_gem_object_userptr_submit_init() fails; the
> current one needs to be cleaned up by eb_release_vmas() at this point,
> so the next one is set. If eb_add_vma() fails, neither the current nor
> the next vma is set to NULL, which is a source of a NULL deref bug
> described in the issue linked in the Closes tag.
> 
> When entering eb_lookup_vmas(), the vma pointers are set to the slab
> poison value, instead of NULL. This doesn't matter for the actual
> lookup, since it gets overwritten anyway, however the eb_release_vmas()
> function only recognizes NULL as the stopping value, hence the pointers
> are being set to NULL as they go in case of intermediate failure. This
> patch changes the approach to filling them all with NULL at the start
> instead, rather than handling that manually during failure.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15062
> Fixes: 544460c33821 ("drm/i915: Multi-BB execbuf")
> Reported-by: Gangmin Kim <km.kim1503@gmail.com>
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

merged to drm-intel-gt-next.

Thankyou,
Andi

