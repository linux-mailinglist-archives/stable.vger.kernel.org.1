Return-Path: <stable+bounces-160520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC9AFCF81
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D551C202BE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17A2E1749;
	Tue,  8 Jul 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9WpH0sk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0F2E11C3
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989201; cv=none; b=XLjY2VtapLiWrK18BLHUSWk2EcZkSL2FHwnVmIvGAbLZB0gcy4opz4xmB1WnY831lqHHmnhfEbHFvFW583V5attR4wGbDge23CRRnSy4+xQPeNQVu8cyknxgTs/5jkX3Nw13aAkBwTR5ZiRuJS8D/ZNJQC4l6VrzmsGc77e0pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989201; c=relaxed/simple;
	bh=/XygNlSmc7jYkBz+SlTl7nsjnFXuRu+7W/+6MamxwAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7yW1F2oBvVlagvPQb2DUcJhKPE9Tdv9kdZJFzKJvsKsh7zkqYk51GyjBYI2kQHhIAxX0ZrwTtObi2933HLogSZvXPsmGeJjJQJQHN+39S4yCmun3rzl4235o9xcEQDkbeaVvTfBtvnBiUlu3g6vgP0RqyTAEQYc/Ei6MP3rULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9WpH0sk; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a7f5abac0aso320421cf.0
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751989198; x=1752593998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NLf7r1SqdhHC1Id+7p34mmn58G9MGm6E8awmU3gkNU=;
        b=t9WpH0skWYclKX5Yl1UOgukM5GgEpEvU3S/yqVps/ONLUw3/rxS3Od87fWbtPye8Qm
         9BHvthwfLNKxsBdQR+PVk3vfX22LPKexmmZPzogFKEc9JOzvi0Esy3DwZEmGyYBhyprh
         /m9r+4oFUzZsyJUxocchVvvEZxcQaFZFnI7rQDsD4EReeRpKvdydLFFGIs7XMW+eXZ44
         btwwv9AiF4deVZw1VNMtxp9Ik3fAn79ey9twhwquz7utyullspAWH11aWn8OoiJ9o4mK
         UgIcdIUW3IaXMsgtKPoAqnWKrtTfMAg+IwnxkTOWC7VN9hTL8ZaAZMV9cCT1T7DWZ0wo
         CylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989198; x=1752593998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NLf7r1SqdhHC1Id+7p34mmn58G9MGm6E8awmU3gkNU=;
        b=n9LOk5QlXIOA6cc2uV0iizi9C2dpcKAv8pfUCsnXnqDjm0fWHxSK/CuczvDE8eUiyc
         Qoi9zDrTGWeRRAuKxES/SKMGqGFOKYelFHffOFNbJUpJE0PaGXFLh4+PYZcAuspc0osV
         GK13cj/h5xBOLFIZ94VZoZHJduNCp4uksXO8pnZm5jfax/3bUSZN1api/g2ciAeOniDu
         BDfvgKRmNNrdaqQtDRE2vuNjkdLGc4zc+Q1Zig8ttXZJfctB0nn1Txy6v83tyxWNFmGB
         6cKipXNaOctZQhdw3Sb7D56uZFKx6lsbQfFPwVXFEh2Dwplckuop4NWqG2dT4B6wfEEK
         4EOw==
X-Forwarded-Encrypted: i=1; AJvYcCVRPqR4KlOsxSprK5tLdkLSbkhtpSeWFhlatsrI7MtoljEnGXZ2B0zQZCYi3n62w/0WV5K8xMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYLXb7VGuKRHsrDUOsP0hJ7rp0J+bEvxnn2HqUPczdENEHXf7
	4DLjIVdGUBvYNrkMR6WY5fIQInfns2knV4kZyxEHqy+VzdtlB1J2RJocr0CjgfODhWAFhvk2G3U
	9PRWX0K11nbd4ehw7MovFwp7Uq/cwQKAu3WEK0PGb
X-Gm-Gg: ASbGncs3dBhBXaGJ7HbTRvmLIEz6ST9NJm29Xy+xhFFIf5ZnTKdA9iQbU5+FWnBS94m
	hY4kL3lrQlAhhWj9frhqGRc+9cA1mVqQS2uNlEMkYgLMemJuDPQRx7vL2SYsahy3Q8nG/11mtx5
	UvGSFN/MMQNvuE3fmcBsVWTil2bWAwHvTUo0t9wlTTZ/JUjCIvUeVtAg2qtYGoACyvUQh0AgAtK
	Q==
