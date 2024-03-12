Return-Path: <stable+bounces-27535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B77879E3A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F3CB2145E
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25814375A;
	Tue, 12 Mar 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1JhmZ8k"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE277A730
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281523; cv=none; b=IwFWRJj5YUEP4B8sNiLj0YjBjnpfsKhNAMUFaMeDC+QjaoCAi5sm1n5JCFpXe6R41O2deIM1XTEjGVXi0wVn2Oh3gT6aZ35k6/xC3A+5lgO24XO/iKyzBJxt+nKIy0sf4QnWx507zgojI+wmsOUbANyMdhMv4EsmwrnwmNNBg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281523; c=relaxed/simple;
	bh=of+4iiFOJBjOA3kpKuxP9ruMd01LKlIOjerKDOA/l7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz44rFqekoeaEtzopZHf2x9EFC7oriwtM9c6l2/yc1M/fyrlZY4pegwzevnXq/d0D/gElYjQN1AVHcw1/4Ppuggai26yzLOebi8jU8HHDdLw0rAXtD7nBuALOp0MXRSClfbpON3+odz8Ff49+Ht/OkV8yRKWoYq4y1vkbW4s3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1JhmZ8k; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so15835ab.1
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710281521; x=1710886321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aHhknlqvNfTdhS7268rU8Y8hdQqP/mq9n0R8UEetUI8=;
        b=z1JhmZ8kAQCoaT6Q+148OgZhiuoWqWkXjNKriankrflxyP2ocAC5hxxUzhDElVA99O
         brAe03DkVkKTfupCuufo3VGRAD2yr5J8G2LUEfKZqnabNRwqxufd3DsPF+JTnyxlTkaU
         wodcSh1Oq8MSlw7SHVB5W91ZRBtNbo9NdvDxnwa5h9JqF7h/8ySAxXMtxvKN0jvXyu14
         42qxzS7H8MpnDfHJ7XjNl4FYrvpiqBuI8eQbihT3s7hqcawI4Mi+rgxR9Bh7DAxlcvft
         XKNhBTX5RNe9FK34BgziLVmYIRSAr5S1oilwVi9rLetASW1ltRytaLY5HReptRim1CUS
         1hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281521; x=1710886321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHhknlqvNfTdhS7268rU8Y8hdQqP/mq9n0R8UEetUI8=;
        b=irpRtfljBgy+ueyfLptCCQv2g1RzdkTLeWGZQsVBzrpuAKjL9eK76/X2VpjfdIiv+Y
         2gLu6OYj4ZkvHcel/P7MGb4O15rkDjJhque56PBSk00yjatLjsdxXiUd2AQ+t9LH/1a6
         VOw/r0FctfCYTZzy7BL3obdJNRU873FAsUv26MkJxmLkgl4gy/R9M/j3p6Lm4Mtz0bv9
         irhf6mDXfrPTo9kiIZZdivLE+qjU53eNMQGUi53Eqv8bLSrbM5j2i4NZVksg5NiJatrC
         4sHUCbYrQamZBtGiWA2ZQP3OGHgppaYCggDw/ydyopzBnvir387hiHVRxYc4tBmb4Bd4
         PgLA==
X-Forwarded-Encrypted: i=1; AJvYcCX85cnhcwpyf3x5rQlZCFd6Uck/Lz0u1MJvUX8kyQ4qRMYWqn+/gWxj6LodkocJhmmtIXcfCBGu1bw68Kg0Vi/jzLGLOxmk
X-Gm-Message-State: AOJu0YyLC7HTJ40Xw4I2y8Q2/47YzdCxcHCICdGn5TV747TkBED3ZkOi
	lPrquFU2g63MSpiONv51t/dcEC8OZx1IAaeW1wOy8tbCByLjoE31DfKECeEjGw==
X-Google-Smtp-Source: AGHT+IGQ/ZlKlS1lCQethqtslXn37Rb1npiCTAGmypdYNYmQ/gfgoKMfjvGdrTzQRF2gWpV2EuFTqg==
X-Received: by 2002:a05:6e02:1cab:b0:363:e69d:896a with SMTP id x11-20020a056e021cab00b00363e69d896amr54805ill.18.1710281520620;
        Tue, 12 Mar 2024 15:12:00 -0700 (PDT)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id n10-20020a02a90a000000b00474d2a8e83fsm2548322jam.83.2024.03.12.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:12:00 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:11:55 -0600
From: Yu Zhao <yuzhao@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: Fix soft lockup attributed to scanning folios
Message-ID: <ZfDTK79iQNlax-h6@google.com>
References: <20240307031952.2123-1-laoar.shao@gmail.com>
 <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
 <CALOAHbAsyT9ms739DLZeAf88XsrxjJgm1D8wr+dKNFxROOQFFw@mail.gmail.com>
 <ZfC7PO0-3Kg88Wj3@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfC7PO0-3Kg88Wj3@google.com>

