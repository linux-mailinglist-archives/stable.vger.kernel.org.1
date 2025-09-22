Return-Path: <stable+bounces-180876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E8B8EE78
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B053AFA6B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C51CAA92;
	Mon, 22 Sep 2025 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQOsXecL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EF249E5
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513942; cv=none; b=tWJuNpnv8xL0Gs8054Kzw32530H8Yoco2dtFMXfo1zsJG/dWiNMzTHawt/D0KttajjfFkwZZ8mylGEqgNO6lsmQm18Lnpm5meZ/lECl/HIh6QldcNBXQhVdwUf78YKXZLJ20O+IuW/lKhQAUelYuL8MI2ab8TI0/Zo0liv46/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513942; c=relaxed/simple;
	bh=ZBAPZD7FlI27vHYmhpxl/0A2E/Zd48kYCrtJKDwck7M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LOgcNfvjEbMLnSuz1aGLXU6UssYsCanWmnxtwCq5mF0pMSucVlJf2sWhwVjBw4qIOi9dwMbTYNRLHtEOWfFHjqZNXE87jM1BjGe83pzJfYMa+7Z2kYpuT4RoBRugoJTzIlAQrrCat65OcxfxNRuNXIuMaTdD7UjVPjbT00Hatow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQOsXecL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea63e86b79aso2771864276.2
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 21:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758513939; x=1759118739; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+MmVU86kQQ0FGDXbZD/BozlPJRQel7QCDmEGJXA2I=;
        b=YQOsXecLuGitEbebrq6Y2YB2rxgwA5oMSdR2a6043y+ix0bkpGQHgtmxCvY1P79KuY
         aikc7OuU+HOFR91hzgyAq8ougy+HVquruKx96rk+PwY2qcxJO+HlBy6qZiUka9ijUfXW
         Isj34aOgSqnMx87zk+U5sKdtIIAj1XYDMqcBgh9rDf3Mp1/B6SObZMSBs3dJ6/Ifjbgk
         LEUzKORiLYk08OWqBmhzlwucyw45R5Qtubhc/C73iWoIIfCbt5GTSPSwRPxoV7ajAdND
         0sWVU/wr+ldCM6tDhZjUmU24kFJnApSXNh6ONGBRyY3+MNm0TTcvN5WhkIjgmCn45tCL
         LBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758513939; x=1759118739;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+MmVU86kQQ0FGDXbZD/BozlPJRQel7QCDmEGJXA2I=;
        b=NG22kYRLs62zCGmrVP1kQDOramoobiGxP404/sXIG0StfJhcB8L0adoqFjuAtB/UEA
         mooPqDdXM4kKT7Z1VAiT5PRTHZzIe5wxXGncf6+M/r6gaoy4jrJRAkAcnxe/m47jYX0i
         wMG5FTw9wLMC0XwTbwhcEdk4FIihgqGqaxic+O7baIJhIifFiHkd3llW9SYZQJpvDJJH
         WJofs15Qqoul6+Z8rwPXmNoZ3yh2HYx9F1xB18CL7IlaAC0ZurMq0XDlsmCuXBI0BMYc
         Iz6dJiycONuRXf9uNGgg6OJNimttckC0bZ6znK1lidyag+nC/nVrPzQZwNgg3GGntxzR
         pogw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4e8HUKp82F24gMs0eld4sdFuYb1EsH+lJqLMS0BUPo79mbOZpSL2YPKPqPb44yEclU/H3nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBFdx7PE4IjfosfNM5IDHFUUX6ZLvpl7neD0vMjfnhL3TztGN
	TwrIJyeg0aK65Fd1Hq+qy6kXRw0IsaWxiRylD8AlcrLInc9SUHl9AYi09z/RBiEQ2w==
