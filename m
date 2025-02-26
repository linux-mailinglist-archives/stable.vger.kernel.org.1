Return-Path: <stable+bounces-119671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124FA460E1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C5517AADF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00B21D3F0;
	Wed, 26 Feb 2025 13:27:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090021B9D2;
	Wed, 26 Feb 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576460; cv=none; b=r4hn11LD4rSgrnMmtxYeW9n0i0VWDlJ/kUOmPkmaQkfoTTivp3j7p1QDN89yPvuIFzb6IPoSw/hTBDPPYZiojJ1j//L9B7aK6DhYf48UtdQiTEEOa3W48ECZDaJPn9svTR59K8ZGj7Qnjee555AKU5kewmxGsC9LtYzcuNpsips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576460; c=relaxed/simple;
	bh=ZUwPDeojIM8ZR4NgP45zcqpCKyZ98Qjn+9vfobavu2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMY+mMBujOO880Yu7eZVMEmTKYngRFEZk97PFWMd39cVD4dwTjYkJXGxhZ+KHDf64KUJeJdGsYGaT6Kg8c6qcnA19F4GnNW9o6EppF7zKTHzCuRxHMCgLIgIyzGdU9FVHG1dJx52u+nzb0nx9f+sbX1jvZdYVeeoBkHs//bT2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: yegpXBg+SRS+TSD/v7PD7w==
X-CSE-MsgGUID: ojROo2MVTW+qkYDKU4N3ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45332309"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="45332309"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:27:38 -0800
X-CSE-ConnectionGUID: 864gnXZ8S86Vm4AYh7hhGg==
X-CSE-MsgGUID: DTuR2PDQSxSv0zs4Wq/Iow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117624304"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:27:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tnHRl-0000000FKmU-0LKu;
	Wed, 26 Feb 2025 15:27:33 +0200
Date: Wed, 26 Feb 2025 15:27:32 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] auxdisplay: hd44780: Fix a potential memory leak in
 hd44780.c
Message-ID: <Z78WxDiEIaYSaQfz@smile.fi.intel.com>
References: <20250226101213.3593835-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226101213.3593835-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 06:12:13PM +0800, Haoxiang Li wrote:
> At the 'fail2' label in hd44780_probe(), the 'lcd' variable is
> freed via kfree(), but this does not actually release the memory
> allocated by charlcd_alloc(), as that memory is a container for lcd.
> As a result, a memory leak occurs. Replace kfree() with charlcd_free()
> to fix a potential memory leak.
> Same replacement is done in hd44780_remove().

The v2 was already applied.

-- 
With Best Regards,
Andy Shevchenko



