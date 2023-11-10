Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FB7E75CE
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbjKJASC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 19:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbjKJASB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 19:18:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45771FEA
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 16:17:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54366784377so2368279a12.3
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575476; x=1700180276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86AHDKme0oU/mK4LbTg0+f9o2KRKUMP2vouZ/vFV6kM=;
        b=BqnIahjEqXb6bfyUEIL6vDApH1h7ux/OBzoMeEgKnjGCMMNKQ3I55CcvgclnPzBY3Y
         3GclvI/jS1C8LfagOEh3aDWEX5/q4gDvHHWySbhZgLzh38wwmDDVUwfpQw1aqpfM5HrI
         pivThmLqSeq09z3FHeotJpVzJsM6L4ES3QfR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575476; x=1700180276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86AHDKme0oU/mK4LbTg0+f9o2KRKUMP2vouZ/vFV6kM=;
        b=ENFMNQN1y2C7becdyRzsXEVtiSrANX/39icBwR1AGVdRrD0lcxg0ZnpmOiwMmPN0OR
         Ys69ihAC62M+pudnHiqxQ6vtde9gS2TFHfkX+N+BxFtkY/k3gip1p9uhhto2D/fLc3lY
         mSifD8pKsLC7ZU90uo6B1+UUrIoODNgOeW4cvd/6cq6omv9Pz5X35aRXsHWBFlN1R78H
         sbeZo0aoEJpphqvC7SYcXrXgEZGelkL1MwrLKFAZ0EuShCuN6YpxqgpgiViUN+Y1cUrp
         LrY84MTtIq6QKZRvExInlnRj4rcc0iSD97mfhSre1KYPdPgEM8T0Y0x5Z/cfNU8kr6NR
         F/9Q==
X-Gm-Message-State: AOJu0YyDjo+Mv7zF46JeykAgKPfhD6eOzITm1TNRcHH3ntQ7kTRU3y6l
        +XMd9IAbffjCLvO6U4vX3d1t74QgDl/tQqCavW5mVg==
X-Google-Smtp-Source: AGHT+IGgvoxxa7/hr0s2dfelnEeaCFBbPSRUd2e9fqP7jVgXHx7JfiiqeLA3mMFxfFqpNdOtF9XPHw==
X-Received: by 2002:a17:906:db06:b0:9de:4007:d676 with SMTP id xj6-20020a170906db0600b009de4007d676mr6263685ejb.16.1699575475685;
        Thu, 09 Nov 2023 16:17:55 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id bm25-20020a170906c05900b009c0c511bd62sm3168087ejb.197.2023.11.09.16.17.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:17:54 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40837124e1cso137775e9.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 16:17:54 -0800 (PST)
X-Received: by 2002:a05:600c:2195:b0:404:74f8:f47c with SMTP id
 e21-20020a05600c219500b0040474f8f47cmr277112wme.5.1699575474598; Thu, 09 Nov
 2023 16:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-2-hsinyi@chromium.org>
In-Reply-To: <20231107204611.3082200-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:17:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UDWNhuBPBUWJNa9E7njYwxJ=zsGqMb=u5CkDGs5UkHzw@mail.gmail.com>
Message-ID: <CAD=FV=UDWNhuBPBUWJNa9E7njYwxJ=zsGqMb=u5CkDGs5UkHzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01
 name and timing
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 12:46=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
> auo_b116xak01: T3=3D200, T12=3D500, T7_max =3D 50 according to decoding e=
did
> and datasheet.
>
> Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v5->v6: split to 2 patches.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Even though this is a fix, it's not super urgent since it'll cause
conflicts with other changes, so pushed to drm-misc-next rather than
drm-misc-fixes.

fc6e76792965 drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timin=
g