X-Gm-Gg: ASbGnct0FbfKMWlow9skWKFQOKM4lNiGqf5xVQjf3afyEfWWJFDAevVoelTWX3kjgfP
	Y1xlPdGq3tJwVxL35tVgF2xWdrkXZCyOkiP86Zisilu+GMU2ITk6s9I6kqacIWiB3YlgbjVvW+R
	nN47OJxr5BINzirRfHsAGrFsmQ5++oCorY59jTxGYxzOP5LvcwmUvLAg5S6WJJc/VRKAnxIemIw
	dfmB8VMmkFpk3m6VgzrX0QLvWKmj4JBlyGXUUIKphGLTA/P0UsPqnaBn/tbSgF4jM5wKE5N4qZs
	qOP2P3yUl7rQPI2CoMVarqhEAZhYtN7krScWnKZCrj7MjDxnpYLcvIyVQlQI920YV1zU/CHcc0i
	/wwxQPGc7TmBZOx0NPIjcNOYEJ+M6bS3Gn7Ts+nOlqkBUdSYLbiMy2iL4KVUORpnBRnzDFJ14yH
	VPQy/OlHLJG5MlEFPE0g==
X-Google-Smtp-Source: AGHT+IFio76maoN3Nn/X/zbU+83XIvDA2y40c8zpLBHK9et19anuGTLDGKs9T8kUHRfh5yaACrAaRg==
X-Received: by 2002:a05:690c:6209:b0:73c:8359:d5ad with SMTP id 00721157ae682-73d3b0b8158mr89984157b3.29.1758513939216;
        Sun, 21 Sep 2025 21:05:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718b98e4sm30981337b3.62.2025.09.21.21.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 21:05:38 -0700 (PDT)
Date: Sun, 21 Sep 2025 21:05:35 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
    Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>, 
    Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
    Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
    Keir Fraser <keirf@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>, 
    Li Zhe <lizhe.67@bytedance.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, 
    Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, 
    yangge <yangge1116@126.com>, Yuanchu Xie <yuanchu@google.com>, 
    Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm: folio_may_be_lru_cached() unless
 folio_test_large()
In-Reply-To: <2025092135-collie-parched-1244@gregkh>
Message-ID: <b7e6758f-9942-81ca-c5fd-1753ce49aa32@google.com>
References: <2025092142-easiness-blatancy-23af@gregkh> <20250921154134.2945191-1-sashal@kernel.org> <2025092135-collie-parched-1244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 21 Sep 2025, Greg KH wrote:
> On Sun, Sep 21, 2025 at 11:41:34AM -0400, Sasha Levin wrote:
> > From: Hugh Dickins <hughd@google.com>
> > 
> > [ Upstream commit 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 ]
> > 
> > mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as a
> > large folio is added: so collect_longterm_unpinnable_folios() just wastes
> > effort when calling lru_add_drain[_all]() on a large folio.
> > 
> > But although there is good reason not to batch up PMD-sized folios, we
> > might well benefit from batching a small number of low-order mTHPs (though
> > unclear how that "small number" limitation will be implemented).
> > 
> > So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
> > insulate those particular checks from future change.  Name preferred to
> > "folio_is_batchable" because large folios can well be put on a batch: it's
> > just the per-CPU LRU caches, drained much later, which need care.
> > 
> > Marked for stable, to counter the increase in lru_add_drain_all()s from
> > "mm/gup: check ref_count instead of lru before migration".
> > 
> > Link: https://lkml.kernel.org/r/57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com
> > Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Keir Fraser <keirf@google.com>
> > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > Cc: Li Zhe <lizhe.67@bytedance.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Shivank Garg <shivankg@amd.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Wei Xu <weixugc@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: yangge <yangge1116@126.com>
> > Cc: Yuanchu Xie <yuanchu@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > [ adapted to drain_allow instead of drained ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> 
> Does not apply as it conflicts with the other mm changes you sent right
> before this one :(

Thanks for grabbing all these, I'm sorry they are troublesome.

Though I'm usually able to work out what to do from the FAILED mails,
in this case I'd just be guessing without the full contexts.
So I'll wait until I see what goes into the various branches of
linux-stable-rc.git before checking and adjusting where necessary.

(As usual, I'll tend towards minimal change, where Sasha tends
towards maximal backporting of encroaching mods: we may disagree.)

The main commits contributing to the pinning failures that Will Deacon
reported were commits going into 5.18 and 6.11.  So although I stand
by my Fixes tag, I'm likely to conclude that 5.15 and 5.10 and 5.4
are better left stable without any of it.

Thanks,
Hugh

