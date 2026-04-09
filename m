Return-Path: <stable+bounces-235318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPazHB9L12k5MQgAu9opvQ
	(envelope-from <stable+bounces-235318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:45:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E543C6ABC
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD2C301E978
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A251346E71;
	Thu,  9 Apr 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OMMxFUJS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAD3090DE
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717137; cv=none; b=oLqTVS2y8vdDrOfnzL/7IuRYzT13pMIgverrY2AQ9+LED4+GeU7WaYazlX06/Mw9AtdLkY662Pmf0dqu0NvJKObej8dfWXT7k6lc24sMKSHdNie0VZqWuA9mGgdJPlTa8F5PBrvx3dtk8omdGejizb/neGyxa4HLmuSpDNoVnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717137; c=relaxed/simple;
	bh=pA9EE+8123iD5d+ulZpCERyBEbtOJMf9lw0edZ4W2Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwxaNcLcdYEyQbG+eTqpWHFBH4cj93IcNctKr29Cjd3oatsujE5q4QyJ6AKZiPIAUu2fOt4M7JKHx1fyeEfmdEcl2y6npN0uS2OBWFHhouWJZbgYPZNJyUjaBNSX211mOx1r1UPGjkhTGsHR3VsK/xsYfs7zKPf7PljVU+O4dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OMMxFUJS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6701c19e7b3so819424a12.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775717134; x=1776321934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVksIoyxhbKAJWIBPCKOwVsoqnYKoaL1pl2sE2OJfqE=;
        b=OMMxFUJSekalTowfOp8HBwI3L4eHFGlrfjOf0UW3CInhSC6bDT2bCdvxEFn1Y58HLj
         cZPo6LFT3skzrSGBvc2minwLSrVRE4Edo8vswe297kg7iba0Sr7dzDwoMHw75nkeuK4B
         LBWKlBg9Uv2CsV1W1DR3/yPe8l1//DUVXj2BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775717134; x=1776321934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVksIoyxhbKAJWIBPCKOwVsoqnYKoaL1pl2sE2OJfqE=;
        b=WH8m51BJC+dLmmrs/6Vx9vHGEBcWXw8LpWCeCsZ/sKEH/bU9R3NX4DZwldLN0skXwZ
         NeFh5ZtjtGA5a7rey4Fd3Kwh8IPdD3rO2Dm8GHkfXJaJfrKLpLYlnstTq7eKkHgB3PGg
         ji2FhhmI5XaoIVSl30NhkuwZylpHQm1dc6wfAgr8V7z+SpnH/OTfPOrO95RxmP6MnmP8
         h80feV8ns5A5dnuuGuX1cNGKT8AlUvZPf6F09at7ChY2UJll2YtE3SnXhVDCpQ/8rjPd
         4OaqOGxTBKYuYIH2DCW9jOrJC6jop9zMMpwqmiXaOYLCBKJz0+h/Ki/SlMNYUwqzcrSu
         DgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUquO4SdV8Xt1/EVXDVWIJIWMlfegly3WuPmDUQJq+uPNMvyyoHZPS5df1pdIB5xqCycb7bHtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AOE1u+bcj+xZdzN8OgzoXQlNGyS71Un3Oae7+B2YkACskfMw
	cmy6m4s3TXI4ILsAtyNwH0ag2O/Uhflgr/DVj/tJ2MS+6Fak+4VXv3OPQKNynodD9SXIeR0JSLq
	SUTZSOQ==
X-Gm-Gg: AeBDiesYUozEdenwnxuxOUdY0HpLNNsks6bymp9ZvIHFDFPEU11XFH7jmAWLms0mtWp
	8OzHkRDq5atz9e+NS5lMkFAgRwkOUBKCxE0CHXoY8uaU97YjEFZGC86cD1Gu6gIISfmaggsIKe5
	0ltyDFu/c3Hko3u7N0l81WadXwCyjfU6Lh9IFDVnzursCQfr+nikTqqPtUccQK2CDl9Fu3h8/ZP
	gIlj7B6rcbRvYkIY3ykR1sSU6FHP9489zCynmusr9s0grCtfbfDy8SSMSvdrAWnMDSNZRRcWbsd
	LSRUtjto9H3vgKHJWeoM99LkN+jhiZni+LJGERFErZOuraSozIXWUBurEPk3lJrs6zXhjzkJ4Xv
	6YsQsG3uu1AnMAyWbxpI+TRPz6vkf3A999iQ3HMwKBPgnLRGCiCwEkcZ+lG2Pct9Z3BP+Qcu5OF
	Ei7iB6Bj1hhe2YM+KEknpsZXYog/NthpkIbhp8U8eRyBRrJT3hzI/Hm+2kvTnB
X-Received: by 2002:a05:6402:5193:b0:66e:5679:d02a with SMTP id 4fb4d7f45d1cf-67003830a95mr1306835a12.3.1775717133609;
        Wed, 08 Apr 2026 23:45:33 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e1c2be094sm5159039a12.1.2026.04.08.23.45.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:45:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9358dd7f79so82492066b.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3i/IDhiwKlBlJaA3xgrTYQOmHr9jOwyeZltG3w6EPE4+/1S3ziJZSrXMrQNAxYl+RF4g2hRg=@vger.kernel.org
X-Received: by 2002:a17:906:ee84:b0:b98:45fc:241d with SMTP id
 a640c23a62f3a-b9d476accb7mr105701466b.37.1775717130802; Wed, 08 Apr 2026
 23:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-3-jp@jphein.com>
In-Reply-To: <20260331003806.212565-3-jp@jphein.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 9 Apr 2026 08:45:17 +0200
X-Gmail-Original-Message-ID: <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
X-Gm-Features: AQROBzAc4hvG8y78I9rwHMbJivFNTf1X7E7WcQbREXMFtN3c6KPUWYC-6n4Rfhw
Message-ID: <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
To: JP Hein <jp@jphein.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Michal Pecio <michal.pecio@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235318-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[jphein.com,rowland.harvard.edu,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jphein.com:email]
X-Rspamd-Queue-Id: 11E543C6ABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi JP

On Tue, 31 Mar 2026 at 02:38, JP Hein <jp@jphein.com> wrote:
>
> Some USB webcams have firmware that crashes when it receives rapid
> consecutive UVC control transfers (SET_CUR). The Razer Kiyo Pro
> (1532:0e05) is one such device -- after several hundred rapid control
> changes over a few seconds, the device stops responding entirely,
> triggering an xHCI stop-endpoint command timeout that causes the host
> controller to be declared dead, disconnecting every USB device on the
> bus.

A usb device shall not be able crash the whole USB host. I believe
that you already captured some logs and the USB guys are looking into
it. I'd really like to hear what they have to say after reviewing
them.

>
> The failure is amplified by the standard UVC error-code query: when a
> SET_CUR fails with EPIPE, the driver sends a second transfer (GET_CUR
> on UVC_VC_REQUEST_ERROR_CODE_CONTROL) to read the UVC error code. On a
> device that is already stalling, this second transfer pushes the
> firmware into a full lockup.
>
> Introduce UVC_QUIRK_CTRL_THROTTLE (0x00080000) to address both issues:
>
>   - Enforce a minimum 50ms interval between SET_CUR control transfers,
>     preventing the rapid-fire pattern that overwhelms the firmware.
>     50ms allows up to 20 control changes per second, which is sufficient
>     for interactive slider adjustments while keeping the device stable.
>
>   - Skip the UVC_VC_REQUEST_ERROR_CODE_CONTROL query after EPIPE errors
>     on devices with this quirk. EPIPE is returned directly without the
>     follow-up query that would amplify the failure.
>
> The UVC control path is serialized by ctrl_mutex, so last_ctrl_set_jiffies
> does not require additional locking.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: JP Hein <jp@jphein.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 32 +++++++++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h  |  3 +++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 40c76c051..9f402f55e 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -75,8 +75,30 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>         u8 error;
>         u8 tmp;
>

Why don't do you do the rate-limit in __uvc_query_ctrl()?

Are you sure that you only have to limit UVC_SET_CUR?

> +       /*
> +        * Rate-limit SET_CUR operations for devices with fragile firmware.
> +        * The Razer Kiyo Pro locks up under sustained rapid SET_CUR
> +        * transfers (hundreds without delay), crashing the xHCI controller.
> +        */
> +       if (query == UVC_SET_CUR &&
> +           (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)) {
> +               unsigned long min_interval = msecs_to_jiffies(50);
> +
> +               if (dev->last_ctrl_set_jiffies &&
> +                   time_before(jiffies,
> +                               dev->last_ctrl_set_jiffies + min_interval)) {
> +                       unsigned long elapsed = dev->last_ctrl_set_jiffies +
> +                                               min_interval - jiffies;
> +                       msleep(jiffies_to_msecs(elapsed));
> +               }
> +       }
> +
>         ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
>                                 UVC_CTRL_CONTROL_TIMEOUT);
> +
> +       if (query == UVC_SET_CUR &&
> +           (dev->quirks & UVC_QUIRK_CTRL_THROTTLE))
> +               dev->last_ctrl_set_jiffies = jiffies;
>         if (likely(ret == size))
>                 return 0;
>
> @@ -108,6 +130,16 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>                 return ret < 0 ? ret : -EPIPE;
>         }
>
> +       /*
> +        * Skip the error code query for devices that crash under load.
> +        * The standard error-code query (GET_CUR on
> +        * UVC_VC_REQUEST_ERROR_CODE_CONTROL) sends a second USB transfer to
> +        * a device that is already stalling, which can amplify the failure
> +        * into a full firmware lockup and xHCI controller death.
> +        */
> +       if (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)
> +               return -EPIPE;
> +
>         /* Reuse data[0] to request the error code. */
>         tmp = *(u8 *)data;
>
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 8480d65ec..cafc71457 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -81,6 +81,7 @@
>  #define UVC_QUIRK_INVALID_DEVICE_SOF   0x00010000
>  #define UVC_QUIRK_MJPEG_NO_EOF         0x00020000
>  #define UVC_QUIRK_MSXU_META            0x00040000
> +#define UVC_QUIRK_CTRL_THROTTLE                0x00080000
>
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED                0x00000001
> @@ -579,6 +580,8 @@ struct uvc_device {
>         struct usb_interface *intf;
>         unsigned long warnings;
>         u32 quirks;
> +       /* Control transfer throttling (UVC_QUIRK_CTRL_THROTTLE) */
> +       unsigned long last_ctrl_set_jiffies;
>         int intfnum;
>         char name[32];
>
> --
> 2.43.0
>


-- 
Ricardo Ribalda

