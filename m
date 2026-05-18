Return-Path: <stable+bounces-249249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kW4QGWbtCmpU9wQAu9opvQ
	(envelope-from <stable+bounces-249249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:43:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037556AE1B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D723B3010665
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A83D5227;
	Mon, 18 May 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PllpDq6R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9653340286;
	Mon, 18 May 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100962; cv=none; b=EUUtO5SVbByrZ5+waGz1p6Ax9MNgmPfLfx67+Aw0a7OJAlX3TnN0YWbQZPTACYVjKDlZTwqdrJnxvZV5OXO86fNlpX180B3NANXqfmiTeVNVMFkW6iEl/LfC53upl4tKWwg0XiFBK9zmuegtpaHvxgcobANJwRf2CwRDjBTbIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100962; c=relaxed/simple;
	bh=r1PVGf1rr4njrmbO5ueph0W/8kJGaLaf/v+erQVDj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLfjAmn6u02hVxqKtVK3TZGFneO/oj4ygX6Rm4KYzK1yuNivcwWDysREjp3YkMLdD3zL4B5pYOdA2SmF51H0mVEPNjK7M3S55cZSglEDGl/NFZSdO7M9KeAhi/8FervwAtLOKeHDgmV6K0VBr4guHaWgNFJePnVwnasLeE7qs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PllpDq6R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779100957; x=1810636957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1PVGf1rr4njrmbO5ueph0W/8kJGaLaf/v+erQVDj3M=;
  b=PllpDq6RqP5BvqjpUKam0DcAsxxLSqVQ0PwC6vK/RtHBAr9xfN6gb7ZU
   hOo8ZKYCsuxw66roUdzmGdSGZOS36NKC/9dar/U3PwtlwZ3RktuHex8Rz
   RjuND8IJgKXqhrplqovf0cx3ytJ9PiHkZQIpKjiQ0YmWQ50KFMY2GiffT
   meXXHzKXXKHujbzEJqaLlCqHIzorCBCUg9vJS9U0e19mFvGulAnIt1Dh4
   AWyTWM+2Y6ake7pOxKi3aYyBgYrs/zyzKeM+0VfQxAEvLrKztC6Xat4tp
   LkXWMFrelTJJPRDUM5PFLq+RlCKo4KQ5yQMZrrnar9TuJxMA8JLYAXefF
   Q==;
X-CSE-ConnectionGUID: IKrNdqP5TZaVT+7SWtdqeg==
X-CSE-MsgGUID: G4fRoKqEQUCIyOfrhHOLTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79999385"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79999385"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:42:32 -0700
X-CSE-ConnectionGUID: mEUjukxRRhGM+xtGNpMN0Q==
X-CSE-MsgGUID: TJDmR4IzSOaf9c5sZE5RvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239471393"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:42:29 -0700
Date: Mon, 18 May 2026 13:42:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, mazziesaccount@gmail.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
Message-ID: <agrtE3refLIQfICE@ashevche-desk.local>
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <20260518094238.1986-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518094238.1986-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 0037556AE1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,baylibre.com,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249249-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 02:42:38PM +0500, Stepan Ionichev wrote:
> bm1390_trigger_handler() returns from three error paths without
> calling iio_trigger_notify_done(). The success path at the end
> does, so on a single transient regmap or read failure the trigger
> use_count is never decremented, and the !atomic_read(&trig->use_count)
> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> The buffered-data flow stays wedged until the trigger is detached.
> 
> Funnel all returns through a single done label that calls
> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().

...

> +done:
>  	iio_trigger_notify_done(idev->trig);


Maybe it's better to make this as an implementation and wrap it in something like

handle_trigger_irq()
{
	bool result;

	// that returns boolean and doesn't have notify call
	result = this_old_function(...);

	iio_trigger_notify_done(idev->trig);
	return IRQ_RETVAL(result);
}


-- 
With Best Regards,
Andy Shevchenko



