Return-Path: <stable+bounces-244321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B/EJEbi+mmGTgMAu9opvQ
	(envelope-from <stable+bounces-244321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9414D6AE4
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70256301FF2F
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4D30DEAC;
	Wed,  6 May 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnI7BX6Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E0285050;
	Wed,  6 May 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049603; cv=none; b=qSQ4jMMqhsXQTVaJ9nHUW2NpeR2Ne4yvzMcaHWltYBfAigB/qCH0nX1rk3Si3E4vmflxkvot5eDM847CR1ITW2IlxVdfxqfpcMDjdPWLxDgVte6et+8LMr3tX+O1FmlHYqqGKh2T/mjHhVkBwb/wr30mCjJR3DDqxcUogAakEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049603; c=relaxed/simple;
	bh=zHScjr4MohVdJcrE9EJdmAsFsus5ZDZ61tsq7lH3tao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXHBD2LuaI7Gi8YEBAZMaNfrNkLc2by9BUQ+4Bav6a3Y2X9rey47s1asP9ZelJvgU/n3fs72tCfHCAPln9To0ADs7tMQ6p/BpORaEz0k4y9TvQQsGH1FUH1wDSG7GRrvk2XnpmY+ruoeQ+d13LuGgfQIGf11pdxrgdYQcwxr2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnI7BX6Z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778049601; x=1809585601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHScjr4MohVdJcrE9EJdmAsFsus5ZDZ61tsq7lH3tao=;
  b=EnI7BX6Zj+DNSKOUuQU9KSK3UASdjLeKD19jTXij3iikHCZESJ3Xqib5
   mSl8tSJLiQADrtmDrj1RnmmV1xlN6ia4opRvoz7jIYJHhR5Pj5I31oOsG
   ALXAZ2tzFbX41two+gpT/doga7rextlAgjjmj4kPl+itJ8+Pq3X6YiIab
   gtLJwkk9i+bAp/nmpMDfM2ILpINbFLtbxx1W3mNuYDGhBFrHGaWWrJZn1
   /04Ic5Wu4IjZ5jRPCpod7whIlM4gIDZ4i43lpaCF82U1bkU/KMel5JlAa
   4C6TNiuefNIjqjgv8qX47YCRhWYUcYFOjBGFJzoTnpXKRFooUirfqs+YA
   g==;
X-CSE-ConnectionGUID: 3X3ejXoHRWSd/Pg1EAfgHg==
X-CSE-MsgGUID: KoAWyrl3TOeMH/DlS+NLHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79054557"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79054557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:40:00 -0700
X-CSE-ConnectionGUID: vzu3dzF6Tc6YR3JUCrSX0w==
X-CSE-MsgGUID: d1o+PxvCSG+/ocNYftjaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="232948113"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:39:54 -0700
Date: Wed, 6 May 2026 09:39:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack
 location
Message-ID: <afriNDbCrUsXwV2a@ashevche-desk.local>
References: <20260505133748.51355-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505133748.51355-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 3A9414D6AE4
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-244321-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ashevche-desk.local:mid]

On Tue, May 05, 2026 at 02:37:48PM +0100, David Carlier wrote:
> itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
> fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
> parameter (a pointer), `&buf' is the address of the local pointer
> slot on the stack of itg3200_read_all_channels(), not the address
> of the caller's scan buffer. The (char *) cast hides the type
> mismatch.
> 
> i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
> = 8 bytes into the parameter's stack slot, which is discarded when
> the function returns. The caller's scan buffer in
> itg3200_trigger_handler() is never written to, so
> iio_push_to_buffers_with_timestamp() pushes uninitialised stack
> contents to userspace via /dev/iio:deviceX every scan -- both a
> functional bug (no actual gyroscope or temperature data is
> delivered through the triggered buffer) and an information leak.
> 
> The non-buffered read_raw() path is unaffected: it goes through
> itg3200_read_reg_s16() which uses `&out' on a local s16 value,
> where that is correct.
> 
> Drop the spurious `&' so the i2c read writes into the caller's
> buffer.

Very good catch! I'm puzzled if that code was ever tested. Do you have an HW
and that's how you enter to this bug?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



