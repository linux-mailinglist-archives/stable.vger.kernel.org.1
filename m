Return-Path: <stable+bounces-189158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F08C02C84
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2991AA55E2
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BA254AE4;
	Thu, 23 Oct 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToeDG3xJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B321E25E3;
	Thu, 23 Oct 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241543; cv=none; b=lasYhCZZ+w5BkZ0f7S9kqhnM/GBkbGUUGVbmERjCuUC2fk+1OJHxvM26QRGrUcn0YSPxN8KpNb/8pGxRIRZ4vbn+8ibzOD1NBn/NV5jbyoHyHnC6xB7nkgf1moxuCNmBYj4DkclREgdzK7qxnEuvsULnjd1txVlxgHob3t6hVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241543; c=relaxed/simple;
	bh=aupfyZ0dQEOMOU8f8kK1fbR1Wu40hd/sy7Db+739CTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izM0dtJe5uJwC7GGaXBcMlLYeA/qWxHPql98WVI5RCT3twBn6oxmGZoW4T4ranJiuX2fvCWeKfIELLtskBKPO3CEBVg9uZ0sDTfGzYT7o+6cRxO0tRMXIxjh6IgSMj0rCIerXHrfAR8WCat3LxL3xKq/affwWP6p384Fq6K5Xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToeDG3xJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761241542; x=1792777542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aupfyZ0dQEOMOU8f8kK1fbR1Wu40hd/sy7Db+739CTs=;
  b=ToeDG3xJeFjwoH1rIHY1GG5MtAvqMxKUmgsNXUH8mA8OWk86W9OoQaX5
   b585HuWYrksOA4LR+b4s1UGsAZ2crWweOgMplIyvz02V5iRWOQZ9W3D+Q
   2jFrWbe95Z5LsYhZbEcOjXPwzHDzrGxliWJFziinBYIs2qDOyfDREUZ4v
   BmzfmZYkXS+MPyohhjTVR4+eEIYUciJ4dwVtCRKImKfABaEssyC5tW1hN
   fB1Hp4GAiLzqBpksoyhKAuhm4iRGa+l1GDs9bVK0bHj/s3xEnXQnz+a2a
   CLp2aO4qA0VWX4KYxVPNTyvr6z/nA3xELhyofeq1Y+zKzeGwLDSmLXy1G
   A==;
