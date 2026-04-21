Return-Path: <stable+bounces-240252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6k0zJHb652lBDwIAu9opvQ
	(envelope-from <stable+bounces-240252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:30:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D64402D7
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 033DB300BE83
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11D3A2544;
	Tue, 21 Apr 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVj72BD8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD120C461;
	Tue, 21 Apr 2026 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810597; cv=none; b=UMs+YUitvhsSmr69Od8LcBG6lIPwZY7AgTyJPZKEJ3bVjPky8WGFDecJILi+rSpfrqVuJh9UMiN4Sr0szOWapfxSE7xBFjXVbKkGXx3Q5pBWIz4w9A2bb1/aaSWvBPoLlTSunLJMru2IGAWMM+EQmZdRAuQNs007urIawHdEgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810597; c=relaxed/simple;
	bh=HwDAUHUeSrDiyXDXsV2CjHp8PEOM2HcnKUqP6U1hhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIo7/J8RUihqLjCypejctV5AAycUIKpsPWwsJattIVqAkiezW1IOsinXsWx0FkUFfH2pM778jM11DMms7udLyYFETS5wDQeTlf2qiEfkFtLzT8vB0hD8DiZiWjzLjhyh1S7YS2y8tpF5B3vk6Ya3r3qS7oZafmJ4ngwG2YnmgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVj72BD8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776810596; x=1808346596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwDAUHUeSrDiyXDXsV2CjHp8PEOM2HcnKUqP6U1hhkY=;
  b=aVj72BD8T3acQdbAXtk+nFa4zUVsW7LZi2iuNPcuaqZScczHADL+QGmi
   bAfK6H5nDZjSxNtLitoRW885tEH1u5QxkkYRkwQ4JG1pXHni9gjJA3Efl
   gGSaEQN1ark5bPud1UbI0sY/uYXu1BAqJz4slvFiR7WTZluCfutep73Kx
   L24uB9Q7tiyZoSLeVOTLcIxN3d9jDdUBNvBYWZp2DmQKbTMTVmTqkLn05
   4bSdAPsnH8u/LIiv/OPX8rswWsQ4PDJPP6/VQfEnWkVuAF5/Dq6ndnRaF
   qGaUQbjhh2Zi3vapqGbq0Sn7tgM20Z3FTHICG9bwYGJ4mb+bL9i6nlLJm
   g==;
X-CSE-ConnectionGUID: ycB7Nxx7TM2y7pxAz1+Keg==
X-CSE-MsgGUID: NwkAQk6OSpm3VIN221NQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77460346"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77460346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:29:55 -0700
X-CSE-ConnectionGUID: mN3c3u+XSLOHLQmiklDPOw==
X-CSE-MsgGUID: bUyq77UxTKGum+t66b0wiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227553036"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:29:54 -0700
Date: Tue, 21 Apr 2026 15:29:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before
 updating new mask
Message-ID: <aef6XiN8TTWdIAiK@tassilo>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240252-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ak@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED4D64402D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4768236c054b..774ae9a4eeaf 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>  	struct perf_event *event, *leader;
>  	int i, j, idx;
>  
> +	/* Clear stale ACR mask first. */
> +	for (i = 0; i < cpuc->n_events; i++) {
> +		event = cpuc->event_list[i];
> +		event->hw.config1 = 0;
> +	}

Are you sure nothing else could be using config1?

In principle ACR events can be used with some config1 setting.


-Andi

