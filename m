Return-Path: <stable+bounces-62590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A593FC0F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A13282E56
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D9F15ECFD;
	Mon, 29 Jul 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2lY2CoF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B01DA24
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272830; cv=none; b=r93/W0kDGmu3GiN2X6k9ADSVcAictbf6pRfS/r5K8Su/kiWFieuZ0HMC21sN92fP7S5Rrf4KqCBOkDxqFJEZOYAJqDwjZOtB8G3IqFsTkrJkC59oBrQN7oYwco5vSlrubkf2HN9W4piDIxUoS3Ea0aVneuuNfDzZqKk3vn2qRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272830; c=relaxed/simple;
	bh=MukDlqwGZ2QOrlAFCR7m7RBj7ADyqK1eLKoPbTuxmPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COm1Y2sFbNLomM9X0znedjVUVRU0IwU5NSbGhuLd7lS2KWCTZ1vGcYsEQID9Sl4P+s7rAnYiBUVmAiPB1jrelLjTjb2G39txiuFeEmWzWNi+g1cRKy4shcd1DHBUBlS+fZvmqfOzmZane2UwcEfhZprNhStpcwwJawIcZKYhv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2lY2CoF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfef5980a69so2489827276.3
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722272827; x=1722877627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhUEd4sPvKvGMKR87Ci4cWNqtkFLlNkM7+ANTlJlEXg=;
        b=L2lY2CoFqqUu2xO3IM8xIXBdo+oglXj80fwysJaQ7l3xZrZ3+5MbiIfCoVSSm12rZQ
         LrqQF6xOUhkNiL/f6dnBizrYkeiAzhxWoQTbkdSv3ZmfimrF/a60LqNPMlzUXJ63PGgD
         zdnya5KmTWnKiN8q1hYs+Ex4EkoWR8BLgrM7MJD6rF7sFaZNcPzeXlHhvW2O1fCdKO3v
         VLcTUNTx499s0O1d9rO2Ot85ivhv9FWRHjCU2NObhTMXStmSLr/EMtCBhmCa5zW3WyHY
         MCGQqSrQO3JGcUdr31YKIRJfbv67P9ZIfgdexonMoQgmThXrkt1AxUOeznZCFxdof5uZ
         SX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272827; x=1722877627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhUEd4sPvKvGMKR87Ci4cWNqtkFLlNkM7+ANTlJlEXg=;
        b=H1klObAisb1F8DJjiQniluinYdXP6MRDigRUCq/m8MgJ1HoPI9+3iloCdau5Etjrtw
         siLa9kHMo3itHdV7HFQkGl8BMKvIMX0wTst8AgT4wqcnOFt4nHTJ+3CWC4PDskSS2ZEw
         r+5ndPpZGz1ucIGnTLtgK3kr+TTo9ST6hYBI1E7TNDOgzFa9id89cB4mrSxNZCmUWOsc
         CcRgeBkkeae2hTFrschZ/uKfBsWyVAPZ8Hbejm/3aagtuz6gZ7H8bX6jNNbZlzC7AX27
         3MmhksLl4fEx6hcMd7N9zAy1RyzwYJFW0/pP/LbO+tqN6qyCgdqBIC6d2cPL6X3H1fcA
         C7kA==
X-Gm-Message-State: AOJu0YzHbVSteGNz/yp5O3QW9an33YZf04QBASfavt+RE4vQxdqtbSVL
	T60Bmr1qjNytgiAU7rErnPQBMckHJhHcP+lDdVDuqkzS3FV/gVLkyH85uSyjY/oL0ZRX0OHXzpS
	L/S0+NYzIklShYPF3WFCILl39omZoUw7cU65aM7boh7UYHP/UhQ==
X-Google-Smtp-Source: AGHT+IFjtTRipB0pNABxw4V/zuBLiCahx2oJALO8GovAMlOSNELCF+sILWkUPexwva6rQDc8Kwu97xK19ggDxPPrYnc=
X-Received: by 2002:a05:6902:1141:b0:e08:6e2c:69ee with SMTP id
 3f1490d57ef6-e0b5440200bmr10163312276.10.1722272826951; Mon, 29 Jul 2024
 10:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024072912-during-vitalize-fe0c@gregkh> <20240729165247.709968-1-tjmercier@google.com>
