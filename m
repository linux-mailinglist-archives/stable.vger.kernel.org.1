Return-Path: <stable+bounces-249360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG1fJdBbC2oCGAUAu9opvQ
	(envelope-from <stable+bounces-249360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56973572557
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF46E301A153
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36C38A720;
	Mon, 18 May 2026 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJSPPxBz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D338657A;
	Mon, 18 May 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129114; cv=none; b=gtwAuDpJL2/zQPwScecQI23Yol94SiJHTQ8hOsXKvl962oPlFHcyKYCx08fU6/VNEpPTZUP5D18q/baiXKydlpiR0kf6KAzu/Zj8h6lcYqRT0OQwTuJMq/phJyIYGhMiejdN9hxVQIpySzvaoat4+/gbt1bYdXM5ecgGBNvlxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129114; c=relaxed/simple;
	bh=agUT8Mpk+dy8irIoWlm7UzBAg+qJnb8pUPGuEVZ5NvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPvrIRZiG3msuZWNaqPnPbHTULH1gGhW0ODATTmoP8fGYaekti+s9nuaOjUqOk28QkX4yqULyyTpaS2TK6uhuTb8f5e7KGYOIahIqTQBb9U7ZgM/eLM2gQtcPcf8AcRa6rLQcfZBYgw1JUgZ+qebXtFjUqGjRTLV8fF0LZ0bMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJSPPxBz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779129113; x=1810665113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agUT8Mpk+dy8irIoWlm7UzBAg+qJnb8pUPGuEVZ5NvQ=;
  b=mJSPPxBzpmFzqd7/7c9+XKh/e3dbwPktwbrTiMy61Ff8Rdb7I5ewfK5r
   /qvuWzcc3GtyaAFf/74JyugR0Ka+w1YGyNOrAO1uQ2bxrVVtyFeQUYSv8
   IdCSYH6Pk0ib+eMShoZscWXAcdImTLpW/I75LuDCUWskxB4T1M5kECQp1
   HB3985jw5ERMGgbGYgyRn5ofMWvzMwHF8dhqPCa4pWKannyM1dtK6+F/4
   TQesk8D5CfYKiOAOJAWIeTPfRiReoc9VM+HOv8Japzv7+Mc49eG5l9rRR
   cdJKuA4MH0BRT+Ohkjwr5MTqDEYkzMui6aAXFhNVqFGKIFiy5tjuQOlHd
   g==;
X-CSE-ConnectionGUID: hil9mQ6tSlekvSuMhMavUA==
X-CSE-MsgGUID: 4ujVF/+oQ+yUNmdCaAbl3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80111813"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="80111813"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:31:52 -0700
X-CSE-ConnectionGUID: J3D55b7RQkGsSXFj+aXtFw==
X-CSE-MsgGUID: Sxq1+rIoQ5GKeaKswBrA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="263290263"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:31:50 -0700
Date: Mon, 18 May 2026 21:31:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <agtbFDbw2m9ptEua@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
 <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
 <agq4zER5Tv2LErZV@ashevche-desk.local>
 <20260518155521.6c61504d@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518155521.6c61504d@jic23-huawei>
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
	TAGGED_FROM(0.00)[bounces-249360-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 56973572557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 03:55:21PM +0100, Jonathan Cameron wrote:
> On Mon, 18 May 2026 09:59:24 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:
> > > On 17/05/2026 20:12, David Lechner wrote:  
> > > > On 5/17/26 11:08 AM, Stepan Ionichev wrote:  

...

> > > Maybe it would be better to do something like:
> > > 
> > > void iio_trigger_poll_nested(struct iio_trigger *trig)
> > > {
> > >         int i;
> > > 
> > >         if (!atomic_read(&trig->use_count)) {
> > >                 atomic_set(&trig->use_count,
> > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);  
> > 
> > Just in case somebody is going to do that, avoid doing atomic_read() followed
> > by atomic_set(). This is typical TOCTOU issue. This should be something like
> > atomic_xchg() or atomic_add_return() or something like this in a single atomic
> > operation.
> 
> Just to clarify - the current code is fine.  This got reported a few years
> back and I did the analysis to prove it. From what I recall the key is
> that the state space isn't as complex as it immediately looks.
> That counter is either non 0 at the start (we don't use it here and we
> skip an interrupt - that's actually the desired behaviour if the trigger is running
> too fast - triggers must survive that - reenable() callback is there to make that
> all work).
> 
> Otherwise there is a single path that sets it and we know any decrement until after
> that happens would have undeflowed (and hence was a bug). The rest are decrement
> only and it can never go to less than 0.
> 
> Hence it is fine.
> 
> Agreed things get messy if we make this alg any more complex though!

Perhaps we need a good comment just on top of this atomic_read()/atomic_set()
pair. Because it's really the code no one should take as an example how to do
atomics :-) Logical question, why do we even have atomics there? Shouldn't
be that READ_ONCE()/WRITE_ONCE() to have an integrity in place? (This I believe
even mentioned in the documentation for atomics.)

> > >                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
> > >                         if (trig->subirqs[i].enabled)
> > >                                 handle_nested_irq(trig->subirq_base + i);
> > >                         else
> > >                                 iio_trigger_notify_done(trig);
> > >                 }
> > > 		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers didn't
> > > */
> > >         }
> > > }
> > > 
> > > to prevent this class of problems once and for all. But yeah, wiser minds
> > > have designed this - so let's hear some other opinions as well :)  

-- 
With Best Regards,
Andy Shevchenko



