Return-Path: <stable+bounces-232940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBFRIY4szmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:45:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDB3863A7
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DD703030ED3
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF03BB9FC;
	Thu,  2 Apr 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbXm9Ptu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35633F5AF;
	Thu,  2 Apr 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119151; cv=none; b=fFL5H/egDsP3ymD2sY2glOLh14mP5wlMzcbyo3OjawjdQ8C0FjuOOj5Ehu0Q4/Vu7NDEOYiWUXgx5T8mBZxuMjf8CGwm1ga4ZQdgvZI0oi24YLq7Km1+Rr+vQMKu24l6xl2u+O1YqZXUV/HgEna8CE8J9D2E3hsvca5JyHG+6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119151; c=relaxed/simple;
	bh=xA+iDdwmvrNkYAACWh1p/hrj9tZn++7dwPc3GtxQJKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM84TlMqqy01tvzi4KAZGTUfdCvp8RMKRMcPcog5ydNkjesHLAAWShB+bZy6q3yUBwB91DvoAmZu2hIHe+M+ae/+VhFM3KAkCExDJW3R9p0VHUr9tWSQ0phjkO3ByYK1v9JP/K1ibf1u55dGVgWvcaKkFqrU+x83OhXMH/eXkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbXm9Ptu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775119150; x=1806655150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xA+iDdwmvrNkYAACWh1p/hrj9tZn++7dwPc3GtxQJKo=;
  b=FbXm9PtueYNEIMyX8FuaOUE2u/EiFQWNCwsTA6unb3/z/SWjuc3kXybD
   oax/2bI9pk3fgyylCCqFz/3EuSukX6ReNOfUbLJ9xeNNx9zdwFN8tIYaG
   ZVF0X0ahy4G5C3kBN/7cwkNB9cB4Ww8vT96vXeYk/5tyYs1Ah5rYy+Vn9
   WGUOyQr6aojcpckfDfJTR4ROPAdN7CxuOUW+1EvzuTJKgMDKXA8fQ56XL
   9wjmssUFYGaBDmyE/megMilEBDZ9J+THVOmqRxasIHnF269cHqA2I2JBe
   wWvzsr/v8Gn4J7DapVps0VFKrWcaMreAA9d2Myqdsd2kOSiQ3At1RhRSk
   w==;
X-CSE-ConnectionGUID: uZMvxes7R5WlVdsM21s3ag==
X-CSE-MsgGUID: jCr1Lt7nRK+t49MIRMfXtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053719"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053719"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:39:10 -0700
X-CSE-ConnectionGUID: f/iQyYZERZe3pFdC72Labg==
X-CSE-MsgGUID: s/K6uaJBS2aBregwF87vKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231863188"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:39:07 -0700
Date: Thu, 2 Apr 2026 11:39:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Gyeyoung Baek <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: mhz19b: reject oversized serial replies
Message-ID: <ac4rKEMYAl-FJ5e8@ashevche-desk.local>
References: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,baylibre.com,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232940-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3BDB3863A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:40:15PM +0800, Pengpeng Hou wrote:
> mhz19b_receive_buf() appends each serdev chunk into the fixed
> MHZ19B_CMD_SIZE receive buffer and advances buf_idx by len without
> checking that the chunk fits in the remaining space. A large callback
> can therefore overflow st->buf before the command path validates the
> reply.
> 
> Reset the reply state before each command and reject oversized serial
> replies before copying them into the fixed buffer. When an oversized
> reply is detected, wake the waiter and report -EMSGSIZE instead of
> overwriting st->buf.

...

>  	struct completion buf_ready;
>  
>  	u8 buf_idx;
> +	bool buf_overflow;

+ blank line here.

(No need to resend just for this.)

-- 
With Best Regards,
Andy Shevchenko



