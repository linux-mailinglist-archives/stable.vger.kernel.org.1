Return-Path: <stable+bounces-213194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLQLBLDhgWmDLQMAu9opvQ
	(envelope-from <stable+bounces-213194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 12:53:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BDD8A15
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5377F3030B19
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB033A9E4;
	Tue,  3 Feb 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwJjMnHr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90922339;
	Tue,  3 Feb 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119587; cv=none; b=pGjP+gLuTwdn8HXQbCqGCwd1/WBSjx0lN559jd/3hxtqMd45adFmT//2A6zZEI+v1Da72wfACHXUJUyXvIpilSiL4QHrCEkH0RQ3f8emHgX0G414iC/+CDkmPXl+PhpURZA+iJ9vO4m2t55/YQefLIFBVdQ57FgOPVPgaiMRq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119587; c=relaxed/simple;
	bh=+Cv82bqvFKaJG3yiPoUug7CoIWqw/Hg7MAUS9jZ9UN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2OQii1epqxUn2B8WH+EHsXUdogZUeuNYnDM4j124UuN2dOzICXkEYPJmejxye6hXqZEOyI4rKqoSGCb/2XrhHH8xmC3afNs8asjjHjt5zGOayJguANVGC1v9LbpKQ/2i6HRYy2MT5g+s2P2tTR7xmb7uO383/rPzzpqhA0qtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwJjMnHr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770119586; x=1801655586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Cv82bqvFKaJG3yiPoUug7CoIWqw/Hg7MAUS9jZ9UN4=;
  b=SwJjMnHrhkp3iy97zWa1ohr29hGUozfJH2nZK2ncB1jq+FgwCUQZhENg
   M/xzStI5NK8WLuI5fItGBp1eF/Mjhm65K33n94wOFLI7128s/SogeEDb3
   GGoX/QYvRklNyxudTRcy5lV0yf/LwUIxV6C1wNlKrOFU7NGoZ0vOm3u+b
   kmkquINkwkUvMwhImqoW6wHGRVQCNm//xIdqiRaw63FJDi9SGTSgrlvhI
   bTP8QLOOFisKfVV48Jzc4kfhhoUI44cL5eWC+DC5mdZ3IAryGBAekufmq
   Z9H2wtu6U8vDflSkmls4MMk0s8NCtf8PVKfMWksiKRWnNrqDkAx4VeEl3
   g==;
X-CSE-ConnectionGUID: jU08Vi8uRqi14QoOuVFkew==
X-CSE-MsgGUID: PePXCSl3QiaINVU3E6RO1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="93940225"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="93940225"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:53:05 -0800
X-CSE-ConnectionGUID: EE5CKyI8SHaMopnW+BfB1Q==
X-CSE-MsgGUID: 9irpcCcFQCWik0iINrUH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214786053"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:53:02 -0800
Date: Tue, 3 Feb 2026 13:52:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	kernel@pengutronix.de, David Jander <david@protonic.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aYHhm03Jsv0zsyZ0@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-2-o.rempel@pengutronix.de>
 <aYHF29ZR9mdi6Pqx@smile.fi.intel.com>
 <aYHN3YfKCgEnAfD5@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHN3YfKCgEnAfD5@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213194-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B1BDD8A15
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:28:45AM +0100, Oleksij Rempel wrote:
> On Tue, Feb 03, 2026 at 11:54:35AM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 03, 2026 at 10:34:21AM +0100, Oleksij Rempel wrote:

...

> > >  	case IIO_CHAN_INFO_RAW:
> > > -		if (val < S8_MIN || val > S8_MAX)
> > > +		if (val <= S8_MIN || val > S8_MAX)
> > >  			return -EINVAL;
> > 
> > I still consider using -127, 127 is better than type _MIN/_MAX.
> > This is all due to '='.
> 
> The use of S8_MIN here is intentional to satisfy the requirement for a minimal
> stable backport, as requested by Jonathan:
> https://lore.kernel.org/all/20260201144226.218a43cb@jic23-huawei/
> 
> This patch: Strict "Fix only" for stable. Uses minimal logic changes (<=
> S8_MIN) to avoid introducing new bugs during backporting.
> 
> N++ patch: Full refactoring.
> 
> Can we accept this temporary state to facilitate the stable process?

Ah, if it's request by the maintainer, I can't and won't overrule it.

-- 
With Best Regards,
Andy Shevchenko



