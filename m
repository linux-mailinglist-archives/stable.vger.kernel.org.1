Return-Path: <stable+bounces-72697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E056B9682FE
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E28E2811A5
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF231C2DC1;
	Mon,  2 Sep 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ieipzoJd"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E941C2DAD;
	Mon,  2 Sep 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268868; cv=none; b=YDwIl/KNLGWVN3AFyja8q5/m+/OENJE4RA6dIygeBXqeRh18naR/jwoYm3tWU6NAzvBPj1HDsn2KafK27KsLuZDpuoWxPsQBaj5KMQau6sou8tdaEchJ+cvO6+0fjTjaYMb6v066IBIwfyQ14nyHHyNjoBkugwc3eeKDDi3E1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268868; c=relaxed/simple;
	bh=Xqc71HLB9RR0YC17nm4rIyYdKPMvk+koNamcsCl4XCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcaNGz6IES9LMRvRh19Kh7yYsQxolB7Tfuqwpchi/M70PdQ9G5YO43radTUV75Vs7/+/msjithRq9I32QmVmWO473zwzx+xrDeA6k7w+rRzNG6qGwTKU1/Mgo3YEyvoDnqLBOzirMrI1mbfl65QSlkBrINDdzcR3VMBM94cDbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ieipzoJd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JAulFDgx3FvNWuvmiwL6YUk4T1Qk0lgDdU6iJ9PrymU=; b=ieipzoJdht1lg4dRdhmixmOKYT
	TI1E8SwgNJhQ/iAsP/lACajYfGU6idk4EFzXg2saJgDFwVUGnVStqhfvs7LnWFDYjXAfU7CphCk7C
	TFJR/IS6aAY14y2ANY7hEWNZtxAxJv3uUbGv1V6nst7BXGky7h6uvkYTqosVt+zzmIhaRUuCY+r6V
	HRCTjbYjYQ1pt7ZWvlEe1raNGTy5uJMDh4ORyhGAWUSl2+B1FguKXNbU/3PYJjiD+1qNeDmL+g/lX
	9SXEZyVfVfJfiuo2s3hTk+EQaq/OemlDBVUBy7YgXsGRMy2Il93jB2MWNA2SvjFXH1AUv3DLtMp7J
	lSFRbs4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl3F0-0000000C7Yt-1IzZ;
	Mon, 02 Sep 2024 09:20:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D9DAD300642; Mon,  2 Sep 2024 11:20:53 +0200 (CEST)
Date: Mon, 2 Sep 2024 11:20:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Fix small negative period being ignored
Message-ID: <20240902092053.GC4723@noisy.programming.kicks-ass.net>
References: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
 <20240831074316.2106159-2-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831074316.2106159-2-luogengkun@huaweicloud.com>

On Sat, Aug 31, 2024 at 07:43:15AM +0000, Luo Gengkun wrote:

>  kernel/events/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c973e3c11e03..a9395bbfd4aa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4092,7 +4092,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	period = perf_calculate_period(event, nsec, count);
>  
>  	delta = (s64)(period - hwc->sample_period);
> -	delta = (delta + 7) / 8; /* low pass filter */
> +	if (delta >= 0)
> +		delta += 7;
> +	else
> +		delta -= 7;
> +	delta /= 8; /* low pass filter */
>  
>  	sample_period = hwc->sample_period + delta;
>  

OK, that makes sense, Thanks!

