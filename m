Return-Path: <stable+bounces-154681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A379ADF002
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39FC16EE35
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E909199947;
	Wed, 18 Jun 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztOfbE7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F14195FE8
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257912; cv=none; b=TrkobldN2a+49q7+ME2BIVocgL/Ntoq7+7t6rtSYJ65e6uw3ujv35US7Jlo+GOJEuSiQYToWaal+m2h7xTDCf+C6Nrzp0oyJOjzC21bpOS9qwVacQW9rf3lBXqadQgUmXlRMrxYT+k1B+vFdMZkI9ppCs0n0WB2sSdE5EZ1dlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257912; c=relaxed/simple;
	bh=wFDJGOoYvxypvMpqpT4ZM8yTHl6scWUOtsqCWIeHNU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9fo5xX9+ZMypRFWumlR+mjLYLhI4FjUXHESDYmKiNcZIDmqVCrZoySJ+qASc4+uIYKctVIsV2dtFRPsxapFC4sOtur8D/GYSjWOQq+lDHYeyDYiWd68nx+c4FT+LowmDe9CWhWCGC9E2JyvQ8l8wEsjVwS44hh9jkrCmmDPR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztOfbE7B; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553a5f2d321so8704e87.0
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750257908; x=1750862708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgwogF8uqMbr2+utkBcdB+9XUE0/TMWHXyL3HiSuo4U=;
        b=ztOfbE7BV6PqP1SZRntwrn1NAZ0bs4p/keOwkqgUHfydN0ecy5SdJhw4Kd2oelNamV
         Ltf2ccSogNMs5dtKsPuDH1cCyvLSSA8oX00hBKHkHCCta5M2kzmBUk61rA4MbkJa+BCs
         zZAml6AJkmUaB2yK1mN6FVodMhqvmJ4StM0A3ai/4lGYvB86Xim9aUpFGmnChtEflv5D
         UqtaFM1XWpdQ9w/KOQ5dxd0xy6ADdFekIhPTkrimoJJLtosjahVhj6B0+Bgx7rA9FnWf
         Bkg5XNPpIv4oP2f96wUlUOjY5VNaHabZXDXqGN3v+Dz0zhTHZGniVDFIkzPAhkL2lmmZ
         SXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257908; x=1750862708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgwogF8uqMbr2+utkBcdB+9XUE0/TMWHXyL3HiSuo4U=;
        b=jRsBwz5UtZxaZMYx4CY3GAN4HHY08sOIuhYAot38Oyi+Iaiam3x4L0BbruwWsy89M2
         ru0FqH2NHvuNtx9VhuSk+UG7sB75JCOdASAziaVinb/jwhWRDgPXFHkHDmJ8Swrc8ZAy
         kWyGsOyiBYAplb5qxePxsPoNjrnAHqx+yE+tTvGTNIFL6GaqrKB0ABvcAtYTmrZ6LhkF
         Sx+Mo4rgAPJ+SmECyjfinKrxeBe0V1TC9tRvCiNVsM3NIvOfdT8bO9U3LPMGzAleYDXG
         T0PYGuuaNnT27jElpdqTetyupNLx36cqA1A/S+uvQhiFmTwSflJBACAIC47Cq3c8X71G
         G58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBhH686zncWRcmo5Lr7/pvWJAtjj6XNLknGQOTAUG+fyetGEBrH/g+DpbS81KIgk27MVEQQT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2y8o3SRpCUb9+JWn/lcxd7FOJqTxbsxUG6Yir18qGdtKSdQT6
	M9OjjcMNn4kMp/HcyzliC4sI5wtRPCKXdyO+8+wJ3WXLT7JZqYnriIlA3DLhg9MZskeQ5RSIXHy
	+Uflly2H1zq3np/lnuAgAQCOaVdouc08IEOKTUO/j
X-Gm-Gg: ASbGncvAx78TD29Tx7Zlf5dLEEdiVXBqAsW3xz94qQvFJUM6w9WUQB7rNRiDPlNC7wt
	KWVHgKO0K5lpq94iYj/4nKgBwluZ/scFdHBzh95Ej4qXdk/fOxIOnVDLECmuFqs9fFVUCrsAFON
	6Jky9r54/ljLWdP7kbKCtD4x2+fNkptPOr3wi8U/FQy43I
X-Google-Smtp-Source: AGHT+IGsHULveGxM+Zja84HplaohcRZH+z1Ahxw+rjNmRssuHdQl/61J38I3+e2DEDA8rD3yf0Aeas3nTywrwhBEfyI=
X-Received: by 2002:ac2:5deb:0:b0:553:50d2:5c20 with SMTP id
 2adb3069b0e04-553b80b051cmr996457e87.6.1750257907321; Wed, 18 Jun 2025
 07:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617050844.1848232-1-khtsai@google.com> <20250617050844.1848232-2-khtsai@google.com>
 <8cbc5220-c993-44a1-b361-418b36a3f336@oss.qualcomm.com>
