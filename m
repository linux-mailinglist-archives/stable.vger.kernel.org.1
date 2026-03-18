Return-Path: <stable+bounces-227181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFWXAawzu2kVgwIAu9opvQ
	(envelope-from <stable+bounces-227181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:22:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636862C3CD0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66408306F3B7
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E33093CB;
	Wed, 18 Mar 2026 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2DHbpJg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366B2DEA7B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876114; cv=pass; b=jnTTB3Yn6Pvjnsfa+mQPWddL/Pq+ma+BZD9WGJPW3h6WsDUifawZmsN1rjvDFhlDOos0WShFV5yY2bqIXKxskf7SBLe5CW4Nb3ePv7BQCIaNv8y7cHfx2GUb+z/iIekaxR759uLWPxfQ4t9yvzU0RkvUSTsCFJmUT33GgeKnmfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876114; c=relaxed/simple;
	bh=sWPkuLJXrcBX9S3aX4yM+gQyI9/bx+U9y1A0D2W1Bz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbobhVUHr0paDgwYj+k7MfjSTzcWl+w4EPcRhunA46jjjg40B0rMlX0Hbh9yBbXMr9zqCrk2dENEk6xjcZMuTgFeps8Beeghwpn9t4D9gvg1M2XsNnDws6P0SMscsXVsnUeXM5umDVTspSEjxWWKCkxhenhEeK9BSsexlEBKzP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2DHbpJg; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5091ed02c54so139431cf.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773876111; cv=none;
        d=google.com; s=arc-20240605;
        b=lgLTcYQU3g7YmJM7AylNqflnlrwrV6KxWsExvK0+8HKMz4o758SW396/CDrPXcxdNJ
         chXbZCVJB8SJu0W/F1epIyEE6m2Y4J4hYQuWbalNnV5hzWIFZtLwC8bLKsQqxXdjc7vy
         G/ar29+8ObHUNl02NBuSRFB7cwZ0AOjxkkhBKAsMPijI2Bucew91jh+66pkfeiPEXRh1
         hJ3Fx6kxNEbFkDA+/w0xmPHypJ/U9Ov7hfsi21GnHKtyN8xp1cLX6bYyke/+mUQ4DrMl
         IcKpSNUoeWLegOKd0vgEqRYiPyPKcsRHj/uZDUlj4j7AhAU05uEiQRngab76sx8I5u0p
         Fdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m9rV6JpeFuPhu2T+JRvifOR+f3O83Iw8gXacOywKROQ=;
        fh=7+HSYltZDLCGOn6THyf6gclzjqyIZ9sQN2Y1vlZ8Rdw=;
        b=h/rw3TorSAs0nzpHpnMyK6Jaa68ZKBuiemTfGUQn1CR8eRmiHLye3HG0TpmCtNN/cr
         77k+Vnp4G+eip5cMEiUrRWdp0UI9qtdETb7tRb4T/IPEWF+ysc7rF2MwwR6cFptgyOPO
         Ha0GubsVsbKcbT61fqsiK4ZH4X+pw0x8I/E4NKYfacadjMUV+MpdWFnkEheLCThxw1ea
         bbk6Xjz3Xykumb/KFGdfH1txno+3z2yC/OjGV8cIvF3XwTAlez1a5gsUitYkapIrc+YW
         MujJgXhdYp3VSVh5uz+2XRlZJPTeHQUivyXz5DT48ihig6gnj3xuzIwVHddEPEs+G5Yy
         JUhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773876111; x=1774480911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9rV6JpeFuPhu2T+JRvifOR+f3O83Iw8gXacOywKROQ=;
        b=H2DHbpJguw8NvIiLyeFMFnAd8A9NJl4xFdl7DohesIVytl9S61tLC/Ee1OvtUa//OV
         7d+7iaX26PR4bl/G/I9P6eVamYnoeStGJjlaCyyJaQ3hXl08BKpmG7UvDMsM82V5vNVu
         Ygeu0wFdZnhixWUrrsHKKlq3EApgNj6eQv/GS0FaHybmS9MHegGMJB9xTo0f+Wr6z6/7
         j+aD1DYTrzC6C3KgLDG1B9aZCmFBSWRMVerYj5SsXmy0CLN5aV8CUppXrVmq605TgHIc
         BtJ0x5GcwDiz9+C14QYEI2Opj/lE/LrtA5T41pgiS2tCSob4AE8BYTiBB7JfYobMrjQE
         2X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773876111; x=1774480911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9rV6JpeFuPhu2T+JRvifOR+f3O83Iw8gXacOywKROQ=;
        b=FXiehR+jBbxPn+w0rQ8yF/1gsNuF2mzjLtqLyKbsZyRFafXtBnkcZ7gd7GZsqUpgVa
         8cVo2DKFkOctN+hfoxGlz3MUUVlRO/hG3JOTh9QAjox8oZ2okxwPOf2wTVA34xUtNcjD
         V96avd3Uz+U1RxnBgzHO/x5t4ClRth2Yn6GNzdZ8eXUE/rCqYymQvJ+ox/JDv8/qMVy3
         vRHbsGogd945/H9TRupZbC/G4t1Qd/a3PD15bXcSbd7enThwdCac/XpniPIR47UeAXzq
         RD5Vgfq15c34P6+lKQRK8CJP8KQL3DaNrQqouPd1qFHDqodGIckbrLRns//wi0M9Bf5q
         b/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVXGfH8nXUewpvXrI27j8JIOWTWYTDWYikQsSCi2RNN90ylzIjQMYhXx0nDvXOk/okrhi87PHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31fXl2psIXhCzCJfmlgBVvHxPgNtQPzUg+Ddd6MVkqzOfCBdg
	Rf2EGZje0iCIWeF6fsPGPwxSQYirN9vG9w7xFbNbB/PVHcMJ5sd0p1WT4OvKWnuO0Tb7oBcKUxf
	ZAiXF7VaVsdlgbq9IBhedGFhYEpme+/kEXv4aZTau
X-Gm-Gg: ATEYQzzSe/KDLODk20NScpDk8xmddnLEjSwXd9MLqOJBozk4Ocv7iD8xM9DZwf6s5gQ
	eynBxqgISgEnQHoMbxRKJpAy8giXVmRskZ8vnsPE5mripe1H75aoSPaqkAUpR6yWvrpL+n+YbPP
	vEqpeN4AJwVZlepaW+jVGu3nSxLSkzTVrhUIUt/CHvWVgRznHxNRKt2oZ3z3zvomjSRnKseZhKN
	qY7bTimnJJOU1kklAY9GhrI6l/BMorCJlr76FVaJeUo+KG9LIBbuiLdog6UKgP2DD2RO6rt7W5f
	RSpzIomfE8Uo
X-Received: by 2002:a05:622a:58c:b0:509:45f:fdd2 with SMTP id
 d75a77b69052e-50b2747cab0mr3002981cf.15.1773876111071; Wed, 18 Mar 2026
 16:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com> <20260309022205.28136-2-guanyulin@google.com>
 <505ab422-f933-4674-8f93-8744d0e67c6d@oss.qualcomm.com>
In-Reply-To: <505ab422-f933-4674-8f93-8744d0e67c6d@oss.qualcomm.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Wed, 18 Mar 2026 19:21:00 -0400
X-Gm-Features: AaiRm539Hmpj3e5uW-24en7eVbe4K9Ue0STys9HF6sxG6gvj_pbB9iJ_D2yzCoI
Message-ID: <CAOuDEK3b4BtHVYhLH_NkE1fP1-9ncqvAq6VedBzWLm=D_YDHQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: offload: move device locking to callers in offload.c
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, stable@vger.kernel.org, 
	Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227181-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,vger.kernel.org,oppo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 636862C3CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 4:17=E2=80=AFPM Wesley Cheng
<wesley.cheng@oss.qualcomm.com> wrote:
>
> On 3/8/2026 7:22 PM, Guan-Yu Lin wrote:
> >
> > @@ -27,31 +28,25 @@ int usb_offload_get(struct usb_device *udev)
> >   {
> >       int ret;
> >
> > -     usb_lock_device(udev);
> > -     if (udev->state =3D=3D USB_STATE_NOTATTACHED) {
> > -             usb_unlock_device(udev);
> > +     device_lock_assert(&udev->dev);
> > +
> > +     if (udev->state =3D=3D USB_STATE_NOTATTACHED)
> >               return -ENODEV;
> > -     }

Could be removed. Since the udev is in USB_STATE_NOTATTACHED. I expect
the data structure being cleaned afterwards, so actually counter value
might not be important at this moment.

> >
> >       if (udev->state =3D=3D USB_STATE_SUSPENDED ||
> > -                udev->offload_at_suspend) {
> > -             usb_unlock_device(udev);
> > +         udev->offload_at_suspend)
> >               return -EBUSY;
> > -     }
> >

This check is still required. Because the suspend/resume process
depends on the counter value, we can't modify the counter value while
the device is suspended. If we do so, we will have an unbalanced
suspend resume operation.

However, we might only need to check for udev->offload_at_suspend (if
we ensure the device is active when we want to incremant the counter):
1. If the offload_usage_count is 0, we won't decrement counts at this momen=
t.
2. If the offload_usage_count is not 0, the offload_at_suspend flag
will be true anyway.

>
> Do we really need to be explicitly checking for the usb device state befo=
re
> we touch the offload_usage count?  In the end, its a reference count that
> determines how many consumers are active for a specific interrupter, so m=
y
> question revolves around if we need to have such strict checks.
>

Please find the explanation for each check above.

> >       /*
> >        * offload_usage could only be modified when the device is active=
, since
> >        * it will alter the suspend flow of the device.
> >        */
> >       ret =3D usb_autoresume_device(udev);
> > -     if (ret < 0) {
> > -             usb_unlock_device(udev);
> > +     if (ret < 0)
> >               return ret;
> > -     }
> >
>
> IMO this should be handled already by the class driver, and if not, what =
is
> the harm?
>

We can only increment the usage count when the device is active. For
counter decrement, the device could be in any state.

My initial design is to resume the device and then modify the usage
count. Another option is to check only whether the USB device is
active via pm_runtime_get_if_active, and leave the device-resuming
effort to the class driver. Do you think this is the better approach?

> >       udev->offload_usage++;
> >       usb_autosuspend_device(udev);
> > -     usb_unlock_device(udev);
> >
> >       return ret;
> >   }
> > @@ -64,6 +59,7 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
> >    * The inverse operation of usb_offload_get, which drops the offload_=
usage of
> >    * a USB device. This information allows the USB driver to adjust its=
 power
