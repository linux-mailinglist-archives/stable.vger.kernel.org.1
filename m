Return-Path: <stable+bounces-94453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C19D41DD
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D561F21C8B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1116DEB5;
	Wed, 20 Nov 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2VfK5CT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935B1F931
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126306; cv=none; b=REiYjq7/xS9IJxHI+0GpjuOqcmckifdd4rwDPg05MH0rTBYyQJwYl+GXOQRKGPcLeO69fLXRQ08hMiu2XMtyGeV8sW9e8NP2su5qgaZGgzGQtfQ+UqysvrPeuKzmvUcX/tYhzwsSbepH1SG+LKel1zC2+zfTLje2SFdJaaM/DOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126306; c=relaxed/simple;
	bh=8P48bj2Bzu622FHvV2p7sLvnsvWJa25/f5NTLjyKJKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEwFh8KIrwTJ8wI9Z0ndrNB51GHnhnlplZeYrwf3MMzaGHMsT2qb2pFKmH9SOG3rStSwlsPYcGZzRAIjCdRYR46TY47JbJ9zjlhPIkHrYYvTlcnf48b5A5dPysvzTkVSm7X8gCunTpuZMLgsy8KW6cmrA+2SANYmI9L9KDdrjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2VfK5CT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211f1a46f7fso7385ad.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732126303; x=1732731103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZEhfbz13LmscM92GU4CFvmcXnMTxENjlmy1AcrMZv0=;
        b=q2VfK5CTn3pRg0dPlG1vi8+zksb7LKzUBq1xrgmeXY8G4yOm17NwnhHIVoJj71GUwg
         n+oNp5qGSu/tUk2yG/iPecskp0pDAgrNi56lxlCTImgm8jmrSg8cO21DqkmPdHyZCyX8
         hlW8Lnq4ILuY5e50gTKNJTRx7XbPFv8ReCy1otN3jiU8E4uswRRCSReoOG0GvaiNrcSg
         S/tzR4mZ42OJa7TOW4Uaj9A17fgiuZaOehXhDxxCyCig6ETcWKJVgzW5sXaxzLuRWRXh
         P/ikff5kUYA+T2eTPPKrdxv60M9VBN3W7bRQctMMwlje4gI3ZbrlYvfR0z885Sk9pT+0
         cd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126303; x=1732731103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZEhfbz13LmscM92GU4CFvmcXnMTxENjlmy1AcrMZv0=;
        b=TdinTxSkUIAv9IEXeXlv6tZssfl1B0XDgi5Daw9c0w+aqfOpG3o5E7VhCXIvY88R+J
         snfQpigSUVD1VZFT8QCQWc0lTmVNEV9tZSnpVB3G8cLZO7UHWgB/ZPGZnxePwxFLvJMj
         S47AlbTkmdKMYGu5dlvXSzQo+qd3ybowvpql2aQl6+AGMW6FKHVbmwn0Nz9dFA9IvyD7
         /r6TreSQT6mz2Nr11r0rsNiS0xuRAjhNKBbGtCQ8DRxSOzuiVEGgJuiRpjwdoTxnqB97
         dgkNViyAhqAtLQkxuix+Oft7yJx/dnmiphzHRMpotqaDq0yWf9k9QczDuOufdAOdzqDK
         QAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdE5Fkl/MA6jORTHITH+kYqWZMwfj/v92Lwsu1LyOjwJzb9pP+18n7z9TUX0mHCI6Uj42qj4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMm9iD0pftrOcsLWhsYIDlvn9GORfzm+IO0pTwtOC7XIJrfozs
	46AO+d1Prc7IR3YYEzDuZNpkjh78RNLEZ+0QqEzaFmfhoLAv6o7r7sglRv9CmaTJu2kiFQeDNTN
	cMN2UPXV4F3Nwkp9CoXqDTCkrznwnlcWhGCUo
X-Gm-Gg: ASbGnctXAyMN4WGxDBuRVZTs+F0glwTKe11DM774iLhMqUyrBV9zqRUWnu3IuCDU4X9
	j4Q7VsLq6DdjqRq4/LTuIf+Q+TDxuwgHQ5QjZFhXNXq/ciDdOkxYBvDARXS69ETfzGQ==
