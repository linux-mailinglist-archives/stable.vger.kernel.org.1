Return-Path: <stable+bounces-93872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0F9D1AE0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 23:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9882D1F22C79
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 22:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B171E7C14;
	Mon, 18 Nov 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bfewpccw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2C1E570E
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967503; cv=none; b=gsi3JDvji+k7JafwgclBLO3sK2s0J61j1xlkRdHrp7zpyW9C8uFE8kLwJ4ChvsCWww0DGO90jPAugRmHTH0MkyckA6ZzXxD0ww9DFbK1o61O9RTB/aVS+w0QRMIYg8DD38645Necjo7x5IElFYpZWpWioNY3OT7P4bio32v/QyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967503; c=relaxed/simple;
	bh=3UstbKIjXyPSx8DgVqxeynoM89MqWOfVES9iwkkAaBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6m6fOMLljJVYfoSB/lsJOIhhjyjSsjCG/MiguzYrK5s2yWLvCmHpm8RtkiClrqDZSTeoz0ulYcB3CNyxmR3e9PV/1rZ2/ASJPvXFRLAfVwhfQeNbP04IEx5gwZuBOm3/qK4+juxomtrjoRFx69VPxANOwCFLjRmNqehG/EYDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bfewpccw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21238b669c5so47475ad.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731967501; x=1732572301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZpbDY5mWrDv6OnVwiqKQCXRFl0cdal4ZeypHNgk58U=;
        b=BfewpccwjDMnDhDzy0F6VO2DMec+MYGNAhDMuVCWOHSRb06RWrk6M77nARLclZiAyI
         6pkbTkBeBj/tOjjs+fDCCbE8Vn2dFJeCJ2csaunFO3ksyUP20Q/UYFn+KWUN5Lkpd5nm
         1icVli3lq+Q48Jryjw7pOWiLPw0e4LEj/8nmKIWSFbVJY9XUPWXal+Mfer3XyPIRnka0
         Jp9OZJO+fUJXtLTP991fGuSwMgyJCVqVP/4qjDhJ7mhLFMda10f94tcJ7NHEbcnjLQzc
         k15Jrzrw70t3iXHc1P7f3pm5xcKjQd4i0ktVL1zzzpNW/CWLJflINZiYq0U1/mfDW7dY
         yPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967501; x=1732572301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZpbDY5mWrDv6OnVwiqKQCXRFl0cdal4ZeypHNgk58U=;
        b=K8FpcZMqeCMJdFk2e8W+6FQRhFxO0Na9cSd9AaxFCoRNK05C4dgkISUe31qqOTZRbd
         L6WUXnlTo/fnz/VnQB6ZAsIWjeFEJ8pFgowixqUaS7q+VMqNoSUAjB0+PYtpA8qOgKyO
         ZTyxA9QnrO9bGlv2r2Gb7TkWGoSgek/g6sELM6BjlgbLIsgPF69e/l/1H9gbKc82Df43
         6gOwmABOgI40Lm+qznEy4fqufUeVwSsmGMYoyWyjr3HSsprdJmuoFgIWIEB6b2m+enDP
         RZG9vxFSPatcduF57NI5PpvkTfnW/lmRS1uAADDn+SJc+1k2imIRtV4ASoROqhJjHump
         0gyA==
X-Forwarded-Encrypted: i=1; AJvYcCUnzVyoNAitnXctR4gKK7nojs0ABtM3CJpz/6J8sCqGQzzXSMamdRwSozohx5YaiQpsvyYhH0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8h2gAyloEzPjGKkg0SHwJrBPtNhJZc3EfKj8O3JRE0YyyJVb+
	w7ktr918wGIPe/0Ai4qDBXmBzaGOepGVWgg446F0KPXx1irzRQ7NabjCb+Jqi0fRXap5tZSc+4P
	FHomUSnmJL2CMt61i0Rxe8rQN8taKmV3cXng9
