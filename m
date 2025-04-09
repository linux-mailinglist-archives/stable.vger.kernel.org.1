Return-Path: <stable+bounces-132013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1BA83415
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 00:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB62144762E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4A218EBE;
	Wed,  9 Apr 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oX8RoJDd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2421B1AA
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237932; cv=none; b=c/N4Y1wAaziExcpEy6z/HgcQw1AnXn0RWOOCp9StrcEXWeCxaqg4tVQ0YNMvEDr1fqKBPR/NKRofmC3FWKF/qn7bjDqxTo0hQbSCR65j0soadv5AqgRE3C3sfxxDOLfqO50CkmxvSZULnOqLmN0duVMZT60dxOnOfysv2/HYLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237932; c=relaxed/simple;
	bh=dUcFiEevDd2uXsRnng0N8jTZMVmnH+f0c9jIaQy4Wmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hST+H0l8sK73gzkHAK6YCahYHAuMG/n5Cl+/aOP0IpP91vAabThMeD5q35ym1aOc9sHEfe2Ul6Zj+W3pYbTKksp1kc39kyM7I0oZkFwqa+Pl2rwiKVLufuMopihRPdu8pJaoJVkDSrscXle0Yh/NF9sMbpvh0NRjYskJKcPhxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oX8RoJDd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47666573242so168611cf.0
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744237929; x=1744842729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRpYe9kZljsIsb6Q8443FGoIbulqLc9TInapjHrYYxI=;
        b=oX8RoJDdgk3XdfuDpblhJzdI202NVsxsVtfbNSWBtpM7oDApZwPyCROAOk0ZL/GLQZ
         B7Dh6saOIl/HKBD6IDsM1Xin9fG38F9QWhhSublipgWHFQTxpZRceJQJklynnHS2G8iI
         aVexkLILRe5DHES3rEHVuFelpT2px7+F/Z01zFSvp7MbyT20haMcOyLz3gQsRziFe8vE
         5Z4BOe1bwxUPH3ktiStZ9YnbajimnIyj/DINWSJiPkypclv2XZsVL7el5OcWjYztvZPy
         GNqw4cjFtP79iAEQf94S9SqrqBdgRo67ZVykuiwANhMKsb6O3N70JtqMap3xZ2yznOBl
         GzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237929; x=1744842729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRpYe9kZljsIsb6Q8443FGoIbulqLc9TInapjHrYYxI=;
        b=en3nb75MD+yoDq1mu0SxTYMQpeVMiiixpmdHrbybDA0vUuQ5Nc8LUlAL46ZdpDIbLj
         +8cxKUSnm7bCsUgfrdOwbVwiomd4Q4lV4+6JrqCrJQco2Zofgm0AGu9nj29G+jTAvkQX
         iNF/XScl1hN8GrGzAw6D1MIFW0Rry3eINda1NfKmJRTHAULn9UIfkl2Y+ACR4bm69CaE
         K3WO8TeGkihGGUeuRHe3r71coktUj7iqMkAc80IGAERG+fYfTDQQdEvq4YwjKpVGpgDu
         +b9nm+TZ/VfaXYfHv793xXwufX4jBB9VaPdnub9mYAb3uFn5sgZFDDJznAVeqfhkTxcm
         z2MA==
X-Forwarded-Encrypted: i=1; AJvYcCU7xAJZLOQWcACmW+IbQ01b8oghvLDrkADK5SC3Gnn0pSvVqG0S1hFR8wbHvmvgDSh42MaZp68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvUfaKUIJ1iLWkCPk+9kSfRUQHGTpARh8AjmjG54nocjovVL3
	BZnasO1cRP+mPJYf0IAKx2Yb7+FgD7HynmLI9KpGSYihQ7DRPCRYaCB90T0ScY/CMrTygRgGBMq
	z6c10Ir43EKl4VFY4y5nzbmhR8GKURLAA92loPthMB7o9j77P/RNFo0M=
X-Gm-Gg: ASbGncscsghteFXYB0AVj1SeEtQv0NxlSZSEqOqRuuc5L30vPkdK/1ALfyQ+36uB/VX
	gZlVl1kf2gnfB8xAGMNrEPd2APThQHztaiVBB0tViLMADUNPY3P+R/zPCukZSWIKLEhBY1okm6B
	Aql2212ye7FG24v4vsqsHE
X-Google-Smtp-Source: AGHT+IEWnzv75rMRVNfzSPLGWPXCHotFgM7AwSEOWuPCUVWA0mtZQClB0wAQ6dnxCPDDtVUQdrQrQyXYqp2BtETmx7Q=
X-Received: by 2002:a05:622a:50:b0:472:538:b795 with SMTP id
 d75a77b69052e-4796c96779dmr866331cf.22.1744237928663; Wed, 09 Apr 2025
 15:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409211241.70C37C4CEE2@smtp.kernel.org> <hzrrdhrvtabiz7g4bvj53lg64f7th5d7ravduisnaqmwmmqubr@f52xy2uq6222>
