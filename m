Return-Path: <stable+bounces-262193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 66B8FHy9J2p+1QIAu9opvQ
	(envelope-from <stable+bounces-262193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:15:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0365D164
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 09:15:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WFpakDu1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262193-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262193-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53AC8301A2EF
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342F3DA7EC;
	Tue,  9 Jun 2026 07:15:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67B3DA7EE;
	Tue,  9 Jun 2026 07:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989300; cv=none; b=tGOSSO99wPTpDofk/PMt/1we5h2IGdB/qr8A+Ee/VsY7EkFv4KosmvpPvabfH49mq9lj0b1d89R+pPzkvDj95Q+x7RkOfZFnowIqaYIwKeeWveP1BjtNsZOy8ROSNsNVJuBqcGPyDicBVCVkgELrDtyJfVdJ3gkQtKxp9O6uiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989300; c=relaxed/simple;
	bh=2qu81oasOVE9oPvab2zZBXtjwJyxu88n0NTYxYVTBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH96JoRoYEDZP4CPfANucq2cZr8DxhqJ4LYK4KDk6S6YR2UcB+wwsnUL/xdhSufdNyGZRqsI6hunCRbyOoLGcnpnN4hm/SYRTHMFLZSnvfocxuD0gcAsykmzsT3PBa0w2bN7M+i/k5AzQXJpBtrE9ZqGot3inXDkAd58jZyOYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFpakDu1; arc=none smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780989299; x=1812525299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qu81oasOVE9oPvab2zZBXtjwJyxu88n0NTYxYVTBeI=;
  b=WFpakDu1q7hza3mtAX0qR4r+kEi9gp0inCMFG1jb1WNcSPnMTcEOjPLr
   +VM7rtcgiUWHWf7Xwgb5TMt0U4p/7xVOPaQMQ277jqRzqiJgIs3d8Z8ih
   SZqEg+OQvDjMuDRgr5RWw1EdMf2sa+/KVdR9KyZjK8qsLgjmMmBEuLH18
   XXWzuEulsds4Su1PPJqHC95DbOSzKo6n/l7oDMXUuVLLn/PfJtS22CDYg
   siyjlQN5K1wqMYZvzIhyuI6q30Yxfz8reTeSYN3wJ0YIDxSvvNryHrlfA
   TVvJ8vOUkgcyocNNR1fj9E6IPKUYCLHquVGIx0R/7EhwyU6aXNSmx7ctw
   A==;
X-CSE-ConnectionGUID: riru4tfpTciiQ4iLmvuhQg==
X-CSE-MsgGUID: MUtBuIr7TGybRKGJfdBv/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85365658"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="85365658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:14:59 -0700
X-CSE-ConnectionGUID: bYIz3a1aQoqRuhWtVUyaig==
X-CSE-MsgGUID: NjQINNlqT06cCOW38m5ijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="243343826"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:14:56 -0700
Date: Tue, 9 Jun 2026 10:14:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikoloz Bakuradze <nbakuradze28@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Khushal Chitturi <khushalchitturi@gmail.com>,
	Archit Anant <architanant5@gmail.com>,
	Minu Jin <s9430939@naver.com>, Kees Cook <kees@kernel.org>,
	Hans de Goede <hansg@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: avoid NULL pointer dereference
 in c2h_wk_callback
Message-ID: <aie9bqpiNDJ_IU0M@ashevche-desk.local>
References: <20260608190700.85755-1-nbakuradze28@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608190700.85755-1-nbakuradze28@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262193-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nbakuradze28@gmail.com,m:gregkh@linuxfoundation.org,m:khushalchitturi@gmail.com,m:architanant5@gmail.com,m:s9430939@naver.com,m:kees@kernel.org,m:hansg@kernel.org,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,naver.com,kernel.org,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,ashevche-desk.local:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51C0365D164

On Mon, Jun 08, 2026 at 11:06:58PM +0400, Nikoloz Bakuradze wrote:
> c2h_wk_callback() allocates a 16-byte buffer with kmalloc(GFP_ATOMIC)
> when the c2h event needs to be read by the host. The existing guard
> only wraps the read step, so on allocation failure the loop body falls
> through with a NULL c2h_evt and dereferences it in rtw_hal_c2h_valid()
> (via c2h_evt_valid() which reads buf->id).
> 
> Restructure the check into an early continue so the rest of the loop
> iteration cannot be reached with a NULL pointer.


Not sure if we need any Fixes tag. kmalloc(16) won't ever fail (otherwise
the system is already in the state when nothing can help).

...

>  			c2h_evt = kmalloc(16, GFP_ATOMIC);
> -			if (c2h_evt) {
> -				/* This C2H event is not read, read & clear now */
> -				if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> -					kfree(c2h_evt);
> -					continue;
> -				}

> +			if (!c2h_evt)
> +				continue;
> +			/* This C2H event is not read, read & clear now */
> +			if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> +				kfree(c2h_evt);
> +				continue;

It's too verbose way of saying

			} else
				continue;

here.

>  			}

-- 
With Best Regards,
Andy Shevchenko



