Return-Path: <stable+bounces-235337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEarBopa12lqMwgAu9opvQ
	(envelope-from <stable+bounces-235337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:51:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B213C7466
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EECF43007AF5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D8386576;
	Thu,  9 Apr 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="aWqTxAh+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F63381AED
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721090; cv=pass; b=Rx4LD+9QAFkBnLjLMRwxkJpql9fmMKcXOgq+Mx9XLtjh+1OmQPvbv4d179E1hvH/ijFdGCg+JpU43rfXO8c/X3xlL31Brk+J76t/AGQil7bYE4cfOSjr13gZ4NWrnEzvRDyOjlcJWHhN7x2CJIxoZ4C+Xc0mK4PjZALXuJNw31Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721090; c=relaxed/simple;
	bh=C7KVOtSC9ooo76nN8CKOmFFkIDMARyug/PSVK9e1yf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKodSClLLbFwien6YioFW74OrCwOL+tMexPNeN5V6T+GsOtn/Vf5fk9l69vksS4btSXvfRy3Z9VELKyjsF4yuWvYmVcCMG9BYr9UPwraD4MxMmJ8gB2Lm6bR2HC5oEx5xDszbRN2m9wUQrw7AA90J4eJKLTsJ37O7WTs+YmLCds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=aWqTxAh+; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65009bfdcfdso638064d50.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 00:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775721088; cv=none;
        d=google.com; s=arc-20240605;
        b=EgqFlTjeBEvBHEK9oJuxaMjfHa6vbPurSg3t+ok1hr0b9QJeEjCOAjG+IMSu2ZyC+s
         PwpsQ45yIE3b5Adv7H7hyotjwT/nX189Qo5lpZZjS+hAnsbhbtijzRE8MAqVRKToyx9/
         cRPJ+r3fnJeSDf+E+cB7dkm14p1Q1Y17IvInxkuS028gW+bAyHqIpLs0yI/XsoiTRAGy
         Y0nAuu5ezmRr9LQERQO/+TK/3SWCKBxeSuW+un4RYd4K54X6dacvJZN1OivHMmbVE4Nz
         hUyYTBWGS+oLYknpGv075n76zFu3NIkL69+mkNXgdN0OXY/1VgF2cz2SViJaze0poKgt
         P/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L6aJUNlSsXw2SpNpH15YLZikxobDr9nZf4oRGaly4Ug=;
        fh=Hl6yH7W6rk4ajm8QY81IsGAAE24eW83sk3o3yPBjgks=;
        b=j1IEaVHC0lrfr7zuPN9cmHwiewFWOa6i5PSlX+Xd0qxySpcRUyUcUHzHCVYr1vczEn
         JlTRSry8KgxjI37IVjeI4VVHUUq3ob2yNfPwu2hTE90HQcYo5yYucM3dxgQyQf90HLlA
         2T4pIntKTJrrGT6xmjqwCJ5NR5RQND/90f6OICd+AQeo9ULyX/xvruws48iZHJJKAG9r
         fOQ37qHw4ME0GcsRhsqmvCxYFGoNrbwQlVAYA7XY/D+6Gl1cARYqclBS+lGfuCFxWEt0
         xhDx2dwfrLjkLdKTSH3sTVghEL4XbM33GjXiCsz5aRjkIiLnUYFC5nCvJEUlTVpXYcHy
         S4pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1775721088; x=1776325888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6aJUNlSsXw2SpNpH15YLZikxobDr9nZf4oRGaly4Ug=;
        b=aWqTxAh+9o+G/ucZf6uWucXiOijyS1pBA3J74G0B5O2GFxOE9hYNH1Ns0D3j/FjgUU
         wwbHjUa+mJDzEHqj8X+65+/jgrzLWxEilue6m1u6hmui4z+Bzs6TuaK80hnE0huy8ub4
         ZaUqHvwxpbMC6k3sZOn6GtycCI8T4xhGC7bDdRPn633erHcTv2+I8gXre8Zeyf+0uUhV
         X2uGdViOF9sMxRCFL6+aokCRBgOe2N5N8YOOG1gYJtN/Sc3pZTsusVq34y4unKof7tR8
         OSiAjAPKlMrWfptmH4dor0FTiA0wlR0JPoLUN77sRCKsSmD+rbi+wMHXYngestT9xw6f
         EbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721088; x=1776325888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6aJUNlSsXw2SpNpH15YLZikxobDr9nZf4oRGaly4Ug=;
        b=nidjMeBvnd/aHlpNTeGoU5YnWUD2fQfh0uibo+4rY/iBavDIOXfglCiAbvF1U2AxS+
         mYTX2bvqTmWB71L4S720OB9+bmqPOxj++1qi4EyPRh05rZEccd1FHjGMEfW1xaOCyGUu
         6mwgnLXwi+7AjC+cJyLIWDrNt/GUPJlXFcnXIS7MeAB+qtCrgKO1JCiq+bZF9kuKv0X3
         nOfF06lOMu31leEOn9YeUsWxZvM+e2cxC+USRDV2NYRxgiosTl7UUdfv5ZmCveWU7tew
         a3K1vPTjJHsP3FPGP0J+xTR+IMA/eZjE58biVehUraLr+nUxGE9aQmkixol/mkxqMe1q
         0aNg==
X-Forwarded-Encrypted: i=1; AJvYcCUH1rda41vsGOaSTdAHk7alu16jJRmPVxn+uFhJNm0UBVW6HezSqDVD+tnGpan7sjWMQ8KcQrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVB/fvEP487O+384w8eAhQ+6NNcqNBxL7ZUJDev+gNcS63CVV
	z25u+6vC80kK1KZE+FwfJFjK1KFTdUhshDawO7hhAO1vfwMA4R+QGQLcS228i27bwkByYEipkta
	afNAKrYv0Vjdn/aGikOlY/IAFo/J3aJ5LeG5wGYDZ
X-Gm-Gg: AeBDievsh8QBKSxGdtC/tND7kE3H4j7dxDxcHK09y01BCr4iYH79D3UeaAttLcLl7fw
	JanFwFjPe7i2gc9buUsvaON0wH236+DCK8tsLruSPlj2kBpQn9hvePRyrZZuV/5QnfX8WONKUyL
	wM1RfnirCidK1hbIcbWgiAHvr3XzSKd4x9EHczNRu3XstDkV0Bh5rLbjSe6uQb14ntA7KkqWRZ9
	Qzpp1h6kEZsMIZAe/h/HXcVMxhueuLablw9gm144BDJ+oTjPT+ipxXpir6AoJvzk2HKMS6Bd3VF
	3ZR2
X-Received: by 2002:a05:690e:191a:b0:650:70da:bc25 with SMTP id
 956f58d0204a3-65070dabc8bmr12098902d50.58.1775721088090; Thu, 09 Apr 2026
 00:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-3-jp@jphein.com>
 <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com> <CAD5VvzAu8+Qz7hEEBzuKvO11X=YD-wrtX3_Tk77g2Cq5rZZD0Q@mail.gmail.com>
In-Reply-To: <CAD5VvzAu8+Qz7hEEBzuKvO11X=YD-wrtX3_Tk77g2Cq5rZZD0Q@mail.gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Thu, 9 Apr 2026 00:51:17 -0700
X-Gm-Features: AQROBzCxJCsnggkClFbbxyjOvF_Wfs6s-qSUVP_xD4dgFk-wRaWBzxMMF5KblRI
Message-ID: <CAD5VvzD6WDEaQF_v+bg63FRV+LB=youG=TjW87D+DBo6ntrBkA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Michal Pecio <michal.pecio@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rowland.harvard.edu,gmail.com,ideasonboard.com,kernel.org,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235337-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:email,jphein.com:dkim,jphein.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17B213C7466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ricardo,

On Thu, 9 Apr 2026 at 08:45, Ricardo Ribalda <ribalda@chromium.org> wrote:
> A usb device shall not be able crash the whole USB host. I believe
> that you already captured some logs and the USB guys are looking into
> it. I'd really like to hear what they have to say after reviewing
> them.

Agreed -- a single device shouldn't be able to take down the host.
Alan Stern raised the same point and asked whether xhci-hcd should
handle this. Michal Pecio noted that the stop-endpoint command timeout
is a controller-side failure and asked for dynamic debug traces on
newer kernels and non-Intel hardware.

I provided the 6.17 traces. The result: the stress test (control
transfers only) now passes 50/50 thanks to xHCI error handling
improvements between 6.8 and 6.17. But starting a video stream still
triggers hc_died() -- the firmware fails to disable LPM during stream
setup, the endpoint stalls, and the stop-endpoint command times out.

So there's an open question on the xHCI side about whether the
controller could recover from stop-endpoint timeouts instead of
killing the HC. The UVC quirks are defense-in-depth -- they prevent
the firmware from reaching the failure state that triggers the timeout
in the first place.

I'm also planning to test on additional Intel machines (and non-Intel
if I can source one) to determine whether the stop-endpoint timeout
is controller-specific, per Michal's request.