In-Reply-To: <20240729165247.709968-1-tjmercier@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 29 Jul 2024 10:06:54 -0700
Message-ID: <CABdmKX0kOhU7zte1qzf6M5D2k784CXVGGEXnaDr1ULQ605MFoQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] mm/mglru: fix ineffective protection calculation
To: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:52=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> From: Yu Zhao <yuzhao@google.com>
>
> mem_cgroup_calculate_protection() is not stateless and should only be use=
d
> as part of a top-down tree traversal.  shrink_one() traverses the per-nod=
e
> memcg LRU instead of the root_mem_cgroup tree, and therefore it should no=
t
> call mem_cgroup_calculate_protection().
>
> The existing misuse in shrink_one() can cause ineffective protection of
> sub-trees that are grandchildren of root_mem_cgroup.  Fix it by reusing
> lru_gen_age_node(), which already traverses the root_mem_cgroup tree, to
> calculate the protection.
>
> Previously lru_gen_age_node() opportunistically skips the first pass,
> i.e., when scan_control->priority is DEF_PRIORITY.  On the second pass,
> lruvec_is_sizable() uses appropriate scan_control->priority, set by
> set_initial_priority() from lru_gen_shrink_node(), to decide whether a
> memcg is too small to reclaim from.
>
> Now lru_gen_age_node() unconditionally traverses the root_mem_cgroup tree=
.
> So it should call set_initial_priority() upfront, to make sure
> lruvec_is_sizable() uses appropriate scan_control->priority on the first
> pass.  Otherwise, lruvec_is_reclaimable() can return false negatives and
> result in premature OOM kills when min_ttl_ms is used.
>
> Link: https://lkml.kernel.org/r/20240712232956.1427127-1-yuzhao@google.co=
m
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Change-Id: I2ff1de0c7a3fae01370d99198d3a1b04c109aac6
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reported-by: T.J. Mercier <tjmercier@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 30d77b7eef019fa4422980806e8b7cdc8674493e)
> [TJ: moved up the existing set_initial_priority from this branch
> instead of the upstream version with changes from other patches]
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  mm/vmscan.c | 75 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 34 insertions(+), 41 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e9d4c1f6d7bb..627c4d3b4c04 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4545,6 +4545,28 @@ static bool try_to_inc_max_seq(struct lruvec *lruv=
ec, unsigned long max_seq,
>  /***********************************************************************=
*******
>   *                          working set protection
>   ***********************************************************************=
*******/
> +static void set_initial_priority(struct pglist_data *pgdat, struct scan_=
control *sc)
> +{
> +       int priority;
> +       unsigned long reclaimable;
> +       struct lruvec *lruvec =3D mem_cgroup_lruvec(NULL, pgdat);
> +
> +       if (sc->priority !=3D DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU=
_BATCH)
> +               return;
> +       /*
> +        * Determine the initial priority based on
> +        * (total >> priority) * reclaimed_to_scanned_ratio =3D nr_to_rec=
laim,
> +        * where reclaimed_to_scanned_ratio =3D inactive / total.
> +        */
> +       reclaimable =3D node_page_state(pgdat, NR_INACTIVE_FILE);
> +       if (get_swappiness(lruvec, sc))
> +               reclaimable +=3D node_page_state(pgdat, NR_INACTIVE_ANON)=
;
> +
> +       /* round down reclaimable and round up sc->nr_to_reclaim */
> +       priority =3D fls_long(reclaimable) - 1 - fls_long(sc->nr_to_recla=
im - 1);
> +
> +       sc->priority =3D clamp(priority, 0, DEF_PRIORITY);
> +}
>
>  static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control=
 *sc)
