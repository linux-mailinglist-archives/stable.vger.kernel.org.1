Return-Path: <stable+bounces-224896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LZWOLv2smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:24:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE0276868
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 187263024406
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330531C8634;
	Thu, 12 Mar 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/OA37Z5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE93859F2
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336244; cv=pass; b=ctGVV8F3Lo8j1uK3Y7+PqEwq6HkdTL5PhAmd+VxtdMkEjLaScEmeAJosSEh+i0BgSnzotPkYitJo0bVCOpoZ/WkfFZJCaKTiVvTO1x1UT/BhsNAf8vXkZGfUd+C6zFEPHWVuo7CC3GSDtfIVXBto6dqvCiSU+A4pRmRRC1hf9CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336244; c=relaxed/simple;
	bh=cs9NydnZlUj2ytjzvPGe3kpN6J9plhpBN0pmEXhJkR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C448mU3aKLwxNyC2+6VLljIvcWSqRQ5v6lW0RmgqlTm0yDGqZXv6bNAwDKDOBE21qmQ3USh/A9bQ62tp/WC+Lt1Z/gyEtua0tZGkvy3WMBFwAHbTqvLcsa5txJiyXzocGMuMUE8FUlrZKzli9QZ48LU6vfmgg8vsds6/JwUs9/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/OA37Z5; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50906a98ffeso35321cf.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 10:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773336242; cv=none;
        d=google.com; s=arc-20240605;
        b=CZ6+HAgev1NqioPXI8bSv5Ai3bJlxxJxBvNDJ13P6nUcGYSR8qAbhP5bTz5LsICEad
         6hsZTf3PWyJrGWqYAK98VcVR7gV98lJqHHP5PHYhDNkpzbGfMrhM3ma5Pwdng2HZn+NJ
         Zu3I/W6f2EW5T2rVqvMk75JWROmtrs7zB4Fh3rqh+thdSr+6ROpQlwo8+ToTZddQjLlZ
         TPd8TXNJ0KTTBF8AwXLajeIGuZpFPOXYNO/0rCdJKsU6KavdWXHZtnNQfLGJ0D/uULVw
         cWiUK7NeH/Rnd3SQm9+0tBxT4NXx84YkbXapnDs0LPtGXCnlMiSEmXwhmWSf04V/yVSV
         FB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drMga890hBoz1tXxKNjKqbtUxogSlXx8qnX/9lqYuDg=;
        fh=72ALynuYos1i6Uw5ODa6xve/Gx7P+mjJwPSuYbKXi3M=;
        b=Ke/Y+iEN/elQdID3b/JF6ksZeD9M5TeLfZZEOqayrmreL9s0MdR7KxOEnD3MVFDpUx
         ZlzXwdr85i+FPQ5P6+blHreCdVAWRY3y+L0F/jhyCMiYg/GEXNBbbteUxZVTY+Akik4O
         UuG7MWCaIu4G4tvxS9jdGiwFW8qVNyPvph0Sf0E5O5bnpRfCmZSM3JFU0DhZpnpKNTjX
         +XhHwEyrduH+E8Vm8kHBMZKp+iCf4KcINeBEGpX7g8xXYKV3qWG8STQko6HuVEIafcYY
         oNXAjnWW/CcnpILrrOP5Rf72QE2KpuuT1xWxDk0Z2mBT6f0i0YobPBjbLUytqxRJfIcI
         Pe1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336242; x=1773941042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drMga890hBoz1tXxKNjKqbtUxogSlXx8qnX/9lqYuDg=;
        b=l/OA37Z5jrji/icRRqDj70IWIFhcMD+xVvpkIY37afq/KXC3iiAMhB0Fxl6oZZ6Hqg
         kJgoK/oiMjC3rZFvhu7Bh8vd4wRsUimppVoKUkFhukcc2yJtx/ziN7EYKDgsEju+Izzr
         VwPlCWDxl0iSoRZIS0gVBIu0k5zW5ojB+Oxi3o4bfCFCCdPkAb79cNEy20SL6hSrbd61
         sW6dCo07iIUKyvVOmS5ld8Z+62aHiY/M6fbD88QtFNwiJIj7scBJ7yJjwb6HzhHku1q+
         RDCuQ3HK6OzhX3oYMqXYXxQoxTgFFQHaZgczyHmd5qObJ+LBZ3IDMsp+1HLn9oPzhfV9
         kslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336242; x=1773941042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drMga890hBoz1tXxKNjKqbtUxogSlXx8qnX/9lqYuDg=;
        b=qkkQf4Y6b6PDu3B1SBddoSCKxsMNR4so4/aYL6Mz3jUK29mUx9VgEqXPxf2Kc90X6D
         mKSNXP8cvMsWCzJ/RXAmYSWF2s333QWUwl9csCbtAoX/APG4WJBN2+XYX0hPjb1LKyrb
         kBXW/qfUZSoUFODbs9ARx+sVXN12pfbWE3AtBWyxfUChJKc3uvoPZYuOjGdtElQdQf4r
         SwoDYSwKkZ4UcLCUZEQEovQFeq+d1IfasTfnuMrwOcAMA68GyyTHNMnyljVidNPtbkZ4
         Cu5hBkxYIMx2Ol8KgOtulJUHwFbsrKqQePjadPYoK3C78pBYjWJA6SXrOgtsmNFowxuw
         zErw==
