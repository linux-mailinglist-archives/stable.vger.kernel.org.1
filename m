Return-Path: <stable+bounces-188997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08DBFC48C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A595E1A053D3
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334C34887E;
	Wed, 22 Oct 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHaW3NDe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58C348447
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140895; cv=none; b=N9QEUmnPZtizhRUPqzKOiVtDLcCuNWcP+S/rUC8DHTnWfDpkLXlgWAihPSX9jjsLeoX0U7v6FLqjOOmBgwsSOJHP87UBGM6tm7DFsKzWXtjeZBGAUsqOmazqSEvcQKKgFnkbZRqXMuQ1Cz81EyTGuxF5vprC+hkxLy7O3oeRYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140895; c=relaxed/simple;
	bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiV6OBoocJ/ks5d8zp7fy0dJ11JKAJDrfyzXZeH9S8GqPSuFbXyk6le3XwULqube8w/geNyxbMNIiRaqSOLxG1G//Q3DtZwk5L2fNTsTChIRvpxbhXDIB3vVajwRx8QdzD2YUlwZzk6YEdXNpq7Iowu4YzeEJB3ZWtQPYOxXvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHaW3NDe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so9869461a12.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140892; x=1761745692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
        b=DHaW3NDev1RDSphTbDxQD251qxiDChfS61xdvO0IDpC1JxWRGuCTmbqFPp7bRlTEbH
         J0c92Q/jB1nKojacP1C/x0eyPH1ZyQaBKZUJmEJ9a7MEo2s5RWJVhw77mkAKrh5liwtV
         PJJ+pGcGVv5y1LXkUjTPCOl1fl3FWrdghLdrW80WSGYvUqaP6kcYoevWjNXw9dtraHER
         Z+Dmp5l+6/7jaS4xCLH9WfHPJgOQiyoIqPrzCeO5s0Ve3TBooRJBIVHS3y5kybHdA+7A
         8L4DWh25aYfB0aoQv5HR25kGnZFsw7uPlHHj9KRRtqfVEK1E10Xh7CcZRsZYKxQ9Tcbv
         tdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140892; x=1761745692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
        b=RL9Gh6Gv/0GDcPFYrYD7I1KTtorK6K6sdzL+UuPb4yiCJAM2D92W0XVLa3n2OFyH/I
         p0r15+W544bxKjKoP7nfN3OM2wKSo8akbSf8NW9j/LYrmlz+eOde9Tocz9UfcKjoA2NG
         jRU5mzyX59HAOc5JxOsSSOYJL14pFUWX3w1F7ALMlLi/rxTvD8afHtStWou+O92X5Bh+
         tTcXujig3QHK0Fk9sG4GmwYoxLQKwf7fQMVNYOCGn2ZuhiT3fyx3RYC2kvBJBiOBBhle
         2AzA/4ZB8Ocghx+B+kfXNuvPpIh+bjoLfyJnzHv9jkLfd/dIqIX2ERMVJx6ZZxlXmsih
         DZKA==
X-Forwarded-Encrypted: i=1; AJvYcCUPQKsbs5nl00YdzXTGt8pE2h7K5yT54FUaE+a0DPphgWzQILRb+OSDbi4Yoqn1MKlpXOGa8wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHzYwOY07ifsB+MnM6SKxYb6UCukkDTZ1MxmXPM/RBQtTkyQH
	Ju0V4IrI9+UOm4ztpP6B+YT9Vw+Ena8KKjAu1+/3O+VSQml3JiWnx7NfZCRpTg/m5+fW09/OXvN
	egQG2iHpYvNfXN9qKoJ8bhUf0qu8xBOmRHOTHkZA=
X-Gm-Gg: ASbGncu6250fNjscMtzfc1sY5JFU8i2eXB/SHotCdat+b+D8MKhbUhvSiuthqI5pylv
	45+h+Wk+eN1aVPa4X+7RtlWR7JQEK3j5Ezsb1WsGSZhXeoim0rVuFUKBZGh26akEuNgxAyPtbyk
	32upJZvGwqgxzjqgDcoTxH1gw18qpEWfeJYi0I0qlpuvgwXnJoL1FoG6WA4aPZhF73zqYBewUKu
	9581i7wpmzMsdrJFW2wEQAEY2+Lc7/hii0PrNzkVAl4ay4dp4AL7E4nBa82hgsyfGPURxlG
X-Google-Smtp-Source: AGHT+IEuV7ok09UjY4sSyg8xFKgHnnOuV/JfYn1sZVkbPUVR5FFRF22mq8r+kNUqlJQt2/5X3tjoeoegXNFBatkKhxo=
X-Received: by 2002:a17:907:72d3:b0:b3b:4e6:46e6 with SMTP id
 a640c23a62f3a-b6472c6191dmr2347267866b.1.1761140892136; Wed, 22 Oct 2025
 06:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022133715.331241-1-hansg@kernel.org> <20251022133715.331241-2-hansg@kernel.org>
In-Reply-To: <20251022133715.331241-2-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 16:47:34 +0300
X-Gm-Features: AS18NWBj2gBYFMQcocMtRK0flD8nTDu1ZgBmGY1rHhMmb1QfH--tXoq-ijJYeDk
Message-ID: <CAHp75VcDmafp4fiOH7LqhPqtTX5BEp1w0eA5UMk13U=2_tHsyA@mail.gmail.com>
Subject: Re: [REGRESSION FIX resend 1/1] gpiolib: acpi: Make set debounce
 errors non fatal
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:37=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Commit 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
> adds a gpio_set_debounce_timeout() call to acpi_find_gpio() and makes
> acpi_find_gpio() fail if this fails.
>
> But gpio_set_debounce_timeout() failing is a somewhat normal occurrence,
> since not all debounce values are supported on all GPIO/pinctrl chips.
>
> Making this an error for example break getting the card-detect GPIO for
> the micro-sd slot found on many Bay Trail tablets, breaking support for
> the micro-sd slot on these tablets.
>
> acpi_request_own_gpiod() already treats gpio_set_debounce_timeout()
> failures as non-fatal, just warning about them.
>
> Add a acpi_gpio_set_debounce_timeout() helper which wraps
> gpio_set_debounce_timeout() and warns on failures and replace both existi=
ng
> gpio_set_debounce_timeout() calls with the helper.
>
> Since the helper only warns on failures this fixes the card-detect issue.

Acked-by: Andy Shevchenko <andy@kernel.org>
if Bart wants to take this directly.

--=20
With Best Regards,
Andy Shevchenko

