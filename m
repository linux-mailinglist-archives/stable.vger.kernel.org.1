Return-Path: <stable+bounces-169299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A3B23B9E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D593516D9A0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11F2D6E49;
	Tue, 12 Aug 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep4Mx1/Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89023D7F2;
	Tue, 12 Aug 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036178; cv=none; b=eLvTlzsEJ47uFuM0gApQr3IPdEqSQrmCaAJdX6j7j2yY/UeIIE9ZJL1crBDEsucyi0Y2a6tnzTQtNboLf53sZ2uS8Lga5MDI01lW/YnMtxWDo7OoknPNPaPjFoF04GZuBa6DxGpWTHw/Lyi8LVk483c4w9fMeZtVtk1tHjYx774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036178; c=relaxed/simple;
	bh=1x7t5wWL9HcNnaOfBsQPYQIOiskmEFP1sIHOP5Qa1Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoGyNrkJhrGtqFncRVx4g7XYwfteWepex6cUdTWAVfpxL87rDTLKwUJO/3SsFMl+iHo0xKhrNEp2qXZ7qS/E2kWdTbs2MQ2hS8UHxySgW+f0D2KuK/tm4dCwW0gs8Ww4IW7CKQdcSEGZnlTR+UQ5Rn+Iv4P254ZMHGjgNMR55O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep4Mx1/Y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b797ad392so7024693e87.3;
        Tue, 12 Aug 2025 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036174; x=1755640974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNl/M0OvGwvDqjB88jNN7p0rDDZU5B8ZAYSCNldxDjU=;
        b=ep4Mx1/YTFnICVRSmwcC1jAShO7Z6HmFucUtSgdjgzl2mSjWIKaGFIQqRE/X6rJYkQ
         5YZ00bHd5x5MS2yqSm9kXe6RMkVKZRrLK7U0fLczZmNiQraPzeU5Hszy/SWywAFE7BMn
         nzcUMfcfDCOcojYjtAU2TCGT+opynlSr8OkogIM1GRbDq4dOKnggTjuB+UEtRXtLrhYM
         QoB7RnmAHS8CzE8HG6ORUeagkBFvuRJIFYIduhoVCmJzgSy7nTV1n/OUaaL/ecRimjAu
         WsLsMQ9Zg5shAK+wcDipKC7P7oDuOKkrmJQk5wpYFvsYz+zUKIg3PFptIjzO5KgM3Few
         W8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036174; x=1755640974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNl/M0OvGwvDqjB88jNN7p0rDDZU5B8ZAYSCNldxDjU=;
        b=l+4+YbackvsJH8sj80unCycaqNY8wx2Z4hqDkPR7R3dhlZieiTkpWeWzaKEZ1WhsDV
         zWs1nrCDfvv8IR3ybCyg/42yzMy6p8LC4LCtU0625FK4aZfmVEu5iE+pgNITSfQvSaRO
         0oJ7/+JBjlwCBY2n0+IXKYvk3qag0GJ1QJrK+wkTvbLevdnYdCDrzKCaz9uXgNxFUOUy
         Q5Xh7pHF307hiwdcHBKoGaMLSytEN/tyoe1ngZmI9nuyl2aO9+fRd+8GQkkcH7f4sXSr
         4gy55QRhp5WBt+oXRXdiobnY3N1sHxSi4ej0DCljS+Zne7bMWAGW6FCDNU4KuRga5GGZ
         htcg==
X-Forwarded-Encrypted: i=1; AJvYcCVb97eUBFbnu2IuJTPtzt8iOGnb3us+9rJYnKMcxLYxnehrKjroqk5t9pfpQYa7njRqsVCrRgqk@vger.kernel.org, AJvYcCX5dSqXl9eqjRL1Si+LZUBGwsZIaoOvxutV7k3Pj/Irr8zL0w+f3EBcCDSjFQqeEEaX5NxkszqR2Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxguwn4F4n15gHzYM0IPMUeUMdzeMH8R3+jcVT8kq6XfSJeYf07
	yE83bjoBvr27mGvs4bmXt6QkU6iZmyTBlPlU3gdK69No71L0RiAmTUoy
X-Gm-Gg: ASbGnctEEC8qQh1MGLOSe8msOJZstJ/oaH5iL5JZldGpOkq741u533XI/2r1ELpWzA+
	q9oZfawuswsFtgiTqQQ365dAxtFiPwOqKFig4vNG8o9RgtinzXJyLzssoZfglSzvOL8sCmdTaTg
	np67cRjFuR7wJp5ENHHOsxDT2+4ebscwk2WhpYl0VAWEJEmxVZ3SqtpamFYCqwGn6fFJcSkeryd
	K1Ie2SRvjs4wUsAVlZJg0ellct++3G6h7fA7ErSKulu/USl0pFnaIpGTRGbolF9WYzgGQGYjRyJ
	IAWXZAf9qEjUkOrsj41wF3fQKn9EuPDmj9cKbCR4fbtlHwZcsluD97VdDGvnrxpaw+OwrhH5Mm0
	/o9K9VQkDxoj3gmQ2y3hPBV71QFNGi3TyEEXmg9044Stukg==
X-Google-Smtp-Source: AGHT+IE6BDQibg3kP5nW2d4pufTS7GP36fyBY6oAVySTNLlebU4AM+/FAiM86149hVO3IJ+Lo6sXTQ==
X-Received: by 2002:a05:6512:3b0b:b0:55b:8e7b:8afe with SMTP id 2adb3069b0e04-55ce03b5e1amr191470e87.27.1755036173770;
        Tue, 12 Aug 2025 15:02:53 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabce5sm5012956e87.151.2025.08.12.15.02.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Aug 2025 15:02:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 00:02:48 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Marcus =?UTF-8?B?UsO8Y2tlcnQ=?= <kernel@nordisch.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby 
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?B?xYF1a2Fzeg==?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <20250813000248.36d9689e@foxbook>
In-Reply-To: <4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
	<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
	<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
	<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 20:15:13 +0200, Marcus R=C3=BCckert wrote:
> On Tue, 2025-08-12 at 13:48 +0300, Mathias Nyman wrote:
> > > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: x=
HCI
> > > > host controller not responding, assume dead
> > > > [Wed Aug=C2=A0 6 16:52:50 2025] [ T362645] xhci_hcd 0000:0e:00.0: HC
> > > > died; cleaning up =20
> >=20
> > Tear down xhci. =20
>=20
> so usb is not dead completely. I can connect my keyboard to the
> charging cable of my mouse and it starts working again. but it seems
> all my devices hanging on that part of the usb tree are dead
> (DAC/keyboard)

You have multiple USB buses on multiple xHCI controllers. Controller
responsible for bus 1 goes belly up and its devices are lost, but the
rest keeps working.

It would make sense to figure out what was this device on port 2 of
bus 1 which triggered the failure. Your lsusb output shows no such
device, so it was either disconnected, connected to another port or
it malfunctioned and failed to enumerate at the time. Do you know?

What's the output of these commands right now?
  dmesg |grep 'usb 1-2'
  dmesg |grep 'descriptor read'

Do you have logs? Can you look at them to see if it was always
"usb 1-2" causing trouble in the past?

> lspci is here=20
>=20
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1247895#c3
>=20
> Mainboard is a ASUS ProArt X870E-CREATOR WIFI

Thanks. Unfortunately I don't have this exact chipset, but it's
an AMD chipset made by ASMedia, as suspected.

The situation is somewhat similar (though different) to this bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D220069
Random failures for no clear reason, apparently triggered by some
repetitive background activity. Very annoying.

