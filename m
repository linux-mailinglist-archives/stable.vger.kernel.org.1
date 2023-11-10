Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D47E75DA
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 01:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjKJASi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 19:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbjKJASf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 19:18:35 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7D4683
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 16:18:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e61e969b1aso17035866b.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 16:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575508; x=1700180308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+QzYnLmP4o/hoHhC9dU8TbOe24+y8dJpH5rWAXxVBA=;
        b=fDstD3sy3ciEFDKCW+d5iiy/9yLJrz2g1frVrWIoPURE2KQwDkOVWzq+PwqNxmpZ4v
         yIiqzo6vhU6SSm+fw95JmQZmrproHnk9v5KF4WDaGnA+PKh6GoS35eCe/bXGzQ5IzwSZ
         t25oQ+BN3d8zUCltbIKsIEwqm+LM9/r/pYkmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575508; x=1700180308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+QzYnLmP4o/hoHhC9dU8TbOe24+y8dJpH5rWAXxVBA=;
        b=mIIYlJKAr9Hr7Bmu5RAjCwxge7aaHjdfIDtEl3v+1LutoYke5XGaxu9nrrQI7zrVEa
         RH302tGLuBB8qu1iAYSfXUVRR8P5Kl6jZxhLj2JxGTd+TnZd2uZaD0+UWl+gSpBmQzVE
         bmdGqnmRVwD3OxYrNktVDlfIBIwcp7+hJbhO4cEA0zkKD34glYnMl286RP1dkruam0Sd
         AD8duN5JwOFG7wrbKQKdvgRWt2ZuiLl8A057cpBt3Nm6PFY8nlaxx3GfZqGJI1/U2MW9
         VE3Fa48+mRcva69GSX4zkSeGDPhthMAFLCC8H3ZAhNHVvJklmnFblHuOaLXBp9Tj14MN
         6TBA==
X-Gm-Message-State: AOJu0YwHVcC3t0vEXNifpFwFFsS1VcouClSP7tfqHJi5rUK9xLCg9Lp6
        toxXtHKdfSn19j66NEporcYAbTnwXmqpi4efj5cD7A==
X-Google-Smtp-Source: AGHT+IGiYhdyXRbWZ4YzStJ8zTt0hJ68nn8sPbGoowES7KAKDSoSqulc3IbAhFNFNg7nmJ68zem94w==
X-Received: by 2002:a17:907:9802:b0:9e3:85c9:11f2 with SMTP id ji2-20020a170907980200b009e385c911f2mr5454897ejc.35.1699575508120;
        Thu, 09 Nov 2023 16:18:28 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b0099bd86f9248sm3179086ejb.63.2023.11.09.16.18.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:18:27 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so124055e9.1
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 16:18:27 -0800 (PST)
X-Received: by 2002:a05:600c:34cd:b0:408:2b:5956 with SMTP id
 d13-20020a05600c34cd00b00408002b5956mr277928wmq.6.1699575507115; Thu, 09 Nov
 2023 16:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-3-hsinyi@chromium.org>
In-Reply-To: <20231107204611.3082200-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:18:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0GCcNj+9spKsjk0H2O_u5HP-u-E+QcP0UDTvcHrWy3A@mail.gmail.com>
Message-ID: <CAD=FV=U0GCcNj+9spKsjk0H2O_u5HP-u-E+QcP0UDTvcHrWy3A@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
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
> Rename AUO 0x235c B116XTN02 to B116XTN02.3 according to decoding edid.
>
> Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,=
836X2, NV116WHM-N49 V8.0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v5->v6: split to 2 patches.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Even though this is a fix, it's not super urgent and since it'll cause
conflicts with other changes, so pushed to drm-misc-next rather than
drm-misc-fixes.

962845c090c4 drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
