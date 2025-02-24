Return-Path: <stable+bounces-118915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9502EA41F32
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F335D7A35C6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448923BD0A;
	Mon, 24 Feb 2025 12:35:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB323372D;
	Mon, 24 Feb 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400548; cv=none; b=PS+9AdSuuZRCNm/rC16jQNkE7rxsP7d/CRCB1KChpyt2D3EytWNm4UxRCFw33/Zy9qotJu2rdLWuehnBWkkDU089WnPr7mHFC0ic628mDv8pbE/8euyHfYMl9QGprOlzTGSLyspCl2SdfPsL3en1rNEz3LeAnalkfgPKrTwgWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400548; c=relaxed/simple;
	bh=jcR9ncjvukKqn/WocsBFBYojZvBoe3irKCHwfzWsL0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hemeeNhMJGw1Kn/s/2Dv5ub+13Sk00v5oP9uXzFMbzcuh4yCi2pB6Grum+fW3pIJ0W5e7aRcMI60jRQqoOwuBsqC05HB7hBSrWQz4cHoPwrAQ+7uE7f4tb9CbA3KjJNTjQ+TodBNGL9qixx6oRNuAFujiGmYUS078vQn6mvFKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: j+nwlmHeTkGTOkoOtsr7bA==
X-CSE-MsgGUID: V+fY6Zk9TauIUNk+E3s0Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41064565"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41064565"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:35:46 -0800
X-CSE-ConnectionGUID: BcsVNQVARUao9YqWHx0LpA==
X-CSE-MsgGUID: sp9l7U3qQX6M5ZjDGn4Bnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116243471"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:35:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmXgS-0000000Eh67-30HY;
	Mon, 24 Feb 2025 14:35:40 +0200
Date: Mon, 24 Feb 2025 14:35:40 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Message-ID: <Z7xnnPaoHfz7lYyi@smile.fi.intel.com>
References: <20250224101527.2971012-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224101527.2971012-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 06:15:27PM +0800, Haoxiang Li wrote:
> Variable allocated by charlcd_alloc() should be released
> by charlcd_free(). The following patch changed kfree() to
> charlcd_free() to fix an API misuse.

> Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> Cc: stable@vger.kernel.org

Okay, looking closer to the current state of affairs, the change
does not fix anything actually. OTOH it's correct semantically and
allows to do any further development in charlcd_alloc(), if any.

That said, if Geert is okay with it, I would like to apply but without
Fixes/Cc: stable@ tags.

P.S.
The very similar needs to be applied to panel.c, but I already have
a patch for that locally, thanks to this thread.

-- 
With Best Regards,
Andy Shevchenko



