Return-Path: <stable+bounces-109238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228FA1381E
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D6E3A52F2
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90911DDC03;
	Thu, 16 Jan 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2uuhxG8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20061D63EF
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024050; cv=none; b=Bgt1JlAx2yF5cTViKvP7cCZRp7o4DRq8n9il7nM8801wfg2wEpMYtH7QHNSlhjM+0barpsQ0j85rS8rIj1uLfUl/6HLtj2U6ueiUioJUrjAzqZWCoiB5sxTGL+O9sZP5qMp2B43ezTv1WJaplgupOKxF3M69nt2bET8Md4S4Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024050; c=relaxed/simple;
	bh=FXr/R/ASTh37z1sRowGMoD+KS4XfQ1KUY2lWIB+fsm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMFHINSW2K1ZBNS/CyZJ6+r/diWaCJMTlVfL5yorCNak/ddzdQIiXsww3zJUNJJItHlpbBv3N1j/94HAYXj00nPQbfO9hWOutcM6bDwMJ1Wen41eQQuLeYtrsGlG2Yt172IxvGfXgM/JMiPti6LoNcCYKy1C5HQPJQEnmf5xAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S2uuhxG8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a34e8410bso381712f8f.2
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737024047; x=1737628847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO66lMiXI/Sfgw5U/SYlAlVA9b1JkDl1ZV2cUjyfDeo=;
        b=S2uuhxG8t3yRx9fYZgNa9BD6J7CV86GcTgAG7JnUuLOxGuO0kVeeesWIBLOtIQVJ+N
         8HMpXlEf0IAZFtIfrRQRgfbyZfr3bBUsgE8gJBKCUO5Ck8Uoz45UbkjkjzOVzql3OTvz
         rRYJAZgj81jFnj6Z30H0SP1cdwadJkRn8ys0i0oqayUDaxreaGDZK6PuU2KoMlbiyupM
         7EVofZb+6maXvdYiNbWE6uE2IvP5UdJSa8idBDWNmwDs0689nc4tJ2sejP6PhJ4wrGds
         OksisIUBPHEbtiqzGnmkrxWWH0fcqPoG0Z9AzjlYf7e0gkLFgUMYrgAJzZtxRdI5kdqF
         xmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024047; x=1737628847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO66lMiXI/Sfgw5U/SYlAlVA9b1JkDl1ZV2cUjyfDeo=;
        b=MllKZ4UNNNz/iglNQYikhXaVphh06Hr9Dq1r/bOC8W2kxzhNjZamwa4LJLr59pnfMk
         EKAqiP2OgQ8kgHrkE7V6AXqjGQc6z9hbcthkH9OhcU2ddAS6kvBT4VIF03wySDp7OGyV
         qWfezbLTZrptYbiiVBy5cCrhSijRtH7HdTNG+7fxq+60rWiaR/6AwOrEujTcaDemhBS+
         eH5TTvTYp99xnuQXkIZhl1Zj6dySJukeRGNwE1DKCTYGLMRNvZKZT6GmTTRV2AroRRAv
         VPQUkSSy8Nf5esOp+GfLwvSAesx4owcolZxdGNnU1M7gr77DkG4taQHCaB095ncmZbyV
         oYfA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DF0J8mk+J0v1+HAm+2QEVebXLUB5Dmd24joQF4+ZhOHjqT/06/uFC1Qqf7Iyo2XfH0vD7zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCZ9aXvd+ingfj+roZDiTD8g+bERB2rLLyaMk+NWoSoEWwnDW
	jvtEApBfb8WX0EN6mWRBs5yOA+1Fu0SEsL8PN7nnAnXOyDC68cTOWpEzxUc7tM0=
X-Gm-Gg: ASbGnctF6/aUFqcNfwTDvrZCv9ZgeefrudRD0yDLZa6nDRDTHhxEw7dZCqLd22lZIt/
	IZ6M3sssB5T1uoLqRd92h7AmiQGPXz5SSzxp1sYW1hsWtVTPAd7fcdnR1Jl+kF9CcSt5HbI/6+f
	vjf0GOL57qLIXBf6NopGkBeuVaaZvi5f1XtMzsyFu+qsC79eia7Rpfs4gWx16gybId9rNts/goN
	FeqybEF4Sb0FGZAA5g6xwVszTDjkyNvnn5eqzzeG8u/0rfwpR13BtyRUcziYvIPCw==
X-Google-Smtp-Source: AGHT+IENhP2degD2HSgnG/QrAKOGnMF+zY05b1bOVZLzbMSLYYZMykC89gMNgsoBqQE6xISFPPiCKA==
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id ffacd0b85a97d-38a87ccfd10mr22019911f8f.14.1737024047135;
        Thu, 16 Jan 2025 02:40:47 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bec32b96dsm1625787f8f.21.2025.01.16.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 02:40:46 -0800 (PST)
Message-ID: <d90e130c-984a-4b9f-8297-ead2857ab361@linaro.org>
Date: Thu, 16 Jan 2025 10:40:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf bench: Fix undefined behavior in cmpworker()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chun-Ying Huang <chuang@cs.nycu.edu.tw>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20250107073906.3323640-1-visitorckw@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250107073906.3323640-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2025 7:39 am, Kuan-Wei Chiu wrote:
> The comparison function cmpworker() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> In its current implementation, cmpworker() incorrectly returns 0 when
> w1->tid < w2->tid, which breaks both symmetry and transitivity. This
> violation causes undefined behavior, potentially leading to issues such
> as memory corruption in glibc [1].
> 
> Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> compliance with the C standard and preventing undefined behavior.
> 
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Rewrite commit message
> 
>   tools/perf/bench/epoll-wait.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index ef5c4257844d..4868d610e9bf 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -420,7 +420,7 @@ static int cmpworker(const void *p1, const void *p2)
>   
>   	struct worker *w1 = (struct worker *) p1;
>   	struct worker *w2 = (struct worker *) p2;
> -	return w1->tid > w2->tid;
> +	return w1->tid > w2->tid ? 1 : -1;

I suppose you can skip the 0 for equality because you know that no two 
tids are the same?

Anyone looking at this in the future might still think it's still wrong 
unless it does the full comparison. Even if it's not technically 
required I would write it like a "normal" one now that we're here:

   if (w1->tid > w2->tid) return 1;
   if (w1->tid < w2->tid) return -1;
   return 0;


