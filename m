Return-Path: <stable+bounces-211745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEMYCdCXeGkWrQEAu9opvQ
	(envelope-from <stable+bounces-211745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 11:47:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE5931DC
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4A1304DEA7
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD23446B3;
	Tue, 27 Jan 2026 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/jfU2uz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B66342C8B;
	Tue, 27 Jan 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510556; cv=none; b=BSE5Uy/LrVEXvfK45nMJFaeuXlHjh8A0XpS+SZ4CrtRsRx3qE9VkyPVEmHrLia4fQnCsy8sTpgHIIvc/gRj21cwVUFGyDidr703GGH91/T6WcosKqQIZ/2RDL0gY/pASGnHOqaeSb5UCzQ2EaYjfbvH3tzHHbc0mJtrNSUlm0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510556; c=relaxed/simple;
	bh=geF5sj/jmwdPWTxyB3iA1a2JfJu4BPJEE1G2d4A9lHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRgl29BP/3D7EGCxiyWEzkjajZe3hwTXESxCVolYrWq3yYVxoEL34fJlwS0xXC6TTnMHvUig624eQH8Rk7DXoNB7d6Qpe4ll8cZSGxHBwg5p7wHP2A7mEfzkrxx8n4aRJsQ5j/BzT4aaS+48gYIXSpiyhnVwiTl6J+XX8+PNafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/jfU2uz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769510554; x=1801046554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geF5sj/jmwdPWTxyB3iA1a2JfJu4BPJEE1G2d4A9lHk=;
  b=F/jfU2uzPeliUumg/v5cvqcJ8LdbFp7oCGi9bTh6bHxsJRzjzhgZW9nL
   qyiAcCk02simYgUxDqukchVuVUFac6+9tA6UFJXZlmcNx+p+9vNb6KPtL
   ncPjA0FHH3n1S6bgrQHYIiiqarTiP1yjFvm6xrGaqMICejQDo1k5uL/FG
   nLLgy/SSpeNhPOD/z6Fu9FyWgnDvI+RTMshhE6i9FXkDlGT9P/xlJkw21
   hp9fboibowNsGMvdSgiHrj5k4yGQX+lWB3HQ+rLXE6Rz1tbVYO0pzOv9n
   HD6OnDVyEotcHS1munlvTuf5Yv92OivjCguZNozazygGTJRXFp9y8CBTG
   Q==;
X-CSE-ConnectionGUID: 3fkg44pbSaCCXbbyh7IPmA==
X-CSE-MsgGUID: 20TewNRKR7qkbB7s9ctDcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74325558"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="74325558"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:42:31 -0800
X-CSE-ConnectionGUID: pqlJ3fqBTeCsCl+BiiaO5w==
X-CSE-MsgGUID: ct7ZOaZuQmG0IivPMXplNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212056489"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:42:26 -0800
Date: Tue, 27 Jan 2026 12:42:24 +0200
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
Subject: Re: [PATCH v2 6/8] iio: dac: ds4424: fix -128 rejection and refactor
 raw access
Message-ID: <aXiWkF04r7FkLPRx@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060939.3914006-7-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211745-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 7FAE5931DC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:09:37AM +0100, Oleksij Rempel wrote:
> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
> Previously, passing -128 resulted in a truncated value that programmed 0mA.
> 
> Fix this by validating the input against the 7-bit magnitude limit.
> Additionally, refactor the raw access logic to use symmetrical bitwise
> operations, replacing the union structure.

> Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")

Usually fixes go first in the series...

...

> +#define DS4424_DAC_MASK			GENMASK(6, 0)
> +#define DS4424_DAC_SOURCE		BIT(7)

+ bits.h ?

...

>  	case IIO_CHAN_INFO_RAW:
> -		if (val < S8_MIN || val > S8_MAX)
> +		abs_val = abs(val);

> +

Redundant blank line.

> +		if (abs_val > DS4424_DAC_MASK)
>  			return -EINVAL;

...

> +		/*
> +		 * Currents exiting the IC (Source) are positive.
> +		 * Canonicalize 0 to sink; datasheet treats sign as don't-care.
> +		 */
> +		if (val > 0)
> +			abs_val |= DS4424_DAC_SOURCE;

Hmm... Maybe 0 should be excluded as invalid?

-- 
With Best Regards,
Andy Shevchenko



