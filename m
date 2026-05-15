Return-Path: <stable+bounces-247635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOUvDtT0Bmo4pgIAu9opvQ
	(envelope-from <stable+bounces-247635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933854D4CA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA05030361A1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587643DA22;
	Fri, 15 May 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1XjzH1k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3540629F;
	Fri, 15 May 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838679; cv=none; b=cIT8WWuptlr2MjvkKeCJ/FcNh0CkSt8cMJXwI0RjqDESkqxqwNLfLA5YN03sVSozeR3HBxXRdryUtVuLJodgpWL32R6HJaQ3Nz14bWTfe8vnDYXgiWGemwVvgpLGattiVO+rGHP2MdJBrsp0HzyzcG/FR8q74/u4I0yqgQ2nHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838679; c=relaxed/simple;
	bh=qiAZjKX/MURvn7xBRGhLK35fpkW2b8CBt6CjfRs7ioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdWtEzm83UgP0/JhNx5597N3asswuJHOZrsLOm/kA1QwbYUW1j2xRfi6zHgRWIU3WxUDOhnTdcXawK3dRkqeGv4um2Za6GCa1zcoREUb50gY5UFWvkFOHQZ4GaYsvMULWAQMfAO8nrzWotJhZCCE8PFiQ/Rb/Ez6Xvhx269Tj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1XjzH1k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778838679; x=1810374679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qiAZjKX/MURvn7xBRGhLK35fpkW2b8CBt6CjfRs7ioo=;
  b=b1XjzH1kTB1VJKAyp5bqHH0fgYKb2F1AQc1lTHsZZjW1zYT/kDelFyTL
   KpK8YL21+8i0g5uJF9eB8bxMT3CyAry3b0SwNdqmnZ9WhiSOxBSVZ2Vqq
   bPIu8SMpyOJGaL4VLwssqMddpkGbOmXwb7Vs4oKXGoq54151+uKRjx/Py
   pYFOUkMkiQn/GXkfJHcUObeqoGl4ZHf9byT3t9myo94JlHzS42hfBGYj5
   Icyhz8a///pIua1k/RxvTQRza+TLtZoUPJrs/sG6z7j2+rI7o/FkqAnWH
   lHYsKYBKJiz+OSSdtGdtlnFsz2nF+DgLuCjTb6M9hosjKEJEEmRgy5RNy
   Q==;
X-CSE-ConnectionGUID: mApK2+xrRbqE6qcj/Sj1BQ==
X-CSE-MsgGUID: +I6Ml1reS6Cs11uj+To1iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79834912"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79834912"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:51:18 -0700
X-CSE-ConnectionGUID: Ip8wcBmVQbeQ5pTed9DXDg==
X-CSE-MsgGUID: sGNThLzOTXKyDJkhLHLyQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="240459884"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:51:15 -0700
Date: Fri, 15 May 2026 12:51:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
Message-ID: <agbskYwLK31PCnhG@ashevche-desk.local>
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
 <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 3933854D4CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,parrot.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247635-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:00:17AM +0200, Joshua Crofts wrote:
> On Thu, 14 May 2026 at 13:38, Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> > -       if (ret < 0)
> > +       if (ret != sizeof(fval)) {
> 
> Hmm, Sashiko pointed out that I am comparing a signed integer with
> an unsigned integer, which would result in type promotion and subsequent
> mangling of any potential negative values... will fix in v2.
> 
> https://sashiko.dev/#/patchset/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf%40gmail.com

See my response. That how it should be in your v2.

-- 
With Best Regards,
Andy Shevchenko



