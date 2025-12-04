Return-Path: <stable+bounces-200030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134CCA431C
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C4331DB9AD
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436DB2D876B;
	Thu,  4 Dec 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrqS/EOY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9F2D3EF1
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860945; cv=none; b=W6AVgBJr1DfPF4GyTQpbdYVPFqW9IYbMnn/82BldtzDsqd1ZncEcb6rDE+6GBADTVrG/TKlv8bYvLvRGL+pViv4F6p8lkVNv2PqnPyLZziRBwqgYThTn1VcHPYXclLXtYnROV/4g725bHq1kbX1zqLrM1bQjoCEovJrBZAmwWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860945; c=relaxed/simple;
	bh=5v9szWJGeDjjmm5BmESzhqY5NC+TLr6VLOtjJwfkMBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeUUr9ibUnMUFgnXzsamSuEQoOlrEFtOeVDHK1nRliwl1rIRromTVUlP7VbS6TSGrEtMWXKC730ADtORNeQDAvFexs6f1EdDct+1yBJwAFAqzsxjI1hZDCep03OwCENEPKvVlgJb+KuFO6Ld2cCBg6AfP0HFaNwc9zQFjDOa7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrqS/EOY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so8698755e9.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 07:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860940; x=1765465740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuUcWJogoj5Zy6UaFHm38nZ24EUypEOSoXHBrVrDbNA=;
        b=TrqS/EOYmJ7VRiFbcnv06bQKPhFw9RJJnIK3rMWTtmrtpetjix7grmJu23fFm6BQRd
         9AvFWIZDAG8/BdgyBYB5pNMlRKWdOB0pNTb31HcTFJA/ZYPEQCoiLal1ISovIQ49HP2l
         wSwNFuNa4AX5/Lw8onu7uGjhVWsmHwkfdzFo7iqMT06F5KAH1LqYyiKDZdSdFJtbjJXv
         wJWijpKiTwSfKQ85iW8U2tJo8wW6i5UKXfPlWTrlPLVvpSFuC5DIi0w5/8Z1GXw6UpAZ
         EqcxU41KUKiFZP2LdNIO6ACohM7NMpG9C6oxXUEHtK3/Amd/oBw8ACWuGkyRlR5CBcb5
         30Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860940; x=1765465740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuUcWJogoj5Zy6UaFHm38nZ24EUypEOSoXHBrVrDbNA=;
        b=XV8650V2zIxf4WuXgsrz2fOuqvei13BUiqHrZrVyT76br/XV88fMFjx+ZY5pFbY3CG
         qxigAg3mgV+ozR7pop9cveJHib3p+X+vhTD/dkhVguH6NykCXvtCy3l3G5sOOgfooEcp
         fCUFOF1/SYPvZ3yn4UmHQ+WviWe/aBuK1JJGoT5BX16ICVL7KGBdN2AXUvlQoRAi2S8G
         NwzV13NWz780/fSPGc7jl8VAHUJD9vZgizG0MrZ3Szrx/0M54EiAjnzwtyiIGq6Pd+VK
         6F8avBQ8DB+G9Ni58U4puLTFjDZnsXR0g/VwlLU/jjwlabuLo9oXlWJD28hTKcP97GO+
         ms+A==
X-Forwarded-Encrypted: i=1; AJvYcCV6yn17ORFXSR8YPKweoR499i/jRfu9Ee7G4IaSn2KIyNHwAdof1wxm/pO1H2pO5riDKjFR/oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjEuqDlkIsuUsrKQXka8p4kUD9jprJflI3fJRAEm+nZZwLjK+
	ktH+BnG++ODKhnp3+1nCAh0HFdJNIGlxsIAi8ymAw9ZUyVWuh9WsRDpJ50ghuMGhNulEbvL7eu0
	XYYNAlekdlkwuBmk1VV4bsG83sM7QEJQ=
X-Gm-Gg: ASbGncuarVFFCtKldo1wnwrva3dKXvPOBXcSxWQbUJVhCwl0xcmp0XxlNLNnqIg0rFV
	+J2o39WL9YSKuMxohYWpMiMyK2/YCBSacDC4oj16BcMjHX/VEn8sG1iTGTmksidloyeXd1OoDlT
	jJZJB3eVKISOkvo5eDBjCQEdle+alg7/qdps7FLxhXuF5H6vFrreveACjC61Dn6JP9VnmSVTKhT
	md3Sj68ElM1AHtN/Pgczs927oECosumUHjrpI5viF3LXpWWwbUacRksH2locu0mFLTSBU3dKzsF
	CpgPnepCDS05q079MppDiEdouX4o
