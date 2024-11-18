Return-Path: <stable+bounces-93816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C79D16B9
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F521F2298B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9871BDA8C;
	Mon, 18 Nov 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqF6lU9o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA21BD4E2;
	Mon, 18 Nov 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949554; cv=none; b=QDG1sE/3Qx1HZUMAeGuIH2UuTaiwWETZziVBopUh2xkqdO51wtKclCIZ44wL6MKdD2ce2oGgdeSNiYYSYjkcpzVuBbqisMm+Iq9i1ltqJfAWUgiFZTAYcjcy4vgcTXpHyD9ubFxJt9lOvWxgCoxtv4771dP4aUOLoBJ/EKg9vSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949554; c=relaxed/simple;
	bh=j/2iHbWKdqr4IOdfrNOHbbHzH5o8YVW0WXIAyZt5DkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqtxx8liJYn6vobPtbQPKu9yb+b+jwztJd8INgJVNVcezTuDUpPv0mBirEXs6FoVoCS/8B/Vr7rZ6L2hp5e9RIoxdgfnUVpNd7UjVNqPzHxs2wKdmJ53E2uDpOqXMuO8RAYwV5ow5cxIQ63jEwKUn6+qp70k5ZnnKC3QZX8q7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqF6lU9o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso2677584a12.1;
        Mon, 18 Nov 2024 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949549; x=1732554349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAAcT/OPi/xTEIu4o5P9ht6vtv0FiG41VgA9+8+Ke2o=;
        b=KqF6lU9oZXcmwgqIpZnc1Z4+Vp1kfFAK6fwWGAFy7CHsOfjXVd3MvvoYpAdar/BEdJ
         4y8qgNE3P47TFmjEZPv7jAbrMyds5m1bWtVQQatTElWzri9MA+w4ojWSsV+lOS8e7ydA
         VtvkpkPmkaDgwM9VHaMCKP8ggTfcJGwLd1ByGH3M6jepfXUPkfIOEG97fBC/b4J/YFc/
         ZG30/quBj8vKBzCKucoW4Ejk6B3P4EMjU3YVzushBPmbHePvQIuqwB+AYS+6WEtxh7DO
         ueyb1arXyualxkcS03FGmI50e7QwJPRBRlLRMnJWI7Tv7yyrm5sNUA4qZlyi9dSYm3/a
         f1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949549; x=1732554349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAAcT/OPi/xTEIu4o5P9ht6vtv0FiG41VgA9+8+Ke2o=;
        b=aglXXPwM8E1fOkSvOwCHLWSb0423sEDvhkAIO111L/PGTZJiBlya8PiA5uP43FC7mE
         5fMIKjePBXz2ItRD0NRHbyDnh+MTbr5XQpic2nJE4WwaNMSE0fR98VRWEFG7Jk9UWLtR
         W+ljr79FbF13wIRSbCG5vEIoz1fvvVbVfwO20RlFXuHMkqUqebshVqbNt0lm3f/xv+aP
         YyIRrQGoeponOdG+IpMtC+e4heDa5TWk9rnSd0W7SZ47wpmIdw8reR+o1mFcF4XJS+ut
         IakkOec048Hha3UmOV4E21Grqz8nqooIVQG7EX96arIeTg8BsjTqEOsH1sL9lKGzPw+T
         y62g==
X-Forwarded-Encrypted: i=1; AJvYcCWYrYyv+8wFyFjQhgaCWulmPUeqJQE/ZNhXr0k5o9jZK4ukkKUPGHx4ooVW/s49FrC0GBujvo2X@vger.kernel.org, AJvYcCWk3+IJDkoTWKOf9UVKRnhCiJM6Oey6L6sCYkRQleHy4zGmPqiyEPVvAqpoAZmZ5vczijzq9es9U+AkgBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkqrQjIEheeKYc3JB8mi2bl8oDMTLxVRYiO1N366hVXGe34+e
	24r+3RgrnfdRBifnVhIydKb95HnH5ZxIu+qOSMsQwwQ5GAdphkpbqOqSJXyWAcNkVR7LSqisG5O
	OBr6CHq/6g0NcatANAiJPorfZFBA=
X-Google-Smtp-Source: AGHT+IFT1a0ahsVwQr/ntY5jBpOYCzQ75ZgH6KFnj0LUci0TFmKYQgqclum4n/5C7Xi5p6jFSBhTk8VTOpuyk1gKTg8=
X-Received: by 2002:a05:6402:35cd:b0:5cf:9517:e3e3 with SMTP id
 4fb4d7f45d1cf-5cf9517e555mr10913313a12.25.1731949547556; Mon, 18 Nov 2024
 09:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com>
 <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com> <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz>
In-Reply-To: <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 18 Nov 2024 09:05:36 -0800
Message-ID: <CAHbLzkq+CwMdGprYFa4jrzc3QSJ5eCDcEtp_EwWJ3G-aJmEx6A@mail.gmail.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kalesh Singh <kaleshsingh@google.com>, kernel-team@android.com, android-mm@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Shi <yang@os.amperecomputing.com>, 
	Rik van Riel <riel@surriel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 3:12=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/15/24 23:15, Yang Shi wrote:
