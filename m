Return-Path: <stable+bounces-32408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FF88D2C0
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 00:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CD0B23CE3
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8B13DBB3;
	Tue, 26 Mar 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dzs43hVL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D0208B4
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494984; cv=none; b=d5GSzumf903c60ELSI0n4SCE9scFK608SOLWj4YEHGhKR7RdXRW3P1nVMu8V6Gm0PhKJOXfEx6Qno+Cj1dDqJ/VsqQXdKrjFGBYhqV22W30/F52QCZ1urLGKm4t6WlxhcUmx7inGNTmbq2brW1C0/XUHldMSgPMeC0EIGeYKdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494984; c=relaxed/simple;
	bh=xSeQZGWNTgZFAsZBhQPy/UL/WO1JBSkDZmSypsvOpqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxpD+Vztp4OROzTnmYBXAaUZjai16zNoCbphxbAPDx8s0akkLWbpHv0HaDG3fIn4QG1nHLIkfpt8bhpSQmp0MDQtESKmiJlOwT1xN96AZnCL8PUyr6JUh6XOOm8eIICQUqLtqadIqbVxwsjZc7+u2w8i2EQQH62mtSjWSRhfb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dzs43hVL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711494983; x=1743030983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSeQZGWNTgZFAsZBhQPy/UL/WO1JBSkDZmSypsvOpqU=;
  b=Dzs43hVL2BKium6wkVfg3VO6NizE/efMOBxm9fS6HBtgk421bh/YsHXo
   lANN09wK9UvYkraQykdh2ogX+fdDF6JjgAgVEEG92Ow/8lCAQ4ZbuSZs/
   45/Qy2cfTCcCLxOnWDnsPCLTPzSG6+xJ2riiI5D+fzFgYVxMN/t7flqn8
   k1jEV73MotjosHfLKSp8zsKDB/O6zqBPiV6DS6YgVDq3d+csx5GNnJefz
   xFEvbjeHC8la9M9pszmoOYTN4aovVQgS1vvfnjBLOQikOYVTQKIMeCvwc
   ZwR0Bb9MktoxT8TX02PO+abA31GrcazuyeeMDkV3mIC58+2/Bzjf0RK6G
   g==;
X-CSE-ConnectionGUID: GtHT8ahnTaqLesxn9blmnw==
X-CSE-MsgGUID: DlD7rPWmTteCfKY9VBkv0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17304196"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="17304196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 16:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="47291647"
Received: from unknown (HELO intel.com) ([10.247.118.210])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 16:16:16 -0700
Date: Wed, 27 Mar 2024 00:16:09 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v6 2/3] drm/i915/gt: Do not generate the command streamer
 for all the CCS
Message-ID: <ZgNXOfBm5RK4oG9r@ashyti-mobl2.lan>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
 <20240313201955.95716-3-andi.shyti@linux.intel.com>
 <20240326160310.GC718896@mdroper-desk1.amr.corp.intel.com>
 <ZgMXGlfsGSOhbC0b@ashyti-mobl2.lan>
 <20240326213033.GA1332995@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213033.GA1332995@mdroper-desk1.amr.corp.intel.com>

Hi Matt,

On Tue, Mar 26, 2024 at 02:30:33PM -0700, Matt Roper wrote:
> On Tue, Mar 26, 2024 at 07:42:34PM +0100, Andi Shyti wrote:
> > On Tue, Mar 26, 2024 at 09:03:10AM -0700, Matt Roper wrote:
> > > On Wed, Mar 13, 2024 at 09:19:50PM +0100, Andi Shyti wrote:
> > > > +			/*
> > > > +			 * Do not create the command streamer for CCS slices
> > > > +			 * beyond the first. All the workload submitted to the
> > > > +			 * first engine will be shared among all the slices.
> > > > +			 *
> > > > +			 * Once the user will be allowed to customize the CCS
> > > > +			 * mode, then this check needs to be removed.
> > > > +			 */
> > > > +			if (IS_DG2(i915) &&
> > > > +			    class == COMPUTE_CLASS &&
> > > > +			    ccs_instance++)
> > > > +				continue;
> > > 
> > > Wouldn't it be more intuitive to drop the non-lowest CCS engines in
> > > init_engine_mask() since that's the function that's dedicated to
> > > building the list of engines we'll use?  Then we don't need to kill the
> > > assertion farther down either.
> > 
> > Because we don't check the result of init_engine_mask() while
> > creating the engine's structure. We check it only after and
> > indeed I removed the drm_WARN_ON() check.
> > 
> > I think the whole process of creating the engine's structure in
> > the intel_engines_init_mmio() can be simplified, but this goes
> > beyong the scope of the series.
> > 
> > Or am I missing something?
> 
> The important part of init_engine_mask isn't the return value, but
> rather that it's what sets up gt->info.engine_mask.  The HAS_ENGINE()
> check that intel_engines_init_mmio() uses is based on the value stored
> there, so updating that function will also ensure that we skip the
> engines we don't want in the loop.

Yes, can do like this, as well. After all this is done I'm going
to do some cleanup here, as well.

Thanks,
Andi