On Tue, Mar 12, 2024 at 02:29:48PM -0600, Yu Zhao wrote:
> On Fri, Mar 08, 2024 at 04:57:08PM +0800, Yafang Shao wrote:
> > On Fri, Mar 8, 2024 at 1:06 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu,  7 Mar 2024 11:19:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > After we enabled mglru on our 384C1536GB production servers, we
> > > > encountered frequent soft lockups attributed to scanning folios.
> > > >
> > > > The soft lockup as follows,
> > > >
> > > > ...
> > > >
> > > > There were a total of 22 tasks waiting for this spinlock
> > > > (RDI: ffff99d2b6ff9050):
> > > >
> > > >  crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  grep "RDI: ffff99d2b6ff9050" | wc -l
> > > >  22
> > >
> > > If we're holding the lock for this long then there's a possibility of
> > > getting hit by the NMI watchdog also.
> > 
> > The NMI watchdog is disabled as these servers are KVM guest.
> > 
> >     kernel.nmi_watchdog = 0
> >     kernel.soft_watchdog = 1
> > 
> > >
> > > > Additionally, two other threads were also engaged in scanning folios, one
> > > > with 19 waiters and the other with 15 waiters.
> > > >
> > > > To address this issue under heavy reclaim conditions, we introduced a
> > > > hotfix version of the fix, incorporating cond_resched() in scan_folios().
> > > > Following the application of this hotfix to our servers, the soft lockup
> > > > issue ceased.
> > > >
> > > > ...
> > > >
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
> > > >
> > > >                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
> > > >                               break;
> > > > +
> > > > +                     spin_unlock_irq(&lruvec->lru_lock);
> > > > +                     cond_resched();
> > > > +                     spin_lock_irq(&lruvec->lru_lock);
> > > >               }
> > >
> > > Presumably wrapping this with `if (need_resched())' will save some work.
> > 
> > good suggestion.
> > 
> > >
> > > This lock is held for a reason.  I'd like to see an analysis of why
> > > this change is safe.
> > 
> > I believe the key point here is whether we can reduce the scope of
> > this lock from:
> > 
> >   evict_folios
> >       spin_lock_irq(&lruvec->lru_lock);
> >       scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
> >       scanned += try_to_inc_min_seq(lruvec, swappiness);
> >       if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
> >           scanned = 0;
> >       spin_unlock_irq(&lruvec->lru_lock);
> > 
> > to:
> > 
> >   evict_folios
> >       spin_lock_irq(&lruvec->lru_lock);
> >       scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
> >       spin_unlock_irq(&lruvec->lru_lock);
> > 
> >       spin_lock_irq(&lruvec->lru_lock);
> >       scanned += try_to_inc_min_seq(lruvec, swappiness);
> >       if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
> >           scanned = 0;
> >       spin_unlock_irq(&lruvec->lru_lock);
> > 
> > In isolate_folios(), it merely utilizes the min_seq to retrieve the
> > generation without modifying it. If multiple tasks are running
> > evict_folios() concurrently, it seems inconsequential whether min_seq
> > is incremented by one task or another. I'd appreciate Yu's
> > confirmation on this matter.
> 
> Hi Yafang,
> 
> Thanks for the patch!
> 
> Yes, your second analysis is correct -- we can't just drop the lock
> as the original patch does because min_seq can be updated in the mean
> time. If this happens, the gen value becomes invalid, since it's based
> on the expired min_seq:
> 
>   sort_folio()
>   {
>     ..
>     gen = lru_gen_from_seq(lrugen->min_seq[type]);
>     ..
>   }
> 
> The following might be a better approach (untested):
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..6fe53cfa8ef8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4365,7 +4365,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  				skipped_zone += delta;
>  			}
>  
> -			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
> +			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH ||
> +			    spin_is_contended(&lruvec->lru_lock))
>  				break;
>  		}
>  
> @@ -4375,7 +4376,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  			skipped += skipped_zone;
>  		}
>  
> -		if (!remaining || isolated >= MIN_LRU_BATCH)
> +		if (!remaining || isolated >= MIN_LRU_BATCH ||
> +		    (scanned && spin_is_contended(&lruvec->lru_lock)))
>  			break;
>  	}

A better way might be:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4255619a1a31..ac59f064c4e1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4367,6 +4367,11 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
 				break;
+
+			if (need_resched() || spin_is_contended(&lruvec->lru_lock)) {
+				remaining = 0;
+				break;
+			}
 		}
 
 		if (skipped_zone) {

