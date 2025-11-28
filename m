Return-Path: <stable+bounces-197624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073EC92DD8
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 19:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC273ABED6
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473F332EA5;
	Fri, 28 Nov 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7vqab36"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0D33345D
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352804; cv=none; b=ah2lzGeNEfvTsUv9kSMC6EpbQNFti0IJP2mcBRcOYJ/WGvbDrB2Ixbzs8XOhcBbb93f4eXSTHFtyiYac1wDUIHcJtdLnOvq5usDm5KbzBy1+H/t95mh7HLrrh61yaSbK9gM4k7JYx9uTFhxAonwjeoSJumgQvxbqaquvy5HpyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352804; c=relaxed/simple;
	bh=ECUXSR4U96orJixpkWssmGfOVBqVIhjeWDFsBnEHe70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI54wPREjGmZqlPdCcEuRoJ74v7ZHDb8su+rQhDXPU45bzGaQZBWDtdYKI9VoZWbUZDoux58oLvWxWOLd/lz8If20eL+b9zswRdhXXjFys1Sdh5nEnHM1wt7xjN1jCqhpquo8mKDVZNKV4nojfLdkY/1dOAqFUBnh0eEZjr9mNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7vqab36; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so785377fac.2
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 10:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764352802; x=1764957602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECUXSR4U96orJixpkWssmGfOVBqVIhjeWDFsBnEHe70=;
        b=R7vqab36kFJQV9EWoa+e0klNq7eU5zb5SwnCd6fDMnUE3NSAFyPrcsLG/6YyjBOv1v
         UQ0akpM8wIrNFOFJKBDPk874g5HviPcw7SZSqY+ZA85En70mFyAsN/nYgYqBCpd+X+r3
         ZAo1DxTbH94Pwvyswq0i4CFfSj0fDkzmkbpipSkDv54Xtw3kO1YzMbFHDXCLpQMdgNdm
         CQplOREhuBmYM3lV+zb+9l5BHgTleQfJX9Go4D5wQhlL77Jm1M62rcpIq1W7ge+Ta9Tn
         KlbJ2FNoFzluJaxPNDXRHTefn8R9H6Genf8GHOWaqFJvcRrJ8CFEuy9UIvVmEQ/j1YmC
         A0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764352802; x=1764957602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :x-google-sender-delegation:sender:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECUXSR4U96orJixpkWssmGfOVBqVIhjeWDFsBnEHe70=;
        b=HnAm7Cz0058MkBM2m5d01wfkNXuyEbbqUk0ADqD1PNYhK4Uvxa8MoT315l3trtv+p3
         jNZg9w1qTD78Bo6jmHaqa+N8FUXl/67MA/ORZS2oqDTg0f0BJRIfNnb+M1ENJwGbChxA
         CxIeVqSEEHq+uo0BU11dz1PGNnpuE8Q/imhS6/SmD7v9zpeyJLcw2yhs+3feeHque/sp
         okNz3z1zs3T6ZPYnB23le7oDkwuv5YH0THvcAAasv8M6L3+2nVkTd1GrN0iCUadeOzw+
         JohmBk7igcuiqmEhaceHh36dvAuKjgHzbJWFpwr4h2xDHsE8xe08sa6/fnG0tvnGS24w
         PlXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs27mSfYPYjH4/8Sxo3joVduDoFXuRLqFkj7R8Y/8U0XFiU0q9vKA1YDPQDZ2RR6fiwz1ORRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EyZtQPOdYu8gmC5EZUBOx7YntIPfDklvGEGRS1N8pVR55WoU
	iBanX9taJ0SgFA4oZDOcMBZeW4V16N2brl7K73AQkaJCCcTWJgksTdnP7zP5o1iuItt+HayEvtH
	Ve1KWIAMxAz18drMPTA3gTqIKnd6qIch11gXuvss=
