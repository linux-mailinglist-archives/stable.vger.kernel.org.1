Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1C7D396B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjJWOgA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJWOf5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 10:35:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68590D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 07:35:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso476635566b.2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698071753; x=1698676553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thBbcDnCCIr+oLSwwKxaUY7Kp5osFavsrH9yvSs64sE=;
        b=AhRMXKgRn9IeisWo1mZT4XCmXWYG9KNo+WcAugTd6GkpG0bLvCQ7LmZX8457OPalCS
         n7doX6PGsKfD29iQEeY0zLd9qki7nzlNzjbeRJVYTRo9y7gP8laExLV/v6WVMCusQ9s6
         NT5YtYzN5XzY2z9crL8TLMQJZfMB91w4pKjHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071753; x=1698676553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thBbcDnCCIr+oLSwwKxaUY7Kp5osFavsrH9yvSs64sE=;
        b=iWhgp5PjSxru1U1mLJVmjw+yrSbGWA0Vm1FA4r3QzYkOmbyWEmBhoQ1BRsSdrjSYMw
         UqMz1obpcrsiwE9rIXr2QkqQxkX/AhdTdyxmG6jcdhsaq0KCBUsJEbPLn5zps5kYnE3S
         FhvjIuSOXyjAqwiMszx38J7v2IdtITjwMBUhVXBKBLr8aAGukGPXASL0aDXXIMvdJoxw
         ezmB578mtUF1IhcKnU4Ywrw/866dkRjmOlKXAw3dqo39QHsn7mUAsZqpTi9qa2cSYiuG
         fTvuPgJ5pxloGhsVNdgEDopPEV4qAYNJfni7D5kYs9GAY8shakIAJSrs+DMHFIuu4FG+
         WhlA==
X-Gm-Message-State: AOJu0YxLwR6mCdKAkj9nPRyjIDgtGgAd/LX/1BEtxWmGbHzKcSc+hH9Q
        COWOJbZvgL+0m3UpURj1uQ8cO1ZyaFIJWEgSpEfsnw==
X-Google-Smtp-Source: AGHT+IGW8sS2Fq8zBF7GJbAqo+JMQIlsGrlZnokwvWJ824QJEOYGkj/D+MsJH2UuBN4is2TPWW2fcg==
X-Received: by 2002:a17:907:7da9:b0:9b2:982e:339a with SMTP id oz41-20020a1709077da900b009b2982e339amr7618770ejc.22.1698071753140;
        Mon, 23 Oct 2023 07:35:53 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090657d100b009c5c5c2c59csm6966551ejr.149.2023.10.23.07.35.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:35:52 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so80515e9.1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 07:35:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4a22:b0:408:2b:5956 with SMTP id
 c34-20020a05600c4a2200b00408002b5956mr278445wmp.6.1698071751787; Mon, 23 Oct
 2023 07:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104833.832874523@linuxfoundation.org> <20231023104839.191685463@linuxfoundation.org>
In-Reply-To: <20231023104839.191685463@linuxfoundation.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Oct 2023 07:35:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XV9csGb273q8eam8bAPFR91a9p8DULCZ_Mm6bW0pBQ0w@mail.gmail.com>
Message-ID: <CAD=FV=XV9csGb273q8eam8bAPFR91a9p8DULCZ_Mm6bW0pBQ0w@mail.gmail.com>
Subject: Re: [PATCH 6.5 219/241] drm/panel: Move AUX B116XW03 out of panel-edp
 back to panel-simple
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Anton Bambura <jenneron@postmarketos.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sasha Levin <sashal@kernel.org>
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

On Mon, Oct 23, 2023 at 4:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Douglas Anderson <dianders@chromium.org>
>
> [ Upstream commit ad3e33fe071dffea07279f96dab4f3773c430fe2 ]
>
> In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
> panel-simple") I moved a pile of panels out of panel-simple driver
> into the newly created panel-edp driver. One of those panels, however,
> shouldn't have been moved.
>
> As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
> B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used in
> exynos5250-snow and exynos5420-peach-pit where it's clear that the
> panel is hooked up with LVDS. Furthermore, searching for datasheets I
> found one that makes it clear that this panel is LVDS.
>
> As far as I can tell, I got confused because in commit 88d3457ceb82
> ("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
> Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
> downstream ChromeOS trees, it seems like some Mediatek boards are
> using a panel that they call "auo,b116xw03" that's an eDP panel. The
> best I can guess is that they actually have a different panel that has
> similar timing. If so then the proper panel should be used or they
> should switch to the generic "edp-panel" compatible.
>
> When moving this back to panel-edp, I wasn't sure what to use for
> .bus_flags and .bus_format and whether to add the extra "enable" delay
> from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
> backlight when power on"). I've added formats/flags/delays based on my
> (inexpert) analysis of the datasheet. These are untested.
>
> NOTE: if/when this is backported to stable, we might run into some
> trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
> jacuzzi: Move panel under aux-bus") this panel was used by
> "mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
> know what to suggest for that other than someone making up a bogus
> panel for jacuzzi that's just for the stable channel.
>
> Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when p=
ower on")
> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple=
")
> Tested-by: Anton Bambura <jenneron@postmarketos.org>
> Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230925150010.1.Iff6=
72233861bcc4cf25a7ad0a81308adc3bda8a4@changeid
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c    | 29 -----------------------
>  drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 29 deletions(-)

I responded to Sasha but managed to miss CCing stable@. My
apologies... Copying what I wrote there:

---

I feel that this should not be added to any stable trees. Please
remove it from the 6.1 and 6.5 stable trees and, if possible, mark it
so it won't get auto-selected in the future.

The issue here is that several mediatek boards ended up (incorrectly)
claiming that they included this panel and this change has the
possibility to break those boards. In the latest upstream kernel
mediatek boards that were using it have switched to the generic
"edp-panel" compatible string, but if this is backported someplace
before that change it has the potential to break folks.

It should be noted that it was confirmed that the "snow" and
"peach-pit" boards appeared to be working even without this patch, so
there is no burning need (even for those boards) to get this patch
backported.

For discussion on the topic, please see the link pointed to by the patch, A=
KA:

https://patchwork.freedesktop.org/patch/msgid/20230925150010.1.Iff672233861=
bcc4cf25a7ad0a81308adc3bda8a4@changeid

---

Sasha has already said he'd remove it from the queue, but responding
here just in case it's important. Thanks!

-Doug
