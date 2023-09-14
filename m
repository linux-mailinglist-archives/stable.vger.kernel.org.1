Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8717A063F
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjINNkV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbjINNkE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 09:40:04 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F549C0
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:38:47 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1d651ab1d77so57617fac.1
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694698724; x=1695303524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmkM3eTScVXDHH0jlpqEzGVs0jKDHtYdRBTAlD8i+NE=;
        b=WHSGpmzDv7YQ6LAEcUfCTvT+zySYeHW9piPmwbEBMNrKob5+FuKksuJrlgy7l8ReIq
         FJtgDqp2sKw9dvyZvBaW29kSB0zhle1NfNM/JZOUEAH89t6PH2YTcb9qWCOVQVjJWaSr
         VZvKKLg4HQzO+tWBy2jg0McK9ZL5UYNb0yOneJp5gs/kmY3u+hRiqRkvV9TVrset2AN6
         zF8NjyQ2idIHuxv1McBDLoX9tROHuG81fv/yMHIHdzyUwKmNbhMWLK1ZDjd7pJPVsb+z
         OT/Krp0yes9OMZGNqHhYcvNWXXPOiBIqIrR3ibiMF+y8hdQWaTb5fWmzmKT+OoxUhA0G
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698724; x=1695303524;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmkM3eTScVXDHH0jlpqEzGVs0jKDHtYdRBTAlD8i+NE=;
        b=SKZfj96O1z1z5ZpwNZ6j1FQ85At4/YH4sW4vrxKh5lt2BDXhB8aUyCz8zHBEmk9bbb
         oU8eO0JHYreOhK38c8T2MjJ0v89qdvHol5IBW1yEphv0a2s8WY05bdN/g4v37DoUIQUZ
         jnuYEvscNd3SgWjgvzBFRrGJKTnIgzBBTJrMavXHEKotWP668SMI6np1mHjLdKk28G37
         IGtj5UPP8Y5fk2ZwCWMXrYr+toDP6/wxUGmjyWpbg+U0hwEY+Xs7zySXVhRCmyjtAnIr
         8987BD3VqbEq9pWb7rxLKa2lsyPRcWdF1rYHqeZ8GLDzFhw0z1aYY9DwkgwlmNXr3WTl
         BL/w==
X-Gm-Message-State: AOJu0YwwwGaLCUKI/2YT7GQAZrOKfOXW12+fYe1vncbswUUwiOkKLPe3
        FlYFaD15OD5FzsAUB/2t+0BxJQff2fxa5pG0JsL2rw==
X-Google-Smtp-Source: AGHT+IFh7Yh89j5toiLrapBEM+lFJrnPKMRKQDggX4YR83wnaK2tnE/8N6Y+YLTaga5Qlr9XmuCrRhn8q0u0c8VABfw=
X-Received: by 2002:a05:6870:b69d:b0:1d5:b0b9:f6f1 with SMTP id
 cy29-20020a056870b69d00b001d5b0b9f6f1mr6386214oab.8.1694698724531; Thu, 14
 Sep 2023 06:38:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Sep 2023 13:38:43 +0000
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.3
References: <20230914131058.2472260-1-jani.nikula@intel.com>
In-Reply-To: <20230914131058.2472260-1-jani.nikula@intel.com>
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 13:38:43 +0000
Message-ID: <CABnWg9sy_u5+TRvuRXEN8FB8BGdSadYimUQ-R6=PYEKZn2RZRw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 error path
To:     Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 14 Sep 2023 15:10, Jani Nikula <jani.nikula@intel.com> wrote:
>Setting new_edid to NULL leaks the buffer.
>
>Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
>Cc: Markus Schneider-Pargmann <msp@baylibre.com>
>Cc: Guillaume Ranquet <granquet@baylibre.com>
>Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
>Cc: CK Hu <ck.hu@mediatek.com>
>Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>Cc: Philipp Zabel <p.zabel@pengutronix.de>
>Cc: Matthias Brugger <matthias.bgg@gmail.com>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-mediatek@lists.infradead.org
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-arm-kernel@lists.infradead.org
>Cc: <stable@vger.kernel.org> # v6.1+
>Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>

Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>
>---
>
>UNTESTED
>---
> drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>index 2cb47f663756..8fc6eff68e30 100644
>--- a/drivers/gpu/drm/mediatek/mtk_dp.c
>+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>@@ -2049,6 +2049,7 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
> 	 */
> 	if (mtk_dp_parse_capabilities(mtk_dp)) {
> 		drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
>+		kfree(new_edid);
> 		new_edid = NULL;
> 	}
>
>--
>2.39.2
>
