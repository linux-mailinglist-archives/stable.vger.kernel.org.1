Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB270E953
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEWXAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 19:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEWXA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 19:00:29 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72FC2
        for <stable@vger.kernel.org>; Tue, 23 May 2023 16:00:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-623feecfa42so21363166d6.0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684882824; x=1687474824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBamSlt4wxup3dd7QTwi66UfZEdzd8aNk4n9ZcIZasE=;
        b=hBNSZxlGENyPgY+2waN9MDJswnzRjt4dDk19gHd3FfqDoKVV76r6CLtTzOjxAMtB/8
         WZL1p8ikaLfiCHLDA7eo0KtxOKl+IlTaf1nJDy+aW0AKcefpEZSKUre/0RHPPbvbfyo7
         byPPACFQ9My3jhvV0ThV/NfW011K8FvKhf55fehiOJ72+MGsnbtHIGNZkS4ADnQmtkVC
         W8x6yQbQQIK2nS0WIu/MIaciO+x9jymnvF51qEpUJ8sg8eQaLQkmVDye0A4qzwcsUTmG
         fVqrVHz2A1+j8HYWl2d6kDa0SmcZNx5DSJLajmecJC2h4UoEMYFqQEEUGCwAAOQ9i7rR
         Rb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882824; x=1687474824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBamSlt4wxup3dd7QTwi66UfZEdzd8aNk4n9ZcIZasE=;
        b=JPfbjyjt/3V1cm/+1RuJixArURE6tiCOJC5e39ZcG/WPOkRrun8vhV2CC92K3puEyU
         hcUlI+XGj9kwH2HVfjiYAwoOxbSphdOYzy1hLr4IzRSMpww3gdHOzsO4bSjMXCa6aYVi
         U1UlyLm2Ex7iIHdWmm8IrHU1KtImmXQXGLqRvKekKeGPzkFpm0cqWwOqvMugcsRSWZjV
         coHgHRmtLARBquZR4wqZ5KrmVi3a8JpaAWotQK0SCX3mAPyGVCSHzYOkaM/B0CpsbyxN
         xbhd6T2ummtKI/b90bOE5QZKREfgnN8bfAZ1ZXKRFZOYa0oyyBgHeZ4K+Sc4x7Kijvz0
         m+Uw==
X-Gm-Message-State: AC+VfDyCnE6GbLxB86Sq6PTApARcqeuLErATUjccxRFzJBwvasC++lQf
        RcJGYDU0+h0P4R3CfoQo+w/jLmNFn8NgPWeuehwkhFYNWIXVZw==
X-Google-Smtp-Source: ACHHUZ6+LPGd7t3kgTy0klwZ3Rf/Tfkc3chbGVQuDNja8sXJYaS+ygIJ3jQAHKtRQ/SKsRWzrxLK9WUq40Dav1LFoos=
X-Received: by 2002:ad4:5e8e:0:b0:621:65de:f600 with SMTP id
 jl14-20020ad45e8e000000b0062165def600mr29830254qvb.1.1684882824201; Tue, 23
 May 2023 16:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <2023052230-sprout-playful-a41f@gregkh> <20230523225201.413344-1-nphamcs@gmail.com>
