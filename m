Return-Path: <stable+bounces-165683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3DB1759B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC7A830BA
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58124DCED;
	Thu, 31 Jul 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIadDMlG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879BE1B87F2
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983063; cv=none; b=cg2oqKXo0mbrYaZX7c4aud0595wdx0KAOnKKuL12assRznt0UpOIJoErcwQ4D0PvDqj4Ehzn9wjjACG35DMw8GNkIM1M1ThWADveKf1BOSPkgABWD7WDlt8VmEkv4GNfLcyYeV5WqpLEsvYl9EL1jh5Kp1rpaPUBMo8lOqTGbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983063; c=relaxed/simple;
	bh=s8Fkj2wMw9x/f8DV4m/VFl3/5T54yAmMlF1RuB1J8Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gm/Qp5R5bx3cwORgFUpSUmYSy5rloDc4Ob/cm/G5nghIWm0tqjpjTEfoW5jt5B0gyOiBpzWHQEfKzdAMzOeMWVqRCvy6xQe79g7vjVeE+72s2v7hgedDi1RvbJ0fxXthcFWuKI9VjT8FjakO8q1yHUA6/h5UQeTrW/ySQPP05Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIadDMlG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso654a12.1
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753983059; x=1754587859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTYZ6ctQGC42ES6NTcAXoMAQOzCvBSfMLOvM1LONwic=;
        b=vIadDMlGg9Td+k1aaZpCt1PYRMRmADkx/ghEdmG7OEzPJI3JFudjeyrSMyI3b0ozt9
         4r0L+W6azV87rGzf5CYfHLI/Hu+jhI2UYCnrPhlsV2Jmy5XvdKhqupInT9bUBMdJgSqe
         I8BSHTXtSRdY1OJbjoHH7oiT09u7yPCnY/SUkTqbvC16eW2wyLRPhFD/PDlzHuQNWuuR
         ++JSdvZyVkxXnApw/nuERrd0Cup/jd4CjwFQiAUnOOB3NcKoIplTY251vO/wHgqt1zw4
         BqTYD/W0QlclmDLrJoVgv2bWY3r7emIHIoozE1Sn+ier5Em3bg3jWsKpHOahyA6DQVpx
         /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983059; x=1754587859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTYZ6ctQGC42ES6NTcAXoMAQOzCvBSfMLOvM1LONwic=;
        b=ZAik3LVh/FTH4nwjMaXpkgurmO5pjUyNb7G8DzGhZPEaoYo4U8OSwtzrWE8lLBfWVj
         qvJ9fFOU5WXGZLBjTg8FsQs5ODdPUXNzoM0ZHM/ZmfHKFISgDzsYTC5V/Ao7yNvXU8SW
         lVjuVeqZk7tIRzIABbesyj4+yz1gbugW7G9luLxoEY38GJukNAZdP08sOq8tnUMwfgnm
         Iiyckoffmg4HpuOCCIGS+Eb41uSsPeVIVa+04KKzybIvomgO1/tv2MZR8/5Y1ovpcb9w
         SSEdVGUZsfV5R0JSCDKGNgHNxVp0z9DaJzu3TYUMj2jhN2a5HfWy77Tdx8pocGaIGjhP
         wFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMC8D1h+LC38AOivjwE14dtEbgKPnWvfTvSRb4kPwQaOHw42/cpd7aPuYL+cp89760vYe6M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbTWpQDGyncG/SuMziBQLHQLSUN48WarQ2TXva98S7Ni8tT6O
	+Rn5ncIO/0P2Z1Z4nM59dInyZwxzKXeHJt31v9NYPfNyEkj0gLOT7Mpq1Piz29LW+GqALhAHBaa
	6V8Wps2JoiUWl+BDkqH4dwxPR7F5i71lTsGxoQU4f
X-Gm-Gg: ASbGnctrjbCnJ1nqbpbDtIeHJ183rDn8+NL2uAdRMbpqykOtQ44uvBfG+zOFLjRfmdu
	RIJQ2XzgB3R84FN6N+kd213R6sI1vaNuXJI7F7DyP5A3O305M83EBYE6TNWKTrJ7tlu7YH9EVH7
	K2LOhzgfZ+S8k5cB0yKZirKzqofXuGQ3+OpLiaLGUHy3EnksK40k0ypY5eQU2OczMheZRD9OjRc
	eAPii7Yz6pqwnJyYYavL9QGwPe4LzhIjVmlWnIIzw==
