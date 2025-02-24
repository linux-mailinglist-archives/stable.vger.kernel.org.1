Return-Path: <stable+bounces-118896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B67A41DC1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539A37A542E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDB264F81;
	Mon, 24 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="smvSQqpT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686725A2C6
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396440; cv=none; b=uj3TrLW6gsEe9jIQPE+b8MlwP2+qZsERS2qwaXRdi3L924Vx3wgI5z2CUYGd4gpnrnnk6kfvGMNKgX8tlvXJXAySCVfeqrrdLIrL8FtOML1zvcMQtzvytXGmAnMwgLXUnotBI6Rx+OF185h74Yzj6h0TSaZv4yZJa0B/HWnlTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396440; c=relaxed/simple;
	bh=uVUI9XT3ntm/IJHQ8VdbiNgxGQ63ksKn5ue/m1VRUYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4m5bEk6c0xbLmoBjxsocNttKBj+frKVSrhtJvwsFQca1uW2uLd/8uuZHlNZrvZ+qmQ4H4ZQAbfMSW6UfJoTEjewDRDicizOUvB406REBy8nVZ1ODVg//8+7mrGATWBlSWWUWys5ZNyIoDXrSMb1fiKMHwysLWoMa6HXm6JxSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=smvSQqpT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so6781226a12.3
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740396437; x=1741001237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPK2zF8A/QoLIlZ7H4rce8LDxvSgapo6R5EV/XU26lw=;
        b=smvSQqpT1iNyAw4TqYZqACvPQgnTTKF6jPY1finqkDcYHrIA2RITOqFnZpniehSq4B
         RsZg6GdcKqaSnmEDwozoVpraectASso5bNz/l2sbKIaY3pYXlOOzIQOT7FSNZG+JVBgG
         Yt+p6HES/IONQIGVuOXma5cfyAR9qr/GT99aXBhmkZ9XrEBiQrv8wuB624VD6M9kpE44
         tCIg+ck+KqcEtL/QbbJ5ghsd34bdV9Qr/4KqbduHZA+ofg+LmEcppvCkfoV0sAp7vMni
         qq3suHhL07ymygXKI5efNAzh1mxH0UCcgYoFEjZtRtsM8qBKKj/9WFKtnEv+T/LFfVNt
         ds9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740396437; x=1741001237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPK2zF8A/QoLIlZ7H4rce8LDxvSgapo6R5EV/XU26lw=;
        b=Qv6O/kU9/ud1ktDjF7AetN28/l3RFpUmtbIStvq1MtWZcjKER864sY0e7cXuNZzXCq
         XU+9Y+mcXgTQyaRyIoY6w1Suj0i0eMVKrx++mcSvzPkdBW7QFtLA4M6XvWbjRvFopZge
         eZzGfYo0HyJrU4Qn5oyHifQGdy657z1iHcf/0kNoiisuzX+bW+86FPloi+yWI6w04VeG
         wMfgiABKV08IbMwWdHXq1KRtKFkKZzToman84RbmiXKagd7hT6AshTf0Ox80Hyhq0nVX
         qZMLHlHjUqBhEqc2lmwZphFtPFQYFq4y+RjgntSjigiCJWjBlMHPXKTNiUOry9YpRYZT
         MZzg==
X-Forwarded-Encrypted: i=1; AJvYcCVe4ccxuSqyF4YDC+Lejc1fB2Lp3+T6+2CLGDKbagGvU9AhCW0B/Jgspu/KhvToAQ8iRRliKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tYKfw8JZCMWDNL6VtJ4EbdN1shbliSUmJzQFg+A56Xj/7p49
	/m8CnUyMn7td2cOwWKs0e69AbyAX76xoTg2ij9EVJrnXUWPFhGt9lGOYkiiqI/mNaM8uUm5Z8qg
	kFwhS4Kf95SvMW3qRcww2p1OA7A4RvZ6Z3SPh9Q==
X-Gm-Gg: ASbGncvCbKccSO3EMj1o3q8RHngZxPFBhOApHMPjhd2Az5lt5kjUnmF9h5tFpZbG7OI
	2ws+ChaPmq/lFkUrMm3ghCJ08ETjpx1kNk4lWdTejz2cRpcfRexw4J0ctsE6iR+Qk6xTZsym9Y0
	kKvKwXEwE=
X-Google-Smtp-Source: AGHT+IFzHPiP7HgEi1iLeAsUfPrgcPiwkLzFkdvMUmpitpPx5I5iW5pGV+bPYBd/LufmeWzu4SPrwChI7bwpkBQUkUA=
X-Received: by 2002:a05:6402:274b:b0:5dc:db28:6afc with SMTP id
 4fb4d7f45d1cf-5e0b6fdf732mr13463545a12.0.1740396436756; Mon, 24 Feb 2025
 03:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140419.1702389-1-ryan.roberts@arm.com> <20250217140419.1702389-3-ryan.roberts@arm.com>
