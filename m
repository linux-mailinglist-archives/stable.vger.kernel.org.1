Return-Path: <stable+bounces-200801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB18ECB622D
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 15:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49D4C3017861
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF42C324C;
	Thu, 11 Dec 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXRN+6cS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F42C3261
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461877; cv=none; b=YuvimVYOYSFeUYFWbm/gakh3WAes0u+D83jYJmAk9itig20uX39ezT6qPCU27ReihgZokGo37ctDmsYknQKftPo38DZy6d1f2gKdhVIdhjNWDX3nNcQ8+HraTKNlSUbQ4Zby4QKojVvH2K5KOqQY8sW5800Rp3f/gQS1hjnuKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461877; c=relaxed/simple;
	bh=8rju0sIOdUgAVxzoAbCeZb5Ok9k0o3hFXh44STEZKGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE5XVOpzXBwYdUKluGdxRpH320MO1nzmtBsBw+R/dSLw6asQCNVapoWCXravB+lr0xRazAVnLqrYtaxrR8E3QAV6SEf2bzO1buuLez5ECwPQXSU5FahEUflmYsnMDtIXSDxpgqHIfTQAONl3hmrEEoi2L51HqNWjMxVPVzWJuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXRN+6cS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765461876; x=1796997876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rju0sIOdUgAVxzoAbCeZb5Ok9k0o3hFXh44STEZKGM=;
  b=CXRN+6cSTH1D+KJe+ukAUlH+LR9AEfhJwjGHyyZvbslibjapaPjfmAXx
   2uDhR1ANYGJv+jd04NWu8sWrIYIbJlXgPVvNRbpezgD+oIvclQhCXcpoL
   zzGBrIPRVJmvyvgz6oQpEPsEnx8RsYFpPVA1xI+4LyRo138kKGU5PFQ+/
   GUSO5/GfSCeev2YlXwY4Rs07xkt2NbSDxVvjz5sxh2zxKt5wQTDXkUywU
   x90Itwzq4utGZwg+hlqu0mS7gFCN+ocryF5SYCo4zoqm8RiH0MyoZ9GzC
   dkIiBW7cfj2GHBxBezCSnZNEf6LbEZFVLHVtZFZgqX7wcCu69UKjfRv0u
   w==;
X-CSE-ConnectionGUID: SOmSFKSDRmKBc6kZM0OPqw==
X-CSE-MsgGUID: XlUiP9eUQZ+a0qN7A/ZIGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67176539"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67176539"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:04:35 -0800
X-CSE-ConnectionGUID: 0+WJemQkSdSqfEjt8Uhsyw==
X-CSE-MsgGUID: pK9oDWMoQViNHqcsPOBK5g==
X-ExtLoop1: 1
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.254])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 06:04:31 -0800
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject:
 Re: [PATCH v3] drm/i915/gem: Zero-initialize the eb.vma array in
 i915_gem_do_execbuffer()
Date: Thu, 11 Dec 2025 15:04:29 +0100
Message-ID: <2468170.UQZUX1FTLU@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ezfzff7burfabd2b4ofna5pmue2m64zn3gin2uyefnk7fczizk@f52nhwgfliyh>
References:
 <20251210165659.29349-3-krzysztof.niemiec@intel.com>
 <ezfzff7burfabd2b4ofna5pmue2m64zn3gin2uyefnk7fczizk@f52nhwgfliyh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 11 December 2025 12:24:31 CET Krzysztof Karas wrote:
> Hi Krzysztof,
> 
> [...]
> 
> > @@ -3375,7 +3360,9 @@ i915_gem_do_execbuffer(struct drm_device *dev,
> >  
> >  	eb.exec = exec;
> >  	eb.vma = (struct eb_vma *)(exec + args->buffer_count + 1);
> > -	eb.vma[0].vma = NULL;
> > +
> > +	memset(eb.vma, 0x00, args->buffer_count * sizeof(struct eb_vma));
> > +
> >  	eb.batch_pool = NULL;
> >  
> >  	eb.invalid_flags = __EXEC_OBJECT_UNKNOWN_FLAGS;
> > @@ -3584,7 +3571,16 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
> >  	if (err)
> >  		return err;
> >  
> > -	/* Allocate extra slots for use by the command parser */
> > +	/*
> > +	 * Allocate extra slots for use by the command parser.
> > +	 *
> > +	 * Note that this allocation handles two different arrays (the
> > +	 * exec2_list array, and the eventual eb.vma array introduced in
> > +	 * i915_gem_do_execubuffer()), that reside in virtually contiguous
> > +	 * memory. Also note that the allocation doesn't fill the area with
> > +	 * zeros (the first part doesn't need to be), but the second part only
> > +	 * is explicitly zeroed later in i915_gem_do_execbuffer().
> I get the gist of this comment, but I think you could reword the
> last sentence:
> "Also note that the allocation doesn't fill the area with zeros,
> because it is unnecessary for exec2_list array, and eb.vma is
> explicitly zeroed later in i915_gem_do_execbuffer()."

My preferred wording would look something like this:

Also note that the allocation intentionally doesn't fill the area with 
zeros since the exec2_list array part is then fully overwritten with a 
copy of user data before use.  However, the eb.vma array part is still 
expected to be initialized as needed by its user.

Thanks,
Janusz

> 
> > +	 */
> >  	exec2_list = kvmalloc_array(count + 2, eb_element_size(),
> >  				    __GFP_NOWARN | GFP_KERNEL);
> >  	if (exec2_list == NULL) {
> 
> 





