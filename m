Return-Path: <stable+bounces-109241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F2A13849
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE368161494
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0931DE2BA;
	Thu, 16 Jan 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZdqsF37"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8119539F;
	Thu, 16 Jan 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024650; cv=none; b=mgm2vvOqdYGwGCJFuTBdKd5xEJUJiRbYXqmQPiEjt3IC6s//2ry6I/qjcjHmZ+uMvNbGS5+R+CTPhSAnVFLfHlKQZK+5ed1g7p35MM/C8Y7us1lMNM3DN1/AtdYX3Z//Tvg/fbSOo0NMdNNomLh88WAPQulhbPFZFOtMMjWyFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024650; c=relaxed/simple;
	bh=OeNeCtcrONL801H/WZiafjSKFBzM3TLEC3IK7ijLiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOjt0ZxMk/sWfu7lffRSQCRa4bPZDjv7jkMswkAhT5adTmV2oBo3BM+kwGq6DPEJ6lw8BUWtr2SutBU5xOgrIx+SzjPXWFQrS9Lnl9fU1UzfP3yknpocJ1YAxQSjtEIdgju/A1Ur1Wwpx6ppsHVZoaJYhgxgaHzYTZpQVFsap54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZdqsF37; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso1126087a91.1;
        Thu, 16 Jan 2025 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737024648; x=1737629448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rY9XRKJvOJ8/3ciXecDpmNkHd5QK6jGNJj71By9HiJs=;
        b=kZdqsF37+GltjD+TtagnebPDNvKz51tBWVrY9Frvw7IoqAywPqMEM6ZPq/51R8oYln
         LtoZwwpdRlzs4qv0jWnnAE1dlc/H1Pw1EFSGLSU+WEaX2UoeZvS7YPUv7O9GDV6NUt8M
         YEVJWp/e98sErRnIrbLOPoztH08kJ519O7K5lm6ayeK//zLP5yhvvE76VCo/ePqKLbxS
         H8462vdxf3/FdsdTdBL4PRMfNxaXF3OkrFNMvfW42kJ8JRuJ8FtsoQIJzFmF0aXyOXUE
         CCFy3zuwgDNx5iREGnZTeL5KnnEbwyshb9tiY3rPW/klAg4K378So3/F+AZhvAN4RXzl
         15Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024648; x=1737629448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY9XRKJvOJ8/3ciXecDpmNkHd5QK6jGNJj71By9HiJs=;
        b=RhsIKWd/6vVx0061K23RYp1BcplZO9i6c/JRZS9TJvIrSX4U7vXxlMCAKzlgls02d7
         KhZWcit1E6Bkas8JvtOJVWggbqy8blu796y3+7evwrv9JsNWE05MMdqL9b9rMPIa+ut7
         MPiTwkb/reH9/X1WNscZbUnZbpKVYEWh8CsZJ8W1MHrrfoHhFxq07eky5KZbIaNZxZ9r
         utm0Cvmbr9pLnS8H9aOdEe6XMEUXzZU50S/4R5GuRph8BSwtWbmBvXO0M+7gHs0x5UTZ
         tIv3molBgpr2GhEbhxrkWRiWZaK2RlAJPOKFPrIpzWnVYfehMiiCbQwfqR/3vghbFRhm
         z1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUENoG5F5PyNwDn63Ix/XDp7kejo+8XaBgGCKO5ZoXKMB7bdzOdQ6I9TzEsZLCWLoh1HFL9CL8aRLjRf5QfYaSMBA==@vger.kernel.org, AJvYcCV9UUIxpoBUZGrvfMyL+DAOjoQ+Q/oFDlx9WUft3NijnpuvVorgHccGyQX/784IDLtEsbnxD25c@vger.kernel.org, AJvYcCVASpQn0KVTAKoELik9AKkZf+FTbW9NB4RV3GdIGRAmahAJ3VCTBllPH1UvI6wRBd4s0OtakAoUdVfDUz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X8hhLu6oMtxDne+eEQFFBsgSeTG46e5ypfF4J2rqtelTBo68
	w6o1ZHJ0sFhuxkzg3wMU2TyZTL9+AAb0SwFnGRPvloxB7rR7Qurt
