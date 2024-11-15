Return-Path: <stable+bounces-93612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79C9CFA4C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FA72856A6
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6551917FF;
	Fri, 15 Nov 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3+APjVv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E033190470
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710683; cv=none; b=KcRGernuSZOs44mcIErprzvM5XyC+6ADsJt9rD27dZTFw8NRCY/g18ccHvplUtswhIC0om81Cg0TZYq2kgL61ukReFgbZSVgizl+rWvY8h5E5FLcGeErfHejdi6tfCdQAYR8AmV0dNxhzTG+kHJrwLlS7HZccpTiuMItHCZ3iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710683; c=relaxed/simple;
	bh=Natk0N7EmRdbqrIE9+0UaNnE56IygungoSA5ZQChHH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUxZamoJri/mSL9hmYW/sBK+uQRYyRwEcMnwn1r6ROKKPPUDNG7hfWl94A2FEuk3GbSKfsHw8ywU+9wkvdt8NCJkwzIqcfWopERBSnfd61mzArlHzx6wSg/YQqZGfIv+0t2SIeGXqivuGE91iaJi683VB/j6frI/XXjE6eEnbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3+APjVv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so3051a12.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731710679; x=1732315479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZwlo1UiJxfRk6Ay0RNijnjJNxXonIfP1NSZKq36oVo=;
        b=K3+APjVvaAbF/q76Zi09Ndwi3+nn9dCJz7ZxQq7N+IlRRdXJaOqPjqXMls8X/Zmk50
         243fYcQpPNat/8QQp+tkdZquAwxwZ20Uy7PZQ2Cj1kYvNNdZGuQmkCwApzkZM3AvT0Ns
         DORsfCrllwJblvHS8x3Q9IPwI3HasoylTh9HgGoJ1r6gOwOHsRFTbtFZ3d8+UH74b/H0
         cu+Bqv0fKHvCTXehUfWfezrq+kQC3FuADO+z+dr32wXKIYYxPiP1oool+i+ruEtK8MGz
         FKZqdcuGNdKK//knFK9wKBAdwcwGY3g8MCtlIrK0j77cfX1w/xKi3UgosB/diSFg2T7j
         6d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710679; x=1732315479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZwlo1UiJxfRk6Ay0RNijnjJNxXonIfP1NSZKq36oVo=;
        b=JTqzNw240sDB55Zaqk/mMbwrfyUG0pTnk1xmyXNTffp238ycOUtzxZYhcUI2sH7ZXX
         /8TGxjOOmrUB97rdbp1FeGROMNWpvAWawfT3nloI5z7DIzPpxKbVMqVDze/ZhVEXivyu
         KB7ddo2eggV8w71vxAdLWIX+llUQZ1fDNsr2gzSibH887O0qQnm6OD27Q3ZdBgGvGcJ7
         OPiP/KxlIoggJWzt2ML5YcP6r47R4fVjn97hCtZbIU5lgC2VxzDISIQcXVbo5XS9dRJK
         W2PXwdqc+tnsA6SMsI1qcmEc4hvusX2k6RV82c8dJtVzwBsT+BPlxbSbRnE5K6VUjOrf
         FN1g==
X-Forwarded-Encrypted: i=1; AJvYcCWzO4gNL/uHtSZiWe8sOOld08cLZMIB+C5siGoj+frY60xIiJjO6RBYSV3VzngmQ2HBVWmdhyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6eC0AyZfGr63r7T8TWVW2SFo1QxUyTTBNNLsLDoXgvBeIJMl
	HWLJ0nK4ust4/wLFRPekiTd33WbmIhQRT9pyAikEDNMiLJPEIGPU+oCAmOzLnW7ckgi0pCSNxEL
	rvC0jDu58IkwlTPk4wgqhiv7575gThrb3Zi3QqV0NfWazrg/JiQ==
X-Gm-Gg: ASbGncs38545C2BKLIVzUSAgDKr6V3JnqOOMlcy+8KubjBIGMBx4UClEjdgK/XyjGyn
	B24NLLdZGRiXsKE7xIZdY/1xHc3lvic1Ja8aFYi4ZKsVI9vGMsaSyL/MdZF5E0Q==
X-Google-Smtp-Source: AGHT+IHsjFblmGfPUCdxMHEnPyRjyNMUKVr2ov3wlP/7H5jpPAvTNsfV494AHMMACrwmQdw4IXpz14TyC92EHp/0GMo=
X-Received: by 2002:a05:6402:1a25:b0:5cf:7b8f:3ec0 with SMTP id
 4fb4d7f45d1cf-5cfa28a8ef0mr20067a12.0.1731710679310; Fri, 15 Nov 2024
 14:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com> <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
In-Reply-To: <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 15 Nov 2024 14:44:28 -0800
Message-ID: <CAC_TJvdvJ-hh88y+qakyUrkSYsFAh6oDdz1z3BCr+E_Bx_OtZA@mail.gmail.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
To: Yang Shi <shy828301@gmail.com>
Cc: kernel-team@android.com, android-mm@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Yang Shi <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:15=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh@google.=
com> wrote:
> >
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
> >     ...
> >
> >     0x200000-0x400000 --- VMA A
> >     0x400000-0x600000 --- Hole
> >     0x600000-0x800000 --- VMA B
> >
> >     ...
> >
> > A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves differ=
ently:
> >
> >   - Before THP alignment: The requested region (size 0x200000) fits int=
o
> >     the gap at 0x400000, so the hint is respected.
> >
> >   - After alignment: The logic searches for a region of size
> >     0x400000 (len + PMD_SIZE) starting at 0x400000.
> >     This search fails due to the mapping at 0x600000 (VMA B), and the h=
int
> >     is ignored, falling back to arch_get_unmapped_area[_topdown]().
> >
> > In general the hint is effectively ignored, if there is any
> > existing mapping in the below range:
> >
> >      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
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
> > when the user provided a hint address.
>
> Thanks for fixing it. I agree we should respect the hint address. But
> this patch actually just fixed anonymous mapping and the file mappings
> which don't support thp_get_unmapped_area(). So I think you should
> move the hint check to __thp_get_unmapped_area().
>
> And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
> anonymous mappings to PMD-aligned sizes") should be moved to there too
> IMHO.

Thanks Yang, you are right, to cover the file systems that are using
this for their .get_unmapped_area(). I'll move this to where the 64
bit checks are done when posting v2.

Thanks,
Kalesh

>
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
> > ---
> >  mm/mmap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 79d541f1502b..2f01f1a8e304 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned lon=
g addr, unsigned long len,
> >         if (get_area) {
> >                 addr =3D get_area(file, addr, len, pgoff, flags);
> >         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> > +                  && !addr /* no hint */
> >                    && IS_ALIGNED(len, PMD_SIZE)) {
> >                 /* Ensures that larger anonymous mappings are THP align=
ed. */
> >                 addr =3D thp_get_unmapped_area_vmflags(file, addr, len,
> >
> > base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> > --
> > 2.47.0.338.g60cca15819-goog
> >

