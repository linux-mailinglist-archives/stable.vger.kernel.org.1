Return-Path: <stable+bounces-224733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP6FI9OlsWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:26:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6803268022
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43C830C8435
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0D30F7EF;
	Wed, 11 Mar 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGUnUuJb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AD31E840;
	Wed, 11 Mar 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249646; cv=none; b=Yq7d3CFNeenAKa2zZGECWReGsCXDT6FwtKZAou85JjZFi6yQoOIJhIoFsdy9QSFW53i5yf16GiihxdpEMgVhdGcWuLmvgJ+fwmZEoW08J3FIFeRRl1VGKIOKJQ2tiXE7AO9A7+c7m5GDJan9X0uONMK2HgHD4Nm3c3bRgyqCnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249646; c=relaxed/simple;
	bh=twgDOJpvWAo5mNLxiO1CB5wxevRtT3Abbq6Fg3vltjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwOoJA1XzjxLpZZvxHurqVPbb2TkWFce+CQLZJTFtjx6qTUQ/rU/+l9wph8JA9IBivlNENLolk0f9Ax5ikvkLXeQbyGhVrvbwQsg1txKFvxzK0WzGAjfGdHEu9BgM9735wU3cOAVjIQ+D1YF4gpp9VsXmXbkPJx0iYrF9Ekn6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGUnUuJb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773249642; x=1804785642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twgDOJpvWAo5mNLxiO1CB5wxevRtT3Abbq6Fg3vltjk=;
  b=jGUnUuJbCpa1qRctdAr8Ry+cPxmH2crz032OFvKkRtilA7wXCVqR5fDh
   w57gd3++vr7LhF53eOTxx/eTLZKtTKCB1LGUHcXlu+3X0jiD1x0+hzmMG
   fe+f+sYA/UND9YoHu6mCDt7UcgJEbHGZBsU2xw/6js1CMi4kohZgQCoXK
   97FLCvah3WbV6it2KQIWuS0lPUAeQh5+efAqYYh4zsvkt2UjD1d50Anh6
   Gfy5iK2zAHrov2BHFZDDy+0MD93mwAemr5LYoSp8yRXfjiYUC0qWgehXm
   auleBKB7bZYs4yGruHFdpIr4pazIQWx+9TpJmSUr/GdSYufOHTguexTUQ
   Q==;
X-CSE-ConnectionGUID: wVBD5ncwSQGRLXxQFrrEiw==
X-CSE-MsgGUID: /6Lcd7LhR8O7oU7ocZ98WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85414839"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85414839"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:20:40 -0700
X-CSE-ConnectionGUID: EaytoBPhREWbG89letDfUg==
X-CSE-MsgGUID: d1AZGjp3QT647HpZ0+sr5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220483992"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:20:40 -0700
Date: Wed, 11 Mar 2026 19:20:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <abGkZdpsUat7Jo4j@ashevche-desk.local>
References: <20260226224511.458065-1-makb@juniper.net>
 <20260306133806.GM183676@google.com>
 <aarmKE49wgbIblRb@ashevche-desk.local>
 <20260310092148.GE183676@google.com>
 <aa_xriW62F2j3Cpu@ashevche-desk.local>
 <D6FA2D4C-EE9B-4B30-BE9D-A00F83D4C19F@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6FA2D4C-EE9B-4B30-BE9D-A00F83D4C19F@juniper.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224733-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D6803268022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 05:00:45PM +0000, Brian Mak wrote:
> On Mar 10, 2026, at 3:25 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 10, 2026 at 09:21:48AM +0000, Lee Jones wrote:
> >> On Fri, 06 Mar 2026, Andy Shevchenko wrote:

...

> >> If someone is going to do the work sometime in the near future, it can
> >> stay as FIXME.  A few releases isn't going to offend anyone.  However,
> >> if we're just going to sit on it and this is likely to be here for an
> >> elongated period, it should be changed.
> > 
> > Then better to be just a NOTE:.
> 
> Ok, should I raise a v3 patch, or can this just be changed when applied?
> I'm okay either way.

It's better to have a v3 with a clear changelog why it has been changed
(changelog, not part a commit message).

-- 
With Best Regards,
Andy Shevchenko



