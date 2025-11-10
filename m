Return-Path: <stable+bounces-192972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E33C481D8
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3540188EEC6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010933032F;
	Mon, 10 Nov 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXXf6n9n"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC233031C
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792859; cv=none; b=TUUNYrfvA2Sw34M0CrP5qYDU70mEnW4GzJs/BWcU3VvHhZQX1xMya6K7MUqmj1PTdL6XDIQ2wmh9dRZVnp522SL6D0+woCJ+naQIMWv146ASbdgaA4TYaBh2CTmSPsHQqe8sCTbXS43YowDF5LdaiC86jGxZPSc0pvrYsCIhckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792859; c=relaxed/simple;
	bh=Nn93pG9GTk907Z5oYvQqtvL4mNR0sTn6esBD4Jp2XFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCRJEPM8j8RUmupZgw9bGw/gGINAoM3z+fFIvL3RmiVEdZULMPXbvMQGj0O1mTAEvIbz+GbylGGKWE+wl9YjcYoWeyDV/O6xTKjCm28JTczoUynDA+RJvip1w0Cbm5p1pnnXivo6M2m/fJiTu8HlV/UaZBlakxxrjRjXt5YL+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXXf6n9n; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed9c19248bso26336851cf.1
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762792857; x=1763397657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARP0s0P8t6lHLXGPK7oqG4hn2hPk4JBv7/AQ4HrLq7Y=;
        b=IXXf6n9nhmSnymPWmqhjSmnDiR9Up4GTSKZzRllIwT71BVMh/tG5PHzDXfE8YDO62P
         im2WhPVKJmn1o9X6hlJd21VkAsg4IhHJKDYrgMVzClVLABJHJmHRx+hlwsN90izo5jGx
         B+pZGOV25MXrrP2znz2IvIYD4uL4+agnoMF9i7Ec4johf9cye4TtsfJSgJTyPow6+Ap2
         ee6J3qUJ/BirQ83jzYU1221z66ZbqKN1q/Zy1nDzded68tkiuamw4GKbfide35oSdjlu
         60YLCTC0EcOvqP4PbiQZfmBos3Qs9HgVy5+biHMlixcETr2qxfBFilHO7Yqe4dMxBgIE
         DEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792857; x=1763397657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARP0s0P8t6lHLXGPK7oqG4hn2hPk4JBv7/AQ4HrLq7Y=;
        b=TC5klKBxe6mii/3E2o/aC0ZoqXEVDYe4hpDLKM0kYapEWxeqCNth2jeJBfh6hT9f7w
         X0pZyJ0zIzZJsqbNq+86JEhP7lu8KQhlobBNckKLxSS/mKtucAPjo+gyKBG+57yD9nxc
         io2aAeqZFPEePLgsmMFkpKoGsXgLte3de/v096iUuzCAeQnWGWhwozzC1DsuMkx/XW5q
         M1cRyxvvLKt7Hl6Dwv2Cbyth/ordvOPd4TWFgd3TJo91z5z33XVOh9Mmo1gJoKvOYSVH
         HFq+GPTmB0llRbt7ADrqGl8ObjxY7f4aIdHu6i5leZo9YgS5Z2FoejZYjDX16z72yiin
         agcA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGAW/QJDXfWBJ6PWSJ6Jos3obrm1UQGzsN8tyVnT3ZAlCpa80GFOOCRhQcZAnr0OscUONYD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gYtIPK3YVJ0G7gkiF75b+ijO+7aBXK0MKmdI7Hx//Dg0wqzt
	zLrcv8ybuPvluRKd3HD9iJQviRZVJUUbxhMXeFX/huC31nZLtbJM/OXZTBa+qIEj8pg4NJ8qVmp
	d6xgNnl5Xyaka5Yrt5QFhUyIX9l0D0juaaHzUAcFp
X-Gm-Gg: ASbGncvCqndkUT/0j61nAqqFG7F9wNNurwZe4l+NWZGvsW01Ls2hRjl5TewGrLA57Nf
	Yqea6lVGPnlR1SuEdORkQ+QzZMVAytnNlOkjNE+Qd7obd7oiYxsY0ZgapMAeRZXjMAZtia887uX
	Jhkr/GYJHFpoR45IbS/8eXPT723rjEaBY+ZJe58PGGmjXhuT8gMk+C2Nb9UalyHuQCdjfyooRls
	YEMAOnRf5kWWJn/z45AfBAawcRiTKQsRybZtTQ79wOff83aICZb5YuYojUjEOapooYkByPfLrN4
	YYcNjyO3lJokQhbomOrrzXvFuw==
X-Google-Smtp-Source: AGHT+IFXtIVYv/1akorIwGTU2TyeYWKo/ZKjasuLxC+KldJLVH++s5nwoozhcb1g1AswN8A4ZgMNuJJXiz33fQE7EOA=
X-Received: by 2002:ac8:5d05:0:b0:4e8:aa15:c96d with SMTP id
 d75a77b69052e-4eda4fec971mr97364671cf.55.1762792856275; Mon, 10 Nov 2025
 08:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <932121edc75be8e2038d64ecb4853df2e2b258df.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <932121edc75be8e2038d64ecb4853df2e2b258df.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 10 Nov 2025 17:40:19 +0100
X-Gm-Features: AWmQ_bmi0ifqdxD1pRga8rXt1izLseEvw-FOTscdlGLXMffgSbt_R_kuG7tm2tc
Message-ID: <CAG_fn=V6pbNdN3w0Jr5rCL=M27-bOBt4AK8rB7UvvwT=3g4m7g@mail.gmail.com>
Subject: Re: [PATCH v6 02/18] kasan: Unpoison vms[area] addresses with a
 common tag
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>  void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
>  {
>         int area;
>
>         for (area = 0 ; area < nr_vms ; area++) {
>                 kasan_poison(vms[area]->addr, vms[area]->size,
> -                            arch_kasan_get_tag(vms[area]->addr), false);
> +                            arch_kasan_get_tag(vms[0]->addr), false);
> +               arch_kasan_set_tag(vms[area]->addr, arch_kasan_get_tag(vms[0]->addr));

Like set_tag(), arch_kasan_set_tag() does not set the tag value in
place, so this line is a no-op.

