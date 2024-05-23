Return-Path: <stable+bounces-45649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591898CD120
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90A7281C52
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240E146A9C;
	Thu, 23 May 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGI13gXl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A182746F
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463167; cv=none; b=AgDV8pQtbDk/F6B1De6GOh9FPHyuyDlPSDk0QhYA5c//JBDxGHo0wdCHh7GzSZwZ8KZIN4oCbLcpl/ydWmYG9WSaSBR5cRj4z9S+HW/ranKrMhB6qtQLHZ7iwJS6oVtiGfbUOQ3rjGor+DLDm6qTnu5y9PaOjJktLEjgrmb8Uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463167; c=relaxed/simple;
	bh=2RcYa+PV3eSUEx+GeItUnyJGuzG4rfyK0nh7prZKLdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsFCd4CNC6pbAoa3MIYJqu7c690opSwGCvOXA8nL8S3Rg/HGjtfs6TDEoDajP3Jj1wIPmNoynIHN8uIHydmaJIwpfzoeKy5PwnNWsDAqm+CBdv0Sj+bmkOhIGuTy6XUWL7Rsx+yB5mYvKfCuyvVS87V4x6M2p+FhPYWPnlTUPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGI13gXl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716463166; x=1747999166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2RcYa+PV3eSUEx+GeItUnyJGuzG4rfyK0nh7prZKLdQ=;
  b=iGI13gXlm4XXXg5VBrspSX+E1Qt2+SbZvAHkj7apav3u+isegyykYJHA
   Dv5IDvxBgDB85Z9TP2sZX3azKNMUIuJh8zoDcMw0JZ7uOLvYztSJ4VYr4
   OTITEXprG14BEd5JM/fa+1wyClDYMHZVBHRZoG0jIamniZ6v6nWLJ6t4N
   EzO0xJyV+x8F9uZhhxFpLZ8s5bqNj8aElQte+2NUPhW0dCvueGS82LbN5
   NQH2pqT3Sw6z/BGrZdmzo07iguBsSJiyA1uRaFetAXzl/OBWmJV2WJnTd
   YRZZKmpCBS6TD6gzT6IiX2keotrwjETafImwtCs/NX5U7DygvjLSXS3lF
   w==;
X-CSE-ConnectionGUID: f8kfb8NrTcyoow+/y+c9uQ==
X-CSE-MsgGUID: TEolCAhZS0CkQrK9A5Blmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="13002342"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="13002342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 04:19:22 -0700
X-CSE-ConnectionGUID: hpQhgGQoRpeU8kBQ+I4HQQ==
X-CSE-MsgGUID: /Y4MFKwuTF2jBvyDrZpmnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33613999"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 May 2024 04:19:16 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 23 May 2024 14:19:15 +0300
Date: Thu, 23 May 2024 14:19:15 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Vidya Srinivas <vidya.srinivas@intel.com>,
	intel-gfx@lists.freedesktop.org, shawn.c.lee@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Message-ID: <Zk8mM0bh5QMGcSGL@intel.com>
References: <20240520165634.1162470-1-vidya.srinivas@intel.com>
 <20240522152916.1702614-1-vidya.srinivas@intel.com>
 <5e5660ac-e14b-4759-a6f6-38cc55d37246@ursulin.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e5660ac-e14b-4759-a6f6-38cc55d37246@ursulin.net>
X-Patchwork-Hint: comment

On Thu, May 23, 2024 at 09:25:45AM +0100, Tvrtko Ursulin wrote:
> 
> On 22/05/2024 16:29, Vidya Srinivas wrote:
> > In some scenarios, the DPT object gets shrunk but
> > the actual framebuffer did not and thus its still
> > there on the DPT's vm->bound_list. Then it tries to
> > rewrite the PTEs via a stale CPU mapping. This causes panic.
> > 
> > Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
> > Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > index 3560a062d287..e6b485fc54d4 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> > @@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
> >   static inline bool
> >   i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
> >   {
> > -	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
> > +	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
> > +		!obj->is_dpt;
> 
> Is there a reason i915_gem_object_make_unshrinkable() cannot be used to 
> mark the object at a suitable place?

Do you have a suitable place in mind?
i915_gem_object_make_unshrinkable() contains some magic
ingredients so doesn't look like it can be called willy
nilly.

Anyways, looks like I forgot to reply that I already pushed this
with this extra comment added:
/* TODO: make DPT shrinkable when it has no bound vmas */

-- 
Ville Syrjälä
Intel

