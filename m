Return-Path: <stable+bounces-114204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9539A2BBFB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 08:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41133A7EF7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9919D8A4;
	Fri,  7 Feb 2025 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktH9QRPa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B039235C19;
	Fri,  7 Feb 2025 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911578; cv=none; b=fKZp4KPyQhJpJv1T8/wIUyoMFMqmEswMXLYFY/uwdgGN9sO2ant8HHU2SDCfTLng6yV0b9jLkAEKDmMPnwxx8n1YrysOS+BuQ93Sl/BsOLhpj+W/apQK1VSHc5NrlC3KYeVd6y3JAOwEK/YjoxLl/2n69F+ecGyVrGxJHb9vfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911578; c=relaxed/simple;
	bh=6XOcL3OWZU2HG9Nhc90c5mAanufZNmC52HVgYGBLg7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOuqwvIwCXjbVLjQy7MSLgcHWWNONbHtorfjp4gTvR5YF15+BXIokLgbz59mHnMYtWTrKzN7iNPE4+E3vJvYUnUmkJCn5cUBHiBNHaFRG20HxXqqPMwBRYjaJYb7Vzi54cgRrKaP5+MLJ7iAICoc5MOq/+B2avageQ8mxYXMxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktH9QRPa; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f31f8f4062so933814eaf.3;
        Thu, 06 Feb 2025 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738911576; x=1739516376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97vO1HF1zHEq9ew3mBBmV+91aHR/hzKRLBbUJ8Z6gg8=;
        b=ktH9QRPalg03iL8xHb9OrKn7uZDmj1HtIfSQVgJ8hsWEyQ6cJrrpN3/klFUZ1Y13Oc
         DAtidFNiv06Ne6zftbk0wIcVeIPr56WmXfwljucCg/TQLwYsi82DSItUSAIeG0rpfrp/
         66RAmQ8G0z2lqgkYO3rXuAlL35EgtMz7PXu97dUigIhjjtTeoEQBMO9Bu/5ALGvb0OZp
         SZH51S37immln5HHztDrURguFcG5/Os0mGWL6CPikPlhFLbTeGAyjhoz10sI+yy6Ng3o
         PutLMZCpEW3Bjn33WJHQwmj3IxSTuyxUtzOW68x9itRheWT4FF2dEqg/HGHYHHRHmF9z
         aKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738911576; x=1739516376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97vO1HF1zHEq9ew3mBBmV+91aHR/hzKRLBbUJ8Z6gg8=;
        b=wB4sFpq0kdgQsKQHi4KXwab65WwkAotwYr6VUgLc3l3pyB5dAAO8jby6ppqPdKfWpl
         uyraI8cvx0Cmw/dSIpXvwjp8r3gbK2Tp9E6ge3x1AvT5S9H617SlqZvNPUhWC2A31BhK
         fSvZx7/Thviz20RuNXo8olSa3BmJv85xnBA/8A1JaHlcrBFI6FucpjwEa3jio8iZ2pX/
         dn7t490SuzjRzQCBPUnfeZuh2KWPyfM652vni8OmoA9jEjQ2I5MfYZQbWOzH0g3J81Vr
         t6muXLdNZNNNd4ZV3PXmd7Yg3uPtDxXi5BGUds9ByFSc3Gc+ycfytP7wvw2gPnZPjxsC
         WcEA==
X-Forwarded-Encrypted: i=1; AJvYcCURlLOD4jp4AI2gX7LXsYEuJQsxrdWhaBnMUsInbnrxwF/KZjvte2OfRiSF8rzr6k8mrkJFdrh2p+ir1v8=@vger.kernel.org, AJvYcCUoUGTaFKgzWLMIfwmy0f09NwSiUm+wIhg2PVex4AxGl9R31gnB7tEgf9THh9K/4507bISLc8EW@vger.kernel.org, AJvYcCV4XKr2VHoAa8k8d3SvqEd8n2Teewodb1GeBlxwvK15vFeliCtiPpw0jYfC7QhcoV+olTM2WdlMSVki@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFICgeIkpAetYHNc1Tg6nqfmTfhU+zky+vz15b+b8SqjI/8B+
	JmWDkUlActqftgShxqGJoFyiSGxLegTN/HmmRqm5a+SzkN5wV6Wqi77MAgS3eZiP+5+cQI6cw3T
	sygW5GlKejWVMQnM2IilvEMxl48zvAMfv
X-Gm-Gg: ASbGncsYHSt0/lzXSJy1C4TbtRpXW6gsEY9QxlMtM2LIDsFd4H8Sm9LPll2Sdmi0IDK
	CfyHPbdnEGRPgb/6X7kYjSOirntUlho/ZeAw3gY32PKeQ3jaw7B79i+/f0BGG1jY+WiIqwi6bQL
	k=