X-Google-Smtp-Source: AGHT+IF1QJ83Q6c4dkzDCM2z6KKYFAxir5RDC4UAZQtNvYOpT4gEPwIqWv3dD6bsp3P9MtuExIQPvuxLjZH4h+ZidhU=
X-Received: by 2002:aa7:c687:0:b0:615:2899:a4e5 with SMTP id
 4fb4d7f45d1cf-615aeb102b5mr84457a12.5.1753983058516; Thu, 31 Jul 2025
 10:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com>
In-Reply-To: <20250731154442.319568-1-surenb@google.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 31 Jul 2025 10:30:46 -0700
X-Gm-Features: Ac12FXwZbn_-TO6sOPye9GKpC7g4hj7tbdyDuoXOlj14tXOv6tXKAlm_xFPsw5k
Message-ID: <CA+EESO4T-rYwmd_h3AxAkiiHgqcLQQzE1SmGNSGqOFbGvEShGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> encounters a non-present THP, it fails to properly recognize an unmapped
> hole and tries to access a non-existent folio, resulting in
> a crash. Add a check to skip non-present THPs.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@goog=
le.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1 [1]
> - Fixed step size calculation, per Lokesh Gidra
> - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gi=
dra
>
> [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.co=
m/
>
>  mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cbed91b09640..b5af31c22731 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
>
>                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
>                 if (ptl) {
> -                       /* Check if we can move the pmd without splitting=
 it. */
> -                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> -                           !pmd_none(dst_pmdval)) {
> -                               struct folio *folio =3D pmd_folio(*src_pm=
d);
> +                       if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
> +                               /* Check if we can move the pmd without s=
plitting it. */
> +                               if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> +                                   !pmd_none(dst_pmdval)) {
> +                                       if (pmd_present(*src_pmd)) {
> +                                               struct folio *folio =3D p=
md_folio(*src_pmd);
> +
> +                                               if (!folio || (!is_huge_z=
ero_folio(folio) &&
> +                                                              !PageAnonE=
xclusive(&folio->page))) {
> +                                                       spin_unlock(ptl);
> +                                                       err =3D -EBUSY;
> +                                                       break;
> +                                               }
> +                                       }
>
> -                               if (!folio || (!is_huge_zero_folio(folio)=
 &&
> -                                              !PageAnonExclusive(&folio-=
>page))) {
>                                         spin_unlock(ptl);
> -                                       err =3D -EBUSY;
> -                                       break;
> +                                       split_huge_pmd(src_vma, src_pmd, =
src_addr);
> +                                       /* The folio will be split by mov=
e_pages_pte() */
> +                                       continue;
>                                 }
>
> +                               err =3D move_pages_huge_pmd(mm, dst_pmd, =
src_pmd,
> +                                                         dst_pmdval, dst=
_vma, src_vma,
> +                                                         dst_addr, src_a=
ddr);
> +                               step_size =3D HPAGE_PMD_SIZE;
> +                       } else {
>                                 spin_unlock(ptl);
> -                               split_huge_pmd(src_vma, src_pmd, src_addr=
);
> -                               /* The folio will be split by move_pages_=
pte() */
> -                               continue;
> +                               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
> +                                       err =3D -ENOENT;
> +                                       break;
> +                               }
> +                               /* nothing to do to move a hole */
> +                               err =3D 0;
> +                               step_size =3D min(HPAGE_PMD_SIZE, src_sta=
rt + len - src_addr);
>                         }
> -
> -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_pmd,
> -                                                 dst_pmdval, dst_vma, sr=
c_vma,
> -                                                 dst_addr, src_addr);
> -                       step_size =3D HPAGE_PMD_SIZE;
>                 } else {
>                         if (pmd_none(*src_pmd)) {
>                                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
>
> base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> --
> 2.50.1.552.g942d659e1b-goog
>

