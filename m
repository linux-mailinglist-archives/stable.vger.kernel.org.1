Return-Path: <stable+bounces-259929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QTm9Kyt+H2qtmQAAu9opvQ
	(envelope-from <stable+bounces-259929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:06:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5113E6334CD
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:06:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="KffLtuU/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259929-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259929-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FC52301640C
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C63002CF;
	Wed,  3 Jun 2026 01:06:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2A2EAD15;
	Wed,  3 Jun 2026 01:06:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448785; cv=none; b=rXO/07LiLXoGLvTO9BRhBMBUU5Jme64U8lqWuosGjQ30E+kerawcBdTf7E0RaRPcuIZtgXHre6zo0NxTjKEMjj7y51EHLjNYegYDwrZbV1+1gwjGfxqjlEXuooOzQWjLtaIA20CnEyV6OrMnEprgzWmCn0LmPgkUEDjAAK/Cr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448785; c=relaxed/simple;
	bh=QZp0OK3dQyxnNySJKhBsMviw0OwDNCQ0fKMSRJLU1Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE1V3QPyFgKiIwbe/SZo3OnwZ+PTiQeVrcmLp68KJxaTqBf8Cda3j6rqhAeufCdN0F8X6B8UboEL3nh3oTWRsIUiUfnr0NvFF4iC3LFIiCkfHeVwkcBDWdpP+g+dqnq4TpBX57kILTMz2CmWSjZltvwIEBKnXzxmjXwaopQuD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KffLtuU/; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448784; x=1811984784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QZp0OK3dQyxnNySJKhBsMviw0OwDNCQ0fKMSRJLU1Is=;
  b=KffLtuU/AVNOXppL1rFDtmGcDDT33Ora4CvaE1+N4aLFR4MFpv7osIS3
   2py+a8OdvmZAG1s1l66RAQ+Jz4tUuAyrm3XT5D6KsjKMSShMpprOM+0H4
   xYWJF44gZjPjIaLPQmYGkwklM5288hlD72lh4VEcSR2v3q1iHbraXGCeb
   o+oqiJFxl0d+MhpOKL6Rh70v8OB/nkztuyfA2Ut65O4wN9ZLsPgQqjbDi
   keYeTdcI8ttBmrwPKYBDRHMWjqyIDTKDN0ZgJ70gyU/uNr2wq8szT1HW/
   WdC8Yzfy7xO6Amz4IB3KCfRUuYBCEaGO56gnIhgkZxI6yNwLQlCKL/BJW
   w==;
X-CSE-ConnectionGUID: 874wqCarTUuD0/D85WEd+A==
X-CSE-MsgGUID: JdUKvrP4T4mot/s1sSd0Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91932359"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91932359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:06:24 -0700
X-CSE-ConnectionGUID: KIwkLwlLTgWV+DfR+7kGTQ==
X-CSE-MsgGUID: hvZpKi/4R8+RXW8ug0QIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="239909649"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:06:21 -0700
Date: Wed, 3 Jun 2026 04:06:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jic23@kernel.org, nuno.sa@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, benato.denis96@gmail.com, martin@martingkelly.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: bmi160: add IRQF_NO_THREAD to data-ready
 trigger IRQ
Message-ID: <ah9-C90a7n0ME4XM@ashevche-desk.local>
References: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
 <20260602091727.2406720-3-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602091727.2406720-3-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259929-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,analog.com,metafoo.de,baylibre.com,gmail.com,martingkelly.com,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:jic23@kernel.org,m:nuno.sa@analog.com,m:lars@metafoo.de,m:Michael.Hennerich@analog.com,m:dlechner@baylibre.com,m:andy@kernel.org,m:benato.denis96@gmail.com,m:martin@martingkelly.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:benatodenis96@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5113E6334CD

On Tue, Jun 02, 2026 at 05:17:27PM +0800, Runyu Xiao wrote:
> bmi160_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
> through devm_request_irq(), but it passes only irq_type and does not add
> IRQF_NO_THREAD.
> 
> When the kernel is booted with forced IRQ threading, the parent IRQ can
> otherwise be threaded by the IRQ core and the subsequent IIO trigger
> child IRQ is dispatched from irq/... thread context instead of hardirq
> context. Because the handler immediately pushes the event into
> iio_trigger_poll(), this violates the hardirq-only IIO trigger helper
> contract and can drive downstream trigger consumers through the wrong
> execution context.
> 
> Add IRQF_NO_THREAD on top of irq_type when registering the BMI160 data-
> ready trigger handler.
> 
> Build-tested by compiling bmi160_core.o.
> 
> No BMI160 hardware was available for end-to-end runtime testing on this
> submission branch.

Same comments as per previous patch.

-- 
With Best Regards,
Andy Shevchenko



