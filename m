Return-Path: <stable+bounces-158983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81571AEE56B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97875167EDC
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5928DF40;
	Mon, 30 Jun 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tck8KRU0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFC19C553
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303606; cv=none; b=A0CN4gmOMq3sYKQCDZenCbiGNCbwBRFXkGCR63ycStMPAuXjpu80zd1Qcg/XVGTEr1wosIWoBmeKMy6PEITNHyQLnDg/BLYT5WeW8q3PFHHIrZp0AZXt45J6ZFqY+OHYJv8oaufbnsNlOX5+JQOgjSDkrexypAj3J0skn5WSE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303606; c=relaxed/simple;
	bh=0e6PgTx8dXkUNY4Ue4f7PBylGohYdjhuikOGN2Z5xdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcjD3B0WTTKUQzIsFagUTrR0fvCGvo0JKxcWvzfC+RzLTRWVdL7V8WSoAejxEpF1TPyMsYhvjM+qAd14GejvahGNvfoFa0aYP4iVXL7+MoKlJ35IbRiZ07abONxh+CJ7i7K8N6Yl/fsFjyL8rbkOW5umq4AQ3COyNgFneb6G0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tck8KRU0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso666a12.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751303603; x=1751908403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jasc2yCLCtAmXj5vg6zKb7XPnw8WeWWLMn09XtqorQ8=;
        b=tck8KRU0w0PXyrYrayIv40pgM3E6fwhCCvnv45JjJMExvTp+FYN4XpLfKvPErQJLGb
         96K1LDObu7tPFRiqoODft3oAhC5abgViZldj7tf89PNlwukr9VQOXm+FP/aDsqHnyPyz
         c/TFkztLpLfoHqs4DaoyOY+W7ZUDdoex+gzdGfa/wmeEWm+UrLiQu5nmqBxbo846yYyb
         8MnKrqdObb4q6VkHCFBpS7CgTG1XQ5R8E0cbZeFy3NsBRdFbSbAFJvaWrdbtG+aWs4Ht
         326qZskhWE6yBHYUuV0/vq+QvWsmxxWX7Wht7clareGc1T8H1YjCpHpmg9Pn70Yyb7Br
         HIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303603; x=1751908403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jasc2yCLCtAmXj5vg6zKb7XPnw8WeWWLMn09XtqorQ8=;
        b=Ubt26KJ2UqNDi/nNwJfGOZzkST5VelZ2nNh3rTsfd6s6uQqKkRcVnig3Z/mDsRCRyY
         vtvEzoz25l1RlEkmaOd30MP5ZupzFhk/pHjyYq5mUk4fAiuflb+sSoRRl1t3j0/Iz/UW
         /3vH7kaItM1gP0Xfm+vgTEeboBzgNu5V/+EmaNwaiVPp10Jb2cuT1PfHzLPb4yQFj76n
         hVtSBxnCMFWMtxOOpydmm+0dNvAxz/vP/OoENMWph1fTK0K/f8h54UaEMzUFi9A3s3Vp
         jwMV50WurqIClJWmQRuoqsIEeJVNPs9jqeg9vbvnyrDChP3CGQE0ZU9j9rWl65USZGLP
         Rkpw==
X-Forwarded-Encrypted: i=1; AJvYcCVp3kUxhQfAdqPIIhPUfuVsUSlT9fzTilrE25S702bcLCE7VeosZ1MBd804atlpC1fcFEfVoGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7guLxW6g1zt6YfaEibakeuvDOkQ7Lm0TbR/omRg0jaY9Ikf7I
	2tzdn+4U9IPlYOJ3Cn1w5YQv4BKp6QqN3QW3+rTpzqphVnksw18kBBm2lt3G6Tx1knQfWKFt0Tl
	AjH6ihfF0bXAIoaJvoPmLiVSxzkG3GWqO0Zy+oMTg
