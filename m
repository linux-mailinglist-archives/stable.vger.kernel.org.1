Return-Path: <stable+bounces-231379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK9KJ5ify2loJgYAu9opvQ
	(envelope-from <stable+bounces-231379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:19:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827D367C98
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E5B311ED36
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423A3A641F;
	Tue, 31 Mar 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2kyswgJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBA3A2542;
	Tue, 31 Mar 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951713; cv=none; b=hiB0oNec2SuMVYUHm/KZ7b2kV8PakXxHW77gIfMtojh8UiM7lbuhxHgPlQBzk4KIJVuHzR5OGsfKnz9LIU4y5Z5u3byy21e1Ae8FAYSemZWsx6h0iS33VHn5mZEb8dYz84SdmarGe1UTz782UXimm5a10nEErkTOS4T5ZoFuWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951713; c=relaxed/simple;
	bh=oJYDGXey4ybov+bfbQoWeXOWATlnqJbviRrykDJvd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY2WnLvI1vC2/zNv+5QlPAAFTHZr5DF5P5iBATXqFJbWr1S4eGsxYUL9c5tOEW8XOG/fXPDa7xaqyBYOodqkzUPAzz+dia6aZU+u0BElyvca7bg1bzSAf+yQ/29O1GhW/dqFT2fXLHZp02OyqjEbhRJ9TCQUfpSPK8EExPTzO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2kyswgJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951712; x=1806487712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJYDGXey4ybov+bfbQoWeXOWATlnqJbviRrykDJvd3s=;
  b=B2kyswgJXlM0t7btqwgvR5OHQ0oKYcsyCpowZ7GpI1+pSDeDq0Z2zBRi
   hZZ1MYjn32oe8CBeRw3q0oIotUGqY/PRCQ7XTQzRPX0zTlw5ckTfLxtgP
   BQ8eJYunvEvhSSNBH2RyJm/aQa+4QSQGfXks+5UjUgANp3bHmwSbk7VJh
   BoB0uSyFCIIBRnqt3Fgvn/s+LPJ5guT1iUK1c4XDM0OjJolO47PDr6wGU
   zU/43USHCeizGBAGx+xPjNkrzWcGaj3ja/LkBKcTZpflSuPf7EzIq6GK2
   amEfKxfEwLcnmadmnuxnCx3bWp8cEmHrY0JZXiydKYBFP8sXkadzwQZMo
   w==;
X-CSE-ConnectionGUID: 6z66y8RJR+aWSbMOMITFUg==
X-CSE-MsgGUID: 6oOnirTxTKquyD+pXWxYPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75846546"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75846546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:08:32 -0700
X-CSE-ConnectionGUID: TeDlc5jmRBSkPiM/4ugs7g==
X-CSE-MsgGUID: zGZyXmajQ4WIjc/9IBL4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226203156"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:08:28 -0700
Date: Tue, 31 Mar 2026 13:08:26 +0300
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
Message-ID: <acudGrFiD7TcAs3S@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
 <acuT8oTnaYujC0k6@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acuT8oTnaYujC0k6@ashevche-desk.local>
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
	TAGGED_FROM(0.00)[bounces-231379-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 0827D367C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 12:29:22PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:

...

> > -		*result = multiplier * abs(val);
> > -		*result += div_s64(multiplier * abs(val2), denominator);
> > +		*result = multiplier * abs((s64)val);
> > +		*result += div_s64(multiplier * abs((s64)val2), denominator);
> 
> Right, but here we get val and val2 from either static values from the driver
> (when it is SCALE channel), or when channel has PROCESSED support.
> In the latter one it might theoretically be possible to go till the INT_MIN,
> but practically I don't know how, except for the broken driver code in the
> first place. With that being said, I think it's better to validate somewhere
> the multipliers (when it's SCALE or PROCESSED channel). I also noted that
> for the _PROCESSED some drivers keep a garbage in val2. That probably needs
> to be addressed as well (exempli gratia: bmi270_read_raw() does that).

Actually the data in the val and val2 should be aligned with the returned type,
hence the potential bugs might only come from the untested drivers. Which means
that this patch doesn't improve the situation.

-- 
With Best Regards,
Andy Shevchenko



