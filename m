Return-Path: <stable+bounces-83044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD92C995156
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80C81C25549
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8A1DF995;
	Tue,  8 Oct 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xujv8ROq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB01DE3AE
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397257; cv=none; b=dP3TC19K/QeeFaiCMt5RDIwgApkA2qDKY+TiyabwrilqbYcaAekznmKLaIZUoYmmP/lSBaM1fiwREn6bTlv/Eqd9n/Ym1ymh+M3BFkIbDLh5h3RfiRlp1U5BHiu1+AefSlCbTEJCiO62kwSsGhMmwT8u4ZG31EPaz/aNVH2w6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397257; c=relaxed/simple;
	bh=K5HbSZkb4M4T2gSXTD/bI7Klw/jMLUVqRvwsA3xFm3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxrXSn2aKytGnmXJa6f5Ng+PydVQk30hHFuFU+9xdlfTrrpIsT60eaF1zO9KrGl+9JeyIheD3c3EF3uMer6lNRZOmPatrjyhleePxn26Zo+1WBKodYnG6VkrJqoeMkBCkhcb77wSEveiRIvqHv7Mbk8BjqRJ2tzAdxWhSu8uytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xujv8ROq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe8ec7dbso221725e9.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728397252; x=1729002052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5L57COaQpnN95Wg6Zd7qNnoi5oHy8p/sLDRMT2+LNOQ=;
        b=Xujv8ROqlqUvGdDlzbvdvRlsHU/Dl0F7xfXeSjNeJCZ62ucPSvD0knc2x9S+U59HUd
         VAQ9Gbp6M/E2rM5IJEvSPxF9p8iXlRN8DWR7rn0Yu+NgBQlVWiyiGq1lGNfejA0RWuO0
         WKVrCORZ+nKpga5VTIx8JhCR913R1sE/nHsrvvLaZDOpSiw5ZTI9gbCMPWKJaB3Gg8y2
         vXSpK6A3xv716S/OQz8VDmqmgXYYg9ji0YTu7IuqgVdV3+sqRpr/3XaoNVfIRTmWXtLR
         Tq+DzV2x19NTQCMKc9HuZ8TzXWDrEg9mMuHjdRJZLnurg2SPo0fzQyfQqRsVcYKtUavS
         Gc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397252; x=1729002052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5L57COaQpnN95Wg6Zd7qNnoi5oHy8p/sLDRMT2+LNOQ=;
        b=Taqq2n24S+6P9bTdPDnZi2jLvS0byYrl+TittmUXuoByZk+S1LKTkVsVZXw30G/k+z
         Y/RGmIrdpaGht2JEOHRJMVbUmE7TcOWm8l1TiWeY8pMMgoc8rnTyx9rAtaY4PEHJgb48
         7to535plZFl0+KsC3QImmZwAb0XX5GDK34ZlEtoE7vNhCATizAbRYn+sZhv48tCV7Mki
         8FZVCUvn3yMxduVctCDcW7XMdv5JL65FKvFaPmyL9BJ9Lyd6OpV1S/2ujSjleVXTnbsk
         SGPY0F/e2pWMQCWO9cXYbE72u62qp2UuCTIqU42THkAuovb4cNsrsXbpPtqJgiUqa7Kq
         mvIg==
X-Forwarded-Encrypted: i=1; AJvYcCWQhRgDgxiVhtvpBKyErIa/nrjpgUobYL0JGuh74TaQJT25fn/Vwa7R2U7o+Ce74Y3QiTpPUic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/eLBjtpuD7+sfD+O4ZlA57Tv6CaunZuLO8xnQA2iZeWsH/NB
	cQosaG/CP22mAga2zVHxLNuAK0EK42+w1tAGqD/S7rX+RdGiac9w4kEIO3t+C0emG5xNpriPHEm
	r97a+F7xi3u6YLLyhByUlmewykouJotxkYp2+
