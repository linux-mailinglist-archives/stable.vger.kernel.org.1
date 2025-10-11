Return-Path: <stable+bounces-184047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D943BCEF7B
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0B684E6640
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99F191484;
	Sat, 11 Oct 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw53tR5X"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358B3D6F;
	Sat, 11 Oct 2025 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154544; cv=none; b=dJeFO8yFjwwAbLi2MQectRJZq3U9v+wggxAPF9gWMnH0fHzR5tThxRzuTRvmLXia/DqZEZAfLw5x3a0x3mzZjeM5P0sNKFHX7WD/bW5b4XOSHchZIThakjbBneRPd2c98bulshM4wU6+ZH7c1zpPPFRFOm5VcYm4YB7jr219Qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154544; c=relaxed/simple;
	bh=rnrQ3OGk44itas8W4eJo4nmGnOlFqBBc9NPO6lnnEDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEYdLgnjK6XY5iYgciYqhyI3aarWbZ6HC/cDI8z9cYnY59eD39J5CAjdwdxqvUcKwzlX03UYK98AitWXkgQ/VkKl581NcpfTVd9cl/56HybiGt07zPeXpCHRvfsb+d11i1iDTz0dlyC5RiDAjjz3YPUvo4MQeB8XPY44pJEKMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw53tR5X; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760154543; x=1791690543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rnrQ3OGk44itas8W4eJo4nmGnOlFqBBc9NPO6lnnEDA=;
  b=Tw53tR5X+oOqiWli0E0V87VHh0FLrd+N7vi5AIZ1w9jnTh+X2Du6K5Za
   tCHX+DH5lLr3EtL70n5yYn7US0iyLMoBi6IE/zQSrLUEVRUY1Qraqw77E
   L9+M2dI7nKgbTwuLWuNEUMAGPYLXdZ3MOKPUY6pEnP4458CtqwG08QWOz
   OIaAudqUcVCmBeJqC9Ad/+XU2NFJyx7KB0YKpNiXuis3vIeclTaCL2HbZ
   ysicmxsJV+wxDXE2Ge3KE/zJMIOBGgY82iGlih0W2WBiiW2t18bcPRtPP
   YHtJDoVA6jh/bz6SoVWQu1k0/k5C2F+lo45SXEaYlaHDIxYCLGwCju+Ms
   A==;
X-CSE-ConnectionGUID: JUsCNzkdQK6eM/HTTeXe6A==
X-CSE-MsgGUID: u4aVOm/STk2j9YLBZj5nOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66200985"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66200985"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:49:03 -0700
X-CSE-ConnectionGUID: EexjwlGBQFW2ha7So1UJag==
X-CSE-MsgGUID: BNBriDgxQWeMF3uoqckbCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180812312"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:48:58 -0700
Message-ID: <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>
Date: Sat, 11 Oct 2025 11:48:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix bool return value in gzip_is_compressed()
To: Miaoqian Lin <linmq006@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250828104652.53724-1-linmq006@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250828104652.53724-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/28/2025 6:46 PM, Miaoqian Lin wrote:
> gzip_is_compressed() returns -1 on error but is declared as bool.
> And -1 gets converted to true, which could be misleading.
> Return false instead to match the declared type.
>
> Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  tools/perf/util/zlib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
> index 78d2297c1b67..1f7c06523059 100644
> --- a/tools/perf/util/zlib.c
> +++ b/tools/perf/util/zlib.c
> @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
>  	ssize_t rc;
>  
>  	if (fd < 0)
> -		return -1;
> +		return false;
>  
>  	rc = read(fd, buf, sizeof(buf));
>  	close(fd);

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



