Return-Path: <stable+bounces-123110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46339A5A368
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27A37A6ACC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63518234969;
	Mon, 10 Mar 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AO6uAzO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F96B1C3BE0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632652; cv=none; b=tezjpTdPyJwOuaJyjJA5f1lCuBWE3RZGlxvXskBFMdz/gfsX4uw/kS5Gh19A5vdMrf+fYroMkB3GB9LlzLmWMeGSsgFSuSGjmSvb1mqoHsDFGNtSvY7s8q1fDAX1OYUWustUG9K/rnVvSrDBDV9BruUHiqQNjkGyOK7281+OhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632652; c=relaxed/simple;
	bh=Vs361ZZa30TtpkF+L2Qkv565a3SDtYqnABCFm92dDOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DePLlv7MMXToTRg8hw+s+a8lapvi3IG8EfOYXIeVedniipLVxewVPzEr2hZYJpKBkr/UG9ECUorFuLL0U4YDCqI8zz2SypmIEPkq4aIN/MP+90+KKOYSLJSs+TpTXe6t6x5JbgvGy7qtDTQKbmaaiPy0sGRAqR1RvjFkDm/jHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AO6uAzO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476693c2cc2so61811cf.0
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741632649; x=1742237449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjtyU7pStz3eAOi9yL03nQ6Rc0jfyziX6VN+xYmVuSE=;
        b=1AO6uAzODbsP7KjLpgHReHlxrocb3FRcs7NbIIExGqDSSFCDOWHEzmFbGL27zpjNth
         I6rOB1AN3F4rX3FCwsBatoIEUfkrcA2w5bcJTehR/rYHmsm205FZw1cTEj12vnHWMgiK
         K1yMrjnayvtisT0mLK0n33BO5+QC+MlPOobUmpEynj4owUerT27MvdjzqUIvpsKQu15A
         BjG0o0JwrTGKUYAM6jnJddDj+hkWvlYjwPkHwl/pLfnkAqObswOvM3A6u2NJA9a16QwQ
         /bElmPaFLpZdamkiuVceqCIeP6kgtQJ98GVSLiQj9Zw/M3mAxYxjpO28lSk36CiKQJjH
         2xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741632649; x=1742237449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjtyU7pStz3eAOi9yL03nQ6Rc0jfyziX6VN+xYmVuSE=;
        b=RXUkKxQG9SwIR9flFx9p3KXgD3WbnynmmmEOWeOlcvlj+t7Or7HKD0FNi9kegrYMlV
         S95oKEc+VPOT5mfwpIFq7Ph8nJpkgsMGrjws0ZqxYTvR5+ZmUoDmTQNyYGUqsTFj7K+b
         jrqwiI2tl0TBStI6KYMbdaEgFXtIpHTLeOF/Y15Q0ke/d87sCSTj7Pj04lM/a7dMX3Y8
         IhwyavVeJ0caulwViRKUMHXHPgJ7Lio9/fUKoVpTJQPVGVT9ilkk6M92itKIU1sAjRuB
         Nf0Jhc5Rwwv5zpVFnWR3njaRPf0NEoD3VI0miwpbowyvFpdrXRl4dq0REjYMRrBdm29k
         xnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2xAtvts6+lNSTE/E0JWmeXvVAOn6y9oupGVHUpb7HvHsmTUbGWBx5WxYtKesvKzRpyx1GIkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRIqg55GykY6Fdo37/UckEafMwC2wv92y9mHqpBE83jHlO7Ii
	XiD2z27Zf8co06Mtf8AKigd8popAjAJnWi9AiYsMLzPQ0wiwegONvxbzxDmXesOlA3+By2y/pNd
	oQMnu4Eob2Ry2/JO3VCL90pWdLOgvpPVvYeWL
X-Gm-Gg: ASbGnct3MabFufZ9HirNE6JSfw+w1LRpagfJwYdFyyyQNFViA9PJSce1AMWPnVdbZmp
	F1ttQK8siHElDSPRFfjYolfkXAqEBjVIPgT3YlQtITYlURPFeH8hJ2AP1pC0soxsFMoUuE/Ot1f
	3vYGDlwP6MUf8HMT4ktwwxILTWoNZ59IoOOqPy
X-Google-Smtp-Source: AGHT+IH8J3ojsosVKcV4VJhYnydtJJZy2PJHJKu9Gc+32X1HjRXbOhQAKXYbY1FTJ51Fu/OqNDIZtoSOsZ7KhRax8jA=
X-Received: by 2002:a05:622a:178a:b0:461:358e:d635 with SMTP id
 d75a77b69052e-476653ed6f3mr8666041cf.18.1741632649011; Mon, 10 Mar 2025
 11:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025030947-disloyal-bust-0d23@gregkh>
In-Reply-To: <2025030947-disloyal-bust-0d23@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Mar 2025 11:50:37 -0700
X-Gm-Features: AQ5f1Jod_jyQ1PzwMqPE1F1kVXoNZcEoEp2a0NILNTNZX6qu3e_oyNkKxoIko5E
Message-ID: <CAJuCfpETm8PL8O91jEhkAHc8hkpJhCyEXiZbCvnPz_GMAZ5ptA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] userfaultfd: fix PTE unmapping
 stack-allocated PTE copies" failed to apply to 6.13-stable tree
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
> The patch below does not apply to the 6.13-stable tree.

Hi Greg,
I just posted linux-6.13.y backport [1] for an earlier patch and with
that and with 37b338eed10581784e854d4262da05c8d960c748 which you
already backported into linux-6.13.y this patch should merge cleanly.
Could you please try cherry-picking it again after merging [1] into
linux-6.13.y?
Thanks,
Suren.

[1] https://lore.kernel.org/all/20250310184033.1205075-1-surenb@google.com/


> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.13.y
> git checkout FETCH_HEAD
> git cherry-pick -x 927e926d72d9155fde3264459fe9bfd7b5e40d28
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030947-=
disloyal-bust-0d23@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..
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

