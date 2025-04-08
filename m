Return-Path: <stable+bounces-131821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F63A8136B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299841BA8154
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052B4236427;
	Tue,  8 Apr 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sa0ADJOg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B214AD2D
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132925; cv=none; b=jaOMCDGeHlpeLttKphiblKPxSzT1vjrdO0wpQWluVbHPkwKGhRUn113TZ8K0bYbgUJCrDrq1R0sQAZp+DEBV24e158pyRwqomhbVjr1xT4+BqvioSlgLybF5Q+8rKdBdbDv17fIkLSA7AkkDDKguZhkHfIyKaM7IJXdf6wEtH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132925; c=relaxed/simple;
	bh=v0CiySCFIMh8gX8ms1ZA6Lo+roQbGhFoAYSK+fQ9M7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YISBLQffpeJ1CH1HfApGGVKgGUgSYopTXXmgJz23fBaqmmC5wFeMv5baCpwqKHHHDx0y0qc6ir+BRLjT1nrVyUIkh9Nu/Gg1Q9odSs9v86beOgbqQEJ11geW9+stPkJXelGjQY67IsDAJ1XR+MXnHHn7mbkMw8fiSsxNgGmnQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sa0ADJOg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39c1b1c0969so5030546f8f.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744132922; x=1744737722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+luVGLBxL0+rbze1Xlp+FWE6ZfU74Gm/3Cw7pY07Gk=;
        b=sa0ADJOgXnLPKghtUUz9Ay+Zh000RU48wePKboqVRn335W8nPEWnNzaZIXagKTNF7w
         Exi90mdQZ6PQskOxCEdMEtbvwMSPTTwESnfW7H6+20CBbfQJXffiewvd0wCwuiLr8x+Y
         sYEAXxryI1o+h4meYIXWtJKwGUdfB5HMstz4FaJxJLGHZdkE6NR1e7DqUBmHhiTI0/qO
         BGmDsVs5zPRyBBh7XfPqTMJe5vPptSnj41Ee0PVF2uHeStbdBo5fohhmqaGuwrlx8wIo
         buRvYw8fGuS/zb+chlZ0yY3LFopQPa4qyMbEQTam+0TAKpR1BlSfF213BZPaGfISXtAr
         4oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744132922; x=1744737722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+luVGLBxL0+rbze1Xlp+FWE6ZfU74Gm/3Cw7pY07Gk=;
        b=uYW2FOTQjdDpdSUiuWqAIwWc1lYB0AZnDMs39Spr1H8MJrfm2pUSasS8NimnAcScza
         E+NYST/0+Uqif+arp2tf1z8U4ayIkfxP+B8s4UYGDSx90E626o40ZBxwaMSvN963svyE
         vAaopJ9W3+WBDc0Lu0r2p567BDfMLTouRkAG7y0wvF97c8IoDMmo2EsTuVVB6ayXzfKy
         z8eU9VGnTtuYzxLfHzaCgEbZDf++Mr6mzEPWOxqb/+LLN6Jvz48B6JRGrUqrKhSVi8+F
         Mmg9qwXenFDgZAikaD0iFhWWCCxKQPKofvmW1e4TqVS47p4dvwrQ+eOnhn9KUGW5kjy/
         mJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA4+80CugzePKv80Ev60K3CjRtS094BAvxzrByIqFQEKZUG67BYF71mREq5ztH+0dJJEt9/lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CmI8cVUTdyarImGHIWLbp5CwAX6GpUgGRGKmN9JrgwPP2zZI
	dGHCRUULU5fk788pqvEDYS+wfgWHrbI5ardj5kqo4InyK4FPagmoj/GH56hcWS8JrmQz89pE+QM
	QBXPGo27PLQ==
