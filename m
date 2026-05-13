Return-Path: <stable+bounces-246986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPRzKTq6BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3F538578
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 831B230087E1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649B4DBD76;
	Wed, 13 May 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DekB4VFO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06087327BF8;
	Wed, 13 May 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694679; cv=none; b=diRi84yfSZg4nU/4yDoDLAL0GRFc67JiBGJd06cm+N3cggo0InTu6iAxjv1CP4FdSt/enVlVWco+4C0AurSnd6SOjtuxqINcaskQAOocBzGAG+1QlSnBfoOg7XpUHFTnu050yn3nYXGo7anoiihyojMrxz4HRoakTpO+EqLTXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694679; c=relaxed/simple;
	bh=zrd1NYBQl6ccVmOdqd7dePf7qdGGzxyFkgLDK/Lw9KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=groL1qUSagLhfYweZcs4cMHJUK5VW9T2bZ+R6NKF6UTuj+JO+drCWPH6/CX8XWnAs1haWdh6taP+tr4E7xz3Vnpkvk/ragNavwBw9cHron/+kPL0V/M3MaSyoDi56RB/UfZ7zQLW32UkS37Mdk/pDW/8kZAVM1RIpQfqS9fnSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DekB4VFO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778694678; x=1810230678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrd1NYBQl6ccVmOdqd7dePf7qdGGzxyFkgLDK/Lw9KY=;
  b=DekB4VFOoH3ApqazNBN2oHq30xRNyB+G2Gi1yGcmddNgBg0VJPTnb+9v
   iFT5QRzHwHUFDLkMi/8tsUAt7EuWjTsGQqM1cVd1gvNF3coR8eVHSK95n
   mSLADn5IKvV8BA6HR6qLbc5iPg6Y56UmRIzrfK7KqX1CqFoyHEyGASHW9
   +K3BVyLAhB8UJAkbL0xNyijckBvQHcvIZ5jQ+zP6D7EdchYX2WaeyNOb0
   emh31tubb+vXTmluoCbdZfU2Lueq0P0IOOh3M5Va0rNsgIgM01Di5cO5Q
   XZ2xn7LRw43RXylRLmVIE/liytBSkMTokvoSKADjb2I7fV/N5JOnBcz0u
   Q==;
X-CSE-ConnectionGUID: F6jyyyOXSaufFCb26Kz56g==
X-CSE-MsgGUID: wofvEb7ISmifR0fUNHMv1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="97200517"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="97200517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:51:17 -0700
X-CSE-ConnectionGUID: kgmlUvT8QHmKaku41LsYiA==
X-CSE-MsgGUID: zrX0KErsSbquxiYcvd7yXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="268485989"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:51:15 -0700
Date: Wed, 13 May 2026 20:51:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacques Nilo <jnilo@free.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: 8250: fix BREAK+SysRq dispatch on
 guard()-locked IRQ handlers
Message-ID: <agS6EG8hd0E6DI5u@ashevche-desk.local>
References: <cover.1778592805.git.jnilo@free.fr>
 <cover.1778675349.git.jnilo@free.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778675349.git.jnilo@free.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 2DD3F538578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-246986-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[free.fr];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:30:22PM +0200, Jacques Nilo wrote:
> This series fixes a silent regression where a SysRq character entered as
> BREAK + key on the serial console is consumed by the kernel but never
> dispatched to handle_sysrq(). Same description as v1 [1].

I have read the v1 discussion and v2 makes sense to me and looks good
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



