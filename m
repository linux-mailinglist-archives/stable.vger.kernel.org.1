Return-Path: <stable+bounces-188894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9CBFA1F0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1B04F7914
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786071DA60F;
	Wed, 22 Oct 2025 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8s77ln9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625331DFD8B
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112178; cv=none; b=Q1arM0WD3GJMaaBUo0s69n2B8UMwxj9gHf5shCFvBDy0/r6nmChGPh0qqYkw57ZBRsbJea+gJyJosHYtl+hkTX/Cik0LDTFqvaIsTBqvYfWL6bmcBsOKdxJvFXabYQpbD/jZzQl7gQcOEy3RZceuFEXZhkOPla+JkNK8OVI/HnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112178; c=relaxed/simple;
	bh=RPNiAenH8YGbjYOgBgh8lZgLycKBqNtudWB2/wBr7PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O81MZPo2H1+8lAuWQFj1XrHyg4SoKKOXy6BOPhtx1DjpuiwvNsCAHiCy7j+PJdWj2foM+r39keE1ruQnKnekoJquKtAihWQTX3CN025uaQjv/6OoaGz0Fc2qvzNLHp8IO4+ZUjtvF0jyTwmrgE+rngA4CR+CZFsC9CnbERE4x+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8s77ln9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso11775925a12.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761112174; x=1761716974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF6I12cmNwQJIE2Ooh/PoCg5Zdy7/MLhY3n+XRHHRpU=;
        b=C8s77ln958D7otPiiEz+wG/FSu6f6N9Hvt4cds+5h7ENAvUcnaAIc5GbLxgzW7G8tE
         EOCFJaXwRcn93rr001Qi+Bl23eckO0EmNelUtp7VVHRCPGtZDACVtog/S+9z3rOsngvb
         lsYWWJOgxZUAWPHYO7lGeVI0QFtKQC3tWve4sljeylpdWWXCR0SqttWmD+yP/PDLwqPF
         eX7sfB8KxkeM0F0wGm8RyN+MOXGNKpWDV4lcSECVX7AYKGPKYtik6+GUrEJIAc0nVAMk
         ZBh0OmN0kpbzTAclPLEVO7F80oGdq9zc90/i6SPVDYWtusfeG8rJhkfkpCm5ltXb6Txp
         KVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112174; x=1761716974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF6I12cmNwQJIE2Ooh/PoCg5Zdy7/MLhY3n+XRHHRpU=;
        b=EojRebkDYVekihZlka7oxnbxZnDzPdGUp2JlKROL/OZ+Jp3ckIc3u6VDbldJLMY50x
         35MzllDGI8pF3smzyZ9wr912Qf5rC9mzwQxIoumv9u7Aqv9juIPEi+b4Nj/rXxLsZF+x
         HUSnH8eFWxZchyGy2v/n0iudwa8Vh8/INll37wREFIqk1Ac7TG+i4hhu4/VMz67I6Rvl
         DAtzXxQVLCtgxuIMoNvxkAbzfsPdBgtO2D1luv/KBTDUyYBtjnTS+gtBEjCSIFZb7+S8
         a3xRAz+UPPOpxhY/03jrG/yCsIUWi6zwbqSNXrZE1a0FZnn+HSd4PlRF9Pfyr1hKCuav
         v69A==
X-Forwarded-Encrypted: i=1; AJvYcCU/MXkxCdpnKenTcFAbm/9/eJ1fwBY2rVq/nz78op7p2uqZ8Ct7fkakv+QRvbp4dA7FMZvhFpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalpwzA0Us2OFH2BVQ67EIBrcdllJSs8B4tzaTvmMiGsN+0got
	JnBJfOifAFDcYseg5XBpf7oti+fregUWdqXcWj+0TT81tjbGWqhkoxlWy7ursCQRbDv2KnPLUtu
	+MTq3Ugla+2dVwEr/crLqPN3/zIVQfOc=
X-Gm-Gg: ASbGncspkMMM7RrDTc1dghPfE/880lCDtp7Jo5nmsgh2IO5PR6cMy2K972Dlk7OKNum
	qVHf/AvHmro6DxZgkNmyi5vzD2d8kGVgIbgBb4hbppUyteUhvf5pJAz5LTj4wW8plDbkJwGkxUP
	RDhOsMKCNlQ57JCPusvhgpOZix/jvXJtRu7JuDHNIuXEYoXDvKk4MbYdkj9BhPWucrCyeNgD+Lh
	95AGRfmCPDsZu+M69Et0jEN9uovNEpONh2uUCVIMi9SbydHYD5bjEiG928Z27Nh2qQHIYM=
