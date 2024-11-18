Return-Path: <stable+bounces-93870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 522CC9D1AC0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C9A1F22E2A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380D1E572E;
	Mon, 18 Nov 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyeLblNq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A7153BE4;
	Mon, 18 Nov 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966286; cv=none; b=B8pRRPgdK/jyfiTCk7yI9Ugek9aBJdVlmXzF9gYUEk5a4TAAcE0n80xRLro+C3JhSPZsY2fue3ILbXaxkkZ2w/3lHgLHEZ4H658+7IhF2NtuJFfaOMqz8+X1acPNAc7mZ00ZPvEMaJnGeQoRLyyvtq+36hOPdyd4a3EDUuIHD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966286; c=relaxed/simple;
	bh=VlG1A76kzh/QP8dTH38mXQGdnjhtV6erPt8D8K+kBDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCd7bpwUbAy6HKTULiUJsLj+2yYvQkU51kjoX/ru3rjxJK9aCaWxvriY7LzveCEYekYGXhkfcg6Z2V6bbk+sdGqAURfx5fPQsPkO07l1K/PI/qP6AX9smDgU5jvTT/cnzR4/eQbkmxb68BcTu7VlB0sLeCr68YL8C4ZLG5/gH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyeLblNq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso2590574a12.2;
        Mon, 18 Nov 2024 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731966281; x=1732571081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRfriMQu+9mTxB6xkzjxY3uVJzxTJgqFClD86fzO5dc=;
        b=iyeLblNqzIUZHvH/WLwDLXgc2ocsuPHJ2s0dyF5tm9eZg8PhwoVG/vRI4SSdcs981U
         LuhVdNpujhoYIXCx2B6VtZLezQucPX9O/62VVJ82mK0DVuoZVrXI0Tc51I+i312LzubF
         BAjnS/poxxdfbDYIL/GreuORNg70RZ6JQFV6cOieOppQVClDCGEcLVjVoep6w7agT510
         yZuJ7Y4CO/uz0OhC0MQq2W0esaKu8k1Ps8pszY7VHOtO3micPvPW2Ks3J7YaIlZbaQoD
         v4EMMBsrYjrJ2Dqk2aVZl9UrqZXgGADD/RA8cK3I9ZUUni+//6buekARqGlUddc+ZecS
         xZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731966281; x=1732571081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRfriMQu+9mTxB6xkzjxY3uVJzxTJgqFClD86fzO5dc=;
        b=Duubv2hQTknpW/n0mQAdrDm2ZEEWWqNJ2/ngXZ6toPP0+bYxf693LZITiFvbH4MoqM
         cLwjLLjfkhaXyn6jTlv2y4wrAAglkB9uDx7IirXExy9b4aKlPIuNFjIHR1Qu10kCkxsO
         8ev86e5aNh8W4h5fFuly3dhikt6mO0EhkztWYOL8YePmBFYcV6jgLbeyY1VXKdzQW3o4
         86DCsLaGnbjIgLZG/mC5oiqFLWtKdARRLkgnoCOzYYXWOlcAXyaLsA0UsSHQuByWgxaS
         aRPARNCT8ph9y9xACsxnzitIDpTK4ItxmScujCyyyKqeeW/1EPy1h7PUwnC8Vqy7CO3y
         YMEw==
X-Forwarded-Encrypted: i=1; AJvYcCUQiIwvSungsMHBD1mOoS29kBfpZXyTJmnBFxZDqMs/fPlrgCGmpBNmM3ghp+0o+N/hPFArJJl2@vger.kernel.org, AJvYcCVOawAHwc/maqeAc283Iz9O1VsmSzM2hUsUf9yeGw2Lk910BPkd5tcAn+fBN7vFj3lE2mU1jw7e9yfIqwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4Srbucejo1VYeLhNvViVtQPkGscNy8uhnhXUb+L1/MLBM/Nt
	mMX1hhxC4l5sLPIMH7v2S17xcYIC373kekEbWgzhlhoRskyrpWJxJu8wF3stnGPzyHHPlTHySKa
	hhNnVFqAHx4YfX/pAeYBEKgZX23E=
X-Google-Smtp-Source: AGHT+IGILNYbmfG19eVFGOYb5KN1Iq5ZhEmhjDA+8mqCgpJJZjE1CC2wXLnImgrqYrI+QLReoyoTBJnAsy5N2wM+IeA=
X-Received: by 2002:a05:6402:2695:b0:5cf:e022:24f5 with SMTP id
 4fb4d7f45d1cf-5cfe022337amr150632a12.2.1731966280598; Mon, 18 Nov 2024
 13:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com>
 <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
 <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz> <CAHbLzkq+CwMdGprYFa4jrzc3QSJ5eCDcEtp_EwWJ3G-aJmEx6A@mail.gmail.com>
 <CAC_TJvdO7pqsmHNjvtTV3WsQvwCF9sa9PdmNE3rVEOSb20v--w@mail.gmail.com>