X-Google-Smtp-Source: AGHT+IGQGpc+2NdoSgKEGygdRbRQb4CH7S7QnY7D6okjNMK1pfRAP/EMjV3MND1mqjwNOyf5wx+LAoxWUboQj00WPHA=
X-Received: by 2002:a05:600c:1d85:b0:42b:8ff7:bee2 with SMTP id
 5b1f17b1804b1-4303de8bd79mr4008595e9.5.1728397251606; Tue, 08 Oct 2024
 07:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com> <1eda6e90-b8d1-4053-9757-8f59c3a6e7ee@lucifer.local>
In-Reply-To: <1eda6e90-b8d1-4053-9757-8f59c3a6e7ee@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Oct 2024 16:20:13 +0200
Message-ID: <CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com>
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against inaccessible VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>, 
	Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000376d5d0623f7d84b"

--000000000000376d5d0623f7d84b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:40=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> This is touching mm/mmap.c, please ensure to cc- the reviewers (me and
> Liam, I have cc'd Liam here) as listed in MAINTAINERS when submitting
> patches for this file.

Ah, my bad, sorry about that.

> Also this seems like a really speculative 'please discuss' change so shou=
ld
> be an RFC imo.
>
> On Tue, Oct 08, 2024 at 12:55:39AM +0200, Jann Horn wrote:
> > As explained in the comment block this change adds, we can't tell what
> > userspace's intent is when the stack grows towards an inaccessible VMA.
> >
> > I have a (highly contrived) C testcase for 32-bit x86 userspace with gl=
ibc
> > that mixes malloc(), pthread creation, and recursion in just the right =
way
> > such that the main stack overflows into malloc() arena memory.
> > (Let me know if you want me to share that.)
>
> You are claiming a fixes from 2017 and cc'ing stable on a non-RFC so
> yeah... we're going to need more than your word for it :) we will want to
> be really sure this is a thing before we backport to basically every
> stable kernel.
>
> Surely this isn't that hard to demonstrate though? You mmap something
> PROT_NONE just stack gap below the stack, then intentionally extend stack
> to it, before mprotect()'ing the PROT_NONE region?

I've attached my test case that demonstrates this using basically only
malloc, free, pthread_create() and recursion, plus a bunch of ugly
read-only gunk and synchronization. It assumes that it runs under
glibc, as a 32-bit x86 binary. Usage:

$ clang -O2 -fstack-check -m32 -o grow-32 grow-32.c -pthread -ggdb &&
for i in {0..10}; do ./grow-32; done
corrupted thread_obj2 at depth 190528
corrupted thread_obj2 at depth 159517
corrupted thread_obj2 at depth 209777
corrupted thread_obj2 at depth 200119
corrupted thread_obj2 at depth 208093
corrupted thread_obj2 at depth 167705
corrupted thread_obj2 at depth 234523
corrupted thread_obj2 at depth 174528
corrupted thread_obj2 at depth 223823
corrupted thread_obj2 at depth 199816
grow-32: malloc failed: Cannot allocate memory

This demonstrates that it is possible for a userspace program that is
just using basic libc functionality, and whose only bug is unbounded
recursion, to corrupt memory despite being built with -fstack-check.

As you said, to just demonstrate the core issue in a more contrived
way, you can also use a simpler example:

$ cat basic-grow-repro.c
#include <err.h>
#include <stdlib.h>
#include <sys/mman.h>

#define STACK_POINTER() ({ void *__stack; asm volatile("mov %%rsp,
%0":"=3Dr"(__stack)); __stack; })

int main(void) {
  char *ptr =3D (char*)(  (unsigned long)(STACK_POINTER() -
(1024*1024*4)/*4MiB*/) & ~0xfffUL  );
  if (mmap(ptr, 0x1000, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) !=3D p=
tr)
    err(1, "mmap");
  *(volatile char *)(ptr + 0x1000); /* expand stack */
  if (mprotect(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC))
    err(1, "mprotect");
  system("cat /proc/$PPID/maps");
}
$ gcc -o basic-grow-repro basic-grow-repro.c
$ ./basic-grow-repro
5600a0fef000-5600a0ff0000 r--p 00000000 fd:01 28313737
  [...]/basic-grow-repro
5600a0ff0000-5600a0ff1000 r-xp 00001000 fd:01 28313737
  [...]/basic-grow-repro
5600a0ff1000-5600a0ff2000 r--p 00002000 fd:01 28313737
  [...]/basic-grow-repro
5600a0ff2000-5600a0ff3000 r--p 00002000 fd:01 28313737
  [...]/basic-grow-repro
5600a0ff3000-5600a0ff4000 rw-p 00003000 fd:01 28313737
  [...]/basic-grow-repro
7f9a88553000-7f9a88556000 rw-p 00000000 00:00 0
7f9a88556000-7f9a8857c000 r--p 00000000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f9a8857c000-7f9a886d2000 r-xp 00026000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f9a886d2000-7f9a88727000 r--p 0017c000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f9a88727000-7f9a8872b000 r--p 001d0000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f9a8872b000-7f9a8872d000 rw-p 001d4000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f9a8872d000-7f9a8873a000 rw-p 00000000 00:00 0
7f9a88754000-7f9a88756000 rw-p 00000000 00:00 0
7f9a88756000-7f9a8875a000 r--p 00000000 00:00 0                          [v=
var]
7f9a8875a000-7f9a8875c000 r-xp 00000000 00:00 0                          [v=
dso]
7f9a8875c000-7f9a8875d000 r--p 00000000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f9a8875d000-7f9a88782000 r-xp 00001000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f9a88782000-7f9a8878c000 r--p 00026000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f9a8878c000-7f9a8878e000 r--p 00030000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f9a8878e000-7f9a88790000 rw-p 00032000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7fff84664000-7fff84665000 rwxp 00000000 00:00 0
7fff84665000-7fff84a67000 rw-p 00000000 00:00 0                          [s=
tack]
$


Though, while writing the above reproducer, I noticed another dodgy
scenario regarding the stack gap: MAP_FIXED_NOREPLACE apparently
ignores the stack guard region, because it only checks for VMA
intersection, see this example:

$ cat basic-grow-repro-ohno.c
#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

#define STACK_POINTER() ({ void *__stack; asm volatile("mov %%rsp,
%0":"=3Dr"(__stack)); __stack; })

int main(void) {
  setbuf(stdout, NULL);
  char *ptr =3D (char*)(  (unsigned long)(STACK_POINTER() -
(1024*1024*4)/*4MiB*/) & ~0xfffUL  );
  *(volatile char *)(ptr + 0x1000); /* expand stack to just above ptr */

  printf("trying to map at %p\n", ptr);
  system("cat /proc/$PPID/maps;echo");
  if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_FIXED_NOREPLACE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) !=3D ptr)
    err(1, "mmap");
  system("cat /proc/$PPID/maps");
}
$ gcc -o basic-grow-repro-ohno basic-grow-repro-ohno.c
$ ./basic-grow-repro-ohno
trying to map at 0x7ffc344ca000
560ee371d000-560ee371e000 r--p 00000000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee371e000-560ee371f000 r-xp 00001000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee371f000-560ee3720000 r--p 00002000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee3720000-560ee3721000 r--p 00002000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee3721000-560ee3722000 rw-p 00003000 fd:01 28313842
  [...]/basic-grow-repro-ohno
