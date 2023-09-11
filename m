Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723BE79B87F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjIKUvy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243843AbjIKR7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 13:59:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D620E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 10:59:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso11225e9.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694455146; x=1695059946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5d3t9wchAGCfDcXuyC+exyIaodFBWJVCMSu2pi73l0=;
        b=ECV8PNt3IZUb1qlM51kSHJsTf6Fajl5UIvZgI8dfdM1oF3TSSV6bTOxtKPVeEECgPY
         BgwKZ0bhQDXnVtxvkBiWVCikR3S1amRfIJm5AL8SbzE3663jvqa9q90HKwQ3rkiPowvl
         c5GWgxABF9ldG+gRAA7uN/SGUUbewD5Wo6qopWEKnl4Aqrnhdxyq7x9GseWv9/C+Hluv
         BKjov3+w/1bdYfn4MvVOAfS8H0PMvcRCLK32q8k2+GGxyVaGHX2Suho4cqX5rgM7XBxV
         9gYIz2zFzTWr06L5oGASITDFAa2eYUQ6inU7xWVmI+4fgQ3IXZnkxm8/GamfDlyZwDW2
         ZV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694455146; x=1695059946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5d3t9wchAGCfDcXuyC+exyIaodFBWJVCMSu2pi73l0=;
        b=O+pQN9eHyyH03GSnZ7UQi4M7l7vKjyJY85eiowB005RrSZ5V/nAoHPVFCm3yMNNyri
         xy9v7hrR5YcGVTFK5r7vncUoFV+ARVexYPA+g63hIIXxw31HLt1EKZroinQ+sM/4mAj+
         ye4lflc3dubDGs51OMu8wVTYpErJbGIHBYJV5vTFd4ggjo1xhN39HYc0c8LWr0sy7dfq
         fKHGE90IGTObQiW28YahueZU4eiodoFBMwSdunDPfnTrzGMTcAaylJBdecIjESGlYDNT
         xPX/KIZAIihIOlCABp61/1gWCmAtK0ip5MGN+SZXFRMZi+dqpkKP7/eSeT16KSdWerCy
         Xa2A==
X-Gm-Message-State: AOJu0Yw+mK409cP58yUBGwMITDAW1ctSmCC61L2Aqc5Us9Q+FS15be7Q
        ws9TDpRtCuoVJBAlSMLVg5KNcZnReEpv3rheC9ClHQ==
X-Google-Smtp-Source: AGHT+IFI/Xiby4nCSZfqef2CmbV7N/OdGjlV40bMjjCMLmugVEIsybhKG6qRrmq03dZDv7qBDVPoZUC/qvRFuaqeYQY=
X-Received: by 2002:a05:600c:4f08:b0:401:a494:2bbb with SMTP id
 l8-20020a05600c4f0800b00401a4942bbbmr11606wmq.5.1694455145699; Mon, 11 Sep
 2023 10:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <2023090959-mothproof-scarf-6195@gregkh>
In-Reply-To: <2023090959-mothproof-scarf-6195@gregkh>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 11 Sep 2023 10:58:54 -0700
Message-ID: <CAC_TJvfS3TWr4NtzU+STAeQQio3PcK=r5sp_NbsW2jEffhHUGQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] Multi-gen LRU: fix per-zone reclaim"
 failed to apply to 6.1-stable tree
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        angelogioacchino.delregno@collabora.com, baohua@kernel.org,
        bgeffon@google.com, heftig@archlinux.org,
        lecopzer.chen@mediatek.com, matthias.bgg@gmail.com,
        oleksandr@natalenko.name, quic_charante@quicinc.com,
        steven@liquorix.net, suleiman@google.com, surenb@google.com,
        yuzhao@google.com, zhengqi.arch@bytedance.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 9, 2023 at 6:04=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 669281ee7ef731fb5204df9d948669bf32a5e68d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090959-=
mothproof-scarf-6195@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
> 669281ee7ef7 ("Multi-gen LRU: fix per-zone reclaim")
> 6df1b2212950 ("mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folio=
s[]")

Hi Greg,

Can you apply in this order please:

1) 6df1b2212950 ("mm: multi-gen LRU: rename lrugen->lists[] to
lrugen->folios[]")
2) 669281ee7ef7 ("Multi-gen LRU: fix per-zone reclaim")

With the one rename dependency, I've checked that this applies cleanly
and tested it.
Or let me know if you prefer I resend both.

