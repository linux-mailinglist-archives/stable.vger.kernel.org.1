Return-Path: <stable+bounces-165001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A822B1419F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224D218C2F72
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB2275845;
	Mon, 28 Jul 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Abv2YMt2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6B1F9F73
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725325; cv=none; b=LZFoKZ0Y0qQDb/W438q5v+ryggse0CtqK7zyPVt+nqMBrU3e5/e29xnv3KFeWimCjMYz98mENU4d4W4BUwJ5QNILH6YRT/gwrKSsdAyLrYlhCE8RJvIX40mHYU4f7MInLBc+hhhnjaxHVH+EZUt9iC/AgonjCS7bDuiT6PCcIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725325; c=relaxed/simple;
	bh=zssRUKNEvHB32vwdHkWFVtfA9UN28Yn3UoP25gyDubA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq8S8eq8+yWSQv65j8pjpie4wJJvKkl36s6s9Bl9/vptrjcPfzy5T0ixDDdB3CvaF8utv7v2uMn09X93bpBOaNU+zsso4G281hVXdplJl0v1KyEc5vg4i+5vf2AzERjxLmNr6iVqEbqEUPBlSBifTMAex8oQ4hSbGuSiU7RXzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Abv2YMt2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab3855fca3so39361cf.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725323; x=1754330123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQxxK6RbpQQjsAWFxkV8xT67PH0plChmN0vYEGz1peg=;
        b=Abv2YMt2CkABlV3UdTppUgt/64hZHX6MihIQCuolMY1V1M7rjYxJxWzw8J6iclxrgW
         ayGxQ+62pbdugM8DEfw8KUJ4rPVBir08BKXIYEmSjFaGEnFisOrLGImgsZ7FfnazMbGB
         LlpXyrtJTsv0YmOnPR5huSixKAovUfCI4/xeejZNiiQr8KVUCtnqd+wca10z3TetgwZ+
         LcFEFYv4L89PHoRZ7Ob/XHZFeE3HoPdLHCQ3CgkdVDf/E5TdyQZ37zD5WRnm3OVo+c6a
         iJp8v2zGlJ5yrnFLjRDiaV+dKgqv8kIeurr8zX1mPcXAvBKglxFUA7QsOfNOPDB2G5Do
         1gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725323; x=1754330123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQxxK6RbpQQjsAWFxkV8xT67PH0plChmN0vYEGz1peg=;
        b=PnvUcZWGMX9VlgHhv8rdF8VBua/FDk3iZcm8IxKTeiXtg7qKWhdKhQ+c7Vsw6K7elR
         jgQb8jV22WnmjeEFsJvi5vDay6soOzAe9CYQnnPD8mQ+CYwUBF1RR3d3CU+gXSYVZNtT
         GfxxdJKwkt/L/umKfSi+71a6a3bYT0Ww1Mb8qIkaCLO87nvaUXHzBHWyi6SqmeZoxeYM
         lvZLLbT7Y4D+G9TF/YQ+cy0SrfWFKP1BopxJBFNVOPmnLPdKEzgS9ISuLRFRRySwHeaY
         auDsdO90eboqmeZ/rmUZwGgpurwEanDQ5hm2/slrohP9+hqcKhi0Fow6LjmyoKgPlQWH
         2oXA==
X-Forwarded-Encrypted: i=1; AJvYcCVlD2QCU1nqC+uZfJ6HyMlwR7hcWVO5YiN/QMYwqo7Mj+GGKDXevvsTanskoenGnLuZWvHzIM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jzcNDis8WZtJDeb2vu0ILt1VkJ8yb6UNsKf7XsJ0TjQwHrkp
	QUmvnslWPrJCYYIExlsgp3yVcnEEgAUh2AotmxDbxDNAKekZu3r/dKVRY3TNqD9KhpqBbQFOgKN
	/9NS709ALfzKJ7WWHZWav4w+Qi5mevHRoaFHXPXXu
