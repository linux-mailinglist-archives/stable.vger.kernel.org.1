Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB872F215
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 03:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjFNBjL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 21:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFNBjJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 21:39:09 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F82E53
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:39:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56d304e5f83so1992657b3.2
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686706747; x=1689298747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyUm5mTJbFdY6dOD/eJa6OeoAAikjCy0NMOeXAPuDAA=;
        b=3r0GV+khXpc4fiLsIUxry47seQLg7FgIpP74mV1T1Fw0zN2awuC1GaPiD1v2NEeOaC
         LAeUIJsbFqVoZJdziNezdK/aLuC3uLz00vPe8ijAHfmJxViFGFoPHXU5LAy0C6mxXi1d
         bhIGguxHdmZKiDsVOOSFFYLLNiEHBqDx20zBQmrTHmhVAPKPi3VeIpSVnC8ZbXl+AcEs
         zHUJpTmBBZa5D8ZcUMNmI9pq0qrBF82GdPQ2aELQrnPYViXiJPPe0IgqU19RhcDbf/2g
         Qh8Tw7gyyAxcTSrDATmLar9XwG+Bpsk4biim5EwGp0FbEkrXLkqIvsZIfzAb5n8g5a9V
         LkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686706747; x=1689298747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyUm5mTJbFdY6dOD/eJa6OeoAAikjCy0NMOeXAPuDAA=;
        b=RoF2c6G8bcRxJyR1WU4JmiTVkKA/x2z/mByxLs/8nDFcam07bacy1bccgkXgd6kbUK
         J8RGXql52qQj1U7+OkesIbY4dTB4kFJ1dr0qLcoXpWOAxkAIGIRVkAz32x+TE5v2cxPZ
         scK5cTfvpwyUlbB6V1BiLWnijk0ia4ub3sPlNjE/oNG3iGZgQs2X7ZBiOlnzt6PWxXNZ
         E2CZ7Lh0nMzyP9L6geHHtxh9NuYp8Zx3q/o4O2OWFAr4+3kxOEpUXGyPxLcgXDIx5xlO
         uE/KDouY9nbbDWsSXP78Of4UONaCUHFy0kP9w8HevsJeBqW5O576gwxjDpzWFB6x+wq6
         pGJg==
X-Gm-Message-State: AC+VfDz2RLwq2tGQvORHx+e3xXWlO3oR1Yvwt6OXLegMxZGBxQPkg6Db
        AA27slJAMmJYTQzOFXefSapcz4nwYb3d2Rx79f+qCZuThuWR1dDPvms=
X-Google-Smtp-Source: ACHHUZ6uiQhlchxDgIcjIqoMMoIIOVvxedfhLxe9+R/EII+gmOxHelWMI1sOlpars+60BJTMLwwCp1dhgiKrrNHFYtc=
X-Received: by 2002:a25:ac44:0:b0:b98:ddf4:7146 with SMTP id
 r4-20020a25ac44000000b00b98ddf47146mr761773ybd.21.1686706746766; Tue, 13 Jun
 2023 18:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230614013548.1382385-1-surenb@google.com>
In-Reply-To: <20230614013548.1382385-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 13 Jun 2023 18:38:55 -0700
Message-ID: <CAJuCfpGcpRc5nxrgC2VmDfqE4s0Z1q75ErVjWQu=tj4y1xUFZw@mail.gmail.com>
Subject: Re: [RESEND 1/1] linux-5.10/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 13, 2023 at 6:35=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Sorry about repeating lines. Didn't realize one would be added automaticall=
y.

