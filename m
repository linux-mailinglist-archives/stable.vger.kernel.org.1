Return-Path: <stable+bounces-233844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC9mD7E81mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:32:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FE83BB46B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B41304D5F5
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64039EF36;
	Wed,  8 Apr 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTNRzPXb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4A37FF64;
	Wed,  8 Apr 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647805; cv=none; b=hSNDCtOaz7VMa/LAUfH6X/E5O+UsWZTF8UkfOFNdbqbv9qRHKplbwZO2UeVSlyj2ajDqyMNq5xSjrywnhenqwfHIAchjDP418dhz56JWhsqyMZOSv74Ea50hhreH59xYwV2C87KKKqoyu3ZI5cg8uy5dC64+DqIXkbgEQS9HVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647805; c=relaxed/simple;
	bh=9oclhQnYC7G09VaWjQnm56KgPbwMb8s+YlxRrPQ96Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm/Xpp52WXuCg1jCRyQ6BxKkbduX4Sxzae70BRmq/6MPhmQ8GnaYoXxiLntmyzm2SMUOB8rbZhgJZZHT2jNIn0r6epWlSHrfGCLszyyWL0BARlAej9iRxUDQSlUNaQrjlhccSpw7AQKeq2OTgUQ5HPAXtUjCl0zwcgcAuLGOHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTNRzPXb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775647804; x=1807183804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9oclhQnYC7G09VaWjQnm56KgPbwMb8s+YlxRrPQ96Kk=;
  b=RTNRzPXb4T/aj99wi5OiGZawMf4bYf9Wwrxkb5V6ahZrdeM7m9a/6OkA
   yPaIdTPLGj2sdBp9JsMw4aSTxtsuuE+NrHtaJQ40V1BFVY9Cv8EiuBFEJ
   RpdvQk0OYduIazCR03F2c6RXhHF4w3Y1wCW7UuVvgPiX3V3dg8q83JzrH
   V2kSLaGph7Fa4R4TXZuRbPCVPsV2rfde7pRBqqTcRlnrvdgx1XdPD6dFp
   l0fv5omn55o6JEe1uy7fPrKy+n3gZPJCRyes9l6UH+zrBsDPrd43vMKQZ
   wlH0WB4KdrAmtVKo1znxhHZscT+aob6S+pErsIPm5A0YwS4PjohV2YKmc
   w==;
X-CSE-ConnectionGUID: MTHf2SJnRsytnhlBq6ZZ1Q==
X-CSE-MsgGUID: w07NzjTBQXCpidcDfR0O5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75797930"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="75797930"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:30:04 -0700
X-CSE-ConnectionGUID: PgS24hczTOquocZhYbgSSw==
X-CSE-MsgGUID: 8Zec0KbXR5W5RxX6SOzObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="227440553"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:30:02 -0700
Date: Wed, 8 Apr 2026 14:29:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <adY8N2sofhMz-6ih@ashevche-desk.local>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
 <20260407160809.48d5fe2a@pumpkin>
 <adYCyvTlIoTdnKcL@pathway.suse.cz>
 <20260408100425.7231966a@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408100425.7231966a@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233844-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,suse.com:email,ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46FE83BB46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:04:25AM +0100, David Laight wrote:
> On Wed, 8 Apr 2026 09:24:58 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2026-04-07 16:08:09, David Laight wrote:
> > > On Mon, 6 Apr 2026 12:32:32 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > On Mon, 6 Apr 2026 11:21:39 -0400
> > > > Tamir Duberstein <tamird@kernel.org> wrote:

...

> > > Even having the KASAN/KMSAN code compiled into allmodconfig is a PITA
> > > when you are trying to check that code compiles to something sensible.  
> > 
> > This does not look like a good idea. KASAN/KMSAN are very useful
> > features. People will want to keep them working. Removing them from
> > randconfig would just postpone detection of the problem. We would
> > need to deal with it sooner or later anyway.
> 
> True, but when I build an allmodconfig build to check how the asm looks
> I really don't want them.

Isn't easy to disable that in the command line to `make`?

> For the 'bot' builds you also want to know whether they are defined.
> Changes to how things are built rather than what is built can throw
> up unexpected warnings that are very hard to pin down.
> 
> It is bad enough finding things that affect one obscure architecture
> with a specific compiler version when the compiler just makes slightly
> different decisions, without having unusual compilation/config options
> is the mix to muddy the waters further.

-- 
With Best Regards,
Andy Shevchenko



