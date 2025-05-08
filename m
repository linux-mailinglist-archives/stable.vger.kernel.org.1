Return-Path: <stable+bounces-142910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747DBAB00FB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848CF173C31
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08EA2857DC;
	Thu,  8 May 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxcE+OWr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50C221294
	for <stable@vger.kernel.org>; Thu,  8 May 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723899; cv=none; b=V0wjKuNU2uEMqy2A6CZ1p92/hizwCjsU2dAx4xGju99XNb4XsanIQlYFTKOSi9rhHEozMPrb92S0uebLyWIvWr+MlLEl9sER7T7dPVUFIaU25XXGRri9fhPHselahPQDVc3KnBqc3Cv5n6PTckxv6g0ofF/pmS1rXY4dwWlpUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723899; c=relaxed/simple;
	bh=Yfz9hBAyOqe3HiefHbXrJanjbqQvgloTrumbHSp58UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yild+WEIMavHEd7MXHL/XqHXdZzPg0IiU0WX56QwU/TebUuJ+OCEe4UMbJtuK5A8MnmWcM2Ecpa6APQKYhwYbxs+9pTVUvF8WuCRv68lpdlACQJG2pb/jQ6Gg3jlyh81TjQNuGEoXtROGs5Fb+y4DJY5Qw1B3ey9h2nXd9sYu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxcE+OWr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47e9fea29easo5901cf.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746723896; x=1747328696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrV74FfvJs+nm8dGPS+u5XEtfMzjV3NN8v4vNf4EC4M=;
        b=PxcE+OWrNpa4nitIDJOKpQ18zMRTp6vjhXqJiENIrtdtNOXc8HHCWGzCWS04LSWpHf
         sIbvdWCxj94ehz7szMd+bXXzUyRxUtfH/BtHEPzKGCPNNgE72dtSSKLb6ELkm6CwmNVD
         o4pexq5RuYKFln7+5U0hkzAGblmzQttAGbvoPV8lXcXJ1uk72opngayreQWfHmI0cHFq
         g01OjE2i4hYgV9dIxr87GGpRLQZdy9UCJ9mSkLmjun1jxrjCEwidMwbWvbPPwtg7doaI
         Dz+AqSCAL8iBCmzLC0DdfSC1gKS/0gdYm0K8AgARxV2EYACFwcnb6v390Nl/JDt8rz0h
         UhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746723896; x=1747328696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrV74FfvJs+nm8dGPS+u5XEtfMzjV3NN8v4vNf4EC4M=;
        b=uhC3JuOmfqfb6cJVeRyemgn8fAUdg6aJZuiXxwYrCutnn1J1tSWrMwn1YNI/Xvg68T
         qNxY1HFF8Q3aZ3SWzLWl5QOOzi0r7kcSeKs0+VyyftdV1IXbu4EBCHMtGrE57tlrUwmk
         OJ9MJiIfCVDCzGYukV9vMMSRzaXmpiN6S1nCMDivyj4B19aCU/942TWdQS0+dc6fzJOP
         udKGBxZUd/o6tYHgwEWV9Y6oIxRdKf9IHcPuTlzJjREFzx26v7+63unBtYDTihG2ThY/
         /ER85gZ6kSmFX4Pc9PNI8AhPu57bxTA518YNt/hiI+zKvWUssvzFkDZWlDWyi+o+55DD
         xhzQ==
X-Gm-Message-State: AOJu0Yw1E2tdjM+IqN0TVs55+EF1tv2/EAWboC/cIWlEx6HYbsVLiUAz
	wsWivTGArT8+p/9Ws72KjoTF8Frz+UxKqsthcIhwMMZP7G2QQAn2oTqWQzXwwdJK2SLwEUx3ej9
	eetushAANjsnj1AqfFthj9Q/Ub0bTh6SxpTftKFagFDuaxQwa0mVSBLY=
X-Gm-Gg: ASbGnctMe8ff79RcipDW8eUVSuPadIBnwD9y5DnfY7Noos8FQ9cmn0zp3Bzkc1ZwfFe
	1pnYmV6/ChB767ojg9kz7LRBCoUlFQf+g39zEwSjb4AjvcHzQ4hyLESgG2hKOS5tbCe1q0PY7ZI
	RJHuELv1LdCX9ihE1xn675DQrc0EM1jD3+cskIqTrpvlgYecn1Hw==
