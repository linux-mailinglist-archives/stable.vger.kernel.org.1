Return-Path: <stable+bounces-150762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B06ACCD84
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 21:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18838188D730
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB421CC59;
	Tue,  3 Jun 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVbgeGEh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A86213E65
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977794; cv=none; b=HQp8714nCwb8VX7rL7XY+4taOMiOjxGUVZ5U1UnsV9CSp3kc/j3RTLTtWBlhjmurAUpxJdsUdOEWOeF1+fbRO/P/I8GaXAhL+0SlSlbNJcrNn05wffIFAiihspPC3eMte3VijRe2S3VPQ35+Tla1msUlnxnwSUFmYhEyTqkPJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977794; c=relaxed/simple;
	bh=4QNqoswYNS6AhpNKdKJXEKRbNRybMqTV40SOe4X1O1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXZbrbxhz7CUX6B3H3NnBn08y89Poy2g2rLUe089G2CkgTfcit41t4PHuixW7EB9wVX7BsTeChdvh0Vxkjyd6WKUpOh+5CBX5+OIwIn8gL75SAi57MXq4TltlwRDN5ZPkS1URIQyLqCPqCzIxADZwEUASVL01ZZcLdtttiH0BF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVbgeGEh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso2150a12.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748977791; x=1749582591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDFpNE99L8Pksyp1ve3dfkrnf/nLOEF78F5qU2cr+gY=;
        b=mVbgeGEhkhq8FclT/eeOxcNPJs0+BQtsULSBKDaSJp0KTXCoXCNJMF1+m5ihl8y2pb
         qHfxv66KsWP54TRCB4XDdW696nhuzxYFTJvdNX22gs6s2JiTqq2Z+YNATlKg2iPvcx7N
         uuyNhys0PrR1gHtCKaoaxnsXoU8149WkDPej/eKTimSDgvcaky5KZAoZht44PXabOfxn
         A8EigFs8epFxOiO2BBTBmusbRUKq3UW//CigSU/vmAw7SaBMbSCKnsqNfyOGHS2pC6Cm
         zDFtikyMtIOPlTuUT+NjODxxSY1cw1M2On+M7amIj/eN8V+zbavr5VsnWOKOllHF+1zp
         M3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748977791; x=1749582591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDFpNE99L8Pksyp1ve3dfkrnf/nLOEF78F5qU2cr+gY=;
        b=vfFMKG3ns1C2KzLRYmEYCDlyxEvOvYEhxXa+cMKGV0dlNfDk0+sgQd3zNgG3PuzR9k
         nc3ssg2z7T60W2r6Cc+U/JjF3lzUW7KYYNFWH2GPCUggsSyYTy/j4BXh32ns8MXNEwyA
         q+MEwNJK6OhoyBSatTZW9esLzyOiHUgicwwm2qFRc7MzLjZUc63S90577xgtUibv9N1X
         CM83JAtgo/0Hwlbvq6xQ2o6OEuLf7s6xN2lRKt062iOqC+BW3ixqJlsDBa3lVRvvvChD
         cWtUpYOLfAR1xa8287AwGX8CdTKvwcPcPrYKbv+4d4WLxMNu01JDrEpXq1TPdmPqTeeU
         di4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLEBc5nrPmbAg0tYfPWFcMavO8tbzEkibXmNzijgaj0d3rqNdYfPHiDOgS9MnI+XNB5yz2DUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe03dd2SW7fFE/mYw9irx0wuXnZjveWPeG3zYiz5W8qJJbtkzc
	zc9Hu/ctdhRg121WLfV/AW2MgS00kVxriM2wXLmUZWr6iXXUlWDqGX9c/bpqtfpfh7nzaVnmvqy
	T8m6o3OyO0TWwfpWUNf9L1G0lahyU+SAeGgWhb8vt