> > On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh@googl=
e.com> wrote:
> >>
> >> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> >> boundaries") updated __get_unmapped_area() to align the start address
> >> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
> >>
> >> It does this by effectively looking up a region that is of size,
> >> request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
> >>
> >> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
> >> on 32 bit") opted out of this for 32bit due to regressions in mmap bas=
e
> >> randomization.
> >>
> >> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> >> mappings to PMD-aligned sizes") restricted this to only mmap sizes tha=
t
> >> are multiples of the PMD_SIZE due to reported regressions in some
> >> performance benchmarks -- which seemed mostly due to the reduced spati=
al
> >> locality of related mappings due to the forced PMD-alignment.
> >>
> >> Another unintended side effect has emerged: When a user specifies an m=
map
> >> hint address, the THP alignment logic modifies the behavior, potential=
ly
> >> ignoring the hint even if a sufficiently large gap exists at the reque=
sted
> >> hint location.
> >>
> >> Example Scenario:
> >>
> >> Consider the following simplified virtual address (VA) space:
> >>
> >>     ...
> >>
> >>     0x200000-0x400000 --- VMA A
> >>     0x400000-0x600000 --- Hole
> >>     0x600000-0x800000 --- VMA B
> >>
> >>     ...
> >>
> >> A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves diffe=
rently:
> >>
> >>   - Before THP alignment: The requested region (size 0x200000) fits in=
to
> >>     the gap at 0x400000, so the hint is respected.
> >>
> >>   - After alignment: The logic searches for a region of size
> >>     0x400000 (len + PMD_SIZE) starting at 0x400000.
> >>     This search fails due to the mapping at 0x600000 (VMA B), and the =
hint
> >>     is ignored, falling back to arch_get_unmapped_area[_topdown]().
>
> Hmm looks like the search is not done in the optimal way regardless of
> whether or not it ignores a hint - it should be able to find the hole, no=
?
>
> >> In general the hint is effectively ignored, if there is any
> >> existing mapping in the below range:
> >>
> >>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> >>
> >> This changes the semantics of mmap hint; from ""Respect the hint if a
> >> sufficiently large gap exists at the requested location" to "Respect t=
he
> >> hint only if an additional PMD-sized gap exists beyond the requested s=
ize".
> >>
> >> This has performance implications for allocators that allocate their h=
eap
> >> using mmap but try to keep it "as contiguous as possible" by using the
> >> end of the exisiting heap as the address hint. With the new behavior
> >> it's more likely to get a much less contiguous heap, adding extra
> >> fragmentation and performance overhead.
> >>
> >> To restore the expected behavior; don't use thp_get_unmapped_area_vmfl=
ags()
> >> when the user provided a hint address.
>
> Agreed, the hint should take precendence.
>
> > Thanks for fixing it. I agree we should respect the hint address. But
> > this patch actually just fixed anonymous mapping and the file mappings
> > which don't support thp_get_unmapped_area(). So I think you should
> > move the hint check to __thp_get_unmapped_area().
> >
> > And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
> > anonymous mappings to PMD-aligned sizes") should be moved to there too
> > IMHO.
>
> This was brought up, but I didn't want to do it as part of the stable fix=
 as
> that would change even situations that Rik's change didn't.
> If the mmap hint change is another stable hotfix, I wouldn't conflate it
> either. But we can try it for further development. But careful about just
> moving the code as-is, the file-based mappings are different than anonymo=
us
> memory and I believe file offsets matter:
>
> https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.cz/
>
> https://lore.kernel.org/all/5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.cz/

Did some research about the history of the code, I found this commit:

97d3d0f9a1cf ("mm/huge_memory.c: thp: fix conflict of above-47bit hint
address and PMD alignment"), it tried to fix "the function would not
try to allocate PMD-aligned area if *any* hint address specified."
It was for file mapping back then since anonymous mapping THP
alignment was not supported yet.

But it seems like this patch somehow tried to do something reverse. It
may not be correct either.

With Vlastimis's fix, we just try to make the address THP aligned for
anonymous mapping when the size is PMD aligned. So we don't need to
take into account the padding for anonymous mapping anymore.

So IIUC we should do something like:

@@ -1085,7 +1085,11 @@ static unsigned long
__thp_get_unmapped_area(struct file *filp,
        if (off_end <=3D off_align || (off_end - off_align) < size)
                return 0;

-       len_pad =3D len + size;
+       if (filp)
+               len_pad =3D len + size;
+       else
+               len_pad =3D len;
+
        if (len_pad < len || (off + len_pad) < off)
                return 0;

>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: Yang Shi <yang@os.amperecomputing.com>
> >> Cc: Rik van Riel <riel@surriel.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Suren Baghdasaryan <surenb@google.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Hans Boehm <hboehm@google.com>
> >> Cc: Lokesh Gidra <lokeshgidra@google.com>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP bound=
aries")
> >> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> >> ---
> >>  mm/mmap.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/mmap.c b/mm/mmap.c
> >> index 79d541f1502b..2f01f1a8e304 100644
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned lo=
ng addr, unsigned long len,
> >>         if (get_area) {
> >>                 addr =3D get_area(file, addr, len, pgoff, flags);
> >>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> >> +                  && !addr /* no hint */
> >>                    && IS_ALIGNED(len, PMD_SIZE)) {
> >>                 /* Ensures that larger anonymous mappings are THP alig=
ned. */
> >>                 addr =3D thp_get_unmapped_area_vmflags(file, addr, len=
,
> >>
> >> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> >> --
> >> 2.47.0.338.g60cca15819-goog
> >>
>

