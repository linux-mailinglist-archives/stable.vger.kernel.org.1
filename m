Return-Path: <stable+bounces-232560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C7PDv4UzGmGOAYAu9opvQ
	(envelope-from <stable+bounces-232560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91637018F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835C13064F00
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102238C41F;
	Tue, 31 Mar 2026 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv9isq+7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629138F236;
	Tue, 31 Mar 2026 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982054; cv=none; b=eMQcPax7wAq6ucKUuHjF8hIn/MAiIznSZNga6RFf3gtHPpE51vA1rjta30sxBy3QAxk3CT7P12YuO0KpjfIAdyUB4j4PVr0Wifam8chm5yv6MHzW7KFIUoYRI+mxFn5HeA9F8zIDaoAxmbHbhIgAY7Fg8UZz2hk2QJORQd232Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982054; c=relaxed/simple;
	bh=AOvvJg2c99YB+rv+783KEYYx3SIQ2xhq7kWHp8iA5xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgyydyzDDhy0eFiW3+8x8n4jfsbOhW2cQ1o8VhQviFvLivx6yoTQL/TlTI3L9mBHJIyhEYMX09H4ncQzlmdsNNKzHCqSPh/On1SHJYYgYUY7Q7FwsLc+3mus/SP5/sivZ0BRLzY6TH8CrTsygKQIF/c8KWRZiRkpgYp4qKbWSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv9isq+7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774982052; x=1806518052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AOvvJg2c99YB+rv+783KEYYx3SIQ2xhq7kWHp8iA5xA=;
  b=Mv9isq+741v5C337vf0ScEyglMoS77ZQ5PsPawMmd+TTD8/dIS/7V1l3
   PViCtFtNmE+2TaU1GMTSkYJXjEFAGd5bcWttE0gQ4vnGvPLXBbu9Q9dBK
   Rfin+VKsnIQUHOp4mXPLW2SObNwvq3OapdBLLxe3HoRouGY842sz6/u6Y
   th3LO6OHGe23eKSpKpmKOkzp9tMXhIQiL06i3PKoJl9rsDOn406F0QHoT
   x8N4RQ6vLxY6NUZjnUsAeE/nrt70IkfXKmFvavA6jHS6+kOht5ZIsiVvr
   LsyIqFDfSx2+ZUMF7a6BdRb8tLYIXOeTIzuFFZ3cH2BRRGYhInkOrgYfe
   w==;
X-CSE-ConnectionGUID: H27guJGWTOu/VMhF02grEA==
X-CSE-MsgGUID: /cReE1M4QEqmk3o0iBzhLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75040889"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75040889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:34:11 -0700
X-CSE-ConnectionGUID: DnCx56Y0RDSWlMnG4zuXnQ==
X-CSE-MsgGUID: w+8P19cLRCSOQOP7eKHspQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231250471"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:34:08 -0700
Date: Tue, 31 Mar 2026 21:34:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <acwTnoz0aFs_xCyO@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
 <acuT8oTnaYujC0k6@ashevche-desk.local>
 <20260331162635.2d8c7f70@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331162635.2d8c7f70@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232560-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 8B91637018F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:26:35PM +0100, David Laight wrote:
> On Tue, 31 Mar 2026 12:29:22 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:

> > > iio_multiply_value() passes integers val and val2 directly to abs(). This
> > > is problematic because if a signed argument to abs is the lowest value for
> > > its type, then the result is undefined due to overflow.
> > > 
> > > Cast val and val2 to s64 before passing them to abs() to avoid this issue.  

...

> I've just looked at the 'work of art' that is abs().
> What is wrong with:
> #define abs(x) (sizeof(x) == sizeof(long long) ? __abs(long long, x) : \
> 		__abs(int, x))
> #define __abs(type, x) \
> 	({ type __abs_x = (x); __abs_x < 0 ? -__abs_x : __abs_x;})
> 
> It is just as broken for u128.
> It will use the correct signedness for char (but it is unsigned now).
> It doesn't cast back to char, but that is entirely pointless unless code
> looks at the type of the expression, the return value itself is always
> promoted to int before being used.
> 
> Actually replace the -__abs_x (UB for INT_MIN) with the safe:
> 	(unsigned type)-(__abs_x + 1) + 1
> and the return type will be unsigned with a correct value for -INT_MIN.
> (Oh and the compiler sees through the mess.)

And this is definitely wrong. We must keep type, because abs() might be used in
the comparisons with signed or as parameter to multiplication or division where
sign has to be preserved.


-- 
With Best Regards,
Andy Shevchenko



