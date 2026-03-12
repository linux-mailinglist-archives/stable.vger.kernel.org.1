Return-Path: <stable+bounces-224781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCzWG7YesmlwIwAAu9opvQ
	(envelope-from <stable+bounces-224781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:02:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B926C0F1
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B56493021D2C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797C34750A;
	Thu, 12 Mar 2026 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZPgc2Fn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613B45039;
	Thu, 12 Mar 2026 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280947; cv=none; b=TTJSXpfs2xyF7htjg5jgeX6Y5fZAoG2Dx/AP/UeHhZNk5NGlWic3HGBGrBXio/j1GCAFtyWvjwYwfrrsrA2T1QT2MIh674Q51fkYkAiS0ZJl49mO1d8l5FH+EAbuqlCS3Tpb7m0N0iuAXoP8MYA0VvP7Ms8cgXS+tXOLZ1gfFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280947; c=relaxed/simple;
	bh=M8le9hNO0YwwcjywIwQignBdb2RqR6+jbV4mLbCKk0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKH7ghYoe3ryueVOVr017LWihp6Tzt72N3xwSHswtocmOD/jVgY6A9pyWh4oH8SClWzmoZQYxX/3YcZoqY7P6D0qNBL9+TAOv2MQcpYK6zhC/nBtfBTHmQYMgQWivipnoCsx28xLy6xs5iHPZKLxC5YI5ogD5sIMKmqHDuzEAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZPgc2Fn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773280946; x=1804816946;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8le9hNO0YwwcjywIwQignBdb2RqR6+jbV4mLbCKk0k=;
  b=BZPgc2FnrljTy0rDVqQK6kiMriqs3P3rGrLkfIQx+Qfa2ijKDNF/25sS
   TecrJIbvJ2pxWBi8YLL5yVYpwejvqkFZniU3JoVYllrr8xn4dl66lPFZC
   7yrRKli58QZHQc4o9taW9WKcaOHZlT9OZcjSAxHC3m1Kl/51/8NWCnoqc
   R8Gnz6gH5RYJtRCoRglvcyiOkcl/kc5WP01uuHUmB8PoHJC4f4rQ1BiRN
   NbEb89ERi9dZnsFDp3Zyxi3iIU8k47Kglik/orM9DPWCB7r0dxrwv6VnU
   v+L5Ou5Z+OMzdhGR42+f8RGPY9KPPSho9cOZJeFIkmS7yjmfhfepoUdA9
   w==;
X-CSE-ConnectionGUID: WdbUznw3QEmfnidm114KIA==
X-CSE-MsgGUID: 8oyrJkPqSPWDYiMEPvrcdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85451434"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85451434"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:02:25 -0700
X-CSE-ConnectionGUID: G1E+37ZSR6mTo+KMwXttcg==
X-CSE-MsgGUID: ecd6+WcSTEKDGGupllc/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="220842502"
Received: from unknown (HELO [10.238.3.214]) ([10.238.3.214])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:02:21 -0700
Message-ID: <b7eedb9a-ecfa-4f9d-9c73-b20dc2a5e217@linux.intel.com>
Date: Thu, 12 Mar 2026 10:02:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
To: Peter Zijlstra <peterz@infradead.org>, "Chen, Zide" <zide.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
 <6e2e5d3e-0906-43af-8816-f9f812e7e0aa@intel.com>
 <20260311200340.GV606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311200340.GV606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-224781-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B94B926C0F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/2026 4:03 AM, Peter Zijlstra wrote:
> On Fri, Mar 06, 2026 at 05:27:35PM -0800, Chen, Zide wrote:
>>
>> On 2/27/2026 9:33 PM, Dapeng Mi wrote:
>>> When running the command:
>>> 'perf record -e "{instructions,instructions:p}" -j any,counter sleep 1',
>>> a "shift-out-of-bounds" warning is reported on CWF.
>>>
>>> [ 5231.981423][   C17] UBSAN: shift-out-of-bounds in /kbuild/src/consumer/arch/x86/events/intel/lbr.c:970:15
>>> [ 5231.981428][   C17] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>>> [ 5231.981436][   C17] CPU: 17 UID: 0 PID: 211871 Comm: sleep Tainted: G S      W           6.18.0-2025-12-09-intel-next-48166-g6cf574943ba3 #1 PREEMPT(none)
>>> [ 5231.981445][   C17] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
>>> [ 5231.981447][   C17] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.IPC.3544.P98.2508260307 08/26/2025
>>> [ 5231.981449][   C17] Call Trace:
>>> [ 5231.981453][   C17]  <NMI>
>>> [ 5231.981455][   C17]  dump_stack_lvl+0x4b/0x70
>>> [ 5231.981463][   C17]  ubsan_epilogue+0x5/0x2b
>>> [ 5231.981468][   C17]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe6
>>> [ 5231.981472][   C17]  ? __entry_text_end+0x158b/0x102259
>>> [ 5231.981475][   C17]  intel_pmu_lbr_counters_reorder.isra.0.cold+0x2a/0xa7
>>> [ 5231.981480][   C17]  ? __task_pid_nr_ns+0x134/0x2a0
>>> [ 5231.981483][   C17]  ? __pfx_intel_pmu_lbr_counters_reorder.isra.0+0x10/0x10
>>> [ 5231.981486][   C17]  ? __pfx_perf_output_sample+0x10/0x10
>>> [ 5231.981489][   C17]  ? arch_perf_update_userpage+0x293/0x310
>>> [ 5231.981491][   C17]  ? __pfx_arch_perf_update_userpage+0x10/0x10
>>> [ 5231.981494][   C17]  ? local_clock_noinstr+0xd/0x100
>>> [ 5231.981498][   C17]  ? calc_timer_values+0x2cb/0x860
>>> [ 5231.981501][   C17]  ? perf_event_update_userpage+0x399/0x5b0
>>> [ 5231.981505][   C17]  ? __pfx_perf_event_update_userpage+0x10/0x10
>>> [ 5231.981508][   C17]  ? local_clock_noinstr+0xd/0x100
>>> [ 5231.981511][   C17]  ? __perf_event_account_interrupt+0x11c/0x540
>>> [ 5231.981514][   C17]  intel_pmu_lbr_save_brstack+0xc0/0x4c0
>>> [ 5231.981518][   C17]  setup_arch_pebs_sample_data+0x114b/0x2400
>>> [ 5231.981522][   C17]  ? __pfx_x86_perf_event_set_period+0x10/0x10
>>> [ 5231.981526][   C17]  intel_pmu_drain_arch_pebs+0x64d/0xcc0
>>> [ 5231.981530][   C17]  ? __pfx_intel_pmu_drain_arch_pebs+0x10/0x10
>>> [ 5231.981534][   C17]  ? unwind_next_frame+0x11c5/0x1df0
>>> [ 5231.981541][   C17]  ? intel_pmu_drain_bts_buffer+0xbf/0x6e0
>>> [ 5231.981545][   C17]  ? __pfx_intel_pmu_drain_bts_buffer+0x10/0x10
>>> [ 5231.981550][   C17]  handle_pmi_common+0x5c5/0xcb0
>>> [ 5231.981553][   C17]  ? __pfx_handle_pmi_common+0x10/0x10
>>> [ 5231.981556][   C17]  ? intel_idle+0x64/0xb0
>>> [ 5231.981560][   C17]  ? intel_bts_interrupt+0xe5/0x4c0
>>> [ 5231.981562][   C17]  ? __pfx_intel_bts_interrupt+0x10/0x10
>>> [ 5231.981565][   C17]  ? intel_pmu_lbr_filter+0x27f/0x910
>>> [ 5231.981568][   C17]  intel_pmu_handle_irq+0x2ed/0x600
>>> [ 5231.981571][   C17]  perf_event_nmi_handler+0x219/0x280
>>> [ 5231.981575][   C17]  ? __pfx_perf_event_nmi_handler+0x10/0x10
>>> [ 5231.981579][   C17]  ? unwind_next_frame+0x11c5/0x1df0
>>> [ 5231.981582][   C17]  nmi_handle.part.0+0x11b/0x3a0
>>> [ 5231.981585][   C17]  ? unwind_next_frame+0x11c5/0x1df0
>>> [ 5231.981588][   C17]  default_do_nmi+0x6b/0x180
>>> [ 5231.981591][   C17]  fred_exc_nmi+0x3e/0x80
>>> [ 5231.981594][   C17]  asm_fred_entrypoint_kernel+0x41/0x60
>>> [ 5231.981596][   C17] RIP: 0010:unwind_next_frame+0x11c5/0x1df0
>>> ......
> That trace could be reduced to:
>
>   UBSAN: shift-out-of-bounds in /kbuild/src/consumer/arch/x86/events/intel/lbr.c:970:15
>   shift exponent 64 is too large for 64-bit type 'long long unsigned int'
>   ......
>   intel_pmu_lbr_counters_reorder.isra.0.cold+0x2a/0xa7
>   intel_pmu_lbr_save_brstack+0xc0/0x4c0
>   setup_arch_pebs_sample_data+0x114b/0x2400
>
> Without loosing anything valuable.

Sure.


>
>
>>> The warning occurs because the second "instructions:p" event, which
>>> involves branch counters sampling, is incorrectly programmed to fixed
>>> counter 0 instead of the general-purpose (GP) counters 0-3 that support
> So here you have 0-3, the normal 'range' notation, but then you go all
> funny and use ~ instead:

😂


>
>>> branch counters sampling. Currently only GP counters 0~3 support branch
>>> counters sampling on CWF, any event involving branch counters sampling
>>> should be programed on GP counters 0~3.
>>> Since the counter index of fixed> counter 0 is 32, it leads to the "src" value in below code is right
>>> shifted 64 bits and trigger the "shift-out-of-bounds" warning.
>>>
>>> cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;
>>>
>>> The root cause is the loss of the branch counters constraint for the
>>> last event in the branch counters sampling event group. This results in
>>> the second "instructions:p" event being programmed on fixed counter 0
>>> incorrectly instead of the appropriate GP counters 0~3.
> s/0~3/0-3/ ?

Sure.


>

