Return-Path: <stable+bounces-191654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF74C1BEF8
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F645889B9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594634AB06;
	Wed, 29 Oct 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjqMVHQJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE533F36A
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753048; cv=none; b=YZeHYZ3aPxSXhty0NOV5Hdt53cXovLO2ankbzMG+ezhzzHOvZ11zuS2Snn3l3hDvWpQNlXYnHIXw0p9mHHHjf0ZlccUfbNj+kFsSycqaMMTQA2q0G8fAPUKzyVW8y0cHDoIjgP8z7RjATRGAUP8m6gwGyuZXyqVw6n/rP/xcOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753048; c=relaxed/simple;
	bh=ncyOs1TIMWDEMQ93v3fXnyW45bIYqohnPx9bW18lEgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQxa2WQX38rI8Xk7KJuP5eU25BNYwHhITlWO6jOViR1Z3gFNrvxqHRJ9R2bjfg08WHuQzMUhCgc8Wcl3uZjAUbvqA4QlEZmNKNYAhRhMLS/G1KFrzPuX8OHzefez+bddWtbvIjmloe1RmCA4a2BnZQZ+6SkIlvxnmG8LwjRWmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjqMVHQJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290d48e9f1fso217105ad.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761753046; x=1762357846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLSSejf9Ov/rf2h/EN+lGG7qdblHRyA6VuFB4BW8g0E=;
        b=ZjqMVHQJSLoxOFWz5cWBA5ZuWAIJ1g5Bbn+r1UNk0F8NvU+FIv8a3XV1xElXwQkfOY
         NIbkhIP3jE9t7qvw50Rr1BLwhBzETXgW1iIAM/P7TYDqPvai4in0E5RDnJNaFxp2ZXtB
         cwQvIbMcuby03uKtuxhu+Eo1hLOJj5yN7Gb4vlSj7zbhKR+3XXmVUkUMr2Iu4niseIdG
         dfPO+E7ItHE6ZxRRMoLwpsDBM5E3pQ0dYR4QTwUVCmQ/TsWJa+ovMkW8lxCDcCRUYbPk
         xOZSHCbsTstpg7fE0yrT7zdTH4MTHhKWlcgySC10/KKWGwNbSnsL/Pj8Z94J7YC0eJdi
         GMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753046; x=1762357846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLSSejf9Ov/rf2h/EN+lGG7qdblHRyA6VuFB4BW8g0E=;
        b=CatJC/r74ZAWzy1dRd+x2f+W6RHZhPHLSJBuj/mefRS/hWxqXCRSXpB6vs//V1H52q
         1KKDOnAARZtxQdq/X0KbvBNEBJrRx6z598qcFytw7sPcOQEpMxT0jepeL+aQmDrgRES1
         7m9ceEnlC/j+2I8lKb717+2rpjPrUpIhkyPCkRKToOsJ3Ou+rIXPCZwuRdvqSBsYBRFC
         qpqG7kTiExOX2CZEv90r/ESpMkv0pAUtLg5WA3oPNJim1YcUNvVr7TUrzNSktEXnYll+
         O6l2tGlk1/qX63RhLLQMEFGNiQ3XLZ8VUMm5TwBNuwMfRxZZq+Hj+BD+fNZ4frRhRwXM
         WbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtVrM88FaJkCkuZP1e7Ui1gnTJ0cJa9kkbn+t+IiBkIISeL82XNmkXzsZKWwZflDJnX1+ko2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ469NytBK0Jxngnf+2M10xxJpt7wcVn7P3ULzn/rIZD6/Xolw
	cV1f2NytLUdiPbMGxV4pozXT6iyLiM4CYKsg7xDvOzenLxPNMIBiA2Spwom8ttl6vA==
X-Gm-Gg: ASbGncu1pq3x4lAqkasa7aGUiKmVsM4jqaKPk7om5GJn1nJuFLhRqT61H4UkgTL4i/J
	qxvCgiNNHSTFMfq7SDBv6NPJjBshVTW1ILZWykDzrVZCxrUdMo3XOV9AMD/AEXZgfsUI2zyRE2O
	uiYUWju8UQ4tgCP4kBc5Zb1cTPIeGWh/jZ7bGzw7A7WkNSbUljbHtyojPV06zGJXC24SAsjcA3G
	5CvK8JzxPRRRyYaXj9ldfTdg4yIf98fjP3Z4hgLB16LCzSOQK4F08YsPaKcILcEenfRBX21213O
	iJzrGS93RB7NFkuZHezhPwK18O9ftBjImjNM6rAhuFvbUrRRCZSSO7eXOHp+99ZAd0i9D3aNJES
	MNYmu/wYAYgp38jdZxze4EOHuhjdCscuHeOYwhSHH5/4Vc/VSmRP+JrR0K33jJR3GjWMXR3hh90
	O203L63hTCia/h83AdwbCKtb48WA+RB7GSuYFH1UixW+dTgR8F9T6f
X-Google-Smtp-Source: AGHT+IGKPx3RLfl6Sze4h/1XGsrW5jd0bsQlcCb4PLueO0OQww5kd42KAzAHDNBGaMp7vPiY2Mr9QA==
X-Received: by 2002:a17:902:e783:b0:294:e585:1f39 with SMTP id d9443c01a7336-294e5852cfdmr2782045ad.14.1761753045254;
        Wed, 29 Oct 2025 08:50:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9ab7:9682:d77a:f311])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm15654178b3a.28.2025.10.29.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:50:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:50:39 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aQI3z0x0gZ3T1fij@google.com>
References: <20251028191020.413002-1-isaacmanjarres@google.com>
 <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>

On Wed, Oct 29, 2025 at 11:03:18AM +0100, David Hildenbrand wrote:
> On 28.10.25 20:10, Isaac J. Manjarres wrote:
> > When emitting the order of the allocation for a hash table,
> > alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> > log base 2 of the allocation size. This is not correct if the
> > allocation size is smaller than a page, and yields a negative value
> > for the order as seen below:
> > 
> > TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> > TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> > 
> > Use get_order() to compute the order when emitting the hash table
> > information to correctly handle cases where the allocation size is
> > smaller than a page:
> > 
> > TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> > TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org # v5.4+
> 
> This is a pr_info(), why do you think this is stable material? Just curious,
> intuitively I'd have said that it's not that critical.
> 

Hi David,

Thank you for taking the time to review this patch! I was just under the
impression that any bug--even those for informational logging--should be
sent to stable as well.

> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >   mm/mm_init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 3db2dea7db4c..7712d887b696 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >   		panic("Failed to allocate %s hash table\n", tablename);
> >   	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> > -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> > +		tablename, 1UL << log2qty, get_order(size), size,
> 
> So in case it's smaller than a page we now correctly return "0".

Correct.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers
> 
> David / dhildenb

Thanks!
Isaac