X-Gm-Gg: ASbGncsVDPRDQvc86HxPo8fPkjwSF3OCQw5nOyXWaxKSMAD0kvxyqn2kD7IyrXOouTZ
	gqmXDek59JgoOOHcXXEp2h57cOrEhjQydhwivr+GbHFS47ef4L3AaEB/0pPbc
X-Google-Smtp-Source: AGHT+IHDU1IGm7lewxumKHELmTgTS6tIR08JzMLNeZLhHDULczS9ajfRvPk8jGcBzWoEeEzD8Ssf6fHi+EwybokLFFU=
X-Received: by 2002:a17:902:db11:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-2124fffa518mr437955ad.7.1731967500584; Mon, 18 Nov 2024
 14:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com>
 <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
 <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz> <CAHbLzkq+CwMdGprYFa4jrzc3QSJ5eCDcEtp_EwWJ3G-aJmEx6A@mail.gmail.com>
 <CAC_TJvdO7pqsmHNjvtTV3WsQvwCF9sa9PdmNE3rVEOSb20v--w@mail.gmail.com> <CAHbLzkqFfduLoWAiP3xwjMg5=JqEsKFMHAxh_ypmvGMBqAMbFg@mail.gmail.com>
In-Reply-To: <CAHbLzkqFfduLoWAiP3xwjMg5=JqEsKFMHAxh_ypmvGMBqAMbFg@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 18 Nov 2024 14:04:49 -0800
Message-ID: <CAC_TJvcNNcgO3z0DfJoSf3KSUXsLkL66NsAvft2vcJSCK2AgEw@mail.gmail.com>
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

On Mon, Nov 18, 2024 at 1:44=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Mon, Nov 18, 2024 at 9:52=E2=80=AFAM Kalesh Singh <kaleshsingh@google.=
com> wrote:
> >
> > On Mon, Nov 18, 2024 at 9:05=E2=80=AFAM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Sun, Nov 17, 2024 at 3:12=E2=80=AFAM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > > >
> > > > On 11/15/24 23:15, Yang Shi wrote:
> > > > > On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh=
@google.com> wrote:
> > > > >>
> > > > >> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > > > >> boundaries") updated __get_unmapped_area() to align the start ad=
dress
> > > > >> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy=
.
> > > > >>
> > > > >> It does this by effectively looking up a region that is of size,
> > > > >> request_size + PMD_SIZE, and aligning up the start to a PMD boun=
dary.
> > > > >>
> > > > >> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page ali=
gnment
> > > > >> on 32 bit") opted out of this for 32bit due to regressions in mm=
ap base
> > > > >> randomization.
> > > > >>
> > > > >> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> > > > >> mappings to PMD-aligned sizes") restricted this to only mmap siz=
es that
> > > > >> are multiples of the PMD_SIZE due to reported regressions in som=
e
> > > > >> performance benchmarks -- which seemed mostly due to the reduced=
 spatial
> > > > >> locality of related mappings due to the forced PMD-alignment.
> > > > >>
> > > > >> Another unintended side effect has emerged: When a user specifie=
s an mmap
> > > > >> hint address, the THP alignment logic modifies the behavior, pot=
entially
> > > > >> ignoring the hint even if a sufficiently large gap exists at the=
 requested
> > > > >> hint location.
> > > > >>
> > > > >> Example Scenario:
> > > > >>
> > > > >> Consider the following simplified virtual address (VA) space:
> > > > >>
> > > > >>     ...
> > > > >>
> > > > >>     0x200000-0x400000 --- VMA A
> > > > >>     0x400000-0x600000 --- Hole
> > > > >>     0x600000-0x800000 --- VMA B
> > > > >>
> > > > >>     ...
> > > > >>
> > > > >> A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves=
 differently:
