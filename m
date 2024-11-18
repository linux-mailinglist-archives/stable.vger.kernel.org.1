Return-Path: <stable+bounces-93819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56329D1769
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022971F22570
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FBE1BD9F3;
	Mon, 18 Nov 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nQRSqCY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3054199EB2
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952351; cv=none; b=UMMmp/Uybnrl6+Zl0WsSXzgtK6cf9dwqhgd0DZuVgJQUB2dPfqGzlD+dYivrcA4xZu7NkkJWLmcENJsQo3s/Gc/OOQrgjss81fTAG5vdwb6rLAb1ItwbQQ4Usbj0sZLmk2O5l6Y67QUFy6Sce5Fwl9pFw8ZcnFsFW8BkN4JHyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952351; c=relaxed/simple;
	bh=S5Ci+cW/BTzXHMR+vqdJDF5B3XklZIG4cA+g3Z5PoRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYf27vSp8/Pfi0ab8pW0EB46qduaPYtztgwoiE9lrN7w9Whs+Rwgi8SD+q03ZpDldp6HFOW3xMfe2ISiGR8X/epL1c/nWqQVpBO8p4VpkkHPnFqJM5NbHPRpMO1xvW6Z7lxUtvWwxhfTHaLBfUEwweyivNPBiurksHc9bEjLk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nQRSqCY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211f1a46f7fso3805ad.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731952349; x=1732557149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYRwOqHXgBSPG5FYbCwLw3UU1tpwz/sD7toXk7cf5rg=;
        b=0nQRSqCYszYJW8D0SLp1lv4MQVDOzkAm/tno/rDIWOSzCFjmqkWRz0XF9ppsBRI7lR
         4HrqD8mndCgzA0m7MPacm1mY+ye50i5HPYBo2YmVzBdeYS7Z4KlQ1fv4QULVkK2azmFw
         VSTX6sZtLSTQNJABqtzfFv/P3mPlhceiAuq7AXDqRmuYJkOiXPF549GbCqEeHgti5o/q
         28aVqV2ryMlVm5iUwDh1+7xakeYQiXxzx3hr6riXbQtD9PQf2ymAiFh74nceKUq7/9k1
         WnQtmPUcTE56s0IjHrNp+Vdo67ONx1j8P+IiLjGKiWxgAWh8bO7n7VoZ5bxj+2M1HFQu
         cUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731952349; x=1732557149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYRwOqHXgBSPG5FYbCwLw3UU1tpwz/sD7toXk7cf5rg=;
        b=uKK/s+rNnWIJCmWNLnjozmdMMZMFCUQ2ZcfvIEmTSeDr7uasMLvB9RXz9TcuCof8mj
         f7T/yvKrY64ebudj9TZn2KxW9Sc5dVbR8SdCoflO3UZq+x0BgKfet8RuzwUnQ/el71Ix
         wbgWWHSrgUD9VYXsUdHwLMCBTtmODaREI3hMaypbqIEckfYGPuadPxr19QGronJU4XVV
         SRzBvcAau1rqf2JiDkyik4bx7A8NhAawjaSSvLnZEnLl8sa6/+3Hq3XIO0oISzNs4o/X
         wx8kV+wPFcpGQLs1By5HKUQcPsVzNR8ZxsOOnFw53Dx9uD8tD1MY0LZfgrFUTorHu6/E
         S3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdgfpsHUrQJE4F3fAmRHEt64/5ZuWoRiDv3k6fXYL5kpLcLgA8WOG+fslZ+Y0kVX95ou0TjXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+SngzNm0C0WW7hiH8SavrleUwvEH1kZW9TrzpW7Vv+i0bmA7
	2qEIAJOYw0fMouqktOrRRCorh4W7WIvOxxE2J4OsFXLQCeS1eVqSpCRGFElf4rSHQCKkhLTZ0jS
	v2/7WEy+QJ6IwQJbuf1uTC1tuCF2PAA32Arrw
X-Gm-Gg: ASbGncu4a8m+/b5qhiq3OCtRntO7cyzov3U/nHDsJGn8GnfYWmP3cNa23Yd45+UNxZZ
	AbBYlD9JFcg0oat/OfjtEeEDFxRfZ2rO/rVAAoQF83pTsStwSWb5khy62c2m5
