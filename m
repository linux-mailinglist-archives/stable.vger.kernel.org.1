Return-Path: <stable+bounces-267974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iZsOCGuuOmqMDggAu9opvQ
	(envelope-from <stable+bounces-267974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 18:03:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123C6B88A3
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 18:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gV4oizqV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267974-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267974-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8533056684
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C330CD92;
	Tue, 23 Jun 2026 16:03:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A72305968;
	Tue, 23 Jun 2026 16:03:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230626; cv=none; b=gGZHU9KY85/pKjGROwl3QWKdsUmHib5wCCqvYHRTLuD8d+k6EU5nsd1E+EWBnq2IlG4/aPmltUNuy78nkPge4wH/scNgbk0e/+tcFN/sEk3UBEGidntsZQP3Rgp4s2yX6iAfV15WjQnj0mL+urx7S8fDqNDHn48Ulwcm8pKTGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230626; c=relaxed/simple;
	bh=M+yrv/rttnRC9SUCDZi67uEy7XqdBOsgEDrOYVtOu3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvyculpmCIk+StLihZQPSIux69VsbZbtBKw85hDicytGaNBSGA6oW4wfOihVf0U0Y4xpWpzdAgXMO0CaG++4fvgavLLrFR5jRLnfC9K5mTnlnhfUhniJ0dub3Ap5NaebkxClu3SpWZbRqMCNLOwZJUVzoy4AWpjHpOOpqSIrp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gV4oizqV; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782230624; x=1813766624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+yrv/rttnRC9SUCDZi67uEy7XqdBOsgEDrOYVtOu3k=;
  b=gV4oizqVvG2NEbvG9CJYzi11kCBNc+4vvqRnwEkUrDOdTaBIOiC/U8XN
   ccY0iQ9V6Nde47XxO6t0uEgGIzeDd0aczrmt8C438oBTkQAP/7QspyDQ/
   dM/nw5Ps/kXSWhlwX9H4C+JG9sftrk1HfEl9F/5CpquevhqCoqt45BiFX
   fa0jTHNUS0B4aR6mtSQYAbvYnB63Xwpo23gYpNWstszqcnBfoOKeXrT2h
   5KP3vsZ0scE0nifm1pqGDJBVb6huB9VOPZIE41g73aBFbbQNQOz0Xnjxn
   CY09iB+46LXqRwNtzQ3o1OQ5dp1C2VLJXHt1N6UWDHiw6/yRKyjfgxpGs
   w==;
X-CSE-ConnectionGUID: mLAwNsEWTnKoPBbrj9lsdQ==
X-CSE-MsgGUID: StyCjNs+QYakQ9qGaQMJfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="70494256"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="70494256"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 09:03:43 -0700
X-CSE-ConnectionGUID: 8FOrKmyKRmaCoYnKQLu24w==
X-CSE-MsgGUID: +eHckxSDSTqkMUHlmZae5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245187256"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 09:03:40 -0700
Date: Tue, 23 Jun 2026 19:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	fourier.thomas@gmail.com, 2426767509@qq.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: pch_uart: add check for pci_get_slot()
Message-ID: <ajquWkPABcxOVQWg@ashevche-desk.local>
References: <20260623140539.2272473-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623140539.2272473-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267974-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:gregkh@linuxfoundation.org,m:jirislaby@kernel.org,m:fourier.thomas@gmail.com,m:2426767509@qq.com,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:stable@vger.kernel.org,m:fourierthomas@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,qq.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1123C6B88A3

On Tue, Jun 23, 2026 at 10:05:39PM +0800, Haoxiang Li wrote:
> Add check for pci_get_slot() to prevent a potetial
> null pointer dereference in pch_request_dma().

Not that it's quite possible, but probably you found this due to AI review
which might have considered some cases of manual binding a PCI device to any
PCI driver.

Given that is the case, I'm fine with the change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



