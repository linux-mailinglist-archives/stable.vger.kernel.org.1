Return-Path: <stable+bounces-238269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDQbL+KX4GlMkAAAu9opvQ
	(envelope-from <stable+bounces-238269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A9640B4CD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7723045646
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FA318B85;
	Thu, 16 Apr 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5nTPOgV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043A2701BB;
	Thu, 16 Apr 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326621; cv=none; b=TAArxAJKK5is1ORaVs17k1zW8czO8NFioIdfsM4Va/1mKMtBnfN+CMoK/q/yjJ0MPY1TcZCUoTWxyE2Dh+dce9PHK6dLCmWzeeRPE18/+i9yk/lCyxE2GyYmRgMOkABBj+7dOIbU+Pk5sV6tY8D8G8TbxB6pJLVLksPCMoLlp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326621; c=relaxed/simple;
	bh=yZw9iQqdQFGLs9E14Uhc+ABsrVj6P6Qwp6mM8nQTYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX3yBJS9bZ+YKTZN8HNwNjQZ/Tvk2767GqJhXEH+pFoinZLB21HbXn0zgyutP0ATRr1Kvka0C5D3ct9h+TISNnLQqYYIi2ZCDF/fS8VIXKltT2aftaVlLFrjN7TOfUjBL/Y9aXLGcplrI0PY0OPvjAkBswT1sIqAXhddq1AXdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5nTPOgV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776326620; x=1807862620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZw9iQqdQFGLs9E14Uhc+ABsrVj6P6Qwp6mM8nQTYzc=;
  b=I5nTPOgVINQuTFuZe5g7Uy/96DnofRDSpLfwQNGfg2d7sQpf5EIp4b1l
   F+1MVQCcI1uQUlwNDPaY6Wzx1RMEH7Jhe8JIjSeqGYS7BXdc9pQjLvfDd
   iVGtBn+49NPpcXEGJf4d6bzLqSXVjVfrIsCa1ViHaL1eSo7lbGUrOP2ss
   Vg5R1rvLCLLliWqq7ot4gXEQCEfYLLmVZ+TNQ5DWZwPmePy0Yf15gXi8u
   /m3TiN6TvgZxO0MOHiJfY7BewQABJANK0kZF9YrVIbC4/PwbsOGpPtL+E
   SxnEpY6pcz9ikUQ6J0Qq9/JnBaik/05pu3ZaGjKijS9ZMCqNCbPetlfR1
   g==;
X-CSE-ConnectionGUID: WN5oI05DR2KMUlnRhxj/vw==
X-CSE-MsgGUID: WWgA5xdPSLGGeTiy/PkCwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79903295"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="79903295"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:03:39 -0700
X-CSE-ConnectionGUID: yFugkF4jRKK0TpZ+8grNJA==
X-CSE-MsgGUID: BbU0WXX2RhuLaX+E9VqbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230912743"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:03:37 -0700
Date: Thu, 16 Apr 2026 11:03:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel_scu_wdt: fix reference leak on
 failed device registration
Message-ID: <aeCX1m_RMbSYXG8R@ashevche-desk.local>
References: <20260415180042.3648360-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415180042.3648360-1-lgs201920130244@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-238269-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 82A9640B4CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 02:00:42AM +0800, Guangshuo Li wrote:
> When platform_device_register() fails in register_mid_wdt(), the
> embedded struct device in wdt_dev has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
> 
>   register_mid_wdt()
>     -> platform_device_register(&wdt_dev)
>        -> device_initialize(&wdt_dev.dev)
>        -> setup_pdev_dma_masks(&wdt_dev)
>        -> platform_device_add(&wdt_dev)
> 
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