> > > > >>
> > > > >>   - Before THP alignment: The requested region (size 0x200000) f=
its into
> > > > >>     the gap at 0x400000, so the hint is respected.
> > > > >>
> > > > >>   - After alignment: The logic searches for a region of size
> > > > >>     0x400000 (len + PMD_SIZE) starting at 0x400000.
> > > > >>     This search fails due to the mapping at 0x600000 (VMA B), an=
d the hint
> > > > >>     is ignored, falling back to arch_get_unmapped_area[_topdown]=
().
> > > >
> >
> > Hi all, Thanks for the reviews.
> >
> > > > Hmm looks like the search is not done in the optimal way regardless=
 of
> > > > whether or not it ignores a hint - it should be able to find the ho=
le, no?
> >
> > It's not able to find the hole in the example case because the size we
> > are looking for is now
> > (requested size + padding len) which is larger than the hole we have
> > at the hint address.
> >
> > > >
> > > > >> In general the hint is effectively ignored, if there is any
> > > > >> existing mapping in the below range:
> > > > >>
> > > > >>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> > > > >>
> > > > >> This changes the semantics of mmap hint; from ""Respect the hint=
 if a
> > > > >> sufficiently large gap exists at the requested location" to "Res=
pect the
> > > > >> hint only if an additional PMD-sized gap exists beyond the reque=
sted size".
> > > > >>
> > > > >> This has performance implications for allocators that allocate t=
heir heap
> > > > >> using mmap but try to keep it "as contiguous as possible" by usi=
ng the
> > > > >> end of the exisiting heap as the address hint. With the new beha=
vior
> > > > >> it's more likely to get a much less contiguous heap, adding extr=
a
> > > > >> fragmentation and performance overhead.
> > > > >>
> > > > >> To restore the expected behavior; don't use thp_get_unmapped_are=
a_vmflags()
> > > > >> when the user provided a hint address.
> > > >
> > > > Agreed, the hint should take precendence.
> > > >
> > > > > Thanks for fixing it. I agree we should respect the hint address.=
 But
