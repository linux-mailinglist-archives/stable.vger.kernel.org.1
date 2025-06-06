Return-Path: <stable+bounces-151617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93783AD029E
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4541F17471C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D355288514;
	Fri,  6 Jun 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBFbsyo4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3C283FE6
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214564; cv=none; b=jVbO1qMMwqOY2itGNIXMdPmPD30tgRy+UHhGmCrCucQPIWD6bAKleEXuv4KET6jEefafcR57xfANHPSaoKy2HzNN5dyhMCwKrEhXnTFHQRq63iFuI3WW6XyDKJ9JNBHpM3SBni6jogga61NpUjVACpP4B7asPjL2QbfDlUe8usU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214564; c=relaxed/simple;
	bh=pyP4voBTnGow5cseeEAeEmJxNYO/WBjrdKku1W4VhIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjTMmi7O6qeg0XMYANrH0PMqccbIbqHMEZA0MvCPWv11DSYsT7P1/0tpM1uKFxh2tOenOXYnYgMf/kNfnzSunQdf7RRVCLXvmk6L11aLAjZK+8tKEmK0pciGxiGN8vLVRmsSRmjQpqSqgdqZTV56Lwua4iftfi1zR6nsgZceJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBFbsyo4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso8594a12.1
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749214561; x=1749819361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lej/JzmO0Dw1V/XOb+M60AVoOmPPuLiZ67cVi04ciIo=;
        b=uBFbsyo4SkLBrAKLUmvzR34JtdqTWUnPPAzOILSYG9PupdcRaLlRR1c20f/GeS3vtu
         C9tQgaeTLgKSWtL/v/yTjo2P4Ll4p9cc2A8YCSkW4ZL67RntHfZlMp3P72vy0vo9DZad
         JlNETEPiBUdgZ61Ip/DDT9cGMlNBraDcgHbb4mBhK/MGdCifR2Ow4PebsehI9l87XapG
         JzWza0J/yxV33ob9S2cun7Ux407OSytqlFY1Tn80JhXTcEWPzdmXo63LA/yMgBwZu3+X
         8v8t7gYstMSJpWb3VvHhmRMbjUJ33dMF1lICdlDADiADxMOGMcNqfWXTaPo+GVk73J7w
         Z+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749214561; x=1749819361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lej/JzmO0Dw1V/XOb+M60AVoOmPPuLiZ67cVi04ciIo=;
        b=FImR8G0+g1nXVLdqVqORBsny0Kq+51VxSZKwa5cXQic+9XJ/3wB2vmFiQxJEWUnm1y
         tRAI/xE5oZ7YzAQjqJrt5Pq9iM8/Akl0dF3ttTQd1if+hc7GI8RjBBLmJUSNNIQHZDwu
         8ClkaEoDFT0ECjqYBFlqzhmS7IG/LZgRLIWfLAN8VuQ66FWEKGf6x5MJ1wtTI8u0iziG
         ecsJVL8WzmTmxbyK0Vlo0Fu9agZ0hS0ZjyLStEp1Cvnv2FUax9HdAPJ75LlNd+nxxDbP
         VZ33M1fBRyDl216kNcW4ggUlq3dE4dGWj57cBCNpQ1m2/Hgn9yDC4LW2OyyoCV8+9XPJ
         dE5A==
X-Forwarded-Encrypted: i=1; AJvYcCXYluLWqSrkPsbhXNWwxhhX+dum40h/LPpVWScerqIWB6+YH211BbeHMhNjmkfilJM5OkYRd+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rfIGS7e9yKIbcetLlVWdT7CFP7xPKiea9VYcbDrq2I/j9f4A
	e1QEdF9Fh9H+0XnAMgybGueNsV0s9GgzsomHAZndnEomGeExeKJe6b1MJxwus9+Ip5Ujt8lvP1W
	X36+mO6nYfs3kAoQnadbpW9JzWVizkH/D3KfIizF+1rAKpFygdIFq97nM