X-Gm-Gg: ASbGncuEFwF349TJNsRIQffAHFnmrCGr93Cg9aSfiLDNF3KzdCWX+e7AKSPJoBXVbpy
	hIIIw1r/SFhJ3g7PxyQV1nckNni1PoBasPiT3DOk7VwvyDHn6Upatcg860ht2mrtooQf3aRzzkx
	Dbf8V96WFlSKbnqnLEIttamo1tYTaBc1SQvehR+Z6IXdpmslTCJxbL4RMRN/JoYhNEmpn9jxCK
X-Google-Smtp-Source: AGHT+IEzfT/ZhtvaiHES1w5oEMGGkR7Cyo6jq9vHat5tTCdSf7fpQ7ssJ8USfyRBT8RU2gzg9zUYeCitkt1kJFZnKtE=
X-Received: by 2002:a05:6402:896:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60ca584adb6mr177763a12.7.1751303602326; Mon, 30 Jun 2025
 10:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025062041-uplifted-cahoots-6c42@gregkh> <20250620213334.158850-1-jannh@google.com>
 <20250620213334.158850-2-jannh@google.com> <srhpjxlqfna67blvma5frmy3aa@altlinux.org>
In-Reply-To: <srhpjxlqfna67blvma5frmy3aa@altlinux.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 30 Jun 2025 19:12:45 +0200
X-Gm-Features: Ac12FXzfUXrkv-OKuAyNZTAWdJTtbngKItkU25c4MYi5jjRadoR-tibPVCecEWs
Message-ID: <CAG48ez26QWvqPoL-B0p934P9U6hDyGTUDjE6srGdUhBeCR2Z=w@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 2/3] mm: hugetlb: independent PMD page table shared count
To: Vitaly Chikunov <vt@altlinux.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	Jane Chu <jane.chu@oracle.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	Ken Chen <kenneth.w.chen@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

tl;dr: 32-bit x86 without PAE opts into hugetlb page table sharing
despite only having 2-level paging, which means the "sharable" page
tables are PGDs, and then stuff breaks

On Sun, Jun 29, 2025 at 3:00=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
> LTP tests failure with the following commit described below:

Uuugh... thanks for letting me know.

> On Fri, Jun 20, 2025 at 11:33:32PM +0200, Jann Horn wrote:
> > From: Liu Shixin <liushixin2@huawei.com>
> >
> > [ Upstream commit 59d9094df3d79443937add8700b2ef1a866b1081 ]
> >
> > The folio refcount may be increased unexpectly through try_get_folio() =
by
> > caller such as split_huge_pages.  In huge_pmd_unshare(), we use refcoun=
t
> > to check whether a pmd page table is shared.  The check is incorrect if
> > the refcount is increased by the above caller, and this can cause the p=
age
> > table leaked:
[...]
> The commit causes LTP test memfd_create03 to fail on i586 architecture
> on v6.1.142 stable release, the test was passing on v6.1.141. Found the
> commit with git bisect.

Ah, yes, I can reproduce this; specifically it reproduces on a 32-bit
X86 builds without X86_PAE. If I enable X86_PAE, the tests pass.

Okay, I don't know precisely why this is breaking, but at a high
level: x86 unconditionally selects ARCH_WANT_HUGE_PMD_SHARE (and still
does in mainline). That flag means "when we have PMD entries pointing
to hugetlb pages, we want to share the PMD table across processes".

32-bit X86 with PAE has 3 page table levels (pgd, pmd, pte); so with
this sharing mechanism, we'd have multiple PGD entries pointing to the
same PMD. I guess that seems fine.

But 32-bit X86 with PAE only has 2 page table levels (pgd, pte). So a
hugepage is referenced by a PGD entry, and it makes no sense to try to
share PGDs. PGDs not being shared page tables is also baked into
(looking at the mainline version) "struct ptdesc", which puts "struct
mm_struct *pt_mm;" (for x86 PGDs) and "atomic_t pt_share_count;" (for
hugetlb page table sharing) into the same union.

I guess I'll send a patch later to disable page table sharing in
non-PAE 32-bit x86... or maybe we should disable it entirely for
32-bit x86...

