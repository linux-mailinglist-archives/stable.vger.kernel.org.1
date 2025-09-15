Return-Path: <stable+bounces-179653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C691B585DB
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA53F483CDA
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00928E5F3;
	Mon, 15 Sep 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESdlTdOP"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CB28F948
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967331; cv=none; b=GBDXMeIF5Bs5N2prAKUtAa3siosCoVLevHCDBXqIKgYuB2WOyZ9BwyHoMqWcCT8kCOyXKjC3gJqZtBukiCBdMRmF2oprO5Af1Z3sQ044fdnGRf8XHeg9FojPmuenlifWZXXUL7KoNn5SlUMyxTrPQ+YUhb38gbazA+v+T7f+tnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967331; c=relaxed/simple;
	bh=wWwx5SwaBv+9/Y7GF7bBTitX8HYbR/n1WZNDRyIeVog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m98z1lXfKh8gA15R2wPDMZG1lDqIq2G/NcXP6UqE1mFJnNl7GUqo1HviZFfYpKpDFGLN1nCEABBV2QPGcZ2lUmCtRUv+RHs5Dndinv/IxFmn+g8TITk4yZc5M6vOGbjfGsd/BbAs9ZaMsB4CWdoXJlFJWDMLYUKKIzxSFRAKZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESdlTdOP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Sep 2025 13:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757967327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fiu+/JsF0ratR6bMwfydxpKbaWu9OWoA9n/p9dm5StU=;
	b=ESdlTdOPYdfNqWIXfz9dOUsepNFdwyUi8hsnxPSA4jzzwt1/+IicKrIvaTZyo58cSDjp7v
	vLhvniA7lUfOvs9uDpqIKunxfeZSJiNTuqJi9pMf6mnpDEhOQ6zuXn4rLbKQMlyH3kbN0O
	XD6cdBVT1FMy7xAivKX/c8lF4xAQR54=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, souravpanda@google.com, 
	kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] slab: mark slab->obj_exts allocation failures
 unconditionally
Message-ID: <dia6xv4liysr54vdjfpw3bucbvg3eqh4nn4jh57h5htxev2zy6@rtnakdtz7vjb>
References: <20250915200918.3855580-1-surenb@google.com>
 <20250915200918.3855580-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915200918.3855580-3-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 15, 2025 at 01:09:18PM -0700, Suren Baghdasaryan wrote:
> alloc_slab_obj_exts() should mark failed obj_exts vector allocations
> independent on whether the vector is being allocated for a new or an
> existing slab. Current implementation skips doing this for existing
> slabs. Fix this by marking failed allocations unconditionally.
> 
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
> Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
> Closes: https://lore.kernel.org/all/avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org # v6.10+

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

