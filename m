Return-Path: <stable+bounces-106181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5F9FCF4F
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C96A1883352
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8EAD2C;
	Fri, 27 Dec 2024 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="huPuXAgO"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F36184F
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735260194; cv=none; b=astcF04LYDFd07xfEoBrmy4XUT7q9ulih8X0edaSRjk/GOUCiZS2dYJE1HrN+8v1TIvPw66ai4FGZC6oh55ILDw5slBULCU34xB9QhFNt/hJkvdBth0FhyepZ6OmvKRzagOzqtfrBDODFO99f8C3S6Jww3FeO/MYMYBGPuXzWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735260194; c=relaxed/simple;
	bh=ZHJ9Wm8Cc21f1V98AD4/fhuT5lbCQ4uw+01Zsuj/EvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdEsSjRDU9n3aeYiUPAiad7daB24MPPFomwAsE6alZNwpvSojOw0jrGs12rcotkrXodBFGwznXlkN2gDI092r3YOTZxW3quHEw2joKWqoOIE0Njpxk1o8wyWPWlcnkb3iGvhe9OK4N/UUsqmNZzFJud4E0LW78Z/1c602Tw5OrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=huPuXAgO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Dec 2024 19:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735260189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw22maXZajwmHe4lU3PEPYOvL49uRn6Y9HVjS0mNUIg=;
	b=huPuXAgOQ+iAnvgi0MKgQuU4dyLzEti9ke/QxevNYbaNpTP/DIhvWSdVyF23vjAqpL5JxH
	3Hh7KIKR4Q7spAatlyNE81+5Y5n3jseqcY+XKCQtMOftITGqJVoq/E8T+SdS6Jf/iPCG+j
	kMmwKnPyvBslw+/5uSGbaVE2L4Q4rKc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] alloc_tag: avoid current->alloc_tag manipulations
 when profiling is disabled
Message-ID: <zvihgtiazhc7rgvikplfy342bqejfnsskv6avhqtbzwufwijsd@g7azxbtjl7ud>
References: <20241226211639.1357704-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226211639.1357704-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 26, 2024 at 01:16:38PM -0800, Suren Baghdasaryan wrote:
> When memory allocation profiling is disabled there is no need to update
> current->alloc_tag and these manipulations add unnecessary overhead. Fix
> the overhead by skipping these extra updates.

I did it the other way because I was concerned about the overhead of
adding a huge number of static keys. But on further thought a static key
probably isn't any bigger than an alloc tag, no?

> 
> Fixes: b951aaff5035 ("mm: enable page allocation tagging")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/alloc_tag.h | 11 ++++++++---
>  lib/alloc_tag.c           |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 0bbbe537c5f9..a946e0203e6d 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -224,9 +224,14 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
>  
>  #define alloc_hooks_tag(_tag, _do_alloc)				\
>  ({									\
> -	struct alloc_tag * __maybe_unused _old = alloc_tag_save(_tag);	\
> -	typeof(_do_alloc) _res = _do_alloc;				\
> -	alloc_tag_restore(_tag, _old);					\
> +	typeof(_do_alloc) _res;						\
> +	if (mem_alloc_profiling_enabled()) {				\
> +		struct alloc_tag * __maybe_unused _old;			\
> +		_old = alloc_tag_save(_tag);				\
> +		_res = _do_alloc;					\
> +		alloc_tag_restore(_tag, _old);				\
> +	} else								\
> +		_res = _do_alloc;					\
>  	_res;								\
>  })
>  
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 7dcebf118a3e..4c373f444eb1 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -29,6 +29,8 @@ EXPORT_SYMBOL(_shared_alloc_tag);
>  
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>  			mem_alloc_profiling_key);
> +EXPORT_SYMBOL(mem_alloc_profiling_key);
> +
>  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
>  
>  struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
> 
> base-commit: 431614f1580a03c1a653340c55ea76bd12a9403f
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

