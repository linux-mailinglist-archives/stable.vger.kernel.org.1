Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144497B3788
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjI2QLQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2QLP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 12:11:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F5BE
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 09:11:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4065f29e933so7103535e9.1
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696003872; x=1696608672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIPQ+mq4ibCqI5jqpIgOMLXR3PB1xuDdnJNEgz17YYw=;
        b=cNuDA3tv4pNz7IONothlNC6q4HG2+WalHh9807nGYx9Z1c6ImMPXyE5K7CCaL7Ibdl
         Znp4NQ9ETIkAoJpKxA1hAKr0OwjFvdlj/MkziNzdHU+kHT95hXBgIpXVBuliDsqiRdsG
         W/j/9GqRDsz3+1FccuNSIr1+7kcIhikb/ME4fsnpE60me6V5KhnLs2UbdJZwBEbWAneE
         pUkNkS0fA1oeaWNpj7OpHXkGYL3F/XPTG2pigSpFfVJiXUeIw+H2ix0di3hJVIooTN8D
         /RaPlkNuqOxcxw0fFnKOAFqo/Eh0C4FxE0dffi92jti6aMGtOpzq3WGbpDWOR8tjSbcl
         EkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003872; x=1696608672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIPQ+mq4ibCqI5jqpIgOMLXR3PB1xuDdnJNEgz17YYw=;
        b=qN3W0nSkfXIDd1rqu1UXwUtP3XxjATEjDMt+pVc4M6lX/uhAiO/lTdIZmS6cBr5ABP
         CrTdzvSaQjF4XcGo/J1RQU58d/Wda3glIYbKPl6n5i8c1VtvIYaMnkhxI6r1tlpRc+LU
         XLbT+vlnjWrXGi+u1wimn7NVMyJcrmiesnpbXOqAs3fzT6Oic+ArAsx825L+mO/O4Yiz
         5uxnyeiTDibZyFkXG03MirhvAJy/lfyz8luWh4+b7K1zO7FDROd0kckP4ZdFkNfWqczU
         WWusRH7+t3H5W8ExUxS22/015lHFv1Cf/hk4ViuFu+vBaT8xQwsH+s3Us1Wapt5QSVJV
         utnw==
X-Gm-Message-State: AOJu0YyzjG3kmTkIH0O2Xl0N/f98oh8REwx4ULjRk25E0PuxcXriu7zy
        FQuaFO25RCFVVYNzROaWwgjty16T17KZkwbEZh1XWg==
X-Google-Smtp-Source: AGHT+IHTkXbH1QknEI9Ysx3L+jH5s7p8b7Rc2XdNP9tA/fdwT11V/0psMIJDE4SeahHKIE8IAqZpA9dtji9ugui/hZw=
X-Received: by 2002:a5d:58cd:0:b0:314:152d:f8db with SMTP id
 o13-20020a5d58cd000000b00314152df8dbmr3503480wrf.58.1696003872116; Fri, 29
 Sep 2023 09:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-5-10-fix-drm-mediatek-backport-v1-1-912d76cd4a96@kernel.org>
In-Reply-To: <20230922-5-10-fix-drm-mediatek-backport-v1-1-912d76cd4a96@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Sep 2023 09:11:00 -0700
Message-ID: <CAKwvOdkvJgrstZdVCMRMy+QC4VqHYq0+n5fRGbH7iYDxgAov1Q@mail.gmail.com>
Subject: Re: [PATCH 5.10] drm/mediatek: Fix backport issue in mtk_drm_gem_prime_vmap()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
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

On Fri, Sep 22, 2023 at 8:51=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When building with clang:
>
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c:255:10: error: incompatible inte=
ger to pointer conversion returning 'int' from a function with result type =
'void *' [-Wint-conversion]
>     255 |                 return -ENOMEM;
>         |                        ^~~~~~~
>   1 error generated.
>
> GCC reports the same issue as a warning, rather than an error.
>
> Prior to commit 7e542ff8b463 ("drm/mediatek: Use struct dma_buf_map in
> GEM vmap ops"), this function returned a pointer rather than an integer.
> This function is indirectly called in drm_gem_vmap(), which treats NULL
> as -ENOMEM through an error pointer. Return NULL in this block to
> resolve the warning but keep the same end result.
>
> Fixes: 43f561e809aa ("drm/mediatek: Fix potential memory leak if vmap() f=
ail")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

(resending as text/plain)
Did this get picked up? Our CI has been red for a few days on
linux-5.10.y over this.

> ---
> This is a fix for a 5.10 backport, so it has no upstream relevance but
> I've still cc'd the relevant maintainers in case they have any comments
> or want to double check my work.
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index fe64bf2176f3..b20ea58907c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -252,7 +252,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *o=
bj)
>         if (!mtk_gem->kvaddr) {
>                 kfree(sgt);
>                 kfree(mtk_gem->pages);
> -               return -ENOMEM;
> +               return NULL;
>         }
>  out:
>         kfree(sgt);
>
> ---
> base-commit: ff0bfa8f23eb4c5a65ee6b0d0b7dc2e3439f1063
> change-id: 20230922-5-10-fix-drm-mediatek-backport-0ee69329fef0
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
>


--=20
Thanks,
~Nick Desaulniers
