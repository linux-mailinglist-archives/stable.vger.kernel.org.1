Return-Path: <stable+bounces-249197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCxfERy5CmqY6gQAu9opvQ
	(envelope-from <stable+bounces-249197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C98567160
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7FEC3037DF8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8A3DD847;
	Mon, 18 May 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arS+deuH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB13C5540;
	Mon, 18 May 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087570; cv=none; b=mrEhjLFuKpT+U2Sdvd5EowIHJbHARgoMOkRAlOnzFsNB8oV5F7u9JsfekusqFyFrvSeeIN6o+FzF4SQf4UC9sfDIxJoO2gsPgJodLdpFqburBuYsReBvEJY7K4MNCLoOKVMKBfY9BuGhP2yMAvX6/Khv9nDid6iZ1UMUHDm12sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087570; c=relaxed/simple;
	bh=MRfE5/LUDhTEYZ8g4L1S7n1skYm6+yv595CZqpvZZmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbZVKbr25RUt2Y1c3fsA7UQoF0iwYyzVKonU4YMeKEnn01qAlyeKWGqGdIu1Hy4KCbGgmeKTZ+jw7UCej5Q5W5htZc6ZqSiHm94pYMlQTETpM2VAZeEJiNVTOhUGv4UnbSA+RzhnnzieTHCsDOyADdg5OS/ANni8YmJkcSCKA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arS+deuH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779087570; x=1810623570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRfE5/LUDhTEYZ8g4L1S7n1skYm6+yv595CZqpvZZmc=;
  b=arS+deuHQcgb0Txxha7Bth+MzRrDEofW4c/Q/qnjbt/tummP3QY9iLkP
   iW9UhswW4POt2QUhVcf3nYZaJe397lA1nYhhoEj8h8x2tl+npXBmflm3X
   dLXdoITakN7P3uNjRwvFq4a/hMuu7I9/EIcRZisL3wYaBnai1F454maaY
   rS7G60K8v8G0piz5L3cLjI2fopfBI5KB7SKgID4s9U3YmvVVy4m8TMZIR
   pB/+K3bmCzZ459Jms0yrMrAk1PfS4F+FLtk719HPn2Fhg/hDkpQQqeaOi
   oBhnNoUOpwCaSHKP2i0QWR6YBHQcg5Umk4b5iJgELr27Nb+d342bqMcN5
   g==;
X-CSE-ConnectionGUID: pz0/KG25QjmbXLLTQ69hnQ==
X-CSE-MsgGUID: WhJQ+r4gRH+AwyDopkZ7rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91392798"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91392798"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:59:29 -0700
X-CSE-ConnectionGUID: MAmUauDfSHK69jrcuQx7Kw==
X-CSE-MsgGUID: GSigaf4rTfuiGWsxvPWKeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="269680734"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:59:26 -0700
Date: Mon, 18 May 2026 09:59:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
Message-ID: <agq4zER5Tv2LErZV@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
 <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 55C98567160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,gmail.com,kernel.org,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249197-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:
> On 17/05/2026 20:12, David Lechner wrote:
> > On 5/17/26 11:08 AM, Stepan Ionichev wrote:

...

> Maybe it would be better to do something like:
> 
> void iio_trigger_poll_nested(struct iio_trigger *trig)
> {
>         int i;
> 
>         if (!atomic_read(&trig->use_count)) {
>                 atomic_set(&trig->use_count,
> CONFIG_IIO_CONSUMERS_PER_TRIGGER);

Just in case somebody is going to do that, avoid doing atomic_read() followed
by atomic_set(). This is typical TOCTOU issue. This should be something like
atomic_xchg() or atomic_add_return() or something like this in a single atomic
operation.

>                 for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
>                         if (trig->subirqs[i].enabled)
>                                 handle_nested_irq(trig->subirq_base + i);
>                         else
>                                 iio_trigger_notify_done(trig);
>                 }
> 		atomic_set(&trig->use_count, 0); /* Clear the use_count if drivers didn't
> */
>         }
> }
> 
> to prevent this class of problems once and for all. But yeah, wiser minds
> have designed this - so let's hear some other opinions as well :)


-- 
With Best Regards,
Andy Shevchenko



