Return-Path: <stable+bounces-118778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD5A41B46
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B4316F0D9
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1839254B1E;
	Mon, 24 Feb 2025 10:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77E1EA7E6;
	Mon, 24 Feb 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393369; cv=none; b=Nk/oBBysYUFgghrZtHjvw3IqoVYLbRTiBovvfZ+r2HWDsB9cA1BenEQ29vDcmIYgZasJbwP1yqh3xfNaz0v7M9nozNWqRePvtOXxNLpw0NYq2U/AO03wHRa+1wBQYk55vde9+7Hxu7YFmhkBSA+lFWxULA7vYAzhBxZbRP5swB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393369; c=relaxed/simple;
	bh=/QRPoW5lk+0E4XMQkF2qjohhTPGz+hAfa/dkYnO7+AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzUED5kCIWXhiWQ4/1N6lWzxVDh9eLwhWYAX4/dGQ0HgSqwPYRMAe4xo9YwNwa6XcPVyDCom3Xet0FngRHvkOu+NgZLFnxOBnZ43xFiSHZgzATd3W9YzLDW2PAd8SH0S6a0LiXXmy6zG8+GNkX2i2pz9UsucOw+dDaQed+wbwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 8OZiYwFjQ5SJ9M7167K8fg==
X-CSE-MsgGUID: czf3qQKZQnqJ/rMiYmSt/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52568149"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52568149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:36:07 -0800
X-CSE-ConnectionGUID: 4ZVg8+LeR2eRVpeQWKp3TA==
X-CSE-MsgGUID: rekQZxHCRZeBRi/8xFWpsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115814660"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:36:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmVoe-0000000EfPl-1X4Y;
	Mon, 24 Feb 2025 12:36:00 +0200
Date: Mon, 24 Feb 2025 12:36:00 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Message-ID: <Z7xLkNkPc8rdbTL_@smile.fi.intel.com>
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

...

> - Merge the two patches into one.

Thanks!

> - Modify the patch description.
> Sorry Geert, I didn't see your reply until after I sent the
> second patch. I've merged the two patches into one, hoping
> to make your work a bit easier! Thanks a lot!

In any case it's better if Geert acks/reviews this one as from code p.o.v.
it's a 50% change :-)

-- 
With Best Regards,
Andy Shevchenko