X-CSE-ConnectionGUID: MHyi/qrpTvWkIsKXDLNx5w==
X-CSE-MsgGUID: Q5GEh41PR/6AVLEEXRDHYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67258637"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67258637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:45:41 -0700
X-CSE-ConnectionGUID: 0/pJMXcCSaqrx/OrHfkugg==
X-CSE-MsgGUID: PtGFSRtAR6acHaWjz36QRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183442050"
Received: from unknown (HELO [10.241.241.181]) ([10.241.241.181])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:45:41 -0700
Message-ID: <400d2ef8-07bd-4620-ace8-6eaa05cd200b@intel.com>
Date: Thu, 23 Oct 2025 10:45:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix KASAN global-out-of-bounds warning
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20250904012419.266400-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20250904012419.266400-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/2025 6:24 PM, Dapeng Mi wrote:
> When running "perf mem record" command on CWF, the below KASAN
> global-out-of-bounds warning is seen.
> 
>   196.273657] ==================================================================
> [  196.273662] BUG: KASAN: global-out-of-bounds in cmt_latency_data+0x176/0x1b0
> [  196.273669] Read of size 4 at addr ffffffffb721d000 by task dtlb/9850
> 
> [  196.273676] CPU: 126 UID: 0 PID: 9850 Comm: dtlb Kdump: loaded Not tainted 6.17.0-rc3-2025-08-29-intel-next-34160-g316938187eb0 #1 PREEMPT(none)
> [  196.273680] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.IPC.3544.P83.2507110208 07/11/2025
> [  196.273682] Call Trace:
> [  196.273683]  <NMI>
> [  196.273684]  dump_stack_lvl+0x55/0x70
> [  196.273689]  print_address_description.constprop.0+0x2c/0x3d0
> [  196.273694]  ? cmt_latency_data+0x176/0x1b0
> [  196.273696]  print_report+0xb4/0x270
> [  196.273699]  ? kasan_addr_to_slab+0xd/0xa0
> [  196.273702]  kasan_report+0xb8/0xf0
> [  196.273705]  ? cmt_latency_data+0x176/0x1b0
> [  196.273707]  cmt_latency_data+0x176/0x1b0
> [  196.273710]  setup_arch_pebs_sample_data+0xf49/0x2560
> [  196.273713]  intel_pmu_drain_arch_pebs+0x577/0xb00
> [  196.273716]  ? __pfx_intel_pmu_drain_arch_pebs+0x10/0x10
> [  196.273719]  ? perf_output_begin+0x3e4/0xa10
> [  196.273724]  ? intel_pmu_drain_bts_buffer+0xc2/0x6a0
> [  196.273727]  ? __pfx_intel_pmu_drain_bts_buffer+0x10/0x10
> [  196.273730]  handle_pmi_common+0x6c4/0xc80
> [  196.273734]  ? __pfx_handle_pmi_common+0x10/0x10
> [  196.273738]  ? intel_bts_interrupt+0xd3/0x4d0
> [  196.273740]  ? __pfx_intel_bts_interrupt+0x10/0x10
> [  196.273742]  ? intel_pmu_lbr_enable_all+0x25/0x150
> [  196.273745]  intel_pmu_handle_irq+0x388/0x700
> [  196.273748]  perf_event_nmi_handler+0xff/0x150
> [  196.273751]  nmi_handle.part.0+0xa8/0x2d0
> [  196.273755]  ? perf_output_begin+0x3e9/0xa10
> [  196.273757]  default_do_nmi+0x79/0x1a0
> [  196.273760]  fred_exc_nmi+0x40/0x90
> [  196.273762]  asm_fred_entrypoint_kernel+0x45/0x60
> [  196.273765] RIP: 0010:perf_output_begin+0x3e9/0xa10
> [  196.273768] Code: 54 24 1c 85 d2 0f 85 19 03 00 00 48 8b 44 24 18 48 c1 e8 03 42 0f b6 04 28 84 c0 74 08 3c 03 0f 8e 25 05 00 00 41 8b 44 24 18 <c1> e0 0c 48 98 48 83 e8 01 80 7c 24 2a 00 0f 85 f9 02 00 00 4c 29
> [  196.273770] RSP: 0018:ffffc9001cf575e8 EFLAGS: 00000246
> [  196.273774] RAX: 0000000000000080 RBX: ffff88c1a0f95028 RCX: 0000000000000004
> [  196.273775] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88c08c8f9408
> 
> [  196.273777] RBP: 0000000000000028 R08: 0000000000000000 R09: ffffed18341f2a05
> [  196.273778] R10: ffff88c1a0f9502f R11: ffff88c1a0dbe1b8 R12: ffff88c1a0f95000
> [  196.273779] R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9001cf577e0
> [  196.273782]  </NMI>
> 
> The issue is caused by below code in __grt_latency_data(). The code
> tries to access x86_hybrid_pmu structure which doesn't exist on
> non-hybrid platform like CWF.
> 
>         WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big)
> 
> So add is_hybrid() check before calling this WARN_ON_ONCE to fix the
> global-out-of-bounds access issue.
> 
> Reported-by: Xudong Hao <xudong.hao@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 090262439f66 ("perf/x86/intel: Rename model-specific pebs_latency_data functions")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c0b7ac1c7594..d1ac1f1ceee9 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -317,7 +317,7 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
>  {
>  	u64 val;
>  
> -	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
> +	WARN_ON_ONCE(is_hybrid() && hybrid_pmu(event->pmu)->pmu_type == hybrid_big);

BTW, this line has more than 80 characters.

Reviewed-by: Zide Chen <zide.chen@intel.com>


>  
>  	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
>  	val = hybrid_var(event->pmu, pebs_data_source)[dse];
> 
> base-commit: 16ed389227651330879e17bd83d43bd234006722


