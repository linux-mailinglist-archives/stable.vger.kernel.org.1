Return-Path: <stable+bounces-131956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E6A826E1
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F12019E884E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8E253F01;
	Wed,  9 Apr 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Ki55mXt9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE925E820
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207236; cv=none; b=U2gFPHT0teGUteAkXzRCMgVopqGe7A2Tdy7bm6fmfrw/qVm1XCOyJaK82T1jKDMGvaGK6zq6sGbRJyofzkxwldMOMGdFHxAtaKokq5304ixU7eEZf3cTm4wOvnS8orwVryZQAPDWzKx1aqs9rd5ULr7ZQEFNpFGwHwx67praJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207236; c=relaxed/simple;
	bh=fKAUplVIh9IVEilSqxt68vCgZpO8rfAd86TA8bIK61U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrJQmzRCdDMc6dZQRdMmFzmZLHHnqXFkROH4sqx8gTqh6vYCPZGlhV1JiAO2ADHwdpUnVczJKsgysoTo02Tgsz1pGKpk3QigO+WvZK2f8pfn5TInS9LI2aQj0xM5YtZhBNoO9Z2BMSCGcSmHknZOpoMSegNtelwzb6LSewgn90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Ki55mXt9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c53b9d66fdso870314585a.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744207232; x=1744812032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfO9/CEy4dgci6iz8QJ7UzHvpG+GvqY3wOSCyMzSDbM=;
        b=Ki55mXt9Hom4WOBoo1syI47/Peq6VYzCRgr07Xkth7Pv6+n5snVquciU5yjdz5/mW9
         wuZZ8l2gvxLGkqASk+ykEK0THPVXsnC1QTYBqSqpr4LMQ+JQGxgKnHZDkaexLNrKqrm5
         s122TcPGLLplU0fM4VOH4MHrK278yNvZGnezh45/rOHaLaT8tMALFqtQd2omWXqdmf1X
         DszIa2YfNsTijTDAX9X7ED4rj6xAXEMKlwmwiL35Vurh4uZ4j1GR6Yl+MdDNNHEE6+YN
         FGbfh4gY1xPbYZy2micJJYcoTW24bm8cY3OxE+fUs2BOhVuw9hhsGchj1y4JOVVB4cnW
         hQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207232; x=1744812032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfO9/CEy4dgci6iz8QJ7UzHvpG+GvqY3wOSCyMzSDbM=;
        b=sk/XUyJeAd/BN9/Je1jxr5DhqLcvV14uoRh1NcLDga8rvgCte7fXiKLz/pI4fku4Ey
         oXW/hLarrSA+XKi0tkY/PtftCt4a2K6ApC5ZMtHEcOxEcIoxUG1pqS4YeuQsOK1PTF5p
         usrcEbyaHSNFN346KoManRnZMz2iGTu7npbUwBfdajRCajtJA54WmR/BCtBIobw3SIdn
         qnI98G+QsrWc9lJdtQFrlFLKaNfSdOnSDENrmDW3A4+BU41j2JAnZkaS3rtL94RdSqhC
         LrxZcEpF/z7T92leM8pDEwxc0C6Zb89yx08O+pWBWHGZPsJQUkVRi6x81YuidDqgfaMH
         SzKA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQhEKlUv5fz+a7WM8wE60TWsa0Lr5ZQB2zLI4GQH5sirE0TtwTT/+LbbzNiaRsJLXgxFBHSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vdRKb5wMqzdg4MV86gfsdewIvp/3uBr9R4uZFj4nWrTC0jiK
	AXxG572zHvZBF6k/N4a4/2YKFih9Wm+d8q9ntzZ9v86Rn6gL3yVqvCQEmyYMFnnqAVNDPb28C6u
	o
X-Gm-Gg: ASbGncuDYkr24GNHLjaUr2t5mTGG1iqZIPj+EWEs/75nOEDHO3tGy+LNbkaULqmEk7K
	5BN7v+fAzMweezt0PySctcMmFzazAcfigDlN9d7HD4q1258Si50Ww6UVvAJPD70QTpAtVPfBQlg
	FDa4DWj2jnf/uOToHlSLV1X9i1jsE3oRWhJFrwmXWfmHlOd97gxgv+SciT5xuV2H19/t3G3cXx0
	iwfpiqaVsW/qXdhXTJupL4suaAnStRiA0Uq9KIZ2gDzlZ99SkbdCeAcl5e/zidW8+8SpR+n1w3d
	2WmG52it5wrv/Rkjs434rcn0iv23lsQx
X-Google-Smtp-Source: AGHT+IGzpZNpd5bWmJIrglPrlH0pmCswaggSnMgMXggJtdtTARzTu3BIp4nxphDdER+S+PLR/Q6L3g==
X-Received: by 2002:a05:620a:2614:b0:7c5:50dd:5079 with SMTP id af79cd13be357-7c79dd932c0mr375653685a.1.1744207232165;
        Wed, 09 Apr 2025 07:00:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::1:8699])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a10d3ba6sm76640685a.63.2025.04.09.07.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:00:31 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:00:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Carlos Song <carlos.song@nxp.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Message-ID: <20250409140023.GA2313@cmpxchg.org>
References: <20250407180154.63348-1-hannes@cmpxchg.org>
 <38964e68-ac20-4595-b41d-8adc83ae6ba0@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38964e68-ac20-4595-b41d-8adc83ae6ba0@huawei.com>

On Wed, Apr 09, 2025 at 04:02:39PM +0800, Yunsheng Lin wrote:
> On 2025/4/8 2:01, Johannes Weiner wrote:
> > @@ -2934,6 +2981,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
> >  {
> >  	struct page *page;
> >  	unsigned long flags;
> > +	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
> >  
> >  	do {
> >  		page = NULL;
> > @@ -2945,7 +2993,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
> >  		if (alloc_flags & ALLOC_HIGHATOMIC)
> >  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> >  		if (!page) {
> > -			page = __rmqueue(zone, order, migratetype, alloc_flags);
> > +			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
> >  
> >  			/*
> >  			 * If the allocation fails, allow OOM handling and
> 
> It was not in the diff, but it seems the zone->lock is held inside the do..while loop,
> doesn't it mean that the freelists are subject to outside changes and rmqm is stale?

Yes. Note that it only loops when there is a bug/corrupted page, so it
won't make much difference in practice. But it's still kind of weird.

Thanks for your review, Yunsheng!

Andrew, could you please fold the below fixlet?

---

From 71b1eea7ded41c1f674909f9755c23b9ee9bcb6a Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 9 Apr 2025 09:56:52 -0400
Subject: [PATCH] mm: page_alloc: speed up fallbacks in rmqueue_bulk() fix

reset rmqueue_mode in rmqueue_buddy() error loop, per Yunsheng Lin

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dfb2b3f508af..7ffeeb0f62d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2983,7 +2983,6 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 {
 	struct page *page;
 	unsigned long flags;
-	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 
 	do {
 		page = NULL;
@@ -2996,6 +2995,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
+			enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+
 			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
-- 
2.49.0


