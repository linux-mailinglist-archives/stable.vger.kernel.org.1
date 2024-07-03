Return-Path: <stable+bounces-56925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526D92572C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E061C20C89
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 09:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2613A261;
	Wed,  3 Jul 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvNujiS4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DE13541F;
	Wed,  3 Jul 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999993; cv=none; b=dnZ31UyZPcmMBp4Mjtj/PUf1XAfcS3Gmhzy22PyrirtiYQX6ZdcfpZXnWLsHETLD+GzNVNUnbCIKtT6R60DtZqA+xElYvrQ47lquQUFImpwVjN4bl0SqG2gPIOAukkJne32bTN9X2sQwampfER8vuOQqTWUrFyedLpYHyzTcjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999993; c=relaxed/simple;
	bh=e4PmHOKCXsSy3VJhe4/b/xhQ5o/JWNWiodnpv89roh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab7jJgVj90VR3WVJI9HKM9dH65jX2umFbwqQc7Fd14gXFffT3z69KSL2RvysjxbKVyCQb9LclDEh6ARl1+d6TVm8BPO6HJq5HkAtJ6lUm7y4LJ0LY1qxwOq+kO5fZdQE4fMbbwSVA3EEbwpel5x7EpQOIDc3P+RxEjOgAp/a3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvNujiS4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso4867273276.0;
        Wed, 03 Jul 2024 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719999990; x=1720604790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtEhPZzFC3WYUCzkzU+BMtXUO+QJbt1cXqLAXxOunD8=;
        b=SvNujiS4PuXHHw9bvBiFbf/yngPA2t9Kc1qqE5ow1m+GxPItuxRtzQUxMtY4Wx0bET
         126OM9JDT1g7B7Icpg+ZoN0VkcoLbukNzOqOuZYoj7vz30dHtP11+tkiRJo+8P7J+GQM
         iacsakuAyUb57PJrrKm9mXnKMwz8rLr7OFRhQivewC5jU6n9KpF8UI+NOpFk4KXqDh+5
         nxX64V4JpoFskBahpwR44mdGm3ZHG7JNjykOHaftdP8Ca+c6XSO52uJTuDJohHiSiax5
         5/PJyGlUBN28JkGuvoj+vGRp0Fo/zo13UvEuqyjSF659ks0tVmHJWKpU3M8hbWtxEKO/
         phHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999990; x=1720604790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtEhPZzFC3WYUCzkzU+BMtXUO+QJbt1cXqLAXxOunD8=;
        b=i0uPjgnOmUteLtFwtlWj8zw+1NtG9KOx6mg+OK1UF64wpw/Gecsjqbv+ru1jVySxzh
         SXsYWGPNb8zlSWHTcmTZxRCBOXap/DdgnoTPsEy1HEOZ/FvfimbnrxlwjzQ1GzS5wTpa
         UrG/hJ3pDDyZKTKXys1Qwz0vcKgIypeVjJ91sEf0t3fVujC/tMASCB6ACAVHC9+puU8t
         lAwx9ThFO6poHDpGIwkAmgVlU2vLOSszV2AsRTu8QsAFzGHQhfn71LvdA9miub/j8qig
         NMYjbHnPesOCK2aCF1O+fiFsdP6OZlWmXK0dmMnbEtF+xzItrM4azl1uHTaij7RMLhwv
         CYFg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Nc0m9FAYtbC/YTUd4zbbg6qw6WbDGlLIsMIuZ/u1imSZuTSvtfBrROJjADbe52Jrj9UR8yjHSk+W/hAWcpQWUjPsf2f/YL7EKBrmmuSerWTVW/7jeVcY79J2zLsSFWYRoRrE
X-Gm-Message-State: AOJu0YzTKJYA5cSl5oEe9H93095ykcREgESCWXuKbv+NyEKAr6d8IktF
	fsT/tb9E5asSLYt0j2f4j9vJrhKdzLa/ls+ww2kB11IIE1cLFDEGxY9P2CFA7V05dZbhrLPvHf8
	dXaGriLW2Z2y4Gt2JF/12mVklVeH7pw==
