Return-Path: <stable+bounces-259928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4KQNoR+H2q3mQAAu9opvQ
	(envelope-from <stable+bounces-259928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:08:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 531886334F0
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 03:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Q0Rqz6lx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259928-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-259928-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B96C30819E5
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 01:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF63090C6;
	Wed,  3 Jun 2026 01:05:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E763009D4;
	Wed,  3 Jun 2026 01:05:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448756; cv=none; b=eNSXIyLbvmQ5Cw2AMZ0pwerEBrIqFT/iFbG6c7mfnq2Qv0Vy4b4K6m7kQ7n9SCRAY6x8G5oyQQqsyb8ZgBL8inSNcu2vt5aVZpog35LlJ5FEeXBHhdZMTsTElTJQCTSDctwhyQEBLJQfMfDeWk5thc5BxyVxwywvlN6zG+HvDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448756; c=relaxed/simple;
	bh=i9YGNuNgDpOPBl8d6kjfgs6JfNdl9z8Whc5srrXedg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhZO+9fNZzb4ixsXAIkFS1gCHTrq8+uDjTEoKx2Qqc9D4+UuJ11X2YlnUBVHB+W9dHZzWi3uww1+hoYpQX/v15V1LGfzOMbS9p6ZDAHnYBRXGBDrdtR0ZdyPJ5HpYP0S2Q20ik578IVWdm6MtgNqxI3xDE4qFFFLKjSUyeMI4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0Rqz6lx; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448754; x=1811984754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9YGNuNgDpOPBl8d6kjfgs6JfNdl9z8Whc5srrXedg0=;
  b=Q0Rqz6lxWkA4FzULvwMuMus3Dmu0prJ77LcP4kJSFPsMsqynoALhetRl
   wNf7nRsNt5NhP3eoT5z7TuKNR4i+COeBPZ5WqD0sUGC2WjoVXE46TM+Nl
   9TsDJkJxGPwhT1SkSHBtyfco99ZCIDqBRVdxEXsiOZ83bd/7ylPO1nboM
   hlLahaFeNYaE+TkAC03aoGzl1xWwMaq9u8dpDXVtq3Vb8TFYgoGxpeBOP
   1RrU0fFab8VeXbY2vlt0o08eIZFfWvptdEbQJ6Z1TXjyKfxj0LDKVhwxK
   +Q90jzG01ZlH1syHO3ozjhOBpr5xagD4FwIMhMqExibp2ceGHM4dNvYi0
   Q==;
X-CSE-ConnectionGUID: fHTf1kYtSViu8jzSGuoDXw==
X-CSE-MsgGUID: nL395wVJQlWe/S42bp+YsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92625154"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92625154"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:05:53 -0700
X-CSE-ConnectionGUID: iE1zkginSxCbCQYutHwqRg==
X-CSE-MsgGUID: spwj4h5hSqeCYINXm67ZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241085073"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:05:51 -0700
Date: Wed, 3 Jun 2026 04:05:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jic23@kernel.org, nuno.sa@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, benato.denis96@gmail.com, martin@martingkelly.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO
 trigger IRQ
Message-ID: <ah997ABzoOb0cFq3@ashevche-desk.local>
References: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
 <20260602091727.2406720-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602091727.2406720-2-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259928-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 531886334F0

On Tue, Jun 02, 2026 at 05:17:26PM +0800, Runyu Xiao wrote:
> devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
> through devm_request_irq() on the non-FIFO path, but it does not add
> IRQF_NO_THREAD to the IRQ flags.
> 
> When the kernel is booted with forced IRQ threading, the parent IRQ can
> otherwise be threaded by the IRQ core and the subsequent IIO trigger
> child IRQ is then dispatched from irq/... thread context instead of
> hardirq context. Because iio_trigger_generic_data_rdy_poll()
> immediately drives iio_trigger_poll(), this violates the hardirq-only
> IIO trigger helper contract and can push downstream trigger consumers
> through the wrong execution context.
> 
> Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
> non-FIFO request_irq() path, while preserving the current trigger
> polarity and IRQF_NO_AUTOEN behavior.

> Build-tested by compiling adis_trigger.o.
> 
> No ADIS hardware was available for end-to-end runtime testing on this
> submission branch.

These two paragraphs are unneeded details and can go to the cover letter.

...

Code wise IIRC another approach was discussed. But Jonathan may know better.

-- 
With Best Regards,
Andy Shevchenko