X-Google-Smtp-Source: AGHT+IHm7zQAj1NlhCwNN0td/SqMz2s1c5nwv7O7b6XR7eOhry8Taq94/mMMiwlQ0oUA5ZBttaLFcN6WC00SwnLxiHk=
X-Received: by 2002:a4a:e916:0:b0:5fc:4582:4297 with SMTP id
 006d021491bc7-5fc5e5beb09mr1593266eaf.1.1738911576040; Thu, 06 Feb 2025
 22:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205053750.28251-2-ki.chiang65@gmail.com> <20250205224511.00e52a44@foxbook>
In-Reply-To: <20250205224511.00e52a44@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Fri, 7 Feb 2025 14:59:25 +0800
X-Gm-Features: AWEUYZkavx1U0HhBxiNlh8MokYsFU7x3XWM-lcDBktTqucBWvOwQPDvwJYakp6g
Message-ID: <CAHN5xi1HoTHx5bye6v24eRWzuKLXcyp6zc4wVpYDyHcR4yu99A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=
=886=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:45=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> >       case COMP_STOPPED:
> > +             /* Think of it as the final event if TD had an error */
> > +             if (td->error_mid_td)
> > +                     td->error_mid_td =3D false;
> >               sum_trbs_for_length =3D true;
> >               break;
>
> What was the reason for this part?

To prevent the driver from printing the following debug message twice:

"Error mid isoc TD, wait for final completion event"

This can happen if the driver queues a Stop Endpoint command after
mid isoc TD error occurred, see my debug messages below:

[  110.514149] xhci_hcd 0000:01:00.0: xhci_queue_isoc_tx
[  110.514164] xhci_hcd 0000:01:00.0: @000000002d119510 59600000
00000000 00009000 800b1725
[  110.514169] xhci_hcd 0000:01:00.0: @000000002d119520 59609000
00000000 00107000 800b1515
[  110.514173] xhci_hcd 0000:01:00.0: @000000002d119530 59610000
00000000 00002000 00000625
...
[  110.530263] xhci_hcd 0000:01:00.0: xhci_handle_event_trb
[  110.530266] xhci_hcd 0000:01:00.0: @000000010afe6350 2d119510
00000000 04009000 01138001
[  110.530271] xhci_hcd 0000:01:00.0: Error mid isoc TD, wait for
final completion event
[  110.530373] xhci_hcd 0000:01:00.0: xhci_handle_event_trb
[  110.530378] xhci_hcd 0000:01:00.0: @000000010afe6360 2d119510
00000000 01009000 01138001
[  110.530387] xhci_hcd 0000:01:00.0: xhci_handle_event_trb
[  110.530391] xhci_hcd 0000:01:00.0: @000000010afe6370 2d119520
00000000 04007000 01138001
[  110.530395] xhci_hcd 0000:01:00.0: Error mid isoc TD, wait for
final completion event
[  110.530430] xhci_hcd 0000:01:00.0: queue_command
[  110.530434] xhci_hcd 0000:01:00.0: @000000010afe5230 00000000
00000000 00000000 01133c01
[  110.530470] xhci_hcd 0000:01:00.0: xhci_handle_event_trb
[  110.530473] xhci_hcd 0000:01:00.0: @000000010afe6380 2d119520
00000000 1a000000 01138001
[  110.530478] xhci_hcd 0000:01:00.0: Error mid isoc TD, wait for
final completion event
[  110.530481] xhci_hcd 0000:01:00.0: xhci_handle_event_trb
[  110.530484] xhci_hcd 0000:01:00.0: @000000010afe6390 0afe5230
00000001 01000000 01008401
...

This may become confusing.

>
> As written it is going to cause problems, the driver will forget about
> earlier errors if the endpoint is stopped and resumed on the same TD.

Yes, this can happen, I didn't account for this scenario.

>
>
> I think that the whole patch could be much simpler, like:
>
> case X_ERROR:
>         frame->status =3D X;
>         td->error_mid_td =3D true;
>         break;
> case Y_ERROR:
>         frame->status =3D Y;
>         td->error_mid_td =3D true;
>         break;
>
> and then
>
> if (error_mid_td && (ep_trb !=3D td->end_trb || ETRON && SUPERSPEED)) {
>         // error mid TD, wait for final event
> }
>
> finish_td()

Yes, this is much simpler than my patch, but we still need to fix
the issue with debug message being printed twice.

Maybe silence the debug message like this:

if (error_mid_td && (ep_trb !=3D td->end_trb || ETRON && SUPERSPEED)) {
        if (trb_comp_code !=3D COMP_STOPPED)
                xhci_dbg(xhci, "Error mid isoc TD, wait for final
completion event\n");
...
}

, or do nothing. Could you help with some suggestions?

>
>
> Regards,
> Michal

Thanks,
Kuangyi Chiang

