Return-Path: <stable+bounces-118777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F9A41B42
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF873189715E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30396254B07;
	Mon, 24 Feb 2025 10:34:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D3255E42;
	Mon, 24 Feb 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393273; cv=none; b=FbhakRO+mWD+nimCk1OnQXV8opTKeMZlg/UsmJsCbLcJDcjJnDTUTyirDmnCQY+pjNRl5AGwvQvr3fJx4ZuLoBERNN/sOQmQDSGKjBrCrSeD5g4gan+8X8dfLiKX3lWL5PmGyPK9dy8oGDgKc3R64fhGjjcX66C3Vmh5L9RtFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393273; c=relaxed/simple;
	bh=r031CoRZbOuv1jgcdKq1ZTsiRwvLnjPWRr1yTG6e/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agly5RyQz9AUfYWeHUqEO2WKC+YqgoYX+rtFkfsoFGXhjoGzgJLABlik2yFdtHV4oqC/YCCihsZI64buLmmUYoN3f+wr+qqTrYIEFUibbicjPqCii70r9jf/uRQSUZuzC3fqrviDzwfud2dnoQosHM8N3I+DUuAbShIDE/P1CUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: lM9SXg6aTbuSMShNZzydlw==
X-CSE-MsgGUID: 7LuCZXwuRkyNlDMLy8ZOqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="63610949"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="63610949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:34:31 -0800
X-CSE-ConnectionGUID: 2TjTgOegRpCa72VtoLXs2Q==
X-CSE-MsgGUID: Q92FymkfS9yKq6SgLYIJuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="139245715"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:34:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tmVn7-0000000EfNr-3evM;
	Mon, 24 Feb 2025 12:34:25 +0200
Date: Mon, 24 Feb 2025 12:34:25 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: geert@linux-m68k.org, u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu,
	poeschel@lemonage.de, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: hd44780: Fix an API misuse in
 hd44780_remove()
Message-ID: <Z7xLMaILcO0-FWhH@smile.fi.intel.com>
References: <20250224100009.2968190-1-haoxiang_li2024@163.com>
 <Z7xK0aomyvqww7KG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xK0aomyvqww7KG@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 12:32:49PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2025 at 06:00:09PM +0800, Haoxiang Li wrote:
> > Fix this by using charlcd_free() instead of kfree().
> 
> Please, fold two patches into one and send it as v2. Thank you!

Ah, I see it now.

-- 
With Best Regards,
Andy Shevchenko



