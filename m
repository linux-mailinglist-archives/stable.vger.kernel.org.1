Return-Path: <stable+bounces-215605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqYJcXOimkUOAAAu9opvQ
	(envelope-from <stable+bounces-215605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 07:23:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DC117587
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 07:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E213014125
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F34324B3C;
	Tue, 10 Feb 2026 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxrB0mmx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D2D193F;
	Tue, 10 Feb 2026 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770704540; cv=none; b=tMRJm0OEMxiOltfwvPmof7x6so8B7ZX6gfV1UgvLXTmQSD+RCQy4PpcwV0G81ogj2Vg6k+JmGjlrWNxL2sd0IpYFzGUXlUAnZ1CmqxEMkmw81fJA7BXUn/b5kqS8TbhFDlpOgiygBRZEe3vty/yEVeuZ/OouBb+ct4AB7sFveok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770704540; c=relaxed/simple;
	bh=ta00TBMjS7yckXa5FlBpp6OAjPcOtv7n8deRGQJPRWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWGbbB9Sfsg9TwJoqzYaGutrkPj8garz1E18cSTtwGd9aG7b1LxyeODlYqzwVHl1TQEyQprPA6YWpbS+9hafZNdty5i3ru5mRRhtA0rXfjPetx9eFawi0gzPDuEw37KyM8qK7cvyd9d425VSsQKUW9kj3kHZtgK7ItudsSHjyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxrB0mmx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770704539; x=1802240539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ta00TBMjS7yckXa5FlBpp6OAjPcOtv7n8deRGQJPRWc=;
  b=lxrB0mmxgAH2Y636fHEkm6sX8jMVwpS56qSMXrgOGjAqnqft2doYQimW
   imdSgi7CRCNeT41qyBVrUWnKyOvD3hyszVIxdsd1WhqkRFENIXIr9qQwL
   eNzm7FGGmRZM6qSjV1K0kiNuiqz5Jt295EOmZ3CMkYwJEbxfUd7H9ABcm
   EAQrxykvsu9gT3xnm9NIP3GMOFIsaHXy3KP8VTz+eViGg+Jk8Ntn0DDd6
   V14YrC+r8nDsWeTVZXrn5OWfrYD/jSVvCH5Ba8pk5WCVBihFnhXkO6FZX
   kwyHzlVJ424Yy5yrMcmgKa2WSlsZ8RawSte3MMs9bs9wMynrSHwGsjFLf
   w==;
X-CSE-ConnectionGUID: ODD1vYb4TeWG4n4bhzLDEg==
X-CSE-MsgGUID: JOtPOZTXR3ekorRhl3AUkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71035355"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71035355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 22:22:18 -0800
X-CSE-ConnectionGUID: MTopG9xJSYK46xZwy/6kDQ==
X-CSE-MsgGUID: QTJQxpFxR+CVvK62W8P6JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211029666"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184]) ([10.238.1.184])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 22:22:15 -0800
Message-ID: <436cb93d-f249-4517-b017-5d31920bfc8e@linux.intel.com>
Date: Tue, 10 Feb 2026 14:22:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Add per-scheduler IMC CAS count
 events
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Babu Moger <babu.moger@amd.com>, Tony luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 stable@vger.kernel.org
References: <20260210005225.20311-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260210005225.20311-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215605-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: BF5DC117587
X-Rspamd-Action: no action


On 2/10/2026 8:52 AM, Zide Chen wrote:
> IMC on SPR and EMR does not support sub-channels.  In contrast, CPUs
> that use gnr_uncores[] (e.g. Granite Rapids and Sierra Forest)
> implement two command schedulers (SCH0/SCH1) per memory channel,
> providing logically independent command and data paths.
>
> Do not reuse the spr_uncore_imc[] configuration for these CPUs.
> Instead, introduce a dedicated gnr_uncore_imc[] with per-scheduler
> events, so userspace can monitor SCH0 and SCH1 independently.
>
> On these CPUs, replace cas_count_{read,write} with
> cas_count_{read,write}_sch{0,1}.  This may break existing userspace
> that relies on cas_count_{read,write}, prompting it to switch to the
> per-scheduler events, as the legacy event reports only partial
> traffic (SCH0).
>
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Fixes: 632c4bf6d007 ("perf/x86/intel/uncore: Support Granite Rapids")
> Fixes: cb4a6ccf3583 ("perf/x86/intel/uncore: Support Sierra Forest and Grand Ridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index e513056f4562..b78a1782fc39 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6640,6 +6640,32 @@ static struct intel_uncore_type gnr_uncore_ubox = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct uncore_event_desc gnr_uncore_imc_events[] = {
> +	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x01,umask=0x00"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0,  "event=0x05,umask=0xcf"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch0.unit, "MiB"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1,  "event=0x06,umask=0xcf"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read_sch1.unit, "MiB"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0, "event=0x05,umask=0xf0"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch0.unit, "MiB"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1, "event=0x06,umask=0xf0"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write_sch1.unit, "MiB"),
> +	{ /* end: all zeroes */ },
> +};
> +
> +static struct intel_uncore_type gnr_uncore_imc = {
> +	SPR_UNCORE_MMIO_COMMON_FORMAT(),
> +	.name			= "imc",
> +	.fixed_ctr_bits		= 48,
> +	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
> +	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
> +	.event_descs		= gnr_uncore_imc_events,
> +};
> +
>  static struct intel_uncore_type gnr_uncore_pciex8 = {
>  	SPR_UNCORE_PCI_COMMON_FORMAT(),
>  	.name			= "pciex8",
> @@ -6687,7 +6713,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
>  	NULL,
>  	&spr_uncore_pcu,
>  	&gnr_uncore_ubox,
> -	&spr_uncore_imc,
> +	&gnr_uncore_imc,
>  	NULL,
>  	&gnr_uncore_upi,
>  	NULL,

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



