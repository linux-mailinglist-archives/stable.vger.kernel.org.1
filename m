Return-Path: <stable+bounces-213187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLnBDvnFgWk0JwMAu9opvQ
	(envelope-from <stable+bounces-213187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 10:55:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572CD7290
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 10:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8DE5300B448
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DD39A807;
	Tue,  3 Feb 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Upwx8GJy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077839A7F3;
	Tue,  3 Feb 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112484; cv=none; b=Fg8R4QgyoT+ZtGJXO7RKa2FffAcAbFxAhC0Mxy1V9GoM6ifHO76pP0fe40wUOazdrJwuDfbrFrX+346bNcrl8K1kHCC2pF1UK6fEoxcZabzxwtBXb3HzbmPT2WgLX43qieUDJoBnXoqj8evuAYI86uuSqaBMJo3hhUDKJei4nZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112484; c=relaxed/simple;
	bh=y5rSFPph6ZOlD8suEvnSJyWbUJlAwTCuj4psg7sVWiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX36sPNmZKuttknbelDPWVmltrNqff4aEevhEC+gkG+6pNA7XzaNaKJF7PFToktg59cIz07Emr8oVj4VuOpvDKIIoA85B+tI4DunNxzmMjDLxG2qsPTunj5BN+LTEHu2gpkFWgfCPnhsVU82D/fCyznHO2PCp7yV+mdNLkth04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Upwx8GJy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770112482; x=1801648482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y5rSFPph6ZOlD8suEvnSJyWbUJlAwTCuj4psg7sVWiw=;
  b=Upwx8GJygKukQdhxv89nkccHtL/31sfaTm+g4nBHywuh3T2Mr0Aav94b
   wCxAQgbm+U42W/SF6KVvBAHRnwe78VvEkzipuZp3ObWRgmNIPqublOR/q
   ETzpR9krQFNfzA1poSmXwXQ5O0/j5z3jmRM7mrvkO/BvLVohV9AL0ndD+
   ECFdx5VPPGfK2J+iPnQekY93jcSzE4Qbyyaz7nTD/OPAZxYkhPA+bgdo1
   0O/N/svjNT9eB2zeC45jmn1D86Tfpf5aWmWX6esSZSJCFiwjlc8IskKqY
   VSD8AyRqdK1AKa1pfAnqud0/Iqdqsa0aatZXTxhtpbj2/hRcANyq0mYtR
   w==;
X-CSE-ConnectionGUID: SUVLI6LNQ1a1ofNO7cLs/A==
X-CSE-MsgGUID: yxJQnjrtR0SEngQxwQX7wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="73874403"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="73874403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:54:41 -0800
X-CSE-ConnectionGUID: cFw4D0ydSwuPBfH+P3T/ag==
X-CSE-MsgGUID: mHP/9pZkRNaGNPNM1nia2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209817312"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:54:38 -0800
Date: Tue, 3 Feb 2026 11:54:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aYHF29ZR9mdi6Pqx@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-2-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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
	TAGGED_FROM(0.00)[bounces-213187-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 6572CD7290
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:34:21AM +0100, Oleksij Rempel wrote:
> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented
> in hardware (7-bit magnitude).
> 
> Previously, passing -128 resulted in a truncated value that programmed
> 0mA (magnitude 0) instead of the expected maximum negative current,
> effectively failing silently.
> 
> Reject -128 to avoid producing the wrong current.

...

>  	case IIO_CHAN_INFO_RAW:
> -		if (val < S8_MIN || val > S8_MAX)
> +		if (val <= S8_MIN || val > S8_MAX)
>  			return -EINVAL;

I still consider using -127, 127 is better than type _MIN/_MAX.
This is all due to '='.

-- 
With Best Regards,
Andy Shevchenko



