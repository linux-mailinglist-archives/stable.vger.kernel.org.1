Return-Path: <stable+bounces-231372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CVwHTWUy2nMJAYAu9opvQ
	(envelope-from <stable+bounces-231372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82F367162
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167EB305A4DB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF43DEACB;
	Tue, 31 Mar 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLYDA2cM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDD3ECBD6;
	Tue, 31 Mar 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949369; cv=none; b=tvPRV/xJTqYTMUApTqTN1M5mhlfosDU5eWxSrz1YJftaFC1rXviJZ7VZRTrWibXTFOlR9vAKkNSQfMBg1Bo6OCkikyAQ9s8cLxnkG/M0ExEkLB7qRjbGznM7sMrTLavY8c41s4JQ7LEDy+EiHuMYg4jBvlgDZ7bMlbX+sDwga+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949369; c=relaxed/simple;
	bh=fwr53LcXapfNYFdQOzSQs0hCpIcAeop5V1lml8hLIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKm3OeJh1FjtXbHoHLYyXguXhCRZWunt3VoxBAp5Y2QuVrA7hW3HOpTF4gTXjKq5cYRJafFHHjwABC1rYkPG0F0/ZC3sVmJ3NzITdgTWp5DLePDsoSXAHjcKGN0l0MZKtxNvXxX53w79qmTwGq7PbBjId80wojW2eLh564KjOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLYDA2cM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774949369; x=1806485369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fwr53LcXapfNYFdQOzSQs0hCpIcAeop5V1lml8hLIlI=;
  b=KLYDA2cMylisukLFEzmh2zSg1mzAs3zL5Wu5l3ISTsgyIXlZzOo2CJ2N
   5D3qD1XMiLXtGSuLtZnsJGF+bOpLWO+XovKNwYAF56tn6AA/aflOpWt12
   k4/brwwfwy2pUP2zUAJZn8mV59aD8fjXtco74muePINDF5ig5Icq0vCUC
   q64Oxid5GJUU9SoK8ZzMdv8N9TZ+4Fjotrx8cjbEP0oNBRWWneKG3Qz3O
   NstFvQGGD87Cvr1qbTU+uvqWsn7DmpS6wbdixOM4G5z7dlYEktDCQW9r3
   P0TbxiGLozu45lPRigFawSi8TmZmjy8JoFIPP2xhKZFkUti+yTPabHeOz
   A==;
X-CSE-ConnectionGUID: G0jbZhHpQ52PWLAt54YlFA==
X-CSE-MsgGUID: sodUFCbSTIC+9Do9XTEqmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86651582"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86651582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:29:28 -0700
X-CSE-ConnectionGUID: J6DPuGNTR6eA1f9m3g12xw==
X-CSE-MsgGUID: ieN+9U5WQ5e9WUDIWodQdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="264253141"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:29:25 -0700
Date: Tue, 31 Mar 2026 12:29:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <acuT8oTnaYujC0k6@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231372-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB82F367162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:
> iio_multiply_value() passes integers val and val2 directly to abs(). This
> is problematic because if a signed argument to abs is the lowest value for
> its type, then the result is undefined due to overflow.
> 
> Cast val and val2 to s64 before passing them to abs() to avoid this issue.

...

> Fixes: 0f85406bf830 ("iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()")

Doesn't fix any know issue for now.

...

> -		*result = multiplier * abs(val);
> -		*result += div_s64(multiplier * abs(val2), denominator);
> +		*result = multiplier * abs((s64)val);
> +		*result += div_s64(multiplier * abs((s64)val2), denominator);

Right, but here we get val and val2 from either static values from the driver
(when it is SCALE channel), or when channel has PROCESSED support.
In the latter one it might theoretically be possible to go till the INT_MIN,
but practically I don't know how, except for the broken driver code in the
first place. With that being said, I think it's better to validate somewhere
the multipliers (when it's SCALE or PROCESSED channel). I also noted that
for the _PROCESSED some drivers keep a garbage in val2. That probably needs
to be addressed as well (exempli gratia: bmi270_read_raw() does that).

-- 
With Best Regards,
Andy Shevchenko