X-Gm-Gg: ASbGncsvIevq0FXGysQX/TiQ1nDBE41C+74FHe3bJLOSpAwnCymDCGjgftTTEjGtbVf
	69NkBsBAif1WdvwnKTQ1K08fx5rDsxcLunsxS8jBU/Kc/ZBs8szAxZEmj3G1yiL8MYPjnCbUctd
	Xcx2pyxAHDQlArcQL/FFkWfL4E3v3irc3QasQayzHZtgEQyRmu+J4zeSuhdzZ/13xUS1C0WQ==
X-Google-Smtp-Source: AGHT+IHYswGWanAgWKQSMSfiihgsgNs0+6ptfegE1kE6Wp0sHUCbGa3ku/B3CMF12kd7vrUzCMpjPaYUWT3nbfhBJfM=
X-Received: by 2002:a05:6402:324:b0:606:e3ff:b7f9 with SMTP id
 4fb4d7f45d1cf-606e887b723mr5721a12.3.1748977790474; Tue, 03 Jun 2025 12:09:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com> <aD8--plab38qiQF8@casper.infradead.org>
 <db2268f0-7885-471d-94a3-8ae4641ba2e5@redhat.com>
In-Reply-To: <db2268f0-7885-471d-94a3-8ae4641ba2e5@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 3 Jun 2025 21:09:14 +0200
X-Gm-Features: AX0GCFtCpIPsWFmnSr9w2T4NN3PLSn_1dA8DhnOyioQLG_9FoZlqKdP7GI5LlqA
Message-ID: <CAG48ez2NX-L0Wq-DQDB2vb3CvOJ1uTmJOqmbMW=FOTtxVoouxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory snapshot
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:37=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> On 03.06.25 20:29, Matthew Wilcox wrote:
> > On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
> >> When fork() encounters possibly-pinned pages, those pages are immediat=
ely
> >> copied instead of just marking PTEs to make CoW happen later. If the p=
arent
> >> is multithreaded, this can cause the child to see memory contents that=
 are
> >> inconsistent in multiple ways:
> >>
> >> 1. We are copying the contents of a page with a memcpy() while userspa=
ce
> >>     may be writing to it. This can cause the resulting data in the chi=
ld to
> >>     be inconsistent.
> >> 2. After we've copied this page, future writes to other pages may
> >>     continue to be visible to the child while future writes to this pa=
ge are
> >>     no longer visible to the child.
> >>
> >> This means the child could theoretically see incoherent states where
> >> allocator freelists point to objects that are actually in use or stuff=
 like
> >> that. A mitigating factor is that, unless userspace already has a dead=
lock
> >> bug, userspace can pretty much only observe such issues when fancy loc=
kless
> >> data structures are used (because if another thread was in the middle =
of
> >> mutating data during fork() and the post-fork child tried to take the =
mutex
> >> protecting that data, it might wait forever).
> >
> > Um, OK, but isn't that expected behaviour?  POSIX says:
> >
> > : A process shall be created with a single thread. If a multi-threaded
> > : process calls fork(), the new process shall contain a replica of the
> > : calling thread and its entire address space, possibly including the
> > : states of mutexes and other resources. Consequently, the application
> > : shall ensure that the child process only executes async-signal-safe
> > : operations until such time as one of the exec functions is successful=
.
> >
> > It's always been my understanding that you really, really shouldn't cal=
l
> > fork() from a multithreaded process.
>
> I have the same recollection, but rather because of concurrent O_DIRECT
> and locking (pthread_atfork ...).
>
> Using the allocator above example: what makes sure that no other thread
> is halfway through modifying allocator state? You really have to sync
> somehow before calling fork() -- e.g., grabbing allocator locks in
> pthread_atfork().

Yeah, like what glibc does for its malloc implementation to prevent
allocator calls from racing with fork(), so that malloc() keeps
working after fork(), even though POSIX says that the libc doesn't
have to guarantee that.

> For Linux we document in the man page
>
> "After  a  fork() in a multithreaded program, the child can safely call
> only async-signal-safe functions (see signal-safety(7)) until such time
> as it calls execve(2)."

