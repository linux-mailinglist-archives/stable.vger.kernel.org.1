Return-Path: <stable+bounces-92137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58E9C40E7
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F627281A22
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7191A00E7;
	Mon, 11 Nov 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkXO30BJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2C15A85A
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335328; cv=none; b=EikRkErfSRYwZTgPh+y6crWP9uQ3F0zSa3nIivmrM1kgfZi/HFOiJXHl0CcKXwwY8NJIdxkxYiknl2DSUYYtg3bp++hVp3CgZ75dC/6q1J2TB1qhxptv56mw+tYuHRnFiVxgbH9bDJ1p5Zo7rvfJbAvHV7Ig7lfm4NrSUV86I8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335328; c=relaxed/simple;
	bh=Ochg1RWULUD3izrGJxJrdoR/FpoS0WFHCHbalTgI8d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWbq9SLEfDG+8BXkra3hEmZlEzPNSdnDKI8Iy+jqddZAaUusz4mwl2beeGycee/Es0o6N+CJtPQO/G3aWVUUovUMCp14jdS3ljN5tgiRE9QSfePHeyy/WbW/eMP4h6daMdyrCsDz8nf+1NjczfExIbS5LRp+j7CQWjFmm8svY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkXO30BJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so38319327b3.1
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 06:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731335326; x=1731940126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTMwMwx74ZNUjjbl+IHSZpLW1ImjYvv0M8qHg/IUW+M=;
        b=QkXO30BJvtCaOh83QzZQTe1yc6hI61wopKbMqhtPstQy2vQVWEXbHrWPlm02oMmfIG
         ZF5kWa2bm1LQ6dyGfvmFZ05aWcT41jwJA6iDyRQsY0X3fbm7ISDj+0fsVPQ6QVJPLyOy
         pgas1dguW6+s1sGH9TncdSX7Tt018JKggekhozVFuryylIa4veqQ+Zx2mexUr+mgxoEi
         nd8BPTe345K9YymzMxsiuDyt7h7+LAde+gGPDzwbxkQQPP88JDwIwyWe050ceDoT+cAe
         7MOr3YEqPhEmMJHU6UxUO86O+ZF3Z4qwFxnNjttFpe66L7DG/yeHeGrrV2TIiI5jzm/j
         0dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335326; x=1731940126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTMwMwx74ZNUjjbl+IHSZpLW1ImjYvv0M8qHg/IUW+M=;
        b=aCfDTmk1B1Y/9QF+a4ZsWT3Yr5PviLlj47J3Y/fFwgTd9bcjq0ZE6knruWxAMExBDs
         RQVdspGsvctLx6sGXZOYyTlYMoYyi48gDlTNAiwT0f4yadToL5Y0FC+BElLLklhE4mYd
         7+4+uT5IOFqyZqT1ZcsauVIiOgRuT9FDdRqa4uOgs00gH/ViLn3NsMjabt2poVFgCBRM
         KoWLWgvbSSIGNlfx1Fck3KF53DwcXwVBQ80ClmytabT9oVVPr8MhSUxUe4o9qIcH+XcS
         SwuOrQJpO8QZQ7qqnBbVAfVpJ+to7O9jo6Ex+6T7OD4A8GXL6jIwsf7HGjxphTSFotLx
         QjEg==
X-Forwarded-Encrypted: i=1; AJvYcCUfbZMJqk7R/CoMq5EAYdt7hBMhP8/upice19BRsUMtLIt3vmA+pDoUtbA7Kd8tnfjG3KxD/W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VwnH8tOL3+t/HQVSBLkiZP7D5u3Cu8fmxtfGb6ulrA/wuutq
	dvENJM046ddTzh39XR7u47Jxxhqn3FdfsZAnYKSLT21R0p4mVl5FaKuM70q6JuW3cMuwS15IR+l
	pAMlOBrFoIkr66JMduInDwbxmgOU=
X-Google-Smtp-Source: AGHT+IE8xROkVGciyN1boA9K5AnO0Tbm7acf/oCXyXs2y8tb44Th2b+L5kBmSx7q8KZTclcc6JEy6uuk7GmGYIo4ywU=
X-Received: by 2002:a05:690c:d83:b0:6e7:f98e:12dc with SMTP id
 00721157ae682-6eaddd870c5mr116427167b3.9.1731335325923; Mon, 11 Nov 2024
 06:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
