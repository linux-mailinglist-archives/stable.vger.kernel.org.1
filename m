Return-Path: <stable+bounces-134869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E39A953CE
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5517A189464C
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37B14883F;
	Mon, 21 Apr 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgTlLR89"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F433086
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745251341; cv=none; b=dQcaZvc6aoZxrh+F4Qti9AnE2dfUsO/l3HEg8A8vWfVUOPPUs5V1Gw3zJU4X2HGd1Ul0RvjaO5Xz4Vop1GNlrV5T3/4D4/ZjV+Uwf8kZz4U2W+BP74nsY756uHkART+0KJ3n3t74xcEye/LguXeILtDFajyDmFnCRQdesivRJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745251341; c=relaxed/simple;
	bh=QVRgx1cG71n1EbvoR1X7V3DYQHHXyK5yZ/v4qTIRSfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUuWp3l1F4jf15a6dcvCl1TSGlgBaGzyLIH4ZEtdPTyo4fm7Tr4szL+nunGBtCumFlftH1KSbWojLcf2ExtdhaZdwJ7AbxXi8JU9uYnLdDalayHPr/wQFIzxae+5g+Fc/dvyGNtzJn54Cd/C0FZPkAOCHMq3Bq2pS8zM2YoCgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgTlLR89; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4769e30af66so1262821cf.1
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745251337; x=1745856137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwPtecf76ZYadR3YRRgC+46gtO+vSJrvyRaWH/6/w64=;
        b=UgTlLR89COHTrMSW21bjsVchNL+fd4PJNvFVl69mT7OwXFlBtKA4CbKrdqpbaYwAao
         JudDYxWxObIb1cxrfkbaJ9elm5icHsgKbjJxY7MD54qDr+xgvdIOcm9jE8dmWqq3llvM
         kB5WSqyCtp3uyUJpZO+6IgsjbXD5kcN9X58FnUBN7Tl1ViTHk7LUS2Tm0aGWC01EclWJ
         oky6aHhIFBJXLxGUGWrdEZGFQ8br/zjPzeGEsgC9+Y6e88ZrKt2/RHObMXXCHUaXn9N4
         caidEhfg+pREVVGtOyNdYgXqo99j+BlQwzGLm3jqkHSAW2nkbz526VGPWwgqF+s2IYWG
         DlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745251337; x=1745856137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwPtecf76ZYadR3YRRgC+46gtO+vSJrvyRaWH/6/w64=;
        b=I0OMscwmnVsLJTVx/ZYU8i0wco7UngFQVcDic1P6C4214XZjPrbhIRcw5jKgyGF4Zv
         hHBx5yKaqMsG3QALEdIDKFmTHlWgZzaxUuTV+2caTwqKV24JWBaxh7oIyZ1vdG7JbesE
         dRkSufad/kfkHuGaX/2cGoSwdE+Tf6wzjb9ILd322+eTketMe5n6pKMYRs5i7inFcnNj
         njeiH7UXqtAHlXzhveU7pu18xeqnw075FKmc41baOq8Xwo88LKC2raf0E4TawsO0uiIH
         clPMawzW+iJz7I0lMFpMhfyWjtILEjMAQ5NqXIOL39doQlS7S/fP8S0ko1ih+nVFT7M7
         j7FA==
X-Forwarded-Encrypted: i=1; AJvYcCUm8y1Meu71LwTx3o48lSr57yQ4xnxulacxZsKPlss+rLNOXW0I16AjBnu5A6vNHkzdzmNrdzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRg6p4Polj1yHBoHlrJ9UZyZFiR7rATHuBGPCUR3TzpoApQPp
	QJbBxYLQOQjuyEeBp8RNDbgx/DEdILIV51m+gNiwJEjx59JLrp0+WAzxbZEnKYI2eEuCzjqA8j/
	+rfwzJ497Y1dHiToREj6KBZpum6JoiiqF7oEj
X-Gm-Gg: ASbGncvvpvN6ijglbW9qtq05sTMBRdsyW95wLZIm2ESUg9n6IUcXVKIQc+rlqQ7OyHm
	nTiU3PzOc36L8wLyBvZLBETQeNggE0oFSusbTrAdOAATLFG232qespwQuNVVGu1cwdScT2zizIw
	TrtbIrQ/s0TOdutgW61NyB
X-Google-Smtp-Source: AGHT+IFcrJIudMQwJuhhosU6XokIESjG4OJj8NhYiN8xk3grHh804D2H04q6KbIx6961hwYUS1e4YdDhHpSrKM4x5U0=
X-Received: by 2002:a05:622a:1184:b0:474:bd1b:417b with SMTP id
 d75a77b69052e-47aeb25035bmr12192481cf.26.1745251337383; Mon, 21 Apr 2025
 09:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
In-Reply-To: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Apr 2025 09:02:06 -0700
X-Gm-Features: ATxdqUEERxAN1-oqZuuaQ_rO7ijRW7H4bum1OhOTCPYXUXueTMh6_U49FMFe7hQ
Message-ID: <CAJuCfpGwspnceQ5oq_ovViHnawcVCkM1pKawJGckfKsvK1s_Aw@mail.gmail.com>
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: cl@linux.com, rientjes@google.com, vbabka@suse.cz, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, pasha.tatashin@soleen.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:52=E2=80=AFAM Zhenhua Huang
<quic_zhenhuah@quicinc.com> wrote:
>
> When memory allocation profiling is disabled at runtime or due to an
> error, shutdown_mem_profiling() is called: slab->obj_exts which
> previously allocated remains.
> It won't be cleared by unaccount_slab() because of
> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> should always be cleaned up in unaccount_slab() to avoid following error:
>
> [...]BUG: Bad page state in process...
> ..
> [...]page dumped because: page still charged to cgroup
>
> Cc: stable@vger.kernel.org
> Fixes: 21c690a349ba ("mm: introduce slabobj_ext to support slab object ex=
tensions")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Tested-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 566eb8b8282d..a98ce1426076 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2028,8 +2028,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>         return 0;
>  }
>
> -/* Should be called only if mem_alloc_profiling_enabled() */
> -static noinline void free_slab_obj_exts(struct slab *slab)
> +/* Free only if slab_obj_exts(slab) */

nit: the above comment is unnecessary. It's quite obvious from the code.

> +static inline void free_slab_obj_exts(struct slab *slab)
>  {
>         struct slabobj_ext *obj_exts;
>
> @@ -2601,8 +2601,12 @@ static __always_inline void account_slab(struct sl=
ab *slab, int order,
>  static __always_inline void unaccount_slab(struct slab *slab, int order,
>                                            struct kmem_cache *s)
>  {
> -       if (memcg_kmem_online() || need_slab_obj_ext())
> -               free_slab_obj_exts(slab);
> +       /*
> +        * The slab object extensions should now be freed regardless of
> +        * whether mem_alloc_profiling_enabled() or not because profiling
> +        * might have been disabled after slab->obj_exts got allocated.
> +        */
> +       free_slab_obj_exts(slab);
>
>         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
>                             -(PAGE_SIZE << order));
> --
> 2.34.1
>