X-Forwarded-Encrypted: i=1; AJvYcCVTb88LvSArHHzVvmPsZHv0T/re/fJtogSFERUICiP9doZMxnYfVZ4wiO9+2XgPVY8Bt0XbLQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uLouAXXFjkZE8r1RlXVhQ0el9xJsPGmL4J7J50piwnZjD6/M
	r2srBD43PE1hiH0HgN52ouxy8X+IQXxdPNLPsj9MIpTe9KoxidDksiXBJF7IyNRMJilYIn4Re0F
	CErn3/UJ1x+hpenkAMn22uOqJTA4t3ew68YNDLXEU
X-Gm-Gg: ATEYQzxz02mPL16EJm47w9JD9tNJUU19j6EHLarlACvkpOzeuc5UyhfuGu8SNqN3nIn
	wtaYsURyg8Aru/3Bjg6hQtcgKEot5V9OtnGbeKMEwEh4UYsbvk7HlLUJdk3JuERpsMnH/1D7d3E
	PD+I8dprkI1yETF8N5TcLddqhAJRfXkqxBGF23YAaoAlr8uL48OQ5JyzwHpXfvxjeaTep+QgX94
	O+32nzlBAlOkqM0zdBZv7Hr5+/9OV1sqT/baLw6s2fooEKqNBAr8IhMkfPJ91Mp5vq3pbPmnIkD
	b9NJk0kC
X-Received: by 2002:a05:622a:354:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-509585b04d0mr230561cf.1.1773336240812; Thu, 12 Mar 2026
 10:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com> <20260309022205.28136-2-guanyulin@google.com>
 <2026031134-uncover-siamese-cdf9@gregkh>