In-Reply-To: <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 11 Nov 2024 22:28:09 +0800
Message-ID: <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 6:33=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.11.24 15:17, Yafang Shao wrote:
> > When testing large folio support with XFS on our servers, we observed t=
hat
> > only a few large folios are mapped when reading large files via mmap.
> > After a thorough analysis, I identified it was caused by the
> > `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
> > parameter is set to 128KB. After I tune it to 2MB, the large folio can
> > work as expected. However, I believe the large folio behavior should no=
t be
> > dependent on the value of read_ahead_kb. It would be more robust if the
> > kernel can automatically adopt to it.
>
> Now I am extremely confused.
>
> Documentation/ABI/stable/sysfs-block:
>
> "[RW] Maximum number of kilobytes to read-ahead for filesystems on this
> block device."
>
>
> So, with your patch, will we also be changing the readahead size to
> exceed that, or simply allocate larger folios and not exceeding the
> readahead size (e.g., leaving them partially non-filled)?

Exceeding the readahead size for the MADV_HUGEPAGE case is
straightforward; this is what the current patch accomplishes.

>
> If you're also changing the readahead behavior to exceed the
> configuration parameter it would sound to me like "I am pushing the
> brake pedal and my care brakes; fix the brakes to adopt whether to brake
> automatically" :)
>
> Likely I am missing something here, and how the read_ahead_kb parameter
> is used after your patch.

The read_ahead_kb parameter continues to function for
non-MADV_HUGEPAGE scenarios, whereas special handling is required for
the MADV_HUGEPAGE case. It appears that we ought to update the
Documentation/ABI/stable/sysfs-block to reflect the changes related to
large folios, correct?

>
>
> >
> > With /sys/block/*/queue/read_ahead_kb set to 128KB and performing a
> > sequential read on a 1GB file using MADV_HUGEPAGE, the differences in
> > /proc/meminfo are as follows:
> >
> > - before this patch
> >    FileHugePages:     18432 kB
> >    FilePmdMapped:      4096 kB
> >
> > - after this patch
> >    FileHugePages:   1067008 kB
> >    FilePmdMapped:   1048576 kB
> >
> > This shows that after applying the patch, the entire 1GB file is mapped=
 to
> > huge pages. The stable list is CCed, as without this patch, large folio=
s
> > don=E2=80=99t function optimally in the readahead path.
>  >> It's worth noting that if read_ahead_kb is set to a larger value
> that isn't
> > aligned with huge page sizes (e.g., 4MB + 128KB), it may still fail to =
map
> > to hugepages.
> >
> > Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings=
")
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: stable@vger.kernel.org
> >
> > ---
> >   mm/readahead.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > Changes:
> > v1->v2:
> > - Drop the align (Matthew)
> > - Improve commit log (Andrew)
> >
> > RFC->v1: https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.s=
hao@gmail.com/
> > - Simplify the code as suggested by Matthew
> >
> > RFC: https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao=
@gmail.com/
> >
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 3dc6c7a128dd..9b8a48e736c6 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -385,6 +385,8 @@ static unsigned long get_next_ra_size(struct file_r=
a_state *ra,
> >               return 4 * cur;
> >       if (cur <=3D max / 2)
> >               return 2 * cur;
> > +     if (cur > max)
> > +             return cur;
> >       return max;
>
> Maybe something like
>
> return max_t(unsigned long, cur, max);
>
> might be more readable (likely "max()" cannot be used because of the
> local variable name "max" ...).
>
>
> ... but it's rather weird having a "max" and then returning something
> larger than the "max" ... especially with code like

Indeed, that could lead to confusion ;)

>
> "ra->size =3D get_next_ra_size(ra, max_pages);"
>
>
> Maybe we can improve that by renaming "max_pages" / "max" to what it
> actually is supposed to be (which I haven't quite understood yet).

Perhaps a more straightforward solution would be to implement it
directly at the callsite, as demonstrated below?

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..187efae95b02 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *rac=
tl,
                        1UL << order);
        if (index =3D=3D expected) {
                ra->start +=3D ra->size;
-               ra->size =3D get_next_ra_size(ra, max_pages);
+               /*
+                * Allow the actual size to exceed the readahead window for=
 a
+                * large folio.
+                */
+               ra->size =3D get_next_ra_size(ra, max(max_pages, ra->size))=
;
                ra->async_size =3D ra->size;
                goto readit;
        }


--
Regards
Yafang