In-Reply-To: <20230523225201.413344-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 23 May 2023 16:00:13 -0700
Message-ID: <CAKEwX=PWcc9bgf4axDDaa3e3hud6tqcL8FotBcdLhM76fmc8PQ@mail.gmail.com>
Subject: Re: [PATCH 6.3.y] zsmalloc: move LRU update from zs_map_object() to zs_malloc()
To:     stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 3:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Under memory pressure, we sometimes observe the following crash:
>
> [ 5694.832838] ------------[ cut here ]------------
> [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON=
1 (dead000000000100)
> [ 5694.858677] WARNING: CPU: 33 PID: 418824 at lib/list_debug.c:47 __list=
_del_entry_valid+0x42/0x80
> [ 5694.961820] CPU: 33 PID: 418824 Comm: fuse_counters.s Kdump: loaded Ta=
inted: G S                5.19.0-0_fbk3_rc3_hoangnhatpzsdynshrv41_10870_g85=
a9558a25de #1
> [ 5694.990194] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP,=
 BIOS YMM16 05/24/2021
> [ 5695.007072] RIP: 0010:__list_del_entry_valid+0x42/0x80
> [ 5695.017351] Code: 08 48 83 c2 22 48 39 d0 74 24 48 8b 10 48 39 f2 75 2=
c 48 8b 51 08 b0 01 48 39 f2 75 34 c3 48 c7 c7 55 d7 78 82 e8 4e 45 3b 00 <=
0f> 0b eb 31 48 c7 c7 27 a8 70 82 e8 3e 45 3b 00 0f 0b eb 21 48 c7
> [ 5695.054919] RSP: 0018:ffffc90027aef4f0 EFLAGS: 00010246
> [ 5695.065366] RAX: 41fe484987275300 RBX: ffff888008988180 RCX: 000000000=
0000000
> [ 5695.079636] RDX: ffff88886006c280 RSI: ffff888860060480 RDI: ffff88886=
0060480
> [ 5695.093904] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc9002=
7aef370
> [ 5695.108175] R10: 0000000000000000 R11: ffffffff82fdf1c0 R12: 000000001=
0000002
> [ 5695.122447] R13: ffff888014b6a448 R14: ffff888014b6a420 R15: 000000001=
38dc240
> [ 5695.136717] FS:  00007f23a7d3f740(0000) GS:ffff888860040000(0000) knlG=
S:0000000000000000
> [ 5695.152899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5695.164388] CR2: 0000560ceaab6ac0 CR3: 000000001c06c001 CR4: 000000000=
07706e0
> [ 5695.178659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 5695.192927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 5695.207197] PKRU: 55555554
> [ 5695.212602] Call Trace:
> [ 5695.217486]  <TASK>
> [ 5695.221674]  zs_map_object+0x91/0x270
> [ 5695.229000]  zswap_frontswap_store+0x33d/0x870
> [ 5695.237885]  ? do_raw_spin_lock+0x5d/0xa0
> [ 5695.245899]  __frontswap_store+0x51/0xb0
> [ 5695.253742]  swap_writepage+0x3c/0x60
> [ 5695.261063]  shrink_page_list+0x738/0x1230
> [ 5695.269255]  shrink_lruvec+0x5ec/0xcd0
> [ 5695.276749]  ? shrink_slab+0x187/0x5f0
> [ 5695.284240]  ? mem_cgroup_iter+0x6e/0x120
> [ 5695.292255]  shrink_node+0x293/0x7b0
> [ 5695.299402]  do_try_to_free_pages+0xea/0x550
> [ 5695.307940]  try_to_free_pages+0x19a/0x490
> [ 5695.316126]  __folio_alloc+0x19ff/0x3e40
> [ 5695.323971]  ? __filemap_get_folio+0x8a/0x4e0
> [ 5695.332681]  ? walk_component+0x2a8/0xb50
> [ 5695.340697]  ? generic_permission+0xda/0x2a0
> [ 5695.349231]  ? __filemap_get_folio+0x8a/0x4e0
> [ 5695.357940]  ? walk_component+0x2a8/0xb50
> [ 5695.365955]  vma_alloc_folio+0x10e/0x570
> [ 5695.373796]  ? walk_component+0x52/0xb50
> [ 5695.381634]  wp_page_copy+0x38c/0xc10
> [ 5695.388953]  ? filename_lookup+0x378/0xbc0
> [ 5695.397140]  handle_mm_fault+0x87f/0x1800
> [ 5695.405157]  do_user_addr_fault+0x1bd/0x570
> [ 5695.413520]  exc_page_fault+0x5d/0x110
> [ 5695.421017]  asm_exc_page_fault+0x22/0x30
>
> After some investigation, I have found the following issue: unlike other
> zswap backends, zsmalloc performs the LRU list update at the object
> mapping time, rather than when the slot for the object is allocated.
> This deviation was discussed and agreed upon during the review process
> of the zsmalloc writeback patch series:
>
> https://lore.kernel.org/lkml/Y3flcAXNxxrvy3ZH@cmpxchg.org/
>
> Unfortunately, this introduces a subtle bug that occurs when there is a
> concurrent store and reclaim, which interleave as follows:
>
> zswap_frontswap_store()            shrink_worker()
>   zs_malloc()                        zs_zpool_shrink()
>     spin_lock(&pool->lock)             zs_reclaim_page()
>     zspage =3D find_get_zspage()
>     spin_unlock(&pool->lock)
>                                          spin_lock(&pool->lock)
>                                          zspage =3D list_first_entry(&poo=
l->lru)
>                                          list_del(&zspage->lru)
>                                            zspage->lru.next =3D LIST_POIS=
ON1
>                                            zspage->lru.prev =3D LIST_POIS=
ON2
>                                          spin_unlock(&pool->lock)
>   zs_map_object()
>     spin_lock(&pool->lock)
>     if (!list_empty(&zspage->lru))
>       list_del(&zspage->lru)
>         CHECK_DATA_CORRUPTION(next =3D=3D LIST_POISON1) /* BOOM */
>
> With the current upstream code, this issue rarely happens. zswap only
> triggers writeback when the pool is already full, at which point all
> further store attempts are short-circuited. This creates an implicit
> pseudo-serialization between reclaim and store. I am working on a new
> zswap shrinking mechanism, which makes interleaving reclaim and store
> more likely, exposing this bug.
>
> zbud and z3fold do not have this problem, because they perform the LRU
> list update in the alloc function, while still holding the pool's lock.
> This patch fixes the aforementioned bug by moving the LRU update back to
> zs_malloc(), analogous to zbud and z3fold.
>
> Link: https://lkml.kernel.org/r/20230505185054.2417128-1-nphamcs@gmail.co=
m
> Fixes: 64f768c6b32e ("zsmalloc: add a LRU to zs_pool to keep track of zsp=
ages in LRU order")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit d461aac924b937bcb4fd0ca1242b3ef6868ecddd)
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3aed46ab7e6c..0d451b61573c 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1350,31 +1350,6 @@ void *zs_map_object(struct zs_pool *pool, unsigned=
 long handle,
>         obj_to_location(obj, &page, &obj_idx);
>         zspage =3D get_zspage(page);
>
> -#ifdef CONFIG_ZPOOL
> -       /*
> -        * Move the zspage to front of pool's LRU.
> -        *
> -        * Note that this is swap-specific, so by definition there are no=
 ongoing
> -        * accesses to the memory while the page is swapped out that woul=
d make
> -        * it "hot". A new entry is hot, then ages to the tail until it g=
ets either
> -        * written back or swaps back in.
> -        *
> -        * Furthermore, map is also called during writeback. We must not =
put an
> -        * isolated page on the LRU mid-reclaim.
> -        *
> -        * As a result, only update the LRU when the page is mapped for w=
rite
> -        * when it's first instantiated.
> -        *
> -        * This is a deviation from the other backends, which perform thi=
s update
> -        * in the allocation function (zbud_alloc, z3fold_alloc).
> -        */
> -       if (mm =3D=3D ZS_MM_WO) {
> -               if (!list_empty(&zspage->lru))
> -                       list_del(&zspage->lru);
> -               list_add(&zspage->lru, &pool->lru);
> -       }
> -#endif
> -
>         /*
>          * migration cannot move any zpages in this zspage. Here, pool->l=
ock
>          * is too heavy since callers would take some time until they cal=
ls
> @@ -1544,9 +1519,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_=
t size, gfp_t gfp)
>                 fix_fullness_group(class, zspage);
>                 record_obj(handle, obj);
>                 class_stat_inc(class, OBJ_USED, 1);
> -               spin_unlock(&pool->lock);
>
> -               return handle;
> +               goto out;
>         }
>
>         spin_unlock(&pool->lock);
> @@ -1570,6 +1544,14 @@ unsigned long zs_malloc(struct zs_pool *pool, size=
_t size, gfp_t gfp)
>
>         /* We completely set up zspage so mark them as movable */
>         SetZsPageMovable(pool, zspage);
> +out:
> +#ifdef CONFIG_ZPOOL
> +       /* Add/move zspage to beginning of LRU */
> +       if (!list_empty(&zspage->lru))
> +               list_del(&zspage->lru);
> +       list_add(&zspage->lru, &pool->lru);
> +#endif
> +
>         spin_unlock(&pool->lock);
>
>         return handle;
> --
> 2.34.1
>

(cc-ing Greg in as well, since he detected this)
