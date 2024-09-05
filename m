Return-Path: <stable+bounces-73667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9CD96E480
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 22:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA951F24237
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09C1A4F18;
	Thu,  5 Sep 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaWiUDDk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558C188017;
	Thu,  5 Sep 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569739; cv=none; b=nSrXejjHcdtMhqrYyUhVBjRmZfxIP5yCxj/MQc/NEMOtsGzZXgMq7151iBO2KZv8sgg10dEqYdvnf1nSo2BbQaVlsJ/CqKOfsP/alIHjh0R7dQYU1HHWwN4E9UeGmb93GQ5OGNrgud/8EelwSALhe1mMXGmUmiagAOdqqkhJpNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569739; c=relaxed/simple;
	bh=9xY42Sm9egtu268R11zvjhk9SOpiK8tvnVKdKJrRTRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIhqbBDDkClps8rK7MuV9yxiCCprBe52lQAtGjA3T3tYAiVlo9RDIjtlTH7yrr0oxFyj5P6HUQ7RqLuaQr6AMtEJle7gKawbkb9vUHTFE/QVVrKtnj9J6ISQ9Nn+8SzV6U9Rt0wTxgRlOUI5ZPnhanhXFczBE1Dx/38rkIJxxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaWiUDDk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83597ce5beso213668966b.1;
        Thu, 05 Sep 2024 13:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725569736; x=1726174536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xY42Sm9egtu268R11zvjhk9SOpiK8tvnVKdKJrRTRk=;
        b=VaWiUDDkB5YtkMGIhHFaMlID8jKGGAS0vtlxdeToxs7nNLj7oQahUS9+GtgPQENwuQ
         K1b9Udpn9p7ZgLXZFF/fpsLxR8u/cKy1THCMxiOekcVwNAXxVEkbREV3W/AOcYr8cPN9
         M+bi4hToSHYvw/2PGHtTpguBVA/hgyrIFHv4S1xi41/4GXDk7cTekUFXanwhanW20XOZ
         3lTy+D9ICmc7H7nfwp18zvBJvIlVL11yhClRzJWLkpHDixRHp56OXO9JIjqswwuMnWW2
         6ofN639GPFWfbeVg28ZBzakN8NoW6UhQkaZV0Ez5fswenNgUKZwLhNHMO4yAf8HAXkzi
         zFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569736; x=1726174536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xY42Sm9egtu268R11zvjhk9SOpiK8tvnVKdKJrRTRk=;
        b=HtoXRwT/DrpU+Muvl87BnjrUKthTuSNVINVRVsqFPI2QXekM9TFv5fEh8JRE8zDJLd
         fWc6VObeFNjLSeixPZl4uNXSL+50F4/FfI8QxvX10bs2Rmwu0qdI8uMD4fvfUWJ4/MXA
         Pc2VU3r4q+9xgHtRvjo0rPDeb2zciYpsieId0JlvbceIF1pKfIvB03G4wTAmakKpKd3W
         JW2n5cAi6XsuVQDRHWptC8DxxXLqURD2fZW6x5OA00ONI603Z4oV8THBTxqqqMb2KVMw
         Z+9HKycNuTlZg52kmV3Kikyi2zTAkCg+gRu3isk4oOpus+rBTYEKWwkNtHq2TGhzNHc1
         CZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKcBMKyUBH9QloW4oNtTTeeUlotGC6sY3R4LS52U0BW6JXFxwfaR3QzEC0O8NVr5xL+qtJQvCD@vger.kernel.org, AJvYcCWuSzTkO4vyrsUz/Z9lPkLe4TnqO1v8q+WEnt6sEoxH4CiWTzroKYdIUPgCjS74LNNfHFJwvhFCud0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3hCQ8OYscJuwv4YTh2vyoCGrW5XTom8dQA9d0KzZOaHx6y0Z
	oQPgna8Wav3WAO3igXrNB8yQHZ0LRUYVTaNkeeeqyMc4Zfj50d2wr2sTDrYCY0fK/cDlgaT5k1E
	Y3GYpDyT6X3ZpT2VT7rZJf9IGkM4=
X-Google-Smtp-Source: AGHT+IEMZ181d9kF6iQdLpJNxx9swWkPGjzplfeGBQ+kNatNx8NyS+C40IL5pOW5W9LiXRSkBT7TCVETk6TG/78wJhk=
X-Received: by 2002:a17:907:3e94:b0:a86:8f9b:ef6e with SMTP id
 a640c23a62f3a-a8a85faad6cmr54919966b.13.1725569735675; Thu, 05 Sep 2024
 13:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905204709.556577-1-bvanassche@acm.org> <20240905204709.556577-4-bvanassche@acm.org>
In-Reply-To: <20240905204709.556577-4-bvanassche@acm.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Sep 2024 23:54:59 +0300
Message-ID: <CAHp75Vc61fJSUJtYbMKhWE4tCv-qHRTyFT_PrK0x6Y7zB3dYNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb: roles: Fix a false positive recursive locking complaint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Amit Sunil Dhamne <amitsd@google.com>, 
	Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Suppress the following lockdep complaint by giving each sw->lock
> a unique lockdep key instead of using the same lockdep key for all
> sw->lock instances:
>
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.


> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Cc: stable@vger.kernel.org

If you put these Cc:s after --- line it will reduce the commit message
while having the same effect (assuming use of `git send-email`).
lore.kernel.org archive will keep it.

> Fixes: fde0aa6c175a ("usb: common: Small class for USB role switches")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Co-developed-by ?

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>


--=20
With Best Regards,
Andy Shevchenko

