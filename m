Return-Path: <stable+bounces-273377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jZG8MN/+UWqoLAMAu9opvQ
	(envelope-from <stable+bounces-273377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:29:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23B740E7F
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=k0OnL2z1;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273377-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273377-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083113011C5C
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAA37646A;
	Sat, 11 Jul 2026 08:29:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53835DA41;
	Sat, 11 Jul 2026 08:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758554; cv=none; b=rdMW6YLh/Kr47b+ZioJQx12XFKcj0M0zZimtMcnnA2sz9ATCaEmgrh5RYGOUhnZYh+lKz6pWBgbJkRcyLYan/ybplShutmETy5vtDmkvRWa6+HVthW/IF/kcJO+CDgJrJa/8AUnFmSl2xxkiyvT/21ogYxFAl9rU0HpItaLFqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758554; c=relaxed/simple;
	bh=qwi8ENWVue2neaa+SLCAgjNjmmvsDGp7Px1l+6GIJB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEhbUVfyx2LcaIVx2OsmtBAlH+kzCa/k2sU2zVgqDIePH8gl7p13Qk3FGlR6RQ513I+/lRsVHjvWrEugNcyyB0bXzJ+gNaoAs0Yvcl753IhhK4/17zGhEVAhS2gKpjSFxejMEVX9c1M3eMfn7gaKrsgSHT7AND2muTn9Apxmj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0OnL2z1; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783758552; x=1815294552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwi8ENWVue2neaa+SLCAgjNjmmvsDGp7Px1l+6GIJB4=;
  b=k0OnL2z1flRZPCiRPJFVdH0wo98FS78Dy+wE5dTQuSvt3fjUwzVx3Q7H
   MsSx+hdoaVTj6axSjS+/kv8UZRK9wubuKPIVef+GeXES2fBt7xUaPTJxt
   eWwT7x5GZL+7xqIbwGxDaMN8XJ1eKBWg2dVcolIF3dU8uy+r+D2sHdGow
   DRGVmftVeoH8ObwiRGOmM4uVYtX31FMYjTy0Eqa69EnJfiLQjEyTG+RBX
   tjQ/vbQ8ZsJRUSvm1am/oUu0o8jVkfCazsqq7JA1aFI3k4LbfWqMje33F
   1EDgOOPGb2WGPXB5g6pcj2VHSWAQL/8RFZXxxoK2cjpkqn7nnGBmzsx1W
   w==;
X-CSE-ConnectionGUID: vhMUzrqZR2eVBUUDD9GOog==
X-CSE-MsgGUID: 0v2waxymTIK/y3oEnuqgTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84496078"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84496078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:29:11 -0700
X-CSE-ConnectionGUID: qieRQk9ORe23Ft1Gezs5Ng==
X-CSE-MsgGUID: vuZuD2PqS5OurEz0zdwiMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250674179"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 01:29:09 -0700
Date: Sat, 11 Jul 2026 11:29:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Message-ID: <alH-0gZNqUcGgGcr@ashevche-desk.local>
References: <CAMyXUJkncpA3Q-BStPsbXfViNbxzJ6ZrQCt0RoGxtVXV-R_DOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMyXUJkncpA3Q-BStPsbXfViNbxzJ6ZrQCt0RoGxtVXV-R_DOg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:acharyalaxman8848@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshua.crofts1@gmail.com,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D23B740E7F

On Sat, Jul 11, 2026 at 08:28:27AM +0545, Laxman Acharya Padhya wrote:
> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.

You send the same mail twice without any word saying why. On top of that both
times we got the mangled patch. Please, slow down and check first your email
and other configurations, send to yourself (perhaps different email address)
to check how the result will look like.

-- 
With Best Regards,
Andy Shevchenko