X-Google-Smtp-Source: AGHT+IF7DuBX8KihKThGAbSSiyzQZUh/8czdW4cAAEismtKOZlSmpL+yWuvunDt3A4oAOXN3VCUM2HN56GUEWLbw/A4=
X-Received: by 2002:ac8:5949:0:b0:48a:7cd7:7e02 with SMTP id
 d75a77b69052e-494499d7d62mr6121471cf.18.1746723896291; Thu, 08 May 2025
 10:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505232601.3160940-1-surenb@google.com> <20250507082538-05e988860e87f40a@stable.kernel.org>
In-Reply-To: <20250507082538-05e988860e87f40a@stable.kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 8 May 2025 17:04:45 +0000
X-Gm-Features: ATxdqUFA751lEqbKD-xJxNtwC0DU9NTeHC0-FM0rdJrfutIT2oFRmHIyMU2nM34
Message-ID: <CAJuCfpEdkkZd8RSZUPsXkq3BXzDvebfSHuF4T=AoRHDv8hgJzg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 4:18=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it

Not sure why "patch is missing proper reference to it". I see (cherry
picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef) in place.
Did I miss something?

>
> Found matching upstream commit: be8250786ca94952a19ce87f98ad9906448bc9ef
>
> WARNING: Author mismatch between patch and found commit:
> Backport author: Suren Baghdasaryan<surenb@google.com>
> Commit author: Zhenhua Huang<quic_zhenhuah@quicinc.com>
>
> Status in newer kernel trees:
> 6.14.y | Present (different SHA1: 94107e5aed93)
>
> Note: The patch differs from the upstream commit:

Yep, this is expected as I had to make changes when backporting.

> ---
> 1:  be8250786ca94 ! 1:  86ffacf03afed mm, slab: clean up slab->obj_exts a=
lways
>     @@ Commit message
>          Acked-by: Suren Baghdasaryan <surenb@google.com>
>          Link: https://patch.msgid.link/20250421075232.2165527-1-quic_zhe=
nhuah@quicinc.com
>          Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>     +    (cherry picked from commit be8250786ca94952a19ce87f98ad9906448bc=
9ef)
>     +    [surenb: fixed trivial merge conflict in alloc_tagging_slab_allo=
c_hook(),
>     +    skipped inlining free_slab_obj_exts() as it's already inline in =
6.12]

And the changes are documented above.

>     +    Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
>       ## mm/slub.c ##
>     -@@ mm/slub.c: int alloc_slab_obj_exts(struct slab *slab, struct kmem=
_cache *s,
>     -   return 0;
>     - }
>     -
>     --/* Should be called only if mem_alloc_profiling_enabled() */
>     --static noinline void free_slab_obj_exts(struct slab *slab)
>     -+static inline void free_slab_obj_exts(struct slab *slab)
>     - {
>     -   struct slabobj_ext *obj_exts;
>     -
>     -@@ mm/slub.c: static noinline void free_slab_obj_exts(struct slab *s=
lab)
>     +@@ mm/slub.c: static inline void free_slab_obj_exts(struct slab *sla=
b)
>         slab->obj_exts =3D 0;
>       }
>
>     @@ mm/slub.c: static inline void free_slab_obj_exts(struct slab *slab=
)
>       #endif /* CONFIG_SLAB_OBJ_EXT */
>
>       #ifdef CONFIG_MEM_ALLOC_PROFILING
>     -@@ mm/slub.c: __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, =
void *object, gfp_t flags)
>     +@@ mm/slub.c: prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t=
 flags, void *p)
>       static inline void
>       alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, g=
fp_t flags)
>       {
>     --  if (need_slab_obj_ext())
>     -+  if (mem_alloc_profiling_enabled())
>     -           __alloc_tagging_slab_alloc_hook(s, object, flags);
>     - }
>     +-  if (need_slab_obj_ext()) {
>     ++  if (mem_alloc_profiling_enabled()) {
>     +           struct slabobj_ext *obj_exts;
>
>     +           obj_exts =3D prepare_slab_obj_exts_hook(s, flags, object)=
;
>      @@ mm/slub.c: static __always_inline void account_slab(struct slab *=
slab, int order,
>       static __always_inline void unaccount_slab(struct slab *slab, int o=
rder,
>                                            struct kmem_cache *s)
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.12.y       |  Success    |  Success   |