X-Google-Smtp-Source: AGHT+IH9qij2EnnTYU4wrp7ebJ6CSIKmnbgIYjmTwkCubEC1uoLblQ9ynjH72jG8nKndf4Q/Tj7SpMa7oNNvU2mC27o=
X-Received: by 2002:a17:902:e547:b0:20c:a97d:cc83 with SMTP id
 d9443c01a7336-211edb6efe6mr4539185ad.16.1731952348724; Mon, 18 Nov 2024
 09:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com>
 <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
 <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz> <CAHbLzkq+CwMdGprYFa4jrzc3QSJ5eCDcEtp_EwWJ3G-aJmEx6A@mail.gmail.com>
In-Reply-To: <CAHbLzkq+CwMdGprYFa4jrzc3QSJ5eCDcEtp_EwWJ3G-aJmEx6A@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 18 Nov 2024 09:52:15 -0800
Message-ID: <CAC_TJvdO7pqsmHNjvtTV3WsQvwCF9sa9PdmNE3rVEOSb20v--w@mail.gmail.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
To: Yang Shi <shy828301@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel-team@android.com, android-mm@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Shi <yang@os.amperecomputing.com>, 
	Rik van Riel <riel@surriel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 9:05=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Sun, Nov 17, 2024 at 3:12=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 11/15/24 23:15, Yang Shi wrote:
> > > On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh@goo=
gle.com> wrote:
> > >>
> > >> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > >> boundaries") updated __get_unmapped_area() to align the start addres=
s
> > >> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
> > >>
> > >> It does this by effectively looking up a region that is of size,
> > >> request_size + PMD_SIZE, and aligning up the start to a PMD boundary=
.
> > >>
> > >> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignme=
nt
> > >> on 32 bit") opted out of this for 32bit due to regressions in mmap b=
ase
> > >> randomization.
> > >>
> > >> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> > >> mappings to PMD-aligned sizes") restricted this to only mmap sizes t=
hat
> > >> are multiples of the PMD_SIZE due to reported regressions in some
> > >> performance benchmarks -- which seemed mostly due to the reduced spa=
tial
> > >> locality of related mappings due to the forced PMD-alignment.
> > >>
> > >> Another unintended side effect has emerged: When a user specifies an=
 mmap
> > >> hint address, the THP alignment logic modifies the behavior, potenti=
ally
> > >> ignoring the hint even if a sufficiently large gap exists at the req=
uested
> > >> hint location.
> > >>
> > >> Example Scenario:
> > >>
> > >> Consider the following simplified virtual address (VA) space:
> > >>
> > >>     ...
> > >>
> > >>     0x200000-0x400000 --- VMA A
> > >>     0x400000-0x600000 --- Hole
> > >>     0x600000-0x800000 --- VMA B
> > >>
> > >>     ...
> > >>
> > >> A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves dif=
ferently:
> > >>
> > >>   - Before THP alignment: The requested region (size 0x200000) fits =
into
> > >>     the gap at 0x400000, so the hint is respected.
> > >>
> > >>   - After alignment: The logic searches for a region of size
> > >>     0x400000 (len + PMD_SIZE) starting at 0x400000.
> > >>     This search fails due to the mapping at 0x600000 (VMA B), and th=
e hint
> > >>     is ignored, falling back to arch_get_unmapped_area[_topdown]().
> >

Hi all, Thanks for the reviews.

> > Hmm looks like the search is not done in the optimal way regardless of
> > whether or not it ignores a hint - it should be able to find the hole, =
no?

It's not able to find the hole in the example case because the size we
are looking for is now
(requested size + padding len) which is larger than the hole we have
at the hint address.

> >
> > >> In general the hint is effectively ignored, if there is any
> > >> existing mapping in the below range:
> > >>
> > >>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> > >>
> > >> This changes the semantics of mmap hint; from ""Respect the hint if =
a
> > >> sufficiently large gap exists at the requested location" to "Respect=
 the
> > >> hint only if an additional PMD-sized gap exists beyond the requested=
 size".
> > >>
> > >> This has performance implications for allocators that allocate their=
 heap
