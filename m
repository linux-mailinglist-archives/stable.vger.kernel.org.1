Return-Path: <stable+bounces-60699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C223F938FC3
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762ED282947
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398116CD06;
	Mon, 22 Jul 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8P8LVyA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA13A8F7
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654257; cv=none; b=lYFvx3TJ/N4uMbVdSkA/zzbhwLpMLFB8Wc8xNH+HaWNc0lQsCvNxcG3tFcx1lbHepln5hpdM8WPw2kdzU2SIaJ7yha1LaGXKVJI6L080aykXvcT8FE+1I8bbMypYArxb/bGel4GMlf/kU4ZAxRLQ8dPEyS8AKHDgh8lMpwc2vQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654257; c=relaxed/simple;
	bh=X8Og4cRRjTFTAVcy3iYNTI7NPvrU8WWaBElWujRSza8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brECFDoj41sLE+Enlha6C2i0Q2uFhGKySKVJrOdkZ7kwJbTXF1MO9oCuCCBIS6zKOm0n9HyMD8z0hb8rnjzMkzP4jMWTLWjHdRLta3F22lNGt7lj8GBUrERytfOaaMACOlDXmcOyTEZPq2zbxEH8CT9GZQ364jACnk3P9DFPk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8P8LVyA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so3188670a12.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721654254; x=1722259054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wTbGlt1EcdcYHcKZI4SFSpYHzZQnoTGlIL/NjhJzDtA=;
        b=k8P8LVyARpwL8AEGZ78nZ2qo2c5ZK4WGL7vy/K+veG6ke6PMT41onq5AUywvLAa+hY
         jatgdu5l2I6NZ8bepmlkrAZcfofGrrxicBAE9+bwDUxO2WGLdgsa9euWAKaGgRSICGwa
         Jx4iAO7q7ATUKbBX/yvejjN0L1EyTd0uoFIww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721654254; x=1722259054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTbGlt1EcdcYHcKZI4SFSpYHzZQnoTGlIL/NjhJzDtA=;
        b=LFnGP0M4EVuXPubN2WBOU8H66NGKXTknARZxylkDhOTTpig2Q2wzKjAV39vtqagoPM
         xRPkG5xIJJ95/NwxnBW2YiXP26iKleV8PyZHNbnlYLdFa4ryWstmY4PK5HpCbjK5elZ+
         BKiEyQbAFtfbtgaV5ksjrWG9Fa0hBzhplLf8rEOCrOKSlJXKJ0HXLubLie4mm9L3+o0T
         4OtNkvZ1cVOskpZRvlK0u1LT1//PbaKh1U3n2cErCRYgT/E7BhuhXdi2NcSczOMp8mgq
         N91LepFDHuregFpM0fbvJqAmFDzM4u3oR/zlhZ0KXp0jSi55DZTB+bgCirUoCmxROk+M
         LISA==
X-Forwarded-Encrypted: i=1; AJvYcCXCdS+xq7lbdpge94cuEBTjt/OO/gQZrx1qfB+NPUUH+igXvZtaHvCAIz5vmBPuePp7ydj9qH36tKeDgt3h3L0xiHHoil6Q
X-Gm-Message-State: AOJu0YyO0d50wR0LdPihfVcwu7gdSC9CbIO0Y/DOB5lpefribVM/2eZw
	FNPJ6kI44HWv2Kv/dcjABdK5UyXyNeJyJ+rqDmZeZH8uyn0WrlHpCmYQVqdD5YAqXHQ0RxFi1iZ
	mBg==
X-Google-Smtp-Source: AGHT+IFn7XInCts+fIv54oHN2XmtU5umqW0l6AOmGNRu26uizrxSHcHmhJT/sX++j5v98vVt74zbqw==
X-Received: by 2002:a05:6402:510e:b0:5a2:8bf2:92c6 with SMTP id 4fb4d7f45d1cf-5a3ef3792e8mr6283448a12.21.1721654254147;
        Mon, 22 Jul 2024 06:17:34 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d213csm6082001a12.80.2024.07.22.06.17.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 06:17:33 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so3434319a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 06:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVykUSvkSDcQn6+YG32emHpW7uWExEMepnpnXTp3+2SAdaI/0jaVAcgZs7ae/WBeiTMsGliwlJzjMzjrbgwNQDix3z4DHpq
X-Received: by 2002:a17:906:ce57:b0:a72:b055:3de0 with SMTP id
 a640c23a62f3a-a7a01116219mr1036992766b.6.1721654252644; Mon, 22 Jul 2024
 06:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-fix-filter-mapping-v2-1-7ed5bb6c1185@chromium.org> <20240722122211.GF5732@pendragon.ideasonboard.com>
In-Reply-To: <20240722122211.GF5732@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Jul 2024 15:17:17 +0200
X-Gmail-Original-Message-ID: <CANiDSCs1nuvG1XF1XUAJVvkrbe_bVnvqyTR7gvHDdQ8k0M4pLA@mail.gmail.com>
Message-ID: <CANiDSCs1nuvG1XF1XUAJVvkrbe_bVnvqyTR7gvHDdQ8k0M4pLA@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Fix custom control mapping probing
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 14:22, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Jul 22, 2024 at 11:52:26AM +0000, Ricardo Ribalda wrote:
> > Custom control mapping introduced a bug, where the filter function was
> > applied to every single control.
> >
> > Fix it so it is only applied to the matching controls.
> >
> > The following dmesg errors during probe are now fixed:
> >
> > usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
> > usb 1-5: Failed to query (GET_CUR) UVC control 2 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 3 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 6 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 7 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 8 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 9 on unit 2: -75 (exp. 1).
> > usb 1-5: Failed to query (GET_CUR) UVC control 10 on unit 2: -75 (exp. 1).
> >
> > Reported-by: Paul Menzen <pmenzel@molgen.mpg.de>
> > Closes: https://lore.kernel.org/linux-media/518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de/T/#t
> > Cc: stable@vger.kernel.org
> > Fixes: 8f4362a8d42b ("media: uvcvideo: Allow custom control mapping")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I'll add
>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> from v1 and fix the reported-by tag.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>

Thanks :)

> > ---
> > Paul, could you check if this fixes your issue, thanks!
> > ---
> > Changes in v2:
> > - Replace !(A && B) with (!A || !B)
> > - Add error message to commit message
> > - Link to v1: https://lore.kernel.org/r/20240722-fix-filter-mapping-v1-1-07cc9c6bf4e3@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 0136df5732ba..4fe26e82e3d1 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2680,6 +2680,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >       for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); ++i) {
> >               const struct uvc_control_mapping *mapping = &uvc_ctrl_mappings[i];
> >
> > +             if (!uvc_entity_match_guid(ctrl->entity, mapping->entity) ||
> > +                 ctrl->info.selector != mapping->selector)
> > +                     continue;
> > +
> >               /* Let the device provide a custom mapping. */
> >               if (mapping->filter_mapping) {
> >                       mapping = mapping->filter_mapping(chain, ctrl);
> > @@ -2687,9 +2691,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
> >                               continue;
> >               }
> >
> > -             if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> > -                 ctrl->info.selector == mapping->selector)
> > -                     __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> > +             __uvc_ctrl_add_mapping(chain, ctrl, mapping);
> >       }
> >  }
> >
> >
> > ---
> > base-commit: 68a72104cbcf38ad16500216e213fa4eb21c4be2
> > change-id: 20240722-fix-filter-mapping-18477dc69048
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

