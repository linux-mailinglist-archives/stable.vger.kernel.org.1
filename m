Return-Path: <stable+bounces-270407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +dlQG3RGRmpWNgsAu9opvQ
	(envelope-from <stable+bounces-270407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:07:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC9B6F66E5
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XZ3pzDfH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270407-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270407-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A75300CB31
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06363EA973;
	Thu,  2 Jul 2026 11:02:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD913E0C41;
	Thu,  2 Jul 2026 11:02:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990165; cv=none; b=FNtuZHdySMhYIzp32CbYgtwrX/1u9vSM3LpYZGhvDbo8NUzHMMy0oZhKjclq6X8vSQorkrP7sR8atRTc7Jq5CXXmWz5rG2O/7c63r3r3pZ6QA6Cgc29DROc5hFmQOEMzCFWymmAhNilMNLGe34wA7NlBuZ7hHyAGTc9jveurD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990165; c=relaxed/simple;
	bh=UofN3J6jke6cl6d6Zx94J1oTpLNphIN8AoxVa2z3KhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1MgkjlNfHXGpAg+Rm88DBfHDs8HToIcsm6SBKfSmTdNIyIHCo/vITHImLJH2Rluf9bJiBmO2d9MRWNMpbr8Ak1/p6Kaup6WsGDxqDALk2hzJToPIsdVptB+6jaVtnBZSNZdVaW6pmsQVrIobhWROfVBNFq6ZBA1VzbUTYsigA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ3pzDfH; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782990164; x=1814526164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UofN3J6jke6cl6d6Zx94J1oTpLNphIN8AoxVa2z3KhA=;
  b=XZ3pzDfHO9xzMmeMzmo6IbLZND4paMzR3SS/noxbDNnkDlv9XYHFOXjJ
   jB8ZsOQ5u4MCp6CmwTuzcqcMoXfWBFMpHYlPrP5UGa10QNzKEDXTavVBe
   uFOe+DRZXLRFoYsIpuNDF/I/5psQu35tqecfE7SXr22sLtCISRMUfnxMs
   p5qVF6Ob40OzZbCHtMulbvWuUjua4GZIl+Y18lfdo76v70pFW6PW9CbTR
   vHGihqrAz3lckgZBaSttZtyL5J2qCU0v3itx42Qx1Sh+1vNRk99dRQybt
   uT989phELB0ROfZvMYSpN+XhVixUz2YOFyZfjjVTP52z6f6kndYs2ap3z
   A==;
X-CSE-ConnectionGUID: H1R72T5aR1uzWo+yDjELTw==
X-CSE-MsgGUID: BJi9W7ceQf+xNq3bhQn2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101282390"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101282390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:02:41 -0700
X-CSE-ConnectionGUID: GSdQghq3RKy4my4UspgGTw==
X-CSE-MsgGUID: wt6mGIW1QT+eAYL1z+v5wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="249480166"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:02:39 -0700
Date: Thu, 2 Jul 2026 14:02:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add missing 'select IIO_TRIGGERED_BUFFER'
 to Kconfig entries
Message-ID: <akZFTC6qVzLG5ton@ashevche-desk.local>
References: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:Jonathan.Santos@analog.com,m:ramona.nechita@analog.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270407-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CC9B6F66E5

On Wed, Jul 01, 2026 at 09:21:45PM +0200, Joshua Crofts wrote:
> The AD4130 and AD7779 entries are missing 'select IIO_TRIGGERED_BUFFER'
> entries, causing potential build failures.
> 
> Steps to reproduce:
> 1. Run `make allnoconfig`
> 2. Run `make menuconfig` and select any afformentioned driver and
>    modules it depends on.
> 3. Run `make .` and the build will fail due to missing triggered
>    buffer definitions etc.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> I seem to have stumbled upon a lot of drivers which have incomplete
> Kconfigs, expect more patch series per sensor type.



-- 
With Best Regards,
Andy Shevchenko