X-Google-Smtp-Source: AGHT+IHG8Emt+gyL8UvFNaFyi+O07zeBWkW+UVHfL/feE1C+ZTRqBaq0OQuwKFyF0Kg/LheKjk2b3XFv0JAoeL/sHwo=
X-Received: by 2002:a05:622a:8345:b0:4a9:c8bb:459 with SMTP id
 d75a77b69052e-4a9d48ee47fmr2280891cf.29.1751989198055; Tue, 08 Jul 2025
 08:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630031958.1225651-1-sashal@kernel.org> <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
In-Reply-To: <aG06QBVeBJgluSqP@lappy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 08:39:47 -0700
X-Gm-Features: Ac12FXxgax9QRUHgWfWnI6-7Cpsi0Gj1hqhyNry_hrJmcV9KjYxfNpCr2VuvWkY
Message-ID: <CAJuCfpH5NQBJMqs9U2VjyA_f6Fho2VAcQq=ORw-iW8qhVCDSuA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
To: Sasha Levin <sashal@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:33=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
> >On 01.07.25 02:57, Andrew Morton wrote:
> >>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrot=
e:
> >>
> >>>When handling non-swap entries in move_pages_pte(), the error handling
> >>>for entries that are NOT migration entries fails to unmap the page tab=
le
> >>>entries before jumping to the error handling label.
> >>>
> >>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE system=
s
> >>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
> >>>corrupted.
> >>>
> >>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
> >>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0=
x178/0x17c
> >>>   Call trace:
> >>>     kunmap_local_indexed from move_pages+0x964/0x19f4
> >>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
> >>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> >>>
> >>>The issue was introduced with the UFFDIO_MOVE feature but became more
> >>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: a=
dd
> >>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
> >>>path more commonly executed during userfaultfd operations.
> >>>
> >>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
> >>>paths before jumping to the error handling label, not just for migrati=
on
> >>>entries.
> >>
> >>I don't get it.
> >>
> >>>--- a/mm/userfaultfd.c
> >>>+++ b/mm/userfaultfd.c
> >>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm=
, pmd_t *dst_pmd, pmd_t *src_pmd,
> >>>             entry =3D pte_to_swp_entry(orig_src_pte);
> >>>             if (non_swap_entry(entry)) {
> >>>+                    pte_unmap(src_pte);
> >>>+                    pte_unmap(dst_pte);
> >>>+                    src_pte =3D dst_pte =3D NULL;
> >>>                     if (is_migration_entry(entry)) {
> >>>-                            pte_unmap(src_pte);
> >>>-                            pte_unmap(dst_pte);
> >>>-                            src_pte =3D dst_pte =3D NULL;
> >>>                             migration_entry_wait(mm, src_pmd, src_add=
r);
> >>>                             err =3D -EAGAIN;
> >>>-                    } else
> >>>+                    } else {
> >>>                             err =3D -EFAULT;
> >>>+                    }
> >>>                     goto out;
> >>
> >>where we have
> >>
> >>out:
> >>      ...
> >>      if (dst_pte)
> >>              pte_unmap(dst_pte);
> >>      if (src_pte)
> >>              pte_unmap(src_pte);
> >
> >AI slop?
>
> Nah, this one is sadly all me :(
>
> I was trying to resolve some of the issues found with linus-next on
> LKFT, and misunderstood the code. Funny enough, I thought that the
> change above "fixed" it by making the warnings go away, but clearly is
> the wrong thing to do so I went back to the drawing table...
>
> If you're curious, here's the issue: https://qa-reports.linaro.org/lkft/s=
ashal-linus-next/build/v6.13-rc7-43418-g558c6dd4d863/testrun/29030370/suite=
/log-parser-test/test/exception-warning-cpu-pid-at-mmhighmem-kunmap_local_i=
ndexed/details/

Any way to symbolize that Call trace? I can't find build artefacts to
extract vmlinux image...

>
> --
> Thanks,
> Sasha

