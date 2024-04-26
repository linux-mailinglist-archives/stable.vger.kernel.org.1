Return-Path: <stable+bounces-41514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F688B37B9
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3EFB238CC
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D30146D49;
	Fri, 26 Apr 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ6iEWDu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A8145FE7
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136442; cv=none; b=eADnpELdNM57aDQjs04NCWE458kgU6sGpefj/AztYu3C+uP7ssgDujdt/klAQAHWKWRC/3Bq9SqtJdeEhlBKkkyRxxi5EpkpviJ4wfPnU+H1Ya7WPfhR4+vG7YtBI6V3ZxhF9yRmetDCuUh0MBCj5xUo98OCUCtgIZiAtu+akoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136442; c=relaxed/simple;
	bh=TPvoHDOw8CFxIt1QPp+dGjLmg/3zeloSgEPwTuPDsi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/40X3UtKdhfKZiEWRw1hezzSMAPSCsMonIMGSqv4n3veUmV55zRcW5q/oY1ZVVHl/qGFlNZHXcb9OEDciK3cdgKrUOWUT2k/2qfRR7eJpny/ub4qKzSZ27kzh1OPW+Ifu1mIC2OqtJP8FgSXByEjJvHf0hhrxjKG3g2PluVfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ6iEWDu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714136441; x=1745672441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TPvoHDOw8CFxIt1QPp+dGjLmg/3zeloSgEPwTuPDsi4=;
  b=fQ6iEWDuRJNfMTeAZzTMZ/v5qaCkjfkRp7mh8RTwhLeZqC5e2Q822U82
   kJbSDBLkLHA1F60D5ZLo8Z/yEu7VFWlVs0FCEXbpxhV9ce/e7k7PzcrH3
   eetM5ahefH485dFMeqbvVRDQlXZGi2SDlhyRsLUPlRdKAynBn0wKB3sB9
   uEOTa/fMpnX3s1spEeC5EzEfKSRAhwLW/qrztf1NRSjUII96sao1XKa2e
   mVyuRO0KF0q7u5i3K9yO4sNg4L6tTZUMII3vdoGeuXkaimPuRyzS6K2l/
   YaRp0ukh0euNhGfqX9RsO9lLD69OxCG22fjVzZgRlO9HwEr11kmFBkeMy
   Q==;
X-CSE-ConnectionGUID: 64qy5yqoR++DyFHoGy6g6Q==
X-CSE-MsgGUID: Qa73RkTtRXOC55HdtQzIqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="32367538"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="32367538"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:00:40 -0700
X-CSE-ConnectionGUID: A0QywIJQQb2Rhwx6FrVzBA==
X-CSE-MsgGUID: HASdl/FnQ9uBd7jcKjAcLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25491521"
Received: from unknown (HELO intel.com) ([10.247.119.98])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:00:31 -0700
Date: Fri, 26 Apr 2024 15:00:21 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Andi Shyti <andi.shyti@kernel.org>, Gnattu OC <gnattuoc@me.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Automate CCS Mode setting during engine
 resets
Message-ID: <ZiulZZ_X1SEF8vVE@ashyti-mobl2.lan>
References: <20240426000723.229296-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426000723.229296-1-andi.shyti@linux.intel.com>

Hi,

On Fri, Apr 26, 2024 at 02:07:23AM +0200, Andi Shyti wrote:
> We missed setting the CCS mode during resume and engine resets.
> Create a workaround to be added in the engine's workaround list.
> This workaround sets the XEHP_CCS_MODE value at every reset.
> 
> The issue can be reproduced by running:
> 
>   $ clpeak --kernel-latency
> 
> Without resetting the CCS mode, we encounter a fence timeout:
> 
>   Fence expiration time out i915-0000:03:00.0:clpeak[2387]:2!
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10895
> Fixes: 6db31251bb26 ("drm/i915/gt: Enable only one CCS for compute workload")
> Reported-by: Gnattu OC <gnattuoc@me.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+

based on the discussion on the issue and as agreed with Gnattu:

Tested-by: Gnattu OC <gnattuoc@me.com>

Thank you again, gnattu,
Andi

