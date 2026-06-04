Return-Path: <stable+bounces-260278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f3VNKTUpIWqU/wAAu9opvQ
	(envelope-from <stable+bounces-260278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 09:28:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93863D9F6
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 09:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cY4DGOhs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260278-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260278-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7886A3011070
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C7D3DDDDE;
	Thu,  4 Jun 2026 07:26:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078ED3D3016;
	Thu,  4 Jun 2026 07:26:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557969; cv=none; b=I++tR6a25J8QUUQdgHNpbQ6iJg0mj6cAzs6BN4p4Q3oTWQLntjl13Llm1giwHDBP+MX+6my7cfqawaPvIpF/vb/06y8xT/Lb/SCEESshmQvOVM+8K2WhrTYhq8GOGgiST/6qzVlJ2mR5LAb5uvGPOYYHciHkwpYauTo7l9/O82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557969; c=relaxed/simple;
	bh=9lfqJqs93hN9YXKOtmekrFKtsKQCcKLRN8VXdLaQfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEM6N+zETMV7ygK1US/UVmF13FV2jmWqtLdSvVjvv0y6xI++A84rl8NmXDQbUt335kRp90+xL0n0MUoPLrYnZfI9bdlnUePR5nMmYlQ73+k3x8ae9fCc9vhFQUEAHlTckpxZNVG3EzT+ItmRNMY+T4jE9cCZEA3tFp6oUidufoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cY4DGOhs; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780557968; x=1812093968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lfqJqs93hN9YXKOtmekrFKtsKQCcKLRN8VXdLaQfMI=;
  b=cY4DGOhsYLC2cgId8UAd8RMvDYcANcIuJjfWFgiQ/JiGoJekDb3OFkua
   6Q/jVrGqjeG0JyOZdbUBUcZLM40JXba+JenIRiL+biqiBGHVcJGU43qd4
   XNZfxRdjIGYQ8/WV684EutqEcQCockmNacylLKbT1+94RsL4xe9EHcT8Q
   lBaVJZHE42IGBgxkGQMs0BBIYfBT3P8IG8MKc8/SEBwDHwh7AcnCz7SU4
   Zy1l1hU7Quq9r1L6mez+iTLdgT/NzRgQzDrav/pEhT/+lvqNK3ASFjosx
   /2vRE/E3WuyM3e+aOkHmxOdEMrJzvhzn1PcL0WVaOtNiIMsFfWJN/9mv0
   Q==;
X-CSE-ConnectionGUID: fGmM27QaQqOiz9NP+MBo6Q==
X-CSE-MsgGUID: dxMU2ITQQmeAGiEBDYqO4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85233316"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85233316"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:26:07 -0700
X-CSE-ConnectionGUID: u4lclCPPSU+lSYE1YK7C9A==
X-CSE-MsgGUID: 3yPvoYTtRf28rpL9VvQj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282575058"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:26:05 -0700
Date: Thu, 4 Jun 2026 10:26:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
	joshua.crofts1@gmail.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: return actual error from probe
 IRQ failure
Message-ID: <aiEoilRNQuHR_dqb@ashevche-desk.local>
References: <20260517181042.668-1-sozdayvek@gmail.com>
 <20260518094311.2000-1-sozdayvek@gmail.com>
 <20260518163647.3b4966fb@jic23-huawei>
 <20260518164309.04ed238f@jic23-huawei>
 <20260603182345.5fdb66b5@jic23-huawei>
 <aiEoULtZmGpDd3cy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiEoULtZmGpDd3cy@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jic23@kernel.org,m:sozdayvek@gmail.com,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:hcazarim@yahoo.com,m:joshua.crofts1@gmail.com,m:gregkh@linuxfoundation.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:from_mime,intel.com:dkim,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D93863D9F6

On Thu, Jun 04, 2026 at 10:25:09AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 06:23:45PM +0100, Jonathan Cameron wrote:
> > On Mon, 18 May 2026 16:43:09 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 18 May 2026 16:40:48 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > https://sashiko.dev/#/patchset/20260518094311.2000-1-sozdayvek%40gmail.com
> > > 
> > > Does completely removing dev_err_probe() here drop the deferred probe reason
> > > tracking?
> > > While this patch successfully fixes the return code, dev_err_probe() also
> > > records the deferral reason in debugfs via device_set_deferred_probe_reason()
> > > when ret is -EPROBE_DEFER.
> > > Could we keep the diagnostic tracking by returning the result of
> > > dev_err_probe() directly instead?
> > >         if (ret)
> > >                 return dev_err_probe(&client->dev, ret, "IRQ request error\n");
> > > 
> > > Andy, what do you think?
> > Andy?
> > 
> > This is a change you might have asked for, but sashiko is correctly noting
> > that we might loose a deferred reason even if the print is otherwise useless.
> 
> Incorrectly. IRQ core prints an error via dev_err_probe(). Did I miss something?

I'm referring to implementation of devm_request_result() in kernel/irq/devres.c.

-- 
With Best Regards,
Andy Shevchenko



