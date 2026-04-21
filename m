Return-Path: <stable+bounces-240253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLO1HC3852mADwIAu9opvQ
	(envelope-from <stable+bounces-240253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDF440343
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0355130166D9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACC3A5E82;
	Tue, 21 Apr 2026 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaXyqS3k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9131282F;
	Tue, 21 Apr 2026 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811047; cv=none; b=WLmJDOL90bv0k6w8F4FO76AIwY49tHpPxzvKEO+SabDgXFqiBLYbYCro6boaRIxl73ZwgnWVhd+ig3lq9cdn8cPsQM9Gv6/DF+AOnswXSaAwmpebJd70RgiBiw5bMAekC6evyFVPSy6Xj2Ykb5KQixOrcHdInlooHp+SEdrujPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811047; c=relaxed/simple;
	bh=9asddOYunBnLRNQiRd5AYd47HrnxvGGkWFIRCnjNamY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4FUVR9GMeftolxSnswvOTtrCk70AfX71MHcMQdarv/zY710z1yKT7GKtNtNTDcf5KE7Pn7ItcJGSF8+UWjRXcUvNW4mu5IvKduRE+lrMiHPav81cEuMIQ6GvzlcnJ2AiZiWVQH9Kc1KNVHyEkBUVgDEJPH1p9McfwdnZuWtcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaXyqS3k; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776811046; x=1808347046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9asddOYunBnLRNQiRd5AYd47HrnxvGGkWFIRCnjNamY=;
  b=WaXyqS3knDUZqfJHEIWALQdWTOdjlaj5wub5G0exDtD37I2/grY1VTa4
   1lj71r7Zz4QRHG/IJsKLCkcstNP1UwqyXKwOtLh5SNR1FVWHlKNmlfy9c
   y+R6RIbTvwdZQcx7+Mek3nfNXp1KEqYipWfvBp26r161ral9jBRtnfvOd
   qvnEfnD0VDh4ULyk3QwkO414s/F01BbupoF/xx4x5xg/2Nb6d9e1ofRzH
   k5uP3FURWnUXQlbR+aQUgnjn7lOO0SP/5YGfs7ODacpMNooqermxnPFGt
   ePAQ6j9Y6yYBZTepAupEBRR2CqbOmKcWknEaMg0iVr3re8+tU+IrkI2Cs
   w==;
X-CSE-ConnectionGUID: Pu7bgGWdRB292F8NepyWow==
X-CSE-MsgGUID: I3+QqWRnQZWdG2RX3ngGng==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77670599"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77670599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:37:25 -0700
X-CSE-ConnectionGUID: LV++u1zaSXm15/wOZgckRw==
X-CSE-MsgGUID: ueANhsdgQh+/0shTyaXZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="262567024"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 15:37:25 -0700
Date: Tue, 21 Apr 2026 15:37:22 -0700
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
Subject: Re: [Patch v2 2/4] perf/x86/intel: Disable PMI for self-reloaded ACR
 events
Message-ID: <aef8InBGlZaXNuPk@tassilo>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
 <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420024528.2130065-3-dapeng1.mi@linux.intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240253-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 62BDF440343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:45:26AM +0800, Dapeng Mi wrote:
> @@ -3306,6 +3306,15 @@ static void intel_pmu_enable_event(struct perf_event *event)
>  		intel_set_masks(event, idx);
>  		static_call_cond(intel_pmu_enable_acr_event)(event);
>  		static_call_cond(intel_pmu_enable_event_ext)(event);
> +		/*
> +		 * For self-reloaded ACR event, don't enable PMI since
> +		 * HW won't set overflow bit in GLOBAL_STATUS. Otherwise,
> +		 * the PMI would be recognized as a suspicious NMI.
> +		 */
> +		if (is_acr_self_reload_event(event))
> +			hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
> +		else if (!event->attr.precise_ip)
> +			hwc->config |= ARCH_PERFMON_EVENTSEL_INT;

It seems weird to either clear or set the bit. You don't know the previous
state of the bit here? I would assume it starts with zero?

> +static inline bool is_acr_self_reload_event(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->idx < 0)
> +		return false;
> +
> +	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);

Are you sure this doesn't conflict with some other non ACR usage of config1?


-Andi

