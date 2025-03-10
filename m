Return-Path: <stable+bounces-123113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73386A5A38B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E95170F1B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103EC1ADC78;
	Mon, 10 Mar 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5NfDBZx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B829D0B
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633347; cv=none; b=g7EKBzhAvVPV7Pe3l5jHCvgrBsnZyvH4lIRBSlK+AyFOmqtkR7WEGHvlsK5dp+dAhVedhSx1E+eT84Ki2OxH8p1iQ3YLCknU41dOjcWTp8tY6tjLs97uCx7Ln9mPsa4xFiDghotm2Zc9w6ClBuVmNHU4c4ixDWUYX4rxnDOwWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633347; c=relaxed/simple;
	bh=3nxm43hIuVSnK07oB52G24W2pLRmQb/JI06tFTgtgcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEgFU0ymc+CIMJE4Gbe8yxvdgA+UAQuxDt7vJoaJiY+pF/Fp2Yw7hkzwh49JAy1IfvelNFu3DtuO9azH0wTQKJlfjNmbBTeYVG73ePEz/HmQSb2VN5YfyybpO5FPBPF4dKxQB1MgSI2MRstPmnjP0r9BTl45oonTVvHY4jiqBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5NfDBZx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476693c2cc2so66511cf.0
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741633345; x=1742238145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65TRkQKYAIlb+YN6NxdO5Pu8QP66qaWUU5qzmoVqAd8=;
        b=n5NfDBZxU1DtfUhg5Bm0g0AjC3Y1hm7t1Q3VaPhTZv7Q4SrJNd6LCZ5xNp2HB0XwIT
         HYpn+Z0FSkCrgoZGQVIIDgX+3dmy7NS5TwfR5dt6WPc21UtVCrkAfZb8iPUEgZ3WhG31
         /0lTlY0rvR/2A4iuFkLpz+dSMyQLK1AFJnChGYMf20G9vaLUEfQKeS/hkfuwch42Lh2z
         wkoJPk8ZuMTR+UgzfYwSqayXkIVYsQrXltWm7mMDKRGMpAHvGz9XPu2xDTSH0dQFAsGW
         n0bQHwX1KUH8PAPkYJ4F3DUe6HC+uTOThmsbXbVPrcz5dJkIRejWVZMUDSkSv8+3+rKb
         Bupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741633345; x=1742238145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65TRkQKYAIlb+YN6NxdO5Pu8QP66qaWUU5qzmoVqAd8=;
        b=Nm1anYTfUWKGaAXQPW+OHOFU8ZGd6xOjFw7j//SgKqwutitlQa/HYJN5WS0wPgYsXX
         WtdzcKrtpWgsG06WDaDTWwiS5cbTapoK+E214aWgwzfUCYyKXrT4exRX4ArtRAp655ui
         w5eNIiQSPetfFENFWgmsWMx+l3hIDqxx2JKg4Jpk9NPhHxTG8hwMLogTHOmvFV3YAQwS
         ZHADANoKzN//sWC+WK9DvpNcTgfTsTr0SP1jPnFFcxvZ2k8mBKMnh7XhNnayuQgCPF3M
         5LAOyXS5r/UzMXy2rDFzj5gQNfvzGs/yeRUBuD5hQMTPdTIrmwfStC2SaQKaYBFZ8ew2
         8pdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKTgGS2HoGzSek+bCJkJIZGVwGRBLVaSGcTz9De3dK2vG8WprFDhWRYFk8oH6MDA1vb1nG2iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VVKEdBkesTI0SRozh8Y6wFA1Fu58FNsF4VoP1+RJe6hkyI8v
	Ojh1XGOF7xQu2ophHiMXWsWc5d8Q3dGWYLelMBtuvcnZggK4GQ2VaPIZYiJOsDtQVQ1k2VPu5IB
	j5f8tVcUpSHx9sFGpOJJtJgkjK5hkMhUtKzca
X-Gm-Gg: ASbGnctAFL6404OSVLJ4SEvKEF/4kKbUeixrixygATfyV9d1JRssAoHXa1GuqxYAxW4
	z7UTDZ3w77HhT94z73jVGLJwD8kyzlq/0a1badA0aj841CVA05HVLajvd7JP/JDKVDjOctX66BY
	uxsJF8nGcNUeT5wbYohOn1alR8E7ESfE5fblqM
X-Google-Smtp-Source: AGHT+IF7U8/KFzMXBOLNPR1JbV55EqR1yirm7P4BJROA5Y6N2bRAguF1fRjVF41kOEz72Jw1lujxLkjdV8wsPZwiPAM=
X-Received: by 2002:a05:622a:4e8a:b0:474:cd63:940d with SMTP id
 d75a77b69052e-47664cd4fb2mr9122541cf.0.1741633344418; Mon, 10 Mar 2025
 12:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025030948-playhouse-strongman-c9c3@gregkh>
