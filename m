Return-Path: <stable+bounces-50383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFCD90605A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CF51F221E1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC91B646;
	Thu, 13 Jun 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrTxscEG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2E8F68
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241781; cv=none; b=mO6/CM40hqS1TU5ACn4LO8Lmp4FR1Y3MLXGvGF7YhSSgHFTxmWd0Km5iCheavMncmCnC3wfUm03YKr4XkvjDFjv/zAzQpyc11zGidEN+4VZmGea6DQRU62fdbBQSv/PALA0VZIkFQMpXSIhKJuibqPIMfHct7gpxk/7s8hnRkhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241781; c=relaxed/simple;
	bh=v+51Jinn7l1pZFyQrg4AsqZNKb168ON+pkaoI2MxRd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqvx6+jQX5THUTQEyQGqKuB181TBFk4XSyyR0OZk2mu+uSgQimESBYyaLZvCpRcWgQqXha5vFqXKgrWUaGW+89KYZgQymijqJvEXctfOJ3/Xazi9UMsWc0tC/4/b3aj8Hewgis80gpW+6TM+1tKWRP79OFJe+wZyT1FvbZeKEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrTxscEG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so336553a12.1
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718241778; x=1718846578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYcAAZKj6LT7J/eNcGh35I1PJfriZS4K7Ys7byqs15I=;
        b=HrTxscEG3Oq8a4xg32GRTCbMvOB5YQ/OYR/9rqOUhr3GCASGXJJNIpQMEbvy5rAPTZ
         UbsuC8AzrBaPAyPLoGeLjqEZ8bdRXaW0+kZs/3mfE2arsuOSdEjo9DJaJrAbZ/CcmNOX
         FHqQm3VImm2rMRB92E6adCo8g1mfo3sY2VuBFlIRKj9BEmIFvoY1zPK5/cnBYAc/CvLu
         4f3FoZmYcHMnyKwNORGzbrino5A8Gq5aMjA5a6OPnHhimUHoMuWsiRjgP6XX9hpM2G68
         eG2ETw1sDAje+6fO72Qty69Zh1zQlWzLcVgBtnD0P5mf0RObT1XvwjUNXf950T1M78p0
         F8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718241778; x=1718846578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYcAAZKj6LT7J/eNcGh35I1PJfriZS4K7Ys7byqs15I=;
        b=cHsOeUOAqFAFlRqAtrDVUlNgt6EVJxPUyGvRF2YJOSffRKPGY3MH9Ir9mpU5VDie1E
         YOoJs9+AlN83Q0m6W2zfkokg33BJgGhDPrggIUrKyouGDHdcCi5UErbcb60GuBrAd41L
         Gh1er/J/WOXv5T2qhFTvVdr5jJaDf967oCfoa9VCgG/TbmF+UFY5GrldGTjAr3YY/KTL
         SJAepj82nBKbxLzRnlkXDQF4xqhv9OqEV1eesOIfXI5jq2gmA8xvQf/h0lCYvB83M2mv
         Cc7rsHLiVevUphyzqAEnUmz36WQs9kY5QZFcjk1HEnGudIP51PilqMRWP6euNM14cbx4
         /owQ==
X-Gm-Message-State: AOJu0Yy6ovi0hGvu+8Udjf+IoVNgCTyO0u9QuCXxtbccPJF4AnWPnGWA
	jM9PAs6rPLAbH/JuILgxFONyjf2eumTzAqtNLMx5WE+ILy/r6p3wooqocLKK4X3ekZ7uFVpM+YM
	HVxa1MNydlkxlpMnxaVhD7V8rfY4=
X-Google-Smtp-Source: AGHT+IFFaOV9WtYBeejojpW1zqDtrAGX5FsaLjpVqnMeQj71RUpCjHHFkSPGSjtXsb7j+CBD5ZQ461AxXV1x69gQQ+c=
X-Received: by 2002:a50:aad6:0:b0:57c:80f7:6f5 with SMTP id
 4fb4d7f45d1cf-57caaaf125fmr2210101a12.36.1718241778060; Wed, 12 Jun 2024
 18:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527195557.15351-1-jandryuk@gmail.com> <2024061236-amnesty-eloquence-16bb@gregkh>
In-Reply-To: <2024061236-amnesty-eloquence-16bb@gregkh>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 12 Jun 2024 21:22:46 -0400
Message-ID: <CAKf6xps_0CFbMppgL4ViCpnJCWkb5va6Erksv9PckuuU+by57Q@mail.gmail.com>
Subject: Re: [PATCH] Input: try trimming too long modalias strings
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Jason Andryuk <jason.andryuk@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:17=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 27, 2024 at 03:55:57PM -0400, Jason Andryuk wrote:
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > commit 0774d19038c496f0c3602fb505c43e1b2d8eed85 upstream.
> >
> > If an input device declares too many capability bits then modalias
> > string for such device may become too long and not fit into uevent
> > buffer, resulting in failure of sending said uevent. This, in turn,
> > may prevent userspace from recognizing existence of such devices.
> >
> > This is typically not a concern for real hardware devices as they have
> > limited number of keys, but happen with synthetic devices such as
> > ones created by xen-kbdfront driver, which creates devices as being
> > capable of delivering all possible keys, since it doesn't know what
> > keys the backend may produce.
> >
> > To deal with such devices input core will attempt to trim key data,
> > in the hope that the rest of modalias string will fit in the given
> > buffer. When trimming key data it will indicate that it is not
> > complete by placing "+," sign, resulting in conversions like this:
> >
> > old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> > new: k71,72,73,74,78,7A,7B,7C,+,
> >
> > This should allow existing udev rules continue to work with existing
> > devices, and will also allow writing more complex rules that would
> > recognize trimmed modalias and check input device characteristics by
> > other means (for example by parsing KEY=3D data in uevent or parsing
> > input device sysfs attributes).
> >
> > Note that the driver core may try adding more uevent environment
> > variables once input core is done adding its own, so when forming
> > modalias we can not use the entire available buffer, so we reduce
> > it by somewhat an arbitrary amount (96 bytes).
> >
> > Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> > Tested-by: Jason Andryuk <jandryuk@gmail.com>
> > Link: https://lore.kernel.org/r/ZjAWMQCJdrxZkvkB@google.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > [ Apply to linux-6.1.y ]
> > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> > ---
> > Patch did not automatically apply to 6.1.y because
> > input_print_modalias_parts() does not have const on *id.
> >
> > Tested on 6.1.  Seems to also apply and build on 5.4 and 4.19.
>
> How was this tested?

I built a kernel for 6.1.92 + this patch and booted a VM with it.
Inside, I used udevadm and looked at the sysfs entries for
xen-kbdfront.ko.

For 5.4 and 4.19, I just built the module with `make
drivers/input/misc/xen-kbdfront.ko`.  I see now that misses building
the actual change.  Sorry about that.

> It blows up the build on all branches, 6.1 and older kernels with a ton
> of errors like:
> drivers/input/input.c: In function =E2=80=98input_print_modalias_parts=E2=
=80=99:
> drivers/input/input.c:1397:40: error: passing argument 4 of =E2=80=98inpu=
t_print_modalias_bits=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier f=
rom pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1397 |                                 'e', id->evbit, 0, EV_MAX);
>       |                                      ~~^~~~~~~

Re-building, I see these as warnings.  I don't have -Werror, so they
were non-fatal, and I missed when in the scroll of the full kernel
build.

Sorry about this.  I'm preparing new patches.

Regards,
Jason

