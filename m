Return-Path: <stable+bounces-151444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BCACE1B0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7912E7A7375
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D019E7D0;
	Wed,  4 Jun 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qk3leJ1s"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1E187332
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051749; cv=none; b=qBGN/mlxeOJFYHUSP7sA4xDzi3ta0uF/bkekwg17I6bwJe0Nf6dgCTJl1RXgRzKjQDo4TLxVQPP+yX+rz5ilriUlgajVh+k+r+xrRHqyYx9+ORKMC0UlWy1lgT58d54NSxZdyR6uPMZZri4uk5oAlwrBR5gECRoyYAACzahH5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051749; c=relaxed/simple;
	bh=hhP/A7RLvwyRKQC/O9VmZbiaAZnWTJN7KauhrQU2JQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6a7Xm2AcCqXTZ/wejHiLS8mvAcL3nheeAS9Cs0jK8Cz9H+Ftw0OPZn1FhnPztW9KQQXT1NgSYOHWLafWTGFujrYXllim8ffNpReCA4HJAIR+qOt6Xkg0JZYolxE/p0xB0oOYGxB+DW839FY2VWwjBY03XhnYPek9CgNR/p5WSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qk3leJ1s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso14144a12.0
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749051746; x=1749656546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7t9vtmyioTV7HgLglXfMiupzKVCAToEG32ldpNqXxc=;
        b=qk3leJ1sLkzmXV1+gxW6N3B+/brtpW9ZXyXW+pvebFw8FeomAjHD6tRA+znmnCmNjB
         A4U0idLE1xOmZxTP4Pw3FAtHNEyHG/VVvP5RuKIV2C83sr3QmsfbxK6QcVn1XRdnuQ/L
         OzXKCGKH8d40pfH/xh0zUJhUSYZxpVpnvHqo4/g9TkOCWGENd/YxfVHHucz/M/YTWzHs
         o28gLU8V7QzEL67I2P2ysSUrzjWq4eNpsW3TpPiLFuOLdhOiKkJZ+40QMGBf5n6P3b1T
         XCHPzZc3aQE56Qf/1jyebCDtVB9ccwPU0yj1PiRO/0cBUW5crH5KX7/1euysXqYwGhrT
         igOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051746; x=1749656546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7t9vtmyioTV7HgLglXfMiupzKVCAToEG32ldpNqXxc=;
        b=xHu/n2CFMi988smGrLDhUFa/Nyfh3KUm96oe+K70Lhdja3m0iid1q4PUitrathx6JI
         SRxwvGXiPF/0eNkDpIEN5f4W8J35Or92t8GoswyLKh3snPjSm4nAFSYnYdR/c2aCo3jw
         svL63x+pMlbRT2p6794HLMUKpTvEJuJUZCOhOmmazfJn5LVmGVDo7coxQQFJwiG+p3rw
         YiikDkGIGx6ZkWy7ap05x+eSk8Tjben+EjdemTJKtUS2JbrLID74Pj2wQcQNyyhH/Q8Z
         m5t58A74eoGs5yuFXk2DeWvKdQZQsA/GlAQQ8kGxf/3quAqAuImZHcL37Irav5cqqJWf
         87VA==
X-Forwarded-Encrypted: i=1; AJvYcCWZZ47Ckx7tcGNHnIPkyqY6/fuLwMMAMHawIRWjHk+SUi7FpEgPJEeKekBc9Qd4xHwryQji36Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hMiH6pL7wTLQuZ3wI3r8bKoqzghzKoavsrE5BXRGpA/9Q30c
	YahPcQflVGOgo/nElB1CNG011Q6ctlAIQbZ1J6hdgO0PKXWOCgCH92peC+cCyw7H2pvgP2Lt9ak
	O0qvA4yFY1sjNSXrepC2A1CSenENK4KZ4luqyuCvl
X-Gm-Gg: ASbGncseGVp7Y2cLmLmF2gXnvC7VTHx4/UxSmM88LqxgNTWluYRLrxq5ge9qm7RjVI/
	DVWpaY8vFcj/acp65vPVBWCFeAI95U1pPdbnRdNWwq+Q9VgSSJxRF0xcr1E+ARdwPYWC3gS0Qm2
	2HSYEwxJiWGhdFMaxDeHzJsFFDoSrE1NwZ2y0NfHhacLeCAGXqaZHqwdh1tPm6f506n8SLeoMQq
	gcJfe5u