7f0d636ed000-7f0d636f0000 rw-p 00000000 00:00 0
7f0d636f0000-7f0d63716000 r--p 00000000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d63716000-7f0d6386c000 r-xp 00026000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d6386c000-7f0d638c1000 r--p 0017c000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c1000-7f0d638c5000 r--p 001d0000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c5000-7f0d638c7000 rw-p 001d4000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c7000-7f0d638d4000 rw-p 00000000 00:00 0
7f0d638ee000-7f0d638f0000 rw-p 00000000 00:00 0
7f0d638f0000-7f0d638f4000 r--p 00000000 00:00 0                          [v=
var]
7f0d638f4000-7f0d638f6000 r-xp 00000000 00:00 0                          [v=
dso]
7f0d638f6000-7f0d638f7000 r--p 00000000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d638f7000-7f0d6391c000 r-xp 00001000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d6391c000-7f0d63926000 r--p 00026000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d63926000-7f0d63928000 r--p 00030000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d63928000-7f0d6392a000 rw-p 00032000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7ffc344cb000-7ffc348cd000 rw-p 00000000 00:00 0                          [s=
tack]

560ee371d000-560ee371e000 r--p 00000000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee371e000-560ee371f000 r-xp 00001000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee371f000-560ee3720000 r--p 00002000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee3720000-560ee3721000 r--p 00002000 fd:01 28313842
  [...]/basic-grow-repro-ohno