In-Reply-To: <20250217140419.1702389-3-ryan.roberts@arm.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Feb 2025 12:27:03 +0100
X-Gm-Features: AWEUYZkGhzPlXZwydhM9MLmyrXrPvhtmhDQdRWEVf0EDYo_eOVstS6UzcJ92dwo
Message-ID: <CAHVXubiBS-m91bpx-NbKdkcSk3HdStTxY8QLVTKxxozL2Od8Qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Mon, Feb 17, 2025 at 3:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
> CONT_PMD_SIZE). So the function has to figure out the size from the
> huge_pte pointer. This was previously done by walking the pgtable to
> determine the level and by using the PTE_CONT bit to determine the
> number of ptes at the level.
>
> But the PTE_CONT bit is only valid when the pte is present. For
> non-present pte values (e.g. markers, migration entries), the previous
> implementation was therefore erroniously determining the size. There is
> at least one known caller in core-mm, move_huge_pte(), which may call
> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
> this case. Additionally the "regular" ptep_get_and_clear() is robust to
> being called for non-present ptes so it makes sense to follow the
> behaviour.
>
> Fix this by using the new sz parameter which is now provided to the
> function. Additionally when clearing each pte in a contig range, don't
> gather the access and dirty bits if the pte is not present.
>
> An alternative approach that would not require API changes would be to
> store the PTE_CONT bit in a spare bit in the swap entry pte for the
> non-present case. But it felt cleaner to follow other APIs' lead and
> just pass in the size.
>
> As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
> entry offset field (layout of non-present pte). Since hugetlb is never
> swapped to disk, this field will only be populated for markers, which
> always set this bit to 0 and hwpoison swap entries, which set the offset
> field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
> memory in that high half was poisoned (I think!). So in practice, this
> bit would almost always be zero for non-present ptes and we would only
> clear the first entry if it was actually a contiguous block. That's
> probably a less severe symptom than if it was always interpretted as 1
> and cleared out potentially-present neighboring PTEs.
>
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit"=
)
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 40 ++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 06db4649af91..614b2feddba2 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -163,24 +163,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>                              unsigned long pgsize,
>                              unsigned long ncontig)
>  {
> -       pte_t orig_pte =3D __ptep_get(ptep);
> -       unsigned long i;
> -
> -       for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++) {
> -               pte_t pte =3D __ptep_get_and_clear(mm, addr, ptep);
> -
> -               /*
> -                * If HW_AFDBM is enabled, then the HW could turn on
> -                * the dirty or accessed bit for any page in the set,
> -                * so check them all.
> -                */
> -               if (pte_dirty(pte))
> -                       orig_pte =3D pte_mkdirty(orig_pte);
> -
> -               if (pte_young(pte))
> -                       orig_pte =3D pte_mkyoung(orig_pte);
> +       pte_t pte, tmp_pte;
> +       bool present;
> +
> +       pte =3D __ptep_get_and_clear(mm, addr, ptep);
> +       present =3D pte_present(pte);
> +       while (--ncontig) {
> +               ptep++;
> +               addr +=3D pgsize;
> +               tmp_pte =3D __ptep_get_and_clear(mm, addr, ptep);
> +               if (present) {
> +                       if (pte_dirty(tmp_pte))
> +                               pte =3D pte_mkdirty(pte);
> +                       if (pte_young(tmp_pte))
> +                               pte =3D pte_mkyoung(pte);
> +               }
>         }
> -       return orig_pte;
> +       return pte;
>  }
>
>  static pte_t get_clear_contig_flush(struct mm_struct *mm,
> @@ -401,13 +400,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, =
unsigned long addr,
>  {
>         int ncontig;
>         size_t pgsize;
> -       pte_t orig_pte =3D __ptep_get(ptep);
> -
> -       if (!pte_cont(orig_pte))
> -               return __ptep_get_and_clear(mm, addr, ptep);
> -
> -       ncontig =3D find_num_contig(mm, addr, ptep, &pgsize);
>
> +       ncontig =3D num_contig_ptes(sz, &pgsize);
>         return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
>  }
>
> --
> 2.43.0
>

Thanks for ccing me on this fix, we have the same issue (in
huge_pte_clear() too) in riscv. I'll come up with a fix and wait for
you guys to merge this.

That only comforts my idea to merge both riscv and arm64 implementations :)

Thanks again,

Alex