> >    * management policy based on offload activity.
> > + * The caller must hold @udev's device lock.
> >    *
> >    * Return: 0 on success. A negative error code otherwise.
> >    */
> > @@ -71,33 +67,27 @@ int usb_offload_put(struct usb_device *udev)
> >   {
> >       int ret;
> >
> > -     usb_lock_device(udev);
> > -     if (udev->state =3D=3D USB_STATE_NOTATTACHED) {
> > -             usb_unlock_device(udev);
> > +     device_lock_assert(&udev->dev);
> > +
> > +     if (udev->state =3D=3D USB_STATE_NOTATTACHED)
> >               return -ENODEV;
> > -     }
> >
> >       if (udev->state =3D=3D USB_STATE_SUSPENDED ||
> > -                udev->offload_at_suspend) {
> > -             usb_unlock_device(udev);
> > +         udev->offload_at_suspend)
> >               return -EBUSY;
> > -     }
> >
>
> During your testing, did you ever run into any unbalanced counter issues
> due to the above early exit conditions?
>
> I guess these are all just questions to see if we can remove the need to
> lock the udev mutex, and move to a local mutex for the offload framework.
> That would address the locking concerns being brought up by Greg, etc...
>
> Thanks
> Wesley Cheng
>

While developing the initial patch set, I did encounter the counter imbalan=
ce.

Following the discussion, we could move the device resume effort to
the class driver. This way we only need to check if the device is
active before manipulating the offload usage counter, which doesn't
require a device lock. Is there any concern with this approach?

Regards,
Guan-Yu