> > >> using mmap but try to keep it "as contiguous as possible" by using t=
he
> > >> end of the exisiting heap as the address hint. With the new behavior
> > >> it's more likely to get a much less contiguous heap, adding extra
> > >> fragmentation and performance overhead.
> > >>
> > >> To restore the expected behavior; don't use thp_get_unmapped_area_vm=
flags()
> > >> when the user provided a hint address.
> >
> > Agreed, the hint should take precendence.
> >
> > > Thanks for fixing it. I agree we should respect the hint address. But
> > > this patch actually just fixed anonymous mapping and the file mapping=
s
> > > which don't support thp_get_unmapped_area(). So I think you should
> > > move the hint check to __thp_get_unmapped_area().
> > >
> > > And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
> > > anonymous mappings to PMD-aligned sizes") should be moved to there to=
o
> > > IMHO.
> >
> > This was brought up, but I didn't want to do it as part of the stable f=
ix as
> > that would change even situations that Rik's change didn't.
> > If the mmap hint change is another stable hotfix, I wouldn't conflate i=
t
> > either. But we can try it for further development. But careful about ju=
st
> > moving the code as-is, the file-based mappings are different than anony=
mous
> > memory and I believe file offsets matter:
> >
> > https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.c=
z/
> >
> > https://lore.kernel.org/all/5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.c=
z/
>

I see, so I think we should keep the check here to address the
immediate regression for anonymous mappings.

I believe what we would need to address this longer term is to have
vma_iter_lowest() [1] vma_iter_highest() [2] take into account the
alignment when doing the search. That way we don't need to inflate the
search size to facilitate the manual alignment after the fact. I
haven't looked too too deeply into this, maybe Liam has some ideas
about that?

[1] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L420

[2] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L426

> Did some research about the history of the code, I found this commit:
>
> 97d3d0f9a1cf ("mm/huge_memory.c: thp: fix conflict of above-47bit hint
> address and PMD alignment"), it tried to fix "the function would not
> try to allocate PMD-aligned area if *any* hint address specified."
> It was for file mapping back then since anonymous mapping THP
> alignment was not supported yet.
>
> But it seems like this patch somehow tried to do something reverse. It
> may not be correct either.
>

IIUC Kirill's patch is doing the right thing (mostly), i.e. it will
return the hint address (without any rounding to PMD alignment). The
case it doesn't handle is what I mentioned above, where we aren't able
to find the hole at the hint address in the first place because the
hole is smaller than (size + padding len)

> With Vlastimis's fix, we just try to make the address THP aligned for
> anonymous mapping when the size is PMD aligned. So we don't need to
> take into account the padding for anonymous mapping anymore.
>

We still need to have padding length because PMD alignment of the size
doesn't mean that the start address returned by the search will be PMD
aligned. Inherently those are only PAGE aligned.

Thanks,
Kalesh

> So IIUC we should do something like:
>
> @@ -1085,7 +1085,11 @@ static unsigned long
> __thp_get_unmapped_area(struct file *filp,
>         if (off_end <=3D off_align || (off_end - off_align) < size)
>                 return 0;
>
> -       len_pad =3D len + size;
> +       if (filp)
> +               len_pad =3D len + size;
> +       else
> +               len_pad =3D len;
> +
>         if (len_pad < len || (off + len_pad) < off)
>                 return 0;
>
> >
> > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >> Cc: Vlastimil Babka <vbabka@suse.cz>
> > >> Cc: Yang Shi <yang@os.amperecomputing.com>
> > >> Cc: Rik van Riel <riel@surriel.com>
> > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >> Cc: Suren Baghdasaryan <surenb@google.com>
> > >> Cc: Minchan Kim <minchan@kernel.org>
> > >> Cc: Hans Boehm <hboehm@google.com>
> > >> Cc: Lokesh Gidra <lokeshgidra@google.com>
> > >> Cc: <stable@vger.kernel.org>
> > >> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP bou=
ndaries")
> > >> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > >> ---
> > >>  mm/mmap.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/mm/mmap.c b/mm/mmap.c
> > >> index 79d541f1502b..2f01f1a8e304 100644
> > >> --- a/mm/mmap.c
> > >> +++ b/mm/mmap.c
> > >> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned =
long addr, unsigned long len,
> > >>         if (get_area) {
> > >>                 addr =3D get_area(file, addr, len, pgoff, flags);
> > >>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> > >> +                  && !addr /* no hint */
> > >>                    && IS_ALIGNED(len, PMD_SIZE)) {
> > >>                 /* Ensures that larger anonymous mappings are THP al=
igned. */
> > >>                 addr =3D thp_get_unmapped_area_vmflags(file, addr, l=
en,
> > >>
> > >> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> > >> --
> > >> 2.47.0.338.g60cca15819-goog
> > >>
> >

