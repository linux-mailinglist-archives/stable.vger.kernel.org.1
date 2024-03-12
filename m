Return-Path: <stable+bounces-27517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F1879CE5
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBFF283BB3
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840F1428F9;
	Tue, 12 Mar 2024 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zh7T8TPz"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BF7E104
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275397; cv=none; b=BnH0hrjWenpEQqPywbg2AC7UlLjECxCXC9sIIgORd4wgBA8hyzUZmWAB+SWBdNI36mB2Schnz+r5/9Xyby6Nn8ZztKIgX9XS9TKbEW8ILMDZNCG73CLL2tgd+W3mpkOhugYiG6wBQ0IN7idpLLIKRVAR5ztmr5/MrvwFQLV8X7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275397; c=relaxed/simple;
	bh=QeY1YM6xirtGnDBr7b1VYp4VYHgx8HnF0DJSPenbOIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyDzzYlo6G1WHOcUAubY1adR0WdkUuDnZPCeJE3SepPotbIkQ45+4JvuyiwsvIIrTM/VKO8QCG8G4JIX33twkosux0KIJjD13CY+MMFHyRzW92Znp3Y8GRoFvatNfjXyBmvYrtuQHVk5Gxl2W/0k242qdywjHx/MC3jLeMpJlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zh7T8TPz; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so5065ab.1
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710275394; x=1710880194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9IqxiP3IbRAlqX4sXQy5fioU+eM5If2YrJuZLv1F/c=;
        b=zh7T8TPzvkc0zuuJwK69IaHJgBaIk6SrkddTodGH+RYMbDJOmGH00TiNCHtwn5BQP+
         n3ptGdcFEmMs1MDHMZWYAto9NTFjTYQ/ROILCZ2zhEqhFWorX60o1hdkq8ns7H8kF79M
         C+/2Ze//yxo7L51i17E/0w/mUI4CZ44dE3uYW4OELbAsghFJSf9Sa4LRSkytlK1QnbQT
         bQu8e6qdKUn5nuDweff3pzj+nsotwarISbRNC8CxGjy3fAks//wfPRwgK/kEIBLE+NV9
         CaOb7qBZuUeWvMbe2LVw5C2PfnIqOBcypT8jWQ/U5Su4wZ89BYTRsMv6K3tRXaGxWlWf
         UZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275394; x=1710880194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9IqxiP3IbRAlqX4sXQy5fioU+eM5If2YrJuZLv1F/c=;
        b=U9aCMAIhRX3zjnjWy/w6YCDrR8UZOPt9v5GxHrx/UPWU8RxG2ManghjsCAprz91t2y
         hYnNFwmC/VirIZAqs0Xx0P3ajLi7AmdPeRGrHfUoZN86T7Fpi701t4rqo+/ueNm7OGDM
         E3X0IVb3Epnc5nm/FVPFyFJ7lCGI7gJSstIRI70HhFsI2LhqT5neRn7LYgtRPNp4tgC0
         IdnUgBFhFkHVtBRe+V30TLetvY/bMVXJfe/5R1cko7BjllSwy31PaMAEuXo/uDH257Wm
         TYI+SzW3RsYs+B6SN46/Z3sqiNa6y4+WGMPULXgzjBePC1LHj9/EdOtm6veJooU7BwRO
         OVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3uQNJNfPFVLLDr/FajTXjZ6/mGkKB1/Fq1kvaYtqdifGT4pcn7lhduaboeCxN8JiNmTEiK81p0olWuS99BABSkI0wx3st
X-Gm-Message-State: AOJu0Yy0VU/1lyrLr+3WNhNlBlrp4koj6Uca/aYVzflfJEzJFep1eUj3
	r11scZxrTyEObQKMLvX6xK3e//mfmneb1Ll1lDAwaxM3LIVYQhOzkGMeGODuaA==
X-Google-Smtp-Source: AGHT+IEu5DQpSMFuktwW+vW+BqhBxPvMJGD2/IlvQKGWzLFuzPNHDm1jfM2dyOx0NCRqNCA0W5zJZA==
X-Received: by 2002:a05:6e02:1d93:b0:365:7ef5:ee97 with SMTP id h19-20020a056e021d9300b003657ef5ee97mr31676ila.4.1710275394273;
        Tue, 12 Mar 2024 13:29:54 -0700 (PDT)
Received: from google.com ([100.64.188.49])
        by smtp.gmail.com with ESMTPSA id l15-20020a92d94f000000b003662d59c561sm2516734ilq.62.2024.03.12.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:29:53 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:29:48 -0600
