Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777B87E5BEE
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjKHRE3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 12:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHRE2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 12:04:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB31FF5
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 09:04:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c41e95efcbso1076890966b.3
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699463063; x=1700067863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDcupbe+5qAO0hhDSEHW5GSzZCVe/uaRnl7TSsp+HAs=;
        b=c+mj0HTRDTOZsSPLdBU/bRSzOqDm45aOl/QVkXiYrkZpNsqrJoIkXx+cCCUDUbp92o
         HNl2oTYR7fJEelj6pAeHxDy+0tnU7KEmMP9PER6RvOYHGavNzmUHZDg/N3KISbeiwclF
         45jIy3vRKO4pRjtFImsbTDP5NCIWtxAFEBAms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463063; x=1700067863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDcupbe+5qAO0hhDSEHW5GSzZCVe/uaRnl7TSsp+HAs=;
        b=bvoSXBvaTt22Z8pab1h6tNjJRZDvS9MqaqYScQD/BgljJfvimb1z1WaJv5jA+eQH32
         IXmKpcp0UJUkKfTcfptl4oi0rC7ccrTGgkL8JkVoLERJndzMhqKWzAaHHQE6TK7Eb9Cg
         OCN+aicV94UNslRkQhJ5VZEQuX9ijqL19wxzphHSjQV5ccFU8ZIkg7Gvr70JoRKdlm3M
         sGM1NGPtGbgRbnKcbacksGL/E4HrDoCaQlps+9CO4edDGvL+LIwPJWfV37MpSJbJUz4I
         EG1KSH18MNDZypc4CKpi59ro/fmif6XLITsjR2OPaumneIU0TOAjlJwcHyFyBfh/nZE/
         rdqg==
X-Gm-Message-State: AOJu0YxScCGtX5bKIpVPnEAgxLWcwkWcQ+kYXYBD2nZcwylSRk7JiNIi
        /rqTTh/vUj3SGhLLDhPYMJEtI4u/b5eZjprF/8tMNX6z
X-Google-Smtp-Source: AGHT+IFE+hC8ZXyPXrHNgnNwnl1CuHiqM4L5WJv5XYmZ6lm60iR7pV2Y4ujyuVIbO2OOWm7RvLWWSw==
X-Received: by 2002:a17:907:9620:b0:9be:ab38:a367 with SMTP id gb32-20020a170907962000b009beab38a367mr2308359ejc.16.1699463063222;
        Wed, 08 Nov 2023 09:04:23 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7d44d000000b00542df4a03d0sm6814666edr.16.2023.11.08.09.04.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:04:23 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso96425e9.0
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 09:04:22 -0800 (PST)
X-Received: by 2002:a05:600c:3110:b0:405:320a:44f9 with SMTP id
 g16-20020a05600c311000b00405320a44f9mr219580wmo.5.1699463062323; Wed, 08 Nov
 2023 09:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-5-hsinyi@chromium.org>
 <xnyf3ul7pwsgrmxgbareh5lhhmpfuvfksj3nyd4zmup7khaer2@fbwgbrq4vywb>
In-Reply-To: <xnyf3ul7pwsgrmxgbareh5lhhmpfuvfksj3nyd4zmup7khaer2@fbwgbrq4vywb>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Nov 2023 09:04:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
Message-ID: <CAD=FV=WuwJGsDraFt=i0NbN-HkocsYgL=kCrZTxqVN+Oo1u8pg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/panel-edp: Add override_edid_mode quirk for
 generic edp
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

On Wed, Nov 8, 2023 at 7:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> > @@ -575,9 +599,18 @@ static int panel_edp_get_modes(struct drm_panel *p=
anel,
> >
> >               if (!p->edid)
> >                       p->edid =3D drm_get_edid(connector, p->ddc);
> > -
> > -             if (p->edid)
> > -                     num +=3D drm_add_edid_modes(connector, p->edid);
> > +             if (p->edid) {
> > +                     if (has_override_edid_mode) {
>
> It's not clear to me why the override mechanism is only there when
> there's a ddc bus?

I think you're confusing the two different (but related) issues
addressed by this series. One is when you're using the generic
"edp-panel" compatible string. In that case the mode comes from the
EDID and only the EDID since there's no hardcoded mode. We need a mode
override there since some EDIDs shipped with a bad mode. That's the
subject of ${SUBJECT} patch.

The second issue is what to do with a hardcoded mode. That's the
subject of the next patch in the series (patch #5). Previously we
merged the hardcoded and EDID modes. Now (in the next patch) we use
only the hardcoded mode. There's no need for a fixup because the mode
is hardcoded in the kernel.


> You mentioned before that you were following panel-simple,

As of the newest version of the patch, it's no longer following
panel-simple in response to your feedback on previous versions.

> but that's a
> clear deviation from what I can see. If there's a reason for that
> deviation, that's fine by me, but it should at least be documented in
> the commit log.

I think the commit log is OK. I suspect the confusion is only because
you've reviewed previous versions of the series. Please shout if
things still look confusing.


> > @@ -950,6 +983,19 @@ static const struct panel_desc auo_b101ean01 =3D {
> >       },
> >  };
> >
> > +static const struct drm_display_mode auo_b116xa3_mode =3D {
> > +     .clock =3D 70589,
> > +     .hdisplay =3D 1366,
> > +     .hsync_start =3D 1366 + 40,
> > +     .hsync_end =3D 1366 + 40 + 40,
> > +     .htotal =3D 1366 + 40 + 40 + 32,
> > +     .vdisplay =3D 768,
> > +     .vsync_start =3D 768 + 10,
> > +     .vsync_end =3D 768 + 10 + 12,
> > +     .vtotal =3D 768 + 10 + 12 + 6,
> > +     .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > +};
>
> That should be a separate patch

That's fair. I didn't think it was a huge deal, but I agree that it's
slightly cleaner.

-Doug
