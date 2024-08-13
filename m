Return-Path: <stable+bounces-67484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E0950587
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB20B22B99
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA019AA41;
	Tue, 13 Aug 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0oz2MKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3719923D
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553231; cv=none; b=KmP0hCNo81eE+kEBEN6SVP/YrIFIkDIokv1aspNYZCWSpnbCA9hU8t/T/2xlLaoU4khMgELKvrdS/4/jVxCA5MU10+/i1mLOsmRp+gWRCvQOzQ4hyG9xjrraaDJG/+B+kCWY8BzKd26xyphVI37NHNJwESOo8W7l67xMNmhluuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553231; c=relaxed/simple;
	bh=KkjmXnRgHkTS4ymaoWzJ6UO0aEL0octgTxHsbnROuWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsBQmvM0ldUY5NWIJNCE3uDeVPhMo3mEtcFGlZ3J8C4t7sHfBiXUzCXjdwtczFTtxOfLpIb0apOYKXsVq2TCry7Yhlo9SgWOIUIiRzfF4cKhs69Bd8IiAG7N5O45QDz11h+DQHhwM2RMATIn+isWNNQel5MNqVUNpmCphliWw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0oz2MKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550B3C4AF09;
	Tue, 13 Aug 2024 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723553230;
	bh=KkjmXnRgHkTS4ymaoWzJ6UO0aEL0octgTxHsbnROuWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0oz2MKUYCbNs1ZMH5d92yW2+6Hq4TCxoJRS4ZsYcF53DvAjpAx80yjZVrQMdV1KO
	 /gJY5r9PtRHxSBKk/PjjO1mtZX0o6lY+vHlR17l1NWF4Arw3oqXWK1q9CoEebNRESE
	 6uW1oQQ/JOz246NsOkz58lL3H+cW6V4U/BCA8fYg=
Date: Tue, 13 Aug 2024 14:47:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: Re: [PATCH 5.10.y] drm/i915/gem: Fix Virtual Memory mapping
 boundaries calculation
Message-ID: <2024081358-repackage-drizzly-402d@gregkh>
References: <2024081220-brethren-diagnoses-2569@gregkh>
 <20240813123153.20546-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123153.20546-1-andi.shyti@linux.intel.com>

On Tue, Aug 13, 2024 at 02:31:53PM +0200, Andi Shyti wrote:
> Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.
> 
> Calculating the size of the mapped area as the lesser value
> between the requested size and the actual size does not consider
> the partial mapping offset. This can cause page fault access.
> 
> Fix the calculation of the starting and ending addresses, the
> total size is now deduced from the difference between the end and
> start addresses.
> 
> Additionally, the calculations have been rewritten in a clearer
> and more understandable form.
> 
> Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
> Reported-by: Jann Horn <jannh@google.com>
> Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
> [Joonas: Add Requires: tag]
> Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
> (cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 53 +++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)

Both now queued up, thanks.

greg k-h

