Return-Path: <stable+bounces-219917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EDmOFcuoWk/qwQAu9opvQ
	(envelope-from <stable+bounces-219917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:40:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C31B2F0C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83CA4301ECE5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68703D9033;
	Fri, 27 Feb 2026 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxqMJHjZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C413D9025;
	Fri, 27 Feb 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170834; cv=none; b=pIx5rffCDQhsbrBNfmQ9iXdav3itv5A7K6mY+HwEejmFioUe9T/6WsKDMMYBklTesjluUN0txD2TYgOBLupq5NdFm3jD2PI8vxQ1avDiniNJv2DpsquKBRfGkrL1xBuO5p+dJ7x8p08xB8EZy4fdZOBdEv4caS2GMcZwCUo47tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170834; c=relaxed/simple;
	bh=cosoY1zjVWdZThnph1ieOBFWix61RCNTOSPQDJ/s1lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjssEOiRGQRiAE91THpD3deUcGWVDPOpLfyJ9s0WiuIuM/g7qYBut2EtBibmeL1Zq9IMzlNuHHO9RfY1mWpO4uLM2rT7/zYcDgRlEbJ1vjTjkhzASiYO1dcL4oYoFfnCpZziainjYVHgURfNADZ6XgaoP8EiRjcVdlGFU2mfJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxqMJHjZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772170833; x=1803706833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cosoY1zjVWdZThnph1ieOBFWix61RCNTOSPQDJ/s1lU=;
  b=kxqMJHjZdMyAPZnfmbzqtcyMPNUzWJJwmnQn+s9VE4DHAMQmxW/s/Vxa
   hykpVh1qrIhzAIqU57DTTey9yv7/gZwd0LAj4CeQRXAPuDahYR9CKDoAM
   bGGxw64UK4JkUHBVYuQ3kAZoMzwoQQ7lkAb744rQHFlixSQZrr55BD2Wp
   T0D7JKmEEu5f5Pmbq6JKYH4PUKeoN1+UmxozJ3isnYrcFYLD96fxizfLy
   OlRuSIJJhPHizHYZ1IpciNWTVkPxOW+e+Wxz/HgnPpzKb+0X78BKXzJRq
   wDhDhK+eNLUNYzGIjIavEiIfMwm9MVTOIBPxQTq5AeMp50PTZz7qAXKLL
   A==;
X-CSE-ConnectionGUID: Mqr9FTYeSTe7fhSb5tH9EA==
X-CSE-MsgGUID: G45vj8JzTwqtk+PxNJHcWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73293858"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73293858"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 21:40:32 -0800
X-CSE-ConnectionGUID: c4aTQJyURQCdTsOfFbiCcw==
X-CSE-MsgGUID: KINS5bfsQ16FvTRb14NCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216910562"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 21:40:31 -0800
Date: Fri, 27 Feb 2026 07:40:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Brian Mak <makb@juniper.net>
Cc: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <aaEuTBBBU0PWz04e@smile.fi.intel.com>
References: <20260226224511.458065-1-makb@juniper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226224511.458065-1-makb@juniper.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219917-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 510C31B2F0C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:45:11PM -0800, Brian Mak wrote:
> Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
> does not overwrite the of_node with NULL.
> 
> This allows MFD children with both OF nodes and ACPI handles to have OF
> nodes again.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



