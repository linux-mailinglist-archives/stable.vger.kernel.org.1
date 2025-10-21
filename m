Return-Path: <stable+bounces-188339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB2BF6C29
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28282503C8B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C027336EE1;
	Tue, 21 Oct 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czQ0UXwF"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19732E739
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053110; cv=none; b=Ynk2Zf6NZDyAWqK4hfDp09JdCdki3+4EQmJu+/aDG/ZCPi+QnJk7mqgtzxURh4SUqIhKViT81us2/zAUKzfHdKUiOS4xMIEL2FJJg536FpMkv5HKTArqeO0LJjLWT85bsL9HvpndYN95PK0IYxdvQYErOF2lWMq6pClmwhd3vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053110; c=relaxed/simple;
	bh=kiNqiVIfSory3z3e8ycMVEmSuhU+p709nuG3eFpGoOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOvqv+SENaxS1N4y+nEq/GjNxjC+65ilIkzYb+68IwsQBFgTjqMeiY/hpVoCg0VJU4Yp655Z9Z/qdjvM9hAqRbfoCX2iiG8zZoum9xy3nsgNUmsIZoQkuGgSfDktH6rfDVjdGm8zR3IWeL2ZG/BWlV2stg2w+6CvlQvePDNGotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czQ0UXwF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430e5d5ca8aso408195ab.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053108; x=1761657908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN91pXwgqIQMxfVu6MiKIAGYOkS4a8BITP1vquLMZVQ=;
        b=czQ0UXwFgPQsJ9x6M589G9UJA1EDemR3l+Ouw3iPZ4JPjVh0t7oRbn3mAj/V94cGC5
         F52tM/8GYQbki5VYyGIMCQYTHf7Gh+nIcoaV0Q/cgUwHS+Cqeu+Xjjy7ZUcHSDi74+L2
         vRhwTSJY/adheOXHGluEpqm6B28Mkz3mBGk+z0t/QYx1V40mH4epaKNtDyCWy7ck6PzT
         6shPhiu+z8F1ZdnZ4U9bI1wFp4NZ7AWIKAstHiim6p+Qo6whBudWc4msn+GjDaddAXuw
         IKEgoIwsbzSeqLsWltzpaG6lcVaTWPuLDOlqt8AQ6o2HyQ4K3N6q9ueD0PjwZ5XG2Ebz
         VVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053108; x=1761657908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN91pXwgqIQMxfVu6MiKIAGYOkS4a8BITP1vquLMZVQ=;
        b=Wy5y9mAuMbnXg5hjCp49BBzaeazLPUViDOItiFjeUmxtVTnam7/gg8qA90xcihmHSz
         bsoy20rss/1+hLGXkLvnRHOARfVYnUCtAybNztTaGGgGjNwHF3z2ysVwiuzA3uzYgN0F
         lhxFw9h9cvFFe4+MMA4AJ8gFOOpG4BS/KdxzflFiXxbVvPkyL7LOsyTGS0YX9Ak23P3d
         5joTdzqlE+foAc5pT0snXxd+LzjTjUYt/t5RXcejE1S59UFW++0xQvqmrmas7FC+X1Qo
         dny/VXD49TDvDvZGUZOScT+4hqydKGZXHodrYU1/lWxCtFrIeuG0QGDSMbgCefSXrXJY
         soDA==
X-Forwarded-Encrypted: i=1; AJvYcCXhHoc4DI03mUDkT2nLdj26SaCnIpm8e5w97C+ZGCLerqmswYpS6PYTmpc5EW3wnUqTb4BkS6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPmqSL5/rNCBMLKFPcDgG5OUeDFk335hC4B6M6Idg3XLhninJ
	SVlWlUL/bafnneCie31E3MVHTQSBqDCwScB4MPvLE4gROCOFq/qwN7LZE/jN81sj2bX4239GaFQ
	I3V+H9Wgty3Ptxl7kFa24MKsRv3tbXHOSrv36DxbF
