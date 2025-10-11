Return-Path: <stable+bounces-184046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55CBCEF75
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E14E2906
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652D1CF5C6;
	Sat, 11 Oct 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKnB9JPc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7119191484;
	Sat, 11 Oct 2025 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154463; cv=none; b=rAECdyo6c6BMfH3n6sPtbTuwCMO4U9/fK7oHhoh/u2RsMYl0cNa7zp+YWtDQAhDK7wk/VMxLgZQn4fZMdf4R6lhKOdEu9Yv+kWnF3czGeYCojAZCwfy3pnFsrRHOQaiXw16cWj6C0m8ZNyT2VA8W5sk6tcr9EDQHZh5ntcBD/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154463; c=relaxed/simple;
	bh=umkyust5VvRIrGUPJXzaingfDytZkfJzU1iziKjY5IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSeQEvYfsRbSXddVF9tt4JBCJvM4Pz8CNM3nJJDU7Oyt7ZnsrWxLhEDV1vcjFzutGgd8gTqEWKpdopEVojqbv8dvnP+PcMQdR8edUiigqmnwH6A77Map08QtNwNBVMOyDXix3PJx5c1d6LtmF7QE4c3dw1X4+tCJQU/iGIhqta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKnB9JPc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760154462; x=1791690462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=umkyust5VvRIrGUPJXzaingfDytZkfJzU1iziKjY5IE=;
  b=aKnB9JPcdo+xU4x0dL7YhpFrnoHmZPmoCZVIpM0z7y0YpMTDcO1yAnfe
   bJ4xDcjz3VNI/EgY7pvVy9FqcqlnU4A6O8wgTHJKASYWqrPdx9GPOfiS1
   nlNYZ5eQdjnaGfuPByyOzw6ZcT+eF9SaNYv7jDkXArx/TlmH2gSO0JLLO
   C2H4cNd5qA9ogAbMJPO9uaKLzo74P/dPAhkArwT1KbJGrdMao6v4stNgr
   IgSN0wLh5QIPoadLy3JeCyPXYGcDumymQpo4GphesbhixRNqkIOale6Y6
   6yFciAGQSpc5zO7l/vr/H58h6upV1gkP7qhYEP04aj/ZIEfFtWqjMBbWt
   w==;
X-CSE-ConnectionGUID: fXBMnQqiSfCgnyzcLRkc+Q==
X-CSE-MsgGUID: Qxww27EqQyWxEk8SPv7Zhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62413147"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62413147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:47:42 -0700
X-CSE-ConnectionGUID: ky8XLXWyQXuYeJfj3+t3sQ==
X-CSE-MsgGUID: wK3iIWsuSL+kslTBHQbu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="181551672"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 20:47:37 -0700
Message-ID: <479d0898-db4a-4112-a97c-26cfd7ab04b1@linux.intel.com>
Date: Sat, 11 Oct 2025 11:47:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf lzma: Fix return value in lzma_is_compressed()
To: Miaoqian Lin <linmq006@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250828105048.55247-1-linmq006@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250828105048.55247-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/28/2025 6:50 PM, Miaoqian Lin wrote:
> lzma_is_compressed() returns -1 on error but is declared as bool.
> And -1 gets converted to true, which could be misleading.
> Return false instead to match the declared type.
>
> Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  tools/perf/util/lzma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
> index bbcd2ffcf4bd..c355757ed391 100644
> --- a/tools/perf/util/lzma.c
> +++ b/tools/perf/util/lzma.c
> @@ -120,7 +120,7 @@ bool lzma_is_compressed(const char *input)
>  	ssize_t rc;
>  
>  	if (fd < 0)
> -		return -1;
> +		return false;
>  
>  	rc = read(fd, buf, sizeof(buf));
>  	close(fd);

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