X-Google-Smtp-Source: AGHT+IFN6fJQ9FxDMTyB8AfK32sF4RcKcTiuXHuahStmF3o94VAYMckaMoXyAs7LTUHzEjZuWyRrspjYyMGCS3OXBkA=
X-Received: by 2002:a25:e089:0:b0:dff:338e:4f6 with SMTP id
 3f1490d57ef6-e036eaf9069mr10571411276.5.1719999990222; Wed, 03 Jul 2024
 02:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1719038884-1903-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Jul 2024 21:46:19 +1200
Message-ID: <CAGsJ_4yO5NJ4kSDPaS-QdRyKfw-A52HE+Jn38vQpbonFSE8ZoQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com, 
	baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 6:48=E2=80=AFPM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> If a large number of CMA memory are configured in system (for example, th=
e
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
> ...) to pin memory.  Normally if a page is present and in CMA area,
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> area because of FOLL_LONGTERM flag. But the current code will cause the
> migration failure due to unexpected page refcounts, and eventually cause
> the virtual machine fail to start.
>
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is no=
t
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail=
.
>
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page=
).
> Seems making the LRU flag of the page invisible a long time is no problem=
,
> because a new page is allocated from buddy and added to the lru batch,
> its LRU flag is also not visible for a long time.
>
> Cc: <stable@vger.kernel.org>

you have Cced stable, what is the fixes tag?

> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index dc205bd..9caf6b0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch =
*fbatch, move_fn_t move_fn)
>         for (i =3D 0; i < folio_batch_count(fbatch); i++) {
>                 struct folio *folio =3D fbatch->folios[i];
>
> -               /* block memcg migration while the folio moves between lr=
u */
> -               if (move_fn !=3D lru_add_fn && !folio_test_clear_lru(foli=
o))
> -                       continue;
> -
>                 folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>                 move_fn(lruvec, folio);
>
> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec,=
 struct folio *folio)
>  void folio_rotate_reclaimable(struct folio *folio)
>  {
>         if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +           !folio_test_unevictable(folio)) {
>                 struct folio_batch *fbatch;
>                 unsigned long flags;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock_irqsave(&lru_rotate.lock, flags);
>                 fbatch =3D this_cpu_ptr(&lru_rotate.fbatch);
>                 folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn)=
;
> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>
>  void folio_activate(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && !folio_test_active(folio) &&
> -           !folio_test_unevictable(folio)) {
> +       if (!folio_test_active(folio) && !folio_test_unevictable(folio)) =
{
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.activate);
>                 folio_batch_add_and_move(fbatch, folio, folio_activate_fn=
);
> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>                 return;
>
>         folio_get(folio);
> +       if (!folio_test_clear_lru(folio)) {
> +               folio_put(folio);
> +               return;
> +       }
> +
>         local_lock(&cpu_fbatches.lock);
>         fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>         folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>   */
>  void folio_deactivate(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
> -           (folio_test_active(folio) || lru_gen_enabled())) {
> +       if (!folio_test_unevictable(folio) && (folio_test_active(folio) |=
|
> +           lru_gen_enabled())) {
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>                 folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn=
);
> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>   */
>  void folio_mark_lazyfree(struct folio *folio)
>  {
> -       if (folio_test_lru(folio) && folio_test_anon(folio) &&
> -           folio_test_swapbacked(folio) && !folio_test_swapcache(folio) =
&&
> -           !folio_test_unevictable(folio)) {
> +       if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +           !folio_test_swapcache(folio) && !folio_test_unevictable(folio=
)) {
>                 struct folio_batch *fbatch;
>
>                 folio_get(folio);
> +               if (!folio_test_clear_lru(folio)) {
> +                       folio_put(folio);
> +                       return;
> +               }
> +
>                 local_lock(&cpu_fbatches.lock);
>                 fbatch =3D this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
>                 folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
> --
> 2.7.4
>

