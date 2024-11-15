Return-Path: <stable+bounces-93611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF19CF9AE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2283B3C68D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D0191F8F;
	Fri, 15 Nov 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Dafu4o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33042AA3;
	Fri, 15 Nov 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708935; cv=none; b=OdBuA+pjcCQHW6MmevAeoWc8T8SY52enrbUaXVAslHOtRTr+4nZ+AX5H3HzT6xSeuI5tPW8FGxFTAsWiVwlhzyVLx2Nxy3caSuzHU2U4Fmi/42FmRDnszA/MRblvHhI3qjYgWbw7eFdw8f2ojcYb1AEzELPc40oLbWCb9c4KLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708935; c=relaxed/simple;
	bh=I+QtWGHRBD+4yemSKClWnFIJi0GIE4JSgJQS5uBerY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvU+XKuL5qvZbOw4WYSZ+pDHxdNdYH1LF3Ukh6YN71caHlEihKiPklZQKa2TI0kPCtJyzHZUUA/1jgpYZSveLoMEv0YAbmtdsWcHlP7nzsSQzmVsGIF57qHRSh9zbDd4MUptNYfwLi5c22MnNV2NMM1Z9mrKib061n8GODmJ6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Dafu4o; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3798896a12.0;
        Fri, 15 Nov 2024 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708931; x=1732313731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM323IeHX5Wao0Wvn3Qxm0EBhrnoes7GmduEknVbsqI=;
        b=d0Dafu4ozjILAK3vbT+OQSMzuwWQzZcLMiVwFQ53tCQ47QziJlFdwaM6TZ5GH2WXiK
         +hbK3bOs3wYckNuOgOuSyr1iD+HVUyUhffi4lhBgyo2Rt2Qd1IvKNaZjmqaReqBKxKWJ
         5a/xEbSjjlzA5mFH6ivyqTGSKD4ieW9677/ZK6WXS9f0hLX2ZHO0Ytvlw81vqj2WB4eK
         Uc9id54FwPd7HeKEbRryrjB223ev61+ovEeJLXgFHsNR29UXct1hR+WrULjkQt4gcxz7
         qLbSSWbPbObhUvsjmvi7DdvZAdRJb+PBBUWsW6sXg5S3kIStRpmB6z3u3TofG2yGxeNm
         U2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708931; x=1732313731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM323IeHX5Wao0Wvn3Qxm0EBhrnoes7GmduEknVbsqI=;
        b=F/hnsSWk1U2N+48BjSGYwbg2tq49pSjXnvHBtP06uV3lLAIMwALHFYwbgsSmvdPYOC
         EaJWWKLKmLTQT/VrBctieuxHiQMBnTdyKl1R3p2fE6+wVbSElkqQmRam62FVs+EWqGYa
         kY4ns/0WF485Z1R3yDFpZt7U2EK110U0DC/ns6m7D9/xVMVlrpkE0T+i6mcByuVX6J/6
         5p2eOCLpvWwUQA+GKSFWmKl0FwhCzgCVBjGTbEUYtdPDCpqO3nsOhQlnpTLHUA2UPzKr
         AZDdo3tl1AekILbzaya9bmJUebd/oriTuyl/cJF/XW7dxYGD1s6oai54Zn85pmLIYLwq
         aa6g==
X-Forwarded-Encrypted: i=1; AJvYcCVWnoCg38LGFiT4FWKzHn4O4jihF4oD60Hczj36jYJqeMY8KNYw+M4/UR2sLSHZQQz83loed0EtJ/DWMTY=@vger.kernel.org, AJvYcCWB7Ab6YjogfESXjr3wWXiT4Fnr/k+HG5GZGrqtfG8UWtBNgqUEorQsuvLWgfxjDJDveGHXlClV@vger.kernel.org
X-Gm-Message-State: AOJu0YxRhQziIR//ZkI/0u9q83FxoGRSMO4mSBtSkT+rB6udo5HuusKW
	B8kEjB0bRaiKgRp7WMKBi00/jCZUyn71TWHSaV2UlBukh1CremFNL/33eAeVK4y/KRSe9douoU7
	3YZHf4Did49KH999uHN5XG4OvU0E=