X-Gm-Gg: ASbGncup1kgZDiUok7rcA8cRyAxLj0QB+njqtfAyNkZWb6TLBowOqdoY/ZsbalQzDkT
	TxPr0IljXZreujXzGu/lm4Hxg5scuSc+erev+1+91UcvKFtNkk1RZI4skseoIpwdq9Y0/TDzS+R
	zHJtgO/ETKwvxikIQjHBThEI8bmFPZ8ZQhmionIcVX9pRf24BsDOlvUx/DtsW9L3byv8HA9W6VK
	dvF55klxszZ0LNu0x3SDJk+/CW2CZFcwANJ/F7Z00966M19gUupXdgiYspsJYh7Hbw9a3koYKHu
	k2mWEcHZ
X-Google-Smtp-Source: AGHT+IHOV72YO7rbqVMyaLFj8IoR3lyUCUWSbQtM1clkvTCv6q4Db7N3rGOjRkdRIL7nJr31+/wMrg==
X-Received: by 2002:a17:90b:2b83:b0:2ee:a4f2:b311 with SMTP id 98e67ed59e1d1-2f548f103e9mr47378292a91.8.1737024647747;
        Thu, 16 Jan 2025 02:50:47 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2bb332sm3273949a91.36.2025.01.16.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:50:47 -0800 (PST)
Date: Thu, 16 Jan 2025 18:50:41 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chun-Ying Huang <chuang@cs.nycu.edu.tw>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2] perf bench: Fix undefined behavior in cmpworker()
Message-ID: <Z4jkgatm62bNybb+@visitorckw-System-Product-Name>
References: <20250107073906.3323640-1-visitorckw@gmail.com>
 <d90e130c-984a-4b9f-8297-ead2857ab361@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90e130c-984a-4b9f-8297-ead2857ab361@linaro.org>

On Thu, Jan 16, 2025 at 10:40:45AM +0000, James Clark wrote:
> 
> 
> On 07/01/2025 7:39 am, Kuan-Wei Chiu wrote:
> > The comparison function cmpworker() violates the C standard's
> > requirements for qsort() comparison functions, which mandate symmetry
> > and transitivity:
> > 
> > Symmetry: If x < y, then y > x.
> > Transitivity: If x < y and y < z, then x < z.
> > 
> > In its current implementation, cmpworker() incorrectly returns 0 when
> > w1->tid < w2->tid, which breaks both symmetry and transitivity. This
> > violation causes undefined behavior, potentially leading to issues such
> > as memory corruption in glibc [1].
> > 
> > Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> > compliance with the C standard and preventing undefined behavior.
> > 
> > Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> > Fixes: 121dd9ea0116 ("perf bench: Add epoll parallel epoll_wait benchmark")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v2:
> > - Rewrite commit message
> > 
> >   tools/perf/bench/epoll-wait.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> > index ef5c4257844d..4868d610e9bf 100644
> > --- a/tools/perf/bench/epoll-wait.c
> > +++ b/tools/perf/bench/epoll-wait.c
> > @@ -420,7 +420,7 @@ static int cmpworker(const void *p1, const void *p2)
> >   	struct worker *w1 = (struct worker *) p1;
> >   	struct worker *w2 = (struct worker *) p2;
> > -	return w1->tid > w2->tid;
> > +	return w1->tid > w2->tid ? 1 : -1;
> 
> I suppose you can skip the 0 for equality because you know that no two tids
> are the same?
>
Yes, exactly.

> Anyone looking at this in the future might still think it's still wrong
> unless it does the full comparison. Even if it's not technically required I
> would write it like a "normal" one now that we're here:
> 
>   if (w1->tid > w2->tid) return 1;
>   if (w1->tid < w2->tid) return -1;
>   return 0;
> 
Sure. I'll make that change in v3.

Regards,
Kuan-Wei

