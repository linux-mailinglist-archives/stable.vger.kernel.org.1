Return-Path: <stable+bounces-237933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JlSEZx23mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:17:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829B3FCF91
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E34C43094B47
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6773E6DF3;
	Tue, 14 Apr 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrUAFFtT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91F38645A;
	Tue, 14 Apr 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186818; cv=none; b=LWhzan8G8TLunNF1+uh/1KMS90ickZ6S0rBA9fk8jgVde32BB/YQS1rn5pogiGBbMxmEyX+uII6hdc/1wzYWWYMOyloxe6JHUVtJqHLPdYnH3nm9U+RRVIbKbbg/hnu/23OLYo8cG6qeWJp3Bna4svL8U8TYWB56cWs7fsoYNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186818; c=relaxed/simple;
	bh=Fiaut4O4FafLOosAOBmWHxd3wJTwn8QUQRCtLrg7Fug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms7zL23jNemofNMSkyhg6KIwq7Gra0gp6ds8ADzvulGt0RBheCzew0EThMGUPTmNBethztHW5lnXj+iw+oI2yFe7I5jnxZmCxhALnXQAFyQzWreu5xQIth0nF6dKam9oZmIDxQxBPDSoLaKTAN0W5ay+jwqdaKMBwpobqbkB1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrUAFFtT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186817; x=1807722817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fiaut4O4FafLOosAOBmWHxd3wJTwn8QUQRCtLrg7Fug=;
  b=PrUAFFtTbtMlD3AtHwPN7thluW5pOTUJfct1M5/gRkSdSzNtJoPehIqI
   5iDa4ILQmQ01HOKmIkjAXGUuuOONb/YXO1YZ1n94QiDDahm+ikv7jstE6
   YV8aDxi9qErQgAQkQYViNNFalUBdJqEomnHBb8k4UBvojk//bZ0WKOvrl
   0bTula8AWiyvidLWJ3Ebg2CoXTWdPiMugve0XemB05lgWx4MleqOY8VwX
   oNvKy1kp552lElGcuRb9Cu/Inx77S+Tc6p/4Ni1ebBrsMhCBeKaJQkrqu
   QsIFKwlAg2b6nXwvABIi4tukT4AhgWLC7zr0zN7jd3b0ou8CBdRmYbHhH
   g==;
X-CSE-ConnectionGUID: l0fpnaToQqGGdB1TwSklDw==
X-CSE-MsgGUID: NxGBtaAaTwOade357AYbdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77264312"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77264312"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:13:36 -0700
X-CSE-ConnectionGUID: xByqH/qTQ4mRNX7zax9mKg==
X-CSE-MsgGUID: JjQImoz6TDufzPC6uvnl7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235109119"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:13:33 -0700
Date: Tue, 14 Apr 2026 20:13:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhaoyang Yu <2426767509@qq.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, kees@kernel.org,
	fourier.thomas@gmail.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn,
	23120469@bjtu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: pch_uart: add check for
 dma_alloc_coherent()
Message-ID: <ad51u1C0PWZPdFi3@ashevche-desk.local>
References: <tencent_E328416B7CFD436F6029F2DF02AD7ED89C08@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E328416B7CFD436F6029F2DF02AD7ED89C08@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237933-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,vger.kernel.org,bjtu.edu.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,ashevche-desk.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9829B3FCF91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 01:41:58PM +0800, Zhaoyang Yu wrote:
> Add a check for dma_alloc_coherent() failure to prevent a potential
> NULL pointer dereference in dma_handle_rx(). Properly release DMA
> channels and the PCI device reference using a goto ladder if the
> allocation fails.

As a fix for backporting it's good enough, ideally should be converted to one
from 8250 family as it was done, for example, for Intel MID (see a history of
8250_mid.c for the details).

FWIW, the HW one may test this on is Intel Minnowboard v1 which uses EG20T PCH.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