X-Google-Smtp-Source: AGHT+IFpg42qBOE2i3RJF23Qu7bb0Wdl9LRB8XOn80l6Xa/542IJqFJwKaXgpinZsQaFtyqmA+qDNSpL9W8JJoFJzJw=
X-Received: by 2002:a17:907:6e94:b0:a9e:c696:8f78 with SMTP id
 a640c23a62f3a-aa48354da39mr338250966b.51.1731708931183; Fri, 15 Nov 2024
 14:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115215256.578125-1-kaleshsingh@google.com>
In-Reply-To: <20241115215256.578125-1-kaleshsingh@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 15 Nov 2024 14:15:20 -0800
Message-ID: <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
To: Kalesh Singh <kaleshsingh@google.com>
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

On Fri, Nov 15, 2024 at 1:52=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") updated __get_unmapped_area() to align the start address
> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=3Dy.
>
> It does this by effectively looking up a region that is of size,
> request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
>
> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
> on 32 bit") opted out of this for 32bit due to regressions in mmap base
> randomization.
>
> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> mappings to PMD-aligned sizes") restricted this to only mmap sizes that
> are multiples of the PMD_SIZE due to reported regressions in some
> performance benchmarks -- which seemed mostly due to the reduced spatial
> locality of related mappings due to the forced PMD-alignment.
>
> Another unintended side effect has emerged: When a user specifies an mmap
> hint address, the THP alignment logic modifies the behavior, potentially
> ignoring the hint even if a sufficiently large gap exists at the requeste=
d
> hint location.
>
> Example Scenario:
>
> Consider the following simplified virtual address (VA) space:
>
>     ...
>
>     0x200000-0x400000 --- VMA A
>     0x400000-0x600000 --- Hole
>     0x600000-0x800000 --- VMA B
>
>     ...
>
> A call to mmap() with hint=3D0x400000 and len=3D0x200000 behaves differen=
tly:
>
>   - Before THP alignment: The requested region (size 0x200000) fits into
>     the gap at 0x400000, so the hint is respected.
>
>   - After alignment: The logic searches for a region of size
>     0x400000 (len + PMD_SIZE) starting at 0x400000.
>     This search fails due to the mapping at 0x600000 (VMA B), and the hin=
t
>     is ignored, falling back to arch_get_unmapped_area[_topdown]().
>
> In general the hint is effectively ignored, if there is any
> existing mapping in the below range:
>
>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
>
> This changes the semantics of mmap hint; from ""Respect the hint if a
> sufficiently large gap exists at the requested location" to "Respect the
> hint only if an additional PMD-sized gap exists beyond the requested size=
".
>
> This has performance implications for allocators that allocate their heap
> using mmap but try to keep it "as contiguous as possible" by using the
> end of the exisiting heap as the address hint. With the new behavior
> it's more likely to get a much less contiguous heap, adding extra
> fragmentation and performance overhead.
>
> To restore the expected behavior; don't use thp_get_unmapped_area_vmflags=
()
> when the user provided a hint address.

Thanks for fixing it. I agree we should respect the hint address. But
this patch actually just fixed anonymous mapping and the file mappings
which don't support thp_get_unmapped_area(). So I think you should
move the hint check to __thp_get_unmapped_area().

And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
anonymous mappings to PMD-aligned sizes") should be moved to there too
IMHO.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hans Boehm <hboehm@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundari=
es")
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  mm/mmap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79d541f1502b..2f01f1a8e304 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
>         if (get_area) {
>                 addr =3D get_area(file, addr, len, pgoff, flags);
>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +                  && !addr /* no hint */
>                    && IS_ALIGNED(len, PMD_SIZE)) {
>                 /* Ensures that larger anonymous mappings are THP aligned=
. */
>                 addr =3D thp_get_unmapped_area_vmflags(file, addr, len,
>
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> --
> 2.47.0.338.g60cca15819-goog
>