X-Google-Smtp-Source: AGHT+IGfPx1qQPMXmJnjVKhaEVQluNKuo3ENlcH6cBs0pacjJK5V/ek72eM4MKfZg2Ho+J1PAnctmEkhuhZRW6TjsQE=
X-Received: by 2002:a50:ee0d:0:b0:606:efc1:949b with SMTP id
 4fb4d7f45d1cf-606efc199femr93289a12.3.1749051745229; Wed, 04 Jun 2025
 08:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com> <t5uqs6kbzmcl2sjplxa5tqy6luinuysi7lfimbademagop7323@gveunpi3eqyo>
In-Reply-To: <t5uqs6kbzmcl2sjplxa5tqy6luinuysi7lfimbademagop7323@gveunpi3eqyo>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Jun 2025 17:41:47 +0200
X-Gm-Features: AX0GCFsCvblCWcy9XKdf8MqurIoG-ndCCsP0NcLQgarcwuDEBT9XXvHYP38LsIc
Message-ID: <CAG48ez29awjpSXnupQGyxCLoLds72QcYtbhmkAyLT2dCqFzA5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory snapshot
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:32=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
> On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
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
>
> This is an interesting problem, but we'll get to it later.
>
> > 2. After we've copied this page, future writes to other pages may
> >    continue to be visible to the child while future writes to this page=
 are
> >    no longer visible to the child.
> >
>
> Yes, and this is not fixable. It's also a problem for the regular write-p=
rotect
> pte path where inevitably only a part of the address space will be write-=
protected.

I don't understand what you mean by "inevitably only a part of the
address space will be write-protected". Are you talking about how
shared pages are kept shared between parent in child? Or are you
talking about how there is a point in time at which part of the
address space is write-protected while another part is not yet
write-protected? In that case: Yes, that can happen, but that's not a
problem.

> This would only be fixable if e.g we suspended every thread on a multi-th=
readed fork.

No, I think it is fine to keep threads running in parallel on a
multi-threaded fork as long as all the writes they do are guaranteed
to also be observable in the child. Such writes are no different from
writes performed before fork().

It would only get problematic if something in the parent first wrote
to page A, which has already been copied to the child (so the child no
longer sees the write) and then wrote to page B, which is CoWed (so
the child would see the write). I prevent this scenario by effectively
suspending the thread that tries to write to page A until the fork is
over (by making it block on the mmap lock in the fault handling path).

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
>
> Ok, so the issue here is that atomics + memcpy (or our kernel variants) w=
ill
> possibly observe tearing. This is indeed a problem, and POSIX doesn't _re=
ally_
> tell us anything about this. _However_:
>
> POSIX says:
> > Any locks held by any thread in the calling process that have been set =
to be process-shared
> > shall not be held by the child process. For locks held by any thread in=
 the calling process
> > that have not been set to be process-shared, any attempt by the child p=
rocess to perform
> > any operation on the lock results in undefined behavior (regardless of =
whether the calling
> > process is single-threaded or multi-threaded).
>
> The interesting bit here is "For locks held by any thread [...] any attem=
pt by
> the child [...] results in UB". I don't think it's entirely far-fetched t=
o say
> the spirit of the law is that atomics may also be UB (just like a lock[1]=
 that was
> held by a separate thread, then unlocked mid-concurrent-fork is in a UB s=
tate).

I think interpreting atomic operations as locks is far-fetched. Also,
POSIX is a sort of minimal bar, and if we only implemented things
explicitly required by POSIX, we might not have a particularly useful
operating system.

Besides, I think things specified by the C standard override whatever
POSIX says, and C23 specifies that there are atomic operations, and I
haven't seen anything in C23 that restricts availability of those to
before fork().

> In any way, I think the bottom-line is that fork memory snapshot coherenc=
y is
> a fallacy. It's really impossible to reach without adding insane constrai=
nts
> (like the aforementioned thread suspending + resume). It's not even possi=
ble
> when going through normal write-protect paths that have been conceptually=
 stable since
> the BSDs in the 1980s (due to the write-protect-a-page-at-a-time-problem)=
.

No, Linux already had memory snapshot coherency before commit
70e806e4e645 ("mm: Do early cow for pinned pages during fork() for
ptes"). Write-protecting a page at a time does not cause coherency
issues, because letting a concurrent thread write into such memory
during fork() is no different from letting it do so before fork() from
a memory coherency perspective, as long as fork() write-locks memory
management for the process.