X-Gm-Gg: ASbGncuwdUuq6BAemxcPTqcEqLTL1mZt38SSMiV6yZImps3H6EcUIimRDGx/xbrBDEn
	PeyRn53lo2/0cQr2S8U5DTbC7WapuriltF7yEe2KWsmJJdRtqXOkqOaxZyQtRt9I0ztnb01u0sz
	GjRB3p4qNcKmKAbStnx5wagB+LQvA652OJyI+Y7T+fMpvnAipXX5yZuHhFjLd7PStK8fgs/D+4i
	hrR2PjCmXuuOepqscHkKJy0SRNSaJrjUiz+fw==
X-Google-Smtp-Source: AGHT+IFFnoxBnnNVScW/VpJt6pjdkyu/boiKhrUJzdPlXt0VAhjFqNpn6IGuDGg/1A36+VHGOxFhSv/p5MrjmKydpFI=
X-Received: by 2002:ac8:5a43:0:b0:49d:88d0:145 with SMTP id
 d75a77b69052e-4aecdec4fdemr7141cf.23.1753725322548; Mon, 28 Jul 2025 10:55:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728170950.2216966-1-surenb@google.com> <3f8c28f4-6935-4581-83ec-d3bc1e6c400e@suse.cz>
 <CAJuCfpGZXGF_k_QVQqHWZpnypB-sWB8hwZeOYMOD0xmAFOBxkA@mail.gmail.com>
 <97938dc6-5dfe-4591-ba53-3729934c1235@suse.cz> <CAJuCfpHgyzQxmAiriFM59KGi465ocxH6T5nBSBY1fcUazOj9Gw@mail.gmail.com>
In-Reply-To: <CAJuCfpHgyzQxmAiriFM59KGi465ocxH6T5nBSBY1fcUazOj9Gw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:55:11 -0700
X-Gm-Features: Ac12FXzlgFF7itYZWvvVBXrV-1oKF1zTqyNKqehylT5HcvvNfhoWPx9GYVarnJM
Message-ID: <CAJuCfpF3543giq6vHuBbmLuxjUYVxNub6PgTzu0M3Zfe0H2xGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:43=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Jul 28, 2025 at 10:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >
> > On 7/28/25 19:37, Suren Baghdasaryan wrote:
> > > On Mon, Jul 28, 2025 at 10:19=E2=80=AFAM Vlastimil Babka <vbabka@suse=
.cz> wrote:
> > >> > +      */
> > >> > +     if (unlikely(vma->vm_mm !=3D mm)) {
> > >> > +             /*
> > >> > +              * __mmdrop() is a heavy operation and we don't need=
 RCU
> > >> > +              * protection here. Release RCU lock during these op=
erations.
> > >> > +              */
> > >> > +             rcu_read_unlock();
> > >> > +             mmgrab(vma->vm_mm);
> > >> > +             vma_refcount_put(vma);
> > >>
> > >> The vma can go away here.
> > >
> > > No, the vma can't go away here because we are holding vm_refcnt. So,
> > > the vma and its mm are stable up until vma_refcount_put() drops
> > > vm_refcnt.
> >
> > But that's exactly what we're doing here?
>
> Ah, you are right. At the time of mmdrop() call the vma is already
> unstable. Let me fix it by copying the mm like we do in
> vma_refcount_put().

Fixed in v2: https://lore.kernel.org/all/20250728175355.2282375-1-surenb@go=
ogle.com/
Thanks!

>
> >
> > >>
> > >> > +             mmdrop(vma->vm_mm);
> >
> > And here we reference the vma again?
> >
> > >> So we need to copy the vma->vm_mm first?
> > >>
> > >> > +             rcu_read_lock();
> > >> > +             return NULL;
> > >> > +     }
> > >> > +
> > >> >       /*
> > >> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false l=
ocked result.
> > >> >        * False unlocked result is impossible because we modify and=
 check

