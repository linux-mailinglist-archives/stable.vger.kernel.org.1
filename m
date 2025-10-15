Return-Path: <stable+bounces-185851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0DBE03B7
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 20:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EF400C40
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30682D837E;
	Wed, 15 Oct 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PL2LUj2G"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081A27E05F
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553893; cv=none; b=NOgK9JMWWdugOivKvVZ8hZGwnRpk5OGfwZEgCISPkZ1zsD5fWs072WIgxMmgXZK2mWCM3Q+1fBZm3usKbuzU9vYpxzTNSlN6FOw2Xz1bgDbPz234rKVvnH873vdYTlNqYDSfiJoZRkZn2M+EZ1TIjHelRhtA4DFTGri9HKSISC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553893; c=relaxed/simple;
	bh=vJt2samCRmYLdQKY01Hke1/HG/H/GCAFpfcw1LZJqHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANpFwfdXNqvlXxeu3L4briZo50wSycCFKt/GExV2W9uzZ3MYCHqzQkojcrc/3h9NxVpqZtLIxvR/53YS67YOJ1RAK1gWajSfcU+34PD7gB21OVYP2mvV4rq5HfLOIXxBKv28WhiL116GAyRl2+wMBNLdzAC/oNgvOaT2JIJfp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PL2LUj2G; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4417d8bb6d3so564529b6e.0
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760553891; x=1761158691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkI3CPsEoef6DKq/9XSIUcKhl/lHGn2p9yW3ie99PjU=;
        b=PL2LUj2Gzzz/bMdpkZd03HiK1SGuu+QROT7PYUfL3GJvgD7xJl0IPyLyDX1XV85rcl
         wx7WCyAH4J+1kdygRRotkEA3hhMcriPeQDGoDGu5B37ZHFAa8DX4F/V77NgG3vAd10PA
         shTJ9DvGk4ukkvFb25iiZQb48Gw7bbNMLZA4+sYu9qHBIgdWkAzOWnxmbmU7jeF3qtHL
         +FiC/DvOowgqEBqqiFBNn2LeLShw9JRB7PRqY2ktYkzt9fOx294UNSs8txXqJSXfUGDg
         Wa9VIHb+dTpG+G0w6hV5A9YCvmCFWH09L0wCH8npq5EciVY4okbjvK5PSH++NFqWM90C
         FNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553891; x=1761158691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkI3CPsEoef6DKq/9XSIUcKhl/lHGn2p9yW3ie99PjU=;
        b=WYNFO+NP2TW2//8yyvcVGWCe2+SVgHoz6reqGCG1fPjuuMishvVsFNcUGP5uoEvJnp
         kZ1M1oa3nOkB9Bya5pzpv5M16BIjn5baKY6oPSPaYPjuoruViSe4bI4KK3b6mNLjkqJV
         /sFV/ycKLcfOvgMw0+akniwVcRtp3SFpq30EhrZU4fKb7DAfw4McuZY1CQ77ADudqFHP
         lHXLTm/XnnWEczk2lngayWGJd4NGk9GJu1XM/kdQpdNspC+jrvLOJW8e9EfQD0g4FhXU
         1oV/ANhzgRZ39/aHlgDNhveZvHhwU3DJ6qQ+AwSNWXuZhD4szYC06lKEqxTdD+AzWd5a
         ea2g==
X-Gm-Message-State: AOJu0YzNtwlPUIj+RinjFnWwzMk1Q7wRs7q0R07SrNJaU2Nxl2XELxcN
	+05GT/M1FPIyTxt1qYaNJVz6qcfBx/49xhG4d0UYnn8/qajJKa7oyoRu4DbMMoP8Nu3Lo1/H6sD
	Hn+vjp60=