X-Gm-Gg: ASbGnctdXY8OICSdKl0c562pYA36BSAPYSOReD019zQe/UoHB6lxFrSD2JQklKs1oB+
	gFy7KjbwDuUETmRykZqwBGVnoiAiM6fg8TtO1FJVRXrUFcD/m0i/7RGvRyt2g64VxUnq/Pk6ogm
	IRAzPC9fnZ4HGPz7hgmRjhAj86q62mpm9druqslPb12nYFH4jP4VBqYawGQhpbrCYXnX4j9g==
X-Google-Smtp-Source: AGHT+IHXwcAquv0lb5IUM1aVYSbEaPQ46aM0vazICMyj+IzmQp//DMyCXsrGOLh2XTNX6ibsNYUExUiUldgyqMaL0gE=
X-Received: by 2002:aa7:c346:0:b0:607:1323:9c2c with SMTP id
 4fb4d7f45d1cf-607793de3b1mr62222a12.7.1749214561141; Fri, 06 Jun 2025
 05:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com> <ba208d76-7992-4c70-be8f-49082001f194@suse.cz>
In-Reply-To: <ba208d76-7992-4c70-be8f-49082001f194@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Jun 2025 14:55:25 +0200
X-Gm-Features: AX0GCFtRkqF2Lt6u6n6mq4FlDl2aj4mZ-IS4O5MGhg5wVl65bWzoxagLke2Bp80
Message-ID: <CAG48ez1R7v-L-L33nJUXtj_Y=SKyyFcU8amLs0dQ6ecuC3xMWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory snapshot
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-mm@kvack.org, Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
> On 6/3/25 20:21, Jann Horn wrote:
> > When fork() encounters possibly-pinned pages, those pages are immediate=
ly
> > copied instead of just marking PTEs to make CoW happen later. If the pa=
rent
> > is multithreaded, this can cause the child to see memory contents that =
are
> > inconsistent in multiple ways:
> >
> > 1. We are copying the contents of a page with a memcpy() while userspac=
e
> >    may be writing to it. This can cause the resulting data in the child=
 to
> >    be inconsistent.
> > 2. After we've copied this page, future writes to other pages may
> >    continue to be visible to the child while future writes to this page=
 are
> >    no longer visible to the child.
> >
> > This means the child could theoretically see incoherent states where
> > allocator freelists point to objects that are actually in use or stuff =
like
> > that. A mitigating factor is that, unless userspace already has a deadl=
ock
> > bug, userspace can pretty much only observe such issues when fancy lock=
less
> > data structures are used (because if another thread was in the middle o=
f
> > mutating data during fork() and the post-fork child tried to take the m=
utex
> > protecting that data, it might wait forever).
> >
> > On top of that, this issue is only observable when pages are either
> > DMA-pinned or appear false-positive-DMA-pinned due to a page having >=
=3D1024
> > references and the parent process having used DMA-pinning at least once
> > before.
>
> Seems the changelog seems to be missing the part describing what it's doi=
ng
> to fix the issue? Some details are not immediately obvious (the writing
> threads become blocked in page fault) as the conversation has shown.

I tried to document this in patch 2/2, where I wrote this (though I
guess I should maybe make it more verbose and not just say "subsequent
writes are delayed until mmap_write_unlock()"):

+ *  - Before mmap_write_unlock(), a TLB flush ensures that parent threads =
can't
+ *    write to copy-on-write pages anymore.
+ *  - Before dup_mmap() copies page contents (which happens rarely), the
+ *    parent's PTE for the page is made read-only and a TLB flush is issue=
d, so
+ *    subsequent writes are delayed until mmap_write_unlock().

But I guess this way makes it hard to review patch 1/2 individually.
Should I just squash the two patches together, and then write in the
commit message "see the comment blocks I'm adding for the fix
approach"? Or is there value in repeating the explanation in the
commit message?

> > Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() f=
or ptes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Given how the fix seems to be localized to the already rare slowpath and
> doesn't require us to pessimize every trivial fork(), it seems reasonable=
 to
> me even if don't have a concrete example of a sane code in the wild that'=
s
> broken by the current behavior, so:
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

