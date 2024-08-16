Return-Path: <stable+bounces-69326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02239548D8
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57711C2324B
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111091B3F0B;
	Fri, 16 Aug 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X/lkLRCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93500196D80
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811583; cv=none; b=Os6/K/wFH9rik3J0v29rz6uGtMn5/Vi3hGZxrDDCxQp7NC5M2xIncVEFd1OajQbzbOWv0uL4y6eS3c66+kn12Ku5IzCzcoUfvQfDu4m3WxvJuYwgfKbLcElEIPnR8UB+U7laTTovXuGMdQJHMtoIGKAVTHGnn4IoI7IpUFlRSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811583; c=relaxed/simple;
	bh=j0MaI76PTKoeqeDQdZhV0ErnN5UMg+cqjx1sgt61kOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtw+C25SpKPVWmnEGIHsQ9Cx3+1gTLhAhEWEG3fO8ONaYryKE/vQG/9yB3K4IGob9aXuv8Utv3PNjD3IZ2N2MiYz1dhQU8BOfBqBU8dX9kjmx2+2OBFeQICYlmjgwczJxZtxD69A2jGaL3CMvj5jtjGG3lBsf/udsrWOwTldcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X/lkLRCQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso14538195e9.0
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723811579; x=1724416379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imUnUTrQCkXERD1oWFs8dq4uU7ZTGW4Zz3wDRT4mvzE=;
        b=X/lkLRCQm7HJz0ykP9pouzG1XF4ZcbiSmg06xgw3lRMM9svqq38NMoFGpwcuBv+Bzv
         gVFzmkQhJtHiSJ4soCyHgQxqOzmtdHrBlJA1LO38RVzzopa197ZnjlBoDeZsVSvqx3R7
         reKUuyalVvT3xGo2VaM94T5V//HRyMPklQhYXtCTdNgrLPDjI5VAkaMjeWHluyiCBh//
         GiFGQ9CTJhruPlC7ANNNItSp2fwypnUkO0zKVbvFH9qeOWnUyP7wFBxFHV6x6an+EpD/
         pQmA2I6Y9Pnc7w5tKDaOtvdEbAWrLmI41phn4TKNwKOM/nyJK/SPqPTkVH2EIX3sGqpi
         svmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811579; x=1724416379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imUnUTrQCkXERD1oWFs8dq4uU7ZTGW4Zz3wDRT4mvzE=;
        b=Zw6Gx+fU69R/VTd4tH8VH8ukTOKQAkDWmRqLNt5JGJk53uVtdlDrjKdPZRaq2hA/kv
         t55Xse8kVPmY1IjS0PTR1k7XrtZlYKoSGJrQorq5LE3hHTxuaXWYxyJi0jiGqaHXx0A0
         CgVX+GA/vuvFBAF/+A/bWe03lrOaYGjSirZ4K5bgqOOHSh1kwus9dFa6AZWFuIwpSCPr
         raeYW78ZCx37KD9v8mdjLINg+6cjELbYMVLwEm+c/Vj4P1eYgv+/tjpFQEzF8b3KBAkb
         r2P8+1qkGkfBvSHKaPlWLwWIryPDnMl4mq3rYYR1r+HN4ZDLojkBeamsxXl5YpYTO0o3
         Mm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsz6LvsoIYb4tyrI8g6jKOu0J9P8XE0ie0ItvUBJRw6BPomw6pu8YyX5JJhUJ64cH0qPL5bFrAhO6T2DTIbrPbDMsGneOE
X-Gm-Message-State: AOJu0YzJ3N7QIjn/WBXtArwQ5kOyWZZsHWMXvDJ9GOvklzR5nF4ZT5RJ
	463LJzid7prkWCcqAOtbiZ/VC/DxU3SkjDR7ytF8LN/7McZ93kjDIE54zJVq/Dw=
X-Google-Smtp-Source: AGHT+IEYox1YBAo6ykzkHRbM+Ew1Xh2yiN9lOFnrSfrmPCD8QsEhWd3lchIYN5j834cdCu2zZqrLAQ==
X-Received: by 2002:a05:600c:444d:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-429ed7d17d8mr16523875e9.25.1723811578716;
        Fri, 16 Aug 2024 05:32:58 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650a96sm21636315e9.17.2024.08.16.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:32:58 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:32:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zr9G-d6bMU4_QodJ@tiehlicka>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114626.jmhqh5ducbk7qeur@oppo.com>

On Fri 16-08-24 19:46:26, Hailong Liu wrote:
> On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > >
> > > > > > > because we already have a fallback here:
> > > > > > >
> > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > >
> > > > > > > fail:
> > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > >                 shift = PAGE_SHIFT;
> > > > > > >                 align = real_align;
> > > > > > >                 size = real_size;
> > > > > > >                 goto again;
> > > > > > >         }
> > > > > >
> > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > >
> > > > > > Thanks for the fix.
> > > > > >
> > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > >
> > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > to order-0 should be commented.
> > > >
> > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > this comment?
> > >
> > > Hi Andrew:
> > >
> > > Do you mean that I need to send a v2 patch with the the comments included?
> > >
> > It is better to post v2.
> Got it.
> 
> >
> > But before, could you please comment on:
> >
> > in case of order-0, bulk path may easily fail and fallback to the single
> > page allocator. If an request is marked as NO_FAIL, i am talking about
> > order-0 request, your change breaks GFP_NOFAIL for !order.
> >
> > Am i missing something obvious?
> For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> the flag correctly. IMO we don't need to handle the flag here.

Let me clarify what I would like to have clarified:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..fea90a39f5c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3510,13 +3510,13 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+/* GFP_NOFAIL semantic is implemented by __vmalloc_node_range_noprof */
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
-	gfp_t alloc_gfp = gfp;
-	bool nofail = gfp & __GFP_NOFAIL;
+	gfp_t alloc_gfp = gfp & ~ __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -3527,9 +3527,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
-		/* bulk allocator doesn't support nofail req. officially */
-		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
-
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -3547,12 +3544,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
+				nr = alloc_pages_bulk_array_mempolicy_noprof(alloc_gfp,
 							nr_pages_request,
 							pages + nr_allocated);
 
 			else
-				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
+				nr = alloc_pages_bulk_array_node_noprof(alloc_gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -3566,13 +3563,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else if (gfp & __GFP_NOFAIL) {
-		/*
-		 * Higher order nofail allocations are really expensive and
-		 * potentially dangerous (pre-mature OOM, disruptive reclaim
-		 * and compaction etc.
-		 */
-		alloc_gfp &= ~__GFP_NOFAIL;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
-- 
Michal Hocko
SUSE Labs