> Why don't do you do the rate-limit in __uvc_query_ctrl()?

Good point -- moved it there in v6. This covers all callers including
uvc_set_video_ctrl() which bypasses uvc_query_ctrl() for probe/commit.

> Are you sure that you only have to limit UVC_SET_CUR?

I haven't been able to isolate the crash to a specific query direction
-- our testing shows it's the sustained transfer rate that matters. v6
throttles all query types in __uvc_query_ctrl() to be safe.

v6 posted with these changes.

Thanks,
JP

>
> On Wed, Apr 8, 2026 at 11:45=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
>>
>> Hi JP
>>
>> On Tue, 31 Mar 2026 at 02:38, JP Hein <jp@jphein.com> wrote:
>> >
>> > Some USB webcams have firmware that crashes when it receives rapid
>> > consecutive UVC control transfers (SET_CUR). The Razer Kiyo Pro
>> > (1532:0e05) is one such device -- after several hundred rapid control
>> > changes over a few seconds, the device stops responding entirely,
>> > triggering an xHCI stop-endpoint command timeout that causes the host
>> > controller to be declared dead, disconnecting every USB device on the
>> > bus.
>>
>> A usb device shall not be able crash the whole USB host. I believe
>> that you already captured some logs and the USB guys are looking into
>> it. I'd really like to hear what they have to say after reviewing
>> them.
>>
>> >
>> > The failure is amplified by the standard UVC error-code query: when a
>> > SET_CUR fails with EPIPE, the driver sends a second transfer (GET_CUR
>> > on UVC_VC_REQUEST_ERROR_CODE_CONTROL) to read the UVC error code. On a
>> > device that is already stalling, this second transfer pushes the
>> > firmware into a full lockup.
>> >
>> > Introduce UVC_QUIRK_CTRL_THROTTLE (0x00080000) to address both issues:
>> >
>> >   - Enforce a minimum 50ms interval between SET_CUR control transfers,
>> >     preventing the rapid-fire pattern that overwhelms the firmware.
>> >     50ms allows up to 20 control changes per second, which is sufficie=
nt
>> >     for interactive slider adjustments while keeping the device stable=
.
>> >
>> >   - Skip the UVC_VC_REQUEST_ERROR_CODE_CONTROL query after EPIPE error=
s
>> >     on devices with this quirk. EPIPE is returned directly without the
>> >     follow-up query that would amplify the failure.
>> >
>> > The UVC control path is serialized by ctrl_mutex, so last_ctrl_set_jif=
fies
>> > does not require additional locking.
>> >
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: JP Hein <jp@jphein.com>
>> > ---
>> >  drivers/media/usb/uvc/uvc_video.c | 32 ++++++++++++++++++++++++++++++=
+
>> >  drivers/media/usb/uvc/uvcvideo.h  |  3 +++
>> >  2 files changed, 35 insertions(+)
>> >
>> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc=
/uvc_video.c
>> > index 40c76c051..9f402f55e 100644
>> > --- a/drivers/media/usb/uvc/uvc_video.c
>> > +++ b/drivers/media/usb/uvc/uvc_video.c
>> > @@ -75,8 +75,30 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query=
, u8 unit,
>> >         u8 error;
>> >         u8 tmp;
>> >
>>
>> Why don't do you do the rate-limit in __uvc_query_ctrl()?
>>
>> Are you sure that you only have to limit UVC_SET_CUR?
>>
>> > +       /*
>> > +        * Rate-limit SET_CUR operations for devices with fragile firm=
ware.
>> > +        * The Razer Kiyo Pro locks up under sustained rapid SET_CUR
>> > +        * transfers (hundreds without delay), crashing the xHCI contr=
oller.
>> > +        */
>> > +       if (query =3D=3D UVC_SET_CUR &&
>> > +           (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)) {
>> > +               unsigned long min_interval =3D msecs_to_jiffies(50);
>> > +
>> > +               if (dev->last_ctrl_set_jiffies &&
>> > +                   time_before(jiffies,
>> > +                               dev->last_ctrl_set_jiffies + min_inter=
val)) {
>> > +                       unsigned long elapsed =3D dev->last_ctrl_set_j=
iffies +
>> > +                                               min_interval - jiffies=
;
>> > +                       msleep(jiffies_to_msecs(elapsed));
>> > +               }
>> > +       }
>> > +
>> >         ret =3D __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, =
size,
>> >                                 UVC_CTRL_CONTROL_TIMEOUT);
>> > +
>> > +       if (query =3D=3D UVC_SET_CUR &&
>> > +           (dev->quirks & UVC_QUIRK_CTRL_THROTTLE))
>> > +               dev->last_ctrl_set_jiffies =3D jiffies;
>> >         if (likely(ret =3D=3D size))
>> >                 return 0;
>> >
>> > @@ -108,6 +130,16 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 que=
ry, u8 unit,
>> >                 return ret < 0 ? ret : -EPIPE;
>> >         }
>> >
>> > +       /*
>> > +        * Skip the error code query for devices that crash under load=
.
>> > +        * The standard error-code query (GET_CUR on
>> > +        * UVC_VC_REQUEST_ERROR_CODE_CONTROL) sends a second USB trans=
fer to
>> > +        * a device that is already stalling, which can amplify the fa=
ilure
>> > +        * into a full firmware lockup and xHCI controller death.
>> > +        */
>> > +       if (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)
>> > +               return -EPIPE;
>> > +
>> >         /* Reuse data[0] to request the error code. */
>> >         tmp =3D *(u8 *)data;
>> >
>> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/=
uvcvideo.h
>> > index 8480d65ec..cafc71457 100644
>> > --- a/drivers/media/usb/uvc/uvcvideo.h
>> > +++ b/drivers/media/usb/uvc/uvcvideo.h
>> > @@ -81,6 +81,7 @@
>> >  #define UVC_QUIRK_INVALID_DEVICE_SOF   0x00010000
>> >  #define UVC_QUIRK_MJPEG_NO_EOF         0x00020000
>> >  #define UVC_QUIRK_MSXU_META            0x00040000
>> > +#define UVC_QUIRK_CTRL_THROTTLE                0x00080000
>> >
>> >  /* Format flags */
>> >  #define UVC_FMT_FLAG_COMPRESSED                0x00000001
>> > @@ -579,6 +580,8 @@ struct uvc_device {
>> >         struct usb_interface *intf;
>> >         unsigned long warnings;
>> >         u32 quirks;
>> > +       /* Control transfer throttling (UVC_QUIRK_CTRL_THROTTLE) */
>> > +       unsigned long last_ctrl_set_jiffies;
>> >         int intfnum;
>> >         char name[32];
>> >
>> > --
>> > 2.43.0
>> >
>>
>>
>> --
>> Ricardo Ribalda

