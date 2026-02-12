Return-Path: <stable+bounces-215935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBLKMwipjWkK5wAAu9opvQ
	(envelope-from <stable+bounces-215935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:18:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67E612C674
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22D5F3017E31
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFF2EB847;
	Thu, 12 Feb 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji8DxQAY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A32D77E3;
	Thu, 12 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891358; cv=none; b=k+agMuZqg5kwb8hntwsEXqB66u/iuKoOdOVfACFmDzjs+iQ8ZowwBCXmdSGVjLXHCaZYAOZH+14QfC0BFdigMWGpGk7RIPbpPDoMlTd/8l3/Uz3ghzOOOW0VVnwN8aK0e59E9B81RENGYU7iFtELm9zfGF8sHRvHClO/UM1ylK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891358; c=relaxed/simple;
	bh=Wk89nFUepuSXaXCGvF8acoSpbg0D5i8pnzVyOgeRsro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9yiCNlZS/AAdSS0TEw02OSArMUzmI5LosN2raNfSH85cBV43POy7P/SBb87/Et8ym596tSzLyFc5AzKt8Ehbx7JxAre5Gpv9E3vd9zfBYn/IC9CftgpXESn7DE2Te/lHw8OVPXsWmtG40n4whm15/jlcZl2pgG0GL2YubyEgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji8DxQAY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770891357; x=1802427357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wk89nFUepuSXaXCGvF8acoSpbg0D5i8pnzVyOgeRsro=;
  b=Ji8DxQAYrjPq42bYJ9vxcYYGBk2FMGdtNDeavH+cPZGxKQFh11GptjCK
   sSKspGek5aFccmtRF7oIsv4vPmUHYR8GXissRTGuD1CbxS2k6QQVnNH2G
   pA/vCTWzjA0WBo5bCoOkA2ZVmSdRZtG2jhCnahlvG3MGJ2UWoIWwL/MYN
   6orx60zXz09kGojXVISETVSMuaKJ3aGlEOCgbHHTWDHoL+wfWE6rEAuGx
   y67HOzQY85UGt2kJX8b8S7q/ytTiNVKplnpzgc4DwijXMZO2gWzjukFJ4
   yTOXTNczzRzwIhwwXjxaY/b+Vq77AzxuAhGFYDhbESxbDGO220X7fhhTo
   A==;
X-CSE-ConnectionGUID: DQgkvj4IRV69nGR5CAsLfA==
X-CSE-MsgGUID: FUJKXL0FQwq6MESJgW9nUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72104976"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="72104976"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:15:56 -0800
X-CSE-ConnectionGUID: M1pIBHV8Ttm5cMtvCOqfJg==
X-CSE-MsgGUID: cEy5DnNZS4SO6lSjS0EdHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="212582397"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:15:53 -0800
Date: Thu, 12 Feb 2026 12:15:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Alban Bedel <alban.bedel@lht.dlh.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lennert Buytenhek <buytenh@arista.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Maximilian Lueer <maximilian.lueer@lht.dlh.de>
Subject: Re: [PATCH v3] serial: 8250: always disable IRQ during THRE test
Message-ID: <aY2oVjCL21wL-8aE@smile.fi.intel.com>
References: <20260209113207.2118445-1-alban.bedel@lht.dlh.de>
 <5964c41f-ddd3-406d-91b1-62fa33364163@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5964c41f-ddd3-406d-91b1-62fa33364163@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: B67E612C674
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 09:41:08AM +0100, Jiri Slaby wrote:
> On 09. 02. 26, 12:32, Alban Bedel wrote:

> > commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
> > has been set up") moved IRQ setup before the THRE test, so the interrupt
> > handler can run during the test and race with its IIR reads. This can
> > produce wrong THRE test results and cause spurious registration of the
> > serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
> > short duration of the test and re-enable it afterwards to avoid the race.

...

> > v2: Replaced disable_irq_nosync() with disable_irq() to prevent interrupts
> >      that are currently being handled
> 
> This made me to check, why/how this is possible. It appears to be, but only
> thanks to:
>   205d300aea75 serial: 8250: change lock order in serial8250_do_startup()
> 
> And the change should be documented in the commit log. Especially to avoid
> stable backports to trees without 205d300aea75.

There is a de facto tag Depends-on: which might be used here.

-- 
With Best Regards,
Andy Shevchenko