X-Google-Smtp-Source: AGHT+IHdYabz3C+xJtFwEDGe82K06BCCU9X9KG7kGpGxQnakHaUJ1yK6rjgOVQR4DkLL2l3XL/XAWN28j9hdnZXlfmg=
X-Received: by 2002:a17:902:dac3:b0:1fc:60f2:a089 with SMTP id
 d9443c01a7336-2126e159d11mr2604655ad.17.1732126302690; Wed, 20 Nov 2024
 10:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118214650.3667577-1-kaleshsingh@google.com> <db6e1966-3824-45cd-8cae-740348780002@redhat.com>
In-Reply-To: <db6e1966-3824-45cd-8cae-740348780002@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 20 Nov 2024 10:11:31 -0800
Message-ID: <CAC_TJvfK8Rtf2tAtG-1QMK_SCjUAQeGZWkCR-aA1s69Pae7vEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Respect mmap hint address when aligning for THP
To: David Hildenbrand <david@redhat.com>
Cc: kernel-team@android.com, android-mm@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Yang Shi <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 6:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.11.24 22:46, Kalesh Singh wrote:
> > Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > boundaries") updated __get_unmapped_area() to align the start address
> > for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
> >
> > It does this by effectively looking up a region that is of size,
> > request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
> >
> > Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
> > on 32 bit") opted out of this for 32bit due to regressions in mmap base
> > randomization.
> >
> > Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> > mappings to PMD-aligned sizes") restricted this to only mmap sizes that
> > are multiples of the PMD_SIZE due to reported regressions in some
> > performance benchmarks -- which seemed mostly due to the reduced spatia=
l
> > locality of related mappings due to the forced PMD-alignment.
> >
> > Another unintended side effect has emerged: When a user specifies an mm=
ap
> > hint address, the THP alignment logic modifies the behavior, potentiall=
y
> > ignoring the hint even if a sufficiently large gap exists at the reques=
ted
> > hint location.
> >
> > Example Scenario:
> >
> > Consider the following simplified virtual address (VA) space:
> >
> >      ...
> >
> >      0x200000-0x400000 --- VMA A
> >      0x400000-0x600000 --- Hole
> >      0x600000-0x800000 --- VMA B
> >
> >      ...
> >
> > A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves differ=
ently:
> >
> >    - Before THP alignment: The requested region (size 0x200000) fits in=
to
> >      the gap at 0x400000, so the hint is respected.
> >
> >    - After alignment: The logic searches for a region of size
> >      0x400000 (len + PMD_SIZE) starting at 0x400000.
> >      This search fails due to the mapping at 0x600000 (VMA B), and the =
hint
> >      is ignored, falling back to arch_get_unmapped_area[_topdown]().
> >
> > In general the hint is effectively ignored, if there is any
> > existing mapping in the below range:
> >
> >       [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> >
> > This changes the semantics of mmap hint; from ""Respect the hint if a
> > sufficiently large gap exists at the requested location" to "Respect th=
e
> > hint only if an additional PMD-sized gap exists beyond the requested si=
ze".
> >
> > This has performance implications for allocators that allocate their he=
ap
> > using mmap but try to keep it "as contiguous as possible" by using the
> > end of the exisiting heap as the address hint. With the new behavior
> > it's more likely to get a much less contiguous heap, adding extra
> > fragmentation and performance overhead.
> >
> > To restore the expected behavior; don't use thp_get_unmapped_area_vmfla=
gs()
> > when the user provided a hint address, for anonymous mappings.
> >
> > Note: As, Yang Shi, pointed out: the issue still remains for filesystem=
s
> > which are using thp_get_unmapped_area() for their get_unmapped_area() o=
p.
> > It is unclear what worklaods will regress for if we ignore THP alignmen=
t
> > when the hint address is provided for such file backed mappings -- so t=
his
> > fix will be handled separately.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Yang Shi <yang@os.amperecomputing.com>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Hans Boehm <hboehm@google.com>
> > Cc: Lokesh Gidra <lokeshgidra@google.com>
> > Cc: <stable@vger.kernel.org>
> > Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP bounda=
ries")
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Rik van Riel <riel@surriel.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
>
> LGTM. Hopefully that's the end of this story :)
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks David.

Andrew, when you have a chance, could you take this for mm fixes please.

Thanks,
Kalesh

>
> --
> Cheers,
>
> David / dhildenb
>

