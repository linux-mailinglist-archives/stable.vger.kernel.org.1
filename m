Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C475F312
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjGXK07 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjGXK0s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 06:26:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80B4211
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 03:21:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so8797155a12.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1690194103; x=1690798903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S8rEjFIJj26RXW8T44yah1SylV/DZPxrJbrI1qzkoXo=;
        b=S4TIFHhCcymBH3Y0VgIXs2nd8CaNRGLU9idh5D3oJcH9JDVeQL2AthTbh1LnCTr+9v
         LoyW0Q4OLuieQcGN4mSorCoiRlYR963xR6vqA0/GZw3AkttK4h+QjsfTaXnB/pVZZAmZ
         TzZgliivva/FDQ5/EUvwkJSsVeb4tNg9qv7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194103; x=1690798903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8rEjFIJj26RXW8T44yah1SylV/DZPxrJbrI1qzkoXo=;
        b=GBd219zdu7J2ku4kca7rp9ETKn/tjbSNQB62KQ2ZYaUeqORtga167yu5N+ZFS84g1c
         83WuRhFnmw1jFNrn14isBk89DzcL1H60L+JkjChETZCiEoYx3RDWxcZ6Xx7pxohuxP8E
         66nnWHZUz14LVEqNjvtpk4KlRE92nx6ZE43FLz4AC94MHr0exkiiYk/T45z6kUINV9lv
         SLvhwei6C2VrdW4RVG41XiKbarjipj4zH/bV3DBRzya5n7ajMlUdbU7BKtHgaa1j34hv
         OIlVrpqERWglTZUF05ufAVpDH8WinPmButJqSzOblH6dHsdLhPGv8lwK98nxz5q4H4q3
         f8gg==
X-Gm-Message-State: ABy/qLactT3F7qkh7Lebjymbpd1WFTp9S89e0AYdoF5rsT5J4BT+WP/v
        lianQwbxtzrut5bjCgh4Hcbq4A==
X-Google-Smtp-Source: APBJJlFmAesp632314YKk2nnJ44cYdguylOuBb4r7ec1EWtIU/KMOdwP5NfA4FwUzmZRAZ3pvrrb6Q==
X-Received: by 2002:a05:6402:12cf:b0:51f:f079:875f with SMTP id k15-20020a05640212cf00b0051ff079875fmr9225015edx.4.1690194103210;
        Mon, 24 Jul 2023 03:21:43 -0700 (PDT)
Received: from bender.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id be26-20020a0564021a3a00b005215eb17bb7sm5988601edb.88.2023.07.24.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:21:42 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:21:41 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     leon.anavi@konsulko.com, Andrew Jones <ajones@ventanamicro.com>,
        stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] riscv: Implement missing huge_ptep_get
Message-ID: <20230724102141.GC11091@bender.k.g>
References: <20230723134822.617037-1-petko.manolov@konsulko.com>
 <20230723134822.617037-7-petko.manolov@konsulko.com>
 <CAHVXubig4XHGeK5qW+w3uqZ-DQbZaY8f80=Y9fnCGKfRgwk0nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubig4XHGeK5qW+w3uqZ-DQbZaY8f80=Y9fnCGKfRgwk0nA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 23-07-24 10:30:20, Alexandre Ghiti wrote:
> Hi Petko,
> 
> On Sun, Jul 23, 2023 at 3:48 PM Petko Manolov
> <petko.manolov@konsulko.com> wrote:
> >
> > From: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> > huge_ptep_get must be reimplemented in order to go through all the PTEs
> > of a NAPOT region: this is needed because the HW can update the A/D bits
> > of any of the PTE that constitutes the NAPOT region.
> >
> > Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Link: https://lore.kernel.org/r/20230428120120.21620-2-alexghiti@rivosinc.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> > ---
> >  arch/riscv/include/asm/hugetlb.h |  3 +++
> >  arch/riscv/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
> > index fe6f23006641..ce1ebda1a49a 100644
> > --- a/arch/riscv/include/asm/hugetlb.h
> > +++ b/arch/riscv/include/asm/hugetlb.h
> > @@ -36,6 +36,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >                                unsigned long addr, pte_t *ptep,
> >                                pte_t pte, int dirty);
> >
> > +#define __HAVE_ARCH_HUGE_PTEP_GET
> > +pte_t huge_ptep_get(pte_t *ptep);
> > +
> >  pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
> >  #define arch_make_huge_pte arch_make_huge_pte
> >
> > diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> > index 238d00bdac14..e0ef56dc57b9 100644
> > --- a/arch/riscv/mm/hugetlbpage.c
> > +++ b/arch/riscv/mm/hugetlbpage.c
> > @@ -3,6 +3,30 @@
> >  #include <linux/err.h>
> >
> >  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +pte_t huge_ptep_get(pte_t *ptep)
> > +{
> > +       unsigned long pte_num;
> > +       int i;
> > +       pte_t orig_pte = ptep_get(ptep);
> > +
> > +       if (!pte_present(orig_pte) || !pte_napot(orig_pte))
> > +               return orig_pte;
> > +
> > +       pte_num = napot_pte_num(napot_cont_order(orig_pte));
> > +
> > +       for (i = 0; i < pte_num; i++, ptep++) {
> > +               pte_t pte = ptep_get(ptep);
> > +
> > +               if (pte_dirty(pte))
> > +                       orig_pte = pte_mkdirty(orig_pte);
> > +
> > +               if (pte_young(pte))
> > +                       orig_pte = pte_mkyoung(orig_pte);
> > +       }
> > +
> > +       return orig_pte;
> > +}
> > +
> >  pte_t *huge_pte_alloc(struct mm_struct *mm,
> >                       struct vm_area_struct *vma,
> >                       unsigned long addr,
> > --
> > 2.39.2
> >
> 
> Not sure I understand why you propose this patch to stable since svnapot
> support was introduced in 6.4 and this fix (and another one) was merged in 6.4
> too. Am I missing something?

Hey there.  I've no idea how "Signed-off" with my email address appeared in this
patch.  I most certainly have not done so, nor i am in any way related to this
code.  Weird.


		Petko
