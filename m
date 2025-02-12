Return-Path: <stable+bounces-115001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48889A31E66
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8327A37B5
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367261FBC8B;
	Wed, 12 Feb 2025 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1Y/Fr0O"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89B2B9BC;
	Wed, 12 Feb 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340000; cv=none; b=JIeY2uBiIQdRHUV4TgDhMKHuuUTnWLupkxTdatSOrFyY2Km2SRycZcJ2BRUvuwZ+7yOY81WcCDQJDMhsVzoa26e2QUSi4/71JHTNm+8UoTfZgMjGvjZHyo1rr3sC1GQPklMnos4jIjyviWUz3lhVxzPb3eCVzwYKlzNh0JLMaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340000; c=relaxed/simple;
	bh=a2ba5B9m7MkVzUv6GtWCZepykHbmaU3/BHDUn1sGLuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFy0zze/GEajvumenxglsdWo3WS4JOfjVD6MawlY1Pjzs3Igobgj0MkOyxoKBDMuHnteTDIfP5WKq83c8PVKV2v3dSjv22+ycYWKCJ0O3uECC8qR64heABbkPMxWml/gHIQ9FVcQE0QwlfS2IKQBfjKeZ+i73n1mafXUqXnh6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1Y/Fr0O; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fc8f74d397so1275573eaf.3;
        Tue, 11 Feb 2025 21:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739339997; x=1739944797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI/hjOkcJ3P1pXU852POm+uc+CfDlCv2Czyl9Opbgnk=;
        b=V1Y/Fr0OJhc6E0X0H7n6PNq1BHrlNXlbgIPc4XaWWdiHzwuMc8qtp1ZYmABhX6JzxP
         ge+C1VGGoMJ6vnwhQWXrA08GkVRmMNCxzRKR5z9nglBuda4soLq9lGoizyefRQD0/G2j
         W2DIkbfkHx6dlkiLmgbv14BJtIGcrJlYX+xd5J66MRgkungKYC8fnz+ZRTheTo/oJa46
         UU9Y01y0Ddr2rSHoLC/VmQgUwmILO3hpPrlYGQUOWHAuZvalMKbuZoJhrKwHhTOZn/Ge
         f1QhLJUeCFEExrKlHvuApW1IWtyCa1oMxOx1ZPVjW7JthzHMgWeRG6a2gS59Ss6/tDCD
         swbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739339997; x=1739944797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI/hjOkcJ3P1pXU852POm+uc+CfDlCv2Czyl9Opbgnk=;
        b=ggmiILfHA08cvze5h/sDzEr8dm4dT9fsOcIi0l9RM5PCwkV8oPt0enZRaKbZPYtzns
         9gCrUyi8HAhb46noe8e94aq7rdZ0bYxw5kSdRxwMbAp3m7XOEA+BpDuvsXZkehyNhxx1
         qFmJBf6A3i8Jj1s81osAt1oUdsVEoM8b5amMFxYa1sCFO2EeZ/VqUfsNgpi/KsNUMG4B
         4uzfECf+6y4SRjP3SH5yZwrzQ0ryc7EMVLDJTbReh8EYSWFlbznxye9zD0sPrrFMgKpt
         QxOlqlgkndlygyjF7OX7NNh0slSuezIxxDmDWsNnxgYIprU7qYlWMeF2+dlwa9qNHWGh
         X7oA==
X-Forwarded-Encrypted: i=1; AJvYcCWlnpEGa1c0XgmBUktx2iec2To6d4eVmbEbjMYzorsbvdiAEjL+1Ky5TSZ77i2gsypbdL5BHeT192wq@vger.kernel.org, AJvYcCXTZz09U0q6zbtOu7wgj7WEKEeLyWNUc5X6qCiKLURgf196J1wwnVRbTqj1CqrHxzBMXjq+rv/R@vger.kernel.org, AJvYcCXxYpnoCD9VThgCfhaOFCxmVJsWVaAN7ccvh+5Dr2oxeT+MznsfaB/TqtAkynY8iimEci83g7CqKfhSjkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1oOra1xUWNF4Chd9DDVddajoA2WGbRI1n/mZ+nRdKBR1Vwah
	1rNxvldw2/QvXeKPtnKTO9tTyL+HbudJ+BGjl4dC/byprIgGJvLdKK1D32prvilSexndBkeRsZW
	RKx9Xgdn5j9bX0cjGppIyN0Adlds=