From: Yu Zhao <yuzhao@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: Fix soft lockup attributed to scanning folios
Message-ID: <ZfC7PO0-3Kg88Wj3@google.com>
References: <20240307031952.2123-1-laoar.shao@gmail.com>
 <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
 <CALOAHbAsyT9ms739DLZeAf88XsrxjJgm1D8wr+dKNFxROOQFFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAsyT9ms739DLZeAf88XsrxjJgm1D8wr+dKNFxROOQFFw@mail.gmail.com>

On Fri, Mar 08, 2024 at 04:57:08PM +0800, Yafang Shao wrote:
> On Fri, Mar 8, 2024 at 1:06 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu,  7 Mar 2024 11:19:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > After we enabled mglru on our 384C1536GB production servers, we
> > > encountered frequent soft lockups attributed to scanning folios.
> > >
> > > The soft lockup as follows,
> > >
> > > ...
> > >
> > > There were a total of 22 tasks waiting for this spinlock
> > > (RDI: ffff99d2b6ff9050):
> > >
> > >  crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  grep "RDI: ffff99d2b6ff9050" | wc -l
> > >  22
> >
> > If we're holding the lock for this long then there's a possibility of
> > getting hit by the NMI watchdog also.
> 
> The NMI watchdog is disabled as these servers are KVM guest.
> 
>     kernel.nmi_watchdog = 0
>     kernel.soft_watchdog = 1
> 
> >
> > > Additionally, two other threads were also engaged in scanning folios, one
> > > with 19 waiters and the other with 15 waiters.
> > >
> > > To address this issue under heavy reclaim conditions, we introduced a
> > > hotfix version of the fix, incorporating cond_resched() in scan_folios().
> > > Following the application of this hotfix to our servers, the soft lockup
> > > issue ceased.
> > >
> > > ...
> > >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
> > >
> > >                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
> > >                               break;
> > > +
> > > +                     spin_unlock_irq(&lruvec->lru_lock);
> > > +                     cond_resched();
> > > +                     spin_lock_irq(&lruvec->lru_lock);
> > >               }
> >
> > Presumably wrapping this with `if (need_resched())' will save some work.
> 
> good suggestion.
> 
> >
> > This lock is held for a reason.  I'd like to see an analysis of why
> > this change is safe.
> 
> I believe the key point here is whether we can reduce the scope of
> this lock from:
> 
>   evict_folios
>       spin_lock_irq(&lruvec->lru_lock);
>       scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
>       scanned += try_to_inc_min_seq(lruvec, swappiness);
>       if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
>           scanned = 0;
>       spin_unlock_irq(&lruvec->lru_lock);
> 
> to:
> 
>   evict_folios
>       spin_lock_irq(&lruvec->lru_lock);
>       scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
>       spin_unlock_irq(&lruvec->lru_lock);
> 
>       spin_lock_irq(&lruvec->lru_lock);
>       scanned += try_to_inc_min_seq(lruvec, swappiness);
>       if (get_nr_gens(lruvec, !swappiness) == MIN_NR_GENS)
>           scanned = 0;
>       spin_unlock_irq(&lruvec->lru_lock);
> 
> In isolate_folios(), it merely utilizes the min_seq to retrieve the
> generation without modifying it. If multiple tasks are running
> evict_folios() concurrently, it seems inconsequential whether min_seq
> is incremented by one task or another. I'd appreciate Yu's
> confirmation on this matter.

Hi Yafang,

Thanks for the patch!

Yes, your second analysis is correct -- we can't just drop the lock
as the original patch does because min_seq can be updated in the mean
time. If this happens, the gen value becomes invalid, since it's based
on the expired min_seq:

  sort_folio()
  {
    ..
    gen = lru_gen_from_seq(lrugen->min_seq[type]);
    ..
  }

The following might be a better approach (untested):

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4255619a1a31..6fe53cfa8ef8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4365,7 +4365,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				skipped_zone += delta;
 			}
 
-			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
+			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH ||
+			    spin_is_contended(&lruvec->lru_lock))
 				break;
 		}
 
@@ -4375,7 +4376,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			skipped += skipped_zone;
 		}
 
-		if (!remaining || isolated >= MIN_LRU_BATCH)
+		if (!remaining || isolated >= MIN_LRU_BATCH ||
+		    (scanned && spin_is_contended(&lruvec->lru_lock)))
 			break;
 	}
 

