Return-Path: <stable+bounces-269961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FHHwJM2uQ2ogfAoAu9opvQ
	(envelope-from <stable+bounces-269961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:55:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 028156E3E10
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 13:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=N95sYqlI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269961-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269961-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8660F3023DB4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F97407569;
	Tue, 30 Jun 2026 11:53:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2040627B;
	Tue, 30 Jun 2026 11:53:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820421; cv=none; b=C3hlN6N6HXH7fEE67v8X2K9FQ2tyLi8iEF0QkEy7o9SyJgMRcwVNwuNVmTDD3mNXSy9AsYCgk9LvIkvasaX8/MnX7OhC88CgTi5vWc3xkIeOJgkRA4Hz1W4iZyqQhw3DpsLCH2Mir7NrUH7wVLjvHNnM6LidgQX9p3srLoj7L10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820421; c=relaxed/simple;
	bh=HHeUzys9SZo4sXJXwBYEOYegZzAOleiFoxqxV4KVsUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atrBSgt0GK0XTU4/VXnKO34dxafOYUa8O5bV7WNExeBSEfIhvvHP8tjyp8ZizsklIHJobkzlXTjAYY3usZ4eN8HEbEswL3LSEuUMQv0ZEaT95EZldWwwuNb47I2mznvWebZLklnvkx8Jz9WFIvJf+5n4Adq5x/bLOXSe/W9U+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N95sYqlI; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782820420; x=1814356420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHeUzys9SZo4sXJXwBYEOYegZzAOleiFoxqxV4KVsUA=;
  b=N95sYqlIcdWsKyi8Wwj9FSbmqjGRWu1HNJyPFWjEsQM9KZ6EwxOVMLnr
   oE6S2x2tU11XtAjhgQa/9PyqyLQGgR6jG48Ub3QRGNIqZLrkHDdqa/s2y
   17pMKdk0SOFuimdxL8vrYve5mfXqup0jKunjDAdUFJKpvyRgTmU2osO20
   3SJRViL0oeb0fNne6zkP65PIs5l42vI91Al0kllIkUvL6BZHf7L1+k7tc
   wtk/BzYvl3c5iL2D5giZPC1Br450LDOQcxHTrCOxiOn5O/EDgy9XgWPYP
   5cyn2IPLgCA19xASErdGsVNNdHKyZOu7+2WLlwQfDdc4rK4A/ceqk/J34
   w==;
X-CSE-ConnectionGUID: L/qS6vz8TJelXaU+2foZog==
X-CSE-MsgGUID: CttWor74QAeYzONEJyqCgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="109080376"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="109080376"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:53:39 -0700
X-CSE-ConnectionGUID: UseMqb4hTouQba8inFEEaA==
X-CSE-MsgGUID: OQAo9beZS6SkUijWaWBaZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="250556196"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:53:36 -0700
Date: Tue, 30 Jun 2026 14:53:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Timur Tabi <ttabi@nvidia.com>, Dave Airlie <airlied@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Ben Skeggs <bskeggs@nvidia.com>, Kees Cook <kees@kernel.org>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Mel Henning <mhenning@darkrefraction.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
Message-ID: <akOuPQ37-zxIJWWH@ashevche-desk.local>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629224350.2870201-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269961-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lyude@redhat.com,m:nouveau@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ttabi@nvidia.com,m:airlied@redhat.com,m:maarten.lankhorst@linux.intel.com,m:bskeggs@nvidia.com,m:kees@kernel.org,m:simona@ffwll.ch,m:airlied@gmail.com,m:tzimmermann@suse.de,m:mripard@kernel.org,m:mhenning@darkrefraction.com,m:dakr@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,nvidia.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com,suse.de,darkrefraction.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ashevche-desk.local:mid,intel.com:dkim,vger.kernel.org:from_smtp,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 028156E3E10

On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> 
> It turns out this looked like the right fix on some systems, but it's not -
> as this causes runtime PM to actually fail on many a laptop.
> 
> [I have set the fixes to an older commit then the one that is reverted
> here, because when applied with the other patches in this series, this
> appears to /fully/ fix runtime PM in addition to the regression]

No need to have this in the commit message, move it to the comment block...

> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")

I'm not sure, actually, that this is a correct approach. You can't revert
something that never appeared (in time range between 53dac0623853 and
8302d0afeaec). Have you consulted with the stable kernel process documentation
and/or respective maintainers?

> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---

...somewhere here.

>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 8 ++++----
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        | 2 +-

-- 
With Best Regards,
Andy Shevchenko