>  {
> @@ -4579,19 +4601,17 @@ static bool lruvec_is_reclaimable(struct lruvec *=
lruvec, struct scan_control *sc
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>         DEFINE_MIN_SEQ(lruvec);
>
> -       /* see the comment on lru_gen_folio */
> -       gen =3D lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
> -       birth =3D READ_ONCE(lruvec->lrugen.timestamps[gen]);
> -
> -       if (time_is_after_jiffies(birth + min_ttl))
> +       if (mem_cgroup_below_min(NULL, memcg))
>                 return false;
>
>         if (!lruvec_is_sizable(lruvec, sc))
>                 return false;
>
> -       mem_cgroup_calculate_protection(NULL, memcg);
> +       /* see the comment on lru_gen_folio */
> +       gen =3D lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
> +       birth =3D READ_ONCE(lruvec->lrugen.timestamps[gen]);
>
> -       return !mem_cgroup_below_min(NULL, memcg);
> +       return time_is_before_jiffies(birth + min_ttl);
>  }
>
>  /* to protect the working set of the last N jiffies */
> @@ -4601,23 +4621,20 @@ static void lru_gen_age_node(struct pglist_data *=
pgdat, struct scan_control *sc)
>  {
>         struct mem_cgroup *memcg;
>         unsigned long min_ttl =3D READ_ONCE(lru_gen_min_ttl);
> +       bool reclaimable =3D !min_ttl;
>
>         VM_WARN_ON_ONCE(!current_is_kswapd());
>
> -       /* check the order to exclude compaction-induced reclaim */
> -       if (!min_ttl || sc->order || sc->priority =3D=3D DEF_PRIORITY)
> -               return;
> +       set_initial_priority(pgdat, sc);
>
>         memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
>         do {
>                 struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat)=
;
>
> -               if (lruvec_is_reclaimable(lruvec, sc, min_ttl)) {
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       return;
> -               }
> +               mem_cgroup_calculate_protection(NULL, memcg);
>
> -               cond_resched();
> +               if (!reclaimable)
> +                       reclaimable =3D lruvec_is_reclaimable(lruvec, sc,=
 min_ttl);
>         } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
>
>         /*
> @@ -4625,7 +4642,7 @@ static void lru_gen_age_node(struct pglist_data *pg=
dat, struct scan_control *sc)
>          * younger than min_ttl. However, another possibility is all memc=
gs are
>          * either too small or below min.
>          */
> -       if (mutex_trylock(&oom_lock)) {
> +       if (!reclaimable && mutex_trylock(&oom_lock)) {
>                 struct oom_control oc =3D {
>                         .gfp_mask =3D sc->gfp_mask,
>                 };
> @@ -5425,8 +5442,7 @@ static int shrink_one(struct lruvec *lruvec, struct=
 scan_control *sc)
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
> -       mem_cgroup_calculate_protection(NULL, memcg);
> -
> +       /* lru_gen_age_node() called mem_cgroup_calculate_protection() */
>         if (mem_cgroup_below_min(NULL, memcg))
>                 return MEMCG_LRU_YOUNG;
>
> @@ -5566,29 +5582,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *l=
ruvec, struct scan_control *sc
>
>  #endif
>
> -static void set_initial_priority(struct pglist_data *pgdat, struct scan_=
control *sc)
> -{
> -       int priority;
> -       unsigned long reclaimable;
> -       struct lruvec *lruvec =3D mem_cgroup_lruvec(NULL, pgdat);
> -
> -       if (sc->priority !=3D DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU=
_BATCH)
> -               return;
> -       /*
> -        * Determine the initial priority based on
> -        * (total >> priority) * reclaimed_to_scanned_ratio =3D nr_to_rec=
laim,
> -        * where reclaimed_to_scanned_ratio =3D inactive / total.
> -        */
> -       reclaimable =3D node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (get_swappiness(lruvec, sc))
> -               reclaimable +=3D node_page_state(pgdat, NR_INACTIVE_ANON)=
;
> -
> -       /* round down reclaimable and round up sc->nr_to_reclaim */
> -       priority =3D fls_long(reclaimable) - 1 - fls_long(sc->nr_to_recla=
im - 1);
> -
> -       sc->priority =3D clamp(priority, 0, DEF_PRIORITY);
> -}
> -
>  static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_c=
ontrol *sc)
>  {
>         struct blk_plug plug;
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

Please ignore this patch. I didn't see Yu's existing thread for this.

