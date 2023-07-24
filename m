Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C775EDA3
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGXIaz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGXIag (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 04:30:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4051B3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 01:30:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-316eabffaa6so2792509f8f.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690187431; x=1690792231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM3T4XQeo2Rwf8P4XnVgIPJxLOK5OfL53+1bBgJEHlI=;
        b=yNCJ/1cGSLzFXQigRWvUyUoHDHIVzBh9O68gZyds2VvxTsqgJPZ1jKhHGPC3PktHk5
         yR9XvGq2np/yKjj8s0f2zj2Rmq23mVp3DNiUnLx0cHdQvy9A/nMfF5BFSfOdIF5L22DW
         dwss61loxN1F8Sc0c6hdx6piAOfESYoUiA3qrYP2BOnkJqWggtKwcYb6yw3wk8KJe0qN
         zGCezCbo8HaLRFdAoqpwewdc5hFYqDAdr7yKNj8+AcqUa3lqSRYA4osAExe6uOdi1rKU
         JXZOG0+bwphc1vc1a8T+/Ohwo//gtrzVj8i+FmnTgcjGhDkdI2LZY9H2XZw9eFP8ZnKk
         HcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187431; x=1690792231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM3T4XQeo2Rwf8P4XnVgIPJxLOK5OfL53+1bBgJEHlI=;
        b=UzQZmMhlIjvG0+lMstjsbr+J8NOyFHZZONDafgmEH/HC9tjyF6TjUCxBMEX4LzlQ9e
         XQ67JZUoqwNG+NMnRF+qwYWFTDMkOYYxW4JEamWNtDpXqtJnsEH+VA/J5vCCWccIbEep
         JIST3R0Es3WJgXpbruI9FCKjJiaTl8Rx4c653j80ia35B9aeR1Ieqhp2vRTWcIvewII+
         QawohJRw2LQYMSHDWOXiAQ7JQAI7dHLORo0UTLQI2SgAqdVQqPPaqL680aX/lmU54Pbn
         pEaeJufjDvaC3CoZkPibMD70K0BmGzz8KeB/Nlol9hkGlF1/+B5T9aLEX4i42FLXh0Gx
         EVkA==
X-Gm-Message-State: ABy/qLaaGl9ynZUqOUIFDBf7DL5kFvkBannpgzfRCqw0hQhvhsuuCouu
        iZf01N0BrlRl1cQzeGzoZX/ayYF14jqprOsxFz52FQ==
X-Google-Smtp-Source: APBJJlHCEmaleZW/hhPhv2uqHLz8a4WYPXRqkt+WjJ14d+PGHLWfAzR6MNjtG5kcPIMNo71K3DxpJ7uzImxt65cvdeI=
X-Received: by 2002:a5d:4526:0:b0:317:630f:de0c with SMTP id
 j6-20020a5d4526000000b00317630fde0cmr482547wra.44.1690187431488; Mon, 24 Jul
 2023 01:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230723134822.617037-1-petko.manolov@konsulko.com> <20230723134822.617037-7-petko.manolov@konsulko.com>
In-Reply-To: <20230723134822.617037-7-petko.manolov@konsulko.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 24 Jul 2023 10:30:20 +0200
Message-ID: <CAHVXubig4XHGeK5qW+w3uqZ-DQbZaY8f80=Y9fnCGKfRgwk0nA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Implement missing huge_ptep_get
To:     Petko Manolov <petko.manolov@konsulko.com>
Cc:     leon.anavi@konsulko.com, Andrew Jones <ajones@ventanamicro.com>,
        stable@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Petko,

On Sun, Jul 23, 2023 at 3:48=E2=80=AFPM Petko Manolov
<petko.manolov@konsulko.com> wrote:
>
> From: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> huge_ptep_get must be reimplemented in order to go through all the PTEs
> of a NAPOT region: this is needed because the HW can update the A/D bits
> of any of the PTE that constitutes the NAPOT region.
>
> Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Link: https://lore.kernel.org/r/20230428120120.21620-2-alexghiti@rivosinc=
.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> ---
>  arch/riscv/include/asm/hugetlb.h |  3 +++
>  arch/riscv/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hu=
getlb.h
> index fe6f23006641..ce1ebda1a49a 100644
> --- a/arch/riscv/include/asm/hugetlb.h
> +++ b/arch/riscv/include/asm/hugetlb.h
> @@ -36,6 +36,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *v=
ma,
>                                unsigned long addr, pte_t *ptep,
>                                pte_t pte, int dirty);
>
> +#define __HAVE_ARCH_HUGE_PTEP_GET
> +pte_t huge_ptep_get(pte_t *ptep);
> +
>  pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t fla=
gs);
>  #define arch_make_huge_pte arch_make_huge_pte
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 238d00bdac14..e0ef56dc57b9 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -3,6 +3,30 @@
>  #include <linux/err.h>
>
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> +pte_t huge_ptep_get(pte_t *ptep)
> +{
> +       unsigned long pte_num;
> +       int i;
> +       pte_t orig_pte =3D ptep_get(ptep);
> +
> +       if (!pte_present(orig_pte) || !pte_napot(orig_pte))
> +               return orig_pte;
> +
> +       pte_num =3D napot_pte_num(napot_cont_order(orig_pte));
> +
> +       for (i =3D 0; i < pte_num; i++, ptep++) {
> +               pte_t pte =3D ptep_get(ptep);
> +
> +               if (pte_dirty(pte))
> +                       orig_pte =3D pte_mkdirty(orig_pte);
> +
> +               if (pte_young(pte))
> +                       orig_pte =3D pte_mkyoung(orig_pte);
> +       }
> +
> +       return orig_pte;
> +}
> +
>  pte_t *huge_pte_alloc(struct mm_struct *mm,
>                       struct vm_area_struct *vma,
>                       unsigned long addr,
> --
> 2.39.2
>

Not sure I understand why you propose this patch to stable since
svnapot support was introduced in 6.4 and this fix (and another one)
was merged in 6.4 too. Am I missing something?

Thanks,

Alex
