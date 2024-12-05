Return-Path: <stable+bounces-98759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E69E50B6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82318287521
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985901D88D7;
	Thu,  5 Dec 2024 09:05:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151731D5CFE;
	Thu,  5 Dec 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389544; cv=none; b=fX+sYlJ5VrJLmyqlCbHgNY+PivlWwl1+e2VvzHUvL8UX8WnNzbHjUZ4tU1WLlUtLMWM5/AaM0Dz1N6hZEQMreXxMV1y0GzfaEnZ5E6Fs5CSJT2VTTiLQqVGVEF7lFQ7qCozEJ8q5PUE0EoWA8SUnd1ICXCgCpsmj6msH/R+qk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389544; c=relaxed/simple;
	bh=10otrxhA1olVuUl7zOfi7Auyj1IJqPaGCK+rEEm6TkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvQiqLCX6rPElmlY9x9Vn4VAXNnwOOh+lZgG6tgaTz8cejzBEmxrWsky4SsRvjGtV94vovumI6eC3A22g0ydTk9PnTiQa1vcUj52YO6Q9mbB2hoM2nyaYMr4ok8FzPXrh4LOnmKYqgJgwpA4mhM1hmMwAARR2Jtwri0QBusnusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 9zuUEuhiS2u9fs4wuRtosQ==
X-CSE-MsgGUID: uXuI3wSySFeG6qoSQ6KTeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56168376"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="56168376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 01:05:43 -0800
X-CSE-ConnectionGUID: QsnFHx4uQfeqwrK3u9sUyQ==
X-CSE-MsgGUID: VgOmDvEERiKD99pywuUZyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="117280074"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 01:05:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tJ7nm-000000042Gp-30cS;
	Thu, 05 Dec 2024 11:05:38 +0200
Date: Thu, 5 Dec 2024 11:05:38 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/8] platform/x86: serdev_helpers: Check for
 serial_ctrl_uid == NULL
Message-ID: <Z1Fs4j8g7uC-Cc14@smile.fi.intel.com>
References: <20241204204227.95757-1-hdegoede@redhat.com>
 <20241204204227.95757-4-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204204227.95757-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 09:42:14PM +0100, Hans de Goede wrote:
> dell_uart_bl_pdev_probe() calls get_serdev_controller() with the
> serial_ctrl_uid parameter set to NULL.
> 
> In case of errors this NULL parameter then gets passed to pr_err()
> as argument matching a "%s" conversion specification. This leads to
> compiler warnings when building with "make W=1".
> 
> Check serial_ctrl_uid before passing it to pr_err() to avoid these.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +		       serial_ctrl_hid, serial_ctrl_uid ?: "*");

Not sure about '*' as it would mean 'any', perhaps 'none', '-', or 'undefined'
would be better, but since they are error messages, it's not so critical.

-- 
With Best Regards,
Andy Shevchenko



