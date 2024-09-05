Return-Path: <stable+bounces-73654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D796E1A9
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A371C23BD1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096017ADE7;
	Thu,  5 Sep 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGh/lhFn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0E17C9B;
	Thu,  5 Sep 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560033; cv=none; b=Jb2BMb9fYtmyHXJfffd61og6j7quNdnHJPCZiW4Ipn1/reGUwRUpc4bqLBhiC0X0vpPfPKcnKStBbfvWWT8fW1dh5Ru5oI+gOL4YE46iJMVYHyYPXz/fiCLR57BObYC+wq1mccmqvHIWQP3DynDf8vrbbZJcxSVDng724izFyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560033; c=relaxed/simple;
	bh=E2nZ7PgOCaHXSnkwTZu2+wT36ogjLDD4uMjRvOOZdtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tui+0aJu4q/fib+zU6KHoIIOVBQtHSaJ+DaZTMxJ8hBz96G5b2FHk2tHzJGHp5v6MhQ2MIFbDPKRq83LMZY/TCPTcu2ivklInOi1kL3IvNE4pg3F9owiYB63gJGUZhWNoge+U7Mn71a61rW2HD5uPdnK08s6ylcOf6hFV86MVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGh/lhFn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53343bf5eddso1278394e87.1;
        Thu, 05 Sep 2024 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725560030; x=1726164830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOxTx1YOhFIVvo5OaOZE8xZTSOCkuZa2p87/yleKeDk=;
        b=gGh/lhFnrrz86SHC+XHvlfrHKAsEIAhc8w4/XbhY219/U3fjRT3GwWWyJerfdWKB3X
         /MtwxUaesi58m8MN7E7dM6dCNiWRseP+di1BMvW665cMVzW1/usQt3U63OEuNRmvzc/g
         +2/38b1cZEJ3Sd0j+guljBu79S2YQu3Zx53mRLSUOSNMYgHLx7Pp8qr6RfUwT0pWLALR
         2sghL/FVZhAGOeCjFHwKg1tvv6VI1n/NcE/JQ/e6BsjsE/eEsvsgoftEhy9vUAsL/4AR
         soRzNtYzfjaBE97QIe6tnhrtYSvyD0IQ30y8kfKOIag/Q5xj89Md12XXWfR//7GGN0f2
         E0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560030; x=1726164830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOxTx1YOhFIVvo5OaOZE8xZTSOCkuZa2p87/yleKeDk=;
        b=jrs88ZwZRnAvhTLLf7PdfUchjzr27NZUxT3F3mds8x7D0N/lY611Nwk0hQ3y+F2mPC
         sO5jYu4Rru7F+ssyGKuMGOt87j4SnB362PFOoJvLfHkNpaPXzOjkNPXMFm8pZ3kq5VGL
         lvLgOHdkiiK++OHGRyqXxf6rYgQaCZbY16nG7syduICW66bxyFFvUwNkw/trcHiNS8qc
         jcHTX9lmVN81x3MnQzGmK2NcE0YZ8op9DLffdGI5wojArWIhF65PRmdhTwlE2UKweZOE
         8UM8vMJW7IYAunkVEyT31vtZCC1bJ6hjn++A1iDAInRRCi6cilM585s/mGEGf3r1M6Tz
         pXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUOTU6Lu5VXBPwa6ZGi6CWXh3Ei6+46zrNKtZvuD2GU/Fedkngh9SqndwQg9oCltI9bGf8raqwa@vger.kernel.org, AJvYcCXCMII6RzdXlIofcZQeSzCx+mUGaQ+IyRm7jYsG7vYi8j4UFBAcBbIdc72UKULb/wWJO3c/qNdhKvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqvMbN/S/DgGvncLpYa5C9i4siIlVYulWCanUuxwebLTThbwK
	awZTWOHVDccrDNcv/8a0TMe/Z8aelADxC/Zpg4rDUGf/ggAzJK1Uit9nA1xOv9aUGTGDQhNrCbY
	ud8TKhaxrrdwvhBC+9KUrzDeY7M8=
X-Google-Smtp-Source: AGHT+IEPgSZ7QHRwGliobYurGtb4otSt8hlc9e4wadbkAPSQkyxy7XZVdqfHUupfDLBN3UmUa4lT19fFK3v7hfkfWRk=
X-Received: by 2002:a05:6512:1310:b0:52c:d9a3:58af with SMTP id
 2adb3069b0e04-53546bc34a6mr15496963e87.49.1725560030081; Thu, 05 Sep 2024
 11:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904201839.2901330-1-bvanassche@acm.org> <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org> <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
 <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org>
In-Reply-To: <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Sep 2024 21:13:13 +0300
Message-ID: <CAHp75VeA6N_jmkz0-asjogYx4ig8Q=zxnNM7C4m5FV94pH-nCg@mail.gmail.com>
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking complaint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Amit Sunil Dhamne <amitsd@google.com>, Badhri Jagan Sridharan <badhri@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
> On 9/4/24 3:34 PM, Amit Sunil Dhamne wrote:
> > However, I have seen almost 30+ instances of the prior
> > method
> > (https://lore.kernel.org/all/20240822223717.253433-1-amitsd@google.com/=
)
> > of registering lockdep key, which is what I followed.
>
> Many of these examples are for spinlocks. It would be good to have a
> variant of spin_lock_init() that does not instantiate a struct
> lock_class_key and instead accepts a lock_class_key pointer as argument.
>
> > However, if that's is not the right way, it brings into question the
> > purpose
> > of lockdep_set_class() considering I would always and unconditionally u=
se
> > __mutex_init()  if I want to manage the lockdep class keys myself or
> > mutex_init() if I didn't.
> What I'm proposing is not a new pattern. There are multiple examples
> in the kernel tree of lockdep_register_key() calls followed by a
> __mutex_init() call:
>
> $ git grep -wB3 __mutex_init | grep lockdep_register_key | wc -l
> 5

I see pros and cons for both approaches, but I take Bart's as the simpler o=
ne.
However, since it might be confusing, what I would suggest is to add a
respective wrapper to mutex.h and have a non-__ named macro for this
case.

--=20
With Best Regards,
Andy Shevchenko

