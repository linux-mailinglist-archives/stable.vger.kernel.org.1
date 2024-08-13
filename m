Return-Path: <stable+bounces-67521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D7950ADA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5741F24104
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618B1A2C01;
	Tue, 13 Aug 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvKCf132"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35741A256C
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568248; cv=none; b=FUiaTETlnZBKz+swzAVxmqtFfD8w8SBaAZgSX+DG7gH/OzmTdowUqRNn5GzhF2oHo01/bRjmpN273bajNcZju1qx6LLqFSTqbYGCg1OhN7dZ//xL8pyZPq0amT7Cnt7fDpIOXyoLoStte3pRuDFWvLBeq+3voWChW+1yZGdv9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568248; c=relaxed/simple;
	bh=Bg70giKPVBJXHcWQA0AaVaYRWFhSRQqIva6/TQ3PTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBLipzW/dfVcw23RZRnnwVpkaQzeEi9iIAKIZWdfFWr8kIs4wVVoadat4dMOP8BA5oV6Ocfc0LC60BIqP5z0MThZi6HpdnvFOu+e88M+uaPBXpYpKULxLjAulehaB4BnsouvUsSCmSq+nQI1/mJ2nyJ692eYykiXtd3fhohuoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvKCf132; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723568246; x=1755104246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bg70giKPVBJXHcWQA0AaVaYRWFhSRQqIva6/TQ3PTsY=;
  b=GvKCf132xsRhbjuc4vl9qLhi70FjrT2aAvTa3nrFRK3r8RCrh6zigufw
   etrrQ2iohzdDPwKQx3JPwZeQXOaUZ76iotaAXCfi4uXeZgPFcczzoZTcq
   qTf1mq8fZHpfX52heoNR+CDOnGqfS5xgvMGTsXgK2GZWSvUQIpEDJauDl
   lL4pJbJgYVxouLeXLx0QlA6z+kIbyj5O9DRjv9toiXcTgEQLQdVGf4WAN
   mkIJ+PxgVzNWUZvC4hveucA9/Ga3JXzgXH0QeG29FOmyVTPlPcXc9v9Hw
   kdRo34yT//C+ct11KSYgnuti/kboBGJ5mFXnx6WwGa6vNcVXovUHyR4ST
   g==;
X-CSE-ConnectionGUID: 4UTAOUyaRKS7QQeKaknLUQ==
X-CSE-MsgGUID: d6YkjdJRTaqq5pU39WqQXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="47147941"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="47147941"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:57:25 -0700
X-CSE-ConnectionGUID: 6E3Ent9TQUiYb8+1m2GBQQ==
X-CSE-MsgGUID: fwJVlu8/RCeg7veRJSVZhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59283193"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO intel.com) ([10.245.246.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:57:23 -0700
Date: Tue, 13 Aug 2024 18:57:18 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: Re: [PATCH 4.19.y] drm/i915/gem: Fix Virtual Memory mapping
 boundaries calculation
Message-ID: <ZruQbmM6pVvKS1I1@ashyti-mobl2.lan>
References: <2024081222-process-suspect-d983@gregkh>
 <20240813141436.25278-1-andi.shyti@linux.intel.com>
 <2024081306-tasty-spoof-62c6@gregkh>
 <2024081308-olive-fondness-db98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024081308-olive-fondness-db98@gregkh>

On Tue, Aug 13, 2024 at 06:09:04PM +0200, Greg KH wrote:
> On Tue, Aug 13, 2024 at 05:28:15PM +0200, Greg KH wrote:
> > On Tue, Aug 13, 2024 at 04:14:36PM +0200, Andi Shyti wrote:
> > > Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.
> > > 
> > > Calculating the size of the mapped area as the lesser value
> > > between the requested size and the actual size does not consider
> > > the partial mapping offset. This can cause page fault access.
> > > 
> > > Fix the calculation of the starting and ending addresses, the
> > > total size is now deduced from the difference between the end and
> > > start addresses.
> > > 
> > > Additionally, the calculations have been rewritten in a clearer
> > > and more understandable form.
> > > 
> > > Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> > > Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> > > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: <stable@vger.kernel.org> # v4.9+
> > > Reviewed-by: Jann Horn <jannh@google.com>
> > > Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
> > > [Joonas: Add Requires: tag]
> > > Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
> > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
> > > (cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
> > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_gem.c | 48 +++++++++++++++++++++++++++++----
> > >  1 file changed, 43 insertions(+), 5 deletions(-)
> > 
> > Both now applied, thanks.
> 
> Wait, did you build this?  I get the following error:
> 
>   CC [M]  drivers/gpu/drm/i915/i915_gem.o
> drivers/gpu/drm/i915/i915_gem.c: In function ‘set_address_limits’:
> drivers/gpu/drm/i915/i915_gem.c:2034:18: error: ‘obj_offset’ undeclared (first use in this function); did you mean ‘iova_offset’?
>  2034 |         start -= obj_offset;
>       |                  ^~~~~~~~~~
>       |                  iova_offset
> 
> 
> I'll drop this now.
> 
> Can you fix this up and provide a working version?

ops! Sorry, I was on the wrong branch.

Will send you immediately the correct patch.

Thank you,
Andi

> thanks,
> 
> greg k-h

