Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F07B6CC3
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJCPOs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjJCPOs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 11:14:48 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFDA6
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 08:14:45 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-452749f6c47so577326137.1
        for <stable@vger.kernel.org>; Tue, 03 Oct 2023 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696346084; x=1696950884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G502n/pwsi2xTvXRats/u+gp/KdtO1vpg74dn53OTQA=;
        b=KfmNOFLqCS+lSSOgcbphofXlnxSqCS+9qJZ4baHQnOOMsa5qaZhbtZ5VvQ/5FEUE58
         tBDiXS3+dnR2aETNg4Ovm2t9NQ63VigILPawUn4BvQro5Of0g60Ta2xXrAie87EBmAHb
         nrSb1UPrNB6AuvVA+QL1gCbfYFR0bAb4d0AMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346084; x=1696950884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G502n/pwsi2xTvXRats/u+gp/KdtO1vpg74dn53OTQA=;
        b=PuFEEnVYhx3xrpJqgQG75DCSmPtcvWGulO9lZt7rHLrqRLusVaQg2irGuGv8lrORvU
         ju5FUVIMgmD2DSPuHaeHHjT/Z4gY3hw7/RBtY4Dy9mGPFOcajA2Uuje2hsqXcdUxz4NP
         V0J9Fngp3vMoTI12eu/aMmJ4o6RCb6Q6b+tbHzDlYKhf+OHIXo1MqYHtGQLqWsX9Orcl
         U0BUdP50evSTIcuXEprQyPTmoxg7qzSOs1Cxp/1Y7C/3EnVD2uCzIz/ShTxKqBH95TaW
         66IfDwGjYS4X9Bg3nv9MwBXDzTbJefDnfGZsToaqgvVqiXjJSqCYO9/Rnw1XhsI6t13Q
         Wxng==
X-Gm-Message-State: AOJu0YxjG29KO9txvCUBvKdk0HZe6dexBEgFWX8vcoRjjZO8iI8Pwgli
        JcPtePEDD2QhLDStPlY0E5WLRRJcnvuw1QqJvKPjdA==
X-Google-Smtp-Source: AGHT+IGu4llupNvUdFq1gkRLTjp2qMYOUldKCmzu/UhFyKqb0DB3x+At54a4tU0zCbY/el6lQSvxxw==
X-Received: by 2002:a05:6102:2e4:b0:452:8afa:e1ac with SMTP id j4-20020a05610202e400b004528afae1acmr13224743vsj.26.1696346083751;
        Tue, 03 Oct 2023 08:14:43 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id q5-20020ab054c5000000b007a89b13f2a8sm207495uaa.33.2023.10.03.08.14.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 08:14:43 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-45274236ef6so570786137.3
        for <stable@vger.kernel.org>; Tue, 03 Oct 2023 08:14:43 -0700 (PDT)
X-Received: by 2002:a05:6102:274c:b0:452:9384:139a with SMTP id
 p12-20020a056102274c00b004529384139amr13589952vsu.22.1696346082550; Tue, 03
 Oct 2023 08:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231002092051.555479-1-wenst@chromium.org>
In-Reply-To: <20231002092051.555479-1-wenst@chromium.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 3 Oct 2023 23:14:06 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
Message-ID: <CAC=S1ng3_z0H48awhum7unXTTk0yfn61pTWqSmPJ9fWdoURL=A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Correctly free sg_table in gem prime vmap
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Mon, Oct 2, 2023 at 5:21=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> The MediaTek DRM driver implements GEM PRIME vmap by fetching the
> sg_table for the object, iterating through the pages, and then
> vmapping them. In essence, unlike the GEM DMA helpers which vmap
> when the object is first created or imported, the MediaTek version
> does it on request.
>
> Unfortunately, the code never correctly frees the sg_table contents.
> This results in a kernel memory leak. On a Hayato device with a text
> console on the internal display, this results in the system running
> out of memory in a few days from all the console screen cursor updates.
>
> Add sg_free_table() to correctly free the contents of the sg_table. This
> was missing despite explicitly required by mtk_gem_prime_get_sg_table().
>
> Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap funct=
ion")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Please merge for v6.6 fixes.
>
> Also, I was wondering why the MediaTek DRM driver implements a lot of
> the GEM functionality itself, instead of using the GEM DMA helpers.
> From what I could tell, the code closely follows the DMA helpers, except
> that it vmaps the buffers only upon request.
>
>
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/med=
iatek/mtk_drm_gem.c
> index 9f364df52478..297ee090e02e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -239,6 +239,7 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj=
, struct iosys_map *map)
>         npages =3D obj->size >> PAGE_SHIFT;
>         mtk_gem->pages =3D kcalloc(npages, sizeof(*mtk_gem->pages), GFP_K=
ERNEL);
>         if (!mtk_gem->pages) {
> +               sg_free_table(sgt);
>                 kfree(sgt);
>                 return -ENOMEM;
>         }
> @@ -248,11 +249,13 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *o=
bj, struct iosys_map *map)
>         mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
>                                pgprot_writecombine(PAGE_KERNEL));
>         if (!mtk_gem->kvaddr) {
> +               sg_free_table(sgt);
>                 kfree(sgt);
>                 kfree(mtk_gem->pages);
>                 return -ENOMEM;
>         }
>  out:
> +       sg_free_table(sgt);

I think this will cause invalid access from the "goto out" path -
sg_free_table() accesses the provided sg table pointer, but it doesn't
handle NULL pointers like kfree() does.

Regards,
Fei


>         kfree(sgt);
>         iosys_map_set_vaddr(map, mtk_gem->kvaddr);
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>
>