X-Gm-Gg: ASbGncu9CKVVbzSMvVIf/ej/ESBo7n1J/jb573lWxiw1pTT3vWL6h8P/kRngm3d8IbL
	C8e2E1HBsOuWP6wweGbKAgKEag4QwG3eNWSMXzGVvua1gYryWS0FXo0Dd1up5H/dzQBkTeXc16S
	+ywvs6Iyp99eZnyluLDnhkT/yqRAqfDO4qNux+bPUu4Hxvr9dBB0IEeRdvk9Ofu25pb61d5uigc
	RSlJSY/deUI6wiFMf2gvdD6bsFhjcjFHLo9hCcFJ5zD9WRxOw4rfEqQgAwwUx7orMF+4YAwoRm7
	0p0=
X-Google-Smtp-Source: AGHT+IGwQdWkwD3oLqoEjcg38f4Ne9W3YQFdwdBnTRDIOapB6SkiW3MAoWautq5VTQ/9khFBGQUsvoAEjStwjacGWvY=
X-Received: by 2002:a05:6808:1b2c:b0:44f:e211:856e with SMTP id
 5614622812f47-45115b8889fmr11673023b6e.50.1764352801286; Fri, 28 Nov 2025
 10:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128124351.3778-1-hanguidong02@gmail.com> <f5a0e99d-306a-4367-8283-b5790a74dfcb@roeck-us.net>
In-Reply-To: <f5a0e99d-306a-4367-8283-b5790a74dfcb@roeck-us.net>
Sender: 2045gemini@gmail.com
X-Google-Sender-Delegation: 2045gemini@gmail.com
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Sat, 29 Nov 2025 01:59:51 +0800
X-Google-Sender-Auth: p50osYshLPhQwT0JjSmXxGP18EU
X-Gm-Features: AWmQ_bmBarVYMquAekr27ZrtklPwTLh9JPE_EWhAWm3IyhQmO6wdSHTyPZngemE
Message-ID: <CALbr=LbzgLK7Y-e3TTpusXGZEq4+DJJ=mbVMP=M3gt6XDGNUGA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6620) Add locking to avoid TOCTOU
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 12:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Fri, Nov 28, 2025 at 08:43:51PM +0800, Gui-Dong Han wrote:
> > The function max6620_read checks shared data (tach and target) for zero
> > before passing it to max6620_fan_tach_to_rpm, which uses it as a diviso=
r.
> > These accesses are currently lockless. If the data changes to zero
> > between the check and the division, it causes a divide-by-zero error.
> >
> > Explicitly acquire the update lock around these checks and calculations
> > to ensure the data remains stable, preventing Time-of-Check to
> > Time-of-Use (TOCTOU) race conditions.
> >
> > This change also aligns the locking behavior with the hwmon_fan_alarm
> > case, which already uses the update lock.
> >
> > Link: https://lore.kernel.org/all/CALbr=3DLYJ_ehtp53HXEVkSpYoub+XYSTU8R=
g=3Do1xxMJ8=3D5z8B-g@mail.gmail.com/
> > Fixes: e8ac01e5db32 ("hwmon: Add Maxim MAX6620 hardware monitoring driv=
er")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> > Based on the discussion in the link, I will submit a series of patches =
to
> > address TOCTOU issues in the hwmon subsystem by converting macros to
> > functions or adjusting locking where appropriate.
>
> This patch is not necessary. The driver registers with the hwmon subsyste=
m
> using devm_hwmon_device_register_with_info(). That means the hwmon subsys=
tem
> handles the necessary locking. On top of that, removing the existing driv=
er
> internal locking code is queued for v6.19.

Hi Guenter,

Thanks for the information. I missed the new hwmon subsystem locking
implementation earlier as it wasn't present in v6.17.9. I have since
studied the code in v6.18-rc, and it looks like an excellent
improvement. I will focus exclusively on drivers not using
devm_hwmon_device_register_with_info() going forward.

In our previous discussion, you also suggested adding a note to
submitting-patches.rst about "avoiding calculations in macros" to
explicitly explain the risk of race conditions. Is this something you
would still like to see added? If so, I would be happy to prepare a
patch.

Best regards,
Gui-Dong Han