X-Google-Smtp-Source: AGHT+IG8ZNIqkG+ruavtPJNLq/7WMSVxHMUln0iX3Nef6xsc00ik27GsBe6pzlL0EJfSOb1mXAdcaDwF7df//rfefjc=
X-Received: by 2002:a05:600c:4443:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-4792aee3a05mr61970655e9.4.1764860939413; Thu, 04 Dec 2025
 07:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128185523.B995CC4CEFB@smtp.kernel.org> <CA+fCnZeKm4uZuv2hhnSE0RrBvjw26eZFNXC6S+SPDMD0O1vvvA@mail.gmail.com>
 <2f817f0ba6bc68d5e70309858d946597d64bac8b@linux.dev>
In-Reply-To: <2f817f0ba6bc68d5e70309858d946597d64bac8b@linux.dev>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 16:08:48 +0100
X-Gm-Features: AWmQ_bmRB-ksejN_0Sq4l24XGjc90aU-UQEIYgag1iEv7qWtJahCQTEp5QO-pZ4
Message-ID: <CA+fCnZeizRWUFs2k_7wbhJ5v+LdD8H77C0vrP6jp52qp0G_6zw@mail.gmail.com>
Subject: Re: + mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kasan.patch
 added to mm-hotfixes-unstable branch
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Kees Cook <kees@kernel.org>, mm-commits@vger.kernel.org, vincenzo.frascino@arm.com, 
	urezki@gmail.com, stable@vger.kernel.org, ryabinin.a.a@gmail.com, 
	glider@google.com, dvyukov@google.com, dakr@kernel.org, 
	kasan-dev <kasan-dev@googlegroups.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 2:00=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> December 3, 2025 at 23:18, "Andrey Konovalov" <andreyknvl@gmail.com mailt=
o:andreyknvl@gmail.com?to=3D%22Andrey%20Konovalov%22%20%3Candreyknvl%40gmai=
l.com%3E > wrote:
>
>
> >
>
> > >  ------------------------------------------------------
> > >  From: Jiayuan Chen <jiayuan.chen@linux.dev>
> > >  Subject: mm/kasan: fix incorrect unpoisoning in vrealloc for KASAN
> > >  Date: Fri, 28 Nov 2025 19:15:14 +0800
> > >
> > Hi Jiayuan,
> >
> > Please CC kasan-dev@googlegroups.com when sending KASAN patches.
> >
>
> Sorry about that. I missed it.
>
> > >
> > > Syzkaller reported a memory out-of-bounds bug [1]. This patch fixes t=
wo
> > >  issues:
> > >
> > >  1. In vrealloc, we were missing the KASAN_VMALLOC_VM_ALLOC flag when
> > >  unpoisoning the extended region. This flag is required to correctly
> > >  associate the allocation with KASAN's vmalloc tracking.
> > >
> > >  Note: In contrast, vzalloc (via __vmalloc_node_range_noprof) explici=
tly
> > >  sets KASAN_VMALLOC_VM_ALLOC and calls kasan_unpoison_vmalloc() with =
it.
> > >  vrealloc must behave consistently =E2=80=94 especially when reusing =
existing
> > >  vmalloc regions =E2=80=94 to ensure KASAN can track allocations corr=
ectly.
> > >
> > >  2. When vrealloc reuses an existing vmalloc region (without allocati=
ng new
> > >  pages), KASAN previously generated a new tag, which broke tag-based
> > >  memory access tracking. We now add a 'reuse_tag' parameter to
> > >  __kasan_unpoison_vmalloc() to preserve the original tag in such case=
s.
> > >
> > I think we actually could assign a new tag to detect accesses through
> > the old pointer. Just gotta retag the whole region with this tag. But
> > this is a separate thing; filed
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D220829 for this.
> >
>
> Thank you for your advice. I tested the following modification, and it wo=
rks.
>
>         if (size <=3D alloced_size) {
> -               kasan_unpoison_vmalloc(p + old_size, size - old_size,
> -                                      KASAN_VMALLOC_PROT_NORMAL);
> +               p =3D kasan_unpoison_vmalloc(p, size,
> +                                          KASAN_VMALLOC_PROT_NORMAL | KA=
SAN_VMALLOC_VM_ALLOC);
>                 /*
>                  * No need to zero memory here, as unused memory will hav=
e
>                  * already been zeroed at initial allocation time or duri=
ng
>                  * realloc shrink time.
>                  */
>                 vm->requested_size =3D size;
>                 return (void *)p;
>         }
>
>
> > >
> [...]
> > Would be good to have tests for vrealloc too. Filed
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D220830 for this.
> >
>
> Thanks, I will add test for vrealloc in kasan_test_c.c.

Awesome!

But as mentioned in the other thread, let's first implement a
standalone fix for the original issue (that can be backported) and all
these extra additions can come as separate patches on top.

Thank you!