X-Gm-Gg: ASbGnctYGAv6APiMTXCOmdHW5wll0w6CALS0rLyZMrDcmk6vC/VIRTpsqxXHL+D/2aG
	csm8znotNgPiPyH/XD/hW4T3lHXWKpP/+AF0Vh5j+RYoAL6ySuGTncqwMkgFlxZIhr/wJLl1keX
	k=
X-Google-Smtp-Source: AGHT+IHJEMlkMdkkIP0tGh0S1tp/wHKoqMMQq5akQOLAdes7eQ3B6XtswIqezsyyUk/mA5PYyrlrVful8wr/picmr+I=
X-Received: by 2002:a05:6871:4081:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2b8d68a1b80mr1550888fac.30.1739339997227; Tue, 11 Feb 2025
 21:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205234205.73ca4ff8@foxbook> <b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
 <20250210095736.6607f098@foxbook> <20250211133614.5d64301f@foxbook>
In-Reply-To: <20250211133614.5d64301f@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 12 Feb 2025 13:59:49 +0800
X-Gm-Features: AWEUYZkbSksPIxhIaoXjz_XdtyIIoYP38S4kAxq9aFiscapfHQv17JViEIAqTyw
Message-ID: <CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error reporting
 by Etron HCs
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Michal Pecio <michal.pecio@gmail.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> xHCI 4.9.1 requires HCs to obey the IOC flag we set on the last TRB even
> after an error has been reported on an earlier TRB. This typically means
> that an error mid TD is followed by a success event for the last TRB.
>
> On SuperSpeed (and only SS) isochronous endpoints Etron hosts were found
> to emit a success event also after an error on the last TRB of a TD.
>
> Reuse the machinery for handling errors mid TD to handle these otherwise
> unexpected events. Avoid printing "TRB not part of current TD" errors,
> ensure proper tracking of HC's internal dequeue pointer and distinguish
> this known quirk from other bogus events caused by ordinary bugs.
>
> This patch was found to eliminate all related warnings and errors while
> running for 30 minutes with a UVC camera on a flaky cable which produces
> transaction errors about every second. An altsetting was chosen which
> causes some TDs to be multi-TRB, dynamic debug was used to confirm that
> errors both mid TD and on the last TRB are handled as expected:
>
> [ 6028.439776] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on e=
ndpoint
> [ 6028.439784] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final=
 completion event, is_last_trb=3D1
> [ 6028.440268] xhci_hcd 0000:06:00.0: Successful completion on short TX f=
or slot 1 ep 2 with last td short 0
> [ 6028.440270] xhci_hcd 0000:06:00.0: Got event 1 after mid TD error
> [ 6029.123683] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on e=
ndpoint
> [ 6029.123694] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final=
 completion event, is_last_trb=3D0
> [ 6029.123697] xhci_hcd 0000:06:00.0: Successful completion on short TX f=
or slot 1 ep 2 with last td short 0
> [ 6029.123700] xhci_hcd 0000:06:00.0: Got event 1 after mid TD error
>
> Handling of Stopped events is unaffected: finish_td() is called but it
> does nothing and the TD waits until it's unlinked:
>
> [ 7081.705544] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on e=
ndpoint
> [ 7081.705546] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final=
 completion event, is_last_trb=3D1