X-Gm-Gg: ASbGncv6Ec8HvjtD5R3Tvw2ZpIf3LDl9JJmMyvYv07x3P7E22OlsJn2fKnobxpA0q6M
	SEfZ8gtqOaI6hcxRnyH0P64u/ebTml2gu/4TGtW1fErlbOo0ARw/WSlykZPm4Rw/WtN4LPNDLuL
	i13NcZjgadl7bjSlAYqY5KshsSRl5HP4WisWa2ywVy3ko1/xHS4tYeEa+s4yiVtAwXEkIGjJDYl
	eNwVGieghkkUxsuuB7jX6YHZIhiVRieM/vm1Ni9LIypcXHS7LbFsUo0UcRwlu4Nnmlb2uc=
X-Google-Smtp-Source: AGHT+IEY3/tL9248AlNmzuOMolz/CQv5WsxYicH+FzqLOvMDH2FmXvH2tkQitr3keOXC46BpA4ai0otA6bymkuK1obw=
X-Received: by 2002:ac8:5c90:0:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4ea11f78f5bmr1896601cf.8.1761053107372; Tue, 21 Oct 2025
 06:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021010353.1187193-1-hao.ge@linux.dev> <1e1376fd-1d38-4dde-918a-d4e937d4feac@suse.cz>
In-Reply-To: <1e1376fd-1d38-4dde-918a-d4e937d4feac@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 21 Oct 2025 06:24:53 -0700
X-Gm-Features: AS18NWBq-WflSIhn0eZIg3ZJV7hVJZWkIF7eJkNyEtLKL0lBLjGKZ_AOqjdE04E
Message-ID: <CAJuCfpFto6=Z0kPdjNP6WeOYUB0uMKom9+HFg+ugA=ZjsNhewA@mail.gmail.com>
Subject: Re: [PATCH v3] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:04=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 10/21/25 03:03, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > If two competing threads enter alloc_slab_obj_exts() and one of them
> > fails to allocate the object extension vector, it might override the
> > valid slab->obj_exts allocated by the other thread with
> > OBJEXTS_ALLOC_FAIL. This will cause the thread that lost this race and
> > expects a valid pointer to dereference a NULL pointer later on.
> >
> > Update slab->obj_exts atomically using cmpxchg() to avoid
> > slab->obj_exts overrides by racing threads.
> >
> > Thanks for Vlastimil and Suren's help with debugging.
> >
> > Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unc=
onditionally")
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks for the fix, Hao!

>
> Added to slab/for-next-fixes, thanks!
>
> > ---
> > v3: According to Suren's suggestion, simplify the commit message and th=
e code comments.
> >     Thanks for Suren.
> >
> > v2: Incorporate handling for the scenario where, if mark_failed_objexts=
_alloc wins the race,
> >     the other process (that previously succeeded in allocation) will lo=
se the race, based on Suren's suggestion.
> >     Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/slub.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2e4340c75be2..d4403341c9df 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slab=
obj_ext *obj_exts)
> >
> >  static inline void mark_failed_objexts_alloc(struct slab *slab)
> >  {
> > -     slab->obj_exts =3D OBJEXTS_ALLOC_FAIL;
> > +     cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> >  }
> >
> >  static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> > @@ -2136,6 +2136,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >  #ifdef CONFIG_MEMCG
> >       new_exts |=3D MEMCG_DATA_OBJEXTS;
> >  #endif
> > +retry:
> >       old_exts =3D READ_ONCE(slab->obj_exts);
> >       handle_failed_objexts_alloc(old_exts, vec, objects);
> >       if (new_slab) {
> > @@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >                * be simply assigned.
> >                */
> >               slab->obj_exts =3D new_exts;
> > -     } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> > -                cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_=
exts) {
> > +     } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
> >               /*
> >                * If the slab is already in use, somebody can allocate a=
nd
> >                * assign slabobj_exts in parallel. In this case the exis=
ting
> > @@ -2158,6 +2158,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct=
 kmem_cache *s,
> >               else
> >                       kfree(vec);
> >               return 0;
> > +     } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_=
exts) {
> > +             /* Retry if a racing thread changed slab->obj_exts from u=
nder us. */
> > +             goto retry;
> >       }
> >
> >       if (allow_spin)
>

