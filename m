Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAD7A156A
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjIOF2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 01:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOF2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 01:28:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56B2D54
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 22:28:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso2517886e87.1
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755696; x=1695360496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn9oFhHLAknaWRf3uArqHTLA9prBJhnE4LW7Dd164uA=;
        b=dK+HDjyZaIzzWjOpKGliaqyaq/IuzoIhWNmB8yFOe3y4+beIdkyiw3y4C+DO86gi5Z
         AQEBqzuRuIB+l5fp3AsZavt6Lz/jrs3lfLVPhX4ZEpJm1WJvceXX/P831J+WFK8f1/it
         eIQBvIggVMaXhLBOOAxyvA/w4SoUn970h/sCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755696; x=1695360496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn9oFhHLAknaWRf3uArqHTLA9prBJhnE4LW7Dd164uA=;
        b=Ar6lmdgLQ9y+PKOTmR5w+Zt2ANlDlCXBJwCN8iOpdDOpGF/zAEsY+0wILC053nDmGN
         6YTfX8rgcTNEEL+jKc++z4tfP1e5xhWlo9yJ7KxlGsdYkWATHvLY2QVAyeHq5NR+hF2l
         z64JdPgXfVPCt7sKizY19BFh7X1d4fFmdaCeeehHWArRYxrGxelKTPhRGMgrHNSKXzDI
         Ig1Q5zgEJdG2FqynnshYPwI0VOGN91o75Mc2uoNdtYDfurSX9brV6KEKZiHVsi6NpRUq
         xz96ace0YnbM4LmT/skVd3hntRH/mGeha5AZVU5YdXPOt64RMKUgZvnLrq3LVpVuiWk/
         zB7g==
X-Gm-Message-State: AOJu0YzC0RXCXjwwItdXOyvPDKNTsKVtr+3q7EJDneXk5yJx19E276jB
        7Cxyb6cc24apcadPRBkbsD2IvKQQ1Zq3jdzO8J1s3w==
X-Google-Smtp-Source: AGHT+IHBF/LZiSOCHbF9PK/ZZsZw9DLkRfLiviBg8ZInp/Df/pEH0sQClGR3SSNslHwvIhnE/oLD3Fo+uCtKqC7O+9w=
X-Received: by 2002:a05:6512:48c9:b0:502:d639:22ed with SMTP id
 er9-20020a05651248c900b00502d63922edmr518597lfb.48.1694755696091; Thu, 14 Sep
 2023 22:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131058.2472260-1-jani.nikula@intel.com> <20230914155317.2511876-1-jani.nikula@intel.com>
In-Reply-To: <20230914155317.2511876-1-jani.nikula@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 15 Sep 2023 13:28:04 +0800
Message-ID: <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 audio detection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> The sads returned by drm_edid_to_sad() needs to be freed.
>
> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
> Cc: Guillaume Ranquet <granquet@baylibre.com>
> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Looks correct to me.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
