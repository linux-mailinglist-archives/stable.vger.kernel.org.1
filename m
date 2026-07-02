Return-Path: <stable+bounces-270408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KqodMOVLRmocOAsAu9opvQ
	(envelope-from <stable+bounces-270408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:30:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F56F6B9E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 13:30:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SqjVT1sm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270408-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270408-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A635E32502F3
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475B3CA4B5;
	Thu,  2 Jul 2026 11:03:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397482D97B5;
	Thu,  2 Jul 2026 11:03:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990188; cv=none; b=E7daVS0cVLr++lx2k6tsgHAyiVLPnELNE9WfMxljmvxjrjVMt3zyoEtkUDHn1INrRrxcNxI4Bn0UTtFg1+IU4kYzAmwH2TaD691PYb1z9ZvdPLR4cK1dX+NPw8eQaOIk7j1no+MdjW63doHvkJMwP4kvCjiX8bSH9UHjYAevDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990188; c=relaxed/simple;
	bh=0KYEcf0dhsGWh7qVk3Lq9HCAo3+/k3T0Bh/8zhGy9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQcDms0igNdXklknErMU6vXybJxZelCNSt86fRuwGHRBEId0/+uDGZp3pDkNBu09EOVNZkeIhnWkHUjQqRuTs/uMU8yWu+J5lty0HfiLN1FKEhdaLwr+bPPAsj1lDIpCRHgHNCu+jnqRp/Uy6Mn2P9fo5hP7IUM7+HbsOOT7jK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqjVT1sm; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782990187; x=1814526187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KYEcf0dhsGWh7qVk3Lq9HCAo3+/k3T0Bh/8zhGy9aI=;
  b=SqjVT1smBKQeTALjgQWnP30WmXvjh22ZPFPlieERb+BkTatFMS2pbflt
   0DZMtOaZraBDqZdk/oKXNad9PNxKpPBQ4UCDRtjZNoaFRvCub4bz+noXs
   N4AlGPMKwrKnnGa9xGCBGhS8htA4NNE08AV4WrO4XMhkAt5NYT8qbLBTe
   UUbIO4DDld00E5/OR717rVsjGsQmicqSZZCUUDSahja11cfx9WcbtFbR4
   VmTbLiGoSBAaCBhkqEVDl2qyaC85rw9l6SMp0ONIbLLDH0iqAhbdIxFUG
   X0K7xoDflveuum5uybotwe4xR5ssdf7bmJOvR4xJWH7AyvFaTI34rF6rl
   Q==;
X-CSE-ConnectionGUID: Hxnvexm7QdyHeQWcBu2FzA==
X-CSE-MsgGUID: fUZHvPcdTKygflM+dejFYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101282491"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101282491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:03:06 -0700
X-CSE-ConnectionGUID: ul5mNFzeQBCyDQm4flpp/g==
X-CSE-MsgGUID: uUk9nc18QeO98BkjYn3z9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="249480294"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:03:04 -0700
Date: Thu, 2 Jul 2026 14:03:02 +0300
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
Subject: Re: [PATCH 2/2] iio: adc: ad7779: add missing 'select
 IIO_TRIGGERED_BUFFER' to Kconfig
Message-ID: <akZFZqGM7dk4usBE@ashevche-desk.local>
References: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
 <20260701-add-adc-kconfig-deps-v1-2-b9708d74f426@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-add-adc-kconfig-deps-v1-2-b9708d74f426@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270408-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:Jonathan.Santos@analog.com,m:ramona.nechita@analog.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B4F56F6B9E

On Wed, Jul 01, 2026 at 09:21:47PM +0200, Joshua Crofts wrote:
> The Kconfig entry for the AD7779 is missing a
> 'select IIO_TRIGGERED_BUFFER' parameter, causing build failures.

Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