X-Gm-Gg: ASbGncvfhCZcJlfDkDocLBdLCTTKURTvoPardZxlNjlo1f47ltls6hsxbzMSdqoTm/9
	DBbzU8TqZLyk5NytD3WvB/8nvSu0RZAnvZV7Q8tdfsk9EntL1sh8YxvgQ5QRgHcMGTflpS+QbXx
	VPmS44oonm/lj87UrXGAG09Gf9OVofFtKK6yPYzi0T8+0h13nELJjmJTV/xkAVczEcNHncgEd2G
	8Xf19zbgrD6MHrgUAaqHfFnislPt4J7J2FYPXdIr9TqNVgKTSeDVY3qJzAI5MaLUWNC+MPvl3Xl
	fzK6iflwdkffqG2pBdb0BCY9DpIvHywMaOV3H8HUfatQl9MroV0YRAZUr6p2r8SWsA1jbijCicY
	G0rHjuWi5VBQnDEJjAeDfdAts5EwbWcAYO2uJcik4y0YphQ==
X-Google-Smtp-Source: AGHT+IG8tfx8ZhbpF/8aVVaXnahrHLTfmvmyn3nCS8l6Jlt4G3qEjfaephuN623Xa7KcvJYgLLVpTw==
X-Received: by 2002:a05:6808:1b25:b0:441:8f74:eff with SMTP id 5614622812f47-441fb9761a4mr625518b6e.28.1760553891069;
        Wed, 15 Oct 2025 11:44:51 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::281:e4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441987494ccsm4180825b6e.0.2025.10.15.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:44:50 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:44:49 -0500
From: Chris Arges <carges@cloudflare.com>
To: stable@vger.kernel.org
Cc: kernel-team@cloudflare.com, Peter Zijlstra <peterz@infradead.org>,
	David Wang <00107082@163.com>, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] perf: Fix dangling cgroup pointer in cpuctx
Message-ID: <aO_roag9qzfkRztQ@861G6M3>
References: <20251007164556.516406-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007164556.516406-1-carges@cloudflare.com>

On 2025-10-07 11:45:52, Chris J Arges wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> [ Upstream commit 3b7a34aebbdf2a4b7295205bf0c654294283ec82 ]
> 
> Commit a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting
> bug at task exit") moves the event->state update to before
> list_del_event(). This makes the event->state test in list_del_event()
> always false; never calling perf_cgroup_event_disable().
> 
> As a result, cpuctx->cgrp won't be cleared properly; causing havoc.
> 
> Cc: stable@vger.kernel.org # 6.6.x, 6.12.x
> Fixes: a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  kernel/events/core.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3cc06ffb60c1..6688660845d2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2100,18 +2100,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>  	if (event->group_leader == event)
>  		del_event_from_groups(event, ctx);
>  
> -	/*
> -	 * If event was in error state, then keep it
> -	 * that way, otherwise bogus counts will be
> -	 * returned on read(). The only way to get out
> -	 * of error state is by explicit re-enabling
> -	 * of the event
> -	 */
> -	if (event->state > PERF_EVENT_STATE_OFF) {
> -		perf_cgroup_event_disable(event, ctx);
> -		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> -	}
> -
>  	ctx->generation++;
>  	event->pmu_ctx->nr_events--;
>  }
> @@ -2456,11 +2444,14 @@ __perf_remove_from_context(struct perf_event *event,
>  	 */
>  	if (flags & DETACH_EXIT)
>  		state = PERF_EVENT_STATE_EXIT;
> -	if (flags & DETACH_DEAD) {
> -		event->pending_disable = 1;
> +	if (flags & DETACH_DEAD)
>  		state = PERF_EVENT_STATE_DEAD;
> -	}
> +
>  	event_sched_out(event, ctx);
> +
> +	if (event->state > PERF_EVENT_STATE_OFF)
> +		perf_cgroup_event_disable(event, ctx);
> +
>  	perf_event_set_state(event, min(event->state, state));
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
> -- 
> 2.43.0
>

Hi, can this patch be applied to stable 6.6.x and 6.12.x?

Thanks,
--chris

