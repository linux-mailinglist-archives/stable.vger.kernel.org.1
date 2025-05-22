Return-Path: <stable+bounces-146074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AAAC0A53
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA91D1BC4FDB
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709FD2874F5;
	Thu, 22 May 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOPWLudC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE117BB6
	for <stable@vger.kernel.org>; Thu, 22 May 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912230; cv=none; b=hygzIAM2aZ3rP6evHmXHEvqnmGTdKzzq2oGAilXohPH+ZAJT6Sx4+wAOfQXVeOIll/SkBcxdi1wJ2j9EXziYyMVGOho8vZ9JPdEg4Ag4yzfYhwTzLMrVGPbgG+OpQchVE1ECatmWhNrmPgEufp4+3snXCJf0dbQpN8o96312LOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912230; c=relaxed/simple;
	bh=8ofgiHW8Kwcc25P4Z8SQrs5ciMFqB+D9plMAvYRuUpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDxX7EP0ftpYCKDe05GNobcxcHH3DlGcwhw4qbDgooYgamBiuPbq/FL2FO35abQajmxjWNCRddkoRskSbvIQQkOz+fgXIryl8CU6gZYNmRhNArxtS3eW9OVrqTKPtwh97YKIoX4/Xy+5qMcZc+SRp9Vs3D3F4fid5buFvm2LT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOPWLudC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747912228; x=1779448228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ofgiHW8Kwcc25P4Z8SQrs5ciMFqB+D9plMAvYRuUpk=;
  b=GOPWLudC8nsg5jqwjELr3ccCJJyET3UUUgbIy1+UkvYWkp+co670DLia
   eVQTGx4KFlIcpJHkbMTWEcqVGI3WFf33u4bUxMaySwrElnYSWhdZpWkJ2
   P7KsdY8Ox6wcUhAeBy36pR4tK2qRJcF8Ir/hZAEefcNw6NlgljrOQmxm/
   6jwhhpRXl948/7kcXGb2zmLaVZMgcUNRBUr+I4zQlXn+3fVsXMBQaehpS
   OfIjAdAA3Hz/mHOyINP/6an7aA4ogqR452R49SFD6JmcPYAz7U6JR1kDU
   v+xPmvkSs7NOO+kIxZM3/8n3nVouEjlru+auDvSKJz0CzeIDlHtL2R/v7
   Q==;
X-CSE-ConnectionGUID: 3UUBPyhRQDOqvF22qUoN6Q==
X-CSE-MsgGUID: KBE17SCTTjKiWOg7y1UDOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60587044"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="60587044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:10:28 -0700
X-CSE-ConnectionGUID: T96FvMLhQnyDyS2q6jcudg==
X-CSE-MsgGUID: cNoWXZ3qSsGy96Z6Ek/8ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140405134"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 04:10:25 -0700
Date: Thu, 22 May 2025 13:10:23 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>,
	stable@vger.kernel.org,
	Ville =?iso-8859-15?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-15?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1"
Message-ID: <aC8GH-3_K4lQ6A9g@ashyti-mobl2.lan>
References: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522064127.24293-1-joonas.lahtinen@linux.intel.com>

Hi Joonas,

On Thu, May 22, 2025 at 09:41:27AM +0300, Joonas Lahtinen wrote:
> This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.
> 
> The IS_DGFX check was put in place because error capture of buffer
> objects is expected to be broken on devices with VRAM.
> 
> We seem to have already submitted the userspace fix to remove that
> flag, so lets just rely on that for DG1.

yes, sorry, I should have checked git bisect before accepting the
patch. I still think that a comment would help. In any case:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

