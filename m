Return-Path: <stable+bounces-83488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AEC99AB74
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB94284900
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C641CFEB6;
	Fri, 11 Oct 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+E0N0xt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A1CDA0A
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672426; cv=none; b=qoTAttwhhHLR+ccNsIm0bQizi9Cx4H1GIDCLmJX05NVLpzBD4ZlW1N1P+7+MpoNiD+iv8hdQZYEody7//wHnFx5h03ZHC7Ko8cSCToneE91vOu88Kqmlu1UVd6n3eNUXPU1MdF69ejPFLXT+95/0xtQAkOKuLtqRqaQyUpd/zUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672426; c=relaxed/simple;
	bh=GXiXoMKDHZODULsqhNnitTHecjzxazifbVVQeopfNJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VQOemtDCcXjam2sHZW1upSNP8x6Y2sN0PSoERcOqs49vlV5SzMyIdDPJEowBDy6eizBlBzelWXYjQtc39wr72dLkKhxM16Tlguer92DgCHoT6hNbYghEf0XtCLUImtGMxBjogE1/reUlDwomFozsZFwX1ZkWHxTj0DjLDxUvm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+E0N0xt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539c10ea8adso3351e87.1
        for <stable@vger.kernel.org>; Fri, 11 Oct 2024 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728672422; x=1729277222; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX3HkjI6Zaa2TFFdkwiH3pZsKN0shfauRmPc72yF3JA=;
        b=L+E0N0xtoapVHAUeWYQsn5LMT0XxnC8kauYe09QWJR/1ORce2Us1Jp/e8Jd+stslL7
         eOsPmxzSqNrcDgTOf2kqBepuj3znHZnRn+Cl9h7cbHbXobm2yS7mE/hAv4yJyE0gK5pd
         yW6A1jJb/W4f1C7z1gaBLVfbCiCAbj1KUA8TeXaxUQaiN7GR53maUEwnIhZf9l5NcBuL
         Mw8JsWjrzFwwXAErKtDuMD8sYU4Lsy0QvJC1MR0TLx+kpZY4feBz6NGGO2H0kS9AiW/H
         7QQ41jkYKak/Vmps30OzwAecmEkRtyLxzniv+VekTpOfOwyX8Crd/w0x33d9l70160im
         p8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672422; x=1729277222;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX3HkjI6Zaa2TFFdkwiH3pZsKN0shfauRmPc72yF3JA=;
        b=PWOwmVUv9eBSKyB5VZhzEdNhywgVq8V2nsfT0T7ngwut0Q5Ngo70zV1RxThRwiPZj3
         l9+k+BnN/2PKCGIMDrxDzVTp2OyUmzFJRI+Q7yY8H0R7J6xpLD3V8riSaov15SsgzW9i
         97PWpvvdCwNOZ6fq+QKSlGBcT+eEtXwS/CePpjeUmIqW47TMqQv/zcYq0a3kxk/CeVWl
         dbHU4lyFSnO5Z7xG19Pa3YaAFrtAfq27fuKp6TyS12gpLhik0bM1zNczAP1RiXATiSrb
         rxyot0xAjvUeQAHm6QLAXw7yERVzJvFKB4CPu6ieirzY1AF6qY0SqED5z2PHiA0UIgX+
         VwOg==
X-Forwarded-Encrypted: i=1; AJvYcCVnEx7N8Hx3cqABwzP4HVEh/yKaTcgJQ8ZngbubuU1Di+2b0NyT+GoiW7NClQnJE+N7HV2aYsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiqGBHq8zUUi1S//6xkreXZVeUL5fX7/tPISkjZOoUFIMjn45
	anzPNQwasE9h0N53hVeb50lm6tvCha6z6jsXOJH+zCypx96y3xdlWRRYnVINnI6j6S52ZAm3PzS
	DHa3mRWVYk05Kjd5TJloezeK3lbvezVaFvMd3
X-Google-Smtp-Source: AGHT+IEpsGIBekk+TDxVRpGTKk+rvvy2DrAz7Z6lJU9X6FNw2REhZ2lq2Ony9IlWMCI/Pg8y632cDd0FBh1e/rpHWXo=
X-Received: by 2002:a05:6512:acf:b0:52e:8475:7c23 with SMTP id
 2adb3069b0e04-539e60a65ebmr35995e87.7.1728672421904; Fri, 11 Oct 2024
 11:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-stack-gap-inaccessible-v2-1-111b6a0ee2cb@google.com> <dantzkqu2pyeypcbljes6omc2wuyqjguhgd4lcrk2tijfyyd2g@fx46a4mynnsh>
