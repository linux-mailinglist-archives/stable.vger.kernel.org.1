Return-Path: <stable+bounces-197084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BBC8DD4F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F359534462E
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B49299924;
	Thu, 27 Nov 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e28GUUQn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B923BD17
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240377; cv=none; b=SmN1KOy+3AQhek04pUzgMCRrA4T2btY6qIqzCBIu5QDtlyOEQ9nEEqdtlh6KwcOBhrDAcgJzfLEh8lbalZ4O9Dxus8AoSWycxDMY3BKj+Xzu4LVv3E2Z18IvvsjT99aTQclNa5szpFNrS3dgtE3QBbW52CqfiN5s/Sd1+/1dSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240377; c=relaxed/simple;
	bh=769dfkMjwB9JqVOZ3iZbI/fNgaIZ21gfa4qwhm9zbXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2b6GfJBPR/T3peb7WH5t+0NHFIsITWpFzwwuh6XJN3VSVmbsHzcJvFB3PS+8njky272I5AbjZDMTJS3werrCdiRYcuqqd/YjxUKBRaK7AI68cYdDEZ10qtDe8/UJprwv9bkiMay81caTzNuadwVHHxDjYnF03AdHOhgTUQGIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e28GUUQn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764240373; x=1795776373;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=769dfkMjwB9JqVOZ3iZbI/fNgaIZ21gfa4qwhm9zbXQ=;
  b=e28GUUQn3KXeG8hlyf9v+urM7n5/Y2oq9LVkf5v0NTcR0WkAQiSRycnU
   mpHNRTEEgrGi3OkfbaBWmK7D/HBuxMOFDsotlAI7ardZ+dOySmV6gCRQw
   jftV4Tu5g730I1iDFLX71Oep5PEE3Pgp/RQT/Z1EuYH3C5sUBOglmfZHj
   /67TiKJRn4lubv/oqohdStwCAMYHHFKZ8j6eeD5lBTI3LMa3mR4vu/+br
   xcWVdmyTLfIvR2ACmrWrmEvP5uGGa9GWIG4fJWzvwTlf1y9v9nCpIyUy9
   2GaZoaf/DmFEOa7DhiOB5phKTvOioYc+hpZtOW1ay/a+pfpyBvuljGgAd
   Q==;
X-CSE-ConnectionGUID: 72P7Y7ONQ4SzsTZ7fAdRcA==
X-CSE-MsgGUID: EaIHDAX1QWypHBedQ5EhbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77756233"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="77756233"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:46:13 -0800
X-CSE-ConnectionGUID: TXdyOk74SWOPAGhU7TKbCg==
X-CSE-MsgGUID: LLRTSh/cRRCYqaUimuPpEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="230469413"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:46:08 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Krzysztof
 Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, =?utf-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>,
 Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>, Chris Wilson
 <chris.p.wilson@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH] drm/i915/gem: NULL-initialize the eb->vma[].vma
 pointers in gem_do_execbuffer
In-Reply-To: <1835827.4herOUoSWf@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251125133337.26483-2-krzysztof.niemiec@intel.com>
 <4423188.Fh7cpCN91P@jkrzyszt-mobl2.ger.corp.intel.com>
 <qylrctylmtj6qzibfpbapwpb77ut7gzckgg2wpc3gv56kl46m2@hyio7hcsj6vy>
 <1835827.4herOUoSWf@jkrzyszt-mobl2.ger.corp.intel.com>
Date: Thu, 27 Nov 2025 12:46:05 +0200
Message-ID: <24917431ff16a8464b89b1314e02201172cc3fde@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 27 Nov 2025, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com> wrote:
> To my taste, zeroing on allocation would be a more clean solution.

IIUC there are micro optimizations to not clear on allocation when you
don't strictly have to...

I'm not advocating one or the other approach, just stating what I
believe is the reason.


BR,
Jani.

-- 
Jani Nikula, Intel

