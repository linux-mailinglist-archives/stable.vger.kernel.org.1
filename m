Return-Path: <stable+bounces-191568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C51C182A4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 04:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8FCD4E8751
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A0221714;
	Wed, 29 Oct 2025 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b74PWSCa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFF277C9B
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708185; cv=none; b=MnB8dtwgBc7e3kPGe7StRDZPJMx4xYeWhOmDWkDzMxmPaP/muBpuDlZdm2DzbmxfLeqhkx53AdEmYQygoMhYZS2ZIZwigsQGZROQLmbaAVuTJQ00/dijFCpamerc3SGx4Nj+ZQ9Y5uKFCk/gGY0W7bKU853sTgvYszfo9eRZy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708185; c=relaxed/simple;
	bh=dGq1aodl/1domVkCsoSU14DBsvKbYwzPwJTt+PqrCik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo0TbndJj665jNEDdLYkv4uY37ygxHoNbLi+tqCJknQZt3RmcteRcqc4Wt/Dw8qLW+8zFlP92CQXONT1hCtYiB1qriMsfUh4KgkEeTER2HA0/5X88T1yUhmjlByq6wZ46l3fU91eXnvP2VRNESQtjJm/xo6CVe+H780IQveC+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b74PWSCa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eccff716f4so192891cf.0
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761708183; x=1762312983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZF5fZYNByvvmd5+XtP+S5jRgK5TgXHSEBZH9+I4nwY=;
        b=b74PWSCaJLlBUief2fHCSmjBEWlhnP6b6cKQj6wyAKYYCYmbAhbB5c1XlNxj0zqLhS
         FIuRzEBbtJ2L+DywfgJ/1IYZ+0bQOjdm/ssblk6yxeoeElo4v+FPCfqmozpoMbEFc1Vt
         9Jv99fj2gdli+IUWOrqD4/3yor8f5gIbiEQded4Sox062S5RmymrFDeo/hcBuHQ12tVk
         eHsQUYaFUMLhzvEwQTWwy9x/rce4O4pMUQmA+b3DUH7kN00uho8HGOe94s7WKvqC5Twx
         dhrjq1EKIGcvC1PBwgcqupLt6BT6xkOFZRiMu9psSFXRzfFNjhc3/m3kdDTGIM95e0ni
         i3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708183; x=1762312983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZF5fZYNByvvmd5+XtP+S5jRgK5TgXHSEBZH9+I4nwY=;
        b=dVOPdINNoXe9ZknTEAHu5AuxtoRiAgBLmEWyNfNveZ3ijjhWf/VQFCvR1H1nnIeltA
         WZOei79ayw7Djf15ORx9PVZnrUeyL4+QF8Fq0vDKaK7kRreuXIga36oi/mGStSINED2R
         xfAMmZwU0WYafuSuZw4Mqs7jBOyMyYifG0TKz2hcL0sfjgTUx3TJS27IDfq1wlvLS+jw
         zQbsfF2idxYol8a78WDmdmEotgQt+7p5MOy35VpyngnVcFTOivJbC3BwRLdrGjwozBOB
         XXpIbgHqlcsneENpPts3qsUMYlEp3dqEyiJVZJd9MGfuGmuqb/+7AU78UzbVHpfV5DRm
         7ejA==
X-Forwarded-Encrypted: i=1; AJvYcCVppBVQE6CSaGXoHT7yCvHJhMgyI80Vl5tG93QODe3zPDXaWCA1SLhJf197nF+RvhDhGkoiha0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAx3gGngnxqJVi70sOCqAzde5WPLkNDNFeLYnj8eKKqXW6kPga
	NYtvEBHnsFRgr1Jp7WIJMoN0+0tBsWc3b0TCEildQnzSsCK3LpABteXobwr+qGxaKGTZNsrU1kp
	dZzZbttnHENtPID0oPT3/TBzQDbGJa/XiBXrgtadU
X-Gm-Gg: ASbGncv8vxmxXv5Z523WNpzaA2zfmWnrmJEjh/TkW9/AdJPM8JevnERCB4G8J+ppfS9
	oXBS4rliwwxEHFnhEoPwtATtyWCdRXbdjg/EHktB2bLRW3fU/uMKj/2bJu7yIw8z25Na/YTuD2e
	Kj6I6jR4IECoRuuYTALUOQkboxQb1zny8cPsHE+aPX5hO8gQayGSw4IkBX4H+5/BOPx/LdbMc0Q
	ZjpBI6nA1tRoGrrqeew2p8cRfvq/6GVdqo5Zi0RLcMZL6gGCafq183xkC4qvd83g1G0B1t5ebWt
	ZFVE
X-Google-Smtp-Source: AGHT+IFt0fdOZNflVxQJh5GQqXSyDE6yhX4j0HA2jB4qnG67bFoJTwJaZpXpVeBGRX36ahJHPN1YN0/KOLD2ewkP1+w=
X-Received: by 2002:a05:622a:53c4:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ed16580052mr2297051cf.5.1761708182803; Tue, 28 Oct 2025
 20:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029014317.1533488-1-hao.ge@linux.dev>
In-Reply-To: <20251029014317.1533488-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 20:22:51 -0700
X-Gm-Features: AWmQ_bnWQlp_hgmAQPXCvvIDSyvF6h29V3Rm7M2r8OKX5bFOVKkcR6boUbLHCuw
Message-ID: <CAJuCfpG+bgLj6-GKNs7K0vRi7PsQvayTvwfyd+tFSnDY3muDGw@mail.gmail.com>
Subject: Re: [PATCH v2] codetag: debug: handle existing CODETAG_EMPTY in
 mark_objexts_empty for slabobj_ext
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:44=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> When alloc_slab_obj_exts() fails and then later succeeds in allocating
> a slab extension vector, it calls handle_failed_objexts_alloc() to
> mark all objects in the vector as empty. As a result all objects in
> this slab (slabA) will have their extensions set to CODETAG_EMPTY.
> Later on if this slabA is used to allocate a slabobj_ext vector for
> another slab (slabB), we end up with the slabB->obj_exts pointing to a
> slabobj_ext vector that itself has a non-NULL slabobj_ext equal to
> CODETAG_EMPTY. When slabB gets freed, free_slab_obj_exts() is called
> to free slabB->obj_exts vector. free_slab_obj_exts() calls
> mark_objexts_empty(slabB->obj_exts) which will generate a warning
> because it expects slabobj_ext vectors to have a NULL obj_ext, not
> CODETAG_EMPTY.
>
> Modify mark_objexts_empty() to skip the warning and setting the
> obj_ext value if it's already set to CODETAG_EMPTY.
>
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mar=
k failed slab_ext allocations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v2: Update the commit message and code comments for greater accuracy,
>     incorporating Suren's suggestions.
>     Thanks for Suren's help.
> ---
>  mm/slub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d4367f25b20d..589c596163c4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2046,7 +2046,11 @@ static inline void mark_objexts_empty(struct slabo=
bj_ext *obj_exts)
>         if (slab_exts) {
>                 unsigned int offs =3D obj_to_index(obj_exts_slab->slab_ca=
che,
>                                                  obj_exts_slab, obj_exts)=
;
> -               /* codetag should be NULL */
> +
> +               if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
> +                       return;
> +
> +               /* codetag should be NULL here */
>                 WARN_ON(slab_exts[offs].ref.ct);
>                 set_codetag_empty(&slab_exts[offs].ref);
>         }
> --
> 2.25.1
>
>

