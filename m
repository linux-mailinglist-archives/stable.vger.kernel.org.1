Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED174BEF2
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGHTW1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHTW0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 15:22:26 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A47FD
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 12:22:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-577497ec6c6so36405977b3.2
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688844144; x=1691436144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FxH4Sn2IVEMSRJMI6h54/CoL9VNO3HIcD6stV0UszU=;
        b=yZP9mqmpeQMLkFovdtEmI4WKMEtko+pAQ1BEDfa+W5OHCr7jJVo29zKlMe4dc5y4+/
         ctYdxCnqqkyKx9WIui1Qqv5Ci88AGheDwsXz2NaxdeLoR4MDhJacff2brnbgaJOICM0/
         FUirKv//hF+3UgB0qF4zsmJdaL2b4sPGgHQwVh5lM+8VF9WIzAMiuuZ3N12zpITmJW2P
         bwvS7I0B45kBtMhXgHGcTY3U6QrBUujNiAIQ4YtZb+FEXhaB5xpVyoqlik6jHJ2HE/rE
         iQRENfjy1+wSccJQm6AdI6rIf3TRZOKTIXbalO5K2RUxxGox0Tcs59Z6qdZpfnU1mAbL
         9T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688844144; x=1691436144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FxH4Sn2IVEMSRJMI6h54/CoL9VNO3HIcD6stV0UszU=;
        b=kYwbEsmloeSXdOHJy9+bgjjF7EjR9s8dyCATP0rUQ3G2eZq7CMD/LiCylgIgkEoXQZ
         lomSJWq79hCvTEKG/UAWy8EnRM8Z9YoQmA9uUNy/23PTKTtCFrmjHg+ON6Hg5WIMauN3
         icfdR48qrK8dMXgV3zRGH1tgJwn/fipBykkJ6JmeABCcxguiqJI8tEz/txsgDwcSWxzR
         ZbLmkVdnib1fRErzB7DIgF5RRMSon5RaPwOnImjGyDN1MNMd10rr1tVvUsniNXhDqigE
         S/tW3Zd+xAbUfrNlRGOGDKGH7/ZE3tzT2zYKdJ2vS2zfiORBbVBORL/xLj7TzsR5xAmS
         VoEQ==
X-Gm-Message-State: ABy/qLa7iTtygEUJR1XUeCd5BEnGemnDDanbz7af+ry85/9XL20JgUOM
        htOtDzJg+yZt4bIB7/g1g4mQCGXHoUsCAWm3CsQnHg==
X-Google-Smtp-Source: APBJJlGKL8J4JHA6mAQOwpLYAy2LOkRrcxRPz0EwZZ4kcff6g2abFfEEg9qIuCiKp4H+yMTT0PzACvox6UCyMAwV86o=
X-Received: by 2002:a0d:dc83:0:b0:570:8482:4074 with SMTP id
 f125-20020a0ddc83000000b0057084824074mr10341749ywe.42.1688844144270; Sat, 08
 Jul 2023 12:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
In-Reply-To: <20230708191212.4147700-3-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 8 Jul 2023 12:22:13 -0700
Message-ID: <CAJuCfpFBnweDUBnxEZQbqxYNtrY08C+1LxYsB_5zaMhrb=AHEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 8, 2023 at 12:12=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> When forking a child process, parent write-protects an anonymous page
> and COW-shares it with the child being forked using copy_present_pte().
> Parent's TLB is flushed right before we drop the parent's mmap_lock in
> dup_mmap(). If we get a write-fault before that TLB flush in the parent,
> and we end up replacing that anonymous page in the parent process in
> do_wp_page() (because, COW-shared with the child), this might lead to
> some stale writable TLB entries targeting the wrong (old) page.
> Similar issue happened in the past with userfaultfd (see flush_tlb_page()
> call inside do_wp_page()).
> Lock VMAs of the parent process when forking a child, which prevents
> concurrent page faults during fork operation and avoids this issue.
> This fix can potentially regress some fork-heavy workloads. Kernel build
> time did not show noticeable regression on a 56-core machine while a
> stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> shows ~5% regression. If such fork time regression is unacceptable,
> disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> optimizations are possible if this regression proves to be problematic.

Sending this earlier version of the patch per request from Linus and
with his explanation here:
https://lore.kernel.org/all/CAHk-=3Dwi-99-DyMOGywTbjRnRRC+XfpPm=3Dr=3Dpei4A=
=3DMEL0QDBXA@mail.gmail.com/

>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@=
kernel.org/
> Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34c@=
applied-asynchrony.com/
> Reported-by: Jacob Young <jacobly.alt@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling firs=
t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b85814e614a5..d2e12b6d2b18 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
>         for_each_vma(old_vmi, mpnt) {
>                 struct file *file;
>
> +               vma_start_write(mpnt);
>                 if (mpnt->vm_flags & VM_DONTCOPY) {
>                         vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mp=
nt));
>                         continue;
> --
> 2.41.0.390.g38632f3daf-goog
>