In-Reply-To: <2026031134-uncover-siamese-cdf9@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 12 Mar 2026 10:23:48 -0700
X-Gm-Features: AaiRm506FY_oJhi6wIWrihwWospchNxvGjcFGure-VJM-x4nJE6EzoeYpJH_Y7A
Message-ID: <CAOuDEK2jBncFtBFmn0h6fg519ErDC1tvLjpsUua2iWean9h4RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: offload: move device locking to callers in offload.c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com, 
	quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	stable@vger.kernel.org, Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224896-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com,vger.kernel.org,oppo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E9AE0276868
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 5:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Mar 09, 2026 at 02:22:04AM +0000, Guan-Yu Lin wrote:
> > Update usb_offload_get() and usb_offload_put() to require that the
> > caller holds the USB device lock. Remove the internal call to
> > usb_lock_device() and add device_lock_assert() to ensure synchronizatio=
n
> > is handled by the caller. These functions continue to manage the
> > device's power state via autoresume/autosuspend and update the
> > offload_usage counter.
> >
> > Additionally, decouple the xHCI sideband interrupter lifecycle from the
> > offload usage counter by removing the calls to usb_offload_get() and
> > usb_offload_put() from the interrupter creation and removal paths. This
> > allows interrupters to be managed independently of the device's offload
> > activity status.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> > Tested-by: Hailong Liu <hailong.liu@oppo.com>
> > ---
> >  drivers/usb/core/offload.c       | 34 +++++++++++---------------------
> >  drivers/usb/host/xhci-sideband.c | 14 +------------
> >  2 files changed, 13 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
> > index 7c699f1b8d2b..e13a4c21d61b 100644
> > --- a/drivers/usb/core/offload.c
> > +++ b/drivers/usb/core/offload.c
> > @@ -20,6 +20,7 @@
> >   * enabled on this usb_device; that is, another entity is actively han=
dling USB
> >   * transfers. This information allows the USB driver to adjust its pow=
er
> >   * management policy based on offload activity.
> > + * The caller must hold @udev's device lock.
>
> Ok, but:
>
> >   *
> >   * Return: 0 on success. A negative error code otherwise.
> >   */
> > @@ -27,31 +28,25 @@ int usb_offload_get(struct usb_device *udev)
>
> Why are you not using the __must_hold() definition here?
>

Thanks for the suggestion, __must_hold() will be added in the next version.

> >  {
> >       int ret;
> >
> > -     usb_lock_device(udev);
> > -     if (udev->state =3D=3D USB_STATE_NOTATTACHED) {
> > -             usb_unlock_device(udev);
> > +     device_lock_assert(&udev->dev);
>
> That's going to splat at runtime, not compile time, which is when you
> really want to check for this, right?
>
> And I thought all of the locking was messy before, and you cleaned it up
> to be nicer here, why go back to the "old" way?  Having a caller be
> forced to have a lock held is ripe for problems...
>

The challenge is that the USB stack automatically holds the lock
during the hardware/software USB connection change. But USB locks are
not held when we create/remove xhci sideband interrupters. Hence, we
need to manipulate the locks by ourselves to distinguish between these
2 usecases. What's your suggestion on this sceneario? Do you have
other options in mind?

> You also are not changing any callers to usb_offload_get() in this
> patch, so does this leave the kernel tree in a broken state?  If not,
> why not?  If so, that's not ok :(
>

The current upstream implementation triggers deadlocks in some cases.
This patch simply disassociates the offload counter manipulation from
sideband interrupt creation to address the deadlock. After applying
the patch, the offload counter won't update until the next patch in
this series is applied. Is this considered a broken state? Should I
squash the two commits into one, or keep them as they were?

>
> > +
> > +     if (udev->state =3D=3D USB_STATE_NOTATTACHED)
> >               return -ENODEV;
> > -     }
> >
> >       if (udev->state =3D=3D USB_STATE_SUSPENDED ||
> > -                udev->offload_at_suspend) {
> > -             usb_unlock_device(udev);
> > +         udev->offload_at_suspend)
>
> Can't that really all be on one line?
>

Sure, Let me change it to one line.

> >               return -EBUSY;
> > -     }
> >
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
> >       udev->offload_usage++;
> >       usb_autosuspend_device(udev);
> > -     usb_unlock_device(udev);
> >
> >       return ret;
> >  }
> > @@ -64,6 +59,7 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
> >   * The inverse operation of usb_offload_get, which drops the offload_u=
sage of
> >   * a USB device. This information allows the USB driver to adjust its =
power
> >   * management policy based on offload activity.
> > + * The caller must hold @udev's device lock.
> >   *
> >   * Return: 0 on success. A negative error code otherwise.
> >   */
> > @@ -71,33 +67,27 @@ int usb_offload_put(struct usb_device *udev)
>
> Again, use __must_hold() here, to catch build time issues.
>
> And again, I don't see any code changes to reflect this new requirement
> :(
>
> thanks,
>
> greg k-h

Thanks for the suggestion, The __must_hold() macro will be adaped in
the next version.

Regards,
Guan-Yu

