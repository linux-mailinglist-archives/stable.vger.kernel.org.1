Return-Path: <stable+bounces-211965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMtnMkQLemk82AEAu9opvQ
	(envelope-from <stable+bounces-211965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:12:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51059A1DD7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 134403007957
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08B349B0F;
	Wed, 28 Jan 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlL6Pkc3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29531355C;
	Wed, 28 Jan 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605940; cv=none; b=U9Sv1CeUgwAZu3JfNe3GZgINUHRsiZtimoSNH9SoO4pPDWjaQoPx4oHjNE42ScHKIvz2BKZt8e7byCJP1DAFpYYBFkfTScbGXWGzn1GonhFjaRWQ0Lz+3zXv3YCNEd94HdssbF53KTNtjxdXpmrAayTQs8g6foWlwAmeQLNOydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605940; c=relaxed/simple;
	bh=caMJj5MeXWu40BTtO1svNq6KPU22GmNvoXPFEBVKB20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eel/KJVGuryihIbhkpH1sf6E20plu1F04Rf6iT9a1JwsEbEvNwrn1z20Bo1ACGo355qgFTBtVdFnucRyvlifi8fWRqoXXgkR9doWBUbwnImXuVLVtV9JinYDjZfwhJTqJcUsvlWOmQmE0/XGo6voim3pPR1WhDkliKylCledpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlL6Pkc3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769605940; x=1801141940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=caMJj5MeXWu40BTtO1svNq6KPU22GmNvoXPFEBVKB20=;
  b=SlL6Pkc37N3qzBhiLdtKoZVx/Q0OB7yetjYH0XZkC8Y6YYinUY5rtP93
   wg0fEIkHUhHv/VOhwpvt3LdMTIQFWxpT6ONT7KbQHQBmL6vFKDhEwm5NA
   94Lf+uUTFQTo8mY25zBHCNG3XMO1kWgV60Wlwyw+/V6Uni5mC4is19neU
   xQzw5aKfAQCQqbHGE0bNvaKQS0QeYh1yEZoYcBaDfMBn8IAtC5yV4PSZZ
   KoymJZd/nO2K5oAqgYqRTVWtWfxzx6Wa03B1VqvoC3hLo8yYHOVdvbu0U
   v69K3MGuldxovVXLHff1Y9/nh31Xs1y54ueGBFa4yb+QVpP6lD65Y4WA7
   g==;
X-CSE-ConnectionGUID: hi3sUG5cRwesQuwL/biixQ==
X-CSE-MsgGUID: B3FGsmTFTMOzaOY9J3CcsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70716351"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70716351"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:12:19 -0800
X-CSE-ConnectionGUID: DlRy0w6cTXCBeNHBC4xmIg==
X-CSE-MsgGUID: +dp6+yVLT6ayjqdD5Av3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208501745"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:12:16 -0800
Date: Wed, 28 Jan 2026 15:12:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] serial: 8250: Protect LCR write in shutdown
Message-ID: <aXoLLq17mWtGzZU7@smile.fi.intel.com>
References: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
 <20260128105301.1869-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128105301.1869-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,163.com,arista.com,intel.com];
	TAGGED_FROM(0.00)[bounces-211965-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 51059A1DD7
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:52:55PM +0200, Ilpo Järvinen wrote:
> The 8250_dw driver needs to potentially perform very complex operations
> during LCR writes because its BUSY handling prevents updates to LCR
> while UART is BUSY (which is not fully under our control without those
> complex operations). Thus, LCR writes should occur under port's lock.
> 
> Move LCR write under port's lock in serial8250_do_shutdown(). Also
> split the LCR RMW so that the logic is on a separate line for clarity.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