Thanks,
Kalesh

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 669281ee7ef731fb5204df9d948669bf32a5e68d Mon Sep 17 00:00:00 2001
> From: Kalesh Singh <kaleshsingh@google.com>
> Date: Tue, 1 Aug 2023 19:56:02 -0700
> Subject: [PATCH] Multi-gen LRU: fix per-zone reclaim
>
> MGLRU has a LRU list for each zone for each type (anon/file) in each
> generation:
>
>         long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>
> The min_seq (oldest generation) can progress independently for each
> type but the max_seq (youngest generation) is shared for both anon and
> file. This is to maintain a common frame of reference.
>
> In order for eviction to advance the min_seq of a type, all the per-zone
> lists in the oldest generation of that type must be empty.
>
> The eviction logic only considers pages from eligible zones for
> eviction or promotion.
>
>     scan_folios() {
>         ...
>         for (zone =3D sc->reclaim_idx; zone >=3D 0; zone--)  {
>             ...
>             sort_folio();       // Promote
>             ...
>             isolate_folio();    // Evict
>         }
>         ...
>     }
>
> Consider the system has the movable zone configured and default 4
> generations. The current state of the system is as shown below
> (only illustrating one type for simplicity):
>
> Type: ANON
>
>         Zone    DMA32     Normal    Movable    Device
>
>         Gen 0       0          0        4GB         0
>
>         Gen 1       0        1GB        1MB         0
>
>         Gen 2     1MB        4GB        1MB         0
>
>         Gen 3     1MB        1MB        1MB         0
>
> Now consider there is a GFP_KERNEL allocation request (eligible zone
> index <=3D Normal), evict_folios() will return without doing any work
> since there are no pages to scan in the eligible zones of the oldest
> generation. Reclaim won't make progress until triggered from a ZONE_MOVAB=
LE
> allocation request; which may not happen soon if there is a lot of free
> memory in the movable zone. This can lead to OOM kills, although there
> is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
> reclaim.
>
> This issue is not seen in the conventional active/inactive LRU since
> there are no per-zone lists.
>
> If there are no (not enough) folios to scan in the eligible zones, move
> folios from ineligible zone (zone_index > reclaim_index) to the next
> generation. This allows for the progression of min_seq and reclaiming
> from the next generation (Gen 1).
>
> Qualcomm, Mediatek and raspberrypi [1] discovered this issue independentl=
y.
>
> [1] https://github.com/raspberrypi/linux/issues/5395
>
> Link: https://lkml.kernel.org/r/20230802025606.346758-1-kaleshsingh@googl=
e.com
> Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com> [mediatek]
> Tested-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Steven Barrett <steven@liquorix.net>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4039620d30fe..489a4fc7d9b1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4889,7 +4889,8 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
>   *                          the eviction
>   ***********************************************************************=
*******/
>
> -static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int t=
ier_idx)
> +static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struc=
t scan_control *sc,
> +                      int tier_idx)
>  {
>         bool success;
>         int gen =3D folio_lru_gen(folio);
> @@ -4939,6 +4940,13 @@ static bool sort_folio(struct lruvec *lruvec, stru=
ct folio *folio, int tier_idx)
>                 return true;
>         }
>
> +       /* ineligible */
> +       if (zone > sc->reclaim_idx) {
> +               gen =3D folio_inc_gen(lruvec, folio, false);
> +               list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> +               return true;
> +       }
> +
>         /* waiting for writeback */
>         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> @@ -4987,7 +4995,8 @@ static bool isolate_folio(struct lruvec *lruvec, st=
ruct folio *folio, struct sca
>  static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>                        int type, int tier, struct list_head *list)
>  {
> -       int gen, zone;
> +       int i;
> +       int gen;
>         enum vm_event_item item;
>         int sorted =3D 0;
>         int scanned =3D 0;
> @@ -5003,9 +5012,10 @@ static int scan_folios(struct lruvec *lruvec, stru=
ct scan_control *sc,
>
>         gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
> -       for (zone =3D sc->reclaim_idx; zone >=3D 0; zone--) {
> +       for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
>                 int skipped =3D 0;
> +               int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
>                 while (!list_empty(head)) {
> @@ -5019,7 +5029,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>
>                         scanned +=3D delta;
>
> -                       if (sort_folio(lruvec, folio, tier))
> +                       if (sort_folio(lruvec, folio, sc, tier))
>                                 sorted +=3D delta;
>                         else if (isolate_folio(lruvec, folio, sc)) {
>                                 list_add(&folio->lru, list);
>