In-Reply-To: <hzrrdhrvtabiz7g4bvj53lg64f7th5d7ravduisnaqmwmmqubr@f52xy2uq6222>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Apr 2025 15:31:57 -0700
X-Gm-Features: ATxdqUFn5hZFVlhVlz0m44XW9D_8EYWgqwFtOyNZawf41CSs-dLCKnhfqgSInYo
Message-ID: <CAJuCfpGe3cY3yYGB03kTGJR-Dyh02w8spDDRkckjdP+qSKtdXg@mail.gmail.com>
Subject: Re: + alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.patch
 added to mm-hotfixes-unstable branch
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	stable@vger.kernel.org, janghyuck.kim@samsung.com, tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 3:10=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Apr 09, 2025 at 02:12:40PM -0700, Andrew Morton wrote:
> >
> > The patch titled
> >      Subject: alloc_tag: handle incomplete bulk allocations in vm_modul=
e_tags_populate
> > has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
> >      alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_pop=
ulate.patch
> >
> > This patch will shortly appear at
> >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tr=
ee/patches/alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_p=
opulate.patch
> >
> > This patch will later appear in the mm-hotfixes-unstable branch at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >
> > Before you just go and hit "reply", please:
> >    a) Consider who else should be cc'ed
> >    b) Prefer to cc a suitable mailing list as well
> >    c) Ideally: find the original patch on the mailing list and do a
> >       reply-to-all to that, adding suitable additional cc's
> >
> > *** Remember to use Documentation/process/submit-checklist.rst when tes=
ting your code ***
> >
> > The -mm tree is included into linux-next via the mm-everything
> > branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > and is updated there every 2-3 working days
>
> I don't think we want to rush this patch, given that it's not fixing an
> actual crash.

It's not designed to fix a crash. The issue is that whenever tags
require more than one page and CONFIG_PAGE_OWNER is enabled, memory
allocation profiling gets disabled. I missed the fact that
alloc_pages_bulk_node() can return less number of pages than requested
and this patch fixes that.

>
> I'm currently chasing a crash (null ptr deref, slab obj extension vector
> seems to not be getting allocated correctly) in 6.15-rc1, so I'm
> wondering what's missing in our test coverage.
>
> > ------------------------------------------------------
> > From: "T.J. Mercier" <tjmercier@google.com>
> > Subject: alloc_tag: handle incomplete bulk allocations in vm_module_tag=
s_populate
> > Date: Wed, 9 Apr 2025 19:54:47 +0000
> >
> > alloc_pages_bulk_node may partially succeed and allocate fewer than the
> > requested nr_pages.  There are several conditions under which this can
> > occur, but we have encountered the case where CONFIG_PAGE_OWNER is enab=
led
> > causing all bulk allocations to always fallback to single page allocati=
ons
> > due to commit 187ad460b841 ("mm/page_alloc: avoid page allocator recurs=
ion
> > with pagesets.lock held").
> >
> > Currently vm_module_tags_populate immediately fails when
> > alloc_pages_bulk_node returns fewer than the requested number of pages.
> > This patch causes vm_module_tags_populate to retry bulk allocations for
> > the remaining memory instead.
> >
> > Link: https://lkml.kernel.org/r/20250409195448.3697351-1-tjmercier@goog=
le.com
> > Fixes: 187ad460b841 ("mm/page_alloc: avoid page allocator recursion wit=
h pagesets.lock held")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Reported-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  lib/alloc_tag.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > --- a/lib/alloc_tag.c~alloc_tag-handle-incomplete-bulk-allocations-in-v=
m_module_tags_populate
> > +++ a/lib/alloc_tag.c
> > @@ -422,11 +422,20 @@ static int vm_module_tags_populate(void)
> >               unsigned long old_shadow_end =3D ALIGN(phys_end, MODULE_A=
LIGN);
> >               unsigned long new_shadow_end =3D ALIGN(new_end, MODULE_AL=
IGN);
> >               unsigned long more_pages;
> > -             unsigned long nr;
> > +             unsigned long nr =3D 0;
> >
> >               more_pages =3D ALIGN(new_end - phys_end, PAGE_SIZE) >> PA=
GE_SHIFT;
> > -             nr =3D alloc_pages_bulk_node(GFP_KERNEL | __GFP_NOWARN,
> > -                                        NUMA_NO_NODE, more_pages, next=
_page);
> > +             while (nr < more_pages) {
> > +                     unsigned long allocated;
> > +
> > +                     allocated =3D alloc_pages_bulk_node(GFP_KERNEL | =
__GFP_NOWARN,
> > +                             NUMA_NO_NODE, more_pages - nr, next_page =
+ nr);
> > +
> > +                     if (!allocated)
> > +                             break;
> > +                     nr +=3D allocated;
> > +             }
> > +
> >               if (nr < more_pages ||
> >                   vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHI=
FT), PAGE_KERNEL,
> >                                    next_page, PAGE_SHIFT) < 0) {
> > _
> >
> > Patches currently in -mm which might be from tjmercier@google.com are
> >
> > alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate=
.patch
> >