In-Reply-To: <dantzkqu2pyeypcbljes6omc2wuyqjguhgd4lcrk2tijfyyd2g@fx46a4mynnsh>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Oct 2024 20:46:24 +0200
Message-ID: <CAG48ez2ZrTqEwnV18isAeYLT-FE1r2io+eXcqNp=ck1n0E08zg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] mm: Enforce the stack gap when changing
 inaccessible VMAs
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Helge Deller <deller@gmx.de>, Ben Hutchings <ben@decadent.org.uk>, 
	Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 7:55=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Jann Horn <jannh@google.com> [241011 11:51]:
> > As explained in the comment block this change adds, we can't tell what
> > userspace's intent is when the stack grows towards an inaccessible VMA.
> >
> > We should ensure that, as long as code is compiled with something like
> > -fstack-check, a stack overflow in this code can never cause the main s=
tack
> > to overflow into adjacent heap memory - so the bottom of a stack should
> > never be directly adjacent to an accessible VMA.
[...]
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..937361be3c48 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -359,6 +359,20 @@ unsigned long do_mmap(struct file *file, unsigned =
long addr,
> >                       return -EEXIST;
> >       }
> >
> > +     /*
> > +      * This does two things:
> > +      *
> > +      * 1. Disallow MAP_FIXED replacing a PROT_NONE VMA adjacent to a =
stack
> > +      * with an accessible VMA.
> > +      * 2. Disallow MAP_FIXED_NOREPLACE creating a new accessible VMA
> > +      * adjacent to a stack.
> > +      */
> > +     if ((flags & (MAP_FIXED_NOREPLACE | MAP_FIXED)) &&
> > +         (prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> > +         !(vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> > +         overlaps_stack_gap(mm, addr, len))
> > +             return (flags & MAP_FIXED) ? -ENOMEM : -EEXIST;
> > +
>
> This is probably going to impact performance for allocators by causing
> two walks of the tree any time they protect a portion of mmaped area.

Well, it's one extra walk except on parisc, thanks to the "if
(!IS_ENABLED(CONFIG_STACK_GROWSUP))" bailout - but point taken, it
would be better to avoid that.

> In the mmap_region() code, there is a place we know next/prev on
> MAP_FIXED, and next for MAP_FIXED_NOREPLACE - which has a vma iterator
> that would be lower cost than a tree walk.  That area may be a better
> place to check these requirements.  Unfortunately, it may cause a vma
> split in the vms_gather_munmap_vmas() call prior to this check, but
> considering the rarity it may not be that big of a deal?

Hmm, yeah, that sounds fine to me.

[...]
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 0c5d6d06107d..2300e2eff956 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -772,6 +772,12 @@ static int do_mprotect_pkey(unsigned long start, s=
ize_t len,
> >               }
> >       }
> >
> > +     error =3D -ENOMEM;
> > +     if ((prot & (PROT_READ | PROT_WRITE | PROT_EXEC)) &&
> > +         !(vma->vm_flags & (VM_GROWSUP|VM_GROWSDOWN)) &&
> > +         overlaps_stack_gap(current->mm, start, end - start))
> > +             goto out;
> > +
>
> We have prev just below your call here, so we could reuse that.  Getting
> the vma after the mprotect range doesn't seem that easy.  I guess we
> need to make the loop even more complicated and find the next vma (and
> remember the fixup can merge).  This isn't as straight forward as what
> you have, but would be faster.

For mprotect, maybe one option would be to do it inside the loop?
Something like this:

```
diff --git a/mm/mprotect.c b/mm/mprotect.c
index d0e3ebfadef8..2873cc254eaf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -790,6 +790,24 @@ static int do_mprotect_pkey(unsigned long start,
size_t len,
                        break;
                }

+               if (IS_ENABLED(CONFIG_STACK_GROWSUP) && vma->vm_start
=3D=3D start) {
+                       /* just do an extra lookup here, we do this
only on parisc */
+                       if (overlaps_stack_gap_growsup([...])) {
+                               error =3D -ENOMEM;
+                               break;
+                       }
+               }
+               if (vma->vm_end =3D=3D end) {
+                       /* peek ahead */
+                       struct vma_iterator vmi_peek =3D vmi;
+                       struct vm_area_struct *next =3D vma_next(&vmi_peek)=
;
+
+                       if (next && overlaps_stack_gap_growsdown([...], nex=
t)) {
+                               error =3D -ENOMEM;
+                               break;
+                       }
+               }
+
                /* Does the application expect PROT_READ to imply PROT_EXEC=
 */
                if (rier && (vma->vm_flags & VM_MAYEXEC))
                        prot |=3D PROT_EXEC;
```

Assuming that well-behaved userspace only calls mprotect() ranges that
are fully covered by VMAs, that should be good enough?

(I don't know how you feel about the idea of peeking ahead from a VMA
iterator by copying the iterator, I imagine you might have a better
way to do that...)

> >       prev =3D vma_prev(&vmi);
> >       if (start > vma->vm_start)
> >               prev =3D vma;