In-Reply-To: <8cbc5220-c993-44a1-b361-418b36a3f336@oss.qualcomm.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 18 Jun 2025 22:44:40 +0800
X-Gm-Features: AX0GCFsDnAuqG_eBCE0NH5iSAwM0mK_YNKjBQDLgH6k-Y0wAmBs5AA-kujp4xNk
Message-ID: <CAKzKK0p0fx4bsqVVPWjJQxG0sEHee0b0OPE7dqCb7cbW7+XkgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: u_serial: Fix race condition in TTY wakeup
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, hulianqin@vivo.com, 
	krzysztof.kozlowski@linaro.org, mwalle@kernel.org, jirislaby@kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:26=E2=80=AFPM Prashanth K
<prashanth.k@oss.qualcomm.com> wrote:
>
>
>
> On 6/17/2025 10:37 AM, Kuen-Han Tsai wrote:
> > A race condition occurs when gs_start_io() calls either gs_start_rx() o=
r
> > gs_start_tx(), as those functions briefly drop the port_lock for
> > usb_ep_queue(). This allows gs_close() and gserial_disconnect() to clea=
r
> > port.tty and port_usb, respectively.
> >
> > Use the null-safe TTY Port helper function to wake up TTY.
> >
> > Example
> >   CPU1:                             CPU2:
> >   gserial_connect() // lock
> >                             gs_close() // await lock
> >   gs_start_rx()     // unlock
> >   usb_ep_queue()
> >                             gs_close() // lock, reset port.tty and unlo=
ck
> >   gs_start_rx()     // lock
> >   tty_wakeup()      // NPE
> >
> > Fixes: 35f95fd7f234 ("TTY: usb/u_serial, use tty from tty_port")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
>
> Reviewed-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>
> > v2:
> > - Move the example up to the changelog
> >
> > Traces:
> > [   51.494375][  T278] ttyGS1: shutdown
> > [   51.494817][  T269] android_work: sent uevent USB_STATE=3DDISCONNECT=
ED
> > [   52.115792][ T1508] usb: [dm_bind] generic ttyGS1: super speed IN/ep=
1in OUT/ep1out
> > [   52.516288][ T1026] android_work: sent uevent USB_STATE=3DCONNECTED
> > [   52.551667][ T1533] gserial_connect: start ttyGS1
> > [   52.565634][ T1533] [khtsai] enter gs_start_io, ttyGS1, port->port.t=
ty=3D0000000046bd4060
> > [   52.565671][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> > [   52.591552][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> > [   52.619901][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> > [   52.638659][ T1325] [khtsai] gs_close, lock port ttyGS1
> > [   52.656842][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be975=
0a5) ...
> > [   52.683005][ T1325] [khtsai] gs_close, clear ttyGS1
> > [   52.683007][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be975=
0a5) done!
> > [   52.708643][ T1325] [khtsai] gs_close, unlock port ttyGS1
> > [   52.747592][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> > [   52.747616][ T1533] [khtsai] gs_start_io, ttyGS1, going to call tty_=
wakeup(), port->port.tty=3D0000000000000000
> > [   52.747629][ T1533] Unable to handle kernel NULL pointer dereference=
 at virtual address 00000000000001f8
> > ---
> >  drivers/usb/gadget/function/u_serial.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadge=
t/function/u_serial.c
> > index c043bdc30d8a..540dc5ab96fc 100644
> > --- a/drivers/usb/gadget/function/u_serial.c
> > +++ b/drivers/usb/gadget/function/u_serial.c
> > @@ -295,8 +295,8 @@ __acquires(&port->port_lock)
> >                       break;
> >       }
> >
> > -     if (do_tty_wake && port->port.tty)
> > -             tty_wakeup(port->port.tty);
> > +     if (do_tty_wake)
> > +             tty_port_tty_wakeup(&port->port);
> >       return status;
> >  }
> >
> > @@ -574,7 +574,7 @@ static int gs_start_io(struct gs_port *port)
> >               gs_start_tx(port);
> >               /* Unblock any pending writes into our circular buffer, i=
n case
> >                * we didn't in gs_start_tx() */
> > -             tty_wakeup(port->port.tty);
>
> Just curious, since this is already under lock, checking for
> port->port.tty would have also helped, right? Anyways looks like
> tty_port_tty_wakeup is better.

You're right, adding a null check for port->port.tty also solves the
problem. I actually submitted that exact solution last year, but it
was rejected.

Link: https://lore.kernel.org/linux-usb/20240116141801.396398-1-khtsai@goog=
le.com/

>
> > +             tty_port_tty_wakeup(&port->port);
> >       } else {
> >               /* Free reqs only if we are still connected */
> >               if (port->port_usb) {
> > --
> > 2.50.0.rc2.692.g299adb8693-goog
> >

