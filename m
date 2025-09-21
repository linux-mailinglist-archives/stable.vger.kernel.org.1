Return-Path: <stable+bounces-180837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B81B8E3A2
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 21:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF7218968F8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38747214A9B;
	Sun, 21 Sep 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIMP4rPw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412242BB1D
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481455; cv=none; b=ANxUKGlE73G5I5ZAZTNkTbn3H+JokCaFAMPTPTFq/UrbmnoTGz6yM7zoz7EicXSE35fH24gWW5PpcXJj0DPLL/VfOOaTcNPQz3vUsa3qBtMjuBPBfdEpkR16/0lgZzz2h7woM5EU0HeN6Hqdo/4hLrPs59ocBS6xhyiYc857iBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481455; c=relaxed/simple;
	bh=BJPFF72dsCJl//Va5XHokThLKW/b3to+vIBA6ac9V2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJtB2rIlb7pyt7A1vOGj/UXRGoce8alR3AVUcYtiaRIMNcSJEcoKp4pxUTVZc2XtOm6VR1lZ9V/MM44xWZLTuOSY0RvS52NQZayM5KXro52et7+WwWcJREvqIi6BFD2KVCqcLaGKYjX4gsgRfC6R+PTvEirJJd+yaGwO7IiO6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIMP4rPw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so485080166b.2
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758481451; x=1759086251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HTjUfL5kki5kMB1zvXr2jB2trY+d+4aKWapJKFWTs0=;
        b=RIMP4rPwyFlireRoboG79/sRAvOil2ckCejtv1XrYW6gqA+AoXfAxHjXQUfV6UuSHN
         AfGyeomhHGQQmKSxYhOZaIKc40KkAzNXBteWAcxQ/f3djJPkXLNidgTAv7tC/QR5bIYg
         o7qLwizrMOTEtJaLf+zthVGbmPwyZLK6q+2aapMAOGqMVt7kUlQ4W31K1DQCM0M67Gct
         tQt8tyEpbs4zzFVQisAiQPrHCOrNZAWJcNSIz36kfFmjk0FsfLFSlCM0EfafGjR2Fy0d
         WbwC6M7ZA9ysB+5ilpZjbwYR82VTAx+u6ANfddfa7rsOmQiKz4EFjVrf0fgUGn5ABn4j
         oGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481451; x=1759086251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HTjUfL5kki5kMB1zvXr2jB2trY+d+4aKWapJKFWTs0=;
        b=AciU3U2mxxm9eK5CPK1K/mEWl01MoCsXOZ+W4/J8nVm8xw6HH+7K+meuTvkC+oLFv8
         iqzztPneKrXYuxL7mA8Re1EnWD+CsN3ZnIOwX2oNDIbFuiK57cPxZohBHD8ChuVvoMHO
         1igy2Rkr9i0qDbgzW2f2TwS/zL3y3Pp+nCouDJFnuhUAyTRcH5ANyM5A4QSptCbN/0HQ
         dWgh+Cqr69p8FpIHX/82f4iXuGFNGXO4WTgN4Dm2FXF+Sx/VLoU4jSqpetvo4Sk50jPr
         8KJVv3/69C2Z4t3nomvu5F37lCADKenYz79Vt5f6FqPxU/mvxa+7WAXZ2sGXNBJhYVhz
         lIug==
X-Forwarded-Encrypted: i=1; AJvYcCVl3lveT8wj1Wj+WXZqvSYYyYZjyX+Gv49c4vhwlP2D8bsMx25fP4OSmxTjq2dyBWBTKY1Gils=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURLP3FI0b+mymTF/UHKwxQsjYgM3QZ/YSVWEsnK1gGfW7MEQg
	AMmdkqYovy4sjsaTWRfK9vj/Qn9C6T0+bUPcbljPbidJj5YhHpoPyuh3sXJSEPhHgJmmwbD1ngH
	OpTPG0INoK1BUvszgr1s68YrJxmIEFME=
X-Gm-Gg: ASbGncv/1jIVlVat6pMb4ZAguK3FCM/y/FLJPe0EO4cMDjWaCtu8r3l2IxbtAnYaaix
	X8xszxS1UBTU6pbO5ApjMo2LgwYoTJ47sazKAV0ezX6jWE3gXRGb8DntLZqZqZqdqfCLvKcxRP4
	5iHUhe498Ne3BmzkCXkRBwKkVEswI71TPCbuQeZZ02/0fky/ZqOZHFPhhgnqBd5cUzhYovWo4zZ
	5oDmHGiPJkCJFhFcw==
X-Google-Smtp-Source: AGHT+IHBSnpMJcWk6XkKtG6y4uHFbhdXqxkzUnTU5yVuXt4gqaAGYKj+uH6Cnq8v6c/a2ZttHmoR79jp+2R7muQ2PIc=
X-Received: by 2002:a17:907:3c8a:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b24f7f1a36amr1039680266b.64.1758481451396; Sun, 21 Sep 2025
 12:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920201200.20611-1-hansg@kernel.org> <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
In-Reply-To: <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 22:03:35 +0300
X-Gm-Features: AS18NWCBhiEjsWPWd83UV9lSxsFOVR7Ya2wWnCbsBeeXYvaqpUaLo0Egqw1SSbE
Message-ID: <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com>
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 9:09=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
> On 9/20/2025 3:12 PM, Hans de Goede wrote:

...

> Looks pretty much identical now to what I sent in my v3 and that Andy
> had requested we change to make it fatal [1].
>
> Where is this bad GPIO value coming from?  It's in the GpioInt()
> declaration?  If so, should the driver actually be supporting this?

Since it's in acpi_find_gpio() it's about any GPIO resource type.
Sorry, it seems I missed this fact. I was under the impression that v4
was done only for the GpioInt() case. With this being said, the
GpioIo() should not be fatal (it's already proven by cases in the wild
that sometimes given values there are unsupported by HW), but
GpioInt() in my opinion needs a justification to become non-fatal.
OTOH, for the first case we can actually run SW debounce. But it might
be quite an intrusive change to call it "a fix".

So, taking the above into account I suggest that the helper should
return int and check the info.gpioint flag and in case of being set,
return an error, otherwise ignore wrong settings. Or something like
this. In such a case we may also use it in the
acpi_dev_gpio_irq_wake_get_by().

> https://lore.kernel.org/linux-gpio/20250811164356.613840-1-superm1@kernel=
.org/
> [1]


--=20
With Best Regards,
Andy Shevchenko