X-Google-Smtp-Source: AGHT+IHaAZMKhByVkpO7+93Ka+6E50kvY3a7Y4B/+srVfxOdRHrMhLAj+xwnnXkHAeq0Q/znDzgiMtXoGrlkKg==
X-Received: from wmbbg30.prod.google.com ([2002:a05:600c:3c9e:b0:43d:44cf:11f8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1843:b0:391:2c0c:1247 with SMTP id ffacd0b85a97d-39d87aa8fd6mr53654f8f.1.1744132922425;
 Tue, 08 Apr 2025 10:22:02 -0700 (PDT)
Date: Tue, 08 Apr 2025 17:22:00 +0000
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407180154.63348-1-hannes@cmpxchg.org>
X-Mailer: aerc 0.18.2
Message-ID: <D91FIQHR9GEK.3VMV7CAKW1BFO@google.com>
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Carlos Song <carlos.song@nxp.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>, <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Apr 7, 2025 at 6:01 PM UTC, Johannes Weiner wrote:
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2194,11 +2194,11 @@ try_to_claim_block(struct zone *zone, struct page *page,
>   * The use of signed ints for order and current_order is a deliberate
>   * deviation from the rest of this file, to make the for loop
>   * condition simpler.
> - *
> - * Return the stolen page, or NULL if none can be found.
>   */

This commentary is pretty confusing now, there's a block of text that
kinda vaguely applies to the aggregate of __rmqueue_steal(),
__rmqueue_fallback() and half of __rmqueue(). I think this new code does
a better job of speaking for itself so I think we should just delete
this block comment and replace it with some more verbosity elsewhere.

> +
> +/* Try to claim a whole foreign block, take a page, expand the remainder */

Also on the commentary front, I am not a fan of "foreign" and "native":

- "Foreign" is already used in this file to mean NUMA-nonlocal.

- We already have "start" and "fallback" being used in identifiers
  as adjectives to describe the mitegratetype concept.

  I wouldn't say those are _better_, "native" and "foreign" might be
  clearer, but it's not worth introducing inconsistency IMO.

>  static __always_inline struct page *
> -__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> +__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>  						unsigned int alloc_flags)
>  {
>  	struct free_area *area;

[pasting in more context that wasn't in the original diff..]
>	/*
>	 * Find the largest available free page in the other list. This roughly
>	 * approximates finding the pageblock with the most free pages, which
>	 * would be too costly to do exactly.
>	 */
>	for (current_order = MAX_PAGE_ORDER; current_order >= min_order;
>				--current_order) {

IIUC we could go one step further here and also avoid repeating this
iteration? Maybe something for a separate patch though?

Anyway, the approach seems like a clear improvement, thanks. I will need
to take a closer look at it tomorrow, I've run out of brain juice today.

Here's what I got from redistributing the block comment and flipping
the terminology:

diff --git i/mm/page_alloc.c w/mm/page_alloc.c
index dfb2b3f508af..b8142d605691 100644
--- i/mm/page_alloc.c
+++ w/mm/page_alloc.c
@@ -2183,21 +2183,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
 }
 
 /*
- * Try finding a free buddy page on the fallback list.
- *
- * This will attempt to claim a whole pageblock for the requested type
- * to ensure grouping of such requests in the future.
- *
- * If a whole block cannot be claimed, steal an individual page, regressing to
- * __rmqueue_smallest() logic to at least break up as little contiguity as
- * possible.
+ * Try to allocate from some fallback migratetype by claiming the entire block,
+ * i.e. converting it to the allocation's start migratetype.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
-
-/* Try to claim a whole foreign block, take a page, expand the remainder */
 static __always_inline struct page *
 __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
                                                unsigned int alloc_flags)
@@ -2247,7 +2239,10 @@ __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
        return NULL;
 }
 
-/* Try to steal a single page from a foreign block */
+/*
+ * Try to steal a single page from some fallback migratetype. Leave the rest of
+ * the block as its current migratetype, potentially causing fragmentation.
+ */
 static __always_inline struct page *
 __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
 {
@@ -2307,7 +2302,9 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
        }
 
        /*
-        * Try the different freelists, native then foreign.
+        * First try the freelists of the requested migratetype, then try
+        * fallbacks. Roughly, each fallback stage poses more of a fragmentation
+        * risk.
         *
         * The fallback logic is expensive and rmqueue_bulk() calls in
         * a loop with the zone->lock held, meaning the freelists are
@@ -2332,7 +2329,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
        case RMQUEUE_CLAIM:
                page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
                if (page) {
-                       /* Replenished native freelist, back to normal mode */
+                       /* Replenished requested migratetype's freelist, back to normal mode */
                        *mode = RMQUEUE_NORMAL;
                        return page;
                }