In-Reply-To: <2025030948-playhouse-strongman-c9c3@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Mar 2025 12:02:12 -0700
X-Gm-Features: AQ5f1JoPlvQhhoEmfZIBsinca87yOUOm6Fus8KXKKVbc4x8nt6FUzu3q04kDMXE
Message-ID: <CAJuCfpG5ovkVXHsxB+L_Spjs1hMYuA725+BgjiQGkqzb1Uiymw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] userfaultfd: fix PTE unmapping
 stack-allocated PTE copies" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: 21cnbao@gmail.com, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, david@redhat.com, hughd@google.com, 
	jannh@google.com, kaleshsingh@google.com, lokeshgidra@google.com, 
	lorenzo.stoakes@oracle.com, peterx@redhat.com, stable@vger.kernel.org, 
	v-songbaohua@oppo.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 11:15=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.

Hi Greg,
Similar to linux-6.13.y, I just posted linux-6.12.y backport [1] for
an earlier patch and with
that and with 37b338eed10581784e854d4262da05c8d960c748 which you
already backported into linux-6.12.y this patch should merge cleanly.
Could you please try cherry-picking it again after merging [1] into
linux-6.12.y?
Thanks,
Suren.

[1] https://lore.kernel.org/all/20250310185747.1238197-1-surenb@google.com/

> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 927e926d72d9155fde3264459fe9bfd7b5e40d28
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030948-=
playhouse-strongman-c9c3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 927e926d72d9155fde3264459fe9bfd7b5e40d28 Mon Sep 17 00:00:00 2001
> From: Suren Baghdasaryan <surenb@google.com>
> Date: Wed, 26 Feb 2025 10:55:09 -0800
> Subject: [PATCH] userfaultfd: fix PTE unmapping stack-allocated PTE copie=
s
>
> Current implementation of move_pages_pte() copies source and destination
> PTEs in order to detect concurrent changes to PTEs involved in the move.
> However these copies are also used to unmap the PTEs, which will fail if
> CONFIG_HIGHPTE is enabled because the copies are allocated on the stack.
> Fix this by using the actual PTEs which were kmap()ed.
>
> Link: https://lkml.kernel.org/r/20250226185510.2732648-3-surenb@google.co=
m
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index f5c6b3454f76..d06453fa8aba 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1290,8 +1290,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                         spin_unlock(src_ptl);
>
>                         if (!locked) {
> -                               pte_unmap(&orig_src_pte);
> -                               pte_unmap(&orig_dst_pte);
> +                               pte_unmap(src_pte);
> +                               pte_unmap(dst_pte);
>                                 src_pte =3D dst_pte =3D NULL;
>                                 /* now we can block and wait */
>                                 folio_lock(src_folio);
> @@ -1307,8 +1307,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                 /* at this point we have src_folio locked */
>                 if (folio_test_large(src_folio)) {
>                         /* split_folio() can block */
> -                       pte_unmap(&orig_src_pte);
> -                       pte_unmap(&orig_dst_pte);
> +                       pte_unmap(src_pte);
> +                       pte_unmap(dst_pte);
>                         src_pte =3D dst_pte =3D NULL;
>                         err =3D split_folio(src_folio);
>                         if (err)
> @@ -1333,8 +1333,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                                 goto out;
>                         }
>                         if (!anon_vma_trylock_write(src_anon_vma)) {
> -                               pte_unmap(&orig_src_pte);
> -                               pte_unmap(&orig_dst_pte);
> +                               pte_unmap(src_pte);
> +                               pte_unmap(dst_pte);
>                                 src_pte =3D dst_pte =3D NULL;
>                                 /* now we can block and wait */
>                                 anon_vma_lock_write(src_anon_vma);
> @@ -1352,8 +1352,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                 entry =3D pte_to_swp_entry(orig_src_pte);
>                 if (non_swap_entry(entry)) {
>                         if (is_migration_entry(entry)) {
> -                               pte_unmap(&orig_src_pte);
> -                               pte_unmap(&orig_dst_pte);
> +                               pte_unmap(src_pte);
> +                               pte_unmap(dst_pte);
>                                 src_pte =3D dst_pte =3D NULL;
>                                 migration_entry_wait(mm, src_pmd, src_add=
r);
>                                 err =3D -EAGAIN;
> @@ -1396,8 +1396,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                         src_folio =3D folio;
>                         src_folio_pte =3D orig_src_pte;
>                         if (!folio_trylock(src_folio)) {
> -                               pte_unmap(&orig_src_pte);
> -                               pte_unmap(&orig_dst_pte);
> +                               pte_unmap(src_pte);
> +                               pte_unmap(dst_pte);
>                                 src_pte =3D dst_pte =3D NULL;
>                                 put_swap_device(si);
>                                 si =3D NULL;
>

