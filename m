Return-Path: <stable+bounces-192977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C268C485AF
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5843A58E9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF82D7DFB;
	Mon, 10 Nov 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drC5W9vK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF02641FC
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795981; cv=none; b=ev3RNDnJzz6CRmB5VOX5tLVZqKgKktdoProc92q8QMUYW3wae+IkqmvdRWURzQn+QoGellAKq7FklKQ7W4X65uC18K/x8paQ1vM7W0mgfQAmjy4dZb4RBN7Z3ZYablcB7W/XyOQZpwW0/wLGDIRerDzarBSAVxBVfAVpWrg9ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795981; c=relaxed/simple;
	bh=lavqjS8uyddXCf50slP6/gj/LovmQ9D/FO5ATpZAsEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvsMOay80eVUkEpNlKAeBmp1PVU5j0QV1zw5oG4+T3EZ7QPAiZCJ3lRr1rlprGKdYr6phPhbI3OfaRH6YyuS/RjMqlF+TIxksmf+YLe6FmxFd276I+diJKFSCWm2dmpqkmfAkxS8vJfCckUwWzZdPFTGExlR+fN6Io1ZZJBdpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drC5W9vK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88249766055so20047496d6.1
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762795979; x=1763400779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auNNYNeszcnW8UxlPsUXlu6HqCk9VFPDDrt3cDy7QDk=;
        b=drC5W9vK26wS4dcrGuI42zlNJSLMOtQMFlg8oSLywXMtlPMkkApgFrPue0PXmqUiLV
         YzCd4G3f72x27RuXRCx8GznVrv16dLie2W3urfbdLr3HTrjpoKLc5jRlurplF0+dNy9C
         sOb9bZY744MQzLXc50Z9dHt5kq5eNt0s77cCnmLoIWRaML/4seD9LSNvetyTLu/Y7ln+
         Su111UYA1BUVwPFlUg8A/y7xMlWfw4Mk1LGxzgcjTVUT8RsCKVQFiN3hL99/lzKurYvx
         l9IXWW230Ku5+eVNAasqEzOAhkLfMCrU81qMAdcafPQyeWTI+ET+4Rrf92/Gm1cqjLIv
         eTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795979; x=1763400779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auNNYNeszcnW8UxlPsUXlu6HqCk9VFPDDrt3cDy7QDk=;
        b=Syw5deYSBlvgdzCMWFaCVggCP56p/3no8+6rJtCGV7KPjv5hh5TiRlO5fkBMxAcaCG
         y5/lW7M3nRP44beSzXopJeOVMTi7QNHDb02lYGB8pPLYkV9sgZST9ikkrJEk0utxWtaG
         0KvZQAgdQIsksZEr2RNqDFhA6YGi3T6/tfrZ1kU/PhGmPFnvfeSaJsbRDv1dUG11SAZy
         V8nBaQC89MfJTR4uRFeLGCfHVD/N8zoMcuyOcVF3u5C/lOG2gGxnJ1LkNC1pUI7Q1k19
         wkq5Bz8VpVuh2xHfwIsZE/179jOAJ2BuHtXDBUqV1JcEBx+7irOZY1VF3t/CIgOncV4O
         HamQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSvQFBCzwsSK40FPr/HEmlS3uLi2sd7KcLECvgkJ5roEsxMoHNVVYGkZQCAuDUfPm7fLuwSWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RCinjkI5xL8gUo2p5h0P+IgthNLq/O5N5hn0gQ3aMRLCPzsQ
	KQ5/KlUY1huQyrJ+ldLeEkPwiyIlmhcmS2yYHK5l48vhbkU89SBoUlTM1daCOAi2RQ6jwnWBE9U
	2c9T7tJNW8xSOMB3exY5io/xfF0HQPTKaqN+ofkA/
X-Gm-Gg: ASbGncvrhZpPyF9mJVg2X9JHB1BcjK9tHC+5aQecp9SH+dbNFHbmGcrLnTFXC+C2P0/
	a09DMT2XdjX5tSM0xxPHaOuHz+ojopZq6s3eVHFPxO+jr9MUCZuWaTJj0i9ZETveQK/yOE/BqHV
	roAFbCjQGDIyTvByZebJ1XHyCnTP7fS+Wg0JR+yq375gE3e4XhjyJ9OVAoK3v6Mg85QTLlfr62G
	9I2TjulWj+yk/EkJowvflsErXs1CXkI+9mxjiY+w0VdwMJJG1ZGzsMzMIdUX4/rnZCzXekiEAPI
	JNp6mDo1ePb/ym0=
X-Google-Smtp-Source: AGHT+IHeuRC7ChrdFjjxvcWC3ajdMKHJ+Azj7LDyTH5BCluSFj1o6p4ZSWP6EGrRrokOPiEV3z2rvlDUhI4wexrXKNM=
X-Received: by 2002:a0c:e00a:0:b0:882:4660:3724 with SMTP id
 6a1803df08f44-88246605291mr69808466d6.63.1762795978283; Mon, 10 Nov 2025
 09:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <fbce40a59b0a22a5735cb6e9b95c5a45a34b23cb.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <fbce40a59b0a22a5735cb6e9b95c5a45a34b23cb.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 10 Nov 2025 18:32:21 +0100
X-Gm-Features: AWmQ_bmUvxxbg_c-XB1Dy80QL57feg4coPRIZHNTl9ervff8Rzi8S1pGrWY59Fo
Message-ID: <CAG_fn=Wj9rB0jHKT3QKjZsPYce1JFcb1e72QBOBP52Ybs3_qgQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] kasan: Unpoison pcpu chunks with base address tag
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
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:05=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> The problem presented here is related to NUMA systems and tag-based
> KASAN modes - software and hardware ones. It can be explained in the
> following points:
>
>         1. There can be more than one virtual memory chunk.
>         2. Chunk's base address has a tag.
>         3. The base address points at the first chunk and thus inherits
>            the tag of the first chunk.
>         4. The subsequent chunks will be accessed with the tag from the
>            first chunk.
>         5. Thus, the subsequent chunks need to have their tag set to
>            match that of the first chunk.
>
> Refactor code by moving it into a helper in preparation for the actual
> fix.

The code in the helper function:

> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
> +{
> +       int area;
> +
> +       for (area =3D 0 ; area < nr_vms ; area++) {
> +               kasan_poison(vms[area]->addr, vms[area]->size,
> +                            arch_kasan_get_tag(vms[area]->addr), false);
> +       }
> +}

is different from what was originally called:

> -       for (area =3D 0; area < nr_vms; area++)
> -               vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->add=
r,
> -                               vms[area]->size, KASAN_VMALLOC_PROT_NORMA=
L);
> +       kasan_unpoison_vmap_areas(vms, nr_vms);

, so the patch description is a bit misleading.

Please also ensure you fix the errors reported by kbuild test robot.

