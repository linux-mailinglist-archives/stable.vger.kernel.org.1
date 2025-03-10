Return-Path: <stable+bounces-121722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF54A59A6D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88ED3A6558
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817022D4F4;
	Mon, 10 Mar 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDxg+4Xh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7B1DFF0;
	Mon, 10 Mar 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622112; cv=none; b=QvfeEEVO0BrpSIWAkGnZTIRuAG7wwqC17gtMsaQENHtjuMZnq7Uj0VaXVHo74HOJPjuPQWnjqqqp6oT5Nce0ESHy585PTgMu73v/Z/IuP0F2LWHhaeUzs4bwMlmyRpfMK3j9nrFkLFb9wQnpx/rNBn8/3xs1+38fGia8xLRJ/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622112; c=relaxed/simple;
	bh=LQycRAS1q5majaMC8CN5bQGG+0H8PIJHt+ztPwFsfWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiOobgV78WX6XDFBgNdlnP7oon4tpVwjRb7pxTcJK6WH+zo/Fw5AZ+vn5pa3kVAzJCWDc0waNC+0kd2D/QwBzW04QRLxIvoV9V/hs50z6H07CY7aBvcXJr0iWXKWU73XkgOukemMnCcU7ieQmA/BeyMBfPjafhTuwJw8SXFkUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDxg+4Xh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741622111; x=1773158111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LQycRAS1q5majaMC8CN5bQGG+0H8PIJHt+ztPwFsfWM=;
  b=ZDxg+4XhZmlg/NxppWEv3JS89NR0LFUKNQDmOOyr0y0H2N5M+ZLmOwkg
   dfpWsmGLQV4kbpv9yMCzwmwZbBjBLBxn4tGAPkbwGvequoPpVE9Oam7bA
   xffPU6SHRmf4wdCXU7g4EaUPB+4cXh29oB4LO8fxAvz1uzZ6k77Sh4KWc
   vw9Her83f/OaEPqrYfI9fPZYjuUK5oKOMCyW7+7iODgrig7Ihrz4+zDR3
   eYux8SJ6ACy5XyuEuCDBgM+FCcTIisWPmeExMJMlpcZgMVgxQHce8WzTo
   EasZ6pjvGc5vaS3cL2NrZi8HA6q1sQwGckSpgT8GE8l7lPraTW3befFIp
   w==;
X-CSE-ConnectionGUID: cieAWNJITXOh/mjJUWyiAQ==
X-CSE-MsgGUID: 9hz34wyGQJipuVwG4ZdreQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65080746"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="65080746"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 08:55:11 -0700
X-CSE-ConnectionGUID: TI6lV3vzQoafx+1AjTVkiw==
X-CSE-MsgGUID: IlLVoWeVRACdQRgRAcuFrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125260256"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 10 Mar 2025 08:55:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Mar 2025 17:55:04 +0200
Date: Mon, 10 Mar 2025 17:55:04 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Patch "drm/i915: Plumb 'dsb' all way to the plane hooks" has
 been added to the 6.12-stable tree
Message-ID: <Z88LWG1_AeNb7Hch@intel.com>
References: <20250309194558.4190633-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250309194558.4190633-1-sashal@kernel.org>
X-Patchwork-Hint: comment

On Sun, Mar 09, 2025 at 03:45:57PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     drm/i915: Plumb 'dsb' all way to the plane hooks
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      drm-i915-plumb-dsb-all-way-to-the-plane-hooks.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit f03e7cca22f4bb50cae98840f91fcf1e6d780a54
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Date:   Mon Sep 30 20:04:13 2024 +0300
> 
>     drm/i915: Plumb 'dsb' all way to the plane hooks
>     
>     [ Upstream commit 01389846f7d61d262cc92d42ad4d1a25730e3eff ]

It would help if you actually mentioned *why* you need to backport this?

-- 
Ville Syrjälä
Intel