In-Reply-To: <CAC_TJvdO7pqsmHNjvtTV3WsQvwCF9sa9PdmNE3rVEOSb20v--w@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 18 Nov 2024 13:44:29 -0800
Message-ID: <CAHbLzkqFfduLoWAiP3xwjMg5=JqEsKFMHAxh_ypmvGMBqAMbFg@mail.gmail.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, kernel-team@android.com, android-mm@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Shi <yang@os.amperecomputing.com>, 
	Rik van Riel <riel@surriel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 9:52=E2=80=AFAM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Mon, Nov 18, 2024 at 9:05=E2=80=AFAM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Sun, Nov 17, 2024 at 3:12=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > On 11/15/24 23:15, Yang Shi wrote:
> > > > On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh@g=
oogle.com> wrote:
> > > >>
> > > >> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > > >> boundaries") updated __get_unmapped_area() to align the start addr=
ess
> > > >> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
> > > >>
> > > >> It does this by effectively looking up a region that is of size,
> > > >> request_size + PMD_SIZE, and aligning up the start to a PMD bounda=
ry.
> > > >>
> > > >> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page align=
ment
> > > >> on 32 bit") opted out of this for 32bit due to regressions in mmap=
 base
> > > >> randomization.
> > > >>
> > > >> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> > > >> mappings to PMD-aligned sizes") restricted this to only mmap sizes=
 that
> > > >> are multiples of the PMD_SIZE due to reported regressions in some
> > > >> performance benchmarks -- which seemed mostly due to the reduced s=
patial
> > > >> locality of related mappings due to the forced PMD-alignment.
> > > >>
> > > >> Another unintended side effect has emerged: When a user specifies =
an mmap
> > > >> hint address, the THP alignment logic modifies the behavior, poten=
tially
> > > >> ignoring the hint even if a sufficiently large gap exists at the r=
equested
> > > >> hint location.
> > > >>
> > > >> Example Scenario:
> > > >>
> > > >> Consider the following simplified virtual address (VA) space:
> > > >>
> > > >>     ...
> > > >>
> > > >>     0x200000-0x400000 --- VMA A
> > > >>     0x400000-0x600000 --- Hole
> > > >>     0x600000-0x800000 --- VMA B
> > > >>
> > > >>     ...
> > > >>
> > > >> A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves d=
ifferently:
> > > >>
> > > >>   - Before THP alignment: The requested region (size 0x200000) fit=
s into
> > > >>     the gap at 0x400000, so the hint is respected.
> > > >>
> > > >>   - After alignment: The logic searches for a region of size
> > > >>     0x400000 (len + PMD_SIZE) starting at 0x400000.
> > > >>     This search fails due to the mapping at 0x600000 (VMA B), and =
the hint
> > > >>     is ignored, falling back to arch_get_unmapped_area[_topdown]()=
.
> > >
>
> Hi all, Thanks for the reviews.
>
> > > Hmm looks like the search is not done in the optimal way regardless o=
f
> > > whether or not it ignores a hint - it should be able to find the hole=
, no?
>
> It's not able to find the hole in the example case because the size we
> are looking for is now
> (requested size + padding len) which is larger than the hole we have
> at the hint address.
>
> > >
> > > >> In general the hint is effectively ignored, if there is any
> > > >> existing mapping in the below range:
> > > >>
> > > >>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> > > >>
> > > >> This changes the semantics of mmap hint; from ""Respect the hint i=
f a
> > > >> sufficiently large gap exists at the requested location" to "Respe=
ct the
> > > >> hint only if an additional PMD-sized gap exists beyond the request=
ed size".
> > > >>
> > > >> This has performance implications for allocators that allocate the=
ir heap
> > > >> using mmap but try to keep it "as contiguous as possible" by using=
 the
> > > >> end of the exisiting heap as the address hint. With the new behavi=
or
> > > >> it's more likely to get a much less contiguous heap, adding extra
> > > >> fragmentation and performance overhead.
> > > >>
> > > >> To restore the expected behavior; don't use thp_get_unmapped_area_=
vmflags()
> > > >> when the user provided a hint address.
> > >
> > > Agreed, the hint should take precendence.
> > >
> > > > Thanks for fixing it. I agree we should respect the hint address. B=
ut
> > > > this patch actually just fixed anonymous mapping and the file mappi=
ngs
> > > > which don't support thp_get_unmapped_area(). So I think you should
> > > > move the hint check to __thp_get_unmapped_area().
> > > >
> > > > And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
> > > > anonymous mappings to PMD-aligned sizes") should be moved to there =
too
> > > > IMHO.
> > >
> > > This was brought up, but I didn't want to do it as part of the stable=
 fix as