X-Google-Smtp-Source: AGHT+IEL4L/n0/KZ2//izEt50x/P7vjrecEoRquGYRoVdQ4a49sx5DhBJ0rYUtgsnqQLisHd/Or3m5ShhudEHx4+ThI=
X-Received: by 2002:a05:6402:5189:b0:63c:3efe:d970 with SMTP id
 4fb4d7f45d1cf-63c3efeee6emr14892034a12.31.1761112174303; Tue, 21 Oct 2025
 22:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021190436.81682-1-ryncsn@gmail.com> <65f4dd0b-2bc2-4345-86c2-630a91fcfa39@linux.alibaba.com>
In-Reply-To: <65f4dd0b-2bc2-4345-86c2-630a91fcfa39@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Oct 2025 13:48:57 +0800
X-Gm-Features: AS18NWDTFF1efA6O66Kmu5sZvMNxApkc4VVj3WyF2eIjSrA0fBYB7cddYTfIxRE
Message-ID: <CAMgjq7D_G=5bJe_Uj11sHV2qCyu-Z-3PZu7QuZyPEhuFiE63wQ@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem: fix THP allocation size check and fallback
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 9:25=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/10/22 03:04, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are some problems with the code implementations of THP fallback.
> > suitable_orders could be zero, and calling highest_order on a zero valu=
e
> > returns an overflowed size. And the order check loop is updating the
> > index value on every loop which may cause the index to be aligned by a
> > larger value while the loop shrinks the order.
>
> No, this is not true. Although =E2=80=98suitable_orders=E2=80=99 might be=
 0, it will not
> enter the =E2=80=98while (suitable_orders)=E2=80=99 loop, and =E2=80=98or=
der=E2=80=99 will not be used
> (this is also how the highest_order() function is used in other places).

Maybe I shouldn't mix the trivial issue with the real issue here,
sorry, my bad, I was in a hurry :P.
I mean if suitable_orders is zero we should just skip calling the
highest_order since that returns a negative value. It's not causing an
issue though, but redundant.

>
> > And it forgot to try order
> > 0 after the final loop.
>
> This is also not true. We will fallback to order 0 allocation in
> shmem_get_folio_gfp() if large order allocation fails.

I thought after the fix, we can simplify the code, and maybe reduce
the call to shmem_alloc_and_add_folio to only one so it will be
inlined by the compiler.

On second thought some more changes are needed to respect the
huge_gfp. Maybe I should send a series to split the hot fix with clean
ups.

But here the index being modified during the loop do need a fix I
think, so, for the fix part, we just need:

diff --git a/mm/shmem.c b/mm/shmem.c
index 29e1eb690125..e89ae4dd6859 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1895,10 +1895,11 @@ static struct folio
*shmem_alloc_and_add_folio(struct vm_fault *vmf,
                order =3D highest_order(suitable_orders);
                while (suitable_orders) {
                        pages =3D 1UL << order;
-                       index =3D round_down(index, pages);
-                       folio =3D shmem_alloc_folio(gfp, order, info, index=
);
-                       if (folio)
+                       folio =3D shmem_alloc_folio(gfp, order, info,
round_down(index, pages));
+                       if (folio) {
+                               index =3D round_down(index, pages);
                                goto allocated;
+                       }

                        if (pages =3D=3D HPAGE_PMD_NR)
                                count_vm_event(THP_FILE_FALLBACK);

>
> > This is usually fine because shmem_add_to_page_cache ensures the shmem
> > mapping is still sane, but it might cause many potential issues like
> > allocating random folios into the random position in the map or return
> > -ENOMEM by accident. This triggered some strange userspace errors [1],
> > and shouldn't have happened in the first place.
>
> I tested tmpfs with swap on ZRAM in the mm-new branch, and no issues
> were encountered. However, it is worth mentioning that, after the commit
> 69e0a3b49003 ("mm: shmem: fix the strategy for the tmpfs 'huge=3D'
> options"), tmpfs may consume more memory (because we no longer allocate
> large folios based on the write size), which might cause your test case
> to run out of memory (OOM) and trigger some errors. You may need to
> adjust your swap size or memcg limit.
>

I'm not seeing any OOM issue, and I tested with different memory
sizes, the error occurs with all different setup.

If I compared the built object with the ones before 69e0a3b49003, I
can see that the build object is corrupted:

Compare using hexdump & diff on any .o generated by gcc:
--- GOOD        2025-10-21 12:17:44.121000287 +0000
+++ BAD 2025-10-21 12:18:01.094000870 +0000
@@ -3371,425 +3371,7 @@
... <summary: whole chunk of data & symbols missing> ...

GCC compile didn't fail because the problem occurs when writing the
objects, so instead LD failed and not due to OOM.

The reproduction rate is very high with different setup, not sure why
it didn't occur on your setup, I suspect it's related to how different
gcc handles write (not fault)?

Revert 69e0a3b49003, the build is OK. 69e0a3b49003 isn't the root
cause but triggered this.

The minimized fix posted above also fixes the problem just fine.

