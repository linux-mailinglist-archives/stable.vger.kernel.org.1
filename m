Return-Path: <stable+bounces-230605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKPIHJhGxmmgIAUAu9opvQ
	(envelope-from <stable+bounces-230605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:58:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745A3415E6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F2BE309D752
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5413D9DD6;
	Fri, 27 Mar 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbYSLisq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3C3D9045;
	Fri, 27 Mar 2026 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601696; cv=none; b=JHJDuWZ+F9m+D5fx/CSwmzOfn3QHV3i4g33jfJNSVqdXufV0vCBNsP9MGEnzbrJOkdb2Za/h2WU55M2p+B2PP6+Plh2Ay+rbcepTkB0uwYNCVhT3Uz3EgVJgpDzrgxdJEVhXpM+p23vABC8xUqfTZoQ36c/kKotCjL8z0ubEzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601696; c=relaxed/simple;
	bh=GT5s6SukjMZBZVEPM5ZT8q2nEZACMQgI+mtZ4XZWFMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8TLoG08xllyYexE1cUuUxWBXcfhaE3EVQAVLd9mFHqRgNjhO4D9O+MNXZxAzAs/ms10CeH64QbqmXJ33w/JyZbzfxn7CmLIDCmno7sdjJxkAZnHXXOTewNS7WsOy+TXzkZApwLKHEBhoN/hfdMmLnpUKLRoofrbVe2dw4cE3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbYSLisq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774601694; x=1806137694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GT5s6SukjMZBZVEPM5ZT8q2nEZACMQgI+mtZ4XZWFMM=;
  b=gbYSLisqCV1zqvOry6ABxJdjkQBSYa0J4t4+nI9E4yVMEguz4w9i7nRn
   0CDBtfIQFONoTj6Hpv5ql6YTRnShF3skNe+tepnTAge880wCcMkpIY0AL
   Wrq/aBWFNXdSOd8rKA7WTEWsPsZ4VZxCRUu52OTK9HFjbIRwSB0TVK8W5
   vAtXCtqQDCLypC55cM09w+OsG3kXZzzZnYBreKs4odk3ptl8BCQ3KhM1I
   z32aMg30T3CUE7DAkPaLig5SeO4AcZZiC1KGnL9YOBkApMZufVOT6NQ8J
   Wa7nwnWf/TPWIyPwEn9GsrOrUZfVXxLFgkaZpsCS1s0gBDWAiBL8Ur78J
   w==;
X-CSE-ConnectionGUID: JLKvOQueTlivp9FMU6E9dw==
X-CSE-MsgGUID: gu3DG+rATSa7ypheedRKmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75386697"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75386697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:54:54 -0700
X-CSE-ConnectionGUID: WuY9rM5aTSOLyJKZuw5YLA==
X-CSE-MsgGUID: 9gOiy6CPRXevPJwTJfN1Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230185947"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:54:52 -0700
Date: Fri, 27 Mar 2026 10:54:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: line-display: fix NULL dereference in
 linedisp_release
Message-ID: <acZF2YSN2C5cinTi@ashevche-desk.local>
References: <20260326171412.1109402-1-lgs201920130244@gmail.com>
 <CAMuHMdWY=pjuLvqU2baRsetbOYf=cFF_y4PsJ0DxH_zTGfx8ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWY=pjuLvqU2baRsetbOYf=cFF_y4PsJ0DxH_zTGfx8ng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230605-lists,stable=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[linux-m68k.org:query timed out];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: 2745A3415E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 09:10:50AM +0100, Geert Uytterhoeven wrote:
> Hi Guangshuo,
> 
> Thanks for your patch!
> 
> On Thu, 26 Mar 2026 at 18:14, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > linedisp_release() currently retrieves the enclosing struct linedisp via
> > to_linedisp(). That lookup depends on the attachment list, but the
> > attachment may already have been removed before put_device() invokes the
> > release callback. This can happen in linedisp_unregister(), and can also
> > be reached from some linedisp_register() error paths.
> >
> > In that case, to_linedisp() returns NULL and linedisp_release()
> > dereferences it while freeing the display resources.
> 
> Indeed, the attachment is not yet or no longer available when
> put_device() is called.
> 
> > The struct device released here is the embedded linedisp->dev used by
> > linedisp_register(), so retrieve the enclosing object directly with
> > container_of() instead.
> 
> True.
> 
> > Fixes: 66c93809487e ("auxdisplay: linedisp: encapsulate container_of usage within to_linedisp")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