> > > that would change even situations that Rik's change didn't.
> > > If the mmap hint change is another stable hotfix, I wouldn't conflate=
 it
> > > either. But we can try it for further development. But careful about =
just
> > > moving the code as-is, the file-based mappings are different than ano=
nymous
> > > memory and I believe file offsets matter:
> > >
> > > https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse=
.cz/
> > >
> > > https://lore.kernel.org/all/5f7a49e8-0416-4648-a704-a7a67e8cd894@suse=
.cz/
> >
>
> I see, so I think we should keep the check here to address the
> immediate regression for anonymous mappings.
>
> I believe what we would need to address this longer term is to have
> vma_iter_lowest() [1] vma_iter_highest() [2] take into account the
> alignment when doing the search. That way we don't need to inflate the
> search size to facilitate the manual alignment after the fact. I
> haven't looked too too deeply into this, maybe Liam has some ideas
> about that?
>
> [1] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L420
>
> [2] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L426
>
> > Did some research about the history of the code, I found this commit:
> >
> > 97d3d0f9a1cf ("mm/huge_memory.c: thp: fix conflict of above-47bit hint
> > address and PMD alignment"), it tried to fix "the function would not
> > try to allocate PMD-aligned area if *any* hint address specified."
> > It was for file mapping back then since anonymous mapping THP
> > alignment was not supported yet.
> >
> > But it seems like this patch somehow tried to do something reverse. It
> > may not be correct either.
> >
>
> IIUC Kirill's patch is doing the right thing (mostly), i.e. it will
> return the hint address (without any rounding to PMD alignment). The
> case it doesn't handle is what I mentioned above, where we aren't able
> to find the hole at the hint address in the first place because the
> hole is smaller than (size + padding len)

Yes. But my point is your fix (just simply skip PMD alignment when
hint is specified) actually broke what Kirill fixed IIUC.

>
> > With Vlastimis's fix, we just try to make the address THP aligned for
> > anonymous mapping when the size is PMD aligned. So we don't need to
> > take into account the padding for anonymous mapping anymore.
> >
>
> We still need to have padding length because PMD alignment of the size
> doesn't mean that the start address returned by the search will be PMD
> aligned. Inherently those are only PAGE aligned.

Yes, you are right, I overlooked this. I think we can do this in two
passes. Use len w/o padding in the first pass. If the returned address
equals the hint or it is already PMD aligned, just return it.
Otherwise it means there is no hole with suitable size and alignment.
In the second pass, we redo it with padding. Just off the top of my
head, others may have better ideas.

>
> Thanks,
> Kalesh
>
> > So IIUC we should do something like:
> >
> > @@ -1085,7 +1085,11 @@ static unsigned long
> > __thp_get_unmapped_area(struct file *filp,
> >         if (off_end <=3D off_align || (off_end - off_align) < size)
> >                 return 0;
> >
> > -       len_pad =3D len + size;
> > +       if (filp)
> > +               len_pad =3D len + size;
> > +       else
> > +               len_pad =3D len;
> > +
> >         if (len_pad < len || (off + len_pad) < off)
> >                 return 0;
> >
> > >
> > > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > >> Cc: Vlastimil Babka <vbabka@suse.cz>
> > > >> Cc: Yang Shi <yang@os.amperecomputing.com>
> > > >> Cc: Rik van Riel <riel@surriel.com>
> > > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > >> Cc: Suren Baghdasaryan <surenb@google.com>
> > > >> Cc: Minchan Kim <minchan@kernel.org>
> > > >> Cc: Hans Boehm <hboehm@google.com>
> > > >> Cc: Lokesh Gidra <lokeshgidra@google.com>
> > > >> Cc: <stable@vger.kernel.org>
> > > >> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP b=
oundaries")
> > > >> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > >
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > >
> > > >> ---
> > > >>  mm/mmap.c | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/mm/mmap.c b/mm/mmap.c
> > > >> index 79d541f1502b..2f01f1a8e304 100644
> > > >> --- a/mm/mmap.c
> > > >> +++ b/mm/mmap.c
> > > >> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigne=
d long addr, unsigned long len,
> > > >>         if (get_area) {
> > > >>                 addr =3D get_area(file, addr, len, pgoff, flags);
> > > >>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> > > >> +                  && !addr /* no hint */
> > > >>                    && IS_ALIGNED(len, PMD_SIZE)) {
> > > >>                 /* Ensures that larger anonymous mappings are THP =
aligned. */
> > > >>                 addr =3D thp_get_unmapped_area_vmflags(file, addr,=
 len,
> > > >>
> > > >> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> > > >> --
> > > >> 2.47.0.338.g60cca15819-goog
> > > >>
> > >