> > > > > this patch actually just fixed anonymous mapping and the file map=
pings
> > > > > which don't support thp_get_unmapped_area(). So I think you shoul=
d
> > > > > move the hint check to __thp_get_unmapped_area().
> > > > >
> > > > > And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment =
of
> > > > > anonymous mappings to PMD-aligned sizes") should be moved to ther=
e too
> > > > > IMHO.
> > > >
> > > > This was brought up, but I didn't want to do it as part of the stab=
le fix as
> > > > that would change even situations that Rik's change didn't.
> > > > If the mmap hint change is another stable hotfix, I wouldn't confla=
te it
> > > > either. But we can try it for further development. But careful abou=
t just
> > > > moving the code as-is, the file-based mappings are different than a=
nonymous
> > > > memory and I believe file offsets matter:
> > > >
> > > > https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@su=
se.cz/
> > > >
> > > > https://lore.kernel.org/all/5f7a49e8-0416-4648-a704-a7a67e8cd894@su=
se.cz/
> > >
> >
> > I see, so I think we should keep the check here to address the
> > immediate regression for anonymous mappings.
> >
> > I believe what we would need to address this longer term is to have
> > vma_iter_lowest() [1] vma_iter_highest() [2] take into account the
> > alignment when doing the search. That way we don't need to inflate the
> > search size to facilitate the manual alignment after the fact. I
> > haven't looked too too deeply into this, maybe Liam has some ideas
> > about that?
> >
> > [1] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L420
> >
> > [2] https://github.com/torvalds/linux/blob/v6.12-rc7/mm/vma.h#L426
> >
> > > Did some research about the history of the code, I found this commit:
> > >
> > > 97d3d0f9a1cf ("mm/huge_memory.c: thp: fix conflict of above-47bit hin=
t
> > > address and PMD alignment"), it tried to fix "the function would not
> > > try to allocate PMD-aligned area if *any* hint address specified."
> > > It was for file mapping back then since anonymous mapping THP
> > > alignment was not supported yet.
> > >
> > > But it seems like this patch somehow tried to do something reverse. I=
t
> > > may not be correct either.
> > >
> >
> > IIUC Kirill's patch is doing the right thing (mostly), i.e. it will
> > return the hint address (without any rounding to PMD alignment). The
> > case it doesn't handle is what I mentioned above, where we aren't able
> > to find the hole at the hint address in the first place because the
> > hole is smaller than (size + padding len)
>
> Yes. But my point is your fix (just simply skip PMD alignment when
> hint is specified) actually broke what Kirill fixed IIUC.

Hi Yang,

It's true the PMD alignment is skipped in that case for the anon
mappings. Though I believe that's still what we want to have here
initially as we shouldn't regress the hint behaviour.

I've posted the v2 here:
https://lore.kernel.org/lkml/20241118214650.3667577-1-kaleshsingh@google.co=
m/

>
> >
> > > With Vlastimis's fix, we just try to make the address THP aligned for
> > > anonymous mapping when the size is PMD aligned. So we don't need to
> > > take into account the padding for anonymous mapping anymore.
> > >
> >
> > We still need to have padding length because PMD alignment of the size
> > doesn't mean that the start address returned by the search will be PMD
> > aligned. Inherently those are only PAGE aligned.
>
> Yes, you are right, I overlooked this. I think we can do this in two
> passes. Use len w/o padding in the first pass. If the returned address
> equals the hint or it is already PMD aligned, just return it.
> Otherwise it means there is no hole with suitable size and alignment.
> In the second pass, we redo it with padding. Just off the top of my
> head, others may have better ideas.
>

You are right, it's one way we can do it. Though, I am concerned that
the 2 passes will add overhead on mmap() performance. One idea I have
is to move the alignment handling lower down to
vma_iter_highest()/lowest(). Interested to hear your thoughts on that.
We can do this in a follow up patch, which should fix file mappings as
well.

Thanks,
Kalesh

> >
> > Thanks,
> > Kalesh
> >
> > > So IIUC we should do something like:
> > >
> > > @@ -1085,7 +1085,11 @@ static unsigned long
> > > __thp_get_unmapped_area(struct file *filp,
> > >         if (off_end <=3D off_align || (off_end - off_align) < size)
> > >                 return 0;
> > >
> > > -       len_pad =3D len + size;
> > > +       if (filp)
> > > +               len_pad =3D len + size;
> > > +       else
> > > +               len_pad =3D len;
> > > +
> > >         if (len_pad < len || (off + len_pad) < off)
> > >                 return 0;
> > >
> > > >
> > > > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >> Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > >> Cc: Yang Shi <yang@os.amperecomputing.com>
> > > > >> Cc: Rik van Riel <riel@surriel.com>
> > > > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > > >> Cc: Suren Baghdasaryan <surenb@google.com>
> > > > >> Cc: Minchan Kim <minchan@kernel.org>
> > > > >> Cc: Hans Boehm <hboehm@google.com>
> > > > >> Cc: Lokesh Gidra <lokeshgidra@google.com>
> > > > >> Cc: <stable@vger.kernel.org>
> > > > >> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP=
 boundaries")
> > > > >> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > >
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > >
> > > > >> ---
> > > > >>  mm/mmap.c | 1 +
> > > > >>  1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/mm/mmap.c b/mm/mmap.c
> > > > >> index 79d541f1502b..2f01f1a8e304 100644
> > > > >> --- a/mm/mmap.c
> > > > >> +++ b/mm/mmap.c
> > > > >> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsig=
ned long addr, unsigned long len,
> > > > >>         if (get_area) {
> > > > >>                 addr =3D get_area(file, addr, len, pgoff, flags)=
;
> > > > >>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> > > > >> +                  && !addr /* no hint */
> > > > >>                    && IS_ALIGNED(len, PMD_SIZE)) {
> > > > >>                 /* Ensures that larger anonymous mappings are TH=
P aligned. */
> > > > >>                 addr =3D thp_get_unmapped_area_vmflags(file, add=
r, len,
> > > > >>
> > > > >> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> > > > >> --
> > > > >> 2.47.0.338.g60cca15819-goog
> > > > >>
> > > >

