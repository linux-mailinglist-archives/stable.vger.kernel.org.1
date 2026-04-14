Return-Path: <stable+bounces-237786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEyCBMIZ3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20AB3F8DF2
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B50153006162
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B83D8137;
	Tue, 14 Apr 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+GiuLWh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D633D7D96
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163245; cv=none; b=YbRyD+21SeymrwyuuBppyYhxDu0uneZYSwYDs8PLxU6cz1EPp+kpLIwddOzCHbM8j6ZOQo0QTGRTrk1eXPYqs65EGSJlMWkSWsRnUsyU7Dy+avabq7MLi/IH74BlyH+DhPED9YtXsdxC+MUyAXFzuVKbNt1/g5WtPX8l6wVYAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163245; c=relaxed/simple;
	bh=grC/g4ZH4PFK1NAhL5Ld3Spj9tmiHlNgJodsMOhivUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMmHKJYt92yRVS1NAz1z2iszcGbxWzdnwW/SKdVectXgvPsHKscHwjaSBnKSsQsmHKMEsciPMCYvnaIg92WLKj7wYriIrRgKHmPg/J3Q5IaVumOgMfwT2PBjzxq0QdyhXvWBWXd/fFHLBcuR9mj++B/eE5ubTULEY3e8JHaSb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K+GiuLWh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f9568e074so857732266b.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776163236; x=1776768036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSSXpcMNMpGp9jKohMZiXzdZCQZ5HzhgwQXsH9TGwik=;
        b=K+GiuLWhIKU4xOMa3Yu0RN/ZKNm5n0mC1r+9CyDD9HFrDGUXL2L2Ak3reJcu4U9EdC
         wRS+WBfeqKOlKbpPPyEPRLVSD1LaUjf2UUkGmb9r6E1QS9f8TCFSLHLesTtrMBAmqTVJ
         KLTiTugEaBX0kqU+fU+8pM7mz6ieb4IRmmMww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163236; x=1776768036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSSXpcMNMpGp9jKohMZiXzdZCQZ5HzhgwQXsH9TGwik=;
        b=egRn6ztn4+Yxu1rs1uu8dWQFb/uve2MOXIWk++0Mg7iQ2zE4Pcw/5RJUK03Bb0JT2b
         sKO2F5vp76cmeKFnacKadpxDIHf1b0Rq8weJXjQvuKuxd5Wz92Q53ax0Sgfeicf5W2Oc
         jAScbNSpCrmegbgSh0KSv7jxon0okwoba+Yhyo421b2PlZbJdY4A1vh1FIOEnBAz/1qC
         YI+pyr1EioWD5k3o3HTqpwhjXnQxlPPAe7PCJYwxReZ2hId6KzWr+kj9Rb7+G8J3KDnp
         gTa3pwpfz1GqiUm3NqJ/BpSOfRmyt6Js5SqWVg8CUR8kzmxsmf4SsyrOru2obx2LbKqK
         Ts8w==
X-Forwarded-Encrypted: i=1; AFNElJ8u8B/WKlz+7cgYMZCoKFWW4Yw3DQc/6z6zqnspZGXH6ebSgIP9WFDt613HTnIKPoDGcoO/XAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIzfJKKeqPgGsrGpiHvx2/KAG9lQ7QhCwiHAZJOSpMwJpaGI09
	5ATXE8Rc5OayLsTo6DzG/aGpy8u+OWOkbwMot++Md5ic1usF++GXdU8AnkBrFBRs13FoxZ20XiG
	b7z+dPQ==
X-Gm-Gg: AeBDiesBNYyKn8RtFC4Nja2mbvZBwNWJ6UMqbHElmYJb+ev1SggIC7QQo0FoAhdWnND
	BDaurojoZWRYHfz6qo/N9zzJ+YXKLRkpnso5AZ1k10McapkEMZHz7Q/soanVOkFEdZG/Kxs1lLB
	teVNuBw4BAPrPkH6pijK6/EGaQDxdG6kUYQ8GAa0Fcg+3m7V71rTGRFhO/oWbNCY0J9HssclOF3
	AWHbVxEZ3isszxa+6N607AWYSScWHNNQFEnHZlhkQw94JfkTn8Di1E/RZNpiYAxektyLpYYEWst
	mR3eA+NT/7XbjhQLg3OWuWx2fb7i6wXnhlv0hkfMVqrfuZgB0WJtcnVW9yqnEaNW1qHXJGFTfmU
	9YYmz9oZNMWqR07uN4lMQULIs3wDSjioPV7YkxyuX1wRoEiapMve6iqTEQwHNRlzp+BCSIe+++z
	kTtmpwUohw4WY2F1Cmvok6ui0VM0z6p8hzRIWow4LNH8xv7V/zC5sdUKTvXsZC