560ee3721000-560ee3722000 rw-p 00003000 fd:01 28313842
  [...]/basic-grow-repro-ohno
7f0d636ed000-7f0d636f0000 rw-p 00000000 00:00 0
7f0d636f0000-7f0d63716000 r--p 00000000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d63716000-7f0d6386c000 r-xp 00026000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d6386c000-7f0d638c1000 r--p 0017c000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c1000-7f0d638c5000 r--p 001d0000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c5000-7f0d638c7000 rw-p 001d4000 fd:01 3417714
  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0d638c7000-7f0d638d4000 rw-p 00000000 00:00 0
7f0d638ee000-7f0d638f0000 rw-p 00000000 00:00 0
7f0d638f0000-7f0d638f4000 r--p 00000000 00:00 0                          [v=
var]
7f0d638f4000-7f0d638f6000 r-xp 00000000 00:00 0                          [v=
dso]
7f0d638f6000-7f0d638f7000 r--p 00000000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d638f7000-7f0d6391c000 r-xp 00001000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d6391c000-7f0d63926000 r--p 00026000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d63926000-7f0d63928000 r--p 00030000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7f0d63928000-7f0d6392a000 rw-p 00032000 fd:01 3409055
  /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7ffc344ca000-7ffc344cb000 rwxp 00000000 00:00 0
7ffc344cb000-7ffc348cd000 rw-p 00000000 00:00 0                          [s=
tack]
$

That could also be bad: MAP_FIXED_NOREPLACE exists, from what I
understand, partly so that malloc implementations can use it to grow
heap memory chunks (though glibc doesn't use it, I'm not sure who
actually uses it that way). We wouldn't want a malloc implementation
to grow a heap memory chunk until it is directly adjacent to a stack.

