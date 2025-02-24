Return-Path: <stable+bounces-118771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31664A41B3A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100961890F6A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E52441AF;
	Mon, 24 Feb 2025 10:33:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421A2F37;
	Mon, 24 Feb 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393225; cv=none; b=MGE02OG4S/QTVNkcYQ0fdiJ212XhSPSkJlD0o8FQTv0NEMO0I10AALaEdRXHIBEMYZ/NBdxd4tTNozoK9pn+2l1KcLBn7vhKxk7+3gy9scobOzDCCVbxtEUHUXGO7BVYUw2Z2hiM/j5diXW0daaSRm+fq9MqqvxNND2uAt86nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393225; c=relaxed/simple;
	bh=wYqX6qK25SdeYMrEkacKw74d/qAtXzL0GRn0TT+qYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNdX0MMPduZD/k+R1xKv02nnU2PiQ7BEqu3FODn67kWCwVs915GGH/b80rKJYoFbYJrhPhpzywnUuaDU4o1keJhY1nr9PXdszmUIRmfDpIZhd6d87g692XQqjF8Mx0SiCJagZDt8DYZ7T63w0vfYwOOj/jy/H/qTqWY+BWWryzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: esegBKwEQnSEF17vQ/GzoQ==
X-CSE-MsgGUID: iShyvSLtQlWV89djKn94sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41404553"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41404553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:33:42 -0800
X-CSE-ConnectionGUID: c/qXJhBeQDGULRmdTo9lPg==
X-CSE-MsgGUID: JP7AdbRJTnWHblFYCIUnHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116654936"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:32:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmVlZ-0000000EfMP-1FaY;
	Mon, 24 Feb 2025 12:32:49 +0200
Date: Mon, 24 Feb 2025 12:32:49 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: hd44780: Fix an API misuse in
 hd44780_remove()
Message-ID: <Z7xK0aomyvqww7KG@smile.fi.intel.com>
References: <20250224100009.2968190-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224100009.2968190-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 06:00:09PM +0800, Haoxiang Li wrote:
> Fix this by using charlcd_free() instead of kfree().

Please, fold two patches into one and send it as v2. Thank you!

-- 
With Best Regards,
Andy Shevchenko



