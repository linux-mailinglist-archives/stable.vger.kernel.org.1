Return-Path: <stable+bounces-96321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508E9E1F37
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B165166A2E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B731F7090;
	Tue,  3 Dec 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctKQ7l3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C81F7083
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236283; cv=none; b=Pve/H4Uq36IeMYtV6uODn6cUmmiqHsXoOnUaipRTOIXfTh8RZ61id9m07ELK7IL+23kZbLHoPwx3xM1roZl74FO8QHsWuwGRF/OIG4GZz5gZgjbI3TcxIk20Ap+uGc6UGtDssoLuotpA1HQ+9r8UUNUFZJ6/Hq426VS+5O+icSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236283; c=relaxed/simple;
	bh=92u3oBcVJJIH1d6DltY240OoxYDKQCBRbIzPmhCLbT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AltiHvuJCpyYQbQrvd2YygjzhZIgGYwmeqFtiZK1h9gb/IW+IJUHr2kdhkG0MBfYi+Elrxz5R7BO9BrlSJHcXyCSNw9r3AdbfiCrGGAbNr7+e2VBshYSGY4XUZfR6BtQ4YH4Hl0CJD4ANzCwa2frJ80vFZ59PeF6+INZfwWqnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ctKQ7l3z; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso49723471fa.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733236279; x=1733841079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTc7M5qwqS7Z5HDO2R7CVasYNVaH3c4KyYE6I8nyddI=;
        b=ctKQ7l3zQglQsnxU8lZZG2TeKWBKchRw6SrOmOBpSR1rym97j5Cs6ck6Qn3hKNvMuQ
         KqC0ikPDgcGh5iirIFO4QAHLX9MZfMrvZP7LkEgaG3WR7FNmI3unf2SkIp6MNC9Hjt4M
         NHb/Qe7EbuhR10/eGc6ToSyw7zl+VLAFFrpu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236279; x=1733841079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTc7M5qwqS7Z5HDO2R7CVasYNVaH3c4KyYE6I8nyddI=;
        b=N4RHGsZZdzg6zL4a50qgnVLY6t1WWCmudQaJj5KADnINaUqvvQT7uhtwBxXnQNZlHh
         Tp7cqxEjK+loCSu4TSoLKPi1p15Cwp7NnvfwzobGi2zWIHBJRuZtIHo10Ew/tgBvTxKA
         WR816rt8YBAALOV6Ly2ApMlEjADWBaz1PJUvkmhN7sv1n4pR/FcOVwqiQIbXUcNp4iwk
         QmxPS+kpVItUWYueMwFq3OIhSX7Oj5hhTZ/PEKKgja2+uhQvqwAJVVeSbcZPPJjbZ/V0
         hS36E+slWs2vlmFY5NU3Bzpc3abZpv61tRQ3u1Axbv9W8OwLtmUPo54lT/ymBq8NBGR3
         iYJw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8+ZX+70H7OQQPoVzI9+Ftl5LKQy0t48ZmAnMfQ5u9saNTHwo8FiOIjXylVG6oWrD8m8kBhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjjnch3ZpoV5HRzxelMm2O5mhygknqELtHsymj2bZOAWLdgcoG
	j21gj+FceREAghdEUvhxoGOvYAv1XHxpJvo2kzxcTJgcmLa7EiteWPYEkZZiBWHobHb4N1q5zK3
	6Mdcd7sVVgG0PUHh0/NejnFDO7jmphuUImAQ=
X-Gm-Gg: ASbGncuhbxTAxWee/1VH2KVXOK6DZCfOCHzRQRF70EUO/XEE2G8YvaXWki2DX5SvbWV
	tfqEDbqc1KhtU4KlXdztqD/7wtAKYdIMvzXEFyBwhQVz0DqFokD9lfuMP5Vw=
X-Google-Smtp-Source: AGHT+IFT94+wMVDgU3RbD5ac34xxjK9TQzJUsTsMaBROTA12s8BR3wUQUXgyZ2YH48tXgwlsXfmy5rITfNqytaXKr94=
X-Received: by 2002:a2e:be84:0:b0:2ff:db26:2664 with SMTP id
 38308e7fff4ca-3000a25fb79mr9099581fa.6.1733236279312; Tue, 03 Dec 2024
 06:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203102318.3386345-1-ukaszb@chromium.org> <Z07-NoXOTO0yJNKk@kuha.fi.intel.com>
 <Z07-yh4HhLKKLJNQ@kuha.fi.intel.com>
In-Reply-To: <Z07-yh4HhLKKLJNQ@kuha.fi.intel.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 3 Dec 2024 15:31:07 +0100
Message-ID: <CALwA+NZBY3PyFPf_X42=omhS-Q379+gt352pELXjqfA5xDzaaA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix completion notifications
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:51=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Dec 03, 2024 at 02:48:59PM +0200, Heikki Krogerus wrote:
> > On Tue, Dec 03, 2024 at 10:23:18AM +0000, =C5=81ukasz Bartosik wrote:
> > > OPM                         PPM                         LPM
> > >  |        1.send cmd         |                           |
> > >  |-------------------------->|                           |
> > >  |                           |--                         |
> > >  |                           |  | 2.set busy bit in CCI  |
> > >  |                           |<-                         |
> > >  |      3.notify the OPM     |                           |
> > >  |<--------------------------|                           |
> > >  |                           | 4.send cmd to be executed |
> > >  |                           |-------------------------->|
> > >  |                           |                           |
> > >  |                           |      5.cmd completed      |
> > >  |                           |<--------------------------|
> > >  |                           |                           |
> > >  |                           |--                         |
> > >  |                           |  | 6.set cmd completed    |
> > >  |                           |<-       bit in CCI        |
> > >  |                           |                           |
> > >  |     7.notify the OPM      |                           |
> > >  |<--------------------------|                           |
> > >  |                           |                           |
> > >  |   8.handle notification   |                           |
> > >  |   from point 3, read CCI  |                           |
> > >  |<--------------------------|                           |
> > >  |                           |                           |
> > >
> > > When the PPM receives command from the OPM (p.1) it sets the busy bit
> > > in the CCI (p.2), sends notification to the OPM (p.3) and forwards th=
e
> > > command to be executed by the LPM (p.4). When the PPM receives comman=
d
> > > completion from the LPM (p.5) it sets command completion bit in the C=
CI
> > > (p.6) and sends notification to the OPM (p.7). If command execution b=
y
> > > the LPM is fast enough then when the OPM starts handling the notifica=
tion
> > > from p.3 in p.8 and reads the CCI value it will see command completio=
n bit
> > > set and will call complete(). Then complete() might be called again w=
hen
> > > the OPM handles notification from p.7.
> > >
> > > This fix replaces test_bit() with test_and_clear_bit()
> > > in ucsi_notify_common() in order to call complete() only
> > > once per request.
> > >
> > > This fix also reinitializes completion variable in
> > > ucsi_sync_control_common() before a command is sent.
> > >
> > > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for comma=
nd handling")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Sorry about that typo.
>
> --
> heikki

Heikki, Dmitry,

Thank you for the review.

Regards,
=C5=81ukasz

