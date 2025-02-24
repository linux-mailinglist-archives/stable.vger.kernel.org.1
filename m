Return-Path: <stable+bounces-118934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F4A421AC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F7E3BE309
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8A23BD0B;
	Mon, 24 Feb 2025 13:38:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED42192E6;
	Mon, 24 Feb 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404312; cv=none; b=pCqgycfuin/m6/pwSY3Z9k0AVPnJWyJvNv9drCBHPjcIf3F6mJk1D61c2x9VY1fxT6cV+7ob/zlNVB0MEPDKpifHkM72U994wv2uaoPLyOoOAw2mbF3tp9mcOWC4wep1ZH9mBb28r0gbTimxEm09QfxdxHgdLdF2rMqQ23HbJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404312; c=relaxed/simple;
	bh=gOA6LCFerHUUNDxs1f1ZtRKSjLkGS6/L0cBq0MXUv/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubIh2otLjDVzFQ8TezbG7Taz4v02bhZ8PagZqxtWPlVAqg6FSWU7y0TWVAgprCNZQ3w3/wG15M+vF5Bj0bgIV8WjtzT2A4MjStk5V2IDLfOSyp7uu1/i/g+C5YDUVHISTbKzwuybccUPIh2owT0GyzI6wHuA0QP3TP/9KA6c+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ZcD1qTvnTRWYPzy4tpk9uw==
X-CSE-MsgGUID: flFkQd76Sj6NTGzSavWFeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40395020"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40395020"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:38:30 -0800
X-CSE-ConnectionGUID: uSp9G2L4SPap7DUnAlAxqg==
X-CSE-MsgGUID: HehEs/ZjSVeufOLhwx4R5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120971151"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:38:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmYfA-0000000Ehx6-2PG2;
	Mon, 24 Feb 2025 15:38:24 +0200
Date: Mon, 24 Feb 2025 15:38:24 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Message-ID: <Z7x2UFoTsLR0umvH@smile.fi.intel.com>
References: <20250224101527.2971012-1-haoxiang_li2024@163.com>
 <Z7xnnPaoHfz7lYyi@smile.fi.intel.com>
 <CAMuHMdVYxruwpA92FykyEAwoSBxfb0Z1AmnyqLziGTpMC3d_gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYxruwpA92FykyEAwoSBxfb0Z1AmnyqLziGTpMC3d_gg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 02:33:49PM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 13:35, Andy Shevchenko <andy@kernel.org> wrote:
> > On Mon, Feb 24, 2025 at 06:15:27PM +0800, Haoxiang Li wrote:
> > > Variable allocated by charlcd_alloc() should be released
> > > by charlcd_free(). The following patch changed kfree() to
> > > charlcd_free() to fix an API misuse.
> >
> > > Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> > > Cc: stable@vger.kernel.org
> >
> > Okay, looking closer to the current state of affairs, the change
> > does not fix anything actually. OTOH it's correct semantically and
> > allows to do any further development in charlcd_alloc(), if any.
> >
> > That said, if Geert is okay with it, I would like to apply but without
> > Fixes/Cc: stable@ tags.
> 
> I had mixed feelings about the Fixes-tag, too.
> Semantically, it's indeed a fix.  If any further cleanups are ever done
> and backported, but this patch would be  missed, it would introduce a bug.

Okay, I return it.

-- 
With Best Regards,
Andy Shevchenko



