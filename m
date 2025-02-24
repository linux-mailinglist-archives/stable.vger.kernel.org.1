Return-Path: <stable+bounces-118916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0106A41F38
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35223188B723
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D6219316;
	Mon, 24 Feb 2025 12:36:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCF163;
	Mon, 24 Feb 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400614; cv=none; b=p4abZ6LW2nB3Odo+01zNhM6hGPPizTrfWBYq7xVyUm0TDUvDOMD+DPWYIDGFibT+e5nYubYBRX3ceJbtxacjdr/vbo4RpGLzy/y4i0Vj+7TdoBHp/YtGeGP8QZxs6GsXi1ym1yRPE2d0kwf2myLp0N+Bj0XEacq4tySyI1J0knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400614; c=relaxed/simple;
	bh=aayPYYFGtkFCxVK1CCv/9P5T5XgtfauuUYDmfvGoPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrotEqZJuUs7qxDFx6VNhqccTFgzHJKhTFZJG3obpnP8/K/ykwpBg6EyVHQsy/w/6Mv9cxUCzJG1QKzIfhHCPF1Zj7GIYuJKRFYxKwjhaUoaXavD7VwxY0seSqHDxmGbyNsjlxT/cRowe8vGUqL0yb59/t9tAsnvk3oMy28mRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: OnPQFCs3ToKG4nPJluqLAg==
X-CSE-MsgGUID: 2VSlAfBiR1K7sCMUbMEpuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51789787"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51789787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:36:53 -0800
X-CSE-ConnectionGUID: h8svp6MYS5SyqvuA3sfQ5A==
X-CSE-MsgGUID: mh/CViJZRr2EN8TjhREqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116069609"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:36:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmXhX-0000000Eh7W-1izE;
	Mon, 24 Feb 2025 14:36:47 +0200
Date: Mon, 24 Feb 2025 14:36:47 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Message-ID: <Z7xn3_x-CTm1H3LK@smile.fi.intel.com>
References: <20250224101527.2971012-1-haoxiang_li2024@163.com>
 <CAMuHMdUM18v5zyvQ5YZWRhN5Ppn8ks5LGxrjOX1GHy=hC3SD3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUM18v5zyvQ5YZWRhN5Ppn8ks5LGxrjOX1GHy=hC3SD3Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 01:30:47PM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 11:16, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> > Variable allocated by charlcd_alloc() should be released
> > by charlcd_free(). The following patch changed kfree() to
> > charlcd_free() to fix an API misuse.
> >
> > Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> > - Merge the two patches into one.
> > - Modify the patch description.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



