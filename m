Return-Path: <stable+bounces-206074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA61CFB840
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859DF302F6BC
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD21F0991;
	Wed,  7 Jan 2026 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meF8g/FL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90478F4A;
	Wed,  7 Jan 2026 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747542; cv=none; b=t2mVhuXRU6xsa76eYgZd/mvQM8wLJ0hLDTE4N6qBhFU5qLhdHCfyRi83T+1rDsqQqoESg3ALdTi34dZ/2984YyQyO1x7QR09R+8QwujGe90qhgM7bfMIJGybM7gYvk8+gsfmEhDpoZjsuOrBdG608Vbjcg5wSVjjcn5fNvaNVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747542; c=relaxed/simple;
	bh=g5N33WItghn5Ak5Sc2mPOtztyJVabSVuyo4LT/NAGi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMoWif8Oe6s63Q3Vt6Qe2TpRdLiokODpgLbNM2Zo9G+foWEl5MXTzHcGEHaVJaXe01VpN0MClPJSnXOcIXT6V7J4xMcky+NhmP/Dby57vYw8Pwd1GrGf5Hxn/3nRq+USDHVBurmNSDXMDCSrymWzh5Jq774fg5Q7ddB5Hjy6U0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meF8g/FL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767747540; x=1799283540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5N33WItghn5Ak5Sc2mPOtztyJVabSVuyo4LT/NAGi8=;
  b=meF8g/FLnbOtqOq3NAKUp3vnK+09M2bhwu3bQIagTRQIPyzQdZpt6dwz
   gfdxTtl7SBSeEZQQgRJP3G9hJH9aZDVxJPtthVENgBOTq5KsC8ywkIV2G
   SvhHNUU97LWdFeWg7jlqgTNDwRpmWM1uZEuVhAeAPkMEnq/bmI12qXQJf
   XyHDgFebu/kPK5umJuEiQDPKGCFs5fHi/L6bx2pWOTeXHyKs8+gCIWPWk
   h9y37Lj18wtY+yfHLJ9WlnxMsfQydfclrbTfY92prLDKh8EBjrqjCjH07
   fMTpuCSsSWYkns2cr/w+45CY6Wz889NjRedp71O8Kbm+ZyPfY2RuhtY0L
   A==;
X-CSE-ConnectionGUID: dKh2UrRNQTeHjWpy8h4Oqw==
X-CSE-MsgGUID: jc6uIGyNQ1yuDAp+eTbGBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69193153"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69193153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:58:59 -0800
X-CSE-ConnectionGUID: +hJOgo6OTeW8VIq5CdRQDA==
X-CSE-MsgGUID: NyMEJm/4TUGWCX+k9q84KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207847935"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:58:56 -0800
Message-ID: <e2a105fc-8b5c-4c7d-ba29-de8bb560cc85@linux.intel.com>
Date: Wed, 7 Jan 2026 08:58:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf Documentation: Correct branch stack sampling
 call-stack option
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

@Arnaldo, @Kim, @Ian

Kindly ping ... 

On 12/16/2025 9:39 AM, Dapeng Mi wrote:
> The correct call-stack option for branch stack sampling should be "stack"
> instead of "call_stack". Correct it.
>
> $perf record -e instructions -j call_stack -- sleep 1
> unknown branch filter call_stack, check man page
>
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
>
>     -j, --branch-filter <branch filter mask>
>                           branch stack filter modes
>
> Cc: stable@vger.kernel.org
> Fixes: 955f6def5590 ("perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index e8b9aadbbfa5..3d19e77c9c53 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -454,7 +454,7 @@ following filters are defined:
>  	- no_tx: only when the target is not in a hardware transaction
>  	- abort_tx: only when the target is a hardware transaction abort
>  	- cond: conditional branches
> -	- call_stack: save call stack
> +	- stack: save call stack
>  	- no_flags: don't save branch flags e.g prediction, misprediction etc
>  	- no_cycles: don't save branch cycles
>  	- hw_index: save branch hardware index
>
> base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821