>
> commit 5da7cb193db32da783a3f3e77d8b639989321d48 upstream.
>
> Memory passed to kvfree_rcu() that is to be freed is tracked by a
> per-CPU kfree_rcu_cpu structure, which in turn contains pointers
> to kvfree_rcu_bulk_data structures that contain pointers to memory
> that has not yet been handed to RCU, along with an kfree_rcu_cpu_work
> structure that tracks the memory that has already been handed to RCU.
> These structures track three categories of memory: (1) Memory for
> kfree(), (2) Memory for kvfree(), and (3) Memory for both that arrived
> during an OOM episode.  The first two categories are tracked in a
> cache-friendly manner involving a dynamically allocated page of pointers
> (the aforementioned kvfree_rcu_bulk_data structures), while the third
> uses a simple (but decidedly cache-unfriendly) linked list through the
> rcu_head structures in each block of memory.
>
> On a given CPU, these three categories are handled as a unit, with that
> CPU's kfree_rcu_cpu_work structure having one pointer for each of the
> three categories.  Clearly, new memory for a given category cannot be
> placed in the corresponding kfree_rcu_cpu_work structure until any old
> memory has had its grace period elapse and thus has been removed.  And
> the kfree_rcu_monitor() function does in fact check for this.
>
> Except that the kfree_rcu_monitor() function checks these pointers one
> at a time.  This means that if the previous kfree_rcu() memory passed
> to RCU had only category 1 and the current one has only category 2, the
> kfree_rcu_monitor() function will send that current category-2 memory
> along immediately.  This can result in memory being freed too soon,
> that is, out from under unsuspecting RCU readers.
>
> To see this, consider the following sequence of events, in which:
>
> o       Task A on CPU 0 calls rcu_read_lock(), then uses "from_cset",
>         then is preempted.
>
> o       CPU 1 calls kfree_rcu(cset, rcu_head) in order to free "from_cset=
"
>         after a later grace period.  Except that "from_cset" is freed
>         right after the previous grace period ended, so that "from_cset"
>         is immediately freed.  Task A resumes and references "from_cset"'=
s
>         member, after which nothing good happens.
>
> In full detail:
>
> CPU 0                                   CPU 1
> ----------------------                  ----------------------
> count_memcg_event_mm()
> |rcu_read_lock()  <---
> |mem_cgroup_from_task()
>  |// css_set_ptr is the "from_cset" mentioned on CPU 1
>  |css_set_ptr =3D rcu_dereference((task)->cgroups)
>  |// Hard irq comes, current task is scheduled out.
>
>                                         cgroup_attach_task()
>                                         |cgroup_migrate()
>                                         |cgroup_migrate_execute()
>                                         |css_set_move_task(task, from_cse=
t, to_cset, true)
>                                         |cgroup_move_task(task, to_cset)
>                                         |rcu_assign_pointer(.., to_cset)
>                                         |...
>                                         |cgroup_migrate_finish()
>                                         |put_css_set_locked(from_cset)
>                                         |from_cset->refcount return 0
>                                         |kfree_rcu(cset, rcu_head) // fre=
e from_cset after new gp
>                                         |add_ptr_to_bulk_krc_lock()
>                                         |schedule_delayed_work(&krcp->mon=
itor_work, ..)
>
>                                         kfree_rcu_monitor()
>                                         |krcp->bulk_head[0]'s work attach=
ed to krwp->bulk_head_free[]
>                                         |queue_rcu_work(system_wq, &krwp-=
>rcu_work)
>                                         |if rwork->rcu.work is not in WOR=
K_STRUCT_PENDING_BIT state,
>                                         |call_rcu(&rwork->rcu, rcu_work_r=
cufn) <--- request new gp
>
>                                         // There is a perious call_rcu(..=
, rcu_work_rcufn)
>                                         // gp end, rcu_work_rcufn() is ca=
lled.
>                                         rcu_work_rcufn()
>                                         |__queue_work(.., rwork->wq, &rwo=
rk->work);
>
>                                         |kfree_rcu_work()
>                                         |krwp->bulk_head_free[0] bulk is =
freed before new gp end!!!
>                                         |The "from_cset" is freed before =
new gp end.
>
> // the task resumes some time later.
>  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_s=
et_ptr is freed.
>
> This commit therefore causes kfree_rcu_monitor() to refrain from moving
> kfree_rcu() memory to the kfree_rcu_cpu_work structure until the RCU
> grace period has completed for all three categories.
>
> v2: Use helper function instead of inserted code block at kfree_rcu_monit=
or().
>
> [UR: backport to 5.10-stable]
> [UR: Added missing need_offload_krc() function]
> Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()"=
)
> Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs"=
)
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Resending per Greg's request.
> Original posting: https://lore.kernel.org/all/20230418102518.5911-1-urezk=
i@gmail.com/
>
>  kernel/rcu/tree.c | 49 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 30e1d7fedb5f..eec8e2f7537e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3281,6 +3281,30 @@ static void kfree_rcu_work(struct work_struct *wor=
k)
>         }
>  }
>
> +static bool
> +need_offload_krc(struct kfree_rcu_cpu *krcp)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < FREE_N_CHANNELS; i++)
> +               if (krcp->bkvhead[i])
> +                       return true;
> +
> +       return !!krcp->head;
> +}
> +
> +static bool
> +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < FREE_N_CHANNELS; i++)
> +               if (krwp->bkvhead_free[i])
> +                       return true;
> +
> +       return !!krwp->head_free;
> +}
> +
>  /*
>   * Schedule the kfree batch RCU work to run in workqueue context after a=
 GP.
>   *
> @@ -3298,16 +3322,13 @@ static inline bool queue_kfree_rcu_work(struct kf=
ree_rcu_cpu *krcp)
>         for (i =3D 0; i < KFREE_N_BATCHES; i++) {
>                 krwp =3D &(krcp->krw_arr[i]);
>
> -               /*
> -                * Try to detach bkvhead or head and attach it over any
> -                * available corresponding free channel. It can be that
> -                * a previous RCU batch is in progress, it means that
> -                * immediately to queue another one is not possible so
> -                * return false to tell caller to retry.
> -                */
> -               if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> -                       (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> -                               (krcp->head && !krwp->head_free)) {
> +               // Try to detach bulk_head or head and attach it, only wh=
en
> +               // all channels are free.  Any channel is not free means =
at krwp
> +               // there is on-going rcu work to handle krwp's free busin=
ess.
> +               if (need_wait_for_krwp_work(krwp))
> +                       continue;
> +
> +               if (need_offload_krc(krcp)) {
>                         // Channel 1 corresponds to SLAB ptrs.
>                         // Channel 2 corresponds to vmalloc ptrs.
>                         for (j =3D 0; j < FREE_N_CHANNELS; j++) {
> @@ -3334,12 +3355,12 @@ static inline bool queue_kfree_rcu_work(struct kf=
ree_rcu_cpu *krcp)
>                          */
>                         queue_rcu_work(system_wq, &krwp->rcu_work);
>                 }
> -
> -               // Repeat if any "free" corresponding channel is still bu=
sy.
> -               if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
> -                       repeat =3D true;
>         }
>
> +       // Repeat if any "free" corresponding channel is still busy.
> +       if (need_offload_krc(krcp))
> +               repeat =3D true;
> +
>         return !repeat;
>  }
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
