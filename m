Return-Path: <stable+bounces-150761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E1AACCD7B
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C3C188512F
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF421171D;
	Tue,  3 Jun 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9BMIIzL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EC202C43
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977468; cv=none; b=mjPT8lwbjAWgD+YeVX10/wJWnDM9xYwN8qOuU29/zUfRJNYu51AZ4OrBM9UArD9jgxM+FAPa3Zi1nFFQGEjQDbLr3J3r/ErzJBzofGeShVhcKmueI3Y0b8Z5sJXNgWS5j9s1+k/ZjmZrHqdK93+w1XawAgOzEkuUGUASH1Pbbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977468; c=relaxed/simple;
	bh=Be9rZg2wVm5Jh98zlevbaUzkraeXZD+KJ2pLFhtjhK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWXDalvW7LebuZCuHDD+Ql8rZC6/gZcDV26xuXifLUXZCv+Ybe99Pkk9/LApTPYRNXaLp+/xz2jEdp55oQe7iobhrAvnhk/70Fg+y0t3g7DMMrJjaO9qiy7bDMe75rSNrhCM07AgC9z780KrD2W8fHlWTHlXLsKJHTFxso5r8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u9BMIIzL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso2044a12.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748977465; x=1749582265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upW65V3EzmhIq53ol8W+l4SqDfLitB19YO+d44FV2Xc=;
        b=u9BMIIzLIRTs5wjnCE24rtIDCehwmizNEi0JabC5233Tsao6QLSBYdZAbIfd18CROQ
         l2uMrQQ26q37WIib3A0kp7HO9xNV+Ub4NO0JVT/xXZIfLGPyoY9THW5MVhwfpHoK/TM0
         +BPy8J3/hWUuhZXS+y1ERIV6msySDLDyDs7CZ7v/z7BxKZSpMh2WsIpcADD//c30//qZ
         iCeSUZC+HPZOORXbvEQuNIwZcwhbEAinn4GSoke6RhcHQl9oDivkJesduuDBMYPhl0P6
         epvt71hFvqQ2tgqDUNODiaiI2ThPs41zxOwcUbWq///D5C8ItCfhF0C67FVJlWIdi8Mn
         L63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748977465; x=1749582265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upW65V3EzmhIq53ol8W+l4SqDfLitB19YO+d44FV2Xc=;
        b=SCHO3ndmoaWLL+YMuenNjdMfEOg1PCpf3hxTCJEbWPcC6dwy8mKfSSxTYK10bnTDka
         il+H4Dj4wzZdxdiGS9d2ZbXaFz+IOKTS2PH8U5mVCZDf9w8uYpDaA4Ox6BVp1kOyVJOO
         BRot5wBMkHXiQolr3ej5vVzdOiUcnG+1//gZpkK9lo9MDeBYypjEHIqrtf9vCIcfJrE0
         lGN1PssKByM6Jn8m8YnNAeWWH6FIdBIHUIoZgzXnpzQuZ255ypWoq11q/CiN1YS+1iFd
         Lty5cGNrZavRu2cDWP0/9ieCx4dERupFgxNIBdftpagVVWdOVFn1LS4ecb4Gn398bNE6
         8OLw==
X-Forwarded-Encrypted: i=1; AJvYcCUV+fGb3Xb0Sp8+OxHPGGuOo6tprMLCx+h1281/0+xyrUMcNNRITNyMWB9CQFpdvsLTqkBwvhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUkoCJDpXa1VjC+rgWmiTaDQcY9wBzowbEl3YGNPtP20ZQPWH
	dAT0BTaLdlC9d/8JTQdMmaz7dq2oaMSgPHBgKgaM/ou6SqgS0QVezPYMK8jp6yEg+tmwOACaCm0
	Ix3849D0B3imtfhKCYACy/iLWUbZpdowck4v9iJ3C
X-Gm-Gg: ASbGncsL6M1842mLZx9FYfgoFwrbvHnVmPDxkecJP8Hy+O2GUz3MbVQ/qPsWsS8CX/d
	8iiqCFwlM/J44TRSCRlxzj18eIka23MerznQeaAzPjZ7JQlqvgSkTDX2ZmUKLeUhSMHdPZu9Dui
	G3na/KsT3qT3p9Oky9dZB828Fc83Li3QYWGugt0HQP8qojlvbupyWoYX1e0nWQ50FH63VW5Q==
X-Google-Smtp-Source: AGHT+IF27moEhGBhsm/ksC0oM3TPqemrqOpUYPAOkCX+3zVbgLX/VHp3AFay/v6jG66/ME7gmjt84tbCZzSThScYaow=
X-Received: by 2002:aa7:d4cf:0:b0:604:58e9:516c with SMTP id
 4fb4d7f45d1cf-606e887b718mr4783a12.5.1748977464523; Tue, 03 Jun 2025 12:04:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com> <aD8--plab38qiQF8@casper.infradead.org>
In-Reply-To: <aD8--plab38qiQF8@casper.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 3 Jun 2025 21:03:48 +0200
X-Gm-Features: AX0GCFuy6Pe40ZC9PMfricVFy-j_0bakFIrtt-vNxRDcTJvFrwsni0IVhkAOpww
Message-ID: <CAG48ez36t3ZaG7DsDCw1xLpdOhKVWQMjcH-hwP66Cbd8p4eTAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory snapshot
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:29=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
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
>
> Um, OK, but isn't that expected behaviour?  POSIX says:

I don't think it is expected behavior that locklessly-updated data
structures in application code could break.

> : A process shall be created with a single thread. If a multi-threaded
> : process calls fork(), the new process shall contain a replica of the
> : calling thread and its entire address space, possibly including the
> : states of mutexes and other resources. Consequently, the application
> : shall ensure that the child process only executes async-signal-safe
> : operations until such time as one of the exec functions is successful.

I think that is only talking about ways in which you can interact with
libc, and does not mean that application code couldn't access its own
lockless data structures or such.

Though admittedly that is a fairly theoretical point, since in
practice the most likely place where you'd encounter this kind of
issue would be in an allocator implementation or such.

> It's always been my understanding that you really, really shouldn't call
> fork() from a multithreaded process.