> [ 7081.705630] xhci_hcd 0000:06:00.0: Stopped on Transfer TRB for slot 1 =
ep 2
> [ 7081.705633] xhci_hcd 0000:06:00.0: Got event 26 after mid TD error
> [ 7081.705678] xhci_hcd 0000:06:00.0: Stopped on Transfer TRB for slot 1 =
ep 2
> [ 7081.705680] xhci_hcd 0000:06:00.0: Got event 26 after mid TD error
> [ 7081.705759] xhci_hcd 0000:06:00.0: Stopped on No-op or Link TRB for sl=
ot 1 ep 2
> [ 7081.705799] xhci_hcd 0000:06:00.0: Stopped on No-op or Link TRB for sl=
ot 1 ep 2
>
> Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> Closes: https://lore.kernel.org/linux-usb/20250205053750.28251-1-ki.chian=
g65@gmail.com/T/
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>
>
>
> Hi Mathias,
>
> This is the best I was able to do. It does add a few lines, but I don't
> think it's too scary and IMO the switch looks even better this way. It
> accurately predicts those events while not breaking anything else that
> I can see or think of, save for the risk of firmware bugfix adding one
> ESIT of latency on errors.
>
> I tried to also test your Etron patch but it has whitespace damage all
> over the place and would be hard to apply.
>
> Regards,
> Michal
>
>
>  drivers/usb/host/xhci-ring.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 965bffce301e..7ff5075e5890 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2437,6 +2437,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, =
struct xhci_virt_ep *ep,
>         bool sum_trbs_for_length =3D false;
>         u32 remaining, requested, ep_trb_len;
>         int short_framestatus;
> +       bool error_event =3D false, etron_quirk =3D false;
>
>         trb_comp_code =3D GET_COMP_CODE(le32_to_cpu(event->transfer_len))=
;
>         urb_priv =3D td->urb->hcpriv;
> @@ -2473,8 +2474,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, =
struct xhci_virt_ep *ep,
>                 fallthrough;
>         case COMP_ISOCH_BUFFER_OVERRUN:
>                 frame->status =3D -EOVERFLOW;
> -               if (ep_trb !=3D td->end_trb)
> -                       td->error_mid_td =3D true;
> +               error_event =3D true;
>                 break;
>         case COMP_INCOMPATIBLE_DEVICE_ERROR:
>         case COMP_STALL_ERROR:
> @@ -2483,8 +2483,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, =
struct xhci_virt_ep *ep,
>         case COMP_USB_TRANSACTION_ERROR:
>                 frame->status =3D -EPROTO;
>                 sum_trbs_for_length =3D true;
> -               if (ep_trb !=3D td->end_trb)
> -                       td->error_mid_td =3D true;
> +               error_event =3D true;
>                 break;
>         case COMP_STOPPED:
>                 sum_trbs_for_length =3D true;
> @@ -2518,8 +2517,17 @@ static void process_isoc_td(struct xhci_hcd *xhci,=
 struct xhci_virt_ep *ep,
>         td->urb->actual_length +=3D frame->actual_length;
>
>  finish_td:
> +       /* An error event mid TD will be followed by more events, xHCI 4.=
9.1 */
> +       td->error_mid_td |=3D error_event && (ep_trb !=3D td->end_trb);
> +
> +       /* Etron treats *all* SuperSpeed isoc errors like errors mid TD *=
/
> +       if (xhci->quirks & XHCI_ETRON_HOST && td->urb->dev->speed =3D=3D =
USB_SPEED_SUPER) {
> +               td->error_mid_td |=3D error_event;
> +               etron_quirk |=3D error_event;

This would be the same as etron_quirk =3D error_event; right?

> +       }
> +
>         /* Don't give back TD yet if we encountered an error mid TD */
> -       if (td->error_mid_td && ep_trb !=3D td->end_trb) {
> +       if (td->error_mid_td && (ep_trb !=3D td->end_trb || etron_quirk))=
 {
>                 xhci_dbg(xhci, "Error mid isoc TD, wait for final complet=
ion event\n");
>                 td->urb_length_set =3D true;
>                 return;
> --
> 2.48.1

I tested this with Etron EJ168 and EJ188 under Linux-6.13.1. It works.

Thanks,
Kuangyi Chiang

