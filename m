Return-Path: <stable+bounces-118779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AAA41B55
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F913B39D2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D9255E5E;
	Mon, 24 Feb 2025 10:39:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C7255E59;
	Mon, 24 Feb 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393558; cv=none; b=JH4fRBCmKfbiv9KJu8S8kdOV8BcqSa5XtxLSBNOUteWbnnn+boIYYLSKhfsJDz6cIcbmGJRgCWs/+AV9BStZZdrL8bCyS1y/LGd4bHczqykyiSbvcmKSwU0DCad2t7kfUKI+TYNwZBy5XPCXT+T0QhlWv0FbfwUdutfDi8quBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393558; c=relaxed/simple;
	bh=5WpA5pve7xG6m/cPcgLMHpsAFVwArMM9GUZMKNDtq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndu/zWId3hwhRY93vRH9+uRtE1lAPTji7W5gsLA8bZ+rPcBHx3nV292VYUUYGB8p2dNd0by4w69HghahVg0ArwSJxsmnOixANSW9dpZ7NnNKM2l+fK5EyBp8TWqXENKT62jQT76PefsVDd0l0r6l4CGT0LiZKWQNMVDAJMoljNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: is98RGZfSg2EONTHoYgC5A==
X-CSE-MsgGUID: Qmv6mDIuRXi28LUFkDw8MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="28739742"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28739742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:39:15 -0800
X-CSE-ConnectionGUID: gQgNxT4eSt2Oq6u7GEhEqA==
X-CSE-MsgGUID: fXUIK0wPToKGwmqScKfcUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146907375"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:39:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmVri-0000000EfSg-1Ysk;
	Mon, 24 Feb 2025 12:39:10 +0200
Date: Mon, 24 Feb 2025 12:39:10 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Message-ID: <Z7xMTiLT_NFzSEXO@smile.fi.intel.com>
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

> ---
> Changes in v2:
> - Merge the two patches into one.
> - Modify the patch description.
> Sorry Geert, I didn't see your reply until after I sent the
> second patch. I've merged the two patches into one, hoping
> to make your work a bit easier! Thanks a lot!

Btw, have you seen this one?

https://lore.kernel.org/r/20221128084421.8626-1-niejianglei2021@163.com

-- 
With Best Regards,
Andy Shevchenko