X-Received: by 2002:a17:907:c928:b0:b9b:fa57:d5b0 with SMTP id a640c23a62f3a-b9d7267b4damr660748166b.43.1776163236285;
        Tue, 14 Apr 2026 03:40:36 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a13sm386215866b.53.2026.04.14.03.40.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:40:35 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso709508666b.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iK2RZ60werZzNzSu4T9wZmCHqwjxz3eCsPmXlutJBWEwheT6flbSmsCLBIG/SVOCgLjUYJ8k=@vger.kernel.org
X-Received: by 2002:a17:906:9fcc:b0:b98:6926:13cb with SMTP id
 a640c23a62f3a-b9d724361eamr959556866b.9.1776163234098; Tue, 14 Apr 2026
 03:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-backport-bpi-v1-1-5b62c6798ccf@chromium.org>
In-Reply-To: <20260323-uvc-backport-bpi-v1-1-5b62c6798ccf@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 14 Apr 2026 12:40:22 +0200
X-Gmail-Original-Message-ID: <CANiDSCvC3KmQKryuAJ=BENo+8eH-VfGKfsWTKLjVBt+UHh34EA@mail.gmail.com>
X-Gm-Features: AQROBzBE8CIyPWh1iBfXYTcJKwcNLn2fmHTe43mUfxh1axMbSzXjnJwpY7ixLDo
Message-ID: <CANiDSCvC3KmQKryuAJ=BENo+8eH-VfGKfsWTKLjVBt+UHh34EA@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Undup use uvc_endpoint_max_bpi() code
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: A20AB3F8DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear stable



On Mon, 23 Mar 2026 at 14:03, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> [ Upstream commit 5b9c75c794ce041e6e00789efef75d71915c4f4c ]
>
> Replace manual decoding of psize in uvc_parse_streaming(), with the code
> from uvc_endpoint_max_bpi(). It also handles usb3 devices.
>
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> The commit: 9764401bf6f8 ("media: uvcvideo: Fix bandwidth issue for Alcor
> camera"), which has been backported to 5.4+, depends on this patch.
>
> Without it, cameras connected to USB3.0 will stop working properly,
> because the bandwidth quirk will be applied wrongly.
>
> Please help adding this patch to 5.4, 5.10 and 5.15.

Is there any update on this?

Regards!


>
> Thanks!
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 4 +---
>  drivers/media/usb/uvc/uvc_video.c  | 3 +--
>  drivers/media/usb/uvc/uvcvideo.h   | 1 +
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 858fc5b26a5e..4ee187a503b8 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1007,9 +1007,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
>                                 streaming->header.bEndpointAddress);
>                 if (ep == NULL)
>                         continue;
> -
> -               psize = le16_to_cpu(ep->desc.wMaxPacketSize);
> -               psize = (psize & 0x07ff) * (1 + ((psize >> 11) & 3));
> +               psize = uvc_endpoint_max_bpi(dev->udev, ep);
>                 if (psize > streaming->maxpsize)
>                         streaming->maxpsize = psize;
>         }
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index f868a13280a1..fb69d534e299 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1797,8 +1797,7 @@ static void uvc_video_stop_transfer(struct uvc_streaming *stream,
>  /*
>   * Compute the maximum number of bytes per interval for an endpoint.
>   */
> -static unsigned int uvc_endpoint_max_bpi(struct usb_device *dev,
> -                                        struct usb_host_endpoint *ep)
> +u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep)
>  {
>         u16 psize;
>         u16 mult;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 95af1591f105..f5bc9fa2c385 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -920,6 +920,7 @@ void uvc_simplify_fraction(u32 *numerator, u32 *denominator,
>  u32 uvc_fraction_to_interval(u32 numerator, u32 denominator);
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
> +u16 uvc_endpoint_max_bpi(struct usb_device *dev, struct usb_host_endpoint *ep);
>
>  /* Quirks support */
>  void uvc_video_decode_isight(struct uvc_urb *uvc_urb,
>
> ---
> base-commit: 91d48252ad4b17577cf8cc8d3e1353402e4da8f1
> change-id: 20260323-uvc-backport-bpi-68368ef14173
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


-- 
Ricardo Ribalda