> > I don't know of any specific scenario where this is actually exploitabl=
e,
> > but it seems like it could be a security problem for sufficiently unluc=
ky
> > userspace.
> >
> > I believe we should ensure that, as long as code is compiled with somet=
hing
> > like -fstack-check, a stack overflow in it can never cause the main sta=
ck
> > to overflow into adjacent heap memory.
> >
> > My fix effectively reverts the behavior for !vma_is_accessible() VMAs t=
o
> > the behavior before commit 1be7107fbe18 ("mm: larger stack guard gap,
> > between vmas"), so I think it should be a fairly safe change even in
> > case A.
> >
> > Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED hol=
es in the stack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I have tested that Libreoffice still launches after this change, though
> > I don't know if that means anything.
> >
> > Note that I haven't tested the growsup code.
> > ---
> >  mm/mmap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 46 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..971bfd6c1cea 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1064,10 +1064,12 @@ static int expand_upwards(struct vm_area_struct=
 *vma, unsigned long address)
> >               gap_addr =3D TASK_SIZE;
> >
> >       next =3D find_vma_intersection(mm, vma->vm_end, gap_addr);
> > -     if (next && vma_is_accessible(next)) {
> > -             if (!(next->vm_flags & VM_GROWSUP))
> > +     if (next && !(next->vm_flags & VM_GROWSUP)) {
> > +             /* see comments in expand_downwards() */
> > +             if (vma_is_accessible(prev))
> > +                     return -ENOMEM;
> > +             if (address =3D=3D next->vm_start)
> >                       return -ENOMEM;
> > -             /* Check that both stack segments have the same anon_vma?=
 */
>
> I hate that we even maintain this for one single arch I believe at this p=
oint?

Looks that way, just parisc?

It would be so nice if we could somehow just get rid of this concept
of growing stacks in general...

> >       }
> >
> >       if (next)
> > @@ -1155,10 +1157,47 @@ int expand_downwards(struct vm_area_struct *vma=
, unsigned long address)
> >       /* Enforce stack_guard_gap */
> >       prev =3D vma_prev(&vmi);
> >       /* Check that both stack segments have the same anon_vma? */
> > -     if (prev) {
> > -             if (!(prev->vm_flags & VM_GROWSDOWN) &&
> > -                 vma_is_accessible(prev) &&
> > -                 (address - prev->vm_end < stack_guard_gap))
> > +     if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
> > +         (address - prev->vm_end < stack_guard_gap)) {
> > +             /*
> > +              * If the previous VMA is accessible, this is the normal =
case
> > +              * where the main stack is growing down towards some unre=
lated
> > +              * VMA. Enforce the full stack guard gap.
> > +              */
> > +             if (vma_is_accessible(prev))
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * If the previous VMA is not accessible, we have a probl=
em:
> > +              * We can't tell what userspace's intent is.
> > +              *
> > +              * Case A:
> > +              * Maybe userspace wants to use the previous VMA as a
> > +              * "guard region" at the bottom of the main stack, in whi=
ch case
> > +              * userspace wants us to grow the stack until it is adjac=
ent to
> > +              * the guard region. Apparently some Java runtime environ=
ments
> > +              * and Rust do that?
> > +              * That is kind of ugly, and in that case userspace reall=
y ought
> > +              * to ensure that the stack is fully expanded immediately=
, but
> > +              * we have to handle this case.
>
> Yeah we can't break userspace on this, no doubt somebody is relying on th=
is
> _somewhere_.

It would have to be a new user who appeared after commit 1be7107fbe18.
And they'd have to install a "guard vma" somewhere below the main
stack, and they'd have to care so much about the size of the stack
that a single page makes a difference.

> That said, I wish we disallowed this altogether regardless of accessibili=
ty.
>
> > +              *
> > +              * Case B:
> > +              * But maybe the previous VMA is entirely unrelated to th=
e stack
> > +              * and is only *temporarily* PROT_NONE. For example, glib=
c
> > +              * malloc arenas create a big PROT_NONE region and then
> > +              * progressively mark parts of it as writable.
> > +              * In that case, we must not let the stack become adjacen=
t to
> > +              * the previous VMA. Otherwise, after the region later be=
comes
> > +              * writable, a stack overflow will cause the stack to gro=
w into
> > +              * the previous VMA, and we won't have any stack gap to p=
rotect
> > +              * against this.
>
> Should be careful with terminology here, an mprotect() will not allow a
> merge so by 'grow into' you mean that a stack VMA could become immediatel=
y
> adjacent to a non-stack VMA prior to it which was later made writable.
>
> Perhaps I am being pedantic...

Ah, sorry, I worded that very confusingly. By "a stack overflow will
cause the stack to grow into the previous VMA", I meant that the stack
pointer moves into the previous VMA and the program uses part of the
previous VMA as stack memory, clobbering whatever was stored there
before. That part was not meant to talk about a change of VMA bounds.

> > +              *
> > +              * As an ugly tradeoff, enforce a single-page gap.
> > +              * A single page will hopefully be small enough to not be
> > +              * noticed in case A, while providing the same level of
> > +              * protection in case B that normal userspace threads get=
.
> > +              */
> > +             if (address =3D=3D prev->vm_end)
> >                       return -ENOMEM;
>
> Ugh, yuck. Not a fan of this at all. Feels like a dreadful hack.

Oh, I agree, I just didn't see a better way to do it.

> You do raise an important point here, but it strikes me that we should be
> doing this check in the mprotect()/mmap() MAP_FIXED scenarios where it
> shouldn't be too costly to check against the next VMA (which we will be
> obtaining anyway for merge checks)?
>
> That way we don't need a hack like this, and can just disallow the
> operation. That'd probably be as liable to break the program as an -ENOME=
M
> on a stack expansion would...

Hmm... yeah, I guess that would work. If someone hits this case, it
would probably be less obvious to the programmer what went wrong based
on the error code, but on the other hand, it would give userspace a
slightly better chance to recover from the issue...

I guess I can see if I can code that up.

--000000000000376d5d0623f7d84b
Content-Type: text/x-csrc; charset="US-ASCII"; name="grow-32.c"
Content-Disposition: attachment; filename="grow-32.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m20f55550>
X-Attachment-Id: f_m20f55550

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnIu
aD4KI2luY2x1ZGUgPHN5cy9ldmVudGZkLmg+CgojZGVmaW5lIFNUQUNLX1BPSU5URVIoKSAoeyB2
b2lkICpfX3N0YWNrOyBhc20gdm9sYXRpbGUoIm1vdiAlJWVzcCwgJTAiOiI9ciIoX19zdGFjaykp
OyBfX3N0YWNrOyB9KQojZGVmaW5lIElHTk9SRSh4KSBhc20gdm9sYXRpbGUoIiI6OiJyIih4KSkK
CiNkZWZpbmUgTUFQX0xFTiAweDEwMDAwMAojZGVmaW5lIFVOTUFQX0NPVU5UIDEwCgpzdGF0aWMg
aW50IGVmZF90b19tYWluLCBlZmRfdG9fdGhyZWFkOwpzdGF0aWMgdm9pZCAqbWFsbG9jX3N0YXJ0
LCAqbWFsbG9jX2VuZDsKc3RhdGljIHVuc2lnbmVkIGxvbmcgKnRocmVhZF9vYmoyOwoKc3RhdGlj
IHZvaWQgKnRocmVhZF9mbih2b2lkICpkdW1teSkgewogIC8qIFNURVAgMiAqLwogIHZvaWQgKnRo
cmVhZF9vYmogPSBtYWxsb2MoMHgxMDAwKTsKICB0aHJlYWRfb2JqMiA9IG1hbGxvYygweDEwMDAp
OwogICp0aHJlYWRfb2JqMiA9IDB4ZGVhZGJlZWY7CiAgbWFsbG9jX3N0YXJ0ID0gKHZvaWQqKSgo
KHVuc2lnbmVkIGxvbmcpdGhyZWFkX29iaikgJiB+MHhmZmZVTCk7CiAgbWFsbG9jX2VuZCA9IG1h
bGxvY19zdGFydCArIE1BUF9MRU47CiAgZXZlbnRmZF93cml0ZShlZmRfdG9fbWFpbiwgMSk7CiAg
ZXZlbnRmZF90IGR1bW15X3ZhbDsKICBldmVudGZkX3JlYWQoZWZkX3RvX3RocmVhZCwgJmR1bW15
X3ZhbCk7CgogIC8qIFNURVAgNCAqLwogIHdoaWxlICgxKSB7CiAgICB2b2lkICpwID0gbWFsbG9j
KDB4NDAwKTsKICAgIGlmIChwIDwgbWFsbG9jX3N0YXJ0IHx8IHAgPiBtYWxsb2NfZW5kKQogICAg
ICBicmVhazsKICB9CiAgZXZlbnRmZF93cml0ZShlZmRfdG9fbWFpbiwgMSk7CgogIHdoaWxlICgx
KQogICAgcGF1c2UoKTsKfQoKX19hdHRyaWJ1dGVfXygobm9pbmxpbmUpKQp2b2lkIHJlY3Vyc2Uo
KSB7CiAgaWYgKFNUQUNLX1BPSU5URVIoKSA+IG1hbGxvY19lbmQrMHhmMDApCiAgICByZWN1cnNl
KCk7CiAgYXNtIHZvbGF0aWxlKCIiKTsKfQoKX19hdHRyaWJ1dGVfXygobm9pbmxpbmUpKQp2b2lk
IHJlY3Vyc2UyKHVuc2lnbmVkIGxvbmcgZGVwdGgpIHsKICBpZiAoKnRocmVhZF9vYmoyICE9IDB4
ZGVhZGJlZWYpIHsKICAgIHByaW50ZigiY29ycnVwdGVkIHRocmVhZF9vYmoyIGF0IGRlcHRoICVs
dVxuIiwgZGVwdGgpOwogICAgZXhpdCgxKTsKICB9CiAgcmVjdXJzZTIoZGVwdGgrMSk7CiAgYXNt
IHZvbGF0aWxlKCIiKTsKfQoKdm9pZCAqdG9wX21hcHNbVU5NQVBfQ09VTlRdOwp2b2lkIHRvcF9t
YXBzX2luc2VydCh2b2lkICpwdHIpIHsKICAvLyBmaW5kIGxvd2VzdCBlbGVtZW50IGluIHRvcF9t
YXBzCiAgc2l6ZV90IGxvd2VzdCA9IDA7CiAgZm9yIChzaXplX3QgaSA9IDA7IGkgPCBVTk1BUF9D
T1VOVDsgaSsrKSB7CiAgICBpZiAodG9wX21hcHNbaV0gPCB0b3BfbWFwc1tsb3dlc3RdKQogICAg
ICBsb3dlc3QgPSBpOwogIH0KICBpZiAodG9wX21hcHNbbG93ZXN0XSA8IHB0cikKICAgIHRvcF9t
YXBzW2xvd2VzdF0gPSBwdHI7Cn0KCmludCBtYWluKHZvaWQpIHsKICBlZmRfdG9fbWFpbiA9IGV2
ZW50ZmQoMCwgRUZEX1NFTUFQSE9SRSk7CiAgZWZkX3RvX3RocmVhZCA9IGV2ZW50ZmQoMCwgRUZE
X1NFTUFQSE9SRSk7CgogIC8qIFNURVAgMSAqLwogIHZvaWQgKnN0YWNrID0gU1RBQ0tfUE9JTlRF
UigpOwogIElHTk9SRShtYWxsb2MoMSkpOyAvKiBtYWtlIHN1cmUgb3VyIGFyZW5hIGlzIGluaXRp
YWxpemVkIG9yIHdoYXRldmVyICovCiAgd2hpbGUgKDEpIHsKICAgIHZvaWQgKm9iaiA9IG1hbGxv
YyhNQVBfTEVOIC0gMHhmMDApOwogICAgaWYgKG9iaiA9PSBOVUxMKQogICAgICBlcnIoMSwgIm1h
bGxvYyBmYWlsZWQiKTsKICAgIGlmIChvYmogPiBTVEFDS19QT0lOVEVSKCkpIHsKICAgICAgZnJl
ZShvYmopOwogICAgICBmb3IgKHNpemVfdCBpID0gMDsgaSA8IFVOTUFQX0NPVU5UOyBpKyspCiAg
ICAgICAgZnJlZSh0b3BfbWFwc1tpXSk7CiAgICAgIGJyZWFrOwogICAgfQogICAgdG9wX21hcHNf
aW5zZXJ0KG9iaik7CiAgfQogIHB0aHJlYWRfdCB0aHJlYWQ7CiAgaWYgKHB0aHJlYWRfY3JlYXRl
KCZ0aHJlYWQsIE5VTEwsIHRocmVhZF9mbiwgTlVMTCkpCiAgICBlcnJ4KDEsICJwdGhyZWFkX2Ny
ZWF0ZSBmYWlsZWQiKTsKICBldmVudGZkX3QgZHVtbXlfdmFsOwogIGV2ZW50ZmRfcmVhZChlZmRf
dG9fbWFpbiwgJmR1bW15X3ZhbCk7CgogIC8qIFNURVAgMyAqLwogIHJlY3Vyc2UoKTsKICBldmVu
dGZkX3dyaXRlKGVmZF90b190aHJlYWQsIDEpOwogIGV2ZW50ZmRfcmVhZChlZmRfdG9fbWFpbiwg
JmR1bW15X3ZhbCk7CgogIC8qIFNURVAgNSAqLwogIHJlY3Vyc2UyKDApOwp9Cg==
--000000000000376d5d0623f7d84b--

